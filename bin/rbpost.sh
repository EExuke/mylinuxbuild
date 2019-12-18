############################################################################# ##
# Copyright (C) 2010-2011 Cameo Communications, Inc.
############################################################################ ##
#
# -------------------------------------------------------------------------- --
#     AUTHOR                   : Zhendong Cao
#     FILE NAME                : rbpost.sh
#     FILE DESCRIPTION         : Perfect script for ME based on rbtpost script
#     FIRST CREATION DATE      : 2018/12/17
# --------------------------------------------------------------------------
#     Version                  : 1.0
#     Last Change              : 2018/12/20
## ************************************************************************** ##
#!/bin/sh
username=xuke
password=xuke
#-----------------------------------------------------------
#                COLOUR VARIABLES
#-----------------------------------------------------------
UNDL="\033[4m"    F6_E="\033[0m"    B_WT="\033[47m"
F_BL="\033[30m"   F_RD="\033[31m"   F_GR="\033[32m"
F_YL="\033[33m"   F_BU="\033[34m"   F_PU="\033[35m"
F_DG="\033[36m"   F_WT="\033[37m"   B_BL="\033[40m"
B_RE="\033[41m"   B_GR="\033[42m"   B_YL="\033[43m"
B_BU="\033[44m"   B_PR="\033[45m"   B_DG="\033[46m"

#-----------------------------------------------------------
#                RBTools PROCESS
#-----------------------------------------------------------
function print_para()
{
    echo -e "${F_GR}================================================================================${F6_E}"
    echo -e "${F_GR} ------------------------------------------------------------------------------${F6_E}"
    echo -e "${F_GR} summary : ${F6_E}${F_WT}$summary${F6_E}"
    echo -e "${F_GR} bugs    : ${F6_E}${F_WT}$bugs_closed${F6_E}"
    echo -e "${F_GR} branch  : ${F6_E}${F_WT}$branch${F6_E}"
    echo -e "${F_GR} groups  : ${F6_E}${F_WT}$reviewer${F6_E}"
    echo -e "${F_GR} ------------------------------------------------------------------------------${F6_E}"
    echo -e "${F_GR}================================================================================${F6_E}\n"
}

function help_info()
{
    echo -e "rbpost [--groups=value]           : names of the groups who will perform the review
       [--diff-filename=value]    : upload an existing diff file, instead of generating a new diff
       [--reviewid=value]         : existing review request ID to update
       [--bugs=value]             : list of bugs closed
       [--description-file=value] : text file containing a description (and a testing-done) of the review
       [--replace=value]          : true/false to choose update info from changelist yes/no"
}

function get_opts()
{
    for i in $*
    do
        param_name=`echo $i | awk -F "=" '{printf $1}'`
        param_value=`echo $i | awk -F "=" '{printf $2}'`

        case ${param_name} in
            --groups)
                reviewer=$param_value
                ;;
            --diff-filename)
                diff_filename=$param_value
                ;;
            --reviewid)
                rb_id=$param_value
                ;;
            --bugs)
                bugs_closed=$param_value
                ;;
            --description-file)
                postfile=$param_value
                ;;
            --replace)
                replace=$param_value
                ;;
            *)
                help_info
                return 1
                ;;
        esac
    done

    return 0
}

function fflush_values()
{
    reviewer="sw3"         rb_id=""      bugs_closed=""
    diff_filename="postdiff"  summary=""    branch=""
    postfile="${HOME}/bin/postfile"
    description_file="${HOME}/bin/description_file"
    testdone_file="${HOME}/bin/testdone_file"
    replace=false
}

function read_summary()
{
    if [ -f $1 ]; then
        paramter=`cat $1 |  sed -n '1p'`

        modolebr=`sed -n '3p' $1 | cut -d ']' -f 1 | cut -d '[' -f2 | tr '[A-Z]' '[a-z]'`
        #summary="[dlink_me][${modolebr}]${paramter##*Subject: }"
        summary="[${modolebr}] ${paramter}"
    fi
}

