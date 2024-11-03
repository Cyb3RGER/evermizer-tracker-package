import mmap
import time
from tqdm import tqdm
from multiprocessing import Pool

from zopfli.png import optimize
import os


def main():
    start = time.time()
    foundFiles = []
    allBytes = 0
    allNewBytes = 0
    for root, dirs, files in os.walk('../images'):
        print(root, dirs, files)
        for file in files:
            filename, extension = os.path.splitext(file)
            if extension.lower() == '.png':
                path = os.path.abspath(os.path.join(root, file))
                foundFiles.append(path)
                print(f'found file: {path}')
    print(f'found {len(foundFiles)} files')
    foundFiles.sort(key=lambda x: os.path.getsize(x), reverse=True)
    print('files sorted')
    with Pool() as p:
        for res in tqdm(p.imap_unordered(optimize_file, foundFiles, chunksize=1), total=len(foundFiles), unit="files"):
            allBytes += res[0]
            allNewBytes += res[1]            
    end = time.time()
    format_saved(allBytes, allNewBytes, end - start)


def optimize_file(path):
    start = time.time()
    with open(path, 'rb') as f:        
        bytes = f.read()
        newBytes = optimize(bytes)
    if len(newBytes) < len(bytes):
        with open(path, 'wb') as f:
            f.seek(0)
            f.write(newBytes)
            f.flush()
    end = time.time()
    # format_saved(len(bytes), len(newBytes), end - start, os.path.basename(path))
    return len(bytes), len(newBytes)


def format_saved(bytes, newBytes, time, filename="overall"):
    saved = bytes - newBytes
    percent = (saved / bytes) * 100
    print(
        f'{filename}: {format_bytes(bytes)}->{format_bytes(newBytes)}, saved {format_bytes(saved)} ({percent:.2f}%), took {time:.3f}s')


def format_bytes(bytes):
    labels = {0: '', 1: 'k', 2: 'M', 3: 'G', 4: 'T', 5: 'P', 6: 'E'}
    n = 0
    while bytes > 1024:
        bytes = bytes / 1024
        n += 1
    return f'{bytes:.1f}{labels[n]}B'


if __name__ == '__main__':
    main()
