#!/bin/bash
gpu_info=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader)

echo "GPU name: $gpu_info"

if [[ "$gpu_info" == *"A100"* ]]; then
    echo "The GPU is an A100 GPU."
    /home/ec2-user/SageMaker/conda_env/ootd/bin/accelerate launch /home/ec2-user/SageMaker/vto/OOTDiffusion-train/run/ootd_train.py --load_height 512 \
	    --load_width 384 \
	    --dataset_list '/home/ec2-user/SageMaker/data/dataset/vto/train_pairs.txt' \
	    --dataset_dir '/home/ec2-user/SageMaker/data/dataset/vto' \
	    --dataset_mode 'train' \
	    --train_batch_size 16 \
	    --num_train_epochs 1
elif [[ "$gpu_info" == *"A10"* ]]; then
    echo "The GPU is an A10 GPU."
    /home/ubuntu/pytorch_gpu_base_ubuntu_uw2_workplace/anaconda3/envs/ootd/bin/accelerate launch /home/ubuntu/pytorch_gpu_base_ubuntu_uw2_workplace/aws-gcr-csdc-atl/aigc-vto-models/aigc-vto-models-ootd/reference/OOTDiffusion-train/run/ootd_train.py --load_height 512 \
	    --load_width 384 \
	    --dataset_list '/home/ubuntu/dataset/aigc-app-vto/zalando-hd-resized/train_pairs.txt' \
	    --dataset_dir '/home/ubuntu/dataset/aigc-app-vto/zalando-hd-resized' \
	    --dataset_mode 'train' \
	    --train_batch_size 1 \
	    --num_train_epochs 1
else
    echo "The GPU is neither A10 nor A100."
    echo "GPU name: $gpu_info"
fi
    
