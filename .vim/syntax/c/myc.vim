" HIGHLIGHT ALL MATH OPERATOR
syn match cMathOperator display "[-+\*/%=]"
syn match cPointerOperator display "->\|\."
syn match cLogicalOperator display "[!<>]=\="
syn match cLogicalOperator display "=="
syn match cBinaryOperator display "\(&\||\|\^\|<<\|>>\)=\="
syn match cBinaryOperator display "\~"
syn match cBinaryOperatorError display "\~="
syn match cLogicalOperator  display "&&\|||"
syn match cLogicalOperatorError display "\(&&\|||\)="
syn match cInterpunction display "[,;]"
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1

hi cMathOperator ctermfg=cyan
hi cPointerOperator ctermfg=cyan
hi cLogicalOperator ctermfg=cyan
hi cBinaryOperator ctermfg=cyan
hi cBinaryOperatorError ctermfg=cyan
hi cLogicalOperator ctermfg=cyan
hi cLogicalOperatorError ctermfg=cyan
hi cInterpunction ctermfg=cyan
hi cFunctions gui=NONE cterm=bold ctermfg=NONE


		"NR-16   NR-8    COLOR NAME ~
		"0	    0	    Black
		"1	    4	    DarkBlue
		"2	    2	    DarkGreen
		"3	    6	    DarkCyan
		"4	    1	    DarkRed
		"5	    5	    DarkMagenta
		"6	    3	    Brown, DarkYellow
		"7	    7	    LightGray, LightGrey, Gray, Grey
		"8	    0*	    DarkGray, DarkGrey
		"9	    4*	    Blue, LightBlue
		"10	    2*	    Green, LightGreen
		"11	    6*	    Cyan, LightCyan
		"12	    1*	    Red, LightRed
		"13	    5*	    Magenta, LightMagenta
		"14	    3*	    Yellow, LightYellow
		"15	    7*	    White

