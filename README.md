# Fine-tuning OpenAI Models

This guide outlines the steps required to fine-tune OpenAI models using the OpenAI package, CLI, and API.

## Prerequisites

1. Ensure the **openai** package is installed and up to date: `pip install --upgrade openai`
2. Set the **OPENAI_API_KEY** environment variable to your API key: `export OPENAI_API_KEY="<OPENAI_API_KEY>"`

## Fine-tuning Steps

1. Generate enough data to train a model. This is currently done manually with ChatGPT with the following prompt.

```
Based on the following text, create prompt-completion pairs for fine-tuning an LLM in the following format:

{"prompt": "<prompt text>", "completion": "<ideal generated text>"}
{"prompt": "<prompt text>", "completion": "<ideal generated text>"}
{"prompt": "<prompt text>", "completion": "<ideal generated text>"}

...more prompts
```

2. Run openai tools to prepare the data for fine-tuning.

```openai tools fine_tunes.prepare_data -f <LOCAL_FILE>```

3. Run openai tools to fine-tune the model.

```openai api fine_tunes.create -t <TRAIN_FILE_ID_OR_PATH> -m <BASE_MODEL>```

4. When the job is done, it should display the name of the fine-tuned model.

## Usage

You can use this fine-tuned model name to generate completions using the following methods:

- OpenAI CLI:

```
openai api completions.create -m <FINE_TUNED_MODEL> -p <YOUR_PROMPT>
```

- cURL:

```
curl https://api.openai.com/v1/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"prompt": YOUR_PROMPT, "model": FINE_TUNED_MODEL}'
```

- Python:

```
openai.Completion.create(
    model=FINE_TUNED_MODEL,
    prompt=YOUR_PROMPT)
```

## Details

To see the list of fine-tunes, their status, and other information, run the following commands.

1. **List all fine-tunes:** `openai api fine_tunes.list`
2. **Retrieve the state of a fine-tune:** `openai api fine_tunes.get -i <YOUR_FINE_TUNE_JOB_ID>`
3. **Cancel a fine-tuning job:** `openai api fine_tunes.cancel -i <YOUR_FINE_TUNE_JOB_ID>`
