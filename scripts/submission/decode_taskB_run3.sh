#!/bin/bash
# Submits our LLM (via LangChain) based approach for task B

TEST_FP="$1"  # Provided to the script by the submission system

# Notes:
# - You must provide an OPENAI_API_KEY for this to work
OPENAI_API_KEY="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" \
python3 ./scripts/run_langchain.py "./data/MEDIQA-Chat-Training-ValidationSets-Feb-10-2023/TaskB/TaskB-TrainingSet.csv" \
    "$TEST_FP" \
    "./outputs" \
    --temperature 0.0 \
    --task "B" \
    --run "3"

# Postprocess the output file to clean up section headers
python3 ./scripts/postprocess_taskB.py "./outputs/taskB_wanglab_run3.csv"

# Validate submission
python3 ./scripts/submission_checker.py "./outputs/taskB_wanglab_run3.csv"