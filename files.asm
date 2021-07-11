#include "consts.asm"
#addr 0xB000
; ################################################
; Files module
; ################################################

; ################################################
; ls_folders(buffer)	
; lists folders in the current folder
; param buffers will hold the returned list of folders
; ################################################
_ls_folders_buffer = 8 ; txt buffer which will receive folders list
_ls_folders:
	push r13
	mov.w r13, sp

	ld.w r0, [r13 + _ls_files_buffer]
	st.w [_files_buffer], r0						; put the address of a buffer into the files_buffer variable
	
	mov.w r0, 0
	st.w [_is_ls_finished], r0

	mov.w r0, LS_FOLDERS				; list folders
	st.w [_files_state], r0
	mov.w r0, 77								; "M" character
	call send_serial
	mov.w r0, 13								; \r character
	call send_serial
	mov.w r0, 10								; \n character
	call send_serial
	mov.w r0, 3
	call send_serial
	mov.w r0, 0x66  						; 'f' - file operation
	call send_serial
	mov.w r0, 0x66  						; 'f' for folders list (list folders in the current folder)
	call send_serial
	
_ls_folders_again:
	ld.w r0, [_is_ls_finished]
	cmp.w r0, 1
	jz _ls_folders_end
	j _ls_folders_again

_ls_folders_end:	
	ld.w r0, [_files_buffer]
	ld.w r2, [_files_size]
	add.w r0, r2
	mov.w r2, 0
	st.b [r0], r2
	
	mov.w sp, r13
	pop r13
	ret


; ################################################
; write_file(buffer, size, file_name)	
; write buffer to file 
; param buffer holds the content to be written to a file
; param size holds the size of the content
; param file_name holds the name of the file to be written
; ################################################
_write_file_buffer = 8 		; buffer which will be written to a file
_write_file_size = 12 		; size of the buffer
_write_file_name = 16 		; txt buffer of the file name of the file to be written
_write_file:
	push r13
	mov.w r13, sp

	mov.w r0, 77								; "M" character
	call send_serial
	mov.w r0, 13								; \r character
	call send_serial
	mov.w r0, 10								; \n character
	call send_serial
	mov.w r0, 3
	call send_serial
	mov.w r0, 0x66  						; 'f' - file operation
	call send_serial
	mov.w r0, 0x77  						; 'w' for write file
	call send_serial

	; send file name
	ld.w r2, [r13 + _write_file_name]
_write_file_again1:	
	ld.b r0, [r2]  						
	call send_serial
	cmp.w r0, 0
	jz _write_file_send_size
	inc.w r2
	j _write_file_again1
	
	; send file size
_write_file_send_size:
	ld.w r0, [r13 + _write_file_size]
	and.w r0, 255
	call send_serial
	ld.w r0, [r13 + _write_file_size]
	shr.w r0, 8
	and.w r0, 255
	call send_serial
	ld.w r0, [r13 + _write_file_size]
	shr.w r0, 16
	and.w r0, 255
	call send_serial
	ld.w r0, [r13 + _write_file_size]
	shr.w r0, 24
	and.w r0, 255
	call send_serial

	; send buffer to be written to a file
	ld.w r2, [r13 + _write_file_buffer]
	ld.w r3, [r13 + _write_file_size]
	mov.w r4, 0
_write_file_again2:
	cmp.w r4, r3
	jz _write_file_end
	ld.b r0, [r2]
	call send_serial
	inc.w r2
	inc.w r4
	j _write_file_again2

_write_file_end:
	mov.w r0, 0
	mov.w sp, r13
	pop r13
	ret

