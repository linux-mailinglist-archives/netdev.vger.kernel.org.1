Return-Path: <netdev+bounces-31516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA778E7BB
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43A12813D3
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71A6FCA;
	Thu, 31 Aug 2023 08:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9C6FBD
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:17:24 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05311A4
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:17:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31aeedbb264so405087f8f.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1693469841; x=1694074641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=omi2x8HAjaQOtFgKTUdzMFLm5NYOyArcbTM6HLpJX+M=;
        b=cJwRhcjgkInl04W2twubZMCtRzYPUzELWJ1WNpPbkVMo8eIa3oFeOPQd9hZokEebc5
         /ySWeyxudkBvRJGAR2H/FTJ8utQ4Gxlyd1QiAjX+Po0bo4eyWP+59iMgDseXGC4GWs6k
         gBAlWTWKt1GwsV7DW6OgrBhW9Ei1DZhg2O7o3YFIJGYgH4zcSKADDxLIsj5QGSKnvqIx
         v2dXtGtbLjl9DVJjrVUKmfiB3zVU+l2xeVyEqY44n5k2RcqjV2R6O9JSErU9aXfGwrD5
         Q1MyKmT+ktVMk92fReCDqEhre1yInsWgDToL+nJzi/gGrnU2DwhkX7xY0HgFOvGGancM
         7Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693469841; x=1694074641;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omi2x8HAjaQOtFgKTUdzMFLm5NYOyArcbTM6HLpJX+M=;
        b=dGhlNncGqtiJzJIw0DW5OxWi2sS+K2kAEBnQaHpQ9AjTwOu8JgpbIe8NAmCrkvtnb8
         lBgipKfO2VxgEkEPC4/n0GGE3dZJMb4IUhnO5eWhDxrXM0MhMQaO2evw1zDFrDYyHIPj
         gosr7H7OFNLpGzd/C0Rfju4764iOXfB3h1Uey1yAfDSvbfu7SXxo8+a3nPGA/TLER9sQ
         6TD/MIHPpeqjl9bBCQve1CC1I9h/n6QuqORa9zM8PBAewT7Nn01b+XoINoZmnhjl+5cx
         AT1LJmksjfBks77mu5GoRrqA2UNlunmAL8V5DF/TEVOCHG/eKiAMNg//HXqh4ZOJ7TqT
         7k8Q==
X-Gm-Message-State: AOJu0YxR/Smem5siB4qIj2Q6QO+7qezUdGsxeLp2A+o2PkZoY6yBdGDK
	njGRul5GiHvi1ZJMtNAULCFK4OKPIKXBn/OPbnw=
X-Google-Smtp-Source: AGHT+IFJbSzhseqdOp4JB2ARKmuSPEPJu1T8krxx1MT9N16W6Y/1Jr6suLBYBSEcUHHqesImkVvpug==
X-Received: by 2002:a5d:568a:0:b0:315:9993:1caa with SMTP id f10-20020a5d568a000000b0031599931caamr3236306wrv.12.1693469841132;
        Thu, 31 Aug 2023 01:17:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:8ad8:2775:884a:f43f? ([2a01:e0a:b41:c160:8ad8:2775:884a:f43f])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0031ad2663ed0sm1338533wri.66.2023.08.31.01.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:17:20 -0700 (PDT)
Message-ID: <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com>
Date: Thu, 31 Aug 2023 10:17:19 +0200
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
To: David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Thomas Haller <thaller@redhat.com>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 30/08/2023 à 20:57, David Ahern a écrit :
> On 8/30/23 9:29 AM, Nicolas Dichtel wrote:
>> Le 30/08/2023 à 08:15, Hangbin Liu a écrit :
>>> Different with IPv4, IPv6 will auto merge the same metric routes into
>>> multipath routes. But the different type and protocol routes are also
>>> merged, which will lost user's configure info. e.g.
>>>
>>> + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
>>> + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
>>> + ip -6 route show table 100
>>> local 2001:db8:103::/64 metric 1024 pref medium
>>>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>>>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
>>>
>>> + ip route add 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel table 200
>>> + ip route append 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp table 200
>>> + ip -6 route show table 200
>>> 2001:db8:104::/64 proto kernel metric 1024 pref medium
>>>         nexthop via 2001:db8:101::10 dev dummy1 weight 1
>>>         nexthop via 2001:db8:101::10 dev dummy2 weight 1
>>>
>>> So let's skip counting the different type and protocol routes as siblings.
>>> After update, the different type/protocol routes will not be merged.
>>>
>>> + ip -6 route show table 100
>>> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
>>> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
>>>
>>> + ip -6 route show table 200
>>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy1 proto kernel metric 1024 pref medium
>>> 2001:db8:104::/64 via 2001:db8:101::10 dev dummy2 proto bgp metric 1024 pref medium
>>
>> This seems wrong. The goal of 'ip route append' is to add a next hop, not to
>> create a new route. Ok, it adds a new route if no route exists, but it seems
>> wrong to me to use it by default, instead of 'add', to make things work magically.
> 
> Legacy API; nothing can be done about that (ie., that append makes a new
> route when none exists).
> 
>>
>> It seems more correct to return an error in these cases, but this will change
>> the uapi and it may break existing setups.
>>
>> Before this patch, both next hops could be used by the kernel. After it, one
>> route will be ignored (the former or the last one?). This is confusing and also
>> seems wrong.
> 
> Append should match all details of a route to add to an existing entry
> and make it multipath. If there is a difference (especially the type -
> protocol difference is arguable) in attributes, then they are different
> routes.
> 

As you said, the protocol difference is arguable. It's not a property of the
route, just a hint.
I think the 'append' should match a route whatever the protocol is.
'ip route change' for example does not use the protocol to find the existing
route, it will update it:

$ ip -6 route add 2003:1:2:3::/64 via 2001::2 dev eth1
$ ip -6 route
2003:1:2:3::/64 via 2001::2 dev eth1 metric 1024 pref medium
$ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol bgp
$ ip -6 route
2003:1:2:3::/64 via 2001::2 dev eth1 proto bgp metric 1024 pref medium
$ ip -6 route change 2003:1:2:3::/64 via 2001::2 dev eth1 protocol kernel
$ ip -6 route
2003:1:2:3::/64 via 2001::2 dev eth1 proto kernel metric 1024 pref medium

Why would 'append' selects route differently?

This patch breaks the legacy API.

