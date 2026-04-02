Return-Path: <netdev+bounces-274564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJT7LDh4zmmMnwYAu9opvQ
	(envelope-from <netdev+bounces-274564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:07:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3438A3D7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED83431057C7
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF73E3DA2;
	Thu,  2 Apr 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gaM0wYYg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB0310655;
	Thu,  2 Apr 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138273; cv=none; b=Zw+QkJTbFJ+MOj7jse4hIm0lCZYd47MGMh0Spc4hupu1v4mj3NUd/EDzohFjxiRDK3WBXREm7tqliua34n9Y51/eDUZiqbuwDTHz123GFmQwnNxyVdFunGnU7Gk1zeDHOc1mywSFIKgAE+AU4ZTmQT7K1gZqjpAKHNgxShHIbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138273; c=relaxed/simple;
	bh=B6XHVrDu4cRpr7JHMEQjOwY23wmaawcouOP1Kt6Y9e8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=WhjBTZ+JX4K+UVkm7CQF+JZOk7/TFjlI7JkNh/JW3qdBo/yv3/AWsZtrpI09/5oeDls7G8+BDGVijTGr+Z59lS3NHhBjiubnIagwZe31Z2aPaBucxQpJ3pCz7LLpSfH3W6GfZtzcSs59xFUnz7QdGedhatSsrV+wHSBZ7Zi7BOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gaM0wYYg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 96244C59F46;
	Thu,  2 Apr 2026 13:58:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 174255FDEB;
	Thu,  2 Apr 2026 13:57:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5F4110450264;
	Thu,  2 Apr 2026 15:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775138266; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GkRbx1KLnlIONYrPbKgeBqIosRCm1oaDFZI+qcdxXlQ=;
	b=gaM0wYYgUCY8eKzjNEC0Z1n6a5u1rokGSWlWgR1p3OFbr8YNzqg6e3uJE9sKjJmOosPhX9
	cPro91YokI7JDnbu64PGC4BEIZ1eiJsmKljOlzOdBRPghPpbl3ZcGnUBcWqRXrHRXim1xO
	y5arF9M635+cdEMKgY6Tk7PDs6O91MqE7SvaEVE3hnRQi3e+goWZnWCXrXYiJEneqpMpij
	VkguGkRnBepqCpckpdkuy0bt2tPTznvK0cXGeB1tU2aaCy2KzmuKdzqqk36R7hExZKO/16
	PPAowRDQ+hB9KQ+M5/kc8lCRN8Nhzo6VR0PKSWy30rcXqsquz0+ok4O18qB+MQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 15:57:41 +0200
Message-Id: <DHIPZVAI06HW.34RS9K2PB52OV@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "Paolo Valerio" <pvalerio@redhat.com>, "Conor
 Dooley" <conor@kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 05/11] net: macb: allocate tieoff descriptor
 once across device lifetime
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-5-9590c5ab7272@bootlin.com>
 <8c500ccc919ac2d7b350eacca0ab6ccf@tipi-net.de>
In-Reply-To: <8c500ccc919ac2d7b350eacca0ab6ccf@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,mobileye.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: 4BC3438A3D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Apr 2, 2026 at 1:14 PM CEST, Nicolai Buchwitz wrote:
> On 1.4.2026 18:39, Th=C3=A9o Lebrun wrote:
>> The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
>> configured onto queues for Wake-on-LAN during system-wide suspend when
>> hardware does not support disabling individual queues
>> (MACB_CAPS_QUEUE_DISABLE).
>>=20
>> MACB/GEM driver allocates it alongside the main RX ring
>> inside macb_alloc_consistent() at open. Free is done by
>> macb_free_consistent() at close.
>>=20
>> Change to allocate once at probe and free on probe failure or device
>> removal. This makes the tieoff descriptor lifetime much longer,
>> avoiding repeating coherent buffer allocation on each open/close cycle.
>>=20
>> Main benefit: we dissociate its lifetime from the main ring's lifetime.
>> That way there is less work to be doing on resources (re)alloc. This
>> currently happens on close/open, but will soon also happen on context
>> swap operations (set_ringparam, change_mtu, set_channels, etc).
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 70=20
>> ++++++++++++++++----------------
>
>> [...]
>
>>=20
>> +static int macb_alloc_tieoff(struct macb *bp)
>> +{
>> +	/* Tieoff is a workaround in case HW cannot disable queues, for PM.=20
>> */
>> +	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
>> +		return 0;
>> +
>> +	bp->rx_ring_tieoff =3D dma_alloc_coherent(&bp->pdev->dev,
>> +						macb_dma_desc_get_size(bp),
>> +						&bp->rx_ring_tieoff_dma,
>> +						GFP_KERNEL);
>> +	if (!bp->rx_ring_tieoff)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>
> The old macb_init_tieoff() that wrote WRAP+USED into the
> descriptor is deleted but its work is not replicated here.
> dma_alloc_coherent zeroes the memory, so RX_USED=3D0 and the
> hardware will treat it as a valid receive buffer pointing to
> DMA address 0 during suspend.
>
> Shouldn't this have a macb_set_addr() + ctrl=3D0 after the
> allocation?

Clearly! This V1 uses tieoff uninitialised. The two instructions from
old macb_init_tieoff() have been appended to macb_alloc_tieoff().

static int macb_alloc_tieoff(struct macb *bp)
{
	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
		return 0;

	bp->rx_ring_tieoff =3D dma_alloc_coherent(&bp->pdev->dev,
						macb_dma_desc_get_size(bp),
						&bp->rx_ring_tieoff_dma,
						GFP_KERNEL);
	if (!bp->rx_ring_tieoff)
		return -ENOMEM;

	macb_set_addr(bp, bp->rx_ring_tieoff,
		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));

	bp->rx_ring_tieoff->ctrl =3D 0;

	return 0;
}

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


