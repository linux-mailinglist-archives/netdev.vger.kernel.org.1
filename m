Return-Path: <netdev+bounces-44518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F47D864E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4981F1C20D7A
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73337C85;
	Thu, 26 Oct 2023 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="ECI6EJx7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CT8s/C8A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360B2D03B
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:53:26 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A371196
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:53:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 8AE125C0270;
	Thu, 26 Oct 2023 11:53:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 11:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698335604; x=1698422004; bh=RXiqDENybowzwa4OE4Aw8PjHkkw5RUPT05i
	KC2TJGu0=; b=ECI6EJx77evs9O+y1odGC7hWpg5kIBeHV+jSVcwf4TrA/b33un4
	WadD9NcFcOl2UAU3yGYmoXASP+OUjEVY1lrqyOF/JotkQ7SkPuDB/WV9ZVdfqwEY
	OQ5obaGnjJz+yL04NWmsLd8U9DYxQZmjySr7QKiLqa3W2VlfEXeWvUr0F3aixlWi
	AD8CB2cDdH2GVRmszXtoAO+M667GTakMAuHoiFtiCsb+CLIfh232PrZ1HYhpUJ1r
	ZI2vaeY2PjL/cLkp0A77RPEQNzJlYZnFgb9v27uW8Tmr9zsRy8VNmzF5GqetvE7Y
	sNbTvN7xnOygSlVRf9XTclwieCYBQpu2zdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698335604; x=1698422004; bh=RXiqDENybowzwa4OE4Aw8PjHkkw5RUPT05i
	KC2TJGu0=; b=CT8s/C8A5SXOWvVnhY+gNeZMAmsgK5NAfY18/CMXIWXyrqMYtAq
	Hz6I/NeEjOYMV0wVgA5bvP95zaw6KCdvLR25u/6p2lDWEabpOLXqDLBlX9/6yazQ
	3NI0ZO186rNk7V3mB2TrvAkyNaHhiPKkvzdRzluLKApiOVKtNhXs1/PsJQTpVw+R
	TyInDc7jBzXuyKBR2iCvMWZOaQM2FMao2dXlAomBj6yUmkVUbrgB1niic/e5gbb9
	RY0EI8fczoQo1CHRMxeMQlzqGCOmP1suD9WbdiwRxhQ5yO7u7YAS81hxW3VO23tK
	XkZvUsAQDp4K7g6StWasmHiDj9Wt+9lXyBw==
X-ME-Sender: <xms:dIs6ZWdaredtomLe4evFJWQp1w-qVx7dZVa912-0af6abZkWpARcew>
    <xme:dIs6ZQMk8lQJLv4TzyTBqUt7ejmXo322wagK5wHhb5T3OGSJtuGKqJkar6EJUcuno
    8eABe5AFpzW9o2mxZs>
X-ME-Received: <xmr:dIs6ZXhfmHv5RHsj0zJJjSUMJWrozY_V3nFxtSWb6sJLZUYHfFKLnZ0OAI--Oo-9pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgghinhgt
    vghnthcuuegvrhhnrghtuceovhhinhgtvghnthessggvrhhnrghtrdgthheqnecuggftrf
    grthhtvghrnhepheevkeeutdeiledtffeludehteegudffjefftdelffettdfgkeeuleff
    gfdukefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epvhhinhgtvghnthessggvrhhnrghtrdgthh
