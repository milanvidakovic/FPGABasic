TARGET=basic
#TARGET=test
#TARGET=snakes

FILES = $(TARGET) sprintf string stdio graphics

ASM_LIST := $(foreach file,$(FILES), $(file).s) keyboard.s files.s graphics320.s graphics640.s fonts.s consts.s

all: compile assemble

compile:
	@for file in $(FILES); do \
    moxiebox-gcc -S $${file}.c -o $${file}.s -fverbose-asm; \
	done
	
assemble:
	java -jar FPGA_Assembler.jar -s $(ASM_LIST)

