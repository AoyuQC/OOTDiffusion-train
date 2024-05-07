/home/ubuntu/pytorch_gpu_base_ubuntu_uw2_workplace/anaconda3/envs/ootd/bin/accelerate launch /home/ubuntu/pytorch_gpu_base_ubuntu_uw2_workplace/aws-gcr-csdc-atl/aigc-vto-models/aigc-vto-models-ootd/reference/OOTDiffusion-train/run/ootd_train.py --load_height 51 \
	--load_width 38 \
	--dataset_list '/home/ubuntu/dataset/aigc-app-vto/zalando-hd-resized/train_pairs.txt' \
	--dataset_dir '/home/ubuntu/dataset/aigc-app-vto/zalando-hd-resized' \
	--dataset_mode 'train' \
	--batch_size 1 \
	--train_batch_size 1 \
	--num_train_epochs 200
