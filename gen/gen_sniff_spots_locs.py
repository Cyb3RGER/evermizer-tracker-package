import csv
import json

from PyPopTracker.packs.locations import *

SNIFF_SPOT_SIZE = 16
SNIFF_BORDER_SIZE = 2
TILE_SIZE = 16

LOGIC_FUNCTION_MAPPING = {
    "weapon": [["^$canCutBushes"]],
    "non-sword": [["^$hasNonSword"]],
    "volcano entered": [["^$volcano_entered"]],
    "east crustacia chests access": [["^$east_crustacia_chests_access"]],
    "levitate": [["levitate"]],
    "aegis": [["aegis"]],
    "oglin cave access": [["^$oglin_access"]],
    "bronze axe+": [["^$hasBronzeAxeOrHigher"]],
    "revealer": [["^$revealer"]],
    "pyramid": [["^$pyramid"]],
    "knight basher": [["^$knight_basher"]],
    "queen's key chests access": [["^$queens_key"]],
    "rocket": [["^$canCutBushes", "rocket"]]
}


class MapOffsets:
    map_id: str
    map_name: str
    map_offset_x: int
    map_offset_y: int
    map_scale_x: int = TILE_SIZE
    map_scale_y: int = TILE_SIZE
    offset_x: int
    offset_y: int
    loc_size: int = SNIFF_SPOT_SIZE

    def __init__(self, props):
        self.map_id = props['map_id']
        self.map_name = props['name']
        self.map_offset_x = int(props['map_offset_x'])
        self.map_offset_y = int(props['map_offset_y'])
        self.map_scale_x = TILE_SIZE
        if props['map_scale_x']:
            self.map_scale_x = int(props['map_scale_x'])
        self.map_scale_y = TILE_SIZE
        if props['map_scale_y']:
            self.map_scale_y = int(props['map_scale_y'])
        self.offset_x = int(props['offset_x'])
        self.offset_y = int(props['offset_y'])
        self.loc_size = SNIFF_SPOT_SIZE
        if props['loc_size']:
            self.loc_size = int(props['loc_size'])


def combine_access(current, to_add, op):
    # print('combine_access', current, to_add, op)
    new = current.copy()
    if op == "AND":
        if len(current) == 0:
            return to_add
        i = 0
        for v2 in current:
            for v in to_add:
                if i >= len(new):
                    new.append([])
                new[i] = v2 + v
                i += 1
    if op == "OR":
        for v in to_add:
            new.append(v)
    # print('combine_access', 'result', new)
    return new


def translate_logic_func(func):
    if func in LOGIC_FUNCTION_MAPPING:
        return LOGIC_FUNCTION_MAPPING[func]
    else:
        print(f'{func} has no translation!')
        return [[func]]


def get_access_rules(logic_val, override_logic):
    if override_logic is not None and override_logic != "":
        return json.loads(f'{{"a": {override_logic}}}')['a']
    if logic_val is None or logic_val == "":
        return None
    rules = [[]]
    for v in logic_val.split(','):
        rule = translate_logic_func(v.strip())
        rules = combine_access(rules, rule, 'AND')
    return rules


def get_visibility_rules(is_hidden):
    return [[f"$sniffLocationVisible|{1 if is_hidden else 0}"]]


def get_offset(offsets: dict[str, MapOffsets], row: dict):
    map = row['map']
    if row['pop_map_override']:
        map = row['pop_map_override']
    if map in offsets:
        return offsets[map]
    return None


def get_map_loc(x1, x2, y1, y2, offset: MapOffsets):
    y = y1 + (y2 - y1) / 2
    x = x1 + (x2 - x1) / 2
    return PopTrackerMapLocation(
        _map=offset.map_name,
        x=round((x - offset.map_offset_x) * offset.map_scale_x + offset.offset_x + (
                offset.loc_size + SNIFF_BORDER_SIZE - offset.map_scale_x) / 2),
        y=round((y - offset.map_offset_y) * offset.map_scale_y + offset.offset_y + (
                offset.loc_size + SNIFF_BORDER_SIZE - offset.map_scale_y) / 2),
        size=offset.loc_size,
        border_thickness=SNIFF_BORDER_SIZE
    )


def get_map_locs(offsets: dict[str, MapOffsets], row: dict):
    offset = get_offset(offsets, row)
    if offset is None:
        return []
    x1 = int(row['x1'])
    x2 = int(row['x2'])
    y1 = int(row['y1'])
    y2 = int(row['y2'])
    main_loc = get_map_loc(x1, x2, y1, y2, offset)
    locs = [main_loc]
    if row['pop_x1'] and row['pop_y1']:
        x1 = int(row['pop_x1'])
        x2 = x1 + 1
        if row['pop_x2']:
            x2 = int(row['pop_x2'])
        y1 = int(row['pop_y1'])
        y2 = y1 + 1
        if row['pop_y2']:
            y2 = int(row['pop_y2'])
        second_loc = get_map_loc(x1, x2, y1, y2, offset)
        if row['pop_pos_mode'] == 'overwrite':
            locs = [second_loc]
        else:
            locs.append(second_loc)
    return locs


