Return-Path: <netdev+bounces-24207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A42276F3CA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750531C21561
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28DF2593F;
	Thu,  3 Aug 2023 20:04:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535363BC
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:04:12 +0000 (UTC)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7154215
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:04:10 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3493862cfb1so5288665ab.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691093050; x=1691697850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yB7u195mr9vI+1R+T35BIrWCfcUHOGaguPdO3WgU8Hg=;
        b=FX6VrcdCRsO7IYpPLgNTX9CWjDX604dXCbleAfdAM9yGyY8aTs7iE9Tzq95eYSaaak
         IC4OIRDEQfQokcJFBdXefQ+RTCJ+kU4T8FBKULSaKu72wIZl9KNqR9IoWoN1RfbbfXfA
         4+Id+ebKe53dZBuVbCrOfBe6kyvGJnvuKFRc7gF5MdmkQjqhDiFMkfiDeiRblgS36zdA
         BuCnXJQuv+zS3VE/nbdTFIwPLmM+96noVxXTtrZEKXhFQB+PLmZkTG/Rs4DJ9WYViGbJ
         BVwFJ9SYk/tAc+0rMwNcxW9dIMsZjzlWloR/VuvmO2AXDUWki/PxkoGT3kEWusMmtX4s
         xi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691093050; x=1691697850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yB7u195mr9vI+1R+T35BIrWCfcUHOGaguPdO3WgU8Hg=;
        b=c8GuyJPyBJrZOPRi8ZEpRVsmnBkNoSHeFrAyWXxqI6pmTt3sLbIY0cRiyWeyUu39XJ
         TNWkkMQ4CZoA91Vc6GBJHEemkHae/7U19HNmQyP0YXFS0cF6BW3gVDHH+ymePnpCRoaY
         gu3QX/lhAVCqTFQ43PtFYYkg1ypDjnS94tI1cxgDoVojpsEEoOi9sBo4PeJLnRhDNO99
         hPboe4RVuuIlrnaPMU6jFZkJv8eVFnpZIVFnRA6RDdtwDQpTAr6dmR19G+v2mMyEi4i0
         wAKbu4hbavpMirsw4Xo85Ts840BWaHixVbDDFk1cJLBLWx6LOhhwoBVhqfHlYoogOQHW
         v9YA==
X-Gm-Message-State: ABy/qLbGyw9mV4bKobC3He28qyJRQCl5KsR1l3oSyxfLa4N39Mb4hrL/
	wAWqo9ClzCCGB+Z345gu2IB2hsTypcE=
X-Google-Smtp-Source: APBJJlEUjwXOlgEAMt4MFK3fqtYvBqn+dthBwkNUl8Bc3YEc+jRHBqytzcVKz8QBMgbRUnm+qjV3mg==
X-Received: by 2002:a05:6e02:c72:b0:348:c940:184c with SMTP id f18-20020a056e020c7200b00348c940184cmr18137848ilj.11.1691093049978;
        Thu, 03 Aug 2023 13:04:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:c07f:1e98:63f3:8107? ([2600:1700:6cf8:1240:c07f:1e98:63f3:8107])
        by smtp.gmail.com with ESMTPSA id g95-20020a25a4e8000000b00d0dfab2e86csm139227ybi.37.2023.08.03.13.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 13:04:09 -0700 (PDT)
Message-ID: <6390faf3-5b91-2534-0d53-b5bfb213c6c9@gmail.com>
Date: Thu, 3 Aug 2023 13:04:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v5 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: kuifeng@meta.com
References: <20230802004303.567266-1-thinker.li@gmail.com>
 <20230802004303.567266-3-thinker.li@gmail.com>
 <85c6c94e-1243-33ae-dadd-9bcdd7d328d1@kernel.org>
 <65a8a91f-65af-e948-1386-fc7d0d413b77@gmail.com>
 <94946d6e-6ca1-84b2-fc4f-619390f9c4fe@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <94946d6e-6ca1-84b2-fc4f-619390f9c4fe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 12:49, David Ahern wrote:
> On 8/2/23 10:09 PM, Kui-Feng Lee wrote:
>>
>>
>> On 8/2/23 19:06, David Ahern wrote:
>>> On 8/1/23 6:43 PM, thinker.li@gmail.com wrote:
>>> \> @@ -747,6 +750,97 @@ fib_notify_test()
>>>>        cleanup &> /dev/null
>>>>    }
>>>>    +fib6_gc_test()
>>>> +{
>>>> +    echo
>>>> +    echo "Fib6 garbage collection test"
>>>> +
>>>> +    STRACE=$(which strace)
>>>> +    if [ -z "$STRACE" ]; then
>>>> +        echo "    SKIP: strace not found"
>>>> +        ret=$ksft_skip
>>>> +        return
>>>> +    fi
>>>> +
>>>> +    EXPIRE=10
>>>> +
>>>> +    setup
>>>> +
>>>> +    set -e
>>>> +
>>>> +    # Check expiration of routes every 3 seconds (GC)
>>>> +    $NS_EXEC sysctl -wq net.ipv6.route.gc_interval=300
>>>> +
>>>> +    $IP link add dummy_10 type dummy
>>>> +    $IP link set dev dummy_10 up
>>>> +    $IP -6 address add 2001:10::1/64 dev dummy_10
>>>> +
>>>> +    $NS_EXEC sysctl -wq net.ipv6.route.flush=1
>>>> +
>>>> +    # Temporary routes
>>>> +    for i in $(seq 1 1000); do
>>>> +        # Expire route after $EXPIRE seconds
>>>> +        $IP -6 route add 2001:20::$i \
>>>> +        via 2001:10::2 dev dummy_10 expires $EXPIRE
>>>> +    done
>>>> +    N_EXP=$($IP -6 route list |grep expires|wc -l)
>>>> +    if [ $N_EXP -ne 1000 ]; then
>>>
>>> race condition here ... that you can install all 1000 routes and then
>>> run this command before any expire. 10 seconds is normally more than
>>> enough time, but on a loaded server it might not be. And really it does
>>> not matter. What matters is that you install routes with an expires and
>>> they disappear when expected - and I believe the flush below should not
>>> be needed to validate they have been removed.
>>
>> Without the flush below, the result will be very unpredictable or need
>> to wait longer, at least two gc_interval seconds. We can
>> shorten gc_interval to 10s, but we need to wait for 20s to make it
>> certain. It is more predictable with the flush.
>>
>> About race condition, I will remove the check.  Just like what you said,
>> it is not necessary.
> 
> you do not need to measure how long it takes to remove expired routes in
> a selftest; you are only testing that in fact the expired routes are
> removed.
> 
> EXPIRES=1
> install routes
> # wait 2x expires time for removal
> sleep 2
> verify routes are removed.
Got it!

