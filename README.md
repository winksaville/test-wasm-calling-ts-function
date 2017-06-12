# test wasm calling ts functiion

# Prerequistes
- node version ^8.0.0 as wasm is needed
- yarn
- [llvmwasm-builder](https://github.com/winksaville/llvmwasm-builder) installed at ../llvmwasm-builder

# Install
```
$ yarn
yarn install v0.24.6
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
$ yarn postcleanup
yarn postcleanup v0.24.6
$ mkdir -p build 
Done in 0.08s.
Done in 0.51s.
```

# Run
```
$ yarn test
yarn test v0.24.6
$ make && yarn build:tsc
mkdir -p out/src
/home/wink/prgs/llvmwasm-builder/dist/bin/clang -emit-llvm --target=wasm32 -Oz src/call_print_i32.c -c -o out/src/call_print_i32.c.bc
/home/wink/prgs/llvmwasm-builder/dist/bin/llc -asm-verbose=false out/src/call_print_i32.c.bc -o out/src/call_print_i32.c.s
/home/wink/prgs/llvmwasm-builder/dist/bin/s2wasm --import-memory out/src/call_print_i32.c.s -o out/src/call_print_i32.c.wast
/home/wink/prgs/llvmwasm-builder/dist/bin/wast2wasm out/src/call_print_i32.c.wast -o out/src/call_print_i32.c.wasm
rm out/src/call_print_i32.c.s out/src/call_print_i32.c.bc
yarn build:tsc v0.24.6
$ tsc -p src/utils.tsconfig.json && tsc -p src/print_i32.tsconfig.json 
Done in 2.60s.
$ node --expose_wasm build/print_i32.js 
x=null
invoke call_print_i32
print_i32: arg=48
invoked call_print_i32
Done in 3.07s.
```
