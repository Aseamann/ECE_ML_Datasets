#!/bin/bash

folder_with_pdbs=$1

output_dir=$2
if [ ! -d $output_dir ]
then
    mkdir -p $output_dir
fi

mpnn_path="/home/austin/GitHub/ProteinMPNN"

path_for_parsed_chains=$output_dir"/parsed_pdbs.jsonl"
chains_to_design="A"

#path_for_model_weights=$mpnn_path"/soluble_model_weights"
#path_for_model_weights=$mpnn_path"/vanilla_model_weights"
path_for_model_weights=$mpnn_path"/hyper_model_weights"
#model_i="v_48_020"
model_i="v48_020_epoch300_hyper"

python $mpnn_path/helper_scripts/parse_multiple_chains.py --input_path=$folder_with_pdbs --output_path=$path_for_parsed_chains

python $mpnn_path/protein_mpnn_run.py \
        --jsonl_path $path_for_parsed_chains \
	--path_to_model_weights $path_for_model_weights \
        --model_name $model_i \
	--out_folder $output_dir \
        --num_seq_per_target 48 \
        --sampling_temp "0.1 0.2 0.3" \
        --batch_size 1
