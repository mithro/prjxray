# Copyright (C) 2017-2020  The Project X-Ray Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC
PART = xc7a35tcsg324-1
BIT2FASM_ARGS = --part "$(XRAY_DIR)/database/artix7/$(PART)" --verbose
SOURCES = ../verilog/mem.init ../verilog/mem_1.init ../verilog/top.v ../verilog/VexRiscv_Lite.v

all: top.fasm top.bits segprint.log

clean:
	@rm -f *.bit
	@rm -f *.bin
	@rm -f *.bits
	@rm -f *.fasm
	@rm -f *.log
	@rm -rf build

.PHONY: all clean

top.bit: $(VIVADO) $(SOURCES) top.xdc top.tcl
	mkdir -p build
	cd build && $(XRAY_VIVADO) -mode batch -source ../top.tcl -nojournal -tempDir build -log vivado.log -verbose
	cp build/*.bit ./

top.fasm: top.bit
	PYTHONPATH="$(XRAY_DIR):$(XRAY_DIR)/utils:$(XRAY_DIR)/third_party/fasm" \
    PATH="$(XRAY_DIR)/build/tools:$(PATH)" \
    $(XRAY_BIT2FASM) $(BIT2FASM_ARGS) \
        top.bit >top.fasm \
        || (rm -f top.fasm && exit 1)

top.bits: top.bit
	$(XRAY_BITREAD) -part_file $(XRAY_DIR)/database/artix7/$(PART).yaml -o top.bits -z -y top.bit

segprint.log: top.bits
	$(XRAY_SEGPRINT) -z -D -b top.bits > segprint.log
