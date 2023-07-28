Return-Path: <netdev+bounces-22281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64196766DCC
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308B11C218A0
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051F12B9B;
	Fri, 28 Jul 2023 13:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161F12B82
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 13:01:59 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB43AA5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 06:01:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e742a787so1439025f8f.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1690549316; x=1691154116;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K91+vIAjx+eJtOJKnpXBwW6BgbBkRzfMC9sOwU5+89E=;
        b=bYmsdKG5T6tkHyD/Yl61CHji1fsmDvPCfL7AQIoa9WzpMLY5Jz3P62uGMpitlsU95g
         UIyMxaa434F6CatdC2yH9ZMjhJ7+KXRkY4axAqbIvq3yWpgcemhiNspNBBtrBDxORios
         2i8mN3mwjkUR1C85mfcomJvjl9K4pERyHcgZ9oKyNLYSBk4kZPHspuoS5rsJKoIs5ZAt
         FjWiuiOUyhWV9abbCBvmTsrwZ8ngsIf8NVeAo4uz6X3ZV2pdbiypPTv/tF1axfLszatw
         qsrP83cJ6FJ43iLYXQBc3b+R3lHuuZKkXbfuYyxgbvRWd2GBcrlitGE+T1YO1SLoeTem
         /T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549316; x=1691154116;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K91+vIAjx+eJtOJKnpXBwW6BgbBkRzfMC9sOwU5+89E=;
        b=VRwxG4VMdaUr3ObAKyRMhefcX1KM7oCEJ1GWjlxd10RM0P2LcUYWFK98cYMYW3YDUQ
         g/KvrzDhQh6uDxaTYWzqR6GVEYmpe213pk4NrrrancXToj57NvfT73eumfl9oKWP4tUI
         nhSwcyGU8BiO+yRfbQ6doyxA/q619YJYj9Ulxa2kk4HQxibz+OvrNTLcaT/qCKjlK3M/
         p49ajQwBRAzZRhv5HNKC/s0nYX0vr+28CPPXtNfPHI+QK3C4T3hgRtOtULiba55haExY
         +R/Me19rMA2EDaHl88t8c+i+V0za/mL8HhFVwX/RhaMI4YZR1vkButgeFfEvXjIkB1Gs
         bS1g==
X-Gm-Message-State: ABy/qLaBeDzXuXqcYJCm78AMCXvKWzrqVb4BzteDFPoeFC3BGOJLGdY3
	mPMuy+WVU/SimZiY3EtXGxUstw==
X-Google-Smtp-Source: APBJJlEKR73KOTfVePRnYPxwSUdSgFcnb1bYO5Z/6oMBSEOqnCWTXK9ZGX4HIRvWAAawskkTl5CtCg==
X-Received: by 2002:a5d:4292:0:b0:313:e2e3:d431 with SMTP id k18-20020a5d4292000000b00313e2e3d431mr4408279wrq.12.1690549315688;
        Fri, 28 Jul 2023 06:01:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:24d9:fc5f:8fea:8b? ([2a01:e0a:b41:c160:24d9:fc5f:8fea:8b])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003fb739d27aesm7042429wmi.35.2023.07.28.06.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:01:28 -0700 (PDT)
Message-ID: <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
Date: Fri, 28 Jul 2023 15:01:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
To: Stephen Hemminger <stephen@networkplumber.org>,
 Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <ZLZnGkMxI+T8gFQK@shredder> <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1> <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20230725093617.44887eb1@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 25/07/2023 à 18:36, Stephen Hemminger a écrit :
> On Tue, 25 Jul 2023 16:20:59 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
>> On Mon, Jul 24, 2023 at 08:48:20AM -0700, Stephen Hemminger wrote:
>>> On Mon, 24 Jul 2023 16:56:37 +0800
>>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>>   
>>>> The NetworkManager keeps a cache of the routes. Missing/Wrong events mean that
>>>> the cache becomes inconsistent. The IPv4 will not send src route delete info
>>>> if it's bond to other device. While IPv6 only modify the src route instead of
>>>> delete it, and also no notify. So NetworkManager developers complained and
>>>> hope to have a consistent and clear notification about route modify/delete.  
>>>
>>> Read FRR they get it right. The routing daemons have to track kernel,
>>> and the semantics have been worked out for years.  
>>
>> Yes, normally the routing daemon need to track kernel. On the other hand,
>> the kernel also need to make a clear feedback. The userspace developers may
>> not know the kernel code very well. The unclear/inconsistent notification
>> would make them confused.
> 
> Right, that should be addressed by clearer documentation of the semantics
> and the rational.
> 
Frankly, it's quite complex, there are corner cases.

When an interface is set down, the routes associated to this interface should be
removed. This is the simple part.
But for ecmp routes, there are several cases:
 - if all nh use this interface: the routes are deleted by the kernel;
 - if only some nh uses this interface :
   + if all other nh already point to a down interface: the route are deleted by
the kernel;
   + if at least one nh points to an up interface: the nh are temporarily disabled.

Managing a cache with this is not so obvious ;-)

My two cents,
Nicolas