; ##################################################################
; Subroutine which is called whenever some byte arrives at the UART
; ##################################################################
_files_irq_triggered:	
	push r0
	push r1
	push r2   
	push r3
	
	ld.w r0, [_files_state]
	cmp.w r0, LS_FILES
	jz _ls_files_first_byte
	cmp.w r0, LS_FILES + 1
	jz _ls_files_second_byte
	cmp.w r0, LS_FILES + 2
	jz _ls_files_third_byte
	cmp.w r0, LS_FILES + 3
	jz _ls_files_fourth_byte
	cmp.w r0, LS_FILES + 4
	jz _ls_files_incoming

	cmp.w r0, LS_FOLDERS
	jz _ls_files_first_byte
	
	cmp.w r0, READ_FILE
	jz _read_file_status_byte
	
	j _files_skip
	
_ls_files_incoming:

	in r0, [PORT_UART_RX_BYTE] 	; r1 holds now received byte from the UART
	ld.w r3, [_files_buffer]
	ld.w r2, [_current_files_size]
	add.w r3, r2
	st.b [r3], r0
	inc.w r2
	st.w [_current_files_size], r2

	ld.w r3, [_files_size]	
	cmp.w r2, r3
	jz _files_irq_end
	
_files_skip:
	pop r3
	pop r2
	pop r1                 
	pop r0
	iret									 

_files_irq_end:
	mov.w r0, 1
	st.w [_is_ls_finished], r0
	j _files_skip

_ls_files_first_byte:
	mov.w r1, 0
	st.w [_current_files_size], r1

	in r1, [PORT_UART_RX_BYTE] 	; r1 holds now received byte from the UART
	st.w [_files_size], r1
	
	mov.w r1, LS_FILES + 1
	st.w [_files_state], r1
	j _files_skip

_ls_files_second_byte:
	in r1, [PORT_UART_RX_BYTE] 	; r1 holds now received byte from the UART
	shl.w r1, 8
	ld.w r2, [_files_size]
	add.w r1, r2
	st.w [_files_size], r1
	
	mov.w r1, LS_FILES + 2
	st.w [_files_state], r1
	j _files_skip

_ls_files_third_byte:
	in r1, [PORT_UART_RX_BYTE] 	; r1 holds now received byte from the UART
	shl.w r1, 16
	ld.w r2, [_files_size]
	add.w r1, r2
	st.w [_files_size], r1
	
	mov.w r1, LS_FILES + 3
	st.w [_files_state], r1
	j _files_skip

_ls_files_fourth_byte:
	in r1, [PORT_UART_RX_BYTE] 	; r1 holds now received byte from the UART
	shl.w r1, 16
	ld.w r2, [_files_size]
	add.w r1, r2
	st.w [_files_size], r1
	
	mov.w r1, LS_FILES + 4
	st.w [_files_state], r1
	j _files_skip

_read_file_status_byte:
	in r1, [PORT_UART_RX_BYTE] 	; r1 holds now received byte from the UART
	st.w [_file_read_status], r1
	
	cmp.w r1, 1
	jnz _irq_file_error

	mov.w r0, 0
	st.w [_is_ls_finished], r0
	
	mov.w r1, LS_FILES
	st.w [_files_state], r1
	j _files_skip	

_irq_file_error:
	j _files_skip


; ################################################
_files_init:
; ################################################
	push r0
	push r1
	
	; set the IRQ handler for UART to our own IRQ handler
	mov.s r0, 1			; JUMP opcode
	mov.w r1, UART_HANDLER_ADDR
	st.s [r1], r0
	mov.w r0, _files_irq_triggered
	mov.s r1, UART_HANDLER_ADDR + 2
	st.w [r1], r0
	
	pop r1
	pop r0
	ret

; ################################################
; ls_files(buffer)	
; lists files in the current folder
; param buffers will hold the returned list of files
; ################################################
_ls_files_buffer = 8 ; txt buffer which will receive files list
_ls_files:
	push r13
	mov.w r13, sp

	ld.w r0, [r13 + _ls_files_buffer]
	st.w [_files_buffer], r0						; put the address of a buffer into the files_buffer variable
	
	mov.w r0, 0
	st.w [_is_ls_finished], r0

	mov.w r0, LS_FILES					; list files
	st.w [_files_state], r0
	mov.w r0, 77								; "M" character
	call send_serial
	mov.w r0, 13								; \r character
	call send_serial
	mov.w r0, 10								; \n character
	call send_serial
	mov.w r0, 3
	call send_serial
	mov.w r0, 0x66  						; 'f' - file operation
	call send_serial
	mov.w r0, 0x64  						; 'd' for dir (list files in folder)
	call send_serial
	
