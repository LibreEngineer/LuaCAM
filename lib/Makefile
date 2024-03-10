
.PHONY: gl3w
gl3w:
	python gl3w/gl3w_gen.py
	cp -r gl3w/include/ .
	@echo -e "\nBuilding shared library for gl3w."
	gcc -c -Wall -Werror -Iinclude/ -fpic gl3w/src/gl3w.c
	gcc -shared -o libgl3w.so gl3w.o
	rm -r src/
