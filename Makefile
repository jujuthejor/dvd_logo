PROJECT_NAME=dvd_logo
EXT=.c

BINDIR=bin
SRCDIR=src
OBJDIR=obj

SRCS=$(wildcard $(SRCDIR)/*$(EXT))
OBJS=$(patsubst $(SRCDIR)/%$(EXT), $(OBJDIR)/%.o, $(SRCS))

CC=gcc
CFLAGS=-Wall -Wno-missing-braces -std=c99 -pedantic

ifeq ($(OS), Windows_NT)
	CFLAGS+=-Wl,--subsystem,windows
endif

INCLUDE_PATH=-Iinclude
LFLAGS=-Llib

ifeq ($(OS), Windows_NT)
	LDFLAGS=-lraylib -lopengl32 -lgdi32 -lwinmm
endif

.PHONY: all debug clean

all: CFLAGS+=-O1
all: TARGETDIR=$(BINDIR)/release
all: $(PROJECT_NAME) $(OBJS)

debug: CFLAGS+=-g
debug: TARGETDIR=$(BINDIR)/debug
debug: $(PROJECT_NAME) $(OBJS)

$(PROJECT_NAME): $(OBJS)
	$(CC) -o $(TARGETDIR)/$@ $(CFLAGS) $(INCLUDE_PATH) $(LFLAGS) $(OBJS) $(LDFLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%$(EXT)
	$(CC) -c $< -o $@ $(CFLAGS) $(INCLUDE_PATH)

clean:
ifeq ($(OS), Windows_NT)
	del $(BINDIR)\debug\*.exe $(BINDIR)\release\*.exe $(OBJDIR)\*.o /Q /S
else
	rm $(BINDIR)/debug/* $(BINDIR)/release/* $(OBJS)
endif
