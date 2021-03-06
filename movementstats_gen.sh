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

 if [ $# -lt 5 ] ; then
        Usage
    fi

project_foldername=$1
subjectlist=$2
runlist=$3
task=$4
pipeline=$5

config_name="`echo ${task}`_movementstatsfmri_config_`echo ${pipeline}`.m"
projects_user_path="/oak/stanford/groups/${GROUP}/projects/${LOGNAME}";
config_pathoutput="${projects_user_path}/`echo ${project_foldername}`/scripts/config_scripts/`echo ${config_name}`";

echo "paralist.parallel = '0';" >> ${config_pathoutput}
echo "paralist.spmversion = 'spm12';" >>  ${config_pathoutput}

echo "paralist.subjectlist = '/oak/stanford/groups/${GROUP}/projects/${LOGNAME}/${project_foldername}/data/subjectlist/${subjectlist}';" >> ${config_pathoutput}
echo "paralist.spgrfilename = 'spgr';" >> ${config_pathoutput};
echo "paralist.runlist = '/oak/stanford/groups/${GROUP}/projects/${LOGNAME}/${project_foldername}/data/subjectlist/${runlist}';" >> ${config_pathoutput}

echo "paralist.rawdatadir = '/oak/stanford/groups/${GROUP}/rawdata/scsnl';" >> ${config_pathoutput}
echo "paralist.projectdir = '/oak/stanford/groups/${GROUP}/projects/${LOGNAME}/${project_foldername}/';" >> ${config_pathoutput}

echo "paralist.preprocessed_folder = '${pipeline}_spm12';" >> ${config_pathoutput}
echo "paralist.scantoscancrit = 0.5;" >> ${config_pathoutput}
