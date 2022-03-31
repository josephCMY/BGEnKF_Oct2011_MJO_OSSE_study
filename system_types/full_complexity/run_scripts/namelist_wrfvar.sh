#!/bin/bash
. $CONFIG_FILE
use_for=$1

if [[ $use_for == "4dvar" ]]; then 
  var4d=true
  analysis_type=3D-VAR
fi
if [[ $use_for == "perturb" ]]; then 
  var4d=false
  analysis_type=RANDOMCV
fi

cat << EOF
&wrfvar1
var4d=$var4d,
var4d_lbc=false,
multi_inc=0,
print_detail_radar=false,
print_detail_xa=false,
print_detail_xb=false,
print_detail_obs=false,
print_detail_grad=false,
print_detail_parallel=false,
/
&wrfvar2
/
&wrfvar3
ob_format=2,
/
&wrfvar4
use_synopobs=$USE_SYNOPOBS,
use_shipsobs=$USE_SHIPSOBS,
use_metarobs=$USE_METAROBS,
use_soundobs=$USE_SOUNDOBS,
use_pilotobs=$USE_PILOTOBS,
use_airepobs=$USE_AIREPOBS,
use_geoamvobs=$USE_GEOAMVOBS,
use_polaramvobs=$USE_POLARAMVOBS,
use_bogusobs=$USE_BOGUSOBS,
use_buoyobs=$USE_BUOYOBS,
use_profilerobs=$USE_PROFILEROBS,
use_satemobs=$USE_SATEMOBS,
use_gpspwobs=$USE_GPSPWOBS,
use_gpsrefobs=$USE_GPSREFOBS,
use_qscatobs=$USE_QSCATOBS,
use_radarobs=$USE_RADAROBS,
/
&wrfvar5
check_max_iv=true,
/
&wrfvar6
max_ext_its=1,
ntmax=50,
/
&wrfvar7
cv_options=$CV_OPTIONS,
je_factor=1.25,
var_scaling1=$VAR_SCALING1,
var_scaling2=$VAR_SCALING2,
var_scaling3=$VAR_SCALING3,
var_scaling4=$VAR_SCALING4,
var_scaling5=$VAR_SCALING5,
len_scaling1=$LEN_SCALING1,
len_scaling2=$LEN_SCALING2,
len_scaling3=$LEN_SCALING3,
len_scaling4=$LEN_SCALING4,
len_scaling5=$LEN_SCALING5,
/
&wrfvar8
/
&wrfvar9
/
&wrfvar10
/
&wrfvar11
cv_options_hum=1,
check_rh=0,
calculate_cg_cost_fn=false,
/
&wrfvar12
/
&wrfvar13
/
&wrfvar14
/
&wrfvar15
/
&wrfvar16
alphacv_method=2,
ensdim_alpha=0,
alpha_truncation=0,
alpha_corr_type=3,
alpha_corr_scale=900,
/
&wrfvar17
analysis_type="$analysis_type",
/
&wrfvar18
analysis_date="`wrf_time_string $time_window_min`.0000"
/
&wrfvar19
/
&wrfvar20
/
&wrfvar21
time_window_min="`wrf_time_string $time_window_min`.0000",
/
&wrfvar22
time_window_max="`wrf_time_string $time_window_max`.0000",
/
&perturbation
/
&namelist_quilt
/
EOF

