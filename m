Return-Path: <netdev+bounces-19982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEC775D168
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5A6282442
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484427F07;
	Fri, 21 Jul 2023 18:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D220F9D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:31:25 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ADDEB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:31:24 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5704fce0f23so25281067b3.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689964283; x=1690569083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5Ugko7jInqQ+PCW7kY+jzt5lNOyilAlEnL7Ws8qAus=;
        b=BNFjhuzObWKjQBRq65QRpnttTp2lbyQRWwXhoYwUqcRE6G/15LzXeFjRm16CjLNjTL
         bEs/A3XVMXpKYkGzaUlfuJNpLg5O/uu30I5bBdjRiMQTT8LVCERsmoagZj1ThIKOF1te
         YRiVTLs6z+jOLxnIMhOtnZ+KAA3+LLq0i2e9EUVnVy8u5AQ6M+kCw00nm/Cq2YVpVSfE
         2QP+RLxOnxNFNcpKB0CYoEVjYRc+4SUHrBZOR4La9XQ97/KLhnMRvxdw9yeNJbIovLvX
         FDhZBeFaLQQLVLWNw8BV6FqbgnabFBzxbmGIBRV4wroSfLuA3y9B5gJD5Hvzr4o0puPW
         zzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964283; x=1690569083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5Ugko7jInqQ+PCW7kY+jzt5lNOyilAlEnL7Ws8qAus=;
        b=UsdGTaTyXMGjMv4n5Bq+dX3fnfyiRzL5vfHkzQgxOzHlYVvANii6iBdA4nBPk6VjpT
         NKigIi7oCbQ7fkC4MkqxQh3qWSVdJvJngihxvvLqifU5B/hQnbmEI9NR4hxhRLUd5UYv
         A4SsN4grsMVNp7SFRGD+5RZzk5v8hwC8KpIjwEsXIutlQ7DnA/wnw5924sUkTl+Gj0Uh
         RRvKoUIAZclIFjuhzwzX5hh1Z40atJTyUWNOsElOf9YcjLvEcpwyn0cODOOezzn4ZCbb
         lKPa7IpMpV4HQ55boCht+XbucA5pOGt46izDCjN2D97VtQwtVWGUyV6HhU11/GYPpNiG
         b17A==
X-Gm-Message-State: ABy/qLb0z06QqPdTDRhO10p3Xlqrb5DVI9XjEusgQUYnw+u20xOVgilz
	RMylmGf9GB9a0T0UUeIJtHk=
X-Google-Smtp-Source: APBJJlE9CjDjczysCndikK4KHruRlfRKbs6R/4OpgdFd9PZj4DFyd/0KR0P7Feg2LJNYNDHV+FJbCA==
X-Received: by 2002:a81:9242:0:b0:579:f163:db3f with SMTP id j63-20020a819242000000b00579f163db3fmr893893ywg.5.1689964283448;
        Fri, 21 Jul 2023 11:31:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:afbb:9b17:f42e:320f? ([2600:1700:6cf8:1240:afbb:9b17:f42e:320f])
        by smtp.gmail.com with ESMTPSA id d205-20020a0ddbd6000000b00577139f85dfsm1048343ywe.22.2023.07.21.11.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 11:31:23 -0700 (PDT)
Message-ID: <03ef2491-6087-4fd4-caf7-a589d0dfda13@gmail.com>
Date: Fri, 21 Jul 2023 11:31:21 -0700
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
To: Paolo Abeni <pabeni@redhat.com>, Kui-Feng Lee <thinker.li@gmail.com>,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
 <20230718180321.294721-3-kuifeng@meta.com>
 <9743a6cc267276bfeba5b0fdcf7ba9a4077c67e1.camel@redhat.com>
 <3057afe9-ac48-84e2-bd39-b227d2dcbc2f@gmail.com>
 <239ca679597a10b6bc00245c66419f4bdedaff83.camel@redhat.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <239ca679597a10b6bc00245c66419f4bdedaff83.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/21/23 00:14, Paolo Abeni wrote:
