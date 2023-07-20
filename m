Return-Path: <netdev+bounces-19662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF075B9A4
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B291C21515
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3FC1BE86;
	Thu, 20 Jul 2023 21:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E3168B0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:36:58 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39147270B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:36:57 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5701810884aso14815887b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689889016; x=1690493816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjkqFELRUweJj7W4kuPP3ZBX7lXRTvvmM7VJK/0CoRQ=;
        b=QSgi1mz+r28ZkeU4aNhNDXOYOO1oiVGcYhpyqexMO7xDvHv1CjSMv3b5OimaPt1b6b
         aA9n9NIMtV7RsujMlBQr7Gu4uwCS3bG4EtJWXvXrDlDMofFHVEP+uqdcLD8mIcU/kPog
         aHQESqHvX3P0DM2xyY8vGV0paXO6dNVjfIU4rt9v9TQChX3EGsFRa0a4eZKYiIVa215D
         XD3uQTG79V5IstI+RPmqyy43tNs9iz/d6cEE7C+jbThlIgmWLTApQaU2GNEaUdDkns4R
         qPA71LahMf4CCb+3QPQLtXF73O4J6rt+CWJPyN/gAXEaw8i2TFtuMSBzT4+I/ix7BZq7
         ++Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889016; x=1690493816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjkqFELRUweJj7W4kuPP3ZBX7lXRTvvmM7VJK/0CoRQ=;
        b=VR97wo3LXPyLtOY0qG9xOHXBlE3We5MVgWfTDPD+QkEJkdVZ58VZWdS6/VRi5mOD95
         DdLFcekhfCrOjN/JM4O9B/r2/YBgi1WqQ6JfFb2wMU0ceWvawgz7fwPktJj1kxd2LNGY
         1aJtZSxAgzYHHW69jzvUagg/HkRGZePGW2xGMYLPzTXfPX0jdwASMQnKRJrbMpfEg6IB
         DbTzE0mZNrhG1hHm/zriTeSfVvBMgIQuLOc9WSbPiQsSSGwsj3cRmpQ/7p2yRlSSI33B
         tQmHX8GdzGJ/Z47hv71PNHFA52OgdqjBgO8kqhP2GPc0TN/pANLf0+7gE4YmCfBujryy
         qYTw==
X-Gm-Message-State: ABy/qLYBxKHFCRj0VxCsGyPbxgLtwbctz+WznFE7xxSr2Q7jb01Azi8I
	PSP1B6sI3fvTNDfopZihkk9Ec3xBoJQ=
X-Google-Smtp-Source: APBJJlFR/+PajDnkyW97RttxOakoGCroyRWndAZIQW/p8mk4E2vANXpim4qYMwZnn/iEHRsVnclgig==
X-Received: by 2002:a81:4ecd:0:b0:581:8d25:ff85 with SMTP id c196-20020a814ecd000000b005818d25ff85mr318965ywb.3.1689889016349;
        Thu, 20 Jul 2023 14:36:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:4771:fc2f:6356:aa8e? ([2600:1700:6cf8:1240:4771:fc2f:6356:aa8e])
        by smtp.gmail.com with ESMTPSA id l6-20020a0de206000000b0057a79da2009sm474497ywe.16.2023.07.20.14.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 14:36:55 -0700 (PDT)
Message-ID: <3057afe9-ac48-84e2-bd39-b227d2dcbc2f@gmail.com>
Date: Thu, 20 Jul 2023 14:36:54 -0700
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

I just realized that I don't know how to measure the time required to do 
GC without providing additional APIs or exposing numbers to procfs or 
sysfs. Do you have any idea about this?

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

