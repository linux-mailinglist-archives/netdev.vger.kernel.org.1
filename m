Return-Path: <netdev+bounces-31711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E89B78FAFB
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 11:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C33F1C20C0B
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5D5A92B;
	Fri,  1 Sep 2023 09:36:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CB881F
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 09:36:56 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7CEC0
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 02:36:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so18616455e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1693561013; x=1694165813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXpyhC+n0diztdcQvnYf/HXUuvEYhyEmGkMlGgW+ITg=;
        b=gqn0560zn94J8DXIqpJzC5Mc2KqMH9GHyqlW96upJtiK2PNwWc1KTaFtqP+SLAigCs
         wfAmB8LAhH25gjKRAJpElvh1t6kHwuaU8PRyYtXJpzhCr5lNQWWf/WhoTTToR1NkJAYg
         7FwkRXagmbbMeH5C/6Wg5I2v0MgRYUh8yGLyDDFLcVIUgdv2cOR+Hcowz/NUVRE0WF2B
         7rtG5LhRWbeaESI9WX7B0utgegeDfBJdwvfdzACC7MBSr4RwGehuvm+YZl6jb1P0p4hD
         wJqMoo82RIPntyAbBYplwHt3u7dg7Q36UxMTAv0OlBB8q6sUD458pDxvPPG5bJ1638BI
         MMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561013; x=1694165813;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXpyhC+n0diztdcQvnYf/HXUuvEYhyEmGkMlGgW+ITg=;
        b=Zdjhlrt8gW4uiNmpvPkJq3EOGZfgtwHFmKbygm1oWY1IkGGQYjeuFoPVJorGoyg1AM
         7qnvjXLBvB0uXAu1XKzQQ7/fKpF2Z36uvzkwsnspgQUeRw3p0VvAIQgK0tV1oCrAP/pu
         qKPI9lTghB9GyWuelwlDWDb+ORZzCmjFQLVQQzA96iOuFWUk59YAUJRD0mjxoDahBW9t
         47eTWAkhxejfqcq050WiOVF7Yo5a2FmJ/QnPT5645Ad0e4MKyDw0N1cdEB0Aoyz6IyiL
         f7gf4JVkfJVia5Qt209UksPalWf1KNavhyVowE6C+e8KbfgG8ru6PG90LcA1uHgI/3kS
         yPsg==
X-Gm-Message-State: AOJu0YzXNbA8jSQ3ZvCUqT1jNKlhpNjiyebyot3/StZ7B53AvLzwgVVk
	pWnKfuNQrX++CQGpkNLiIuizAA==
X-Google-Smtp-Source: AGHT+IGEr0mRlMffpmzaZx6FN4CV4z98kBTPd0LI4iIHk7ZKmYJD6ulocOwa9SF4UFWVXH0eNWkJAQ==
X-Received: by 2002:a05:600c:3646:b0:3fb:ffa8:6d78 with SMTP id y6-20020a05600c364600b003fbffa86d78mr1470330wmq.36.1693561013032;
        Fri, 01 Sep 2023 02:36:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:bc9d:3bc7:e1c2:55da? ([2a01:e0a:b41:c160:bc9d:3bc7:e1c2:55da])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b003fbca942499sm7572163wmj.14.2023.09.01.02.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 02:36:52 -0700 (PDT)
