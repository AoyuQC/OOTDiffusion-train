#!/bin/bash
gpu_info=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader)
echo " the gpu info is: $gpu_info"
# Default variable value
variable="aoyu"

# Check if an argument is provided
if [ "$1" != "" ]; then
    variable="$1"
fi

echo "The scenario of application is: $variable"

if [ "$variable" != "" ]; then
    case "$variable" in
        "aoyu")
            a100_dataset_list='/home/ec2-user/SageMaker/data/dataset/vto/shenin/test_pairs_shein.txt' \
            a100_dataset_dir='/home/ec2-user/SageMaker/data/dataset/vto/shenin' \
            a10_dataset_list='/home/ubuntu/dataset/aigc-app-vto/shenin/test_pairs_shein_debug.txt' \
            a10_dataset_dir='/home/ubuntu/dataset/aigc-app-vto/shenin' \
            ;;
        "xiaoyu")
            a100_dataset_list='/home/ubuntu/VTO/dataset/shenin/test_pairs_shein_341.txt' \
            a100_dataset_dir='/home/ubuntu/VTO/dataset/shenin/' \
            a10_dataset_list='/home/ubuntu/VTO/dataset/shenin/test_pairs_shein_341.txt' \
            a10_dataset_dir='/home/ubuntu/VTO/dataset/shenin/' \
            ;;
        *)
            echo "Invalid option provided."
            exit 1
    esac
else
    echo "Please provide an option as a command-line argument."
    echo "Usage: $0 [opt1|opt2|opt3]"
    exit 1
fi

export USER="$variable"

if [[ "$gpu_info" == *"A100"* ]]; then
    echo "The GPU is an A100 GPU."
    /home/ec2-user/SageMaker/conda_env/ootd/bin/accelerate launch /home/ec2-user/SageMaker/vto/OOTDiffusion-train/run/ootd_train.py --load_height 512 \
	    --load_width 384 \
	    --dataset_list $a100_dataset_list \
	    --dataset_dir $a100_dataset_dir \
	    --dataset_mode 'train' \
	    --train_batch_size 16 \
	    --num_train_epochs 1
elif [[ "$gpu_info" == *"A10"* ]]; then
    echo "The GPU is an A10 GPU."
    /home/ubuntu/.local/bin/accelerate launch /home/ubuntu/VTO/OOTDiffusion-train/run/ootd_train.py --load_height 512 \
	    --load_width 384 \
	    --dataset_list $a10_dataset_list \
	    --dataset_dir $a10_dataset_dir \
	    --dataset_mode 'train' \
	    --train_batch_size 16 \
	    --num_train_epochs 10
else
    echo "The GPU is neither A10 nor A100."
    echo "GPU name: $gpu_info"
fi

# a100 backup
# shein up data
# --dataset_list '/home/ec2-user/SageMaker/data/dataset/vto/shenin/test_pairs_shein.txt' \
# --dataset_dir '/home/ec2-user/SageMaker/data/dataset/vto/shenin' \

# raw data
# --dataset_list '/home/ec2-user/SageMaker/data/dataset/vto/train_pairs.txt' \
# --dataset_dir '/home/ec2-user/SageMaker/data/dataset/vto' \

# a10 backup
# shein up data
# --dataset_list '/home/ubuntu/dataset/aigc-app-vto/shenin/test_pairs_shein.txt' \
# --dataset_dir '/home/ubuntu/dataset/aigc-app-vto/shenin' \

# raw data
# --dataset_list '/home/ubuntu/dataset/aigc-app-vto/zalando-hd-resized/train_pairs.txt' \
# --dataset_dir '/home/ubuntu/dataset/aigc-app-vto/zalando-hd-resized' \
    
