cc=$(HOME)/prgs/llvmwasm-builder/dist/bin/clang
llc=$(HOME)/prgs/llvmwasm-builder/dist/bin/llc
s2wasm=$(HOME)/prgs/llvmwasm-builder/dist/bin/s2wasm
wast2wasm=$(HOME)/prgs/llvmwasm-builder/dist/bin/wast2wasm
wasm2wast=$(HOME)/prgs/llvmwasm-builder/dist/bin/wasm2wast
wasm-link=$(HOME)/prgs/llvmwasm-builder/dist/bin/wasm-link

outDir=out
srcDir=src
dstDir=$(outDir)/$(srcDir)

$(dstDir)/%.c.bc: $(srcDir)/%.c
	mkdir -p $(@D)
	$(cc) -emit-llvm --target=wasm32 -Oz $< -c -o $@

$(dstDir)/%.c.s: $(dstDir)/%.c.bc
	$(llc) -asm-verbose=false $< -o $@

.PRECIOUS: $(dstDir)/%.c.wast
$(dstDir)/%.c.wast: $(dstDir)/%.c.s
	$(s2wasm) --import-memory $< -o $@

$(dstDir)/%.c.wasm: $(dstDir)/%.c.wast
	$(wast2wasm) $< -o $@
	
.PHONY: all
all: $(dstDir)/call_print_i32.c.wasm

.PHONY: clean
clean:
	rm -rf out/
