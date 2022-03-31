












module da_control

   
   
   

   use module_driver_constants, only : max_domains, max_eta, max_moves, max_bogus, &
                                       max_outer_iterations, max_instruments, max_plevs, &
                                       max_ocean, num_ob_indexes

   implicit none

!STARTOFREGISTRYGENERATEDINCLUDE 'inc/namelist_defines.inc'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
integer    :: first_item_in_struct
integer :: run_days
integer :: run_hours
integer :: run_minutes
integer :: run_seconds
integer , DIMENSION(max_domains) :: start_year
integer , DIMENSION(max_domains) :: start_month
integer , DIMENSION(max_domains) :: start_day
integer , DIMENSION(max_domains) :: start_hour
integer , DIMENSION(max_domains) :: start_minute
integer , DIMENSION(max_domains) :: start_second
integer , DIMENSION(max_domains) :: end_year
integer , DIMENSION(max_domains) :: end_month
integer , DIMENSION(max_domains) :: end_day
integer , DIMENSION(max_domains) :: end_hour
integer , DIMENSION(max_domains) :: end_minute
integer , DIMENSION(max_domains) :: end_second
integer :: interval_seconds
logical , DIMENSION(max_domains) :: input_from_file
integer , DIMENSION(max_domains) :: fine_input_stream
logical , DIMENSION(max_domains) :: input_from_hires
character*256 :: rsmas_data_path
logical :: all_ic_times
integer , DIMENSION(max_domains) :: julyr
integer , DIMENSION(max_domains) :: julday
real , DIMENSION(max_domains) :: gmt
character*256 :: input_inname
character*256 :: input_outname
character*256 :: bdy_inname
character*256 :: bdy_outname
character*256 :: rst_inname
character*256 :: rst_outname
logical :: write_input
logical :: write_restart_at_0h
logical :: write_hist_at_0h_rst
logical :: adjust_output_times
logical :: adjust_input_times
integer :: diag_print
logical :: nocolons
logical :: cycling
integer :: output_diagnostics
integer :: nwp_diagnostics
logical :: output_ready_flag
logical :: usepio
integer :: pioprocs
integer :: piostart
integer :: piostride
integer :: pioshift
integer :: dfi_opt
integer :: dfi_savehydmeteors
integer :: dfi_nfilter
logical :: dfi_write_filtered_input
logical :: dfi_write_dfi_history
integer :: dfi_cutoff_seconds
integer :: dfi_time_dim
integer :: dfi_fwdstop_year
integer :: dfi_fwdstop_month
integer :: dfi_fwdstop_day
integer :: dfi_fwdstop_hour
integer :: dfi_fwdstop_minute
integer :: dfi_fwdstop_second
integer :: dfi_bckstop_year
integer :: dfi_bckstop_month
integer :: dfi_bckstop_day
integer :: dfi_bckstop_hour
integer :: dfi_bckstop_minute
integer :: dfi_bckstop_second
integer :: time_step
integer :: time_step_fract_num
integer :: time_step_fract_den
integer :: time_step_dfi
integer , DIMENSION(max_domains) :: min_time_step
integer , DIMENSION(max_domains) :: min_time_step_den
integer , DIMENSION(max_domains) :: max_time_step
integer , DIMENSION(max_domains) :: max_time_step_den
real , DIMENSION(max_domains) :: target_cfl
real , DIMENSION(max_domains) :: target_hcfl
integer , DIMENSION(max_domains) :: max_step_increase_pct
integer , DIMENSION(max_domains) :: starting_time_step
integer , DIMENSION(max_domains) :: starting_time_step_den
logical :: step_to_output_time
integer :: adaptation_domain
logical :: use_adaptive_time_step
logical :: use_adaptive_time_step_dfi
integer :: max_dom
integer :: lats_to_mic
integer , DIMENSION(max_domains) :: s_we
integer , DIMENSION(max_domains) :: e_we
integer , DIMENSION(max_domains) :: s_sn
integer , DIMENSION(max_domains) :: e_sn
integer , DIMENSION(max_domains) :: s_vert
integer , DIMENSION(max_domains) :: e_vert
integer :: num_metgrid_levels
integer :: num_metgrid_soil_levels
real :: p_top_requested
logical :: interp_theta
integer :: interp_type
integer :: rebalance
integer , DIMENSION(max_domains) :: vert_refine_method
integer :: vert_refine_fact
integer :: extrap_type
integer :: t_extrap_type
integer :: hypsometric_opt
logical :: lowest_lev_from_sfc
logical :: use_levels_below_ground
logical :: use_tavg_for_tsk
logical :: use_surface
integer :: lagrange_order
integer :: force_sfc_in_vinterp
real :: zap_close_levels
real :: maxw_horiz_pres_diff
real :: trop_horiz_pres_diff
real :: maxw_above_this_level
integer :: use_maxw_level
integer :: use_trop_level
logical :: sfcp_to_sfcp
logical :: adjust_heights
logical :: smooth_cg_topo
integer :: nest_interp_coord
integer :: interp_method_type
logical :: aggregate_lu
logical :: rh2qv_wrt_liquid
integer :: rh2qv_method
real :: qv_max_p_safe
real :: qv_max_flag
real :: qv_max_value
real :: qv_min_p_safe
real :: qv_min_flag
real :: qv_min_value
integer :: ideal_init_method
real , DIMENSION(max_domains) :: dx
real , DIMENSION(max_domains) :: dy
integer , DIMENSION(max_domains) :: grid_id
logical , DIMENSION(max_domains) :: grid_allowed
integer , DIMENSION(max_domains) :: parent_id
integer , DIMENSION(max_domains) :: i_parent_start
integer , DIMENSION(max_domains) :: j_parent_start
integer , DIMENSION(max_domains) :: parent_grid_ratio
integer , DIMENSION(max_domains) :: parent_time_step_ratio
integer :: feedback
integer :: smooth_option
integer :: blend_width
real , DIMENSION(max_domains) :: ztop
integer , DIMENSION(max_domains) :: moad_grid_ratio
integer , DIMENSION(max_domains) :: moad_time_step_ratio
integer , DIMENSION(max_domains) :: shw
integer :: tile_sz_x
integer :: tile_sz_y
integer :: numtiles
integer :: numtiles_inc
integer :: numtiles_x
integer :: numtiles_y
integer :: tile_strategy
integer :: nproc_x
integer :: nproc_y
integer :: irand
real , DIMENSION(max_domains) :: dt
integer :: fft_used
integer :: cu_used
integer :: shcu_used
integer :: cam_used
integer :: alloc_qndropsource
integer :: num_moves
integer :: ts_buf_size
integer :: max_ts_locs
integer , DIMENSION(max_domains) :: vortex_interval
integer , DIMENSION(max_domains) :: max_vortex_speed
integer , DIMENSION(max_domains) :: corral_dist
integer :: track_level
real , DIMENSION(max_domains) :: time_to_move
integer , DIMENSION(max_moves) :: move_id
integer , DIMENSION(max_moves) :: move_interval
integer , DIMENSION(max_moves) :: move_cd_x
integer , DIMENSION(max_moves) :: move_cd_y
logical , DIMENSION(max_domains) :: swap_x
logical , DIMENSION(max_domains) :: swap_y
logical , DIMENSION(max_domains) :: cycle_x
logical , DIMENSION(max_domains) :: cycle_y
logical :: reorder_mesh
logical :: perturb_input
real , DIMENSION(max_eta) :: eta_levels
real :: max_dz
integer :: ocean_levels
real , DIMENSION(max_ocean) :: ocean_z
real , DIMENSION(max_ocean) :: ocean_t
real , DIMENSION(max_ocean) :: ocean_s
integer :: num_traj
integer :: max_ts_level
integer :: track_loc_in
integer :: num_ext_model_couple_dom
logical :: insert_bogus_storm
logical :: remove_storm
integer :: num_storm
real , DIMENSION(max_bogus) :: latc_loc
real , DIMENSION(max_bogus) :: lonc_loc
real , DIMENSION(max_bogus) :: vmax_meters_per_second
real , DIMENSION(max_bogus) :: rmax
real , DIMENSION(max_bogus) :: vmax_ratio
real :: rankine_lid
logical :: force_read_thompson
logical :: write_thompson_tables
integer , DIMENSION(max_domains) :: mp_physics
real , DIMENSION(max_domains) :: nssl_cccn
real , DIMENSION(max_domains) :: nssl_alphah
real , DIMENSION(max_domains) :: nssl_alphahl
real , DIMENSION(max_domains) :: nssl_cnoh
real , DIMENSION(max_domains) :: nssl_cnohl
real , DIMENSION(max_domains) :: nssl_cnor
real , DIMENSION(max_domains) :: nssl_cnos
real , DIMENSION(max_domains) :: nssl_rho_qh
real , DIMENSION(max_domains) :: nssl_rho_qhl
real , DIMENSION(max_domains) :: nssl_rho_qs
integer , DIMENSION(max_domains) :: nudge_lightning
integer , DIMENSION(max_domains) :: nudge_light_times
integer , DIMENSION(max_domains) :: nudge_light_timee
integer , DIMENSION(max_domains) :: nudge_light_int
character*256 :: path_to_files
integer :: gsfcgce_hail
integer :: gsfcgce_2ice
integer , DIMENSION(max_domains) :: progn
real :: accum_mode
real :: aitken_mode
real :: coarse_mode
integer :: do_radar_ref
integer :: compute_radar_ref
integer , DIMENSION(max_domains) :: ra_lw_physics
integer , DIMENSION(max_domains) :: ra_sw_physics
real , DIMENSION(max_domains) :: radt
real , DIMENSION(max_domains) :: naer
integer , DIMENSION(max_domains) :: sf_sfclay_physics
integer , DIMENSION(max_domains) :: sf_surface_physics
integer , DIMENSION(max_domains) :: bl_pbl_physics
integer , DIMENSION(max_domains) :: bl_mynn_tkebudget
integer :: ysu_topdown_pblmix
integer , DIMENSION(max_domains) :: shinhong_tke_diag
logical , DIMENSION(max_domains) :: bl_mynn_tkeadvect
integer :: bl_mynn_cloudpdf
integer :: bl_mynn_mixlength
integer , DIMENSION(max_domains) :: bl_mynn_edmf
integer , DIMENSION(max_domains) :: bl_mynn_edmf_mom
integer , DIMENSION(max_domains) :: bl_mynn_edmf_tke
integer , DIMENSION(max_domains) :: bl_mynn_edmf_part
integer , DIMENSION(max_domains) :: bl_mynn_cloudmix
integer , DIMENSION(max_domains) :: bl_mynn_mixqt
integer :: icloud_bl
integer , DIMENSION(max_domains) :: mfshconv
integer , DIMENSION(max_domains) :: sf_urban_physics
real , DIMENSION(max_domains) :: bldt
integer , DIMENSION(max_domains) :: cu_physics
integer , DIMENSION(max_domains) :: shcu_physics
integer , DIMENSION(max_domains) :: cu_diag
integer , DIMENSION(max_domains) :: kf_edrates
integer :: kfeta_trigger
integer :: nsas_dx_factor
real , DIMENSION(max_domains) :: cudt
real , DIMENSION(max_domains) :: gsmdt
integer :: isfflx
integer :: ifsnow
integer :: icloud
integer :: ideal_xland
real :: swrad_scat
integer :: surface_input_source
integer :: num_soil_layers
integer :: maxpatch
integer :: num_snow_layers
integer :: num_snso_layers
integer :: num_urban_layers
integer :: num_urban_hi
integer :: num_months
integer :: sf_surface_mosaic
integer :: mosaic_cat
integer :: mosaic_cat_soil
integer :: mosaic_lu
integer :: mosaic_soil
integer :: maxiens
integer :: maxens
integer :: maxens2
integer :: maxens3
integer :: ensdim
integer :: cugd_avedx
integer :: clos_choice
integer :: imomentum
integer :: ishallow
real :: convtrans_avglen_m
integer :: num_land_cat
integer :: num_soil_cat
integer :: mp_zero_out
real :: mp_zero_out_thresh
real :: seaice_threshold
integer :: sst_update
integer :: sst_skin
integer :: tmn_update
logical :: usemonalb
logical :: rdmaxalb
logical :: rdlai2d
logical :: ua_phys
integer :: opt_thcnd
integer :: co2tf
integer :: ra_call_offset
real :: cam_abs_freq_s
integer :: levsiz
integer :: paerlev
integer :: cam_abs_dim1
integer :: cam_abs_dim2
integer :: lagday
integer :: no_src_types
integer :: alevsiz
integer :: o3input
integer :: aer_opt
integer :: swint_opt
integer , DIMENSION(max_domains) :: aer_type
integer , DIMENSION(max_domains) :: aer_aod550_opt
integer , DIMENSION(max_domains) :: aer_angexp_opt
integer , DIMENSION(max_domains) :: aer_ssa_opt
integer , DIMENSION(max_domains) :: aer_asy_opt
real , DIMENSION(max_domains) :: aer_aod550_val
real , DIMENSION(max_domains) :: aer_angexp_val
real , DIMENSION(max_domains) :: aer_ssa_val
real , DIMENSION(max_domains) :: aer_asy_val
logical , DIMENSION(max_domains) :: cu_rad_feedback
logical , DIMENSION(max_domains) :: shallowcu_forced_ra
integer , DIMENSION(max_domains) :: numbins
real , DIMENSION(max_domains) :: thbinsize
real , DIMENSION(max_domains) :: rbinsize
real , DIMENSION(max_domains) :: mindeepfreq
real , DIMENSION(max_domains) :: minshallowfreq
integer , DIMENSION(max_domains) :: shcu_aerosols_opt
integer , DIMENSION(max_domains) :: icloud_cu
integer , DIMENSION(max_domains) :: pxlsm_smois_init
integer :: omlcall
integer :: sf_ocean_physics
integer :: traj_opt
integer :: tracercall
real :: omdt
real :: oml_hml0
real :: oml_gamma
real :: oml_relaxation_time
integer :: isftcflx
integer :: iz0tlnd
real :: shadlen
integer , DIMENSION(max_domains) :: slope_rad
integer , DIMENSION(max_domains) :: topo_shading
integer , DIMENSION(max_domains) :: topo_wind
integer :: no_mp_heating
integer :: fractional_seaice
integer :: seaice_snowdepth_opt
real :: seaice_snowdepth_max
real :: seaice_snowdepth_min
integer :: seaice_albedo_opt
real :: seaice_albedo_default
integer :: seaice_thickness_opt
real :: seaice_thickness_default
logical :: tice2tsk_if2cold
real :: bucket_mm
real :: bucket_j
real :: mp_tend_lim
real , DIMENSION(max_domains) :: prec_acc_dt
integer :: prec_acc_opt
integer :: bucketr_opt
integer :: process_time_series
integer , DIMENSION(max_domains) :: grav_settling
real , DIMENSION(max_domains) :: sas_pgcon
integer , DIMENSION(max_domains) :: scalar_pblmix
integer , DIMENSION(max_domains) :: tracer_pblmix
logical :: use_aero_icbc
logical :: use_rap_aero_icbc
integer :: use_mp_re
real :: ccn_conc
integer :: hail_opt
integer :: dveg
integer :: opt_crs
integer :: opt_btr
integer :: opt_run
integer :: opt_sfc
integer :: opt_frz
integer :: opt_inf
integer :: opt_rad
integer :: opt_alb
integer :: opt_snf
integer :: opt_tbot
integer :: opt_stc
integer :: opt_gla
integer :: opt_rsf
real , DIMENSION(max_domains) :: wtddt
integer :: wrf_hydro
real , DIMENSION(max_domains) :: fgdt
integer , DIMENSION(max_domains) :: fgdtzero
integer , DIMENSION(max_domains) :: grid_fdda
integer , DIMENSION(max_domains) :: grid_sfdda
integer , DIMENSION(max_domains) :: if_no_pbl_nudging_uv
integer , DIMENSION(max_domains) :: if_no_pbl_nudging_t
integer , DIMENSION(max_domains) :: if_no_pbl_nudging_ph
integer , DIMENSION(max_domains) :: if_no_pbl_nudging_q
integer , DIMENSION(max_domains) :: if_zfac_uv
integer , DIMENSION(max_domains) :: k_zfac_uv
integer , DIMENSION(max_domains) :: if_zfac_t
integer , DIMENSION(max_domains) :: k_zfac_t
integer , DIMENSION(max_domains) :: if_zfac_ph
integer , DIMENSION(max_domains) :: k_zfac_ph
integer , DIMENSION(max_domains) :: if_zfac_q
integer , DIMENSION(max_domains) :: k_zfac_q
integer , DIMENSION(max_domains) :: dk_zfac_uv
integer , DIMENSION(max_domains) :: dk_zfac_t
integer , DIMENSION(max_domains) :: dk_zfac_ph
real , DIMENSION(max_domains) :: guv
real , DIMENSION(max_domains) :: guv_sfc
real , DIMENSION(max_domains) :: gt
real , DIMENSION(max_domains) :: gt_sfc
real , DIMENSION(max_domains) :: gq
real , DIMENSION(max_domains) :: gq_sfc
real , DIMENSION(max_domains) :: gph
real :: dtramp_min
integer :: if_ramping
real , DIMENSION(max_domains) :: rinblw
integer , DIMENSION(max_domains) :: xwavenum
integer , DIMENSION(max_domains) :: ywavenum
integer , DIMENSION(max_domains) :: pxlsm_soil_nudge
integer , DIMENSION(max_domains) :: fasdas
integer , DIMENSION(max_domains) :: obs_nudge_opt
integer :: max_obs
real , DIMENSION(max_domains) :: fdda_start
real , DIMENSION(max_domains) :: fdda_end
integer , DIMENSION(max_domains) :: obs_nudge_wind
real , DIMENSION(max_domains) :: obs_coef_wind
integer , DIMENSION(max_domains) :: obs_nudge_temp
real , DIMENSION(max_domains) :: obs_coef_temp
integer , DIMENSION(max_domains) :: obs_nudge_mois
real , DIMENSION(max_domains) :: obs_coef_mois
integer , DIMENSION(max_domains) :: obs_nudge_pstr
real , DIMENSION(max_domains) :: obs_coef_pstr
integer , DIMENSION(max_domains) :: obs_no_pbl_nudge_uv
integer , DIMENSION(max_domains) :: obs_no_pbl_nudge_t
integer , DIMENSION(max_domains) :: obs_no_pbl_nudge_q
integer :: obs_sfc_scheme_horiz
integer :: obs_sfc_scheme_vert
real :: obs_max_sndng_gap
real :: obs_nudgezfullr1_uv
real :: obs_nudgezrampr1_uv
real :: obs_nudgezfullr2_uv
real :: obs_nudgezrampr2_uv
real :: obs_nudgezfullr4_uv
real :: obs_nudgezrampr4_uv
real :: obs_nudgezfullr1_t
real :: obs_nudgezrampr1_t
real :: obs_nudgezfullr2_t
real :: obs_nudgezrampr2_t
real :: obs_nudgezfullr4_t
real :: obs_nudgezrampr4_t
real :: obs_nudgezfullr1_q
real :: obs_nudgezrampr1_q
real :: obs_nudgezfullr2_q
real :: obs_nudgezrampr2_q
real :: obs_nudgezfullr4_q
real :: obs_nudgezrampr4_q
real :: obs_nudgezfullmin
real :: obs_nudgezrampmin
real :: obs_nudgezmax
real :: obs_sfcfact
real :: obs_sfcfacr
real :: obs_dpsmx
real , DIMENSION(max_domains) :: obs_rinxy
real :: obs_rinsig
real , DIMENSION(max_domains) :: obs_twindo
integer :: obs_npfi
integer , DIMENSION(max_domains) :: obs_ionf
integer :: obs_idynin
real :: obs_dtramp
integer :: obs_prt_max
integer , DIMENSION(max_domains) :: obs_prt_freq
logical :: obs_ipf_in4dob
logical :: obs_ipf_errob
logical :: obs_ipf_nudob
logical :: obs_ipf_init
integer :: obs_scl_neg_qv_innov
integer :: scm_force
real :: scm_force_dx
integer :: num_force_layers
integer :: scm_lu_index
integer :: scm_isltyp
real :: scm_vegfra
real :: scm_canwat
real :: scm_lat
real :: scm_lon
logical :: scm_th_t_tend
logical :: scm_qv_t_tend
logical :: scm_th_adv
logical :: scm_wind_adv
logical :: scm_qv_adv
logical :: scm_ql_adv
logical :: scm_vert_adv
integer :: num_force_soil_layers
logical :: scm_soilt_force
logical :: scm_soilq_force
logical :: scm_force_th_largescale
logical :: scm_force_qv_largescale
logical :: scm_force_ql_largescale
logical :: scm_force_wind_largescale
integer :: scm_force_skintemp
integer :: scm_force_flux
integer :: dyn_opt
integer :: rk_ord
integer :: w_damping
integer , DIMENSION(max_domains) :: diff_opt
integer , DIMENSION(max_domains) :: diff_opt_dfi
integer , DIMENSION(max_domains) :: km_opt
integer , DIMENSION(max_domains) :: km_opt_dfi
integer :: damp_opt
integer :: rad_nudge
integer :: gwd_opt
real , DIMENSION(max_domains) :: zdamp
real , DIMENSION(max_domains) :: dampcoef
real , DIMENSION(max_domains) :: khdif
real , DIMENSION(max_domains) :: kvdif
real , DIMENSION(max_domains) :: diff_6th_factor
integer , DIMENSION(max_domains) :: diff_6th_opt
integer :: use_theta_m
integer :: use_q_diabatic
real , DIMENSION(max_domains) :: c_s
real , DIMENSION(max_domains) :: c_k
real , DIMENSION(max_domains) :: smdiv
real , DIMENSION(max_domains) :: emdiv
real , DIMENSION(max_domains) :: epssm
logical , DIMENSION(max_domains) :: non_hydrostatic
logical :: use_input_w
integer , DIMENSION(max_domains) :: time_step_sound
integer , DIMENSION(max_domains) :: h_mom_adv_order
integer , DIMENSION(max_domains) :: v_mom_adv_order
integer , DIMENSION(max_domains) :: h_sca_adv_order
integer , DIMENSION(max_domains) :: v_sca_adv_order
integer , DIMENSION(max_domains) :: momentum_adv_opt
integer , DIMENSION(max_domains) :: moist_adv_opt
integer , DIMENSION(max_domains) :: moist_adv_dfi_opt
integer , DIMENSION(max_domains) :: chem_adv_opt
integer , DIMENSION(max_domains) :: tracer_adv_opt
integer , DIMENSION(max_domains) :: scalar_adv_opt
integer , DIMENSION(max_domains) :: tke_adv_opt
logical , DIMENSION(max_domains) :: top_radiation
integer , DIMENSION(max_domains) :: mix_isotropic
real , DIMENSION(max_domains) :: mix_upper_bound
logical , DIMENSION(max_domains) :: top_lid
real , DIMENSION(max_domains) :: tke_upper_bound
real , DIMENSION(max_domains) :: tke_drag_coefficient
real , DIMENSION(max_domains) :: tke_heat_flux
logical , DIMENSION(max_domains) :: pert_coriolis
logical , DIMENSION(max_domains) :: coriolis2d
logical , DIMENSION(max_domains) :: mix_full_fields
real :: base_pres
real :: base_temp
real :: base_lapse
real :: iso_temp
real :: base_pres_strat
real :: base_lapse_strat
logical :: use_baseparam_fr_nml
real :: fft_filter_lat
logical :: coupled_filtering
logical :: pos_def
logical :: swap_pole_with_next_j
logical :: actual_distance_average
logical :: rotated_pole
logical , DIMENSION(max_domains) :: do_coriolis
logical , DIMENSION(max_domains) :: do_curvature
logical , DIMENSION(max_domains) :: do_gradp
integer , DIMENSION(max_domains) :: tracer_opt
integer , DIMENSION(max_domains) :: tenddiag
integer :: spec_bdy_width
integer :: spec_zone
integer :: relax_zone
logical , DIMENSION(max_domains) :: specified
logical :: constant_bc
logical , DIMENSION(max_domains) :: periodic_x
logical , DIMENSION(max_domains) :: symmetric_xs
logical , DIMENSION(max_domains) :: symmetric_xe
logical , DIMENSION(max_domains) :: open_xs
logical , DIMENSION(max_domains) :: open_xe
logical , DIMENSION(max_domains) :: periodic_y
logical , DIMENSION(max_domains) :: symmetric_ys
logical , DIMENSION(max_domains) :: symmetric_ye
logical , DIMENSION(max_domains) :: open_ys
logical , DIMENSION(max_domains) :: open_ye
logical , DIMENSION(max_domains) :: polar
logical , DIMENSION(max_domains) :: nested
real :: spec_exp
integer :: spec_bdy_final_mu
integer :: real_data_init_type
logical , DIMENSION(max_domains) :: have_bcs_moist
logical , DIMENSION(max_domains) :: have_bcs_scalar
integer :: background_proc_id
integer :: forecast_proc_id
integer :: production_status
integer :: compression
integer :: nobs_ndg_vars
integer :: nobs_err_flds
real , DIMENSION(max_domains) :: cen_lat
real , DIMENSION(max_domains) :: cen_lon
real , DIMENSION(max_domains) :: truelat1
real , DIMENSION(max_domains) :: truelat2
real , DIMENSION(max_domains) :: moad_cen_lat
real , DIMENSION(max_domains) :: stand_lon
real , DIMENSION(max_domains) :: pole_lat
real , DIMENSION(max_domains) :: pole_lon
integer :: flag_metgrid
integer :: flag_snow
integer :: flag_psfc
integer :: flag_sm000010
integer :: flag_sm010040
integer :: flag_sm040100
integer :: flag_sm100200
integer :: flag_st000010
integer :: flag_st010040
integer :: flag_st040100
integer :: flag_st100200
integer :: flag_soil_layers
integer :: flag_slp
integer :: flag_soilhgt
integer :: flag_mf_xy
integer :: flag_um_soil
real , DIMENSION(max_domains) :: bdyfrq
character*256 , DIMENSION(max_domains) :: mminlu
integer , DIMENSION(max_domains) :: iswater
integer , DIMENSION(max_domains) :: islake
integer , DIMENSION(max_domains) :: isice
integer , DIMENSION(max_domains) :: isurban
integer , DIMENSION(max_domains) :: isoilwater
integer , DIMENSION(max_domains) :: map_proj
integer :: use_wps_input
integer , DIMENSION(max_domains) :: dfi_stage
integer , DIMENSION(max_domains) :: mp_physics_dfi
integer , DIMENSION(max_domains) :: bl_pbl_physics_dfi
integer , DIMENSION(max_domains) :: windfarm_opt
integer :: windfarm_ij
integer , DIMENSION(max_domains) :: lightning_option
real , DIMENSION(max_domains) :: lightning_dt
real , DIMENSION(max_domains) :: lightning_start_seconds
real , DIMENSION(max_domains) :: flashrate_factor
integer , DIMENSION(max_domains) :: iccg_method
real , DIMENSION(max_domains) :: iccg_prescribed_num
real , DIMENSION(max_domains) :: iccg_prescribed_den
integer , DIMENSION(max_domains) :: cellcount_method
real , DIMENSION(max_domains) :: cldtop_adjustment
integer , DIMENSION(max_domains) :: sf_lake_physics
character*256 :: auxinput1_inname
integer :: io_form_auxinput1
logical :: override_restart_timers
character*256 :: auxhist1_inname
character*256 :: auxhist1_outname
integer , DIMENSION(max_domains) :: auxhist1_interval_y
integer , DIMENSION(max_domains) :: auxhist1_interval_d
integer , DIMENSION(max_domains) :: auxhist1_interval_h
integer , DIMENSION(max_domains) :: auxhist1_interval_m
integer , DIMENSION(max_domains) :: auxhist1_interval_s
integer , DIMENSION(max_domains) :: auxhist1_interval
integer , DIMENSION(max_domains) :: auxhist1_begin_y
integer , DIMENSION(max_domains) :: auxhist1_begin_d
integer , DIMENSION(max_domains) :: auxhist1_begin_h
integer , DIMENSION(max_domains) :: auxhist1_begin_m
integer , DIMENSION(max_domains) :: auxhist1_begin_s
integer , DIMENSION(max_domains) :: auxhist1_begin
integer , DIMENSION(max_domains) :: auxhist1_end_y
integer , DIMENSION(max_domains) :: auxhist1_end_d
integer , DIMENSION(max_domains) :: auxhist1_end_h
integer , DIMENSION(max_domains) :: auxhist1_end_m
integer , DIMENSION(max_domains) :: auxhist1_end_s
integer , DIMENSION(max_domains) :: auxhist1_end
integer :: io_form_auxhist1
integer , DIMENSION(max_domains) :: frames_per_auxhist1
character*256 :: auxhist2_inname
character*256 :: auxhist2_outname
integer , DIMENSION(max_domains) :: auxhist2_interval_y
integer , DIMENSION(max_domains) :: auxhist2_interval_d
integer , DIMENSION(max_domains) :: auxhist2_interval_h
integer , DIMENSION(max_domains) :: auxhist2_interval_m
integer , DIMENSION(max_domains) :: auxhist2_interval_s
integer , DIMENSION(max_domains) :: auxhist2_interval
integer , DIMENSION(max_domains) :: auxhist2_begin_y
integer , DIMENSION(max_domains) :: auxhist2_begin_d
integer , DIMENSION(max_domains) :: auxhist2_begin_h
integer , DIMENSION(max_domains) :: auxhist2_begin_m
integer , DIMENSION(max_domains) :: auxhist2_begin_s
integer , DIMENSION(max_domains) :: auxhist2_begin
integer , DIMENSION(max_domains) :: auxhist2_end_y
integer , DIMENSION(max_domains) :: auxhist2_end_d
integer , DIMENSION(max_domains) :: auxhist2_end_h
integer , DIMENSION(max_domains) :: auxhist2_end_m
integer , DIMENSION(max_domains) :: auxhist2_end_s
integer , DIMENSION(max_domains) :: auxhist2_end
integer :: io_form_auxhist2
integer , DIMENSION(max_domains) :: frames_per_auxhist2
character*256 :: auxhist3_inname
character*256 :: auxhist3_outname
integer , DIMENSION(max_domains) :: auxhist3_interval_y
integer , DIMENSION(max_domains) :: auxhist3_interval_d
integer , DIMENSION(max_domains) :: auxhist3_interval_h
integer , DIMENSION(max_domains) :: auxhist3_interval_m
integer , DIMENSION(max_domains) :: auxhist3_interval_s
integer , DIMENSION(max_domains) :: auxhist3_interval
integer , DIMENSION(max_domains) :: auxhist3_begin_y
integer , DIMENSION(max_domains) :: auxhist3_begin_d
integer , DIMENSION(max_domains) :: auxhist3_begin_h
integer , DIMENSION(max_domains) :: auxhist3_begin_m
integer , DIMENSION(max_domains) :: auxhist3_begin_s
integer , DIMENSION(max_domains) :: auxhist3_begin
integer , DIMENSION(max_domains) :: auxhist3_end_y
integer , DIMENSION(max_domains) :: auxhist3_end_d
integer , DIMENSION(max_domains) :: auxhist3_end_h
integer , DIMENSION(max_domains) :: auxhist3_end_m
integer , DIMENSION(max_domains) :: auxhist3_end_s
integer , DIMENSION(max_domains) :: auxhist3_end
integer :: io_form_auxhist3
integer , DIMENSION(max_domains) :: frames_per_auxhist3
character*256 :: auxhist4_inname
character*256 :: auxhist4_outname
integer , DIMENSION(max_domains) :: auxhist4_interval_y
integer , DIMENSION(max_domains) :: auxhist4_interval_d
integer , DIMENSION(max_domains) :: auxhist4_interval_h
integer , DIMENSION(max_domains) :: auxhist4_interval_m
integer , DIMENSION(max_domains) :: auxhist4_interval_s
integer , DIMENSION(max_domains) :: auxhist4_interval
integer , DIMENSION(max_domains) :: auxhist4_begin_y
integer , DIMENSION(max_domains) :: auxhist4_begin_d
integer , DIMENSION(max_domains) :: auxhist4_begin_h
integer , DIMENSION(max_domains) :: auxhist4_begin_m
integer , DIMENSION(max_domains) :: auxhist4_begin_s
integer , DIMENSION(max_domains) :: auxhist4_begin
integer , DIMENSION(max_domains) :: auxhist4_end_y
integer , DIMENSION(max_domains) :: auxhist4_end_d
integer , DIMENSION(max_domains) :: auxhist4_end_h
integer , DIMENSION(max_domains) :: auxhist4_end_m
integer , DIMENSION(max_domains) :: auxhist4_end_s
integer , DIMENSION(max_domains) :: auxhist4_end
integer :: io_form_auxhist4
integer , DIMENSION(max_domains) :: frames_per_auxhist4
character*256 :: auxhist5_inname
character*256 :: auxhist5_outname
integer , DIMENSION(max_domains) :: auxhist5_interval_y
integer , DIMENSION(max_domains) :: auxhist5_interval_d
integer , DIMENSION(max_domains) :: auxhist5_interval_h
integer , DIMENSION(max_domains) :: auxhist5_interval_m
integer , DIMENSION(max_domains) :: auxhist5_interval_s
integer , DIMENSION(max_domains) :: auxhist5_interval
integer , DIMENSION(max_domains) :: auxhist5_begin_y
integer , DIMENSION(max_domains) :: auxhist5_begin_d
integer , DIMENSION(max_domains) :: auxhist5_begin_h
integer , DIMENSION(max_domains) :: auxhist5_begin_m
integer , DIMENSION(max_domains) :: auxhist5_begin_s
integer , DIMENSION(max_domains) :: auxhist5_begin
integer , DIMENSION(max_domains) :: auxhist5_end_y
integer , DIMENSION(max_domains) :: auxhist5_end_d
integer , DIMENSION(max_domains) :: auxhist5_end_h
integer , DIMENSION(max_domains) :: auxhist5_end_m
integer , DIMENSION(max_domains) :: auxhist5_end_s
integer , DIMENSION(max_domains) :: auxhist5_end
integer :: io_form_auxhist5
integer , DIMENSION(max_domains) :: frames_per_auxhist5
character*256 :: auxhist6_inname
character*256 :: auxhist6_outname
integer , DIMENSION(max_domains) :: auxhist6_interval_y
integer , DIMENSION(max_domains) :: auxhist6_interval_d
integer , DIMENSION(max_domains) :: auxhist6_interval_h
integer , DIMENSION(max_domains) :: auxhist6_interval_m
integer , DIMENSION(max_domains) :: auxhist6_interval_s
integer , DIMENSION(max_domains) :: auxhist6_interval
integer , DIMENSION(max_domains) :: auxhist6_begin_y
integer , DIMENSION(max_domains) :: auxhist6_begin_d
integer , DIMENSION(max_domains) :: auxhist6_begin_h
integer , DIMENSION(max_domains) :: auxhist6_begin_m
integer , DIMENSION(max_domains) :: auxhist6_begin_s
integer , DIMENSION(max_domains) :: auxhist6_begin
integer , DIMENSION(max_domains) :: auxhist6_end_y
integer , DIMENSION(max_domains) :: auxhist6_end_d
integer , DIMENSION(max_domains) :: auxhist6_end_h
integer , DIMENSION(max_domains) :: auxhist6_end_m
integer , DIMENSION(max_domains) :: auxhist6_end_s
integer , DIMENSION(max_domains) :: auxhist6_end
integer :: io_form_auxhist6
integer , DIMENSION(max_domains) :: frames_per_auxhist6
character*256 :: auxhist7_inname
character*256 :: auxhist7_outname
integer , DIMENSION(max_domains) :: auxhist7_interval_y
integer , DIMENSION(max_domains) :: auxhist7_interval_d
integer , DIMENSION(max_domains) :: auxhist7_interval_h
integer , DIMENSION(max_domains) :: auxhist7_interval_m
integer , DIMENSION(max_domains) :: auxhist7_interval_s
integer , DIMENSION(max_domains) :: auxhist7_interval
integer , DIMENSION(max_domains) :: auxhist7_begin_y
integer , DIMENSION(max_domains) :: auxhist7_begin_d
integer , DIMENSION(max_domains) :: auxhist7_begin_h
integer , DIMENSION(max_domains) :: auxhist7_begin_m
integer , DIMENSION(max_domains) :: auxhist7_begin_s
integer , DIMENSION(max_domains) :: auxhist7_begin
integer , DIMENSION(max_domains) :: auxhist7_end_y
integer , DIMENSION(max_domains) :: auxhist7_end_d
integer , DIMENSION(max_domains) :: auxhist7_end_h
integer , DIMENSION(max_domains) :: auxhist7_end_m
integer , DIMENSION(max_domains) :: auxhist7_end_s
integer , DIMENSION(max_domains) :: auxhist7_end
integer :: io_form_auxhist7
integer , DIMENSION(max_domains) :: frames_per_auxhist7
character*256 :: auxhist8_inname
character*256 :: auxhist8_outname
integer , DIMENSION(max_domains) :: auxhist8_interval_y
integer , DIMENSION(max_domains) :: auxhist8_interval_d
integer , DIMENSION(max_domains) :: auxhist8_interval_h
integer , DIMENSION(max_domains) :: auxhist8_interval_m
integer , DIMENSION(max_domains) :: auxhist8_interval_s
integer , DIMENSION(max_domains) :: auxhist8_interval
integer , DIMENSION(max_domains) :: auxhist8_begin_y
integer , DIMENSION(max_domains) :: auxhist8_begin_d
integer , DIMENSION(max_domains) :: auxhist8_begin_h
integer , DIMENSION(max_domains) :: auxhist8_begin_m
integer , DIMENSION(max_domains) :: auxhist8_begin_s
integer , DIMENSION(max_domains) :: auxhist8_begin
integer , DIMENSION(max_domains) :: auxhist8_end_y
integer , DIMENSION(max_domains) :: auxhist8_end_d
integer , DIMENSION(max_domains) :: auxhist8_end_h
integer , DIMENSION(max_domains) :: auxhist8_end_m
integer , DIMENSION(max_domains) :: auxhist8_end_s
integer , DIMENSION(max_domains) :: auxhist8_end
integer :: io_form_auxhist8
integer , DIMENSION(max_domains) :: frames_per_auxhist8
character*256 :: auxhist9_inname
character*256 :: auxhist9_outname
integer , DIMENSION(max_domains) :: auxhist9_interval_y
integer , DIMENSION(max_domains) :: auxhist9_interval_d
integer , DIMENSION(max_domains) :: auxhist9_interval_h
integer , DIMENSION(max_domains) :: auxhist9_interval_m
integer , DIMENSION(max_domains) :: auxhist9_interval_s
integer , DIMENSION(max_domains) :: auxhist9_interval
integer , DIMENSION(max_domains) :: auxhist9_begin_y
integer , DIMENSION(max_domains) :: auxhist9_begin_d
integer , DIMENSION(max_domains) :: auxhist9_begin_h
integer , DIMENSION(max_domains) :: auxhist9_begin_m
integer , DIMENSION(max_domains) :: auxhist9_begin_s
integer , DIMENSION(max_domains) :: auxhist9_begin
integer , DIMENSION(max_domains) :: auxhist9_end_y
integer , DIMENSION(max_domains) :: auxhist9_end_d
integer , DIMENSION(max_domains) :: auxhist9_end_h
integer , DIMENSION(max_domains) :: auxhist9_end_m
integer , DIMENSION(max_domains) :: auxhist9_end_s
integer , DIMENSION(max_domains) :: auxhist9_end
integer :: io_form_auxhist9
integer , DIMENSION(max_domains) :: frames_per_auxhist9
character*256 :: auxhist10_inname
character*256 :: auxhist10_outname
integer , DIMENSION(max_domains) :: auxhist10_interval_y
integer , DIMENSION(max_domains) :: auxhist10_interval_d
integer , DIMENSION(max_domains) :: auxhist10_interval_h
integer , DIMENSION(max_domains) :: auxhist10_interval_m
integer , DIMENSION(max_domains) :: auxhist10_interval_s
integer , DIMENSION(max_domains) :: auxhist10_interval
integer , DIMENSION(max_domains) :: auxhist10_begin_y
integer , DIMENSION(max_domains) :: auxhist10_begin_d
integer , DIMENSION(max_domains) :: auxhist10_begin_h
integer , DIMENSION(max_domains) :: auxhist10_begin_m
integer , DIMENSION(max_domains) :: auxhist10_begin_s
integer , DIMENSION(max_domains) :: auxhist10_begin
integer , DIMENSION(max_domains) :: auxhist10_end_y
integer , DIMENSION(max_domains) :: auxhist10_end_d
integer , DIMENSION(max_domains) :: auxhist10_end_h
integer , DIMENSION(max_domains) :: auxhist10_end_m
integer , DIMENSION(max_domains) :: auxhist10_end_s
integer , DIMENSION(max_domains) :: auxhist10_end
integer :: io_form_auxhist10
integer , DIMENSION(max_domains) :: frames_per_auxhist10
character*256 :: auxhist11_inname
character*256 :: auxhist11_outname
integer , DIMENSION(max_domains) :: auxhist11_interval_y
integer , DIMENSION(max_domains) :: auxhist11_interval_d
integer , DIMENSION(max_domains) :: auxhist11_interval_h
integer , DIMENSION(max_domains) :: auxhist11_interval_m
integer , DIMENSION(max_domains) :: auxhist11_interval_s
integer , DIMENSION(max_domains) :: auxhist11_interval
integer , DIMENSION(max_domains) :: auxhist11_begin_y
integer , DIMENSION(max_domains) :: auxhist11_begin_d
integer , DIMENSION(max_domains) :: auxhist11_begin_h
integer , DIMENSION(max_domains) :: auxhist11_begin_m
integer , DIMENSION(max_domains) :: auxhist11_begin_s
integer , DIMENSION(max_domains) :: auxhist11_begin
integer , DIMENSION(max_domains) :: auxhist11_end_y
integer , DIMENSION(max_domains) :: auxhist11_end_d
integer , DIMENSION(max_domains) :: auxhist11_end_h
integer , DIMENSION(max_domains) :: auxhist11_end_m
integer , DIMENSION(max_domains) :: auxhist11_end_s
integer , DIMENSION(max_domains) :: auxhist11_end
integer :: io_form_auxhist11
integer , DIMENSION(max_domains) :: frames_per_auxhist11
character*256 :: auxhist12_inname
character*256 :: auxhist12_outname
integer , DIMENSION(max_domains) :: auxhist12_interval_y
integer , DIMENSION(max_domains) :: auxhist12_interval_d
integer , DIMENSION(max_domains) :: auxhist12_interval_h
integer , DIMENSION(max_domains) :: auxhist12_interval_m
integer , DIMENSION(max_domains) :: auxhist12_interval_s
integer , DIMENSION(max_domains) :: auxhist12_interval
integer , DIMENSION(max_domains) :: auxhist12_begin_y
integer , DIMENSION(max_domains) :: auxhist12_begin_d
integer , DIMENSION(max_domains) :: auxhist12_begin_h
integer , DIMENSION(max_domains) :: auxhist12_begin_m
integer , DIMENSION(max_domains) :: auxhist12_begin_s
integer , DIMENSION(max_domains) :: auxhist12_begin
integer , DIMENSION(max_domains) :: auxhist12_end_y
integer , DIMENSION(max_domains) :: auxhist12_end_d
integer , DIMENSION(max_domains) :: auxhist12_end_h
integer , DIMENSION(max_domains) :: auxhist12_end_m
integer , DIMENSION(max_domains) :: auxhist12_end_s
integer , DIMENSION(max_domains) :: auxhist12_end
integer :: io_form_auxhist12
integer , DIMENSION(max_domains) :: frames_per_auxhist12
character*256 :: auxhist13_inname
character*256 :: auxhist13_outname
integer , DIMENSION(max_domains) :: auxhist13_interval_y
integer , DIMENSION(max_domains) :: auxhist13_interval_d
integer , DIMENSION(max_domains) :: auxhist13_interval_h
integer , DIMENSION(max_domains) :: auxhist13_interval_m
integer , DIMENSION(max_domains) :: auxhist13_interval_s
integer , DIMENSION(max_domains) :: auxhist13_interval
integer , DIMENSION(max_domains) :: auxhist13_begin_y
integer , DIMENSION(max_domains) :: auxhist13_begin_d
integer , DIMENSION(max_domains) :: auxhist13_begin_h
integer , DIMENSION(max_domains) :: auxhist13_begin_m
integer , DIMENSION(max_domains) :: auxhist13_begin_s
integer , DIMENSION(max_domains) :: auxhist13_begin
integer , DIMENSION(max_domains) :: auxhist13_end_y
integer , DIMENSION(max_domains) :: auxhist13_end_d
integer , DIMENSION(max_domains) :: auxhist13_end_h
integer , DIMENSION(max_domains) :: auxhist13_end_m
integer , DIMENSION(max_domains) :: auxhist13_end_s
integer , DIMENSION(max_domains) :: auxhist13_end
integer :: io_form_auxhist13
integer , DIMENSION(max_domains) :: frames_per_auxhist13
character*256 :: auxhist14_inname
character*256 :: auxhist14_outname
integer , DIMENSION(max_domains) :: auxhist14_interval_y
integer , DIMENSION(max_domains) :: auxhist14_interval_d
integer , DIMENSION(max_domains) :: auxhist14_interval_h
integer , DIMENSION(max_domains) :: auxhist14_interval_m
integer , DIMENSION(max_domains) :: auxhist14_interval_s
integer , DIMENSION(max_domains) :: auxhist14_interval
integer , DIMENSION(max_domains) :: auxhist14_begin_y
integer , DIMENSION(max_domains) :: auxhist14_begin_d
integer , DIMENSION(max_domains) :: auxhist14_begin_h
integer , DIMENSION(max_domains) :: auxhist14_begin_m
integer , DIMENSION(max_domains) :: auxhist14_begin_s
integer , DIMENSION(max_domains) :: auxhist14_begin
integer , DIMENSION(max_domains) :: auxhist14_end_y
integer , DIMENSION(max_domains) :: auxhist14_end_d
integer , DIMENSION(max_domains) :: auxhist14_end_h
integer , DIMENSION(max_domains) :: auxhist14_end_m
integer , DIMENSION(max_domains) :: auxhist14_end_s
integer , DIMENSION(max_domains) :: auxhist14_end
integer :: io_form_auxhist14
integer , DIMENSION(max_domains) :: frames_per_auxhist14
character*256 :: auxhist15_inname
character*256 :: auxhist15_outname
integer , DIMENSION(max_domains) :: auxhist15_interval_y
integer , DIMENSION(max_domains) :: auxhist15_interval_d
integer , DIMENSION(max_domains) :: auxhist15_interval_h
integer , DIMENSION(max_domains) :: auxhist15_interval_m
integer , DIMENSION(max_domains) :: auxhist15_interval_s
integer , DIMENSION(max_domains) :: auxhist15_interval
integer , DIMENSION(max_domains) :: auxhist15_begin_y
integer , DIMENSION(max_domains) :: auxhist15_begin_d
integer , DIMENSION(max_domains) :: auxhist15_begin_h
integer , DIMENSION(max_domains) :: auxhist15_begin_m
integer , DIMENSION(max_domains) :: auxhist15_begin_s
integer , DIMENSION(max_domains) :: auxhist15_begin
integer , DIMENSION(max_domains) :: auxhist15_end_y
integer , DIMENSION(max_domains) :: auxhist15_end_d
integer , DIMENSION(max_domains) :: auxhist15_end_h
integer , DIMENSION(max_domains) :: auxhist15_end_m
integer , DIMENSION(max_domains) :: auxhist15_end_s
integer , DIMENSION(max_domains) :: auxhist15_end
integer :: io_form_auxhist15
integer , DIMENSION(max_domains) :: frames_per_auxhist15
character*256 :: auxhist16_inname
character*256 :: auxhist16_outname
integer , DIMENSION(max_domains) :: auxhist16_interval_y
integer , DIMENSION(max_domains) :: auxhist16_interval_d
integer , DIMENSION(max_domains) :: auxhist16_interval_h
integer , DIMENSION(max_domains) :: auxhist16_interval_m
integer , DIMENSION(max_domains) :: auxhist16_interval_s
integer , DIMENSION(max_domains) :: auxhist16_interval
integer , DIMENSION(max_domains) :: auxhist16_begin_y
integer , DIMENSION(max_domains) :: auxhist16_begin_d
integer , DIMENSION(max_domains) :: auxhist16_begin_h
integer , DIMENSION(max_domains) :: auxhist16_begin_m
integer , DIMENSION(max_domains) :: auxhist16_begin_s
integer , DIMENSION(max_domains) :: auxhist16_begin
integer , DIMENSION(max_domains) :: auxhist16_end_y
integer , DIMENSION(max_domains) :: auxhist16_end_d
integer , DIMENSION(max_domains) :: auxhist16_end_h
integer , DIMENSION(max_domains) :: auxhist16_end_m
integer , DIMENSION(max_domains) :: auxhist16_end_s
integer , DIMENSION(max_domains) :: auxhist16_end
integer :: io_form_auxhist16
integer , DIMENSION(max_domains) :: frames_per_auxhist16
character*256 :: auxhist17_inname
character*256 :: auxhist17_outname
integer , DIMENSION(max_domains) :: auxhist17_interval_y
integer , DIMENSION(max_domains) :: auxhist17_interval_d
integer , DIMENSION(max_domains) :: auxhist17_interval_h
integer , DIMENSION(max_domains) :: auxhist17_interval_m
integer , DIMENSION(max_domains) :: auxhist17_interval_s
integer , DIMENSION(max_domains) :: auxhist17_interval
integer , DIMENSION(max_domains) :: auxhist17_begin_y
integer , DIMENSION(max_domains) :: auxhist17_begin_d
integer , DIMENSION(max_domains) :: auxhist17_begin_h
integer , DIMENSION(max_domains) :: auxhist17_begin_m
integer , DIMENSION(max_domains) :: auxhist17_begin_s
integer , DIMENSION(max_domains) :: auxhist17_begin
integer , DIMENSION(max_domains) :: auxhist17_end_y
integer , DIMENSION(max_domains) :: auxhist17_end_d
integer , DIMENSION(max_domains) :: auxhist17_end_h
integer , DIMENSION(max_domains) :: auxhist17_end_m
integer , DIMENSION(max_domains) :: auxhist17_end_s
integer , DIMENSION(max_domains) :: auxhist17_end
integer :: io_form_auxhist17
integer , DIMENSION(max_domains) :: frames_per_auxhist17
character*256 :: auxhist18_inname
character*256 :: auxhist18_outname
integer , DIMENSION(max_domains) :: auxhist18_interval_y
integer , DIMENSION(max_domains) :: auxhist18_interval_d
integer , DIMENSION(max_domains) :: auxhist18_interval_h
integer , DIMENSION(max_domains) :: auxhist18_interval_m
integer , DIMENSION(max_domains) :: auxhist18_interval_s
integer , DIMENSION(max_domains) :: auxhist18_interval
integer , DIMENSION(max_domains) :: auxhist18_begin_y
integer , DIMENSION(max_domains) :: auxhist18_begin_d
integer , DIMENSION(max_domains) :: auxhist18_begin_h
integer , DIMENSION(max_domains) :: auxhist18_begin_m
integer , DIMENSION(max_domains) :: auxhist18_begin_s
integer , DIMENSION(max_domains) :: auxhist18_begin
integer , DIMENSION(max_domains) :: auxhist18_end_y
integer , DIMENSION(max_domains) :: auxhist18_end_d
integer , DIMENSION(max_domains) :: auxhist18_end_h
integer , DIMENSION(max_domains) :: auxhist18_end_m
integer , DIMENSION(max_domains) :: auxhist18_end_s
integer , DIMENSION(max_domains) :: auxhist18_end
integer :: io_form_auxhist18
integer , DIMENSION(max_domains) :: frames_per_auxhist18
character*256 :: auxhist19_inname
character*256 :: auxhist19_outname
integer , DIMENSION(max_domains) :: auxhist19_interval_y
integer , DIMENSION(max_domains) :: auxhist19_interval_d
integer , DIMENSION(max_domains) :: auxhist19_interval_h
integer , DIMENSION(max_domains) :: auxhist19_interval_m
integer , DIMENSION(max_domains) :: auxhist19_interval_s
integer , DIMENSION(max_domains) :: auxhist19_interval
integer , DIMENSION(max_domains) :: auxhist19_begin_y
integer , DIMENSION(max_domains) :: auxhist19_begin_d
integer , DIMENSION(max_domains) :: auxhist19_begin_h
integer , DIMENSION(max_domains) :: auxhist19_begin_m
integer , DIMENSION(max_domains) :: auxhist19_begin_s
integer , DIMENSION(max_domains) :: auxhist19_begin
integer , DIMENSION(max_domains) :: auxhist19_end_y
integer , DIMENSION(max_domains) :: auxhist19_end_d
integer , DIMENSION(max_domains) :: auxhist19_end_h
integer , DIMENSION(max_domains) :: auxhist19_end_m
integer , DIMENSION(max_domains) :: auxhist19_end_s
integer , DIMENSION(max_domains) :: auxhist19_end
integer :: io_form_auxhist19
integer , DIMENSION(max_domains) :: frames_per_auxhist19
character*256 :: auxhist20_inname
character*256 :: auxhist20_outname
integer , DIMENSION(max_domains) :: auxhist20_interval_y
integer , DIMENSION(max_domains) :: auxhist20_interval_d
integer , DIMENSION(max_domains) :: auxhist20_interval_h
integer , DIMENSION(max_domains) :: auxhist20_interval_m
integer , DIMENSION(max_domains) :: auxhist20_interval_s
integer , DIMENSION(max_domains) :: auxhist20_interval
integer , DIMENSION(max_domains) :: auxhist20_begin_y
integer , DIMENSION(max_domains) :: auxhist20_begin_d
integer , DIMENSION(max_domains) :: auxhist20_begin_h
integer , DIMENSION(max_domains) :: auxhist20_begin_m
integer , DIMENSION(max_domains) :: auxhist20_begin_s
integer , DIMENSION(max_domains) :: auxhist20_begin
integer , DIMENSION(max_domains) :: auxhist20_end_y
integer , DIMENSION(max_domains) :: auxhist20_end_d
integer , DIMENSION(max_domains) :: auxhist20_end_h
integer , DIMENSION(max_domains) :: auxhist20_end_m
integer , DIMENSION(max_domains) :: auxhist20_end_s
integer , DIMENSION(max_domains) :: auxhist20_end
integer :: io_form_auxhist20
integer , DIMENSION(max_domains) :: frames_per_auxhist20
character*256 :: auxhist21_inname
character*256 :: auxhist21_outname
integer , DIMENSION(max_domains) :: auxhist21_interval_y
integer , DIMENSION(max_domains) :: auxhist21_interval_d
integer , DIMENSION(max_domains) :: auxhist21_interval_h
integer , DIMENSION(max_domains) :: auxhist21_interval_m
integer , DIMENSION(max_domains) :: auxhist21_interval_s
integer , DIMENSION(max_domains) :: auxhist21_interval
integer , DIMENSION(max_domains) :: auxhist21_begin_y
integer , DIMENSION(max_domains) :: auxhist21_begin_d
integer , DIMENSION(max_domains) :: auxhist21_begin_h
integer , DIMENSION(max_domains) :: auxhist21_begin_m
integer , DIMENSION(max_domains) :: auxhist21_begin_s
integer , DIMENSION(max_domains) :: auxhist21_begin
integer , DIMENSION(max_domains) :: auxhist21_end_y
integer , DIMENSION(max_domains) :: auxhist21_end_d
integer , DIMENSION(max_domains) :: auxhist21_end_h
integer , DIMENSION(max_domains) :: auxhist21_end_m
integer , DIMENSION(max_domains) :: auxhist21_end_s
integer , DIMENSION(max_domains) :: auxhist21_end
integer :: io_form_auxhist21
integer , DIMENSION(max_domains) :: frames_per_auxhist21
character*256 :: auxhist22_inname
character*256 :: auxhist22_outname
integer , DIMENSION(max_domains) :: auxhist22_interval_y
integer , DIMENSION(max_domains) :: auxhist22_interval_d
integer , DIMENSION(max_domains) :: auxhist22_interval_h
integer , DIMENSION(max_domains) :: auxhist22_interval_m
integer , DIMENSION(max_domains) :: auxhist22_interval_s
integer , DIMENSION(max_domains) :: auxhist22_interval
integer , DIMENSION(max_domains) :: auxhist22_begin_y
integer , DIMENSION(max_domains) :: auxhist22_begin_d
integer , DIMENSION(max_domains) :: auxhist22_begin_h
integer , DIMENSION(max_domains) :: auxhist22_begin_m
integer , DIMENSION(max_domains) :: auxhist22_begin_s
integer , DIMENSION(max_domains) :: auxhist22_begin
integer , DIMENSION(max_domains) :: auxhist22_end_y
integer , DIMENSION(max_domains) :: auxhist22_end_d
integer , DIMENSION(max_domains) :: auxhist22_end_h
integer , DIMENSION(max_domains) :: auxhist22_end_m
integer , DIMENSION(max_domains) :: auxhist22_end_s
integer , DIMENSION(max_domains) :: auxhist22_end
integer :: io_form_auxhist22
integer , DIMENSION(max_domains) :: frames_per_auxhist22
character*256 :: auxhist23_inname
character*256 :: auxhist23_outname
integer , DIMENSION(max_domains) :: auxhist23_interval_y
integer , DIMENSION(max_domains) :: auxhist23_interval_d
integer , DIMENSION(max_domains) :: auxhist23_interval_h
integer , DIMENSION(max_domains) :: auxhist23_interval_m
integer , DIMENSION(max_domains) :: auxhist23_interval_s
integer , DIMENSION(max_domains) :: auxhist23_interval
integer , DIMENSION(max_domains) :: auxhist23_begin_y
integer , DIMENSION(max_domains) :: auxhist23_begin_d
integer , DIMENSION(max_domains) :: auxhist23_begin_h
integer , DIMENSION(max_domains) :: auxhist23_begin_m
integer , DIMENSION(max_domains) :: auxhist23_begin_s
integer , DIMENSION(max_domains) :: auxhist23_begin
integer , DIMENSION(max_domains) :: auxhist23_end_y
integer , DIMENSION(max_domains) :: auxhist23_end_d
integer , DIMENSION(max_domains) :: auxhist23_end_h
integer , DIMENSION(max_domains) :: auxhist23_end_m
integer , DIMENSION(max_domains) :: auxhist23_end_s
integer , DIMENSION(max_domains) :: auxhist23_end
integer :: io_form_auxhist23
integer , DIMENSION(max_domains) :: frames_per_auxhist23
character*256 :: auxhist24_inname
character*256 :: auxhist24_outname
integer , DIMENSION(max_domains) :: auxhist24_interval_y
integer , DIMENSION(max_domains) :: auxhist24_interval_d
integer , DIMENSION(max_domains) :: auxhist24_interval_h
integer , DIMENSION(max_domains) :: auxhist24_interval_m
integer , DIMENSION(max_domains) :: auxhist24_interval_s
integer , DIMENSION(max_domains) :: auxhist24_interval
integer , DIMENSION(max_domains) :: auxhist24_begin_y
integer , DIMENSION(max_domains) :: auxhist24_begin_d
integer , DIMENSION(max_domains) :: auxhist24_begin_h
integer , DIMENSION(max_domains) :: auxhist24_begin_m
integer , DIMENSION(max_domains) :: auxhist24_begin_s
integer , DIMENSION(max_domains) :: auxhist24_begin
integer , DIMENSION(max_domains) :: auxhist24_end_y
integer , DIMENSION(max_domains) :: auxhist24_end_d
integer , DIMENSION(max_domains) :: auxhist24_end_h
integer , DIMENSION(max_domains) :: auxhist24_end_m
integer , DIMENSION(max_domains) :: auxhist24_end_s
integer , DIMENSION(max_domains) :: auxhist24_end
integer :: io_form_auxhist24
integer , DIMENSION(max_domains) :: frames_per_auxhist24
character*256 :: auxinput1_outname
integer , DIMENSION(max_domains) :: auxinput1_interval_y
integer , DIMENSION(max_domains) :: auxinput1_interval_d
integer , DIMENSION(max_domains) :: auxinput1_interval_h
integer , DIMENSION(max_domains) :: auxinput1_interval_m
integer , DIMENSION(max_domains) :: auxinput1_interval_s
integer , DIMENSION(max_domains) :: auxinput1_interval
integer , DIMENSION(max_domains) :: auxinput1_begin_y
integer , DIMENSION(max_domains) :: auxinput1_begin_d
integer , DIMENSION(max_domains) :: auxinput1_begin_h
integer , DIMENSION(max_domains) :: auxinput1_begin_m
integer , DIMENSION(max_domains) :: auxinput1_begin_s
integer , DIMENSION(max_domains) :: auxinput1_begin
integer , DIMENSION(max_domains) :: auxinput1_end_y
integer , DIMENSION(max_domains) :: auxinput1_end_d
integer , DIMENSION(max_domains) :: auxinput1_end_h
integer , DIMENSION(max_domains) :: auxinput1_end_m
integer , DIMENSION(max_domains) :: auxinput1_end_s
integer , DIMENSION(max_domains) :: auxinput1_end
integer , DIMENSION(max_domains) :: frames_per_auxinput1
character*256 :: auxinput2_inname
character*256 :: auxinput2_outname
integer , DIMENSION(max_domains) :: auxinput2_interval_y
integer , DIMENSION(max_domains) :: auxinput2_interval_d
integer , DIMENSION(max_domains) :: auxinput2_interval_h
integer , DIMENSION(max_domains) :: auxinput2_interval_m
integer , DIMENSION(max_domains) :: auxinput2_interval_s
integer , DIMENSION(max_domains) :: auxinput2_interval
integer , DIMENSION(max_domains) :: auxinput2_begin_y
integer , DIMENSION(max_domains) :: auxinput2_begin_d
integer , DIMENSION(max_domains) :: auxinput2_begin_h
integer , DIMENSION(max_domains) :: auxinput2_begin_m
integer , DIMENSION(max_domains) :: auxinput2_begin_s
integer , DIMENSION(max_domains) :: auxinput2_begin
integer , DIMENSION(max_domains) :: auxinput2_end_y
integer , DIMENSION(max_domains) :: auxinput2_end_d
integer , DIMENSION(max_domains) :: auxinput2_end_h
integer , DIMENSION(max_domains) :: auxinput2_end_m
integer , DIMENSION(max_domains) :: auxinput2_end_s
integer , DIMENSION(max_domains) :: auxinput2_end
integer :: io_form_auxinput2
integer , DIMENSION(max_domains) :: frames_per_auxinput2
character*256 :: auxinput3_inname
character*256 :: auxinput3_outname
integer , DIMENSION(max_domains) :: auxinput3_interval_y
integer , DIMENSION(max_domains) :: auxinput3_interval_d
integer , DIMENSION(max_domains) :: auxinput3_interval_h
integer , DIMENSION(max_domains) :: auxinput3_interval_m
integer , DIMENSION(max_domains) :: auxinput3_interval_s
integer , DIMENSION(max_domains) :: auxinput3_interval
integer , DIMENSION(max_domains) :: auxinput3_begin_y
integer , DIMENSION(max_domains) :: auxinput3_begin_d
integer , DIMENSION(max_domains) :: auxinput3_begin_h
integer , DIMENSION(max_domains) :: auxinput3_begin_m
integer , DIMENSION(max_domains) :: auxinput3_begin_s
integer , DIMENSION(max_domains) :: auxinput3_begin
integer , DIMENSION(max_domains) :: auxinput3_end_y
integer , DIMENSION(max_domains) :: auxinput3_end_d
integer , DIMENSION(max_domains) :: auxinput3_end_h
integer , DIMENSION(max_domains) :: auxinput3_end_m
integer , DIMENSION(max_domains) :: auxinput3_end_s
integer , DIMENSION(max_domains) :: auxinput3_end
integer :: io_form_auxinput3
integer , DIMENSION(max_domains) :: frames_per_auxinput3
character*256 :: auxinput4_inname
character*256 :: auxinput4_outname
integer , DIMENSION(max_domains) :: auxinput4_interval_y
integer , DIMENSION(max_domains) :: auxinput4_interval_d
integer , DIMENSION(max_domains) :: auxinput4_interval_h
integer , DIMENSION(max_domains) :: auxinput4_interval_m
integer , DIMENSION(max_domains) :: auxinput4_interval_s
integer , DIMENSION(max_domains) :: auxinput4_interval
integer , DIMENSION(max_domains) :: auxinput4_begin_y
integer , DIMENSION(max_domains) :: auxinput4_begin_d
integer , DIMENSION(max_domains) :: auxinput4_begin_h
integer , DIMENSION(max_domains) :: auxinput4_begin_m
integer , DIMENSION(max_domains) :: auxinput4_begin_s
integer , DIMENSION(max_domains) :: auxinput4_begin
integer , DIMENSION(max_domains) :: auxinput4_end_y
integer , DIMENSION(max_domains) :: auxinput4_end_d
integer , DIMENSION(max_domains) :: auxinput4_end_h
integer , DIMENSION(max_domains) :: auxinput4_end_m
integer , DIMENSION(max_domains) :: auxinput4_end_s
integer , DIMENSION(max_domains) :: auxinput4_end
integer :: io_form_auxinput4
integer , DIMENSION(max_domains) :: frames_per_auxinput4
character*256 :: auxinput5_inname
character*256 :: auxinput5_outname
integer , DIMENSION(max_domains) :: auxinput5_interval_y
integer , DIMENSION(max_domains) :: auxinput5_interval_d
integer , DIMENSION(max_domains) :: auxinput5_interval_h
integer , DIMENSION(max_domains) :: auxinput5_interval_m
integer , DIMENSION(max_domains) :: auxinput5_interval_s
integer , DIMENSION(max_domains) :: auxinput5_interval
integer , DIMENSION(max_domains) :: auxinput5_begin_y
integer , DIMENSION(max_domains) :: auxinput5_begin_d
integer , DIMENSION(max_domains) :: auxinput5_begin_h
integer , DIMENSION(max_domains) :: auxinput5_begin_m
integer , DIMENSION(max_domains) :: auxinput5_begin_s
integer , DIMENSION(max_domains) :: auxinput5_begin
integer , DIMENSION(max_domains) :: auxinput5_end_y
integer , DIMENSION(max_domains) :: auxinput5_end_d
integer , DIMENSION(max_domains) :: auxinput5_end_h
integer , DIMENSION(max_domains) :: auxinput5_end_m
integer , DIMENSION(max_domains) :: auxinput5_end_s
integer , DIMENSION(max_domains) :: auxinput5_end
integer :: io_form_auxinput5
integer , DIMENSION(max_domains) :: frames_per_auxinput5
character*256 :: auxinput6_inname
character*256 :: auxinput6_outname
integer , DIMENSION(max_domains) :: auxinput6_interval_y
integer , DIMENSION(max_domains) :: auxinput6_interval_d
integer , DIMENSION(max_domains) :: auxinput6_interval_h
integer , DIMENSION(max_domains) :: auxinput6_interval_m
integer , DIMENSION(max_domains) :: auxinput6_interval_s
integer , DIMENSION(max_domains) :: auxinput6_interval
integer , DIMENSION(max_domains) :: auxinput6_begin_y
integer , DIMENSION(max_domains) :: auxinput6_begin_d
integer , DIMENSION(max_domains) :: auxinput6_begin_h
integer , DIMENSION(max_domains) :: auxinput6_begin_m
integer , DIMENSION(max_domains) :: auxinput6_begin_s
integer , DIMENSION(max_domains) :: auxinput6_begin
integer , DIMENSION(max_domains) :: auxinput6_end_y
integer , DIMENSION(max_domains) :: auxinput6_end_d
integer , DIMENSION(max_domains) :: auxinput6_end_h
integer , DIMENSION(max_domains) :: auxinput6_end_m
integer , DIMENSION(max_domains) :: auxinput6_end_s
integer , DIMENSION(max_domains) :: auxinput6_end
integer :: io_form_auxinput6
integer , DIMENSION(max_domains) :: frames_per_auxinput6
character*256 :: auxinput7_inname
character*256 :: auxinput7_outname
integer , DIMENSION(max_domains) :: auxinput7_interval_y
integer , DIMENSION(max_domains) :: auxinput7_interval_d
integer , DIMENSION(max_domains) :: auxinput7_interval_h
integer , DIMENSION(max_domains) :: auxinput7_interval_m
integer , DIMENSION(max_domains) :: auxinput7_interval_s
integer , DIMENSION(max_domains) :: auxinput7_interval
integer , DIMENSION(max_domains) :: auxinput7_begin_y
integer , DIMENSION(max_domains) :: auxinput7_begin_d
integer , DIMENSION(max_domains) :: auxinput7_begin_h
integer , DIMENSION(max_domains) :: auxinput7_begin_m
integer , DIMENSION(max_domains) :: auxinput7_begin_s
integer , DIMENSION(max_domains) :: auxinput7_begin
integer , DIMENSION(max_domains) :: auxinput7_end_y
integer , DIMENSION(max_domains) :: auxinput7_end_d
integer , DIMENSION(max_domains) :: auxinput7_end_h
integer , DIMENSION(max_domains) :: auxinput7_end_m
integer , DIMENSION(max_domains) :: auxinput7_end_s
integer , DIMENSION(max_domains) :: auxinput7_end
integer :: io_form_auxinput7
integer , DIMENSION(max_domains) :: frames_per_auxinput7
character*256 :: auxinput8_inname
character*256 :: auxinput8_outname
integer , DIMENSION(max_domains) :: auxinput8_interval_y
integer , DIMENSION(max_domains) :: auxinput8_interval_d
integer , DIMENSION(max_domains) :: auxinput8_interval_h
integer , DIMENSION(max_domains) :: auxinput8_interval_m
integer , DIMENSION(max_domains) :: auxinput8_interval_s
integer , DIMENSION(max_domains) :: auxinput8_interval
integer , DIMENSION(max_domains) :: auxinput8_begin_y
integer , DIMENSION(max_domains) :: auxinput8_begin_d
integer , DIMENSION(max_domains) :: auxinput8_begin_h
integer , DIMENSION(max_domains) :: auxinput8_begin_m
integer , DIMENSION(max_domains) :: auxinput8_begin_s
integer , DIMENSION(max_domains) :: auxinput8_begin
integer , DIMENSION(max_domains) :: auxinput8_end_y
integer , DIMENSION(max_domains) :: auxinput8_end_d
integer , DIMENSION(max_domains) :: auxinput8_end_h
integer , DIMENSION(max_domains) :: auxinput8_end_m
integer , DIMENSION(max_domains) :: auxinput8_end_s
integer , DIMENSION(max_domains) :: auxinput8_end
integer :: io_form_auxinput8
integer , DIMENSION(max_domains) :: frames_per_auxinput8
character*256 :: auxinput9_inname
character*256 :: auxinput9_outname
integer , DIMENSION(max_domains) :: auxinput9_interval_y
integer , DIMENSION(max_domains) :: auxinput9_interval_d
integer , DIMENSION(max_domains) :: auxinput9_interval_h
integer , DIMENSION(max_domains) :: auxinput9_interval_m
integer , DIMENSION(max_domains) :: auxinput9_interval_s
integer , DIMENSION(max_domains) :: auxinput9_interval
integer , DIMENSION(max_domains) :: auxinput9_begin_y
integer , DIMENSION(max_domains) :: auxinput9_begin_d
integer , DIMENSION(max_domains) :: auxinput9_begin_h
integer , DIMENSION(max_domains) :: auxinput9_begin_m
integer , DIMENSION(max_domains) :: auxinput9_begin_s
integer , DIMENSION(max_domains) :: auxinput9_begin
integer , DIMENSION(max_domains) :: auxinput9_end_y
integer , DIMENSION(max_domains) :: auxinput9_end_d
integer , DIMENSION(max_domains) :: auxinput9_end_h
integer , DIMENSION(max_domains) :: auxinput9_end_m
integer , DIMENSION(max_domains) :: auxinput9_end_s
integer , DIMENSION(max_domains) :: auxinput9_end
integer :: io_form_auxinput9
integer , DIMENSION(max_domains) :: frames_per_auxinput9
character*256 :: auxinput10_inname
character*256 :: auxinput10_outname
integer , DIMENSION(max_domains) :: auxinput10_interval_y
integer , DIMENSION(max_domains) :: auxinput10_interval_d
integer , DIMENSION(max_domains) :: auxinput10_interval_h
integer , DIMENSION(max_domains) :: auxinput10_interval_m
integer , DIMENSION(max_domains) :: auxinput10_interval_s
integer , DIMENSION(max_domains) :: auxinput10_interval
integer , DIMENSION(max_domains) :: auxinput10_begin_y
integer , DIMENSION(max_domains) :: auxinput10_begin_d
integer , DIMENSION(max_domains) :: auxinput10_begin_h
integer , DIMENSION(max_domains) :: auxinput10_begin_m
integer , DIMENSION(max_domains) :: auxinput10_begin_s
integer , DIMENSION(max_domains) :: auxinput10_begin
integer , DIMENSION(max_domains) :: auxinput10_end_y
integer , DIMENSION(max_domains) :: auxinput10_end_d
integer , DIMENSION(max_domains) :: auxinput10_end_h
integer , DIMENSION(max_domains) :: auxinput10_end_m
integer , DIMENSION(max_domains) :: auxinput10_end_s
integer , DIMENSION(max_domains) :: auxinput10_end
integer :: io_form_auxinput10
integer , DIMENSION(max_domains) :: frames_per_auxinput10
character*256 :: auxinput11_inname
character*256 :: auxinput11_outname
integer , DIMENSION(max_domains) :: auxinput11_interval_y
integer , DIMENSION(max_domains) :: auxinput11_interval_d
integer , DIMENSION(max_domains) :: auxinput11_interval_h
integer , DIMENSION(max_domains) :: auxinput11_interval_m
integer , DIMENSION(max_domains) :: auxinput11_interval_s
integer , DIMENSION(max_domains) :: auxinput11_interval
integer , DIMENSION(max_domains) :: auxinput11_begin_y
integer , DIMENSION(max_domains) :: auxinput11_begin_d
integer , DIMENSION(max_domains) :: auxinput11_begin_h
integer , DIMENSION(max_domains) :: auxinput11_begin_m
integer , DIMENSION(max_domains) :: auxinput11_begin_s
integer , DIMENSION(max_domains) :: auxinput11_begin
integer , DIMENSION(max_domains) :: auxinput11_end_y
integer , DIMENSION(max_domains) :: auxinput11_end_d
integer , DIMENSION(max_domains) :: auxinput11_end_h
integer , DIMENSION(max_domains) :: auxinput11_end_m
integer , DIMENSION(max_domains) :: auxinput11_end_s
integer , DIMENSION(max_domains) :: auxinput11_end
integer :: io_form_auxinput11
integer , DIMENSION(max_domains) :: frames_per_auxinput11
character*256 :: auxinput12_inname
character*256 :: auxinput12_outname
integer , DIMENSION(max_domains) :: auxinput12_interval_y
integer , DIMENSION(max_domains) :: auxinput12_interval_d
integer , DIMENSION(max_domains) :: auxinput12_interval_h
integer , DIMENSION(max_domains) :: auxinput12_interval_m
integer , DIMENSION(max_domains) :: auxinput12_interval_s
integer , DIMENSION(max_domains) :: auxinput12_interval
integer , DIMENSION(max_domains) :: auxinput12_begin_y
integer , DIMENSION(max_domains) :: auxinput12_begin_d
integer , DIMENSION(max_domains) :: auxinput12_begin_h
integer , DIMENSION(max_domains) :: auxinput12_begin_m
integer , DIMENSION(max_domains) :: auxinput12_begin_s
integer , DIMENSION(max_domains) :: auxinput12_begin
integer , DIMENSION(max_domains) :: auxinput12_end_y
integer , DIMENSION(max_domains) :: auxinput12_end_d
integer , DIMENSION(max_domains) :: auxinput12_end_h
integer , DIMENSION(max_domains) :: auxinput12_end_m
integer , DIMENSION(max_domains) :: auxinput12_end_s
integer , DIMENSION(max_domains) :: auxinput12_end
integer :: io_form_auxinput12
integer , DIMENSION(max_domains) :: frames_per_auxinput12
character*256 :: auxinput13_inname
character*256 :: auxinput13_outname
integer , DIMENSION(max_domains) :: auxinput13_interval_y
integer , DIMENSION(max_domains) :: auxinput13_interval_d
integer , DIMENSION(max_domains) :: auxinput13_interval_h
integer , DIMENSION(max_domains) :: auxinput13_interval_m
integer , DIMENSION(max_domains) :: auxinput13_interval_s
integer , DIMENSION(max_domains) :: auxinput13_interval
integer , DIMENSION(max_domains) :: auxinput13_begin_y
integer , DIMENSION(max_domains) :: auxinput13_begin_d
integer , DIMENSION(max_domains) :: auxinput13_begin_h
integer , DIMENSION(max_domains) :: auxinput13_begin_m
integer , DIMENSION(max_domains) :: auxinput13_begin_s
integer , DIMENSION(max_domains) :: auxinput13_begin
integer , DIMENSION(max_domains) :: auxinput13_end_y
integer , DIMENSION(max_domains) :: auxinput13_end_d
integer , DIMENSION(max_domains) :: auxinput13_end_h
integer , DIMENSION(max_domains) :: auxinput13_end_m
integer , DIMENSION(max_domains) :: auxinput13_end_s
integer , DIMENSION(max_domains) :: auxinput13_end
integer :: io_form_auxinput13
integer , DIMENSION(max_domains) :: frames_per_auxinput13
character*256 :: auxinput14_inname
character*256 :: auxinput14_outname
integer , DIMENSION(max_domains) :: auxinput14_interval_y
integer , DIMENSION(max_domains) :: auxinput14_interval_d
integer , DIMENSION(max_domains) :: auxinput14_interval_h
integer , DIMENSION(max_domains) :: auxinput14_interval_m
integer , DIMENSION(max_domains) :: auxinput14_interval_s
integer , DIMENSION(max_domains) :: auxinput14_interval
integer , DIMENSION(max_domains) :: auxinput14_begin_y
integer , DIMENSION(max_domains) :: auxinput14_begin_d
integer , DIMENSION(max_domains) :: auxinput14_begin_h
integer , DIMENSION(max_domains) :: auxinput14_begin_m
integer , DIMENSION(max_domains) :: auxinput14_begin_s
integer , DIMENSION(max_domains) :: auxinput14_begin
integer , DIMENSION(max_domains) :: auxinput14_end_y
integer , DIMENSION(max_domains) :: auxinput14_end_d
integer , DIMENSION(max_domains) :: auxinput14_end_h
integer , DIMENSION(max_domains) :: auxinput14_end_m
integer , DIMENSION(max_domains) :: auxinput14_end_s
integer , DIMENSION(max_domains) :: auxinput14_end
integer :: io_form_auxinput14
integer , DIMENSION(max_domains) :: frames_per_auxinput14
character*256 :: auxinput15_inname
character*256 :: auxinput15_outname
integer , DIMENSION(max_domains) :: auxinput15_interval_y
integer , DIMENSION(max_domains) :: auxinput15_interval_d
integer , DIMENSION(max_domains) :: auxinput15_interval_h
integer , DIMENSION(max_domains) :: auxinput15_interval_m
integer , DIMENSION(max_domains) :: auxinput15_interval_s
integer , DIMENSION(max_domains) :: auxinput15_interval
integer , DIMENSION(max_domains) :: auxinput15_begin_y
integer , DIMENSION(max_domains) :: auxinput15_begin_d
integer , DIMENSION(max_domains) :: auxinput15_begin_h
integer , DIMENSION(max_domains) :: auxinput15_begin_m
integer , DIMENSION(max_domains) :: auxinput15_begin_s
integer , DIMENSION(max_domains) :: auxinput15_begin
integer , DIMENSION(max_domains) :: auxinput15_end_y
integer , DIMENSION(max_domains) :: auxinput15_end_d
integer , DIMENSION(max_domains) :: auxinput15_end_h
integer , DIMENSION(max_domains) :: auxinput15_end_m
integer , DIMENSION(max_domains) :: auxinput15_end_s
integer , DIMENSION(max_domains) :: auxinput15_end
integer :: io_form_auxinput15
integer , DIMENSION(max_domains) :: frames_per_auxinput15
character*256 :: auxinput16_inname
character*256 :: auxinput16_outname
integer , DIMENSION(max_domains) :: auxinput16_interval_y
integer , DIMENSION(max_domains) :: auxinput16_interval_d
integer , DIMENSION(max_domains) :: auxinput16_interval_h
integer , DIMENSION(max_domains) :: auxinput16_interval_m
integer , DIMENSION(max_domains) :: auxinput16_interval_s
integer , DIMENSION(max_domains) :: auxinput16_interval
integer , DIMENSION(max_domains) :: auxinput16_begin_y
integer , DIMENSION(max_domains) :: auxinput16_begin_d
integer , DIMENSION(max_domains) :: auxinput16_begin_h
integer , DIMENSION(max_domains) :: auxinput16_begin_m
integer , DIMENSION(max_domains) :: auxinput16_begin_s
integer , DIMENSION(max_domains) :: auxinput16_begin
integer , DIMENSION(max_domains) :: auxinput16_end_y
integer , DIMENSION(max_domains) :: auxinput16_end_d
integer , DIMENSION(max_domains) :: auxinput16_end_h
integer , DIMENSION(max_domains) :: auxinput16_end_m
integer , DIMENSION(max_domains) :: auxinput16_end_s
integer , DIMENSION(max_domains) :: auxinput16_end
integer :: io_form_auxinput16
integer , DIMENSION(max_domains) :: frames_per_auxinput16
character*256 :: auxinput17_inname
character*256 :: auxinput17_outname
integer , DIMENSION(max_domains) :: auxinput17_interval_y
integer , DIMENSION(max_domains) :: auxinput17_interval_d
integer , DIMENSION(max_domains) :: auxinput17_interval_h
integer , DIMENSION(max_domains) :: auxinput17_interval_m
integer , DIMENSION(max_domains) :: auxinput17_interval_s
integer , DIMENSION(max_domains) :: auxinput17_interval
integer , DIMENSION(max_domains) :: auxinput17_begin_y
integer , DIMENSION(max_domains) :: auxinput17_begin_d
integer , DIMENSION(max_domains) :: auxinput17_begin_h
integer , DIMENSION(max_domains) :: auxinput17_begin_m
integer , DIMENSION(max_domains) :: auxinput17_begin_s
integer , DIMENSION(max_domains) :: auxinput17_begin
integer , DIMENSION(max_domains) :: auxinput17_end_y
integer , DIMENSION(max_domains) :: auxinput17_end_d
integer , DIMENSION(max_domains) :: auxinput17_end_h
integer , DIMENSION(max_domains) :: auxinput17_end_m
integer , DIMENSION(max_domains) :: auxinput17_end_s
integer , DIMENSION(max_domains) :: auxinput17_end
integer :: io_form_auxinput17
integer , DIMENSION(max_domains) :: frames_per_auxinput17
character*256 :: auxinput18_inname
character*256 :: auxinput18_outname
integer , DIMENSION(max_domains) :: auxinput18_interval_y
integer , DIMENSION(max_domains) :: auxinput18_interval_d
integer , DIMENSION(max_domains) :: auxinput18_interval_h
integer , DIMENSION(max_domains) :: auxinput18_interval_m
integer , DIMENSION(max_domains) :: auxinput18_interval_s
integer , DIMENSION(max_domains) :: auxinput18_interval
integer , DIMENSION(max_domains) :: auxinput18_begin_y
integer , DIMENSION(max_domains) :: auxinput18_begin_d
integer , DIMENSION(max_domains) :: auxinput18_begin_h
integer , DIMENSION(max_domains) :: auxinput18_begin_m
integer , DIMENSION(max_domains) :: auxinput18_begin_s
integer , DIMENSION(max_domains) :: auxinput18_begin
integer , DIMENSION(max_domains) :: auxinput18_end_y
integer , DIMENSION(max_domains) :: auxinput18_end_d
integer , DIMENSION(max_domains) :: auxinput18_end_h
integer , DIMENSION(max_domains) :: auxinput18_end_m
integer , DIMENSION(max_domains) :: auxinput18_end_s
integer , DIMENSION(max_domains) :: auxinput18_end
integer :: io_form_auxinput18
integer , DIMENSION(max_domains) :: frames_per_auxinput18
character*256 :: auxinput19_inname
character*256 :: auxinput19_outname
integer , DIMENSION(max_domains) :: auxinput19_interval_y
integer , DIMENSION(max_domains) :: auxinput19_interval_d
integer , DIMENSION(max_domains) :: auxinput19_interval_h
integer , DIMENSION(max_domains) :: auxinput19_interval_m
integer , DIMENSION(max_domains) :: auxinput19_interval_s
integer , DIMENSION(max_domains) :: auxinput19_interval
integer , DIMENSION(max_domains) :: auxinput19_begin_y
integer , DIMENSION(max_domains) :: auxinput19_begin_d
integer , DIMENSION(max_domains) :: auxinput19_begin_h
integer , DIMENSION(max_domains) :: auxinput19_begin_m
integer , DIMENSION(max_domains) :: auxinput19_begin_s
integer , DIMENSION(max_domains) :: auxinput19_begin
integer , DIMENSION(max_domains) :: auxinput19_end_y
integer , DIMENSION(max_domains) :: auxinput19_end_d
integer , DIMENSION(max_domains) :: auxinput19_end_h
integer , DIMENSION(max_domains) :: auxinput19_end_m
integer , DIMENSION(max_domains) :: auxinput19_end_s
integer , DIMENSION(max_domains) :: auxinput19_end
integer :: io_form_auxinput19
integer , DIMENSION(max_domains) :: frames_per_auxinput19
character*256 :: auxinput20_inname
character*256 :: auxinput20_outname
integer , DIMENSION(max_domains) :: auxinput20_interval_y
integer , DIMENSION(max_domains) :: auxinput20_interval_d
integer , DIMENSION(max_domains) :: auxinput20_interval_h
integer , DIMENSION(max_domains) :: auxinput20_interval_m
integer , DIMENSION(max_domains) :: auxinput20_interval_s
integer , DIMENSION(max_domains) :: auxinput20_interval
integer , DIMENSION(max_domains) :: auxinput20_begin_y
integer , DIMENSION(max_domains) :: auxinput20_begin_d
integer , DIMENSION(max_domains) :: auxinput20_begin_h
integer , DIMENSION(max_domains) :: auxinput20_begin_m
integer , DIMENSION(max_domains) :: auxinput20_begin_s
integer , DIMENSION(max_domains) :: auxinput20_begin
integer , DIMENSION(max_domains) :: auxinput20_end_y
integer , DIMENSION(max_domains) :: auxinput20_end_d
integer , DIMENSION(max_domains) :: auxinput20_end_h
integer , DIMENSION(max_domains) :: auxinput20_end_m
integer , DIMENSION(max_domains) :: auxinput20_end_s
integer , DIMENSION(max_domains) :: auxinput20_end
integer :: io_form_auxinput20
integer , DIMENSION(max_domains) :: frames_per_auxinput20
character*256 :: auxinput21_inname
character*256 :: auxinput21_outname
integer , DIMENSION(max_domains) :: auxinput21_interval_y
integer , DIMENSION(max_domains) :: auxinput21_interval_d
integer , DIMENSION(max_domains) :: auxinput21_interval_h
integer , DIMENSION(max_domains) :: auxinput21_interval_m
integer , DIMENSION(max_domains) :: auxinput21_interval_s
integer , DIMENSION(max_domains) :: auxinput21_interval
integer , DIMENSION(max_domains) :: auxinput21_begin_y
integer , DIMENSION(max_domains) :: auxinput21_begin_d
integer , DIMENSION(max_domains) :: auxinput21_begin_h
integer , DIMENSION(max_domains) :: auxinput21_begin_m
integer , DIMENSION(max_domains) :: auxinput21_begin_s
integer , DIMENSION(max_domains) :: auxinput21_begin
integer , DIMENSION(max_domains) :: auxinput21_end_y
integer , DIMENSION(max_domains) :: auxinput21_end_d
integer , DIMENSION(max_domains) :: auxinput21_end_h
integer , DIMENSION(max_domains) :: auxinput21_end_m
integer , DIMENSION(max_domains) :: auxinput21_end_s
integer , DIMENSION(max_domains) :: auxinput21_end
integer :: io_form_auxinput21
integer , DIMENSION(max_domains) :: frames_per_auxinput21
character*256 :: auxinput22_inname
character*256 :: auxinput22_outname
integer , DIMENSION(max_domains) :: auxinput22_interval_y
integer , DIMENSION(max_domains) :: auxinput22_interval_d
integer , DIMENSION(max_domains) :: auxinput22_interval_h
integer , DIMENSION(max_domains) :: auxinput22_interval_m
integer , DIMENSION(max_domains) :: auxinput22_interval_s
integer , DIMENSION(max_domains) :: auxinput22_interval
integer , DIMENSION(max_domains) :: auxinput22_begin_y
integer , DIMENSION(max_domains) :: auxinput22_begin_d
integer , DIMENSION(max_domains) :: auxinput22_begin_h
integer , DIMENSION(max_domains) :: auxinput22_begin_m
integer , DIMENSION(max_domains) :: auxinput22_begin_s
integer , DIMENSION(max_domains) :: auxinput22_begin
integer , DIMENSION(max_domains) :: auxinput22_end_y
integer , DIMENSION(max_domains) :: auxinput22_end_d
integer , DIMENSION(max_domains) :: auxinput22_end_h
integer , DIMENSION(max_domains) :: auxinput22_end_m
integer , DIMENSION(max_domains) :: auxinput22_end_s
integer , DIMENSION(max_domains) :: auxinput22_end
integer :: io_form_auxinput22
integer , DIMENSION(max_domains) :: frames_per_auxinput22
character*256 :: auxinput23_inname
character*256 :: auxinput23_outname
integer , DIMENSION(max_domains) :: auxinput23_interval_y
integer , DIMENSION(max_domains) :: auxinput23_interval_d
integer , DIMENSION(max_domains) :: auxinput23_interval_h
integer , DIMENSION(max_domains) :: auxinput23_interval_m
integer , DIMENSION(max_domains) :: auxinput23_interval_s
integer , DIMENSION(max_domains) :: auxinput23_interval
integer , DIMENSION(max_domains) :: auxinput23_begin_y
integer , DIMENSION(max_domains) :: auxinput23_begin_d
integer , DIMENSION(max_domains) :: auxinput23_begin_h
integer , DIMENSION(max_domains) :: auxinput23_begin_m
integer , DIMENSION(max_domains) :: auxinput23_begin_s
integer , DIMENSION(max_domains) :: auxinput23_begin
integer , DIMENSION(max_domains) :: auxinput23_end_y
integer , DIMENSION(max_domains) :: auxinput23_end_d
integer , DIMENSION(max_domains) :: auxinput23_end_h
integer , DIMENSION(max_domains) :: auxinput23_end_m
integer , DIMENSION(max_domains) :: auxinput23_end_s
integer , DIMENSION(max_domains) :: auxinput23_end
integer :: io_form_auxinput23
integer , DIMENSION(max_domains) :: frames_per_auxinput23
character*256 :: auxinput24_inname
character*256 :: auxinput24_outname
integer , DIMENSION(max_domains) :: auxinput24_interval_y
integer , DIMENSION(max_domains) :: auxinput24_interval_d
integer , DIMENSION(max_domains) :: auxinput24_interval_h
integer , DIMENSION(max_domains) :: auxinput24_interval_m
integer , DIMENSION(max_domains) :: auxinput24_interval_s
integer , DIMENSION(max_domains) :: auxinput24_interval
integer , DIMENSION(max_domains) :: auxinput24_begin_y
integer , DIMENSION(max_domains) :: auxinput24_begin_d
integer , DIMENSION(max_domains) :: auxinput24_begin_h
integer , DIMENSION(max_domains) :: auxinput24_begin_m
integer , DIMENSION(max_domains) :: auxinput24_begin_s
integer , DIMENSION(max_domains) :: auxinput24_begin
integer , DIMENSION(max_domains) :: auxinput24_end_y
integer , DIMENSION(max_domains) :: auxinput24_end_d
integer , DIMENSION(max_domains) :: auxinput24_end_h
integer , DIMENSION(max_domains) :: auxinput24_end_m
integer , DIMENSION(max_domains) :: auxinput24_end_s
integer , DIMENSION(max_domains) :: auxinput24_end
integer :: io_form_auxinput24
integer , DIMENSION(max_domains) :: frames_per_auxinput24
integer , DIMENSION(max_domains) :: history_interval
integer , DIMENSION(max_domains) :: frames_per_outfile
logical :: restart
integer :: restart_interval
integer :: io_form_input
integer :: io_form_history
integer :: io_form_restart
integer :: io_form_boundary
integer :: debug_level
logical :: self_test_domain
character*256 :: history_outname
character*256 :: history_inname
logical :: use_netcdf_classic
integer , DIMENSION(max_domains) :: history_interval_d
integer , DIMENSION(max_domains) :: history_interval_h
integer , DIMENSION(max_domains) :: history_interval_m
integer , DIMENSION(max_domains) :: history_interval_s
integer , DIMENSION(max_domains) :: inputout_interval_d
integer , DIMENSION(max_domains) :: inputout_interval_h
integer , DIMENSION(max_domains) :: inputout_interval_m
integer , DIMENSION(max_domains) :: inputout_interval_s
integer , DIMENSION(max_domains) :: inputout_interval
integer :: restart_interval_d
integer :: restart_interval_h
integer :: restart_interval_m
integer :: restart_interval_s
integer , DIMENSION(max_domains) :: history_begin_y
integer , DIMENSION(max_domains) :: history_begin_d
integer , DIMENSION(max_domains) :: history_begin_h
integer , DIMENSION(max_domains) :: history_begin_m
integer , DIMENSION(max_domains) :: history_begin_s
integer , DIMENSION(max_domains) :: history_begin
integer , DIMENSION(max_domains) :: inputout_begin_y
integer , DIMENSION(max_domains) :: inputout_begin_d
integer , DIMENSION(max_domains) :: inputout_begin_h
integer , DIMENSION(max_domains) :: inputout_begin_m
integer , DIMENSION(max_domains) :: inputout_begin_s
integer :: restart_begin_y
integer :: restart_begin_d
integer :: restart_begin_h
integer :: restart_begin_m
integer :: restart_begin_s
integer :: restart_begin
integer , DIMENSION(max_domains) :: history_end_y
integer , DIMENSION(max_domains) :: history_end_d
integer , DIMENSION(max_domains) :: history_end_h
integer , DIMENSION(max_domains) :: history_end_m
integer , DIMENSION(max_domains) :: history_end_s
integer , DIMENSION(max_domains) :: history_end
integer , DIMENSION(max_domains) :: inputout_end_y
integer , DIMENSION(max_domains) :: inputout_end_d
integer , DIMENSION(max_domains) :: inputout_end_h
integer , DIMENSION(max_domains) :: inputout_end_m
integer , DIMENSION(max_domains) :: inputout_end_s
integer :: simulation_start_year
integer :: simulation_start_month
integer :: simulation_start_day
integer :: simulation_start_hour
integer :: simulation_start_minute
integer :: simulation_start_second
logical :: reset_simulation_start
integer , DIMENSION(max_domains) :: sr_x
integer , DIMENSION(max_domains) :: sr_y
character*256 :: sgfdda_inname
character*256 :: gfdda_inname
integer , DIMENSION(max_domains) :: sgfdda_interval_d
integer , DIMENSION(max_domains) :: sgfdda_interval_h
integer , DIMENSION(max_domains) :: sgfdda_interval_m
integer , DIMENSION(max_domains) :: sgfdda_interval_s
integer , DIMENSION(max_domains) :: sgfdda_interval_y
integer , DIMENSION(max_domains) :: sgfdda_interval
integer , DIMENSION(max_domains) :: gfdda_interval_d
integer , DIMENSION(max_domains) :: gfdda_interval_h
integer , DIMENSION(max_domains) :: gfdda_interval_m
integer , DIMENSION(max_domains) :: gfdda_interval_s
integer , DIMENSION(max_domains) :: gfdda_interval_y
integer , DIMENSION(max_domains) :: gfdda_interval
integer , DIMENSION(max_domains) :: sgfdda_begin_y
integer , DIMENSION(max_domains) :: sgfdda_begin_d
integer , DIMENSION(max_domains) :: sgfdda_begin_h
integer , DIMENSION(max_domains) :: sgfdda_begin_m
integer , DIMENSION(max_domains) :: sgfdda_begin_s
integer , DIMENSION(max_domains) :: gfdda_begin_y
integer , DIMENSION(max_domains) :: gfdda_begin_d
integer , DIMENSION(max_domains) :: gfdda_begin_h
integer , DIMENSION(max_domains) :: gfdda_begin_m
integer , DIMENSION(max_domains) :: gfdda_begin_s
integer , DIMENSION(max_domains) :: sgfdda_end_y
integer , DIMENSION(max_domains) :: sgfdda_end_d
integer , DIMENSION(max_domains) :: sgfdda_end_h
integer , DIMENSION(max_domains) :: sgfdda_end_m
integer , DIMENSION(max_domains) :: sgfdda_end_s
integer , DIMENSION(max_domains) :: gfdda_end_y
integer , DIMENSION(max_domains) :: gfdda_end_d
integer , DIMENSION(max_domains) :: gfdda_end_h
integer , DIMENSION(max_domains) :: gfdda_end_m
integer , DIMENSION(max_domains) :: gfdda_end_s
integer :: io_form_sgfdda
integer :: io_form_gfdda
character*256 , DIMENSION(max_domains) :: iofields_filename
logical :: ignore_iofields_warning
logical :: ncd_nofill
logical :: update_sfcdiags
logical :: use_wrf_sfcinfo
logical :: use_background_errors
logical :: write_increments
logical :: var4d
integer :: var4d_bin
integer :: var4d_bin_rain
logical :: var4d_lbc
integer :: multi_inc
logical :: print_detail_radar
logical :: print_detail_rain
logical :: print_detail_rad
logical :: print_detail_xa
logical :: print_detail_xb
logical :: print_detail_obs
logical :: print_detail_f_obs
logical :: print_detail_map
logical :: print_detail_grad
logical :: print_detail_regression
logical :: print_detail_spectral
logical :: print_detail_testing
logical :: print_detail_parallel
logical :: print_detail_be
logical :: print_detail_outerloop
logical :: check_max_iv_print
logical :: check_buddy_print
integer :: analysis_accu
logical :: calc_w_increment
logical :: dt_cloud_model
logical :: write_mod_filtered_obs
logical :: wind_sd
logical :: wind_sd_buoy
logical :: wind_sd_synop
logical :: wind_sd_ships
logical :: wind_sd_metar
logical :: wind_sd_sound
logical :: wind_sd_pilot
logical :: wind_sd_airep
logical :: wind_sd_qscat
logical :: wind_sd_tamdar
logical :: wind_sd_geoamv
logical :: wind_sd_mtgirs
logical :: wind_sd_polaramv
logical :: wind_sd_profiler
logical :: wind_stats_sd
logical :: qc_rej_both
integer :: fg_format
integer :: ob_format
integer :: ob_format_gpsro
integer :: num_fgat_time
logical :: thin_conv
logical :: thin_conv_ascii
real , DIMENSION(num_ob_indexes) :: thin_mesh_conv
logical :: thin_rainobs
logical :: use_synopobs
logical :: use_shipsobs
logical :: use_metarobs
logical :: use_soundobs
logical :: use_mtgirsobs
logical :: use_tamdarobs
logical :: use_pilotobs
logical :: use_airepobs
logical :: use_geoamvobs
logical :: use_polaramvobs
logical :: use_bogusobs
logical :: use_buoyobs
logical :: use_profilerobs
logical :: use_satemobs
logical :: use_gpsztdobs
logical :: use_gpspwobs
logical :: use_gpsrefobs
real :: top_km_gpsro
real :: bot_km_gpsro
logical :: use_ssmiretrievalobs
logical :: use_ssmitbobs
logical :: use_ssmt1obs
logical :: use_ssmt2obs
logical :: use_qscatobs
logical :: use_radarobs
logical :: use_radar_rv
logical :: use_radar_rf
logical :: use_radar_rqv
logical :: use_radar_rhv
logical :: use_3dvar_phy
logical :: use_rainobs
logical :: use_hirs2obs
logical :: use_hirs3obs
logical :: use_hirs4obs
logical :: use_mhsobs
logical :: use_msuobs
logical :: use_amsuaobs
logical :: use_amsubobs
logical :: use_airsobs
logical :: use_airsretobs
logical :: use_eos_amsuaobs
logical :: use_hsbobs
logical :: use_ssmisobs
logical :: use_iasiobs
logical :: use_seviriobs
logical :: use_amsr2obs
logical :: use_kma1dvar
logical :: use_filtered_rad
logical :: use_obs_errfac
logical :: use_atmsobs
logical :: use_mwtsobs
logical :: use_mwhsobs
logical :: check_max_iv
real :: max_error_t
real :: max_error_uv
real :: max_error_spd
real :: max_error_dir
real :: max_omb_spd
real :: max_omb_dir
real :: max_error_pw
real :: max_error_ref
real :: max_error_rh
real :: max_error_q
real :: max_error_p
real :: max_error_tb
real :: max_error_thickness
real :: max_error_rv
real :: max_error_rf
real :: max_error_rain
real :: max_error_buv
real :: max_error_bt
real :: max_error_bq
real :: max_error_slp
logical :: check_buddy
logical :: put_rand_seed
logical :: omb_set_rand
logical :: omb_add_noise
logical :: position_lev_dependant
integer :: obs_qc_pointer
integer :: qmarker_retain
integer :: max_sound_input
integer :: max_mtgirs_input
integer :: max_tamdar_input
integer :: max_synop_input
integer :: max_geoamv_input
integer :: max_polaramv_input
integer :: max_airep_input
integer :: max_satem_input
integer :: max_pilot_input
integer :: max_radar_input
integer :: max_rain_input
integer :: max_metar_input
integer :: max_gpspw_input
integer :: max_ships_input
integer :: max_profiler_input
integer :: max_bogus_input
integer :: max_buoy_input
integer :: max_ssmi_rv_input
integer :: max_ssmi_tb_input
integer :: max_ssmt1_input
integer :: max_ssmt2_input
integer :: max_qscat_input
integer :: max_gpsref_input
integer :: max_airsr_input
integer :: max_tovs_input
integer :: max_ssmis_input
integer :: report_start
integer :: report_end
integer :: tovs_start
integer :: tovs_end
logical :: gpsref_thinning
logical :: outer_loop_restart
integer :: max_ext_its
integer , DIMENSION(max_outer_iterations) :: ntmax
integer :: nsave
integer :: write_interval
real , DIMENSION(max_outer_iterations) :: eps
logical :: precondition_cg
real :: precondition_factor
logical :: use_lanczos
logical :: read_lanczos
logical :: write_lanczos
logical :: orthonorm_gradient
integer :: cv_options
integer :: cloud_cv_options
real , DIMENSION(3*max_outer_iterations) :: as1
real , DIMENSION(3*max_outer_iterations) :: as2
real , DIMENSION(3*max_outer_iterations) :: as3
real , DIMENSION(3*max_outer_iterations) :: as4
real , DIMENSION(3*max_outer_iterations) :: as5
logical :: do_normalize
logical :: use_rf
integer :: rf_passes
real , DIMENSION(max_outer_iterations) :: var_scaling1
real , DIMENSION(max_outer_iterations) :: var_scaling2
real , DIMENSION(max_outer_iterations) :: var_scaling3
real , DIMENSION(max_outer_iterations) :: var_scaling4
real , DIMENSION(max_outer_iterations) :: var_scaling5
real , DIMENSION(max_outer_iterations) :: var_scaling6
real , DIMENSION(max_outer_iterations) :: var_scaling7
real , DIMENSION(max_outer_iterations) :: var_scaling8
real , DIMENSION(max_outer_iterations) :: var_scaling9
real , DIMENSION(max_outer_iterations) :: var_scaling10
real , DIMENSION(max_outer_iterations) :: var_scaling11
real , DIMENSION(max_outer_iterations) :: len_scaling1
real , DIMENSION(max_outer_iterations) :: len_scaling2
real , DIMENSION(max_outer_iterations) :: len_scaling3
real , DIMENSION(max_outer_iterations) :: len_scaling4
real , DIMENSION(max_outer_iterations) :: len_scaling5
real , DIMENSION(max_outer_iterations) :: len_scaling6
real , DIMENSION(max_outer_iterations) :: len_scaling7
real , DIMENSION(max_outer_iterations) :: len_scaling8
real , DIMENSION(max_outer_iterations) :: len_scaling9
real , DIMENSION(max_outer_iterations) :: len_scaling10
real , DIMENSION(max_outer_iterations) :: len_scaling11
real :: je_factor
real :: power_truncation
logical :: def_sub_domain
real :: x_start_sub_domain
real :: y_start_sub_domain
real :: x_end_sub_domain
real :: y_end_sub_domain
integer :: stdout
integer :: stderr
integer :: trace_unit
integer :: trace_pe
integer :: trace_repeat_head
integer :: trace_repeat_body
integer :: trace_max_depth
logical :: trace_use
logical :: trace_use_frequent
logical :: trace_use_dull
logical :: trace_memory
logical :: trace_all_pes
logical :: trace_csv
logical :: use_html
logical :: warnings_are_fatal
logical :: test_transforms
logical :: test_gradient
logical :: test_statistics
logical :: interpolate_stats
real , DIMENSION(99) :: be_eta
logical :: test_dm_exact
integer :: cv_options_hum
integer :: check_rh
real :: set_omb_rand_fac
integer :: seed_array1
integer :: seed_array2
integer :: sfc_assi_options
logical :: psfc_from_slp
logical :: calculate_cg_cost_fn
logical :: lat_stats_option
integer :: interp_option
integer :: balance_type
logical :: use_wpec
real :: wpec_factor
integer :: vert_corr
integer :: vertical_ip
integer :: vert_evalue
real :: max_vert_var1
real :: max_vert_var2
real :: max_vert_var3
real :: max_vert_var4
real :: max_vert_var5
real :: max_vert_var6
real :: max_vert_var7
real :: max_vert_var8
real :: max_vert_var9
real :: max_vert_var10
real :: max_vert_var11
real :: max_vert_var_alpha
real :: psi_chi_factor
real :: psi_t_factor
real :: psi_ps_factor
real :: psi_rh_factor
real :: chi_u_t_factor
real :: chi_u_ps_factor
real :: chi_u_rh_factor
real :: t_u_rh_factor
real :: ps_u_rh_factor
integer :: rttov_emis_atlas_ir
integer :: rttov_emis_atlas_mw
integer :: rtminit_print
integer :: rtminit_nsensor
integer , DIMENSION(max_instruments) :: rtminit_platform
integer , DIMENSION(max_instruments) :: rtminit_satid
integer , DIMENSION(max_instruments) :: rtminit_sensor
integer , DIMENSION(max_instruments) :: rad_monitoring
real , DIMENSION(max_instruments) :: thinning_mesh
logical :: thinning
logical :: read_biascoef
logical :: biascorr
logical :: biasprep
logical :: rttov_scatt
logical :: write_profile
logical :: write_jacobian
logical :: qc_rad
logical :: write_iv_rad_ascii
logical :: write_oa_rad_ascii
logical :: write_filtered_rad
logical :: use_error_factor_rad
logical :: use_landem
logical , DIMENSION(max_instruments) :: use_antcorr
logical , DIMENSION(max_instruments) :: use_mspps_emis
logical , DIMENSION(max_instruments) :: use_mspps_ts
integer :: mw_emis_sea
integer :: tovs_min_transfer
logical :: tovs_batch
integer :: rtm_option
logical :: use_crtm_kmatrix
logical :: use_rttov_kmatrix
logical :: crtm_cloud
logical :: only_sea_rad
logical :: use_pseudo_rad
integer :: pseudo_rad_platid
integer :: pseudo_rad_satid
integer :: pseudo_rad_senid
integer :: pseudo_rad_ichan
real :: pseudo_rad_lat
real :: pseudo_rad_lon
real :: pseudo_rad_inv
real :: pseudo_rad_err
logical :: use_simulated_rad
logical :: simulated_rad_io
integer :: simulated_rad_ngrid
logical :: use_varbc
logical :: freeze_varbc
real :: varbc_factor
integer :: varbc_nbgerr
integer :: varbc_nobsmin
logical :: use_clddet_mmr
logical :: use_clddet_ecmwf
logical :: airs_warmest_fov
logical , DIMENSION(2) :: use_satcv
logical :: use_blacklist_rad
logical :: calc_weightfunc
character*256 :: crtm_coef_path
character*256 :: crtm_irwater_coef
character*256 :: crtm_mwwater_coef
character*256 :: crtm_irland_coef
character*256 :: crtm_visland_coef
integer :: num_pseudo
real :: pseudo_x
real :: pseudo_y
real :: pseudo_z
real :: pseudo_val
real :: pseudo_err
integer :: alphacv_method
integer :: ensdim_alpha
integer :: alpha_truncation
integer :: alpha_corr_type
real :: alpha_corr_scale
real :: alpha_std_dev
logical :: alpha_vertloc
logical :: alpha_hydrometeors
logical :: hybrid_dual_res
integer :: dual_res_upscale_opt
character*256 :: analysis_type
integer :: sensitivity_option
logical :: adj_sens
character*256 :: analysis_date
character*256 :: pseudo_var
character*256 :: documentation_url
character*256 :: time_window_min
character*256 :: time_window_max
logical :: jcdfi_use
integer :: jcdfi_diag
real :: jcdfi_penalty
logical :: enable_identity
logical :: trajectory_io
logical :: var4d_detail_out
logical :: var4d_run
integer , DIMENSION(max_domains) :: mp_physics_ad
integer , DIMENSION(max_domains) :: mp_physics_4dvar
integer , DIMENSION(max_domains) :: chem_opt
integer    :: last_item_in_struct
!ENDOFREGISTRYGENERATEDINCLUDE

   
   logical :: use_obsgts
   logical :: use_rad

   
   
   

   
   real, parameter    :: pi = 3.1415926           
   real, parameter    :: radian = pi / 180.0
   real, parameter    :: gas_constant = 287.0     
   real, parameter    :: gas_constant_v = 461.6   
   real, parameter    :: cp = 7.0*gas_constant/2.0 
   real, parameter    :: t_kelvin = 273.15
   real, parameter    :: t_triple = 273.16 
   
   
   
   real, parameter    :: t_roughem = 273.0
   real, parameter    :: t_landem = 273.0

   real, parameter    :: kappa = gas_constant / cp
   real, parameter    :: rd_over_rv = gas_constant / gas_constant_v
   real, parameter    :: rd_over_rv1 = 1.0 - rd_over_rv
   real, parameter    :: L_over_Rv = 5418.12

   real, parameter    :: gamma = 1.4

   
   real, parameter    :: gravity = 9.81        
   
   real, parameter    :: earth_radius = 6370.0          
   
   real, parameter    :: earth_omega  = 0.000072921     

   
   real, parameter    :: es_alpha = 611.2
   real, parameter    :: es_beta = 17.67
   real, parameter    :: es_gamma = 243.5
   real, parameter    :: es_gammabeta = es_gamma * es_beta
   real, parameter    :: es_gammakelvin = es_gamma - t_kelvin

   
   real, parameter    :: SVP1=0.6112, SVP2=17.67, SVP3=29.65
   real, parameter    :: SVPT0=t_kelvin, TO=t_kelvin
   real, parameter    :: N0R=8.0E6, N0S=2.0E7, RHOS=0.1
   real, parameter    :: AVT=841.99667, BVT=0.8, BVT2=2.5+0.5*BVT, BVT3=3.0+BVT
   real, parameter    :: PPI=1.0/(pi*N0R), PPIS=1.0/(pi*N0S*RHOS)
   real, parameter    :: XLV1=2370.0, XLF0=0.3337E6, XLV0=3.15E6
   real, parameter    :: XLS=XLV0-XLV1*t_triple+XLF0

   
   real, parameter         :: k_kar = 0.4    

   
   
   real, parameter    :: zdk1 = 2.2768e-5 
   real, parameter    :: zdk2 = 2.66e-3 
   real, parameter    :: zdk3 = 2.8e-7 
   
   real, parameter    :: wdk1 = 2.21e-7 
   real, parameter    :: wdk2 = 3.73e-3 
 
   
   real, parameter    :: a_ew = 0.622 
   real, parameter    :: b_ew = 0.378  

   
   real, parameter    :: coeff = (wdk2*1.e8) / 77.6

   real, parameter :: da_zero = 0D0

   complex, parameter :: da_zero_complex = (da_zero,da_zero)
   
   
   
   

   

   integer, parameter ::  missing       = -888888
   real   , parameter ::  missing_r     = -888888.0
   real   , parameter ::  xmiss         = -88.0
   real   , parameter ::  Max_StHeight_Diff = 100.0

   integer, parameter :: cv_options_hum_specific_humidity = 1
   integer, parameter :: cv_options_hum_relative_humidity = 2

   
   integer, parameter :: vert_corr_1 = 1
   integer, parameter :: vert_corr_2 = 2

   integer, parameter :: vertical_ip_0            = 0
   integer, parameter :: vertical_ip_sqrt_delta_p = 1
   integer, parameter :: vertical_ip_delta_p      = 2

   integer, parameter :: vert_evalue_global = 1
   integer, parameter :: vert_evalue_local  = 2

   integer, parameter :: alphacv_method_vp = 1
   integer, parameter :: alphacv_method_xa = 2

   integer, parameter :: sfc_assi_options_1 = 1
   integer, parameter :: sfc_assi_options_2 = 2

   integer, parameter :: check_rh_simple = 1
   integer, parameter :: check_rh_tpw    = 2

   logical :: anal_type_verify=.false.
   logical :: anal_type_randomcv=.false.
   logical :: anal_type_qcobs=.false.
   logical :: anal_type_hybrid_dual_res=.false.

   integer,parameter :: monitor_on  = 1
   integer,parameter :: monitor_off = 0

   integer,parameter :: qc_good       =  1
   integer,parameter :: qc_bad        = -1
   integer,parameter :: qc_varbc_bad  = -1

   integer, parameter :: bufr_satellite_id   = 1
   integer, parameter :: bufr_ifov           = 2
   integer, parameter :: bufr_year           = 3
   integer, parameter :: bufr_month          = 4
   integer, parameter :: bufr_day            = 5
   integer, parameter :: bufr_hour           = 6
   integer, parameter :: bufr_minute         = 7
   integer, parameter :: bufr_second         = 8
   integer, parameter :: bufr_lat            = 9
   integer, parameter :: bufr_lon            = 10
   integer, parameter :: bufr_satzen         = 11
   integer, parameter :: bufr_solzen         = 12
   integer, parameter :: bufr_station_height = 13
   integer, parameter :: bufr_landsea_mask   = 14
   integer, parameter :: bufr_solazi         = 15     

   integer, parameter :: nchan_amsua = 15
   integer, parameter :: nchan_amsub = 5
   integer, parameter :: nchan_mhs   = 5
   integer, parameter :: nchan_msu   = 4
   integer, parameter :: nchan_hirs2 = 19
   integer, parameter :: nchan_hirs3 = 19
   integer, parameter :: nchan_hirs4 = 19
   integer, parameter :: nchan_ssmis = 24
   integer, parameter :: nchan_airs  = 281

   

   integer            :: iter
   integer            :: cv_size
   integer, parameter :: MP = 6
   integer, parameter :: LP = 6
   integer, parameter :: MAXFEV = 10
   real, parameter    :: FTOL = 1.0E-4
   real, parameter    :: GTOL = 0.9
   real, parameter    :: XTOL = 1.0E-17
   real, parameter    :: STPMIN = 1.0E-20
   real, parameter    :: STPMAX = 1.0E+20
   
   
   real, parameter    :: pplow = 1.0e-8       
   real, parameter    :: pp_umin = 1.0e-2     
   real, parameter    :: pp_vmin = 1.0e-2     
   real, parameter    :: pp_tmin = 1.0e-2     
   real, parameter    :: pp_qmin = 1.0e-6     
   real, parameter    :: pp_pmin= 1.0e+1      

   
   integer, parameter :: Forward_FFT     = -1 
   integer, parameter :: Inverse_FFT     =  1 
   integer, parameter :: num_fft_factors = 10 
   integer, parameter :: nrange          =1000
 
   
   integer, parameter :: balance_geo = 1      
   integer, parameter :: balance_cyc = 2      
   integer, parameter :: balance_geocyc = 3   

   
   real, parameter    :: typical_u_rms = 2.0     
   real, parameter    :: typical_v_rms = 2.0     
   real, parameter    :: typical_speed_rms = 2.0 
   real, parameter    :: typical_tb19v_rms = 1.0 
   real, parameter    :: typical_tb19h_rms = 1.0 
   real, parameter    :: typical_tb22v_rms = 1.0 
   real, parameter    :: typical_tb37v_rms = 1.0 
   real, parameter    :: typical_tb37h_rms = 1.0 
   real, parameter    :: typical_tb85v_rms = 1.0 
   real, parameter    :: typical_tb85h_rms = 1.0 
   real, parameter    :: typical_t_rms = 1.0     
   real, parameter    :: typical_p_rms = 100.0   
   real, parameter    :: typical_q_rms = 0.00001 
   real, parameter    :: typical_rho_rms = 0.01  
   real, parameter    :: typical_tpw_rms = 0.2   
   real, parameter    :: typical_ref_rms = 5.0   
   real, parameter    :: typical_rh_rms = 20.0   
   real, parameter    :: typical_thickness_rms = 50.0   
   real, parameter    :: typical_qrn_rms = 0.00001 
   real, parameter    :: typical_qcw_rms = 0.00001 
   real, parameter    :: typical_qci_rms = 0.00001 
   real, parameter    :: typical_qsn_rms = 0.00001 
   real, parameter    :: typical_qgr_rms = 0.00001 
   real, parameter    :: typical_w_rms = 0.1     
   real, parameter    :: typical_rv_rms = 1.0    
   real, parameter    :: typical_rf_rms = 1.0    
   real, parameter    :: typical_rain_rms = 1.0   

   
   
   

   real, parameter    :: inv_typ_vp1_sumsq = 0.00001 
   real, parameter    :: inv_typ_vp2_sumsq = 0.00001 
   real, parameter    :: inv_typ_vp3_sumsq = 0.00001 
   real, parameter    :: inv_typ_vp4_sumsq = 10000.0 
   real, parameter    :: inv_typ_vp5_sumsq = 0.00001 
   real, parameter    :: inv_typ_vpalpha_sumsq = 1.0 

   CHARACTER (LEN=10) :: release_version = 'V3.8.1    '

   integer, parameter :: fg_format_wrf_arw_regional = 1
   integer, parameter :: fg_format_wrf_nmm_regional = 2
   integer, parameter :: fg_format_wrf_arw_global   = 3
   integer, parameter :: fg_format_kma_global = 4

   integer, parameter :: ob_format_bufr = 1
   integer, parameter :: ob_format_ascii = 2
   integer, parameter :: ob_format_madis = 3

   integer, parameter :: convert_fd2uv = 1
   integer, parameter :: convert_uv2fd = -1

   

   

   

   
   integer, parameter :: trace_csv_unit = 8

   integer :: y_unit, yp_unit, cost_unit, grad_unit, stats_unit, jo_unit
   integer :: check_max_iv_unit, check_buddy_unit, rand_unit, omb_unit, &
              filtered_obs_unit
   integer :: biasprep_unit, qcstat_conv_unit

   integer,parameter :: filename_len = 200

   integer, parameter :: num_alpha_corr_types = 3

   integer, parameter :: alpha_corr_type_exp      = 1
   integer, parameter :: alpha_corr_type_soar     = 2
   integer, parameter :: alpha_corr_type_gaussian = 3

   integer :: alpha_corr_unit1(num_alpha_corr_types)
   integer :: alpha_corr_unit2(num_alpha_corr_types)

   integer, parameter :: max_num_of_var = 200 

   integer, parameter :: unit_start = 20
   integer, parameter :: unit_end = 500
   logical :: unit_used(unit_start:unit_end) = .false.

   

   character(len=3), parameter :: grid_ordering = "xyz"
   character(len=3), parameter :: grid_stagger  = "xyz"

   
   
   

   integer            :: map_projection       
                                              
   real               :: ycntr
   integer            :: coarse_ix            
   integer            :: coarse_jy            
   real               :: coarse_ds            
   real               :: start_x              
   real               :: start_y              
   real               :: start_lat            
   real               :: start_lon            
   real               :: delt_lat             
   real               :: delt_lon             

   real               :: phic                 
   real               :: xlonc                
   real               :: cone_factor          
   real               :: truelat1_3dv         
   real               :: truelat2_3dv         
   real               :: pole                 
   real               :: dsm                  
   real               :: psi1                 
   real               :: c2                   

   real               :: ptop
   real, parameter    :: t0 = 300.0

   
   
   

   integer, parameter :: v_interp_not_specified = missing, &
                         v_interp_p             = 1, &
                         v_interp_h             = 2

   
   
   

   integer                :: Anal_Space  
                                         
                                         
                                         

   integer                :: mix         
   integer                :: mjy         
   integer                :: mkz         

   

   real, allocatable      :: rf_turnconds(:) 

   integer, parameter     :: max_ob_levels = 1001 
   integer, parameter     :: max_fgat_time = 100  

   integer                :: time

   logical       :: gaussian_lats  


   integer       :: cv_size_domain_jb    
   integer       :: cv_size_domain_je    
   integer       :: cv_size_domain_jp    
   integer       :: cv_size_domain_js    
   integer       :: cv_size_domain_jl    
   integer       :: cv_size_domain       

   
   real          :: sigma_alpha          
   real          :: jb_factor            

   
   real, parameter :: maximum_rh = 100.0
   real, parameter :: minimum_rh =  10.0

   real, parameter :: qlimit = 1.0e-12   

   

   integer, parameter :: jperr = 6

   
   

   real, parameter :: err_k(0:jperr+1) = &
                      (/200000.0, 100100.0,70000.0,50000.0,30000.0,10000.0,5000.0, 1.0/)
   real, parameter :: err_u(0:jperr+1) = &
                      (/ 1.4, 1.4,   2.4,   2.8,   3.4,   2.5,  2.7,  2.7/)
   real, parameter :: err_v(0:jperr+1) = &
                      (/ 1.4, 1.4,   2.4,   2.8,   3.4,   2.5,  2.7 , 2.7 /)
   real, parameter :: err_t(0:jperr+1) = &
                      (/ 1.8, 1.8,   1.3,   1.3,   2.0,   3.1,  4.0 , 4.0 /)
   real, parameter :: err_rh(0:jperr+1) = &
                      (/ 10.0, 10.0,  10.0,  10.0,  10.0,  10.0, 10.0,  10.0/)
   real, parameter :: err_p(0:jperr+1) = &
                      (/ 100.0,100.0, 100.0, 100.0, 100.0, 100.0,100.0,100.0 /)

   

   real, parameter :: max_buddy_t             =     8.0, &
                      max_buddy_uv            =     8.0, &
                      max_buddy_z             =     8.0, &
                      max_buddy_rh            =    40.0, &
                      max_buddy_p             =   350.0, &
                      buddy_weight            =     1.0, &
                      bin_p_width             =  5000.0, &
                      bin_z_width             =   500.0 

   

   integer, parameter ::  &
      missing_data            = -88, &     
                                           
      outside_of_domain       = -77, &     
                                           
      wrong_direction         = -15, &     
                                           
      negative_spd            = -14, &     
                                           
      zero_spd                = -13, &     
                                           
      wrong_wind_data         = -12, &     
                                           
      zero_t_td               = -11, &     
                                           
      t_fail_supa_inver       = -10, &     
                                           
      wrong_t_sign            = - 9, &     
                                           
      above_model_lid         = - 8, &     
                                           
      far_below_model_surface = - 7, &     
                                           
      below_model_surface     = - 6, &     
                                           
      standard_atmosphere     = - 5, &     
                                           
      from_background         = - 4, &     
                                           
      fails_error_max         = - 3, &     
                                           
      fails_buddy_check       = - 2, &     
                                           
      no_buddies              = - 1, &     
                                           
      good_quality            =   0, &     
                                           
      convective_adjustment   =   1, &     
                                           
      surface_correction      =   2, &     
                                           
      Hydrostatic_recover     =   3, &     
                                           
      Reference_OBS_recover   =   4, &     
                                           
      Other_check             =  88        

   

   integer                :: num_procs            
   integer                :: myproc               
   integer, parameter     :: root = 0             
   logical                :: rootproc             

   integer, parameter :: rtm_option_rttov = 1
   integer, parameter :: rtm_option_crtm = 2

   

   integer, parameter            :: maxsensor = 30

   integer, parameter :: npres_print = 12


   

   integer :: trace_start_points=0   

   integer, parameter :: sound     = 1
   integer, parameter :: synop     = 2
   integer, parameter :: pilot     = 3
   integer, parameter :: satem     = 4
   integer, parameter :: geoamv    = 5
   integer, parameter :: polaramv  = 6
   integer, parameter :: airep     = 7
   integer, parameter :: gpspw     = 8
   integer, parameter :: gpsref    = 9
   integer, parameter :: metar     = 10
   integer, parameter :: ships     = 11
   integer, parameter :: ssmi_rv   = 12
   integer, parameter :: ssmi_tb   = 13
   integer, parameter :: ssmt1     = 14
   integer, parameter :: ssmt2     = 15
   integer, parameter :: qscat     = 16
   integer, parameter :: profiler  = 17
   integer, parameter :: buoy      = 18
   integer, parameter :: bogus     = 19
   integer, parameter :: pseudo    = 20
   integer, parameter :: radar     = 21
   integer, parameter :: radiance  = 22
   integer, parameter :: airsr     = 23
   integer, parameter :: sonde_sfc = 24
   integer, parameter :: mtgirs    = 25
   integer, parameter :: tamdar    = 26
   integer, parameter :: tamdar_sfc = 27
   integer, parameter :: rain      = 28

   character(len=14), parameter :: obs_names(num_ob_indexes) = (/ &
      "sound         ", &
      "synop         ", &
      "pilot         ", &
      "satem         ", &
      "geoamv        ", &
      "polaramv      ", &
      "airep         ", &
      "gpspw         ", &
      "gpsrf         ", &
      "metar         ", &
      "ships         ", &
      "ssmi_rv       ", &
      "ssmi_tb       ", &
      "ssmt1         ", &
      "ssmt2         ", &
      "qscat         ", &
      "profiler      ", &
      "buoy          ", &
      "bogus         ", &
      "pseudo        ", &
      "radar         ", &
      "radiance      ", &
      "airs retrieval", &
      "sonde_sfc     ", &
      "mtgirs        ", &
      "tamdar        ", &
      "tamdar_sfc    ", &
      "rain          " &
   /)

   integer, parameter :: max_no_fm = 290

   integer, parameter :: num_ob_vars=10

   logical, parameter :: in_report(num_ob_vars,2) = reshape((/&
     .false.,.false.,.false.,.false.,.false.,.false.,.false.,.false.,.false., & 
     .true.,.true.,.true.,.true.,.true.,.true.,.false.,.false.,.false.,.false.,.false./), &
     (/num_ob_vars,2/))

   integer, parameter :: report_h   = 1
   integer, parameter :: report_u   = 2
   integer, parameter :: report_v   = 3
   integer, parameter :: report_t   = 4
   integer, parameter :: report_q   = 5
   integer, parameter :: report_p   = 6
   integer, parameter :: report_rh  = 7
   integer, parameter :: report_slp = 8
   integer, parameter :: report_zk  = 9

   logical :: obs_use(num_ob_indexes) = .false.

   

   integer, parameter :: fm_satem = 86
   integer, parameter :: fm_amv   = 88

   integer, parameter :: fm_index(max_no_fm) = (/ &
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,Synop,Ships,0,Metar,            & 
      Metar,Ships,buoy,buoy,0,    & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,pilot,pilot,pilot,sound,  & 
      sound,sound,sound,0,0,            & 
      0,airep,0,0,0,0,0,0,0,0,                      & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,satem,0,geoamv,0,0,           & 
      0,0,0,0,0,airep,airep,0,0,0,            & 
      tamdar,0,0,0,0,0,0,0,0,0,                                & 
      gpspw,0,0,gpspw,0,gpsref,0,0,0,0, & 
      ssmt1,ssmt2,0,0,ssmi_rv,0,0,0,0,0,            & 
      0,profiler,airsr,0,bogus,0,0,0,0,0, & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      mtgirs,0,0,0,0,0,0,0,0,0,                            & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      0,0,0,0,0,0,0,0,0,0,                                & 
      qscat,0,0,0,0,0,0,0,0,0 /)                      

   character(len=120)  :: fmt_info ='(a12,1x,a19,1x,a40,1x,i6,3(f12.3,11x),6x,a5)'
   character(len=120)  :: fmt_srfc = '(7(:,f12.3,i4,f7.2))'

   character(len=120)  :: fmt_each = &
      '(3(f12.3,i4,f7.2),11x,3(f12.3,i4,f7.2),11x,3(f12.3,i4,f7.2))'

   

   real, parameter :: deg_to_rad = pi/180.0
   real, parameter :: rad_to_deg = 1.0/deg_to_rad
  
   real, allocatable :: cos_xls(:)
   real, allocatable :: sin_xls(:)
   real, allocatable :: cos_xle(:)
   real, allocatable :: sin_xle(:)

   integer :: ierr 
   integer :: comm 

   integer :: ids,ide,jds,jde,kds,kde
   integer :: ims,ime,jms,jme,kms,kme
   integer :: its,ite,jts,jte,kts,kte
   integer :: ips,ipe,jps,jpe,kps,kpe
   integer :: itsy,itey,jtsy,jtey,ktsy,ktey
   integer :: itsx,itex,jtsx,jtex,ktsx,ktex

   integer :: ide_ens,jde_ens,kde_ens

   integer :: its_int,ite_int,jts_int,jte_int,kts_int,kte_int
   integer :: ids_int,ide_int,jds_int,jde_int,kds_int,kde_int
   integer :: ims_int,ime_int,jms_int,jme_int,kms_int,kme_int
   integer :: ips_int,ipe_int,jps_int,jpe_int,kps_int,kpe_int

   character (len=filename_len) :: input_file_ens = 'fg_ens'


   TYPE dual_res_type
         real :: x
         real :: y
         integer :: i
         integer :: j
         real    :: dx
         real    :: dy
         real    :: dxm
         real    :: dym
         integer :: xx
         integer :: yy
   END TYPE dual_res_type

   TYPE(dual_res_type), allocatable :: ob_locs(:)
   integer :: total_here
   

   integer :: num_qcstat_conv(2,num_ob_indexes,num_ob_vars,npres_print+1)
   character*4, parameter :: ob_vars(num_ob_vars) = (/'U   ','V   ','T   ',&
                                                      'Q   ','Ps  ','Spd ',&
                                                      'Tpw ','GpsR','Thic','Rain'/)
   real, parameter :: pptop(1:npres_print) = (/ 1000.0, 900.0, 800.0, 600.0, 400.0, 300.0,  &
                      250.0,  200.0, 150.0, 100.0, 50.0, 0./)

   real, parameter :: ppbot(npres_print) = (/ 1200.0, 999.9, 899.9, 799.0, 599.9, 399.9,  &
                      299.9,  249.9, 199.9, 149.9, 99.9, 49.9/)

   real*8, allocatable :: time_slots(:)

   logical :: global

   logical, allocatable :: fgat_rain_flags(:)

end module da_control