_ls_files_again:
	ld.w r0, [_is_ls_finished]
	cmp.w r0, 1
	jz _ls_files_end
	j _ls_files_again
	
_ls_files_end:	
	ld.w r0, [_files_buffer]
	ld.w r2, [_files_size]
	add.w r0, r2
	mov.w r2, 0
	st.b [r0], r2
	
	mov.w sp, r13
	pop r13
	ret

; ################################################
; read_file(buffer, file_name)	
; read file content
; param buffer holds the returned content of a file
; param file_name holds the name of the file to be read
; ################################################
_read_file_buffer = 8 		; txt buffer which will receive file content
_read_file_name = 12 			; txt buffer of the file name of the file to be read
_read_file:
	push r13
	mov.w r13, sp

	ld.w r0, [r13 + _read_file_buffer]
	st.w [_files_buffer], r0						; put the address of a buffer into the files_buffer variable

	ld.w r0, [r13 + _read_file_name]
	st.w [_file_name], r0								; put the address of a string that contains the file name of a file to be read

	; reset the status
	mov.w r0, 0
	st.w [_file_read_status], r0
	st.w [_is_ls_finished], r0

	mov.w r0, READ_FILE					; read file
	st.w [_files_state], r0
	mov.w r0, 77								; "M" character
	call send_serial
	mov.w r0, 13								; \r character
	call send_serial
	mov.w r0, 10								; \n character
	call send_serial
	mov.w r0, 3
	call send_serial
	mov.w r0, 0x66  						; 'f' - file operation
	call send_serial
	mov.w r0, 0x72  						; 'r' for read file (read file content)
	call send_serial
	
	ld.w r2, [_file_name]
_file_read_again:
	ld.b r0, [r2]
	cmp.w r0, 0
	jz _file_read_file_status
	call send_serial
	inc.w r2
	j _file_read_again
	
_file_read_file_status:
	call send_serial		; send the 0 at the end of string
_file_status_again:
	ld.w r0, [_file_read_status]
	cmp.w r0, 0
	jz _file_status_again

	cmp.w r0, 1			; is it OK?
	jnz _file_read_error_end	 ; if the status is 1, then it is OK; otherwise, we return with the error code
	
	; wait for the content to arrive
_file_read_content:
	ld.w r0, [_is_ls_finished]
	cmp.w r0, 1
	jz _file_read_end
	j _file_read_content
	
_file_read_end:	
	ld.w r0, [_files_buffer]
	ld.w r2, [_files_size]
	add.w r0, r2
	mov.w r2, 0
	st.b [r0], r2

	ld.w r0, [_files_size]  ; return value
	
	mov.w sp, r13
	pop r13
	ret

_file_read_error_end:
	; r0 has the error code
	mov.w r0, -1
	mov.w sp, r13
	pop r13
	ret

; ######################################################################
; send_serial(r0) - sends one byte in r0 to the UART serial port
; ######################################################################
send_serial:	
	push r5
ss1:
	in r5, [PORT_UART_TX_BUSY]   ; tx busy in r5
	cmp.w r5, 0     
	jz ss2   ; if not busy, send back the received character 
	j ss1
	
ss2:
	out [PORT_UART_TX_SEND_BYTE], r0  ; send the character to the UART
	
	pop r5
	ret


_file_read_status:
	#d32 0

_files_buffer:
	#d32	0											; variable that holds the address of a buffer passed from the main app.

_file_name:
	#d32	0											; variable that holds the address of a file name string to be read

_is_ls_finished:
	#d32 0	

_current_files_size:
	#d32 0

_files_size:
	#d32 0

_files_state:
	#d32 0

		