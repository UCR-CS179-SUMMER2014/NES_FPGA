#List of 6502 Instructions


$00	BRK	Implied	- - - - - - - 

$01	ORA ($NN,X)	Indexed Indirect	- Z- - - - N

$05	ORA $NN	Zero Page	- Z- - - - N

$06	ASL $NN	Zero Page	CZ- - - - N

$08	PHP	Implied	- - - - - - - 

$09	ORA #$NN	Immediate	- Z- - - - N

$0a	ASL A	Accumulator	CZ- - - - N

$0d	ORA $NNNN	Absolute	- Z- - - - N

$0e	ASL $NNNN	Absolute	CZ- - - - N

$10	BPL $NN	Relative	- - - - - - - 

$11	ORA ($NN),Y	Indirect Indexed	- Z- - - - N

$15	ORA $NN,X	Zero Page,X	- Z- - - - N

$16	ASL $NN,X	Zero Page,X	CZ- - - - N

$18	CLC	Implied	C- - - - - - 

$19	ORA $NNNN,Y	Absolute,Y	- Z- - - - N

$1d	ORA $NNNN,X	Absolute,X	- Z- - - - N

$1e	ASL $NNNN,X	Absolute,X	CZ- - - - N

$20	JSR $NNNN	Absolute	- - - - - - - 

$21	AND ($NN,X)	Indexed Indirect	- Z- - - - N

$24	BIT $NN	Zero Page	- Z- - - VN

$25	AND $NN	Zero Page	- Z- - - - N

$26	ROL $NN	Zero Page	CZ- - - - N

$28	PLP	Implied	CZIDBVN

$29	AND #$NN	Immediate	- Z- - - - N

$2a	ROL A	Accumulator	CZ- - - - N

$2c	BIT $NNNN	Absolute	- Z- - - VN

$2d	AND $NNNN	Absolute	- Z- - - - N

$2e	ROL $NNNN	Absolute	CZ- - - - N

$30	BMI $NN	Relative	- - - - - - - 

$31	AND ($NN),Y	Indirect Indexed	- Z- - - - N

$35	AND $NN,X	Zero Page,X	- Z- - - - N

$36	ROL $NN,X	Zero Page,X	CZ- - - - N

$38	SEC	Implied	C- - - - - - 

$39	AND $NNNN,Y	Absolute,Y	- Z- - - - N

$3d	AND $NNNN,X	Absolute,X	- Z- - - - N

$3e	ROL $NNNN,X	Absolute,X	CZ- - - - N

$40	RTI	Implied	- - - - - - - 

$41	EOR ($NN,X)	Indexed Indirect	- Z- - - - N

$45	EOR $NN	Zero Page	- Z- - - - N

$46	LSR $NN	Zero Page	CZ- - - - N

$48	PHA	Implied	- - - - - - - 

$49	EOR #$NN	Immediate	- Z- - - - N

$4a	LSR A	Accumulator	CZ- - - - N

$4c	JMP $NNNN	Absolute	- - - - - - - 

$4d	EOR $NNNN	Absolute	- Z- - - - N

$4e	LSR $NNNN	Absolute	CZ- - - - N

$50	BVC $NN	Relative	- - - - - - - 

$51	EOR ($NN),Y	Indirect Indexed	- Z- - - - N

$55	EOR $NN,X	Zero Page,X	- Z- - - - N

$56	LSR $NN,X	Zero Page,X	CZ- - - - N

$58	CLI	Implied	- - I- - - - 

$59	EOR $NNNN,Y	Absolute,Y	- Z- - - - N

$5d	EOR $NNNN,X	Absolute,X	- Z- - - - N

$5e	LSR $NNNN,X	Absolute,X	CZ- - - - N

$60	RTS	Implied	- - - - - - - 

$61	ADC ($NN,X)	Indexed Indirect	CZ- - - VN

$65	ADC $NN	Zero Page	CZ- - - VN

$66	ROR $NN	Zero Page	CZ- - - - N

$68	PLA	Implied	- Z- - - - N

$69	ADC #$NN	Immediate	CZ- - - VN

$6a	ROR A	Accumulator	CZ- - - - N

$6c	JMP $NN	Indirect	- - - - - - - 

$6d	ADC $NNNN	Absolute	CZ- - - VN

$6e	ROR $NNNN	Absolute	CZ- - - - N

$70	BVS $NN	Relative	- - - - - - - 

$71	ADC ($NN),Y	Indirect Indexed	CZ- - - VN

$75	ADC $NN,X	Zero Page,X	CZ- - - VN

$76	ROR $NN,X	Zero Page,X	CZ- - - - N

$78	SEI	Implied	- - I- - - - 

$79	ADC $NNNN,Y	Absolute,Y	CZ- - - VN

$7d	ADC $NNNN,X	Absolute,X	CZ- - - VN

$7e	ROR $NNNN,X	Absolute,X	CZ- - - - N

$81	STA ($NN,X)	Indexed Indirect	- - - - - - - 

$84	STY $NN	Zero Page	- - - - - - - 

$85	STA $NN	Zero Page	- - - - - - - 

