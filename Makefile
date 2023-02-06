compilers:
	make -C WACC-to-C transpiler-opt
	cd painwacc/crates/tree-sitter-wacc/ && tree-sitter generate 
	cargo build --bin waccc --manifest-path painwacc/Cargo.toml
	cargo build --bin pisswaccrs --manifest-path pisswaccrs/Cargo.toml	


obj/tp:
	./WACC-to-C/transpiler-opt ./shw.wacc ./obj/tp.c
	gcc ./obj/tp.c -o ./obj/tp

obj/painwacc:
	./painwacc/target/debug/waccc ./shw.wacc --emit-c ./obj/painwacc.c
	gcc ./obj/painwacc.c -o ./obj/painwacc

obj/pisswaccrs:
	./pisswaccrs/target/debug/pisswaccrs ./shw.wacc -k c -o ./obj/pisswaccrs.c
	gcc ./obj/pisswaccrs.c pisswaccrs/src/codegen_c/pwcrt.c -o ./obj/pisswaccrs

bins: obj/tp obj/painwacc obj/pisswaccrs


run:
	./obj/painwacc < ints.txt | md5sum -
	./obj/pisswaccrs < ints.txt | md5sum -
	./obj/tp < ints.txt