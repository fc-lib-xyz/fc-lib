! Copyright (C) 2017 yura@fc-lib.xyz.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel namespaces accessors assocs http.client arrays
json.writer json.reader classes sequences
hashtables math strings classes.tuple ;
IN: sms-pilot-api

SYMBOLS: api-url api-key ;

"http://smspilot.ru/api2.php" api-url set 


: setak ( api-key -- )
    api-key set ;

: req-sp ( assoc -- ht ) 
    api-key get "apikey" rot ?set-at
    >json api-url get http-post nip json> ;

: tuple>ht ( tuple -- ht )
    [ class-of all-slots ] [ tuple-slots ] bi H{ } zip-as
    [ [ initial>> ] dip = ] assoc-reject
    [ [ name>> ] dip ] assoc-map ;

TUPLE: sms 
{ to integer }
{ id integer }
{ from string }
{ text string }
{ send_datetime }
{ callback string }
{ callback_method string }
{ ttl integer } ;

: <sms> ( to text -- sms )
    sms new 
    swap >>text
    swap >>to ;

: send-sms ( sms -- ht-result )
    tuple>ht 1array "send" associate 
    req-sp ;

: send-smslist ( smslist -- ht-result )
    [ tuple>ht ] map "send" associate
    req-sp ;

: cost-sms ( sms -- cost )
    tuple>ht 1array "send" 
    1 "cost"
    associate ?set-at
    req-sp "cost" of ;

: check-sms ( server-id -- ht-result )
    "server_id" associate
    1array "check" associate
    req-sp ;
    
: check-smslist ( list-server-id -- ht-result )
    [ "server_id" associate ] map
    "check" associate
    req-sp ;

: check-sms-packet ( server-packet-id -- ht-result )
    "server_packet_id" 
    t "check" 
    associate ?set-at
    req-sp ;

: info ( -- ht-info )
    t "info" associate 
    req-sp ;

: balance ( -- rur )
    "rur" "balance" associate 
    req-sp "balance" of ;

: balance-sms ( -- sms )
    "sms" "balance" associate 
    req-sp "balance" of ;