> On Thu, 2023-07-20 at 14:36 -0700, Kui-Feng Lee wrote:
>>
>> On 7/20/23 02:32, Paolo Abeni wrote:
>>> On Tue, 2023-07-18 at 11:03 -0700, Kui-Feng Lee wrote:
>>>> Add 10 IPv6 routes with expiration time.  Wait for a few seconds
>>>> to make sure they are removed correctly.
>>>>
>>>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>>>
>>> Same thing as the previous patch.
>>>
>>>> ---
>>>>    tools/testing/selftests/net/fib_tests.sh | 49 +++++++++++++++++++++++-
>>>>    1 file changed, 48 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
>>>> index 35d89dfa6f11..55bc6897513a 100755
>>>> --- a/tools/testing/selftests/net/fib_tests.sh
>>>> +++ b/tools/testing/selftests/net/fib_tests.sh
>>>> @@ -9,7 +9,7 @@ ret=0
>>>>    ksft_skip=4
>>>>    
>>>>    # all tests in this script. Can be overridden with -t option
>>>> -TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
>>>> +TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
>>>
>>> At this point is likely worthy splitting the above line in multiple
>>> ones, something alike:
>>>
>>> TESTS="unregister down carrier nexthop suppress ipv6_notify \
>>> 	ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric
>>> \
>>> 	ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw \
>>> 	rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh \
>>> 	fib6_gc_test"
>>>
>>>>    
>>>>    VERBOSE=0
>>>>    PAUSE_ON_FAIL=no
>>>> @@ -747,6 +747,52 @@ fib_notify_test()
>>>>    	cleanup &> /dev/null
>>>>    }
>>>>    
>>>> +fib6_gc_test()
>>>> +{
>>>> +	setup
>>>> +
>>>> +	echo
>>>> +	echo "Fib6 garbage collection test"
>>>> +	set -e
>>>> +
>>>> +	OLD_INTERVAL=$(sysctl -n net.ipv6.route.gc_interval)
>>>> +	# Check expiration of routes every 3 seconds (GC)
>>>> +	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=3
>>>> +
>>>> +	$IP link add dummy_10 type dummy
>>>> +	$IP link set dev dummy_10 up
>>>> +	$IP -6 address add 2001:10::1/64 dev dummy_10
>>>> +
>>>> +	for i in 0 1 2 3 4 5 6 7 8 9; do
>>> 		$(seq 0 9)
>>>
>>>> +	    # Expire route after 2 seconds
>>>> +	    $IP -6 route add 2001:20::1$i \
>>>> +		via 2001:10::2 dev dummy_10 expires 2
>>>> +	done
>>>> +	N_EXP=$($IP -6 route list |grep expires|wc -l)
>>>> +	if [ $N_EXP -ne 10 ]; then
>>>> +		echo "FAIL: expected 10 routes with expires, got $N_EXP"
>>>> +		ret=1
>>>> +	else
>>>> +	    sleep 4
>>>> +	    N_EXP_s20=$($IP -6 route list |grep expires|wc -l)
>>>> +
>>>> +	    if [ $N_EXP_s20 -ne 0 ]; then
>>>> +		echo "FAIL: expected 0 routes with expires, got $N_EXP_s20"
>>>> +		ret=1
>>>> +	    else
>>>> +		ret=0
>>>> +	    fi
>>>> +	fi
>>>
>>> Possibly also worth trying with a few K of permanent routes, and dump
>>> the time required in both cases?
>>
>> I just realized that I don't know how to measure the time required to do
>> GC without providing additional APIs or exposing numbers to procfs or
>> sysfs. Do you have any idea about this?
> 
> Something like this should do the trick
> 
> sysctl -wq net.ipv6.route.flush=1
> 
> # add routes
> #...
> 
> # delete expired routes synchronously
> sysctl -wq net.ipv6.route.flush=1
> 
> Note that the net.ipv6.route.flush handler uses the 'old' flush value.

May I use bpftrace to measure time spending on writing to procfs?
It is in the order of microseconds. time command doesn't work.

> 
> Cheers,
> 
> Paolo
> 

