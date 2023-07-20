Return-Path: <netdev+bounces-19583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E375B44B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028F61C21548
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D04263CA;
	Thu, 20 Jul 2023 16:32:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3603263C1
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:32:49 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077B19B0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:32:48 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57a8080e4a7so11055507b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689870767; x=1690475567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/TK6JIVorn/sA+eP5G2g+kwOGPGeUL13u229FJaZCg=;
        b=UbJI/czgpE5otuF0Rwhdjbhi/YGyodfJWNHQ2uIDpxKsljdubT86Uyo5ecfbYEauZZ
         SCMSdnww41s1bSBPAYTZzlqLvHQCFTAV2L+tL8RAX4PFj6kqLqCSRz7T3Ngy2El6qDM1
         p4Rdv5OOZb7DPHf71YX9//wRN5mv1CBDNuSiOBntIsbyo7A2RCADQ50DE+MyWW2rXFXW
         puD8lUtBN/kzb1fcJkcvrbVRB9W9n6+FE1CA11JAFRh9QpTThAW6ivrVDjmGOjehrk3p
         IMjdhiwpgg04FtkBq6M1h9zJdYnpamB5ckU40QHk9B7+8a5zUqAeuaKLe0YhK5TLMQOb
         4i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870767; x=1690475567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/TK6JIVorn/sA+eP5G2g+kwOGPGeUL13u229FJaZCg=;
        b=OQl4iBXvWyJJ3dUl3cvh7Lm+XjOIZ6aJ/OGC+6xV+m7CjA3irpxVXvpAX4VreVgPZ4
         l26vdraWv4e9FLypTKUhhXFyaGz5u5jHQDeqrHrZ52286IE7Jz+lrxLe2ZNvlxrqW0gU
         Tp1AhYBpVEfOdTddA2JHqofoKv4ozdrGLlPrqLuHcLtjJFW1ZgtjBZgnay6w4/ml1xNp
         l0cV5zlC60kaSQXDGQ3W3J/5dda3G/kxYyQ7njq/hgfB1Y6q+qUO+pRKNf87RqavONF1
         3Muat53phZWVQJ2afgm2ts+ECRZZi0bV7asvwT4HGJQwQJChfphmCjI4fsFcWqw87tsf
         GHoA==
X-Gm-Message-State: ABy/qLYEARwzFRSPaCQWi95vp4b6ajrY1nhfbWN3hstqCAgJjvdSZPgJ
	FvRex7mA4bE8iFaIjJn7DUA=
X-Google-Smtp-Source: APBJJlGXel4DkfIlK4TBb2N3Gvp1u7nrvKkJpTsXancXIByQmnx09Gb/4EZMrkKgm9UtChwOzAA91Q==
X-Received: by 2002:a0d:f287:0:b0:577:1560:9e17 with SMTP id b129-20020a0df287000000b0057715609e17mr20455145ywf.35.1689870767444;
        Thu, 20 Jul 2023 09:32:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:4771:fc2f:6356:aa8e? ([2600:1700:6cf8:1240:4771:fc2f:6356:aa8e])
        by smtp.gmail.com with ESMTPSA id y66-20020a0def45000000b0056d304e224dsm300065ywe.90.2023.07.20.09.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 09:32:47 -0700 (PDT)
Message-ID: <2d3d4627-177d-e007-bedf-bb3e95de3bc8@gmail.com>
Date: Thu, 20 Jul 2023 09:32:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Kui-Feng Lee <thinker.li@gmail.com>,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
 <20230718180321.294721-3-kuifeng@meta.com>
 <9743a6cc267276bfeba5b0fdcf7ba9a4077c67e1.camel@redhat.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <9743a6cc267276bfeba5b0fdcf7ba9a4077c67e1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/20/23 02:32, Paolo Abeni wrote:
> On Tue, 2023-07-18 at 11:03 -0700, Kui-Feng Lee wrote:
>> Add 10 IPv6 routes with expiration time.  Wait for a few seconds
>> to make sure they are removed correctly.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> 
> Same thing as the previous patch.
> 
>> ---
>>   tools/testing/selftests/net/fib_tests.sh | 49 +++++++++++++++++++++++-
>>   1 file changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
>> index 35d89dfa6f11..55bc6897513a 100755
>> --- a/tools/testing/selftests/net/fib_tests.sh
>> +++ b/tools/testing/selftests/net/fib_tests.sh
>> @@ -9,7 +9,7 @@ ret=0
>>   ksft_skip=4
>>   
>>   # all tests in this script. Can be overridden with -t option
>> -TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
>> +TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
> 
> At this point is likely worthy splitting the above line in multiple
> ones, something alike:
> 
> TESTS="unregister down carrier nexthop suppress ipv6_notify \
> 	ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric
> \
> 	ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw \
> 	rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh \
> 	fib6_gc_test"
> 

Ok!

>>   
>>   VERBOSE=0
>>   PAUSE_ON_FAIL=no
>> @@ -747,6 +747,52 @@ fib_notify_test()
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
>> +	OLD_INTERVAL=$(sysctl -n net.ipv6.route.gc_interval)
>> +	# Check expiration of routes every 3 seconds (GC)
>> +	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=3
>> +
>> +	$IP link add dummy_10 type dummy
>> +	$IP link set dev dummy_10 up
>> +	$IP -6 address add 2001:10::1/64 dev dummy_10
>> +
>> +	for i in 0 1 2 3 4 5 6 7 8 9; do
> 		$(seq 0 9)
> 
>> +	    # Expire route after 2 seconds
>> +	    $IP -6 route add 2001:20::1$i \
>> +		via 2001:10::2 dev dummy_10 expires 2
>> +	done
>> +	N_EXP=$($IP -6 route list |grep expires|wc -l)
>> +	if [ $N_EXP -ne 10 ]; then
>> +		echo "FAIL: expected 10 routes with expires, got $N_EXP"
>> +		ret=1
>> +	else
>> +	    sleep 4
>> +	    N_EXP_s20=$($IP -6 route list |grep expires|wc -l)
>> +
>> +	    if [ $N_EXP_s20 -ne 0 ]; then
>> +		echo "FAIL: expected 0 routes with expires, got $N_EXP_s20"
>> +		ret=1
>> +	    else
>> +		ret=0
>> +	    fi
>> +	fi
> 
> Possibly also worth trying with a few K of permanent routes, and dump
> the time required in both cases?

Sure!

> 
>> +
>> +	set +e
>> +
>> +	log_test $ret 0 "ipv6 route garbage collection"
>> +
>> +	sysctl -wq net.ipv6.route.gc_interval=$OLD_INTERVAL
> 
> No need to restore, gc_interval is a per namespace param specific
>>
> 
> 

