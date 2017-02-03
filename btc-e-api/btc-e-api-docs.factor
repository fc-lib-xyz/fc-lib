! Copyright (C) 2017 yura@fc-lib.xyz.
! See http://factorcode.org/license.txt for BSD license.
USING: help.markup help.syntax strings ;
IN: btc-e-api

ARTICLE: "btc-e-api" "btc-e-api"
{ $vocab-link "btc-e-api" }
;

ABOUT: "btc-e-api"

HELP: setkey
{ $values { "key" string } }
{ $description "This is " { $snippet "key" } " for autentification." } ;

HELP: setsecret
{ $values { "secret" string } }
{ $description "This is " { $snippet "secret" } " for autentification."} ;

HELP: dtht
{ $description "" } ;
