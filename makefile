# -xc -E -v -
TARGET=basic
#TARGET=test
#TARGET=snakes
#INLCUDE=/mnt/c/Prj/Altera/C/moxiebox/modules/include
LIB=/mnt/c/Prj/Altera/C/moxiebox/modules/lib

FILES = $(TARGET) $(LIB)/sprintf $(LIB)/string $(LIB)/stdio $(LIB)/graphics $(LIB)/spi $(LIB)/fat $(LIB)/enc28j60 $(LIB)/tcpip

ASM_LIST := $(foreach file,$(FILES), $(file).s) $(LIB)/keyboard.s $(LIB)/files.s $(LIB)/graphics320.s $(LIB)/graphics640.s $(LIB)/fonts.s $(LIB)/consts.s

all: compile assemble

compile:
	@for file in $(FILES); do \
    moxiebox-gcc -DKERNEL -fsigned-char -S $${file}.c -o $${file}.s -fverbose-asm; \
	done
	
assemble:
	java -jar ../FPGA_Assembler.jar -s -f $(ASM_LIST)

