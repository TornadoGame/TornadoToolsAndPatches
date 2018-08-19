;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;              
;;
;; Tornado Keyboard Mapper 2.0 TSR program
;;
;; (c) 1993 Heinz-Bernd Eggenstein 
;; CIS: 100430,1446
;; internet: eggenste@cantor.informatik.uni-dortmund.de
;;
;; written for the european versions 1.0C, 1.0B and 1.0 of TORNADO,  
;; but should work with all versions <= 1.0C
;; also tested with the Desert Storm Demo by DI.
;;
;; assembled with TASM 3.1 by Borland                   
;;                                                                                       -<####\###\=
;;                                            
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                
;;     IMPORTANT                     ;;
;;     use this asm code only        ;;
;;     for creating COM files        ;;
;;     ( /t option of tlink)         ;;
;;                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		.MODEL tiny ;indeed
PROG            SEGMENT                
		ASSUME cs:PROG, ds:NOTHING, SS:PROG, es:NOTHING
		
		.386 ; silly, but I want those 32 bit registers for
		     ; checking 32 bit magic numbers
		     ; 
		     ; Anyway, TORNADO doesn't run fast enough on
		     ; <386 machines!


		; some constants
;;--------- The following constants may have to be modified
;;--------- for future versions of TORNADO 
magic_number_offset     EQU 0ah        ; offset into TORNADOs int 9 handler 
magic_number            EQU 061e4d88ah ; magic number used to identify
				       ; flight.exe's int 9 handler

magic_num2_offset       EQU 01fh       ; a second magic number 
magic_num2              EQU 08788ebd0h ; 

t_data_seg_offs         EQU 4          ; offset into T's int 9 handler where
				       ; T's data segment is stored
keyb_table_adr_offs     EQU 23h        ; offset into T's int 9 handler where
				       ; offset of keyb. table is stored

reentry_offset          EQU 0ah        ; offset into T's int 9 hanldler
;;------------------------------------------------------------------------

				       

chk_every_n_ticks       EQU 09h        ; determines frequency of int 9
				       ; handler detection.
				       ; every 9 ticks means that
				       ; detection is performed approx.
				       ; every 0.5 sec.

KEY_RELEASED_T          EQU 00h        ; Torn. encodes released key as 0
KEY_PRESSED_T           EQU 01h        ; Torn. encodes pressed key as 1
KEY_REL_DOS             EQU 80h        ; msb of scancode 
KEY_PRE_DOS             EQU 00h        ; msb of scancode
		; some 7 bit scancodes for different keys
E_KEY                   EQU 12h
CTRL_KEY                EQU 1dh
SCR_L_KEY               EQU 46h
RIGHT_SHIFT_KEY         EQU 36h
LEFT_SHIFT_KEY          EQU 2ah
TILDE_KEY               EQU 41 ; ^ key on german keyboards
NUM_LOCK_KEY            EQU 69
F11_KEY                 EQU 87                
F12_KEY                 EQU 88
K_KEY                   EQU 37
L_KEY                   EQU 38
X_KEY                   EQU 45                 
Z_KEY                   EQU 44 ; Y key on german keyb.                 
A_KEY                   EQU 30
S_KEY                   EQU 31
NINE_KEY_REL            EQU 138
PLUS_PAD_KEY            EQU 78
MINUS_PAD_KEY           EQU 74
C_KEY                   EQU 46
F_KEY                   EQU 33
INS_PAD_KEY             EQU 82
DEL_PAD_KEY             EQU 83
CURS_LEFT_KEY           EQU 75
CURS_RIGHT_KEY          EQU 77
 



		ORG 80h
CmdLength       LABEL BYTE

		ORG 81h
CMDLine         LABEL BYTE



		ORG 100h
start:          jmp install
		; two interrupt handlers follow
		; 

		ASSUME SS:NOTHING, DS:NOTHING, ES:NOTHING                


		; Install check via INT 2Fh multiplex interrupt                
TKM_MPLEX_IDENT db 0D3h

ident           db 'TKM identification string'

new2fhandler:   cmp AH,TKM_MPLEX_IDENT
		jne prev_mplex
		or al,al
		jnz prev_mplex

		or si,si
		jnz prev_mplex
		

		

		push cx
		push di
		push si
		push es
		
		mov cx,es
		or cx,cx
		jnz other_2F_func

		mov es,bx
		mov si, offset ident
		mov cx,20
		
		cld
		repe cmps byte ptr [cs:si] , byte ptr [es:di]
		or cx,cx
		jnz other_2F_func

		mov al,0ffh
		
		pop es
		pop si
		pop di
		pop cx

		push cs
		pop es
		mov si,offset ident
		jmp short prev_mplex

		
