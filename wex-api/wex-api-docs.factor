! Copyright (C) 2017 yura@fc-lib.xyz.
! See http://factorcode.org/license.txt for BSD license.
USING: help.markup help.syntax strings ;
IN: wex-api

ARTICLE: "wex-api" "wex-api"
{ $vocab-link "wex-api" }
;

ABOUT: "wex-api"

HELP: setkey
{ $values { "key" string } }
{ $description "This is " { $snippet "key" } " for autentification." } ;

HELP: setsecret
{ $values { "secret" string } }
{ $description "This is " { $snippet "secret" } " for autentification."} ;

HELP: dtht
{ $description "" } ;
