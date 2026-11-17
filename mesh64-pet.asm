!to "mesh64-pet.prg", cbm
CHROUT = $ffd2                ; KERNAL: print char in A

* = $0401                     ; PET BASIC program start

; ---- BASIC stub:  10 SYS 1038 ----
!word basic_end               ; link to next line
!word 10                      ; line number
!byte $9e                     ; SYS token
!text " 1038"                 ; = $040E, where 'start' lands
!byte 0                       ; end of line
basic_end:
!word 0                       ; end of program

; ---- machine code ----
start:
        ldx #0
loop:
        lda message,x
        beq done
        jsr CHROUT
        inx
        bne loop
done:
        rts                   ; back to BASIC

message:
        !text "HELLO, WORLD"
        !byte 13, 0           ; 13 = carriage return, 0 = terminator
