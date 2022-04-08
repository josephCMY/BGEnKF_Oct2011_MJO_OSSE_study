#!/bin/bash

# Script to make namelist.wps for ungrib.exe and metgrid.exe

# Load config file
. ../config

# Construct string
cat << EOF
&time_control
start_year         = `echo $date_st |cut -c1-4`,
start_month        = `echo $date_st |cut -c5-6`,  
start_day          = `echo $date_st |cut -c7-8`,  
start_hour         = `echo $date_st |cut -c9-10`,  
start_minute       = `echo $date_st |cut -c11-12`,  
start_second       = 00,  
end_year           = `echo $date_ed |cut -c1-4`,  
end_month          = `echo $date_ed |cut -c5-6`,  
end_day            = `echo $date_ed |cut -c7-8`,  
end_hour           = `echo $date_ed |cut -c9-10`, 
end_minute         = `echo $date_ed |cut -c11-12`,
end_second         = 00,                          
input_from_file    = .true.,
interval_seconds   = $((60*60)),
history_interval   = 1440,
frames_per_outfile = 1,
debug_level        = 0,
input_outname="wrfinput_d<domain>_<date>",
write_input=true,
inputout_interval=1440,
inputout_begin_m=0,
inputout_end_m=1440,
auxinput4_inname=wrflowinp_d<domain>,
auxinput4_interval=60,
io_form_auxinput4=2,
/
&domains
max_dom = 1,
time_step = 30,
e_we = 431,
e_sn = 401,
e_vert = 45,
dx = 9000,
dy = 9000,
grid_id    = 1,
parent_id  = 0,
parent_grid_ratio = 1,
parent_time_step_ratio = 1,
i_parent_start = 1,
j_parent_start = 1,
feedback=0,
eta_levels = 1.000000, 0.993042, 0.983211, 0.970571, 0.955211, 0.937239,
0.916793, 0.894028, 0.869104, 0.842199, 0.813512, 0.783267,
0.751688, 0.718973, 0.685325, 0.650946, 0.616034, 0.580793,
0.545438, 0.510175, 0.475184, 0.440634, 0.406689, 0.373503,
0.341211, 0.309918, 0.279723, 0.250727, 0.223030, 0.196731,
0.171918, 0.148674, 0.127087, 0.107244, 0.089261, 0.073324,
0.059519, 0.047598, 0.037267, 0.028358, 0.020713, 0.014185,
0.008638, 0.003947, 0.000000,
smooth_option=0,
num_metgrid_levels=38,
p_top_requested=2000,
num_metgrid_soil_levels=4,
nproc_x=0,
sfcp_to_sfcp=.true.,
/
&physics
mp_physics         = 8,
ra_lw_physics      = 4,
ra_sw_physics      = 5,
sf_sfclay_physics  = 1,
sf_surface_physics = 2,
bl_pbl_physics     = 1,
cu_physics         = 0,
radt               = 3,
bldt               = 0,
cudt               = 5,
mp_zero_out        = 0,
sst_update         = 1,

levsiz = 59
paerlev = 29
cam_abs_dim1 = 4
cam_abs_dim2 = 45

 isfflx                              = 1,
 ifsnow                              = 1,
 icloud                              = 1,
 surface_input_source                = 1,

 num_soil_layers                     = 4,
/
&dynamics
 w_damping                           = 0,
 diff_opt                            = 2,
 km_opt                              = 4,
 diff_6th_opt                        = 0,      0,      0,
 diff_6th_factor                     = 0.12,   0.12,   0.12,
 base_temp                           = 290.
 damp_opt                            = 3,
 zdamp                               = 7000.,  7000.,  5000.,
 dampcoef                            = 0.1,    0.1,    0.2
 khdif                               = 0,      0,      0,
 kvdif                               = 0,      0,      0,
 non_hydrostatic                     = .true., .true., .true.,
 moist_adv_opt                       = 1,      1,      1,
 scalar_adv_opt                      = 1,      1,      1,
 use_input_w                         = .true., 
/
&bdy_control
spec_bdy_width      = 5,
spec_zone           = 1,
relax_zone          = 4,
specified           = .true.,
nested              = .false.,
/
&noah_mp
/
&fdda
/
&scm
/
&grib2
/
&fire
/
&diags
/
&namelist_quilt
 nio_tasks_per_group = 0,
 nio_groups = 1,
/
&tc
/
&logging
/
&dfi_control
/
EOF
