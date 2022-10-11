#!/bin/bash
export TCE_ROOT="../../../../../openasip"

function addToVarBeg {
    export $1="${2}${!1}"
}

function addToPath {
    if ! $(\grep -qE ":?${1}(:|$)" <(echo "${PATH}")); then
        addToVarBeg PATH "$1:" 
    fi  
}

# program paths
addToPath "${TCE_ROOT}/src/codesign/Explorer"
[ -e "${TCE_ROOT}/src/codesign/Explorer/explore" ] || { echo "explore not found from source path."; exit 1; }
addToPath "${TCE_ROOT}/src/bintools/Compiler"
[ -e "${TCE_ROOT}/src/bintools/Compiler/tcecc" ] || { echo "tcecc not found from source path."; exit 1; }
addToPath "${TCE_ROOT}/src/bintools/BEMGenerator"
[ -e "${TCE_ROOT}/src/bintools/BEMGenerator/createbem" ] || { echo "createbem not found from source path."; exit 1; }
addToPath "${TCE_ROOT}/src/procgen/ProGe"
[ -e "${TCE_ROOT}/src/procgen/ProGe/generateprocessor" ] || { echo "generateprocessor not found from source path."; exit 1; }
addToPath "${TCE_ROOT}/src/bintools/PIG"
[ -e "${TCE_ROOT}/src/bintools/PIG/generatebits" ] || { echo "generatebits not found from source path."; exit 1; }

${TCE_ROOT}/scripts/c2vhdl data/application1/complex_multiply.c || { echo "c2vhdl script failed."; exit 1; }

# check that image files were created
if [ ! -e "complex_multiply_data.img" ]; then
    echo "Error: No data image generated."
fi

if [ ! -e "complex_multiply.img" ]; then
    echo "Error: No image generated."
fi