X-ME-Proxy: <xmx:dIs6ZT_iKd3gSC-yu-uMpTv9Swx9YZcSojaeEHbD3wgCdrplbaADgQ>
    <xmx:dIs6ZSuzcTw7hirVHsTvfmQsUmGvCc2TXzjZANy_xHkJIMML6wl86w>
    <xmx:dIs6ZaGH7Nmw_Tej3C6JVh1SADbVshkXp9e8oiHWM4dAvlSnukWNqA>
    <xmx:dIs6ZWgn0m_mXBLvIknW3b-WW-52zKmTs5_3Xtj4qzK4lEb8-T5a_A>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 11:53:23 -0400 (EDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by wally.luffy.cx (Postfix) with ESMTP id 66EC55F7A0;
	Thu, 26 Oct 2023 17:53:22 +0200 (CEST)
Message-ID: <8adb039f-00db-40a1-bcb6-4379e823fd0b@bernat.ch>
Date: Thu, 26 Oct 2023 17:53:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] vxlan: add support for flowlabel inherit
Content-Language: en-US, fr
To: Jakub Kicinski <kuba@kernel.org>, Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
References: <20231024165028.251294-1-alce@lafranque.net>
 <20231025182019.1cf5ab0d@kernel.org>
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= xsFNBE/cpVkBEACi8ZoEu+dhI604/5zMuuAlPt7e1GDj75UgXZh5f21JYRt/laVsxiK07BG9
 NkTCpFzoAFRfndf7HvvTcKrumgPUFw0bYy9uvkrDDAzRV3slA+rL+n6hugbxMrtWM+sSoB7p
 teZcfADDwfcO3SjvQV9mGdVcBOQq3lABdbWP7IAG5myrIvozC/Li8v8w1dUeT7dnO1ciVS8y
 4J3fLNXD+EzGllSmc4BOWpkNJylkHLC0aeduhtgfe+t4aC/zaX9ccgWapei2kV8k87imayEQ
 0oaz/112jyGMJHJYnhlzDa/UcYA93EWGmRNeiEBrV1w2RGHm8oK4eh/xMWpHVEd/tNS261x9
 Q/dOHZxX6Qf/WQcmARRAkBhHmt+K+6F/TtOZqldRksUO8CGdQ9zt74Vg2RRVmctkOp+5Vh1i
 LOBzBzFybzlyOhw6+cdE0S5EgS787dcjGw9MBpqt5ZX25dcp+obyMQJCREyuUs6a9F+H0I8Y
 Yhw8b7ygEbTpGmQCZRFcw196luniZHHlfyfY/xsH5FuxfmeVfHJsA36I6G6ge4JBjK8/6WpV
 DH0DmbAHCs5ChT8ppIwNHkdJw7JTCAUx2AQ6HlEK0R/CBXpTnozM40ni3BD0tUh04qUenvni
 +VxpfxyhkNqBCq5wyIoGqXpkxc8TPeSq05Zu9/KSxlKLoJn/TwARAQABzSJWaW5jZW50IEJl
 cm5hdCA8dmluY2VudEBiZXJuYXQuY2g+wsGOBBMBCAA4FiEErvI0h2bzccaJpzYAlaQv6DU1
 JfkFAltos54CGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQlaQv6DU1JfliQQ//Wqe2
 1h/DNiYTGIf7t+QudJfqKizwJP90toxWZACY5ZLqdCijVF0AESODbETJV5AeFCx2O0Lu5XvC
 K241fSBYnNpkvCBTkJ8Lws0b7j39AbtQfWAKHj0FLuf2nr53KFpkudKQYf4LHofc1WdvKUPo
 bVcnURNe9FB9mZXjiP3oi8hvBDbbS8+qeJSb2UMrgxjBQ0fGxERM20IL/jXqWpFfQDs/F9iT
 UGCMEkghiiMumyhTXVfSUUxB6bFM0A0UtyvwpaiWH3pvicYyGv/79/ojjpK0Z4gDyYB3k2Qm
 PNlgadUlSY8fkZYbEbjFVyk22UnyR7mAiwgmeYqQsTF0VU8NalogSw6DgghiJd5cqEsQzgql
 E6uv72zhdlDsIZTA5hNZhPTgV9Bk2PyHywNget8UU3FIr1EszfTI96W14mFYk/N7L8Sq63kq
 jC+zc2B2N8uC3c/p/TEDlS3XID37Iyw2heIqh2PtqjP48tJdQDQ/qJhMiagnR6O2/KkFNQf/
 mTHtR5goqEhvskkHjvVBuCB4TTNfLy/BGynqth2q1W9Ir1ey9K+0Pla27P03fVYqbOnahdUI
 q1y/uY149v6pkCjSqrcCGTPhQYuktdBbuglVWeAukkXUc4B7Xq3adI9yyIcfB/7jUlvPPJe2
 w177cIlro7JlH97yHtLv0Nrh0QomvqTOwU0ET9ylWQEQAJrsPZrACIJvx4KGH7ar/2KbPIaH
 zmWHoGopQVsQSoDNSxtAZZAh4P11U+h1fjiC4+7sFK60nv1lCAyoUJPXBVTnG2+09L9sFbXf
 kuxCuiA0Gq27zKeidT6Rnr770e4YKJt9oiuEJqSmMM9aKWmqrU3NI1StkIftls+1qaGOnEfI
 BGOiCB2CAiedwF91O4Kgl79st5v40eFGZ1DAbkpToxnFVSouAhUNxjArXYUp1RT/gelNu7N4
 R7AvWHy4Wlv2rvlUmVt2gCIC2s/dbsmvgvqF4EeAbxSz2qvWXetgC5WN8PbPAA0um15kwAc1
 iBU5zYKtXd4CKxM0ztLYKVtlV+omAW+IZ65JlhlF642ujgOAs8IDy4nxSDDlr8oDZdxe5hq5
 dolemXeZi/EGUfvwND8hOBAM4cryjUSfWK1Zu5HyZFYNnqHJ36f1nkdMB/D0n+akS/a2Webw
 Nd6NbQVSpYei+xzQwN89v1B6DBjWaBv9TQJiDAgcNtNNkqtOf87u7o5r3opEQxC9EWuZnMsl
 zQlh4oREcYp93siy1AUTfq5ZlwOsXT5WzxSY2zv8DHMnznlatkD0AvOC9Flsn0Z27yIyu1Bi
 XJqTmmOM9wRLiAIms6A1By4WSoJ5xXVS1UYvemZrCgt+N/DGjO6kAfhAvhoooeUCBiNWTPH5
 61ooyXFZABEBAAHCwXwEGAEIACYCGwwWIQSu8jSHZvNxxomnNgCVpC/oNTUl+QUCYrCHmwUJ
 HDnjwgAKCRCVpC/oNTUl+ZmYEACETHKSE/wmaq6J8bXEXaeIs2tYyMlE3k5LqgDIkms/hF6U
 Psf8tf8YW27/C5fEmUNPcsLwiSusYuNVy/jy9jC9Ka06sNqozNUCdHD3zap1k1myjnLe4L9a
 WphuJF0EzSflbZKFOmCY5mKeDZatZSrneYqaqdgxPr4Wyayd4haxjkVnGRBW/eEcHAImjkQ7
 X9lV4zEXng1OC4pBDizj4ATY/zgzRR00rcinG/gtLQ6XcM6SjJQrgIRSA6X5J+T54xXVHWe2
 3+BUJOLN/m606dP9PiAbpbns/ftyA3YX0WgDGXO67y8ZyEmTbuQiwGo11n79vvEySnlF2wEA
 ZsfqKD+IvKKQGVbJAju935/TGMQved0doP0qZOuGJKqb/0wJ2631Kjx3+jegUTaqpUS0Im48
 aDPltGsV+a45vkSA0LIp3G8h6fUeElU0pqY5l6g8cvEEV3Cqj25Z/6cEmJl68Sz+rJHkdJks
 Ty8X172/RyIbVNkefAOd0ZCanSRkTiMtjjX1BhFYgZlK5oRT9aeAhUUQaXYj43X+ciejDzor
 4tEs0NAMbuPdhk9zHNCPD/wFJsAagpaCgYKpKcmBhMsodkGX6MnDRxHn4bZytTAKirrqgJ6s
 4466JQwsN3xxnLyjMGf5eHW82us8jF4i0CHthJAPoIr8p+0dP6qaQ7T0ji9UPw==
