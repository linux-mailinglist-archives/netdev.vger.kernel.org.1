Return-Path: <netdev+bounces-31564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CA78ECA5
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11E01C20A3F
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971B9471;
	Thu, 31 Aug 2023 11:58:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DE63CC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:58:54 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DBBC5
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:58:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so7244545e9.3
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1693483130; x=1694087930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=naCriicqG+9E/gvs/YTnOWIsGi2x8P8Y5A9LW0ufG+s=;
        b=YxhVtPv9xTuSWuUnOi79D28h1akQhunuUAVHagbhPl99o24askCaSnnJIiGbTTvgTk
         BdAtZ2IrzNpMKrQrCdWKATHbLnB9+sS8/0nIps1/VGcWMZ2vVmREiS/MSjA7mCpipjb1
         9ORKzxQYYjw9oInRQNG8FvQBDPJ0EEPqxGAc8RRMd8PfnqUwCSO17GbWyc2g/TeBYZL9
         DbD3bbO2x98e3djKlDTmiDxxFbsUTypnQ+rZn7LSZ4tFW57Qx87JmV1nxfLkRd2ZA65+
         qBITIma72ypkbmQ2ksD50KHZqBsccO+0ZAVul+ttq5lrNrrT59NRZa+7zhcTYYiHY4mg
         OQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693483130; x=1694087930;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naCriicqG+9E/gvs/YTnOWIsGi2x8P8Y5A9LW0ufG+s=;
        b=L0CgxtDOdzzNreyHgAkISbmV8up8SvGDJN/WfVtxQ9VikC4YpwMpnvJCCOFqGBGfgU
         E4N8Q+5Kfd7EnDeLVOyebIVaTRf2kS5g/btRkLjgT5xMaj+hRPE4sg+kTkrA6IPBRIi8
         AwvraNzqbaHI25wXroibzhxeT1w5Xe+nA8u5aSXz5vp2g7qhIXXmkFh4QXjBRuxlAZud
         5mwlIyxHPHDXEx43Au3ES10udAAmUgMfu3+ZgEfX3nhpi4DY+yIOi1kUHAaUslcB93np
         BG78dtZLRTsMXaJJe4YQYeokLJYx/WLwshxFp1KCNOv8gak14nU2G7vuxnS130TZa3SB
         Lj9g==
X-Gm-Message-State: AOJu0YzUtc/hBBq7WuNEaa//o5EmxXFPzj4t3o5rWPR8rAxPjmAEO/X8
	V2aPSSy58vOsmQxKw7Wrlrbsvg==
X-Google-Smtp-Source: AGHT+IHufI2mn2rvEUwBRD4j9fuODEQuTc9N+TxSlT45FxseYUfoy/661eSNLkI+DOvsFJikKE/Kdw==
X-Received: by 2002:a5d:40c8:0:b0:31d:d58a:4b5 with SMTP id b8-20020a5d40c8000000b0031dd58a04b5mr3792862wrq.22.1693483130003;
        Thu, 31 Aug 2023 04:58:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:8ad8:2775:884a:f43f? ([2a01:e0a:b41:c160:8ad8:2775:884a:f43f])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d4452000000b0031431fb40fasm2015932wrr.89.2023.08.31.04.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 04:58:49 -0700 (PDT)
Message-ID: <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
Date: Thu, 31 Aug 2023 13:58:48 +0200
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
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Thomas Haller <thaller@redhat.com>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com> <ZPBn9RQUL5mS/bBx@Laptop-X1>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZPBn9RQUL5mS/bBx@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 31/08/2023 à 12:14, Hangbin Liu a écrit :
> Hi Nicolas,
> On Thu, Aug 31, 2023 at 10:17:19AM +0200, Nicolas Dichtel wrote:
>>>>> So let's skip counting the different type and protocol routes as siblings.
>>>>> After update, the different type/protocol routes will not be merged.
>>>>>
>>>>> + ip -6 route show table 100
>>>>> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
>>>>> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
>>>>>
>>>>> + ip -6 route show table 200
>>>>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
>>>>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium
>>>>
>>>> This seems wrong. The goal of 'ip route append' is to add a next hop, not to
>>>> create a new route. Ok, it adds a new route if no route exists, but it seems
>>>> wrong to me to use it by default, instead of 'add', to make things work magically.
>>>
>>> Legacy API; nothing can be done about that (ie., that append makes a new
>>> route when none exists).
>>>
>>>>
>>>> It seems more correct to return an error in these cases, but this will change
>>>> the uapi and it may break existing setups.
>>>>
>>>> Before this patch, both next hops could be used by the kernel. After it, one
>>>> route will be ignored (the former or the last one?). This is confusing and also
>>>> seems wrong.
>>>
>>> Append should match all details of a route to add to an existing entry
>>> and make it multipath. If there is a difference (especially the type -
>>> protocol difference is arguable) in attributes, then they are different
>>> routes.
>>>
>>
>> As you said, the protocol difference is arguable. It's not a property of the
>> route, just a hint.
>> I think the 'append' should match a route whatever the protocol is.
>> 'ip route change' for example does not use the protocol to find the existing
>> route, it will update it:
>>
>> $ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1
>> $ ip -6 route
>> 2003:1:2:3::/64 via 2001::2 dev eth1 metric 1024 pref medium
>> $ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp
>> $ ip -6 route
>> 2003:1:2:3::/64 via 2001::2 dev eth1 proto bgp metric 1024 pref medium
>> $ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel
>> $ ip -6 route
>> 2003:1:2:3::/64 via 2001::2 dev eth1 proto kernel metric 1024 pref medium
> 
> Not sure if I understand correctly, `ip route replace` should able to
> replace all other field other than dest and dev. It's for changing the route,
> not only nexthop.
>>
>> Why would 'append' selects route differently?
> 
> The append should also works for a single route, not only for append nexthop, no?
I don't think so. The 'append' should 'join', not add. Adding more cases where a
route is added instead of appended doesn't make the API clearer.

With this patch, it will be possible to add a new route with the 'append'
command when the 'add' command fails:
$ ip -6 route add local 2003:1:2:3::/64 via 2001::2 dev eth1 table 200
$ ip -6 route add unicast 2003:1:2:3::/64 via 2001::2 dev eth1 table 200
RTNETLINK answers: File exists

$ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp table 200
$ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel table 200
RTNETLINK answers: File exists

This makes the API more confusing and complex. And I don't understand how it
will be used later. There will be 2 routes on the system, but only one will be
used, which one? This is confusing.

> 
>>
>> This patch breaks the legacy API.
> 
> As the patch's description. Who would expect different type/protocol route
> should be merged as multipath route? I don't think the old API is correct.
The question is not 'who expect', but 'is there some systems somewhere that rely
on this (deliberately or not)'.
Frankly, the protocol is just informative, so I don't see why it is a problem to
ignore it with the 'append' command.
For the type, it is weird, for sure. Rejecting the command seems better than
duplicating routes. Which route is used by the stack?


Regards,
Nicolas

