#!/bin/bash
set -e

echo "Starting JupyterHub with Java Kernel..."

echo "Listing Kernels:"
jupyter kernelspec list

exec "$@"
