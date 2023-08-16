bits 16 ;set 16 bit mode

org 0x7c00 ;set global memory offset

mov [BOOT_DRIVE], dl

mov bp, 0x8000 ;set stack pointer
mov sp, bp

mov bx, 0x9000
mov dh, 2
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

;global variables
BOOT_DRIVE : db 0

;bootsector padding
times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada ;sector after MBR
times 256 dw 0xface ;2 sectors after MBR