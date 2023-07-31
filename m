Return-Path: <netdev+bounces-22914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B167576A01C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D479C1C2086B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E51DDC0;
	Mon, 31 Jul 2023 18:14:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E41D2ED
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:14:40 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D07E4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:14:38 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5661e8f4c45so3499409eaf.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690827278; x=1691432078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xfw3HgedbbT1z0uwqdKPzjbOeqRHydP7NXIETjqtWRo=;
        b=bDqm7ZdgyMMmuKyyn9M1EzWb1nBUXg7wyAygSaxxtKlNZYe0qgeqmuhA8qrKW9sMI/
         qFdqV5urmE5j0Tkm0KNbuTXDn1KzAdF9QRNTzR5RKXK7N8lQ0Br9eBW235rZGcST9Pgi
         kx4QN4NYBYrUhIwMOIll41ZRPZ72k8sdcZ3log5ZU7ecOm2Bjdm7Z6TDHZ3uXfh1G8Gf
         zANglYlz4jOq/YBJhBYj08h+NZqFmTQO3y2qyneMfsnCRm36yh3t1uQQfz21yWiXKXi0
         xGrFzTes0u6hi1y05VAZeMTeizG+CdDroMJXC/xJ3G/9M3DsKidLdA+uzYsSN+M717I0
         5HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827278; x=1691432078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfw3HgedbbT1z0uwqdKPzjbOeqRHydP7NXIETjqtWRo=;
        b=ctVKUJYXfJcDboONz/ygcVYIMsL9US1Wlev1w0PlMo9/91+AKstVMoq+Z6fwiBGXOk
         NN/8eNwHkoSXu2ryz2RADIVLr9s/T1CVoUXlzPhwyOi+XIr7VAIm+BpOBaVi4xOLi6B+
         fhGPoArtEa7ECaj/7MPCb7CQTLFAoD6sajX4AOl7WVKeGOY4swp5iWGHtKNvgGf5o313
         FVmS0teDnz+/L1ToihnI+RHs6Qy3tw9GZHIl956Gm4l1NXmFAIy3GCWrcEr9toGA+5gJ
         ArsICDekpQHccx1rV5RP4opfFsvAlbii4WYWI2rc0rBYIZtFwZmMYl7iRnY1Pc7Buxsw
         sAqg==
X-Gm-Message-State: ABy/qLaVgIP0gnhQxabEZj4rsGUX96nqRNHzIhJk4q4NfAZaBZ/47QqP
	SFkGUbS0yFiEZdru6PO8ueQ=
X-Google-Smtp-Source: APBJJlGFnITyjzVVGIK6UmVCadgLFC3FJse0CbkS7ugZ2Z7hoLfKkRm5da8JwLwQ3cMiKdh98c3RHw==
X-Received: by 2002:a05:6358:7e9a:b0:134:cb65:fbbe with SMTP id o26-20020a0563587e9a00b00134cb65fbbemr712473rwn.13.1690827277821;
        Mon, 31 Jul 2023 11:14:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:4e7b:31fa:d4f3:3c2f? ([2600:1700:6cf8:1240:4e7b:31fa:d4f3:3c2f])
        by smtp.gmail.com with ESMTPSA id z14-20020a81c20e000000b0057726fce046sm3123474ywc.26.2023.07.31.11.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:14:37 -0700 (PDT)
Message-ID: <bcb2066d-465a-6d2a-8469-7d60adc3f276@gmail.com>
Date: Mon, 31 Jul 2023 11:14:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v4 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
To: Paolo Abeni <pabeni@redhat.com>, kuifeng@meta.com, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 yhs@meta.com
Cc: thinker.li@gmail.com
References: <20230722003839.897682-1-kuifeng@meta.com>
 <20230722003839.897682-3-kuifeng@meta.com>
 <f7ba3fc5327f88a0e9b20e177a0ce599b77833db.camel@redhat.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f7ba3fc5327f88a0e9b20e177a0ce599b77833db.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry for replying late! I am just back from a vocation.

