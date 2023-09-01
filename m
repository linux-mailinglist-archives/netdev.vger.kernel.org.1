Return-Path: <netdev+bounces-31713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84478FB70
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 11:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F60628196E
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03EA938;
	Fri,  1 Sep 2023 09:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2EE945F
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 09:50:17 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3BC1BF
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 02:50:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50091b91a83so3059670e87.3
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 02:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1693561814; x=1694166614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fRhrrC0CcYm0S2Ol0Rrb4q5IGiP8ArBUFRdwFIXIAnA=;
        b=G4jC0ZYJc/yf9N96tAc9pD0MlJFxbxoejRm6cfM0Ifw74wNfyjqo3bVRARxS0of5ix
         DJmhoHSYpt06UiLsyPihtR7z/2FS1Pxl+MsVL7zj5G05h249HEB1+HL+kxCzU3cP+Zc7
         mEQB4wBUK6px5bUAj+3asNp84DyCp0DWXhs0u5XryEYcJ3NOWg+y2sceXFQuP0yMidwp
         L4XcaZKD77MfSjcSnj/nWOuL5YtQHDALKCshRwKvSwRxCdLY7XoJU4Km4ehUlwKPZ5Tk
         lxvYsAKSwS7h+jRuBhCxdZrCS0mfk3slZG1Btar2mvA0sVCAqU9S9ZN9ADxEDCHYyIcR
         jeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561814; x=1694166614;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRhrrC0CcYm0S2Ol0Rrb4q5IGiP8ArBUFRdwFIXIAnA=;
        b=YVl/OOrCCjtbuiiYt+8QnDf8fkXmG+swgBAATJWAeRMJafRoWpJBfkR4y7DVtyQ+9X
         UWWL9ylnPoX9sWDuxnKxxPtxGmtX0nOL9PNLhX6q+3LsQ27tteo4Y8WEm87pT3Ze0giR
         T8BIpb9dHmNvRoO9d29vOF/aIBKtHiUI8mWGhI0KITcs12RJaUaIdQczt4dJCliXNCDj
         EhWIBCCahAMGQb77aFppb6E+bFeq8yE8iU+KJC+Isnxm+GFno6y12FvRuwXXPVIGsTE4
         LrMdJKoJyE2M2GFIqKREnxU4whaB8xn1O52YAdY66LQFRnmVss4x0TO56V+oeZeMyyHX
         MtxA==
X-Gm-Message-State: AOJu0YxIQioDH307B1wLymzWDT/uTwZ4JAr1BaFvqVvxDoWoj4o/hSxO
	0nihBAkUtqo0Hi8+MT/XH+kl8++SS+8jcVRIOp4=
X-Google-Smtp-Source: AGHT+IFETNrn1tEY7z71LHHcy7bZgdCkkR6rcscVT2JmLHYV+tvt+jRXAHu6mFAeRktxxMbwN72/Lg==
X-Received: by 2002:a19:690f:0:b0:500:bddc:56d5 with SMTP id e15-20020a19690f000000b00500bddc56d5mr1028123lfc.37.1693561813638;
        Fri, 01 Sep 2023 02:50:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:bc9d:3bc7:e1c2:55da? ([2a01:e0a:b41:c160:bc9d:3bc7:e1c2:55da])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c299000b00400268671c6sm4341294wmd.13.2023.09.01.02.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 02:50:13 -0700 (PDT)
Message-ID: <b4b81499-d53a-d697-4cb6-20338606d68a@6wind.com>
Date: Fri, 1 Sep 2023 11:50:12 +0200
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
 <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com> <ZPFhfgScZiekiOQd@Laptop-X1>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZPFhfgScZiekiOQd@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 01/09/2023 à 05:58, Hangbin Liu a écrit :
> On Thu, Aug 31, 2023 at 01:58:48PM +0200, Nicolas Dichtel wrote:
>>> The append should also works for a single route, not only for append nexthop, no?
>> I don't think so. The 'append' should 'join', not add. Adding more cases where a
>> route is added instead of appended doesn't make the API clearer.
It was clear to me. I distinguish the route part and the next hop part.

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
> 
> Just to makeit it clear, the new patch will not add two route with only
> different type/protocol. Here is the result with my patch.
> 
> + ip -6 route flush table 300
> + ip link add dummy1 up type dummy
> + ip link add dummy2 up type dummy
> + ip addr add 2001:db8:101::1/64 dev dummy1
> + ip addr add 2001:db8:101::2/64 dev dummy2
> + ip route add local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 table 100
> RTNETLINK answers: File exists
> 
>      ^^ here the append still failed
And if I play a little bit of the devil's advocate: why is it rejected? It's not
the same route, the types differ :)

> 
> + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
> + ip -6 route show table 100
> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium

What is the purpose of such a routing table?
How is the gateway of a local route used by the kernel?
Which route will be used when a packet enters the stack?


Regards,
Nicolas

