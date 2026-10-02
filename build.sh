#!/usr/bin/env bash
set -euxo pipefail
cd "$(dirname "$0")"
CM="${CMAKE:-cmake}"
PY="${PYTHON:-python3}"
export CUDA_VISIBLE_DEVICES="${CUDA_VISIBLE_DEVICES:-0}"
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 MKL_THREADING_LAYER=SEQUENTIAL
"$PY" tests/generate_problem.py
export CUDA_HOME="${CUDA_HOME:-/usr/local/cuda}"
export CUDACXX="${CUDACXX:-$CUDA_HOME/bin/nvcc}"
"$CM" -S . -B build-coinor -DCMAKE_BUILD_TYPE=Release -DCMAKE_CUDA_ARCHITECTURES="${GPU_ARCH:-native}" -DCMAKE_INSTALL_PREFIX="$PWD/.coinor-deps/pdhcg-install" -DPDHCG_BUILD_STATIC_LIB=ON -DPDHCG_BUILD_CLI=ON -DPDHCG_BUILD_PYTHON=OFF -DPDHCG_BUILD_TESTS=OFF -DPDHCG_BUILD_SHARED_LIB=OFF -DPDHCG_COMPILE_PREFOS=OFF -DPDHCG_COMPILE_DISTRIBUTED=OFF
"$CM" --build build-coinor --target PDHCG_cli --parallel "${BUILD_JOBS:-4}"
"$CM" --install build-coinor
"$PY" tests/run.py --project PDHCG --binary "$PWD/.coinor-deps/pdhcg-install/bin/pdhcg"

"$PY" tests/check_checker.py --project PDHCG
