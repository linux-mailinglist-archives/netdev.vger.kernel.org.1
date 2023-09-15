Return-Path: <netdev+bounces-34122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1987A230E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E1D1C20B0F
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5611190;
	Fri, 15 Sep 2023 15:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0DF11C92
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:58:37 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD8910E6
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:58:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-403004a96eeso24994275e9.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1694793515; x=1695398315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yWBAfuvqfSlFL5w3qU7MwkAe0D6FzJ2Z5QsNasAGJs4=;
        b=d3WSiho7IdzJLvw5mm2GmsTkRyhMzKZ54qDWoLQckY1ih8M3HDppRaTeTxVF8gL/UV
         E52Izr0E9nRYDIF4VLYb4Ou97vpQamY7acJAM0yrfBlKOUsKP+5Gq7S7oxNqr0XDYvF3
         06FrTuReQdBRK3eBNuLA8CVBacAYTrcZHi+69NGSgex51KCftomwCVtUPj7ISMiRMCmG
         M4IHyTOUmS+m/7lMPrdBTWVZJ7VA9LA11CfD5LlZGJMwoQUcu9A64Y8CjealsMaUBeba
         nZOgzlXQaOukkySptCWq3g2nT7Vqxo4oJxacfkNmI9fpH6djUQ7FU60epvzn9ERtgMrm
         d9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694793515; x=1695398315;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWBAfuvqfSlFL5w3qU7MwkAe0D6FzJ2Z5QsNasAGJs4=;
        b=cSDdgh/qK47QdtlI2zyeTKNS9U9ueAA6vX1PazVE7TC/E4qTmBWKMNDLN7R6VxYpRW
         FHE4hCYnaclzlPae8ncwxD180Q9911fBsihrUQf7IpBiaD5a5IOG4NTokFL86+aS4RcL
         ybMBXv0XU6qO49ptYsML6jRJVPvwYCe8F5mAPBJ0x6/KZF6oTOiXmggIFBTnY0khkPli
         cVBd40VzrGRFXpPZQMGorQMXb1biykOLJc53SmjTlJEY5wd294nBkmglnNaQyrSC2f7q
         Cu82I+3XhfsZ2N7nNT/rDkq9QeZbvGOp6YdpdvFgVa5yT1X2z30YENL5LTlpbQvbW5JQ
         Br9w==
X-Gm-Message-State: AOJu0YwY9RhDCLe9s9y3iC2KkEoKy4PpN0+xSWuNPOabdmpiB6sSE4O5
	1zkobwvOsu2f7GYibffbCbcy4g==
X-Google-Smtp-Source: AGHT+IEXB9nVezzeILjpUyhBJ+IBX2n3WE3zq0nQmCF0/5oJNfuKCpgwDrKeR+7QUawgPEmI6o9gLg==
X-Received: by 2002:a05:600c:2290:b0:401:dc7e:b688 with SMTP id 16-20020a05600c229000b00401dc7eb688mr1942502wmf.6.1694793514763;
        Fri, 15 Sep 2023 08:58:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:724a:5ebf:1377:3f14? ([2a01:e0a:b41:c160:724a:5ebf:1377:3f14])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b004013797efb6sm7858032wmj.9.2023.09.15.08.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:58:34 -0700 (PDT)
Message-ID: <30d8c41c-2f53-c77f-5584-d93ea2e05b5e@6wind.com>
Date: Fri, 15 Sep 2023 17:58:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
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
 <b4b81499-d53a-d697-4cb6-20338606d68a@6wind.com> <ZQPUMchAuQma7Xrh@Laptop-X1>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZQPUMchAuQma7Xrh@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 15/09/2023 à 05:49, Hangbin Liu a écrit :
> On Fri, Sep 01, 2023 at 11:50:12AM +0200, Nicolas Dichtel wrote:
[snip]
>>> + ip route append unicast 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 table 100
>>> + ip -6 route show table 100
>>> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
>>> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
>>
>> What is the purpose of such a routing table?
> 
> As I replied in last mail. I don't have a clear purpose. A user may use
> the local route to block traffic temporary.
> 
>> How is the gateway of a local route used by the kernel?
> 
> I don't know. IPv6 support this since beginning...
> 
>> Which route will be used when a packet enters the stack?
> 
> The first one it find?
Frankly, it seems strange to me to try to fix a scenario without a clear view of
what is expected. I agree that the current behavior is questionable, but it
enables to keep the system (the routing table) in a clear state.


My two cents,
Nicolas

