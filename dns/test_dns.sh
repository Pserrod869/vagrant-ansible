#!/usr/bin/env bash
set -e
echo "=== Probando registros directos ==="
dig @192.168.57.5 dns.pserrod869.test +short
dig @192.168.57.5 negocio.pserrod869.test +short
dig @192.168.57.5 www.pserrod869.test +short
dig @192.168.57.5 ftp.pserrod869.test +short

echo "=== Probando registros inversos ==="
dig @192.168.57.5 -x 192.168.57.5 +short
dig @192.168.57.5 -x 192.168.57.7 +short