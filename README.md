# mediqa-chat-tasks-acl-2023

A repository organizing our submission to the MEDIQA-Chat Tasks @ ACL-ClinicalNLP 2023

## Installation

Requires python>=3.7. First, create and activate a virtual environment, then install the requirements:

```bash
pip install -r requirements.txt
```

For setup on a cluster managed by the [Alliance](https://alliancecan.ca/en/services/advanced-research-computing), please see [`./scripts/slurm/setup_on_arc.sh`](./scripts/slurm/setup_on_arc.sh).

## Usage

### Fine-tuning a model on the challenge data

Models can be fine-tuned on the challenge data using the [`run_summarization.py`](./scripts/run_summarization.py) script, which is adapted from the HuggingFace [`run_summarization.py`](https://github.com/huggingface/transformers/blob/main/examples/pytorch/summarization/run_summarization.py) script. To see all available options, run:

```bash
python ./scripts/run_summarization.py --help
```

Arguments can be modified in the [config files](./conf/) or passed as command-line arguments. To train the model, run the following:

```bash
# Task A
python ./scripts/run_summarization.py "./conf/base.yml" "./conf/task_a.yml" output_dir="./output/task_a"

# Task B
python ./scripts/run_summarization.py "./conf/base.yml" "./conf/task_b.yml" output_dir="./output/task_b"
```

> Note: `base.yml` contains good default arguments that should be used for all experiments. `task_a.yml`/`task_b.yml` contain arguments specific to Task A/B. Arguments passed via the command line arguments will override those in the config files.

Valid arguments are anything from the HuggingFace [`TrainingArguments`](https://huggingface.co/docs/transformers/main_classes/trainer#transformers.TrainingArguments), [`Seq2SeqTrainingArguments`](https://huggingface.co/docs/transformers/main_classes/trainer#transformers.Seq2SeqTrainingArguments) or arguments specified in the script itself. At a minimum, you must provide a path to the dataset partitions with `train_file`, `validation_file` and `test_file`.

> We also provide a SLURM submission script for ARC clusters, which can be found at [`./scripts/slurm/run_summarization.sh`](./scripts/slurm/run_summarization.sh).

If you just want to perform inference (and not train) provide a path to a fine-tuned model with `model_name_or_path`, and set [`do_train=False`](https://huggingface.co/docs/transformers/main_classes/trainer#transformers.TrainingArguments.do_train) and [`do_eval=True`](https://huggingface.co/docs/transformers/main_classes/trainer#transformers.TrainingArguments.do_eval) and/or [`do_predict=True`](https://huggingface.co/docs/transformers/main_classes/trainer#transformers.TrainingArguments.do_predict).