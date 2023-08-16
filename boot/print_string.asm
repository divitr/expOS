;assumes string is in bx
print_string:
    pusha
    mov si, bx
    mov ah, 0x0e ;BIOS teletype function
    print_char:
        lodsb
        cmp al, 0
        je done
        int 0x10
        jmp print_char
    done:
        popa
        ret