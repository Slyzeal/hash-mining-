#!/usr/bin/env bash
set -e

echo "Updating packages..."
apt-get update && apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    build-essential

echo "Adding NVIDIA CUDA repository..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb

dpkg -i cuda-keyring_1.1-1_all.deb
rm cuda-keyring_1.1-1_all.deb

echo "Installing CUDA toolkit..."
apt-get update
apt-get install -y cuda-toolkit-12-4

echo "Configuring environment variables..."
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc

export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

echo "Verifying installation..."
nvcc --version || true

echo "CUDA + NVCC installation complete."
