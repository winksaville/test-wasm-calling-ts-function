# test wasm calling ts functiion

# Prerequistes
- node
- yarn
- Internet connection to download node v8

# Install
```
$ yarn
$ yarn add nodev8
```

# Run
```
$ yarn test
yarn test v0.22.0
$ yarn build:wasm && yarn build:tsc
yarn build:wasm v0.22.0
$ wast2wasm src/call_print_i32.wast --output build/call_print_i32.wasm 
Done in 0.12s.
yarn build:tsc v0.22.0
$ tsc -p src/utils.tsconfig.json && tsc -p src/print_i32.tsconfig.json 
Done in 3.36s.
$ ./nodev8/bin/node --expose_wasm build/print_i32.js 
print_i32: arg=47
Done in 4.00s.
```