In-Reply-To: <20231025182019.1cf5ab0d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-26 03:20, Jakub Kicinski wrote:
>>   struct vxlan_config {
>> -	union vxlan_addr	remote_ip;
>> -	union vxlan_addr	saddr;
>> -	__be32			vni;
>> -	int			remote_ifindex;
>> -	int			mtu;
>> -	__be16			dst_port;
>> -	u16			port_min;
>> -	u16			port_max;
>> -	u8			tos;
>> -	u8			ttl;
>> -	__be32			label;
>> -	u32			flags;
>> -	unsigned long		age_interval;
>> -	unsigned int		addrmax;
>> -	bool			no_share;
>> -	enum ifla_vxlan_df	df;
>> +	union vxlan_addr		remote_ip;
>> +	union vxlan_addr		saddr;
>> +	__be32				vni;
>> +	int				remote_ifindex;
>> +	int				mtu;
>> +	__be16				dst_port;
>> +	u16				port_min;
>> +	u16				port_max;
>> +	u8				tos;
>> +	u8				ttl;
>> +	__be32				label;
>> +	enum ifla_vxlan_label_policy	label_policy;
> 
> Here, OTOH, you could save some space, by making it a u8.

Is it worth it? Keeping an enum helps the compiler catching some 
mistakes and it documents a bit the code (we could put a comment 
instead). In most cases, there is not a lot of vlan_config structs lying 
around (when there are many VXLAN devices, people use single VXLAN 
devices), so it shouldn't be a problem for memory or cache.

Alternatively, we could push this to another patch that would also 
handle df field.

