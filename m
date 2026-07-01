Return-Path: <netdev+bounces-303788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rajCJhVTRWol+goAu9opvQ
	(envelope-from <netdev+bounces-303788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:49:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CAA6F06E3
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:49:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=H33Sk6em;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="nVfWw/CU";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303788-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303788-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B36B530686F4
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BB34C040B;
	Wed,  1 Jul 2026 17:45:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B984BC004;
	Wed,  1 Jul 2026 17:45:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927909; cv=none; b=Lf4MV9NNQjHCAwCWgxoqS2BMakeP97KEOhiVCpHT3Mop5Apts08ttCqrPJM3NtN/sRIU8jEMW7lMER88EPgsD321XAqk2BPRz49QQ+n0Gyy2s2uDzydgb8T4WN5VAlHLBvUY7eb/xDfth3rKaojqMiuZX2hrwJ/5YkPFOaGET5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927909; c=relaxed/simple;
	bh=yu1OYVNjeWpEKBxU8r3a1PqbcvhsLJ/S+dNG+ulBYsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvE32snCnFCZOEBzMZRdc9v3qcr/bIMLOvEvj62Hu1JgWg/NuBwe9vaOQUim0pbakHxfOGyY3VQRxJ2O9I/b+OYJleT4jNZe3si2rlge3gZdV/74f4wXvZe1GFpA9Yj2Sy6Ot+JI7Nm9z7WxHSYMnC0nJ6A9MZ9B8XEbIkeHQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=H33Sk6em; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=nVfWw/CU; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782927905;
	bh=yu1OYVNjeWpEKBxU8r3a1PqbcvhsLJ/S+dNG+ulBYsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H33Sk6emHWn8Vh38nhpdRzjjOfLJuZBaAxjJxzop/PFRdFmBMPhPKy2KH4lHVRSWM
	 B7tLHVM8Cp0nknRVm9uTx4QjLCBJdJXUAukjqQQ5JQzETn0EyTTmqK0bqAKRDjShcB
	 BsmQiYmygkyovSnHuofOcxiqzFv3UKFU6WuFoRJ+QOPr+ev6Wm9sxnFp+T8pcU4Nl+
	 zx4ErWv1chpruhA0dyCyqLI3JFus1zx1QtpaVR2H6MpjVHg9qYeDbdIt/Ru5SF77Rx
	 7Bn8tpJDEom1ntTBAYSb0eOKu3+ZDuEtyc4ue45Slry2OFFuwZQjXllBp9D8UdBN+y
	 pyLU8SqON2rGg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3B55649365; Wed,  1 Jul 2026 17:45:05 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782927904;
	bh=yu1OYVNjeWpEKBxU8r3a1PqbcvhsLJ/S+dNG+ulBYsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nVfWw/CU4h2efX6UOz2BltPdT2bco0XEMXHVXy3eBd7W1GUv4L7Ff676IhnB4xg5B
	 /YRWM+0Bi8XUm6I57WmzIJsq9yoiHvF2oxzpTPc6XgQrKOiNCL/SO0997NDwdLuB+O
	 1GTC/vqxkZ1pEhdoNdnPZzokIwCTu6ka3Oj7W0P7yI9YqW/QeScIzsJmJlcFkSNwAO
	 fXa9RAAzOnE94EGCXB4KTU6vhHbl0HaV4P+pGHU0RidnEk8LvGLgm2jJuzUs1JkL4m
	 JexlNkEg4TG8cviQca3x25ArEW2DE6opt6x6CvErVONaQT6JfK8fbn1eziGiE8kUdd
	 ckXk6y2C8mrTw==
Received: from [IPV6:2003:c6:9f1c:3c00::1c8] (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5093449353;
	Wed,  1 Jul 2026 17:45:04 +0000 (UTC)
Message-ID: <3cc16d45-7b6d-4fb0-8a7b-d6b4d53ab036@birger-koblitz.de>
Date: Wed, 1 Jul 2026 19:45:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause parameter
 configuration
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
 <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
 <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
 <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303788-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	DMARC_NA(0.00)[birger-koblitz.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27CAA6F06E3


> Thanks for these numbers.
> 
>> Renkforce AX88179A: ID1 7c9f, ID2 7061
>> Delock AX88279  ID1 03a2, ID2 a411
> 
> air_en8811h.c:#define EN8811H_PHY_ID		0x03a2a411
> 
>> UGreen AX88772D ID1 e65b, ID2 2c61
>> TP-Link AX88179A ID1 e65b, ID2 2c61
> 
> The two ID registers contain part of an OUI, but it has some bits
> missing. So it is not so easy to look it up.
> 
> However, anything using the MII framework basically assumes a very
> simple PHY and only looks at the 802.3 defined registers. So the
> genphy generic PHY driver might be sufficient for when there is not a
> specific driver. At lot depends on how much extra code there is
> accessing the PHY registers in the driver.
I also found
#define PHY_ID_ASIX_AX88772A         0x003b1861
Which has the same ending as the AX88179A at least. So hopefully these
IDs are stable across firmware versions.
So, I will give phylink a try and send a new patch version out. I am a
bit worried because the PHYs are real divas, getting them to survive
a suspend/resume cycle was a bit like herding fleas: get one of them
to survive a cycle made another one come out completely dead back from
resume, and in need of unplug/plug. So that took a lot of
experimentation to get right. The out-of-tree driver by ASIX is of
little help, because it implements a complete USB device and is not
using usbnet.

Birger

