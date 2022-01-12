#!/bin/bash

#----------------------------------
# Account Information

#SBATCH --account=pi-kilianhuber

#------------------------------
# Resources requested

#SBATCH --partition=standard
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32G
#SBATCH --cores-per-socket=2
#SBATCH --time=0-10:00:00

#---------------------
# Job specific name

#SBATCH --job-name=pdftotext

#-----------------------
# useful variables

echo "Job ID: $SLURM_JOB_ID"
echo "Job User: $SLURM_JOB_USER"
echo "Num Cores: $SLURM_JOB_CPUS_PER_NODE"
printf "\n"

#------------------------
# echo inputted command-line arguments

echo "Input folder: $1"
#echo "Output folder: $2"
printf "\n"

#------------------------
# change directory to input folder

walk_dir () {    
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            case "$pathname" in
                *.pdf)
                    printf '%s\n' "$pathname"
                    pdftotext -layout "$pathname" 
            esac
        fi
    done
}

walk_dir $1
echo done!

# What to type in command line:
# sbatch convert_pdf_to_txt_walkdir.sh /project/kh_mercury_1/channels_in_macro/data/papers_pdf