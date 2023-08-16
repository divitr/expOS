print_hex:
    pusha
    mov cx, 0 ;initialize counter to 0

hex_loop:
    cmp cx, 4
    je end_hex_loop
    
    ; Convert dx hex value to ascii
    mov ax, dx
    and ax, 0x000F
    add al, 0x30
    cmp al, 0x39
    jle move_into_bx
    add al, 0x7
    
move_into_bx:
    mov bx, hexstring + 5 ;base address of hexstring + length of string
    sub bx, cx ;subtract loop counter
    mov [bx], al ;al = ascii character
    ror dx, 4 ;rotate dx right 4 bits
    add cx, 1
    jmp hex_loop

end_hex_loop:
    ; Print the hex value
    mov bx, hexstring
    call print_string
    popa
    ret

hexstring: db '0x0000', 0 