ORG 0
;begin with automated wave/pulse pattern
Start:
	CALL	FullLED0
	CALL 	Clear
	CALL	FullLED1
	CALL 	Clear
	CALL	FullLED2
	CALL 	Clear
	CALL	FullLED3
	CALL 	Clear
	CALL	FullLED4
	CALL 	Clear
	CALL	FullLED5
	CALL 	Clear
	CALL	FullLED6
	CALL 	Clear
	CALL	FullLED7
	CALL 	Clear
	CALL	FullLED8
	CALL 	Clear
	CALL	FullLED9
    
	CALL 	Clear
	CALL	FullLED9
    
	CALL	FullLED8
	CALL 	Clear
	CALL	FullLED7
	CALL 	Clear
	CALL	FullLED6
	CALL 	Clear
	CALL	FullLED5
	CALL 	Clear
	CALL	FullLED4
	CALL 	Clear
	CALL	FullLED3
	CALL 	Clear
	CALL	FullLED2
	CALL 	Clear
	CALL	FullLED1
	CALL 	Clear
	CALL	FullLED0
	CALL 	Clear
	LOAD 	Count
	ADDI	1
	STORE	Count
	ADDI	-3
	JNEG 	Start
    
;loop that allows demo of switch input to LEDs
SwitchDemo:
	IN 		Switches
	OUT 	LEDs
	JUMP 	SwitchDemo
    
;subroutine "FullLEDX" turns the LED with number X to 100% brightness with diminishing brightnesses for nearby LEDs
FullLED0:
	LOADI	&B00001111111 ;full brightness on LED0
	OUT    	LEDs
	LOADI	&B00011000000 ;~50% brightness on LED1
	OUT    	LEDs
	LOADI	&B00100100000 ;~25% brightness on LED2
	OUT 	LEDs
	OUT 	Timer
	CALL	Wait
	RETURN
    
FullLED1:
	LOADI	&B00011111111 ;full brightness on LED1
	OUT    	LEDs
	LOADI	&B00001000000 ;~50% brightness on LED0
	OUT    	LEDs
	LOADI 	&B00101000000 ;~50% brightness on LED2
	OUT    	LEDs
	LOADI	&B00110100000 ;~25% brightness on LED3
	OUT 	LEDs
	OUT 	Timer
	CALL	Wait
	RETURN
FullLED2:
	LOADI	&B00101111111 ;full brightness on LED2
	OUT    	LEDs
	LOADI	&B00011000000 ;~50% brightness on LED1
	OUT    	LEDs
	LOADI	&B00111000000 ;~50% brightness on LED3
	OUT    	LEDs
	LOADI	&B00000100000 ;~25% brightness on LED0
	OUT    	LEDs
	LOADI	&B01000100000 ;~25% brightness on LED4
	OUT    	LEDs
	OUT 	Timer
	CALL	Wait
	RETURN
FullLED3:
	LOADI	&B00111111111 ;full brightness on LED3
	OUT    	LEDs
	LOADI	&B00101000000 ;~50% brightness on LED2
	OUT    	LEDs
	LOADI	&B01001000000 ;~50% brightness on LED4
	OUT    	LEDs
	LOADI	&B00010100000 ;~25% brightness on LED1
	OUT    	LEDs
	LOADI	&B01010100000 ;~25% brightness on LED5
	OUT    	LEDs
	OUT 	Timer
	CALL	Wait
	RETURN
FullLED4:
	LOADI	&B01001111111 ;full brightness on LED4
	OUT    	LEDs
	LOADI	&B00111000000 ;~50% brightness on LED3
	OUT    	LEDs
	LOADI	&B01011000000 ;~50% brightness on LED5
	OUT    	LEDs
	LOADI	&B00100100000 ;~25% brightness on LED2
	OUT    	LEDs
	LOADI	&B01100100000 ;~25% brightness on LED6
	OUT    	LEDs
	OUT    	Timer
	CALL	Wait
	RETURN
FullLED5:
	LOADI	&B01011111111 ;full brightness on LED5
	OUT    	LEDs
	LOADI	&B01001000000 ;~50% brightness on LED4
	OUT    	LEDs
	LOADI	&B01101000000 ;~50% brightness on LED6
	OUT    	LEDs
	LOADI	&B00110100000 ;~25% brightness on LED3
	OUT    	LEDs
	LOADI	&B01110100000 ;~25% brightness on LED7
	OUT    	LEDs
	OUT    	Timer
	CALL	Wait
	RETURN
FullLED6:
	LOADI	&B01101111111 ;full brightness on LED6
	OUT    	LEDs
	LOADI	&B01011000000 ;~50% brightness on LED5
	OUT    	LEDs
	LOADI	&B01111000000 ;~50% brightness on LED7
	OUT    	LEDs
	LOADI	&B01000100000 ;~25% brightness on LED4
	OUT    	LEDs
	LOADI	&B10000100000 ;~25% brightness on LED8
	OUT    	LEDs
	OUT    	Timer
	CALL	Wait
	RETURN
FullLED7:
	LOADI	&B01111111111 ;full brightness on LED7
	OUT    	LEDs
	LOADI	&B01101000000 ;~50% brightness on LED6
	OUT    	LEDs
	LOADI	&B10001000000 ;~50% brightness on LED8
	OUT    	LEDs
	LOADI	&B01010100000 ;~25% brightness on LED5
	OUT    	LEDs
	LOADI	&B10010100000; ~25% brightness on LED9
	OUT    	LEDs
	OUT    	Timer
	CALL	Wait
	RETURN
FullLED8:
	LOADI	&B10001111111 ;full brightness on LED8
	OUT    	LEDs
	LOADI	&B01111000000 ;~50% brightness on LED7
	OUT    	LEDs
	LOADI	&B10011000000 ;~50% brightness on LED9
	OUT    	LEDs
	LOADI	&B01100100000 ;~25% brightness on LED6
	OUT    	LEDs
	OUT    	Timer
	CALL	Wait
	RETURN
FullLED9:
	LOADI	&B10011111111 ;full brightness on LED9
	OUT    	LEDs
	LOADI	&B10001000000 ;~50% brightness on LED8
	OUT    	LEDs
	LOADI	&B01110100000 ;~25% brightness on LED7
	OUT    	LEDs
	OUT    	Timer
	CALL	Wait
	RETURN

; turns off all LEDs
Clear:
	LOADI	&B00000000000
	OUT    	LEDs ; turn off LED0
	LOADI	&B00010000000
	OUT    	LEDs ; turn off LED1
	LOADI	&B00100000000
	OUT    	LEDs ; turn off LED2
	LOADI	&B00110000000
	OUT    	LEDs ; turn off LED3
	LOADI	&B01000000000
	OUT    	LEDs ; turn off LED4
	LOADI	&B01010000000
	OUT    	LEDs ; turn off LED5
	LOADI	&B01100000000
	OUT    	LEDs ; turn off LED6
	LOADI	&B01110000000
	OUT    	LEDs ; turn off LED7
	LOADI	&B10000000000
	OUT    	LEDs ; turn off LED8
	LOADI	&B10010000000
	OUT    	LEDs ; turn off LED9
	RETURN
    
;wait 1 full second before next stage of wave pattern
Wait:
	IN    	Timer
	ADDI	-10
	JNEG	Wait
	RETURN
    

; Variables
Count:        	DW 0
Switches:     	EQU &H000
LEDs:        	EQU &H020
Timer:        	EQU &H002
