#!/bin/bash
#SBATCH --job-name=yolov9_train
#SBATCH --partition=normal          # <-- change to the correct GPU partition on Nano5 if needed
#SBATCH --gres=gpu:1             # number of GPUs
#SBATCH --cpus-per-task=8        # number of CPU cores
#SBATCH --mem=32G                # RAM
#SBATCH --time=24:00:00          # max walltime
#SBATCH --account=MSTXXXXX           # <-- replace with your project/account ID
#SBATCH --output=logs/yolov9_train_%j.out
#SBATCH --error=logs/yolov9_train_%j.err

# Path to your container
CONTAINER="/work/hpc_sys/sifs/pytorch_23.11-py3.sif"

# Project root (where YOLOv9 repo and your train/valid/test folders are)
PROJECT_DIR="$HOME/yolov9"

# Load container module (adjust to your system: singularity or apptainer)
module purge
module load singularity   # or: module load apptainer

# Create log directory if it doesn't exist
mkdir -p "$PROJECT_DIR/logs"

cd "$PROJECT_DIR"

# Useful for PyTorch dataloaders
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Run YOLOv9 training inside the container
singularity exec --nv \
  --bind "$HOME:$HOME" \
  "$CONTAINER" \
  bash -lc "
    cd $PROJECT_DIR

    python -m pip install --user --upgrade pip
    python -m pip install --user seaborn

    python -u train_dual.py \
      --workers 8 \
      --device 0 \
      --batch 64 \
      --epochs 100 \
      --img 640 \
      --data data.yaml \
      --cfg models/detect/yolov9-c.yaml \
      --weights '' \
      --name nano5_yolov9_run \
      --hyp hyp.scratch-high.yaml \
      --min-items 0 \
      --close-mosaic 15
  "

