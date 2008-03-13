# =======================================
# =     Name: Assignment 3              =
# =     Author: Dino Hensen 1367412     =
# =======================================

.text
formatstr: .asciz "Dino Hensen \n1367412 \nAssignment 3: inout \n" # String die aan het begin geprint wordt
vraagstr:  .asciz "Geef een nummer op ?\n"  # String die geprint wordt met vraag
antwstr:   .asciz "%d"                      # String met argument (getal) later opgegeve
incrstr:   .asciz "%d\n"                    # String met antwstr verhoogd met 1

inout:  pushl   %ebp                        # Basepointer naar stack
        movl    %esp, %ebp                  # Stack pointer kopieren
        pushl   $vraagstr                   # Vraagstr naar stack pushen
        call    printf                      # Vraagstr printen
        addl    $4, %esp                    # Stackpointer terugzetten
        subl    $4, %esp                    # Stackruimte voor antwstr reserveren
        leal    -4(%ebp), %eax              # Adres voor stackruimte laden in EAX
        push    %eax                        # EAX naar stack pushen
        push    $antwstr                    # Antwstring naar stack pushen
        call    scanf                       # Scanf callen
        addl    $8, %esp
        movl    -4(%ebp), %eax              # Waarde scanf naar eax kopieren
        incl    %eax                        # Waarde in eax kopieren
        pushl   %eax                        # Waarde van eax op stack pushen
        pushl   $incrstr                    # Incrstr naar stack pushen
        call    printf                      # Incrstr printen
        addl    $8, %esp                    # Stackpointer terugzetten
        movl    %ebp, %esp                  # Variabelen van subroutines van stack del.
        popl    %ebp                        # Basepointer terugzetten
        ret                                 # Terug naar main

.global main                                # Main programma
main:   movl    %esp, %ebp                  # Basepointer initialiseren
        pushl   $formatstr                  # Formatstring naar stack pushen
        call    printf                      # Formatstring uitprinten
        call    inout                       # naar Subroutine inout gaan
        jmp     end                         # Naar einde programma

end:    movl     $0,(%esp)                  # Exit code
        call     exit                       # Eindig programma
