#!/bin/bash
set -e
export MPI_GLOBAL_OPTS=""

echo 
echo "***** Executing sierra *****"
echo Executing: 'launch -n 336 adagio -i bob-1mm-5kg-helmet2-0305-hemi-066b.i'
launch -n 336 adagio -i bob-1mm-5kg-helmet2-0305-hemi-066b.i
echo 
echo "***** Running postprocessing step *****"
echo Executing: 'cd $(dirname output_field.e) && launch -n 1 epu -add_processor -auto "$(basename output_field.e).336.*" >> epu.log 2>&1 && cd -'
cd $(dirname output_field.e) && launch -n 1 epu -add_processor -auto "$(basename output_field.e).336.*" >> epu.log 2>&1 && cd -
echo 
rm -f /home/chovey/autotwin/ssm/input/sierra_batch_script_44266.sh
