Return-Path: <netdev+bounces-274626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB4aAa+azmnfowYAu9opvQ
	(envelope-from <netdev+bounces-274626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:34:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82238BF1E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 067453024D60
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471D3F0774;
	Thu,  2 Apr 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n5UtK6Vj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E428504D
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147692; cv=none; b=r7nfUpmHsnVF2KnuJdy3n7dJ8UtJbyEWoEc8/CXVHtjBXFQLiGmv3aksGxu5hrHvGiYJ6H6oCOrlBiVErklLD/fbV5KlL4CSr4yfTUfYNgmE7QrQh1NdkkR76Ez2ZxxQSCqLq89OwEjkv8xqMaLJw8vttanzkwmrpoZiah9+/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147692; c=relaxed/simple;
	bh=3Dcbl0sj4+9NeJxnCcujmPHaFbsKV05jy1v8rfZV1zY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=BUOeH/XOFpG/OgWXCWQqXmE/11UN3JPsT0XqYzkfgU+MpjeMZFjQpiI7btAOlUu5Py8OfIwzjRjqXZIraAO04FXZIyFm504DKQMDHCBZem73f/ub2M3XdZLDJdTG7Q7khCRvPSmvh6haDN+mPU3Q0iQo0OOIltlTBcZvt2KdpxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n5UtK6Vj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2306D4E428BE;
	Thu,  2 Apr 2026 16:34:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC6A7602CD;
	Thu,  2 Apr 2026 16:34:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DAC910450283;
	Thu,  2 Apr 2026 18:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775147687; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vRWf3P80HFSecf7GD9AyzyNoy9HZEiwxJGyXlkzAnmo=;
	b=n5UtK6VjMPBVKk4cKC2cpxlUJtJdwXjjT1xtDPZbVdRuIiQEVyfnA7PlBOxLbKujIOUCQM
	38U7wkRr7x1U47wPl2NYgtivVXa3r7NpGexYJrfGpi/mhvRXCloeMkgc4zgssTveUa+Q6S
	rlcpoxUeWVfCUntgqaLYqMLF+2poVBhyX4IOpxehtgknc0bQ8EFB+f2UaXVsz2tAYa+vfU
	6lOXIImOrgKyrQ42A7Qoegj2BADk1LuEXQqP/wk/9PTS2OWVrMuxeM9hg4dTTr3YIJ8d1D
	onFICF46xFG/9Wh6wFCYbHcbFKZbW141HZ6qhicDjL56sXxLZ1ez6LuSQjRzvA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 18:34:43 +0200
Message-Id: <DHITC3ZM9A1V.EO1BVY4NNUGJ@bootlin.com>
To: "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, "Russell King" <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 10/11] net: macb: use context swapping in
 .set_ringparam()
Cc: "Paolo Valerio" <pvalerio@redhat.com>, "Conor Dooley"
 <conor@kernel.org>, "Nicolai Buchwitz" <nb@tipi-net.de>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-10-9590c5ab7272@bootlin.com>
 <bc874437-1cf8-4ca6-8383-f6e3e1e888ee@bootlin.com>
In-Reply-To: <bc874437-1cf8-4ca6-8383-f6e3e1e888ee@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274626-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9B82238BF1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 1, 2026 at 10:17 PM CEST, Maxime Chevallier wrote:
> On 01/04/2026 18:39, Th=C3=A9o Lebrun wrote:
>> ethtool_ops.set_ringparam() is implemented using the primitive close /
>> update ring size / reopen sequence. Under memory pressure this does not
>> fly: we free our buffers at close and cannot reallocate new ones at
>> open. Also, it triggers a slow PHY reinit.
>>=20
>> Instead, exploit the new context mechanism and improve our sequence to:
>>  - allocate a new context (including buffers) first
>>  - if it fails, early return without any impact to the interface
>>  - stop interface
>>  - update global state (bp, netdev, etc)
>>  - pass buffer pointers to the hardware
>>  - start interface
>>  - free old context.
>>=20
>> The HW disable sequence is inspired by macb_reset_hw() but avoids
>> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
>>=20
>> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
>> over register writes which would be redundant (because values have not
>> changed).
>>=20
>> The generic context swapping parts are isolated into helper functions
>> macb_context_swap_start|end(), reusable by other operations (change_mtu,
>> set_channels, etc).
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 89 +++++++++++++++++++++++++=
++++---
>>  1 file changed, 82 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 42b19b969f3e..543356554c11 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -2905,6 +2905,76 @@ static struct macb_context *macb_context_alloc(st=
ruct macb *bp,
>>  	return ctx;
>>  }
>> =20
>> +static void macb_context_swap_start(struct macb *bp)
>> +{
>> +	struct macb_queue *queue;
>> +	unsigned int q;
>> +	u32 ctrl;
>> +
>> +	/* Disable software Tx, disable HW Tx/Rx and disable NAPI. */
>> +
>> +	netif_tx_disable(bp->netdev);
>> +
>> +	ctrl =3D macb_readl(bp, NCR);
>> +	macb_writel(bp, NCR, ctrl & ~(MACB_BIT(RE) | MACB_BIT(TE)));
>> +
>> +	macb_writel(bp, TSR, -1);
>> +	macb_writel(bp, RSR, -1);
>> +
>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>> +		queue_writel(queue, IDR, -1);
>> +		queue_readl(queue, ISR);
>> +		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
>> +			queue_writel(queue, ISR, -1);
>> +	}
>
> These registers appear to be protected by bp->lock, any chance that this
> may race with an interrupt in the middle of them being configured here ?

The topic is complex! I dug deep this afternoon and replied to the
neighbour thread by Nicolai. It might be of interest to you.

https://lore.kernel.org/netdev/90f843aa3940bdbabadddce27314c1f1@tipi-net.de=
/
(will appear as a child to this email, it hasn't been indexed yet)

Thanks Maxime,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


