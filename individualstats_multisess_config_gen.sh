#!/bin/bash

Usage() {
    echo "Usage: script.sh <project_foldername> <subjectlist_name> <runlist_name> <task_name> <pipeline>"
    echo ""
    echo "<project_foldername> name of project parent folder "
    echo ""
    echo "<subjectlist> name of subjectlist textfile"
    echo ""
    echo "<runlist> name of runlist"
    echo ""
    echo "<task> full path to location of desired converted fileoutput"
    echo ""
    echo "<pipeline> pipeline name"
    exit 1;
}

if [ $# -lt 5 ]; then
    Usage
fi

project_foldername=$1
subjectlist=$2
runlist=$3
task=$4
pipeline=$5

config_name="`echo ${task}`_individualstats_multisess_config_`echo ${pipeline}`.m";
projects_user_path="/oak/stanford/groups/${GROUP}/projects/${LOGNAME}"
config_pathoutput="${projects_user_path}/`echo ${project_foldername}`/scripts/config_scripts/`echo ${config_name}`";
echo "paralist.parallel = '1';" >> ${config_pathoutput}

# fMRI parameters
echo "paralist.batchtemplatepath = '/oak/stanford/groups/${GROUP}/scsnlscripts/brainImaging/mri/fmri/preprocessing/spm12/preprocessfmrimodules/batchtemplates/';" >> ${config_pathoutput}
echo "paralist.spmversion = 'spm12';" >> ${config_pathoutput}
echo "paralist.subjectlist = '/oak/stanford/groups/${GROUP}/projects/${LOGNAME}/${project_foldername}/data/subjectlist/${subjectlist}';" >> ${config_pathoutput}
echo "paralist.runlist = '/oak/stanford/groups/${GROUP}/projects/${LOGNAME}/${project_foldername}/data/subjectlist/${runlist}';" >> ${config_pathoutput}


echo "paralist.data_type = 'nii';" >> ${config_pathoutput}
echo "paralist.include_mvmnt = 1;" >> ${config_pathoutput}
echo "paralist.pipeline = '${pipeline}';" >> ${config_pathoutput}


# -------------------------------------------------------------------------
# I/O parameters

echo "paralist.projectdir = '/oak/stanford/groups/${GROUP}/projects/${LOGNAME}/${project_foldername}/';" >> ${config_pathoutput}
echo "paralist.preprocessed_folder    = '${pipeline}_spm12';" >> ${config_pathoutput}
echo "paralist.stats_folder = '${task}_${pipeline}';" >> ${config_pathoutput}


# task and contrast parameters
echo "paralist.task_dsgn          = 'task_design.mat';" >> ${config_pathoutput} #'taskdesign_comparisondot.m';

#-Please specify the TR otherwise the default is 2.0 s
echo "paralist.TR = 0.49;" >> ${config_pathoutput}

#-Please specify the type of serial correlations
echo "paralist.cvi = 'FAST';" >> ${config_pathoutput}
echo "%paralist.whole_brain_mask =[''];" >> ${config_pathoutput}
echo "paralist.include_volrepair = 0;" >> ${config_pathoutput}

# -------------------------------------------------------------------------
# VolRepair Preprocessing Setup
# -------------------------------------------------------------------------

# Please specify the volrepair preprocessing pipeline
echo "paralist.volpipeline = '${pipeline}';" >> ${config_pathoutput}
echo "paralist.volrepaired_folder = 'volrepair_spm12';" >> ${config_pathoutput}
echo "paralist.repaired_stats   = 'stats_spm12_VolRepair';" >> ${config_pathoutput}




