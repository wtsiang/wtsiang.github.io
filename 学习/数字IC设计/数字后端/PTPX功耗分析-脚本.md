# PTPX功耗分析-脚本



```tcl

#set_host_options -max_cores 32
#restore_session ../output/session/func_tt25_typ_setup.ses

reset_switching_activity

source /project/STAR2000/DI/STAR2000_DI/user/raosuo.chen/40.STApt/work/proc
set vcd_type rtl

set vcd_file work/aaa.saif
set vcd_file work/bbb.saif
set strip dma_layer_top/u_nvme_endec_wrapper

set time
#set time "85872883 85882876"

Set date[sh date +%G%m%d%I%M]
set design_name [get_object_name [current_design]]

#case $design_name {
#   "nvme_controller" {
#       set mapfile work/all_power_rtl_to_gate.map
#   }
#}
# set mapfile /ux/project/uranus_be/gang.zhou/implementation/release/rtl_vs_gate_map/map/aaa
set rptdir saifpower_${design_name}_${vcd_type}_${date}
sh mkdir $rptdir


set power_enable_analysis true
setpoweranalysis mode averaged
#set power disable_exact_name_match_to_hier_pin true
#set power_disable_exact_name_match_to_net true
reset_rtl_to_gate_name
#source /project/STAR1500/DI/STAR1500N8 all DI/user/wei.zhou/17.syn/work_nvme_endec_wrapper/v0005_0/work/map_file
#source ${mapfile} > ${rptdir}/read _mapfile.log

#report_name_mapping -nosplit > ${rptdir}/name_mapping.rpt 

if{$time!=""} {
    #report_activity_file_check -nosplit -format VCD -strip_path ${strip} ${vcd_file} > ${rptdir}/report_activity_file_check.log
    #read_vcd -time $time -strip path ${strip} ${vcd_file} > ${rptdir}/read vcd.iog
    report_activity_file_check -nosplit format SAIF -strip_path ${strip} ${vcd_file} > ${rptdir}/report_activity_file_check.log
    read_saif -time $time -strip_path ${strip} ${vcd_file} > ${rptdir}/read_vcd.log
    echo "$time" >> ${rptdir}/read_vcd.log
} else {
    #report_activity_file_check -nosplit -format VCD -strip_path ${strip} ${vcd_file} > ${rptdir}/report_activity_file_check.log
    #read_vcd -strip_path ${strip} ${vcd_file} > ${rptdir}/read_vcd.log
    report_activity_file_check -nosplit -format SAIF -strip_path ${strip} ${vcd_file} > ${rptdir}/report_activity_file_check.log
    read_saif -strip_path ${strip} ${vcd_file} > ${rptdir}/read_vcd.log
}

update_power > ${rptdir}/update_power.log
report_switching_activity -list_not_annotated -include_only sequential > not_annotated_regs.log
##report power -hierarchy -levels 10 ${rptdir}/${design name}_power hier.rpt

_saif_power_break_down ${vcd_file} ${strip}
exec sh /project/STAR2000/DI/STAR2000_DI/user/raosuo.chen/40.STA_pt/work/fsdb_power/gen_not_annotated_cells.csh not_annotated_regs.log celllist.tcl test
source celllist.tcl > not_annotated_cells.rpt 

```