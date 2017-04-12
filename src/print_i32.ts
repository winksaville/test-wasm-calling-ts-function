import {instantiateWasmFile} from "../build/utils"

/**
 * An object
 */
let importsForInstance = {
    // Unused
    imports: {
        xxx: (arg: any) => {
            console.log(`xxx: arg=${arg}`);
        },
    },
    // Matches 'module name', the first name following the 'import' keyword
    // (func $prtI32 (import "importsForPrintI32" "print_i32") (param i32))
    importsForPrintI32: {
        // Unused, extra entries are ignored
        wink: (arg: any) => {
            console.log(`wink: arg=${arg}`);
        },
        // Matches 'export name' which follows the 'module name
        print_i32: (arg: number) => {
            console.log(`print_i32: arg=${arg}`);
        }
    }
};

async function main() {
    try {
        let instance = await instantiateWasmFile("./build/call_print_i32.wasm",
            importsForInstance);
        instance.exports.call_print_i32();
    } catch (err) {
        console.log(`instantiateWasmFile: err=${err}`);
    }
}

main();
