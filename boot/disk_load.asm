;load DH sectors to ES:BX from drive DL
disk_load :
    push dx ;to compare number of sectors read to number intended to be read

    mov ah, 0x02 ;BIOS read sector function
    mov al, dh ;read dh sectors
    mov ch, 0 ;select cylinder 0
    mov dh, 0 ;select head 0
    mov cl, 0x02 ;start reading from the second sector (after boot sector)
    
    int 0x13 ;BIOS interrupt to read disk
    
    jc disk_error ;if carry flag set

    pop dx
    cmp al, dh
    jne disk_error
    ret

    disk_error :
        mov bx, DISK_ERROR_MSG
        call print_string
        jmp $

DISK_ERROR_MSG db "DISK READ ERROR", 0