Message-ID: <bf3bb290-25b7-e327-851a-d6a036daab03@6wind.com>
Date: Fri, 1 Sep 2023 11:36:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
To: David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Thomas Haller <thaller@redhat.com>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com> <ZPBn9RQUL5mS/bBx@Laptop-X1>
 <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
 <2546e031-f189-e1b1-bc50-bc7776045719@kernel.org>
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <2546e031-f189-e1b1-bc50-bc7776045719@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 31/08/2023 à 20:27, David Ahern a écrit :
> On 8/31/23 5:58 AM, Nicolas Dichtel wrote:
>> Le 31/08/2023 à 12:14, Hangbin Liu a écrit :
>>> Hi Nicolas,
>>> On Thu, Aug 31, 2023 at 10:17:19AM +0200, Nicolas Dichtel wrote:
>>>>>>> So let's skip counting the different type and protocol routes as siblings.
>>>>>>> After update, the different type/protocol routes will not be merged.
>>>>>>>
>>>>>>> + ip -6 route show table 100
>>>>>>> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
>>>>>>> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
>>>>>>>
>>>>>>> + ip -6 route show table 200
>>>>>>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
>>>>>>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium
>>>>>>
>>>>>> This seems wrong. The goal of 'ip route append' is to add a next hop, not to
>>>>>> create a new route. Ok, it adds a new route if no route exists, but it seems
>>>>>> wrong to me to use it by default, instead of 'add', to make things work magically.
>>>>>
>>>>> Legacy API; nothing can be done about that (ie., that append makes a new
>>>>> route when none exists).
>>>>>
>>>>>>
>>>>>> It seems more correct to return an error in these cases, but this will change
>>>>>> the uapi and it may break existing setups.
>>>>>>
>>>>>> Before this patch, both next hops could be used by the kernel. After it, one
>>>>>> route will be ignored (the former or the last one?). This is confusing and also
>>>>>> seems wrong.
>>>>>
>>>>> Append should match all details of a route to add to an existing entry
>>>>> and make it multipath. If there is a difference (especially the type -
>>>>> protocol difference is arguable) in attributes, then they are different
>>>>> routes.
>>>>>
>>>>
>>>> As you said, the protocol difference is arguable. It's not a property of the
>>>> route, just a hint.
>>>> I think the 'append' should match a route whatever the protocol is.
>>>> 'ip route change' for example does not use the protocol to find the existing
>>>> route, it will update it:
>>>>
>>>> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1
>>>> $ ip -6 route
>>>> 2003:1:2:3::/64 via 2001::2 dev eth1 metric 1024 pref medium
>>>> $ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp
>>>> $ ip -6 route
>>>> 2003:1:2:3::/64 via 2001::2 dev eth1 proto bgp metric 1024 pref medium
>>>> $ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel
>>>> $ ip -6 route
>>>> 2003:1:2:3::/64 via 2001::2 dev eth1 proto kernel metric 1024 pref medium
>>>
>>> Not sure if I understand correctly, `ip route replace` should able to
>>> replace all other field other than dest and dev. It's for changing the route,
>>> not only nexthop.
>>>>
>>>> Why would 'append' selects route differently?
>>>
>>> The append should also works for a single route, not only for append nexthop, no?
>> I don't think so. The 'append' should 'join', not add. Adding more cases where a
>> route is added instead of appended doesn't make the API clearer.
>>
>> With this patch, it will be possible to add a new route with the 'append'
>> command when the 'add' command fails:
>> $ ip -6 route add local 2003:1:2:3::/64 via 2001::2 dev eth1 table 200
>> $ ip -6 route add unicast 2003:1:2:3::/64 via 2001::2 dev eth1 table 200
>> RTNETLINK answers: File exists
>>
>> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp table 200
>> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel table 200
>> RTNETLINK answers: File exists
>>
>> This makes the API more confusing and complex. And I don't understand how it
>> will be used later. There will be 2 routes on the system, but only one will be
>> used, which one? This is confusing.
>>
>>>
>>>>
>>>> This patch breaks the legacy API.
>>>
>>> As the patch's description. Who would expect different type/protocol route
>>> should be merged as multipath route? I don't think the old API is correct.
>> The question is not 'who expect', but 'is there some systems somewhere that rely
>> on this (deliberately or not)'.
>> Frankly, the protocol is just informative, so I don't see why it is a problem to
>> ignore it with the 'append' command.
>> For the type, it is weird, for sure. Rejecting the command seems better than
>> duplicating routes. Which route is used by the stack?
>>
>>
> 
> Part of my intent with fib_tests.sh was to document the legacy meaning
> of 'append, prepend, replace, and change' options while also providing a
> test script to detect changes that cause a regression.
Yes, it's a good idea for sure.

> 
> I do agree now that protocol is informative (passthrough from the kernel
> perspective) so not really part of the route. That should be dropped
> from the patch leaving just a check on rt_type as to whether the routes
> are different. From there the append, prepend, replace and change
> semantics should decide what happens (ie., how the route is inserted).
Right. What can guide us is the meaning/concept/benefit of having this kind of
routing table:
local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium

I don't understand how this is used/useful. It's why I ask for the use case/goal
of this patch.
How does the user know which route is used?


Regards,
Nicolas

