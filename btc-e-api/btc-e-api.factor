! Copyright (C) 2017 yura@fc-lib.xyz.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel accessors arrays assocs hashtables
http http.client math math.parser math.functions
io io.launcher io.sockets.secure io.encodings.private
io.encodings.ascii io.pipes
formatting calendar namespaces json.reader
sequences sequences.generalizations splitting strings ;
IN: btc-e-api

SYMBOLS: key secret datatype ;

f datatype set  ! f - json string, t - hashtable ; 

: setkey ( key -- ) key set ;
: setsecret ( secret -- ) secret set ;
: dtht ( -- ) t datatype set ;
: dtjs ( -- ) f datatype set ;

<PRIVATE

: getkey ( -- key ) key get ;
: getsecret ( -- secret ) secret get ;

: getdt ( -- dt ) datatype get ;

: nonce ( -- nonce ) now timestamp>unix-time round number>string ;

: secret-hash ( query -- hash )
"echo -n " swap append
"openssl dgst -sha512 -hmac " getsecret append
[ readln >string ] 3array
run-pipeline
last 9 tail ;

! connect to privat api
: private-api-connect ( query -- result )
 dup "application/x-www-form-urlencoded" <post-data>
 swap string>byte-array-fast >>data
 "https://btc-e.nz/tapi" <post-request>
 getkey "Key" set-header
 swap secret-hash "Sign" set-header
 http-request nip getdt [ json> ] when ;

! create query and get result

: priv-api ( method assoc -- result )
dup hashtable? not [ drop 0 <hashtable> ] when
"method" swap ?set-at
nonce swap "nonce" swap ?set-at
[ dup number? [ number>string ] when "=" glue ] { } assoc>map
"&" join private-api-connect ;

PRIVATE>

: getInfo ( -- ht-result )
 "getInfo" null priv-api ;

: Trade ( pair type rate amount -- ht-result )
 4array { "pair" "type" "rate" "amount" } swap
 H{ } zip-as "Trade" swap priv-api ;

: ActiveOrders ( pair -- ht-result )
 dup string? [ "pair" associate ] when "ActiveOrders" swap priv-api ;

: OrderInfo ( order-id -- ht-result )
 "OrderInfo" swap "order_id" associate priv-api ;

: CancelOrder ( order-id -- ht-result )
 "CancelOrder" swap "order_id" associate priv-api ;

: TradeHistory ( parameters -- ht-result ) ! { "from" "count" "from_id" "end_id" "order" "since" "end" "pair" }
 "TradeHistory" swap priv-api ;


: TransHistory ( parameters -- ht-result ) ! { "from" "count" "from_id" "end_id" ""order" "since" "end" }
 "TransHistory" swap priv-api ;

! public api 3
<PRIVATE

: pub-api3-con ( pairs-array method limit -- q )
swap "https://btc-e.nz/api/3/" "/" surround 2over swap "-" join swap
dup number?  [ "?limit=" swap number>string append ] when 3append
2nip http-get nip getdt [ json> ] when ;

PRIVATE>

: info ( -- result )
f "info" f pub-api3-con  ;


: ticker ( pairs-array -- result )
dup array? not [ 1array ] when
"ticker" f pub-api3-con  ;


: depth ( pairs-array limit -- result )
swap dup array? not [ 1array ] when
"depth" rot pub-api3-con  ;

: trades ( pairs-array limit -- result )
swap dup array? not [ 1array ] when
"trades" rot pub-api3-con  ;
