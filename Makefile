#
# Author: Pablo Musa
# Creation Date: mar 27 2011
# Last Modification: jun 03 2014
# See Copyright Notice in COPYRIGHT
# 
# luamemprofiler - A Memory Profiler for the Lua language
#

CC = gcc
CFLAGS = -g -Wall -ansi -pedantic -fPIC -shared

# For SDL2, use `sdl2-config --libs` and `sdl2-config --cflags`
SDL_LIBS = $(shell sdl2-config --libs) -lSDL2_ttf -lSDL2
SDL_CFLAGS = $(shell sdl2-config --cflags)

# Assuming LUA_DIR is the directory containing the Lua headers, the default path is correct
LUA_DIR = /usr/include/lua5.2
LUA_CFLAGS = -I$(LUA_DIR)
# Linking against the Lua library should be done via `-llua5.2` which you already have set
LUA_LIBS = -llua5.2

all: luamemprofiler.so

luamemprofiler.so: graphic.o lmp_struct.o vmemory.o lmp.o luamemprofiler.o
	cd src && $(CC) graphic.o lmp_struct.o vmemory.o lmp.o luamemprofiler.o -o luamemprofiler.so $(CFLAGS) $(SDL_LIBS) $(LUA_LIBS) && mv luamemprofiler.so ../

luamemprofiler.o:
	cd src && $(CC) -c luamemprofiler.c $(CFLAGS) $(LUA_CFLAGS)

lmp.o:
	cd src && $(CC) -c lmp.c $(CFLAGS) $(LUA_CFLAGS)

lmp_struct.o:
	cd src && $(CC) -c lmp_struct.c $(CFLAGS) $(LUA_CFLAGS)

vmemory.o:
	cd src && $(CC) -c vmemory.c $(CFLAGS) $(LUA_CFLAGS)

graphic.o:
	cd src && $(CC) -c gsdl.c -o graphic.o $(CFLAGS) $(SDL_CFLAGS)

clean:
	rm src/*.o

test:
	./run.sh

