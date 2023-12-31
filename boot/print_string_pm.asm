bits 32

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

;prints a null-terminated string pointed to by EDX
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je print_string_pm_done
    
    mov [edx], ax

    add ebx, 1 ;next char in string
    add edx, 2 ;next cell in video memory

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret