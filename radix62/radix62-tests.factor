! Copyright (C) 2017 yura@fc-lib.xyz.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test radix62 ;
IN: radix62.tests

{ 1 } [ "1" radix62> ] unit-test

{ "a" }  [ 10 >radix62 ] unit-test

{ 1000 } [ "g8" radix62> ] unit-test

{ "g8" } [ 1000 >radix62 ] unit-test



