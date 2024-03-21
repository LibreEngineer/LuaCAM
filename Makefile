# Build and Install libCAM
LIBS = -lGL -lglfw -lpthread -lXrandr -lXi -ldl -lm
LIB_DIRS = -Llib/
INCLUDE_DIRS = -Ilib/include/
DEBUG_FLAGS = -ggdb

CFLAGS = $(LIB_DIRS) $(INCLUDE_DIRS) $(LIBS) $(DEBUG_FLAGS)

run: build
	@clear
	./luacam

build: lib
	gcc src/*.c lib/gl3w.o $(CFLAGS) -o luacam

lib:
	cd lib; make -f buildconf
