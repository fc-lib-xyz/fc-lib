! Copyright (C) 2017 yura@fc-lib.xyz.
! See http://factorcode.org/license.txt for BSD license.

USING: kernel math sequences strings summary ;

IN: radix62

<PRIVATE

CONSTANT: alphabet "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" 

ERROR: not-integer x ;
M: not-integer summary drop "This's not integer.";

ERROR: char-not-ab str ;
M: char-not-ab summary drop "String contains an incorrect character." ;

: number>chararray ( number -- chararray )
 { } swap [ dup 0  > ] [ 62 /mod swap [ prefix ] dip ] while drop ;

: chararray>number ( chararray -- number )
0 [ alphabet index swap 62 * + ] reduce ;

PRIVATE>

: >radix62 ( number -- string )
 dup integer? 
 [ number>chararray [ alphabet nth ] map >string ]
 [ not-integer ] if ;

: radix62> ( string -- number )
 dup [ alphabet member? ] all? 
 [ chararray>number ]
 [ char-not-ab ] if ;