other_2F_func:  

		pop es
		pop si
		pop di
		pop cx
prev_mplex:     

		jmp DWORD PTR old2Fmplex

old2Fmplex  LABEL DWORD
old2Fmplex_offs dw ?
old2Fmplex_seg  dw ?


		; New interupt handler for the timer interrupt (clock tick) 
		; continues the old handler
		; The timer interrupt serves as a watch dog:
		; It detects the keyboard interrupt handler of 
		; flight.exe and installs a new one 

newhandler:     push bx
		push eax
		push ds
		push es
		push dx
		
		; Is DOS currently executing a int 21h service?
		; if yes, let's not disturb DOS. Continue old interrupt, 
		; better luck next time.

		les bx, indosflagadr

		cmp byte ptr [es:bx],0
		jne noaction 


		inc timercounter
		
		; Is it time to check the interrupt handler?

		cmp timercounter,chk_every_n_ticks
		jb noaction 


		mov timercounter,0

IFNDEF TTC
		xor bx,bx
		mov ds,bx
		les bx, [ds:024h]
ELSE
		; Look up interrupt vector for interrupt #9
		; Doing this via DOS-service 35h ensures  
		; compatibility with TTC, but may result in  
		; problems (?????) if TTC is not loaded
		
		mov ax,3509h
		int 21h

ENDIF                
		; is it the handler of flight.exe? (heuristic test)
		; compare 2 * four bytes of the handler's code
		
		mov eax,dword ptr [es:bx+magic_number_offset]
		cmp eax,magic_number
		jne SHORT noaction  ; jump if it's not the flight.exe handler

		mov eax,dword ptr [es:bx+magic_num2_offset]
		cmp eax,magic_num2
		jne SHORT noaction

		; look up the segment of Tornados data seg of its handler
		; let's hope Tornado doesn't change its code at runtime...
	       
		mov ax, word ptr [es:bx+t_data_seg_offs]
		mov tornadods,ax

IFDEF DBL_SHIFT                
		; look up offset of Tornado's main keyboard table
		

		mov ax, word ptr [es:bx+keyb_table_adr_offs]
		mov keyb_tab_offs,ax
ENDIF
		; Tornado's int. handlers's code segment is stored
		; for calculating re-entry point

		mov t_entry_seg,es

		; calculate offset for interrupt handler re-entry 

		add bx,reentry_offset
		mov t_entry_offs,bx


		; install new int 9 handler
		; this can be done directly by writing to the interrupt
		; vector table in segment 0000, or by calling DOS
		; services thru int 21h. The direct method is incompatible
		; with TTC, the latter method seems to work fine after
		; I added the InDOS flag polling.
		
IFNDEF TTC
		; install new handler
		; direct method
		cli
		mov word ptr [ds:024h],offset newint9
		mov word ptr [ds:026h],cs
		sti

ELSE

		; load address of new handler into DS:DX                
		
		push cs
		pop ds
		
		mov dx,offset newint9


		mov ax,02509h
		int 21h
		; install handler via DOS service 
		; Maybe not a good idea in an interrupt handler
		; but again, it ensures compatibility with 
		; TTC
ENDIF                

		
		

noaction:       pop dx
		pop es
		pop ds
		pop eax
		pop bx 
		; continue old timer interrupt

		jmp dword ptr oldhandler

		; some variables to assist in dubugging this thing

IFDEF DBL_SHIFT 
		; include keyboard translation table:

IFDEF IDMAP

ELSE

IFDEF USKEY
		INCLUDE keymapus.inc
ELSE
		INCLUDE keymapUK.inc
ENDIF
ENDIF

ENDIF



		; entry address of original timer interrupt

oldhandler  LABEL DWORD
oldhandler_offs dw ?
oldhandler_seg  dw ?

		; The data segment of Tornado's keyboard interupt handler
		; We find this by spying inside the handler's code 
		; (after TORNADO has been loaded)

tornadods       dw ?
		
IFDEF DBL_SHIFT
keyb_tab_offs   dw 730h  ; offset into T's data segment.
			 ; array of flags of key status
			 ; (pressed/released). Indexed by
			 ; keyboard scancodes
