#!/usr/bin/env bash

DATA_NAME=jgs

if [ ! -f ./$DATA_NAME.json.txt ]; then
    echo "File not found! Downloading..."

    ### this may take a while
    wget https://drive.google.com/file/d/1cMIHmGIkwkNDfRVlC02cD2qm8BrsKeH_/view?usp=sharing
    python3 custom_format_converter.py $DATA_NAME.json
    mkdir word_vectors
fi

if [ ! -f ./word_vectors/$DATA_NAME.json.txt.w2v ]; then
    echo "Training custom word vectors..."
    python3 word2vec.py $DATA_NAME.json.txt

fi
echo "Training ABAE..."
python3 main.py model.aspects_number=35 data.path=$DATA_NAME.json.txt model.log_progress_steps=1000