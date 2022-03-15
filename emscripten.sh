#!/bin/sh

emcc ./c/sfnt2woff.c ./c/woff.c\
    -s WASM=1 \
	-s USE_ZLIB=1 \
    -O3 \
	--no-entry -fno-rtti -s NO_EXIT_RUNTIME=1 -s ASSERTIONS=0 -s WASM_MEM_MAX=1gb -s ALLOW_TABLE_GROWTH=1 --memory-init-file 0 -s FILESYSTEM=0 -s SUPPORT_LONGJMP=1 -flto --closure 1 -s IGNORE_CLOSURE_COMPILER_ERRORS=0 -s ALLOW_MEMORY_GROWTH=1 \
	-s EXIT_RUNTIME=1 \
	-s ASSERTIONS=1 \
	-s EXPORTED_FUNCTIONS='["_malloc", "_sfnt2woff", "_free"]'\
	--extern-pre-js=pre.js --extern-post-js=end.js \
	-s EXPORT_NAME=sfnt2woff \
    -o web/sfnt2woff.js