ENDIF
		; reentry-point to the original Tornado flight.exe
		; keyboard interrupt handler after the key command
		; manipulation has been done by the new keyboard handler

 
tornado_entry LABEL DWORD 
t_entry_offs    dw ?
t_entry_seg     dw ?

		; Address of the InDOS flag, indicating whether DOS 
		; is currently executing a 21h interrupt.
		; I think TTC is not setting this flag
		; while executing its own 21h  handler, this might be
		; a problem when running both TTC and TKM, but I
		; don't think so.

indosflagadr    LABEL DWORD
indosflag_offs  dw ?   
indosflag_seg   dw ?
		
		; timercounter counts clock ticks. Every few clock ticks,
		; TKM checks whether the keyboard handler of TORNADO's
		; flight.exe (obviously the simulation part of Tornado)
		; has been installed. If this keyboard interrupt
		; handler is detected, TKM replaces it with a handler
		; that disables the CTRL+E ejection command.
		;
		; Another way to do the detection of the flight.exe
		; interrupt 9 handler is to define a new handler for
		; interrupt 21h, DOS service 25h, used by Tornado to 
		; install its keyboard handler. TTC works this way, but I 
		; didn't want to create a chain of handlers of int. 21h
		; when TTC is active. And I don't want to fool around with
		; interrupt 21h unless I have to. Someone told me that some
		; RSR virus detection programs set off an alarm when a 
		; program tries to reroute interrupt 21. I don't know whether  
		; this is true, but I certainly don't want to receive 
		; angry letters from people who think TKM is a virus.
		;
		; However, if the funcions of 
		; TKM were to be integrated into TTC as an (optinal) feature,
		; TTC's interrupt 21h , service 25h handler would be a 
		; good place to do the keyboard handler installation without
		; using the timer interrupt. 
		;
		

timercounter    dw 0



		; New int #9 handler. 
		; takes control during flight and partly replaces Tornado's
		; own interrupt handler.


NVG_flag        db 0
left_shift      db KEY_REL_DOS
right_shift     db KEY_REL_DOS

IFDEF DBL_SHIFT 
		; the 'cool' way to eject: 
		; take both your hands off the controls and press 
		; both shift keys simultaneously. 
		; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
newint9:        PUSH ax  ; if you change this handler, ensure 
		PUSH BX  ; it does not have 'magic_number' at 
		PUSH DS  ; offset 'magic_number_offset', 
		NOP      ; eg. by inserting a NOP
		
		; Load DS with Tornado's data segment
		
		MOV AX,tornadoDS
		mov ds,ax
		
		;  read port
		 
		in al,60h

		mov ah,al
		and ah,80h 
		and al,7fh 

		; ah = 0   : interrupt because a key was pressed
		; ah = 80h : interrupt because a key was released
		; al       : 7 bit "scancode" of key pressed/released
		
		; translate keyboard layout

		
IFDEF IDMAP

ELSE
		mov bx, offset xlat_table  
		xlat [CS:BX]
ENDIF

	      


shift_test:     CMP al,LEFT_SHIFT_KEY
		jne short no_left_shift
		mov left_shift,ah
no_left_shift:  cmp al,RIGHT_SHIFT_KEY
		jne short eject_test
		mov right_shift,ah

eject_test:     or al,ah

		test NVG_flag,0ffh
		jz no_NVG
	    ;; INTERFACE TO TSG, NVG brightness control

		cmp al,F11_KEY
		jne f12_test
		push ax
		mov al,4
		mov ah,right_shift
		and ah,left_shift
		jnz inc_br
		mov al,0fch
inc_br:
		mov ah,5
		int 5
		pop ax
		

f12_test:       cmp al,F12_KEY
		jne NVG_toggle_test
		push ax
		mov al,4
		mov ah,right_shift
		and ah,left_shift
		jnz inc_br2
		mov al,0fch
inc_br2:

		mov ah,6
		int 5
		pop ax


NVG_toggle_test: cmp al,NINE_KEY_REL   ;; 9 key released
		jne no_NVG_toggle
		push ax
		mov ah,3
		int 5
		pop ax


no_NVG_toggle:  

no_NVG:


IFDEF IDMAP

ELSE
		 


		mov bx, keyb_tab_offs
		mov ah,left_shift
		; left and right shift keys pressed?
		or ah,right_shift
		jnz short no_ejection
		; I'm hit, I'm hit! EJECTING! :-)
		; mark CTRL key as pressed 
		mov byte ptr [DS:bx+CTRL_KEY],KEY_PRESSED_T
		; pretend E key was pressed
		; CTRL E will cause ejection
		mov al,E_KEY
		jmp  reentry
		
		; no ejection
