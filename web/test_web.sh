#!/usr/bin/env bash
set -e
curl -s http://192.168.57.7 | grep -q "Servidor web de pserrod869.test" && echo "OK: Servidor web funcionando correctamente"