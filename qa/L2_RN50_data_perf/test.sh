#!/bin/bash -e
# used pip packages
pip_packages=""

pushd ../..

cd dali/test/python

NUM_GPUS=$(nvidia-smi -L | wc -l)

test_body() {
    # test code
    python test_RN50_data_pipeline.py --gpus ${NUM_GPUS} -b 256 --workers 3 --prefetch 2
    python test_RN50_data_pipeline.py --gpus ${NUM_GPUS} -b 16 --workers 3 --prefetch 11
    # fp16 NHWC
    python test_RN50_data_pipeline.py --gpus ${NUM_GPUS} -b 256 --workers 3 --prefetch 2 --fp16 --nhwc
    python test_RN50_data_pipeline.py --gpus ${NUM_GPUS} -b 16 --workers 3 --prefetch 11 --fp16 --nhwc
}

source ../../../qa/test_template.sh

popd
