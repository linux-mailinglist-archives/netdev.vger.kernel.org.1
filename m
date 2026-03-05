Return-Path: <netdev+bounces-264437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP5tAgaaqWm7AgEAu9opvQ
	(envelope-from <netdev+bounces-264437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:58:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74084214004
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B2C0305244C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E23A9DA5;
	Thu,  5 Mar 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iHj2nspi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772E3A961F;
	Thu,  5 Mar 2026 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721969; cv=none; b=GmoasorIo61jzQLp682yqYFoMhpcb+yg3t1jc4ZljzACEP6HY4YOjUSE1x9aUnjhHb8ZdQeSdDiVoILXAid9W6yAKmkUkTWwkVEFJr8ipWJEUgdDDPGxW/+w/BwQyiMo3gXUWEkIGbcjIgfHduOW0mdfhKvytqlRIrNMsvzYcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721969; c=relaxed/simple;
	bh=7Fy8244GRUUip69C456QiN1ZM7elVxNq7hb0gn5Awbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFGfJJRFVeWQApPxAj+y+xF33/1ZalX08x4B7c050Y6secwfCMEwNPEfHrHtIzfnxeGCjcSzAoSDhRmHxgO69DZ/AdemR+xm+DtF/OcUxcB0obSZy2s84erT7VpO+/Wy/xegW9QYe6oXyof8KAG5eOHxc6gcVqZz4TGC9t2+8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iHj2nspi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 96F4FC4041B;
	Thu,  5 Mar 2026 14:46:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CDD995FDEB;
	Thu,  5 Mar 2026 14:46:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44B3B103697B5;
	Thu,  5 Mar 2026 15:45:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772721962; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=bIN4i+aSgD4SV8pfn3MjG18z5RHwGaMJsyLvyjMRK5M=;
	b=iHj2nspiTCO247d5OrTLhEpv7bpCnCZMIkufvLZQ1uOIFX3Sejf1XhsEzd9AQy5Rh+S4sq
	vpX4XzSjM5d+X6TLIciKp+2r89LzWv51RdJpv8WlXe83IadQaip58dFqgKkHn0tjhWc1zg
	TlAAt7F6MUPkqBJzGsB6p/WmI8i/dmenWxouQn0QjGpF13yJF5wHiKR1YjuXZ5QYDAT3jX
	qMcDXsYHnOUl032BTwrijiaO6ShqSrMttBSyAiX3VyFtaeRjuK6u6kHbCJmReusOT8C9lC
	OEuCMCszO2dmkOvcwtM0PDqb4Xz62V1KiskmNL9rZ97v6Ti8hls9O8qBm3CDbA==
Message-ID: <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
Date: Thu, 5 Mar 2026 15:45:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Tristram.Ha@microchip.com
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260305125149.ejju5ptrkviqi3sm@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 74084214004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264437-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action



On 3/5/26 1:51 PM, Vladimir Oltean wrote:
> On Thu, Mar 05, 2026 at 01:39:29PM +0100, Bastien Curutchet wrote:
>> Hi Vladimir,
>>
>> On 3/5/26 10:56 AM, Vladimir Oltean wrote:
>>> On Wed, Mar 04, 2026 at 11:18:52AM +0100, Bastien Curutchet (Schneider Electric) wrote:
>>>> @@ -2890,14 +2899,18 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
>>>>    	unsigned int nhandled = 0;
>>>>    	struct ksz_device *dev;
>>>>    	unsigned int sub_irq;
>>>> -	u8 data;
>>>> +	u16 data;
>>>>    	int ret;
>>>>    	u8 n;
>>>>    	dev = kirq->dev;
>>>> -	/* Read interrupt status register */
>>>> -	ret = ksz_read8(dev, kirq->reg_status, &data);
>>>> +	/*
>>>> +	 * Most of the KSZ switches have a 8-bits long interrupt status
>>>> +	 * register, but the KSZ8463 has a 16-bits long one. The overread here
>>>> +	 * is safe because we only iterate over kirq->nirqs in the below loop.
>>>
>>> FWIW, this isn't the only thing making an overread "safe".
>>> If the adjacent register also has "clear on read" semantics, that's not
>>> good.
>>>
>>> I can't tell whether that's the case here, though. There are just too
>>> many hardware variations to check for. I just wanted to point out that
>>> the reasoning is incomplete.
>>>
>> You're right, I hadn't thought about the 'clear on read' case.
>>
>> I'll use ksz_read16() only for the KSZ8463 to be 100% sure it won't break
>> anything for other switches.
> 
> I'm still on the fence on whether to say this or not, because I don't
> really want to get so involved in internal driver bookkeeping, but...
> this driver is just becoming a hell to review, even if I want to
> concentrate exclusively on correct API use, like I try to do.
> > Linus Walleij has added a new ks8995 driver, which has some overlap with
> the common ksz driver for the KSZ8 family. Now he wants to remove the
> overlapping device support:
> https://lore.kernel.org/netdev/20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org/
> 
> Maybe we should go the other way around, migrate KSZ8 support to the
> ks8995 driver instead? The common ksz driver is becoming just extremely
> convoluted to handle all hardware variations. Would it help in any way
> to maintain cleaner code paths, what do you think?

I agree, this driver is extremely convoluted because of all the 
different hardware it handles. It wasn't easy to fit PTP support for the 
KSZ8463 into it. And I encountered the same kind of difficulties when 
adding periodic output support (I have another series ready for this 
once this PTP support will be merged).

Regarding migrating the KSZ8 support into the ksz8995, I think we would 
quickly hit the same pain points than in ksz_common. Even inside the 
KSZ8 family we can find a quite big amount of differences between the 
switches. For instance, both KSZ8463 and KSZ8563 support PTP, they share 
lots of common registers but their interrupt scheme is very different.

I've added Tristram in Cc:, who works at Microchip. Maybe, Tristram, you 
have some insights about which switches could share code if we decide to 
split the big ksz_common into several drivers ?


Best regards,
Bastien







