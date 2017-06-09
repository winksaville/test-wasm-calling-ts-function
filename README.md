# test wasm calling ts functiion

# Prerequistes
- node version ^8.0.0 as wasm is needed
- yarn
- [llvmwasm-builder](https://github.com/winksaville/llvmwasm-builder) installed at ../llvmwasm-builder

# Install
```
$ yarn
```

# Run
```
$ yarn test
yarn test v0.24.6
$ yarn build:wasm && yarn build:tsc
yarn build:wasm v0.24.6
$ ../llvmwasm-builder/dist/bin/wast2wasm src/call_print_i32.wast --output build/call_print_i32.wasm 
Done in 0.22s.
yarn build:tsc v0.24.6
$ tsc -p src/utils.tsconfig.json && tsc -p src/print_i32.tsconfig.json 
Done in 4.27s.
$ node --expose_wasm build/print_i32.js 
print_i32: arg=47
Done in 5.06s.
```