On 7/25/23 03:27, Paolo Abeni wrote:
> On Fri, 2023-07-21 at 17:38 -0700, kuifeng@meta.com wrote:
>> From: Kui-Feng Lee <kuifeng@meta.com>
>>
>> Add 10 IPv6 routes with expiration time.  Wait for a few seconds
>> to make sure they are removed correctly.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/testing/selftests/net/fib_tests.sh | 90 +++++++++++++++++++++++-
>>   1 file changed, 87 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
>> index 35d89dfa6f11..4c92fb3c3844 100755
>> --- a/tools/testing/selftests/net/fib_tests.sh
>> +++ b/tools/testing/selftests/net/fib_tests.sh
>> @@ -9,13 +9,16 @@ ret=0
>>   ksft_skip=4
>>   
>>   # all tests in this script. Can be overridden with -t option
>> -TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
>> +TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
>> +       ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics \
>> +       ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
>> +       ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
>>   
>>   VERBOSE=0
>>   PAUSE_ON_FAIL=no
>>   PAUSE=no
>> -IP="ip -netns ns1"
>> -NS_EXEC="ip netns exec ns1"
>> +IP="$(which ip) -netns ns1"
>> +NS_EXEC="$(which ip) netns exec ns1"
>>   
>>   which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
>>   
>> @@ -747,6 +750,86 @@ fib_notify_test()
>>   	cleanup &> /dev/null
>>   }
>>   
>> +fib6_gc_test()
>> +{
>> +	setup
>> +
>> +	echo
>> +	echo "Fib6 garbage collection test"
>> +	set -e
>> +
>> +	# Check expiration of routes every 3 seconds (GC)
>> +	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=300
>> +
>> +	$IP link add dummy_10 type dummy
>> +	$IP link set dev dummy_10 up
>> +	$IP -6 address add 2001:10::1/64 dev dummy_10
>> +
>> +	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
>> +
>> +	# Temporary routes
>> +	for i in $(seq 1 1000); do
>> +	    # Expire route after 4 seconds
>> +	    $IP -6 route add 2001:20::$i \
>> +		via 2001:10::2 dev dummy_10 expires 4
>> +	done
>> +	N_EXP=$($IP -6 route list |grep expires|wc -l)
>> +	if [ $N_EXP -ne 1000 ]; then
>> +		echo "FAIL: expected 1000 routes with expires, got $N_EXP"
>> +		ret=1
>> +	else
>> +	    sleep 5
>> +	    REALTM_P=$($NS_EXEC strace -T sysctl \
>> +		       -wq net.ipv6.route.flush=1 2>&1 | \
>> +		       awk -- '/write\(.*"1\\n", 2\)/ { gsub("(.*<|>.*)", ""); print $0;}')
> 
> I guess the above works somehow ?!?
> 
> But I think something alike:
> 
> 	# just after printing the banner
> 	TIME=$(which time)
> 	if [ -z "$TIME" ]; then
> 		echo "command 'time' is missing, skipping test"
> 		return
> 	fi
> 	# ...
> 
> 		# replacing the strace command
> 		REALTM_P=$(time -f %e $NS_EXEC sysctl \
> 		       -wq net.ipv6.route.flush=1 2>&1)
> 
> would be better.
> 
> In any case you should check explicitly for the additionally needed
> command ('strace' in your code, 'time' here).
> 
> And you could include the expected output in the commit message (just a
> line, right?)
> 
> Cheers
> 
> Paolo


The availability of 'time' is much higher than 'strace', however
'time -f %e' measures runtime in mini-seconds. That means I have to
add more (x100 perhaps) temporary routes to make it reliably visible to
'time -f %e'. I will try it and check the existence of the command.

> 
> 
>> +	    N_EXP_s5=$($IP -6 route list |grep expires|wc -l)
>> +
>> +	    if [ $N_EXP_s5 -ne 0 ]; then
>> +		echo "FAIL: expected 0 routes with expires, got $N_EXP_s5"
>> +		ret=1
>> +	    else
>> +		ret=0
>> +	    fi
>> +	fi
>> +
>> +	# Permanent routes
>> +	for i in $(seq 1 5000); do
>> +	    $IP -6 route add 2001:30::$i \
>> +		via 2001:10::2 dev dummy_10
>> +	done
>> +	# Temporary routes
>> +	for i in $(seq 1 1000); do
>> +	    # Expire route after 4 seconds
>> +	    $IP -6 route add 2001:20::$i \
>> +		via 2001:10::2 dev dummy_10 expires 4
>> +	done
>> +	N_EXP=$($IP -6 route list |grep expires|wc -l)
>> +	if [ $N_EXP -ne 1000 ]; then
>> +	    echo
>> +	    "FAIL: expected 1000 routes with expires, got $N_EXP (5000 permanent routes)"
>> +		ret=1
>> +	else
>> +	    sleep 5
>> +	    REALTM_T=$($NS_EXEC strace -T sysctl \
>> +		       -wq net.ipv6.route.flush=1 2>&1 | \
>> +		       awk -- '/write\(.*"1\\n", 2\)/ { gsub("(.*<|>.*)", ""); print $0;}')
>> +	    N_EXP_s5=$($IP -6 route list |grep expires|wc -l)
>> +
>> +	    if [ $N_EXP_s5 -ne 0 ]; then
>> +		echo "FAIL: expected 0 routes with expires, got $N_EXP_s5 (5000 permanent routes)"
>> +		ret=1
>> +	    else
>> +		ret=0
>> +	    fi
>> +	fi
>> +
>> +	set +e
>> +
>> +	log_test $ret 0 "ipv6 route garbage collection (${REALTM_P}s, ${REALTM_T}s)"
>> +
>> +	cleanup &> /dev/null
>> +}
>> +
>>   fib_suppress_test()
>>   {
>>   	echo
>> @@ -2217,6 +2300,7 @@ do
>>   	ipv4_mangle)			ipv4_mangle_test;;
>>   	ipv6_mangle)			ipv6_mangle_test;;
>>   	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
>> +	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
>>   
>>   	help) echo "Test names: $TESTS"; exit 0;;
>>   	esac
> 
> 

