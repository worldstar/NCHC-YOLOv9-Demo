# YOLOv9 on NCHC
Because the Dept of CSIE, TKU bought the GPU resources from NCHC in 2025, to help teachers and students access this platform easily, I designed this quick-start guide, which introduces how to use the NCHC GPU instance by Slurm. This repository shows how to run YOLOv9 (PyTorch) on NCHC Nano5 using Slurm and a Singularity container. Examples of [image classification](https://github.com/worldstar/NCHC-Slurm-Demo) and [GAN](https://github.com/worldstar/NCHC-GAN-Pix2Pix-CycleGAN-demo) are also provided.

## Quick-Start Steps
### 1. Connect to the Nano5 Server by SSH
Please read the slides "How to use Nano5 of NCHC.pdf", particularly Section 2.

### 2. Download / Clone this Project on NCHC Nano5
```bash
git clone https://github.com/worldstar/NCHC-YOLOv9-Demo.git
```
### 3. Revise singularityClassification.slurm: 
Edit the Slurm script to match your project/account and container:

```bash
cd NCHC-YOLOv9-Demo
vim yolov9_train.slurm
```
In this file, please update YOUR_PROJECT_ID:

```bash
#SBATCH --account=YOUR_PROJECT_ID   # e.g. MSTXXXX or ACDXXXX

```
Save and exit:

```bash
:wq
```

### 4. Submit the Slurm Job: 
From the repository folder, submit the job:

```bash
sbatch yolov9_train.slurm
```

### 5. Check job status:
We will check that the job is assigned to a queue and is to be executed. Besides, we will read the logs during the training.

```bash
squeue -u $USER
```
View logs (after job starts):

```bash
cd NCHC-YOLOv9-Demo
ls *.out *.err
less JOBNAME-JOBID.out
```

## TWCC (Supports Tesla V100)
TWCC actually provides a very sufficient GPU resources. If you like to use older GPU on TWCC, you will login to the master node at ln01.twcc.ai by SSH. Then, the SIF could be available under the /work/TWCC_cntr, including the pytorch_23.11-py3.sif used by this example. The partition names could be the gp1d(run for one-day),gp2d(two-days), and gp4d(4-days). Once these required parameters are updated, the code could be run on TWCC.

## Useful Resources:
1. Nano5 Main Document: https://man.twcc.ai/@AI-Pilot/manual
2. Slides: https://docs.google.com/presentation/d/1WKUXZJMqch0xUEPKZCN1cBLErxKtJ9P2/mobilepresent?pli=1&slide=id.p1
3. Member Management：https://iservice.nchc.org.tw/nchc_service/nchc_service_qa_single.php?qa_code=23
4. Wallet Management：https://iservice.nchc.org.tw/nchc_service/nchc_service_qa_single.php?qa_code=20

## Credits:
1. The YOLOv9 algorithm is obtained from the following GitHub repo
https://github.com/WongKinYiu/yolov9
2. Image Dataset: Football player dataset
https://universe.roboflow.com/roboflow-jvuqo/football-players-detection-3zvbc

## Extra
If you are interested in the Taiwan Computing Cloud (TWCC) with Tesla V100 GPU with a web interface, please read the slides "How to use TWCC-YOLOv9.pdf" in the Slides folder.
