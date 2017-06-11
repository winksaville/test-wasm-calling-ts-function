cc=$(HOME)/prgs/llvmwasm-builder/dist/bin/clang
llc=$(HOME)/prgs/llvmwasm-builder/dist/bin/llc
s2wasm=$(HOME)/prgs/llvmwasm-builder/dist/bin/s2wasm
wasm-merge=$(HOME)/prgs/llvmwasm-builder/dist/bin/wasm-merge
wast2wasm=$(HOME)/prgs/llvmwasm-builder/dist/bin/wast2wasm
wasm2wast=$(HOME)/prgs/llvmwasm-builder/dist/bin/wasm2wast
wasm-link=$(HOME)/prgs/llvmwasm-builder/dist/bin/wasm-link

outDir=out
srcDir=src
dstDir=$(outDir)/$(srcDir)

$(dstDir)/%.cpp.s: $(srcDir)/%.cpp
	mkdir -p $(outDir)/$(srcDir)
	$(cc) -emit-llvm --target=wasm32 -x c++ -Oz $< -c -o $(dstDir)/$(notdir $<).bc
	$(llc) -asm-verbose=false $(dstDir)/$(notdir $<).bc -o $(dstDir)/$(notdir $<).s

$(dstDir)/%.cpp.wast: $(dstDir)/%.cpp.s
	$(s2wasm) --import-memory $< -o $@

$(dstDir)/%.cpp.main_wast: $(dstDir)/%.cpp.s
	$(s2wasm) $< -o $@

$(dstDir)/%.cpp.wasm: $(dstDir)/%.cpp.wast
	$(wast2wasm) $< -o $@
	
$(dstDir)/%.cpp.main_wasm: $(dstDir)/%.cpp.main_wast
	$(wast2wasm) $< -o $@
	

$(dstDir)/%.c.s: $(srcDir)/%.c
	mkdir -p $(outDir)/$(srcDir)
	$(cc) -emit-llvm --target=wasm32 -Oz $< -c -o $(dstDir)/$(notdir $<).bc
	$(llc) -asm-verbose=false $(dstDir)/$(notdir $<).bc -o $(dstDir)/$(notdir $<).s

$(dstDir)/%.c.wast: $(dstDir)/%.c.s
	$(s2wasm) --import-memory $< -o $@

$(dstDir)/%.c.main_wast: $(dstDir)/%.c.s
	$(s2wasm) $< -o $@

$(dstDir)/%.c.wasm: $(dstDir)/%.c.wast
	$(wast2wasm) $< -o $@
	
$(dstDir)/%.c.main_wasm: $(dstDir)/%.c.main_wast
	$(wast2wasm) $< -o $@
	

#$(dstDir)/%.c.wasm: $(srcDir)/%.c $(dstDir)/$(dstDir)/%.c.s $(dstDir)/$(dstDir)/%.c.wast

.PHONY: all, clean

all: $(dstDir)/call_print_i32.c.wasm

$(dstDir)/call_print_i32.c.s: $(srcDir)/call_print_i32.c
$(dstDir)/call_print_i32.c.wast: $(dstDir)/call_print_i32.c.s
$(dstDir)/call_print_i32.c.wasm: $(dstDir)/call_print_i32.c.wast
