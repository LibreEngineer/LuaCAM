# Build and Install libCAM
LIBS = -lGL -lglfw -lpthread -lXrandr -lXi -ldl -lm
LIB_DIRS = -Llib/
INCLUDE_DIRS = -Ilib/include/
DEBUG_FLAGS = -g

CFLAGS = $(LIB_DIRS) $(INCLUDE_DIRS) $(LIBS) $(DEBUG_FLAGS)

run: build
	./luacam

build:
	gcc src/*.c lib/gl3w.o $(CFLAGS) -o luacam

