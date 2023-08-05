Return-Path: <netdev+bounces-24646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E8770EED
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C9A1C20AE5
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFF35662;
	Sat,  5 Aug 2023 08:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F11FA0
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 08:55:00 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62FB4689
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:54:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 86CA43200786;
	Sat,  5 Aug 2023 04:54:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 05 Aug 2023 04:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1691225695; x=1691312095; bh=B/bzUf3FxJ5kK3JHBTypLN6VEPUj9cfTrXv
	uYynhqi0=; b=VKEc1wYEHCrkQZXGiIVOukkndY3X/miltG1h7KSchGANOb8bq6u
	yhpDO7ZIyqK7oKbkGrLRkmWZPqeEkQ9gzHSNTmuwa7i5kq7hf5Mt2BD3rNtjnql5
	suWUWiOa5cEL1B0HBkcPsFV7Qtt2MmbKu5HALxE43jnS67ogFKLmaSqT/UibY0E4
	NWZV72sCHR+HUC5M3JWVfS+srnaDDiLzilcg6/od4xgMaKH6OyEfPbe58np8j3VI
	sTAHGJACKeXh6tsLJj4oUU5up5tXoWHArAgRK61ecnco795A7qAKX4PunhBo0qat
	7U5OACR3wHFoDnae/Ef01wRY6AV/3S0vX5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1691225695; x=1691312095; bh=B/bzUf3FxJ5kK3JHBTypLN6VEPUj9cfTrXv
	uYynhqi0=; b=0vuITU8QT/0MW6yhNUaXpd9586h+2A88Qq2xV/NHuaVbKvsnmC3
	fKzR8wci6sTDsm+IaJr8GLl7N+YFf0hTX1c4CHMjCmWjOFA/K7m/BbW5Ni7nIvCp
	Vg2rOSYhLsZqAIH8IX1WWXmHy4IiUagJEMAU2t2JRvfcFKXzsosDVoFClRkSnX5q
	NNw7gy4mXHAQVBXjR40v4YoKfMRqfrl4hk6F9uB5VTPwwUrm/OhY4Rj+jm7bjsgJ
	qDFHjMVM2fHYWQr4Vdhnp1FWBQeM4DCKLwS7ShQwaZH4wxRUFNYOaX54vcIHACez
	8BiSycaimBbnjsvFdj9h3U5cii3kOaZefBg==
X-ME-Sender: <xms:Xg7OZHR4z2MIk4X1UK7_h0abEIXiPt76HGWKXLCox4qSgQ8TBlRwRg>
    <xme:Xg7OZIyddNDjma09ZJfjIgpwtcu0HDJqjuwsoBqdLqyYmOto8uWCcyt-OWiW8DLMG
    TKN090iYeGyley00O8>
X-ME-Received: <xmr:Xg7OZM00oyOjB2zDZVSMH9h0ABJ0WUXwUU_1A3kvWDR_be9xZt-I3bfcm7EDK22yaInrpFuubWTXeu7skW4QFqjLquLqOuJyoeFBQqO5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepgghinhgt
    vghnthcuuegvrhhnrghtuceovhhinhgtvghnthessggvrhhnrghtrdgthheqnecuggftrf
    grthhtvghrnhepvdeikefgkedvveejkeekteeggeetffegueejhefhudfgvefhiedttefh
    heegfffhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvihhntggvnhhtsegsvghrnhgrthdr
    tghh
X-ME-Proxy: <xmx:Xg7OZHAVzYXSsI0vFSjgEZj0YfVgU3zhZ3bN0XO86qmdcg4VGuVxkg>
    <xmx:Xg7OZAiFGFkzMbA8CA--ahFWeZgd7MqBl951rvK9gyh0WWC8zr1R6Q>
    <xmx:Xg7OZLpwPAtd1o8vHGSi0JwvaGPCiTSUpWXpZEwmg0fWsabNLdUIXw>
    <xmx:Xw7OZFZpSqgynYldnHW5sIAD0sokE-ldaW8WosRAVhNapkQ1ovNdmg>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Aug 2023 04:54:54 -0400 (EDT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by neo.luffy.cx (Postfix) with ESMTP id 37F671F0;
	Sat,  5 Aug 2023 10:54:52 +0200 (CEST)
Message-ID: <b9336a67-c337-ae86-2604-81368dcdfbac@bernat.ch>
Date: Sat, 5 Aug 2023 10:54:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance question: af_packet with bpf filter vs TX path
 skb_clone
Content-Language: en-US, fr
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Linux NetDev
 <netdev@vger.kernel.org>, Pengtao He <hepengtao@xiaomi.com>,
 Willem Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@google.com>,
 Xiao Ma <xiaom@google.com>, Patrick Rohr <prohr@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Dave Tucker <datucker@redhat.com>,
 Marek Majkowski <marek@cloudflare.com>
References: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
 <CANn89iJ+iWS_d3Vwg6k03mp4v_6OXHB1oS76A+9p1U7hGKdFng@mail.gmail.com>
 <d1b1c0cc-c542-e626-9f35-8ad0dabb56b0@kernel.org>
 <CANP3RGcTAjkPsFgqyeW5Tp9EJT-SrBX2CGVB7Zavkt6sKRKUOg@mail.gmail.com>
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= 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
In-Reply-To: <CANP3RGcTAjkPsFgqyeW5Tp9EJT-SrBX2CGVB7Zavkt6sKRKUOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-03 10:46, Maciej Żenczykowski wrote:
> I think a fair number of these can get by with non-ETH_P_ALL (for 
> example ETH_P_LLDP), or can use a different socket for RX (where you can 
> choose to not see your own TX packets) and transmit via ETH_P_NONE (btw. 
> that constant should really exist and be equal to 0)

Hey!

For lldpd, I was using ETH_P_LLDP in the past, but there was cases where 
packets are not received, notably when an interface is enslaved by an 
Open vSwitch. See: 
https://github.com/lldpd/lldpd/commit/8b50be7f61ad20ebae15372a509f7e778da2cc6f

This may have been fixed, but this kind of differences between ETH_P_ALL 
and ETH_P_LLDP makes it difficult to trust ETH_P_LLDP to do the right 
thing as it will work for most people but a few edge cases may appear.