function read_description()
{
    fileline=`awk '{print NR}' ${postfile}|tail -n1`
    splitline=`grep -n "Tested on" ${postfile} | cut -d ":" -f 1`

    if [ ${splitline} != "" ]; then
        sed -n "1,$((${splitline}-2)) p" ${postfile} > ${description_file}
        sed -n "${splitline},${fileline} p" ${postfile} > ${testdone_file}
    else
        description_file=${postfile}
    fi
}

function read_bugs()
{
    if [ -f $1 ]; then
        bugs_closed=`cat $1 |  sed -n '3p' | cut -d ']' -f6 | awk -F "M#" '{print $2}'`
    fi
}

function rbpost()
{
    local exitflag=0

    fflush_values

    if [ $# != 0 ]; then
        get_opts $* || return 0
    fi

    git pull || return 1

    branch=`git branch | grep \* | awk '{print $NF}'`

    if [ "${summary}" = "" ] && [ "${postfile}" != "" ]; then
        read_summary ${postfile};
        read_description;
    fi

    if [ "${bugs_closed}" = "" ] && [ "${postfile}" != "" ]; then
        read_bugs ${postfile};
    fi

    post-review --parent=${branch} -n > postdiff && editor postdiff || exitflag=1

    if [ $exitflag = 1 ];then
        cat postdiff; rm -rf postdiff; return 1
    fi

    print_para

    if [ "${rb_id}" =  "" ]; then
        echo -ne "${F_YL}Do you want to post it to review board? (yes/no):${F6_E}"
    else
        echo -ne "${F_YL}Do you want to update it to ${F_RD}R#${rb_id}${F_YL} ? (yes/no):${F6_E}"
    fi

    read CHOICE

    case ${CHOICE} in
        yes|y)
            if [ "${rb_id}" = "" ]; then
                post-review                                      \
                    --diff-filename="${diff_filename}"           \
                    --target-groups="${reviewer}"                \
                    --summary="${summary}"                       \
                    --bugs-closed="${bugs_closed}"               \
                    --branch="${branch}"                         \
                    --description-file="${description_file}"     \
                    --testing-done-file="${testdone_file}"       \
                    --username=${username}                       \
                    --password=${password}
            else
                if [ $replace = true ]; then
                    post-review                                  \
                        -r ${rb_id}                              \
                        --diff-filename="${diff_filename}"       \
                        --target-groups="${reviewer}"            \
                        --summary="${summary}"                   \
                        --bugs-closed="${bugs_closed}"           \
                        --branch="${branch}"                     \
                        --description-file="${description_file}" \
                        --testing-done-file="${testdone_file}"   \
                        --username=${username}                   \
                        --password=${password}
                else
                    post-review                                  \
                         -r ${rb_id}                             \
                         --diff-filename="${diff_filename}"      \
                         --username=${username}                  \
                         --password=${password}
                fi
            fi

            rm -rf ${description_file} ${testdone_file} ;;
        *)
            echo -e "${F_RD}aborted.${F6_E}" ;;
    esac
}

_rbpost () {
    local cur prev comps
    local flags='--diff-filename= --description-file= --reviewid= --groups= --bugs= --replace= -h --help'

    _init_completion -n = || return

    case $cur in
        --diff-filename=*)
            cur=${cur#*=}
            comps=$(ls *.patch 2> /dev/null )
            comps+='postdiff'
            COMPREPLY=($(compgen -W '${comps[*]}' -- "$cur"))
            ;;

        --description-file=*)
            cur=${cur#*=}
            comps=$(ls readme_* 2> /dev/null)
            COMPREPLY=($(compgen -W '${comps[*]}' -- "$cur"))
            ;;

        --groups=*)
            cur=${cur#*=}
            COMPREPLY=($(compgen -W 'sw3 sw3_t3 sw3_all sw3_cypress' -- "$cur"))
            ;;

        --replace=*)
            cur=${cur#*=}
            COMPREPLY=($(compgen -W 'true false' -- "$cur"))
            ;;

        --*=*)
            ;;

        -*)
            COMPREPLY=($(compgen -W '${flags[*]}' -- "$cur"))
            [[ $COMPREPLY == *= ]] && compopt -o nospace
            ;;
    esac
}

complete -F _rbpost rbpost