class Watch:
    addr: int
    len: int

    def __init__(self, addr, len):
        self.addr = addr
        self.len = len


def translate_act(map_name):
    ACT_TRANSLATION_TABLE = {
        'Prehistoria': 'Act 1',
        'Antiqua': 'Act 2',
        'Gothica': 'Act 3',
        'Omnitopia': 'Act 4',
    }
    return ACT_TRANSLATION_TABLE[map_name.split(' - ')[0]]


def write_mapping(outf, name, mapping):
    outf.write(f'{name} = {{\n')
    for k, v in mapping.items():
        outf.write(f"    [0x{k+0x7e0000:X}] = {{\n")
        for k2, v2 in v.items():
            outf.write(f"        [0x{1<<k2:02X}] = {{ ")
            for v3 in v2:
                outf.write(f"\"{v3}\"")
            outf.write(" },\n")
        outf.write("    },\n")
    outf.write("}\n")


def write_watches(outf, watches):
    outf.write('SNIFF_SPOT_WATCHES = {\n')
    for watch in watches:
        outf.write(f'    {{ addr=0x{0x7e0000+watch.addr:x}, len=0x{watch.len:x} }},\n')
    outf.write('}\n')


def main():
    locs: list[PopTrackerLocation] = []
    offsets: dict[str, MapOffsets] = {}
    detailed_mapping: dict[int, [int, list[str]]] = {}
    overworld_mapping: dict[int, [int, list[str]]] = {}
    watches: list[Watch] = []
    addrs: list[int] = []
    with open('offsets.csv') as offsets_file:
        offsets_reader = csv.DictReader(offsets_file, lineterminator='\n')
        for row in offsets_reader:
            offsets[row['map_id']] = MapOffsets(row)

    with open('sniff_edit.csv') as f:
        csv_reader = csv.DictReader(f, lineterminator='\n')
        for row in csv_reader:
            is_hidden = 'hidden' in row['difficulty']
            offset = get_offset(offsets, row)
            if offset is None or row['pop_pos_mode'] == 'ignore':
                continue
            loc_name = f'Sniff Spot #{row["id"]}'
            loc = PopTrackerLocation(
                name=loc_name,
                access_rules=get_access_rules(row['logic'], row['pop_logic']),
                visibility_rules=get_visibility_rules(is_hidden),
                chest_opened_img='images/locations/sniff_open_gray.png',
                chest_unopened_img='images/locations/sniff.png',
                map_locations=get_map_locs(offsets, row)
            )
            sec_name = f'(Vanilla: {row["prize_text"]})'
            sec = PopTrackerSection(sec_name)            
            loc.sections.append(sec)
            locs.append(loc)
            addr = int(row['address'])
            if addr not in addrs:
                addrs.append(addr)
            if addr not in detailed_mapping:
                detailed_mapping[addr] = {}
            if int(row['bit']) not in detailed_mapping[addr]:
                detailed_mapping[addr][int(row['bit'])] = []
            detailed_mapping[addr][int(row['bit'])].append(f'@{loc_name}/{sec_name}')
            overview_name = f'@{translate_act(row["map_name"])}/{row["pop_overview_parent"]}/{"hidden " if is_hidden else ""}Sniff Spots'
            if row['pop_postfix']:
                overview_name += f' {row["pop_postfix"]}'
            if addr not in overworld_mapping:
                overworld_mapping[addr] = {}
            if int(row['bit']) not in overworld_mapping[addr]:
                overworld_mapping[addr][int(row['bit'])] = []
            overworld_mapping[addr][int(row['bit'])].append(overview_name)

    last = None
    _len = 0
    print(sorted(addrs), len(addrs))
    for addr in sorted(addrs):
        if last and addr != last + 1:
            watches.append(Watch(last + 1 - _len, _len))
            _len = 0
        _len += 1
        print(_len, f'{addr:x}')
        last = addr
    watches.append(Watch(addr + 1 - _len, _len))
    print([(f'0x{w.addr:x}-0x{w.addr+w.len:x}', f'0x{w.len:x}') for w in watches])
    print(overworld_mapping)
    print(detailed_mapping)

    with open('../var_detailed/locations/sniff_spots.json', 'w') as outf:
        json.dump(locs, outf, cls=PopTrackerJsonEncoder, indent=4)

    with open('../scripts/autotracking/locations/sniff_spots.lua', 'w') as outf:
        write_watches(outf, watches)
        write_mapping(outf, 'SNIFF_MAPPING_DETAILED', detailed_mapping)
        write_mapping(outf, 'SNIFF_MAPPING_OVERWORLD', overworld_mapping)


if __name__ == "__main__":
    main()