no_ejection:    cmp al,CTRL_KEY ; CTRL key pressed
		jne short test_e
		mov byte ptr[ds:bx+E_KEY],KEY_RELEASED_T
		jmp reentry                
test_e:         cmp al,E_KEY ; ECM-toggle key pressed               
		jne short reentry
		cmp byte ptr [ds:bx+CTRL_KEY],KEY_PRESSED_T
		jne short reentry
		; The ECM toggle key caused the interrupt, control key is
		; pressed 
		mov al,SCR_L_KEY ; a key that has no function in TORNADO

		; return to Tornado's own handler, with
		; scancode in register AL

ENDIF

reentry:        jmp tornado_entry

ELSE
		; This is a not so cool, but simpler alternative to
		; the double shift ejection:
		; The Scroll-Lock and E keys are "swapped":
		; E and CTRL E will do nothing,
		; Scroll Lock will toggle ECM,
		; CTRL + Scroll LOCK will eject the 'pilot'

newint9:        PUSH ax ; if you change this handler, ensure it does not
		PUSH BX ; have 'magic_number' at offset 'magic_number_offset'
		PUSH DS ; eg. by inserting a NOP like the following one
		NOP     ; don't remove !!!!
		
		; Load DS with Tornados data segment
		
		MOV AX,tornadoDS
		mov ds,ax
		
		;  read port
		 
		in al,60h

		mov ah,al
		and al,80h 
		and ah,7fh 

		; al = 0: interrupt because a key was pressed
		; al = 80h: interrupt because a key was released
		; ah : "scancode" of key pressed/released
		
		; TKM will now swap the E and Scroll Lock scancodes 
		; Of course, we could perform an arbitrary 
		; keyboard layout translation here, by lookups
		; in a 128 byte long table that maps individual 
		; keys to other keys.  
		; This is done by the TKM_DS and TKM_DSWT versions.
		; Translating arbitrary combinations of keys to other 
		; combinatination like (CTRL  + shift + R -> CTRL+R)
		; would however require more complex bookkeeping of key
		; presses and releases to interface with the Tornado
		; keyboard handler.

		mov bx,E_KEY +256 * SCR_L_KEY
		cmp ah,bl
		je short swap
		XCHG bl,bh
		cmp ah, bl
		jne short swapend
swap:           mov ah,bh
swapend:        
		;----------------------------
		;cmp bl,E_KEY ; 12h: code for e-key
		;jne SHORT not_e_key 
		;mov bl,SCR_L_KEY ; make it a SCROLL-LOCK
		;jmp SHORT reentry
;not_e_key:      cmp bl,SCR_L_KEY ; 46h: code for scroll-lock key
;                jne SHORT reentry
;                mov bl,E_KEY

reentry:        
		CMP al,LEFT_SHIFT_KEY
		jne short no_left_shift
		mov left_shift,ah
no_left_shift:  cmp al,RIGHT_SHIFT_KEY
		jne short reentry2
		mov right_shift,ah

reentry2:       or al,ah 





		test NVG_flag,0ffh
		jz no_NVG
	    ;; INTERFACE TO TSG, NVG brightness control

		cmp al,F11_KEY
		jne f12_test
		push ax
		mov al,4
		mov ah,right_shift
		and ah,left_shift
		jnz inc_br
		mov al,0fch
inc_br:
		mov ah,5
		int 5
		pop ax
		

f12_test:       cmp al,F12_KEY
		jne NVG_toggle_test
		push ax
		mov al,4
		mov ah,right_shift
		and ah,left_shift
		jnz inc_br2
		mov al,0fch
inc_br2:

		mov ah,6
		int 5
		pop ax


NVG_toggle_test: cmp al,NINE_KEY_REL   ;; 9 key released
		jne no_NVG_toggle
		push ax
		mov ah,3
		int 5
		pop ax


no_NVG_toggle:  

no_NVG:




		jmp tornado_entry
ENDIF                
;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;-------------------------------------------------------------------------                
		; code for installing the TSR

		ASSUME SS:PROG, CS:PROG, DS:NOTHING, ES:NOTHING
