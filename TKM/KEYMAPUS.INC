;; keyboard layout for US style keyboards (101 keys)

R_KEY           EQU     19
KEY_43          EQU     43
GR_KEY          EQU     86 


xlat_table      db 0,1,2,3,4,5,6,7,8,9, \
		   10,11,12,13,14,15,16,17,SCR_L_KEY,KEY_43, \
		   20,21,22,23,24,25,26,27,28,29, \
		   Z_KEY,X_KEY,32,CURS_RIGHT_KEY,34,35,36,88,87,39, \
		   40,NUM_LOCK_KEY,42,R_KEY,
		   A_KEY,S_KEY,CURS_LEFT_KEY,47,48,49, \
		   50,51,52,53,54,55,56,57,58,59, \
		   60,61,62,63,64,65,66,67,68,TILDE_KEY, \
		   E_KEY,71,72,73,74,INS_PAD_KEY,76,DEL_PAD_KEY,78,79, \
		   80,81,F_KEY,C_KEY,84,85,86,L_KEY,K_KEY,89, \
		   90,91,92,93,94,95,96,97,98,99, \
		   100,101,102,103,104,105,106,107,108,109, \
		   110,111,112,113,114,115,116,117,118,119, \
		   120,121,122,123,124,125,126,127 

;; Changes in keyboard layout:
;; <key> : key on num. keypad
;;
;; function              old key       new key
;; ----------------------------------------------------------
;; ECM toggle            E             Scroll Lock   
;; drop chaff            C             <+>             
;; drop flare            F             <->         
;; select A-G package    K             F12
;; select delivery mode  L             F11
;; sweep wing back       A             Y  
;; deploy flaps          S             X
;; rotate camera left    Y             A
;; rotate camera right   X             S
;; Radar                 R             \
;;
;; EJECT                 CTRL E        both SHIFT keys (not implemented by
;;                                                      the translation table        
;;                                                      but by separate code)                                                           