$86	STX $NN	Zero Page	- - - - - - - 

$88	DEY	Implied	- Z- - - - N

$8a	TXA	Implied	- Z- - - - N

$8c	STY $NNNN	Absolute	- - - - - - - 

$8d	STA $NNNN	Absolute	- - - - - - - 

$8e	STX $NNNN	Absolute	- - - - - - - 

$90	BCC $NN	Relative	- - - - - - - 

$91	STA ($NN),Y	Indirect Indexed	- - - - - - - 

$94	STY $NN,X	Zero Page,X	- - - - - - - 

$95	STA $NN,X	Zero Page,X	- - - - - - - 

$96	STX $NN,Y	Zero Page,Y	- - - - - - - 

$98	TYA	Implied	- Z- - - - N

$99	STA $NNNN,Y	Absolute,Y	- - - - - - - 

$9a	TXS	Implied	- - - - - - - 

$9d	STA $NNNN,X	Absolute,X	- - - - - - - 

$a0	LDY #$NN	Immediate	- Z- - - - N

$a1	LDA ($NN,X)	Indexed Indirect	- Z- - - - N

$a2	LDX #$NN	Immediate	- Z- - - - N

$a4	LDY $NN	Zero Page	- Z- - - - N

$a5	LDA $NN	Zero Page	- Z- - - - N

$a6	LDX $NN	Zero Page	- Z- - - - N

$a8	TAY	Implied	- Z- - - - N

$a9	LDA #$NN	Immediate	- Z- - - - N

$aa	TAX	Implied	- Z- - - - N

$ac	LDY $NNNN	Absolute	- Z- - - - N

$ad	LDA $NNNN	Absolute	- Z- - - - N

$ae	LDX $NNNN	Absolute	- Z- - - - N

$b0	BCS $NN	Relative	- - - - - - - 

$b1	LDA ($NN),Y	Indirect Indexed	- Z- - - - N

$b4	LDY $NN,X	Zero Page,X	- Z- - - - N

$b5	LDA $NN,X	Zero Page,X	- Z- - - - N

$b6	LDX $NN,Y	Zero Page,Y	- Z- - - - N

$b8	CLV	Implied	- - - - - V- 

$b9	LDA $NNNN,Y	Absolute,Y	- Z- - - - N

$ba	TSX	Implied	- Z- - - - N

$bc	LDY $NNNN,X	Absolute,X	- Z- - - - N

$bd	LDA $NNNN,X	Absolute,X	- Z- - - - N

$be	LDX $NNNN,Y	Absolute,Y	- Z- - - - N

$c0	CPY #$NN	Immediate	CZ- - - - N

$c1	CMP ($NN,X)	Indexed Indirect	CZ- - - - N

$c4	CPY $NN	Zero Page	CZ- - - - N

$c5	CMP $NN	Zero Page	CZ- - - - N

$c6	DEC $NN	Zero Page	- Z- - - - N

$c8	INY	Implied	- Z- - - - N

$c9	CMP #$NN	Immediate	CZ- - - - N

$ca	DEX	Implied	- Z- - - - N

$cc	CPY $NNNN	Absolute	CZ- - - - N

$cd	CMP $NNNN	Absolute	CZ- - - - N

$ce	DEC $NNNN	Absolute	- Z- - - - N

$d0	BNE $NN	Relative	- - - - - - - 

$d1	CMP ($NN),Y	Indirect Indexed	CZ- - - - N

$d5	CMP $NN,X	Zero Page,X	CZ- - - - N

$d6	DEC $NN,X	Zero Page,X	- Z- - - - N

$d8	CLD	Implied	- - - D- - - 

$d9	CMP $NNNN,Y	Absolute,Y	CZ- - - - N

$dd	CMP $NNNN,X	Absolute,X	CZ- - - - N

$de	DEC $NNNN,X	Absolute,X	- Z- - - - N

$e0	CPX #$NN	Immediate	CZ- - - - N

$e1	SBC ($NN,X)	Indexed Indirect	CZ- - - VN

$e4	CPX $NN	Zero Page	CZ- - - - N

$e5	SBC $NN	Zero Page	CZ- - - VN

$e6	INC $NN	Zero Page	- Z- - - - N

$e8	INX	Implied	- Z- - - - N

$e9	SBC #$NN	Immediate	CZ- - - VN

$ea	NOP	Implied	- - - - - - - 

$ec	CPX $NNNN	Absolute	CZ- - - - N

$ed	SBC $NNNN	Absolute	CZ- - - VN

$ee	INC $NNNN	Absolute	- Z- - - - N

$f0	BEQ $NN	Relative	- - - - - - - 

$f1	SBC ($NN),Y	Indirect Indexed	CZ- - - VN

$f5	SBC $NN,X	Zero Page,X	CZ- - - VN

$f6	INC $NN,X	Zero Page,X	- Z- - - - N

$f8	SED	Implied	- - - D- - - 

$f9	SBC $NNNN,Y	Absolute,Y	CZ- - - VN

$fd	SBC $NNNN,X	Absolute,X	CZ- - - VN

$fe	INC $NNNN,X	Absolute,X	- Z- - - - N