install:        mov ax,cs
		mov ds,ax

		mov ax,3508h
		int 21h
		mov dx,es
		mov oldhandler_seg,dx
		mov oldhandler_offs,bx
		
		mov ax,352Fh
		int 21h
		mov dx,es
		mov old2Fmplex_seg,dx
		mov old2Fmplex_offs,bx

		; check if TKM is already installed

		mov ah,0BFh
		mov TKM_MPLEX_IDENT,ah
		xor ah,ah
		mov MPLEX_SLOT,AH
		jmp short detect_loop
		
free_slot_found: 
		test MPLEX_SLOT,0ffh
		jnz detect_loop
		mov MPLEX_SLOT,ah


detect_loop:    INC TKM_MPLEX_IDENT
		mov ah,TKM_MPLEX_IDENT
		or ah,ah
		jz detect_end
		mov al,0
		xor si,si
		mov es,si

		mov bx,cs
		mov di,offset ident

		int 2fh
		
		cmp al,00h
		mov ah,TKM_MPLEX_IDENT
		je free_slot_found


		or si,si
		jz detect_loop

		mov cx,es
		or cx,cx
		jz detect_loop

		mov cx,20
		mov di,offset ident

		xchg si,di
		
		cld
		repe cmps byte ptr [cs:si],byte ptr [es:di]
		
		or cx,cx
		jnz detect_loop

		; TKM already installed!
		
		mov dx, offset refuse_load
		mov ah,9
		int 21h

		; this is the end

		mov ax,4c01h
		int 21h

no_slot_avail:
		mov dx, offset no_2f_slots
		mov ah,9
		int 21h

		; this is the end

		mov ax,4c01h
		int 21h



detect_end:     mov ah,MPLEX_SLOT
		or ah,ah
		je no_slot_avail

		mov TKM_MPLEX_IDENT,ah

proc_inst:      mov ax,2508h
		push cs
		pop ds
		mov dx, offset newhandler

		int 21h

		mov ax,252fh
		push cs
		pop ds
		mov dx, offset new2fhandler

		int 21h
		

		;; get address of InDOS flag

		mov ah,34h
		int 21h
		mov ax,es
		mov indosflag_seg,ax
		mov indosflag_offs,bx


		push cs
		pop ds


		; Tell user TKM is installed
		mov dx, offset intro
		mov ah,9
		int 21h

		
		; how to use tkm
		mov dx, offset manual
		mov ah,9
		int 21h


IFNDEF FORCE_NVG
		mov al,CmdLength ;; Comand Line Length
		or al,al
		jz no_cmd_line

		push cs
		pop es

		mov cl,al
		xor ch,ch
		mov di, offset CmdLine
		mov al, ' '
		cld

		repne scasb

		or cx,cx
		jz no_cmd_line
		mov al,'/'

		cld
		repne scasb

		or cx,cx
		jz no_cmd_line

		mov NVG_flag,01h


		push cs
		pop ds

		mov dx, offset NVG_support
		mov ah,9
		int 21h



no_cmd_line:

ELSE 
		mov nvg_flag,1

ENDIF



		; free environment memory block (about 256 bytes, depends
		; on env. var. usage)

		; PSP segment == CS for COM files, not for EXE files!!!!!
		mov bx,cs

		mov es,bx
		mov bx, [es:2ch] ; get env. segment from PSP
		mov es,bx

		; free memory block
		mov ah,49h
		int 21h 

		; Terminate program, but stay resident


		mov ax,cs
		mov es,ax
		mov ds,ax


		mov ax,3101h
		mov dx,offset install
		shr dx,4
		add dx,2 
		int 21h

MPLEX_SLOT      db 0

refuse_load     db 'TKM is already installed!',13,10,'Reboot to install a different TKM TSR', 13,10,'$'
no_2f_slots     db 'TKM could not be loaded (no INT 2F slot available)',13,10,'$'
intro           db 'Tornado Keyboard Mapper 2.0',13,10,'$'
NVG_support     db 13,10,'NVG hotkey support on',13,10,'$'                

IFDEF DBL_SHIFT
IFDEF IDMAP
manual          db ' ',13,10,'$'
ELSE
manual          db 'ECM: Scroll Lock,    EJECT: LEFT+RIGHT SHIFT',13,10, \
		   'Please read README.TKM for additional key commands',13,10, \
		   '!!!!Please reboot after leaving TORNADO!!!!',13,10,'$'
ENDIF

ELSE
manual          db 'ECM: Scroll Lock, EJECT: CTRL+Scroll Lock',13,10,13,10,\
		   '!!!!Please reboot after leaving TORNADO!!!!',13,10,'$'

ENDIF                

PROG            ENDS                
		END start
