# Makefile

# the variables are set when make is called
# SRC is set to demo.c (at the time of this writing demo.c is the only program in there)
# OBJ is set to demo.o using demo.c via patsubst function
# TARGET is set to demo.exe using demo.o via patsubst function
# targets are defined by the ':' after the name, example 'all' is a target
# if you type just 'make' it will look for the first target, in this case
# that would be 'default'

# is set when script is called will be -lncurses no matter if target is before
# or after it, could be reset by a different target.
LDFLAGS=-lncurses

# is set when make is called
CC=g++

# we run make all
# all rules and variables are loaded.
# target all says it depends on something called $(TARGET) which is set to demo.exe
# demo.exe does not exist, so the target cannot be satisfied, so it looks to its pool
# of targets and patterns, it find that it matches "%.exe : %.o" so it says to get the
# demo.exe I need something called demo.o, so using demo.o it hits the general rule
# "%.o : %.c" so it knows to get demo.o it must have demo.c, lucky for it demo.c exists
# in the directory.
# we run demo.c to make demo.o via this line "$(CC) -c $< -o $@" now that demo.o exists
# we jump back to "%.o : %.c" and run "$(CC) -c $< -o $@" now demo.exe is obtained
# demo.exe is the only dependency that $(TARGET) has, now that it has been satisfied
# the rest of the demo.exe target will be executed and unless echo somehow fails the
# target should succeed

# helpful URLS:
#	make functions: wildcard, subst, etc
#	https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

#	various make variables $<, $@, etc.
#	https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

%.o : %.c
	@echo "Pattern .o from .c"
	@echo "$$<	$<"
	@echo -n "$$"
	@echo "@	$@"
	@echo -n "$$"
	@echo "%	$%"
	@echo -n "$$"
	@echo "*	$*"
	@echo -e "\007 *bing*"
	@echo "$(CC) -c $< -o $@"
	$(CC) -c $< -o $@
	@echo

%.exe : %.o
	@echo "Pattern .exe from .o"
	@echo "$$<	$<"
	@echo -n "$$"
	@echo "@	$@"
	@echo -n "$$"
	@echo "%	$%"
	@echo -n "$$"
	@echo "*	$*"
	@echo -e "\007 *bing*"
	@echo "$(CC) -o $@ $< $(LDFLAGS)"
	$(CC) -o $@ $< $(LDFLAGS)
	@echo

SRC=$(wildcard *.c)
OBJ=$(patsubst %.c,%.o,$(SRC)) 
TARGET=$(patsubst %.o,%.exe,$(OBJ))

default:
	#I am the default target since I am first
	@echo "$@"

all: $(TARGET)
	@echo "All Rule"
	@echo $(SRC)
	@echo $(OBJ)
	@echo $(TARGET)

