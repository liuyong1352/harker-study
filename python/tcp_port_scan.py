#! /usr/bin/env python3
import socket
import threading

OPEN_COUNT = 0
lock = threading.Lock()
threads = []

def testPort(host, port):
    global OPEN_COUNT
    s = socket.socket()
    try:
        s.connect((host, port))
        print('[+] {} open'.format(port))
        lock.acquire()
        OPEN_COUNT += 1
        lock.release()
    except: pass
    finally: s.close()

def scanPorts(host, ports, max_thread_num=10):
    socket.setdefaulttimeout(1)
    
    for p in range(ports[0], ports[1]+1):
        t = threading.Thread(target=testPort, args=(host, p))
        try:
            t.start()
            threads.append(t)
        except RuntimeError:
            pass
        if len(threads) % max_thread_num == 0:
            for t in threads:
                t.join()
            threads.clear()

    for t in threads:
        t.join()
    print('Total is {}'.format(OPEN_COUNT))

if __name__ == '__main__':
    import sys
    if len(sys.argv) == 4:
        scanPorts(sys.argv[1], (int(sys.argv[2]), int(sys.argv[3])))
    elif len(sys.argv) == 5:
        scanPorts(sys.argv[1], (int(sys.argv[2]), int(sys.argv[3])), int(sys.argv[4]))
