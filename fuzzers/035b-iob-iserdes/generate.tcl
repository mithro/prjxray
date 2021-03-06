# Copyright (C) 2017-2020  The Project X-Ray Authors
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC
set_param general.maxThreads 1

create_project -force -part $::env(XRAY_PART) design design
read_verilog top.v
synth_design -top top

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.PERFRAMECRC YES [current_design]
set_param tcl.collectionResultDisplayLimit 0

set_property IS_ENABLED 0 [get_drc_checks {NSTD-1}]
set_property IS_ENABLED 0 [get_drc_checks {NDRV-1}]
set_property IS_ENABLED 0 [get_drc_checks {UCIO-1}]
set_property IS_ENABLED 0 [get_drc_checks {REQP-98}]
set_property IS_ENABLED 0 [get_drc_checks {REQP-109}]
set_property IS_ENABLED 0 [get_drc_checks {REQP-111}]
set_property IS_ENABLED 0 [get_drc_checks {REQP-103}]
set_property IS_ENABLED 0 [get_drc_checks {REQP-79}]
set_property IS_ENABLED 0 [get_drc_checks {PDRC-26}]
set_property IS_ENABLED 0 [get_drc_checks {REQP-105}]

place_design
route_design

write_checkpoint -force design.dcp
write_bitstream -force design.bit
