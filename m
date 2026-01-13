Return-Path: <netdev+bounces-249414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A32D18229
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F69A3067670
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D332D0CF;
	Tue, 13 Jan 2026 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e7SroRhc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF52BE04C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300995; cv=none; b=HVkLhi7djvtJXmCilIVMO+uwr1c2XG13obkwwegaRpWTjoy9Cv5/J1s8ZgPyvl6UfTbWawiKb8Qzh91k6FBB8t7sSRDzc6Qgj6dGM0jhJrjidHHFR9+U6OMknfXyeTYVEN6RADKcUzksd3L2LCnmzppt6NCoTjzcxkIRJ8anZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300995; c=relaxed/simple;
	bh=EZL+zR1nHieRKOqhXcZRjAQQACUpajd/mR+bgn4Kd7c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=VhAiy4oczPwv9p8Ogvz8VW2+zCMGd9q77SR3+suNd09dzsLI0oPMMpJ3u3qURCmaFZapU+oyaJyyV1q+o51DetbDs8pahGXzbdowKV8ZsB0ly37q1etiH7LOxqUEJWYvU0/VRljAtkNxBo23cGDW6wU4urchC3dVoAEhe+cfI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e7SroRhc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 083944E420A1;
	Tue, 13 Jan 2026 10:43:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D058560732;
	Tue, 13 Jan 2026 10:43:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C5C5103C930F;
	Tue, 13 Jan 2026 11:43:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768300991; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=v52MClGNb0k/YObNyq5NzXvLkG+cNxxUOzfz96JOhVA=;
	b=e7SroRhcdj8w2c6VLHYrK/WRPjWEo9SRuaB4UNuxiQczurRl2nxf95st6M7l2TTjSZnCQa
	6rqBDKJauI9vepN6dSbopiIRTCDQXysaB+YipspNGwHNGXdmjoNcVtSidMpnJTtNp4aK7P
	QE33Ik168kgMFoUJTJ+gUFvXmDdwwftc038/SddCGXfMJO9sxEZit225DchPXlUGd+HoK4
	Md8F4OzxuR4uvbPum6n6y9keXmGEbpt6v0DsKM1P+yFgfIh9mqAx75RPek1moTun/YZO9m
	K9IVknwAufJ/53n7V2TLXUSmQ65NOEomMhX7rupz6Y0PcwVFuCXkRtI+IKykhg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 11:43:08 +0100
Message-Id: <DFNEDVIHWVSS.42X1VB6HKJBF@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Gregory Clement"
 <gregory.clement@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 3/8] cadence: macb: Add page pool
 support handle multi-descriptor frame rx
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-4-pvalerio@redhat.com>
 <DFJBNAK0H1KV.1HVW5GR7V4Q2B@bootlin.com> <87jyxmor0n.fsf@redhat.com>
In-Reply-To: <87jyxmor0n.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jan 12, 2026 at 3:16 PM CET, Paolo Valerio wrote:
> On 08 Jan 2026 at 04:43:43 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>> On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
>>> @@ -1382,58 +1382,118 @@ static int gem_rx(struct macb_queue *queue, st=
ruct napi_struct *napi,
>>> +		first_frame =3D ctrl & MACB_BIT(RX_SOF);
>>>  		len =3D ctrl & bp->rx_frm_len_mask;
>>> =20
>>> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
>>> +		if (len) {
>>> +			data_len =3D len;
>>> +			if (!first_frame)
>>> +				data_len -=3D queue->skb->len;
>>> +		} else {
>>> +			data_len =3D bp->rx_buffer_size;
>>> +		}
>>
>> Why deal with the `!len` case? How can it occur? User guide doesn't hint
>> that. It would mean we would grab uninitialised bytes as we assume len
>> is the max buffer size.
>
> Good point. After taking a second look, !len may not be the most reliable
> way to check this.
> From the datasheet, status signals are only valid (with some exceptions)
> when MACB_BIT(RX_EOF) is set. As a side effect, len is always zero on my
> hw for frames without the EOF bit, but it's probably better to just rely
> on MACB_BIT(RX_EOF) instead of reading something that may end up being
> unreliable.

100%, I do agree!

>>> +		bp->rx_buffer_size =3D SKB_DATA_ALIGN(size);
>>> +		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
>>> +			overhead =3D bp->rx_headroom +
>>> +				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>> +			bp->rx_buffer_size =3D rounddown(PAGE_SIZE - overhead,
>>> +						       RX_BUFFER_MULTIPLE);
>>> +		}
>>
>> I've seen your comment in [0/8]. Do you have any advice on how to test
>> this clamping? All I can think of is to either configure a massive MTU
>> or, more easily, cheat with the headroom.
>
> I normally test the set with 4k PAGE_SIZE and, as you said, setting the
> mtu to something bigger than that. This is still possible with 8k pages
> (given .jumbo_max_len =3D 10240).

Ah yes there is .jumbo_max_len, but our PAGE_SIZE=3D=3D16K > .jumbo_max_len
so we cannot land in that codepath.

>> Also, should we warn? It means MTU-sized packets will be received in
>> fragments. It will work but is probably unexpected by users and a
>> slowdown reason that users might want to know about.
>
> I'm not sure about the warning as I don't see this as a user level detail=
.
> For debugging purpose, I guess we should be fine the last print out (even
> better once extended with your suggestion). Of course, feel free to disag=
ree.

I'm fine with no warnings. We'll check our performance anyways. :-)
If it changes we'll notice.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


