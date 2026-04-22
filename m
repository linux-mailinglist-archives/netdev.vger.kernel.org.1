Return-Path: <netdev+bounces-280439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMfzJOXc6GnOQwIAu9opvQ
	(envelope-from <netdev+bounces-280439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:36:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6F447511
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4871E306980F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0613ED5C5;
	Wed, 22 Apr 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JoYdE6gX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998C3EDABA
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868518; cv=none; b=n4lq/guWMQ+N5IJ5e8Y34YROdGRBJux3C7PSGQjYgZkf72TAj9y/zuVSvj5fXFXVvc9NGXusUoEp6FD+Gg46W/5kc/2qsIlB83nCE/xJ/lgem8VpqeuJfuLw6GcV8317afwhlGaz+YECBoJ8GxqCMEm8KnCtFiluhGcH25TCd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868518; c=relaxed/simple;
	bh=yMWhmkZqddMkTffR0oXvybpuNFjYBQ+4h4rbg2V6dyY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ot6GtlLLqlDqNMXSyF4tiPBxxV3MappUdvhZ49xuJ9oRecJuy/0S8sFus/3pJsn4FE5vUsorjYk71xVZ6B+8rQbiwMVhhIveCluPH1ngNu5pjUodYgBS1O56uGU9g40Cih0ooGBATMVZhy/BAYfxBu++dp3m8eFGT34khzqf0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JoYdE6gX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AE1611A33A3;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8283C5FA8F;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFFFD104609B8;
	Wed, 22 Apr 2026 16:35:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776868507; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O6m/OWSOFXw0xhnR84l8iFLAI/1MSUuVnp+wgBuSwiE=;
	b=JoYdE6gXlnAWw+1qR/v7eTY9Z3FgXzyiZA4nm4ejyl19hQEliDey36IPHjqP5AZKHdDMHG
	MdNXFFkFCzvMhf/oLVE5Wn5hN95lWjXycm7nSkA2zSJFX7Tt67SzZdjGkv5NChvM9i34xN
	DAWVeeNCFL92XRIymJ4PTmx39pDVNnmOIxATi3vjoJe8pqS+GufGjnkN6AyNIYfj8v09Pc
	aGOXYmuPAXB0oCm9ijf0ULwgm+109LuoeFEej5JUqICq9qXehLFjrQU9UnVYyHSbL5Cvmx
	Tz1WI1Tn7LZoR4U4gt8XBOcK6KKT0J2+T7PpMAqHc5pHvzFe+8uov/gvqX/9bA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 16:35:01 +0200
Message-Id: <DHZRBCN3OFXQ.18Y21LL2HDX02@bootlin.com>
Subject: Re: [PATCH net-next v2 14/14] net: macb: use context swapping in
 .ndo_change_mtu()
Cc: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <pvalerio@redhat.com>, <conor@kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <benoit.monin@bootlin.com>, <tawfik.bayouk@mobileye.com>,
 <thomas.petazzoni@bootlin.com>, <maxime.chevallier@bootlin.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-macb-context-v2-14-af39f71d40b6@bootlin.com>
 <20260414005657.3767049-1-kuba@kernel.org>
In-Reply-To: <20260414005657.3767049-1-kuba@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280439-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,bootlin.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFC6F447511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jakub,

On Tue Apr 14, 2026 at 2:56 AM CEST, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: macb: use context swapping in .ndo_change_mtu()
>
> This commit introduces a mechanism to perform context swapping when chang=
ing
> the MTU while the interface is running. It allocates a new context,
> reconfigures the hardware via a start and end swap process, and then free=
s
> the old context to avoid PHY reinitialization and gracefully handle memor=
y
> pressure.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index d1536cb1e40bb..79371718f8392 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3430,11 +3430,25 @@ static int macb_close(struct net_device *netdev)
>> =20
>>  static int macb_change_mtu(struct net_device *netdev, int new_mtu)
>>  {
>> -	if (netif_running(netdev))
>> -		return -EBUSY;
>> +	struct macb *bp =3D netdev_priv(netdev);
>> +	bool running =3D netif_running(netdev);
>> +	struct macb_context *new_ctx;
>> +
>> +	if (running) {
>> +		new_ctx =3D macb_context_alloc(bp, new_mtu,
>> +					     bp->configured_rx_ring_size,
>> +					     bp->configured_tx_ring_size);
>> +		if (IS_ERR(new_ctx))
>> +			return PTR_ERR(new_ctx);
>> +
>> +		macb_context_swap_start(bp);
>
> Does macb_context_swap_start() gracefully halt the transmitter before the
> context is freed?
>
> It appears to attempt disabling the hardware transmitter by clearing the
> TE and RE bits in the NCR register, but does not poll the hardware to ens=
ure
> it has reached an idle state.
>
> Immediately after, macb_context_swap_end() frees the descriptor rings and=
 data
> buffers via macb_free_consistent().
>
> If the MAC DMA engine is still mid-transfer, could it read or write to ke=
rnel
> memory that has already been freed or reallocated?

Yes and we already have the solution in macb_halt_tx(), used by
macb_tx_error_task(). Close and swap should also use it. Will fix.

Though from the manual's description of TE it sounds super unlikely.

Rx isn't an issue, modifying RE in NCR is the way to go.

> Can this code cause an AB-BA deadlock between napi_disable() and
> cancel_work_sync()?
>
> In macb_context_swap_start(), the code calls napi_disable() for all queue=
s,
> and then immediately calls cancel_work_sync() on the error tasks.
>
> Both of these work items internally invoke napi_disable().
>
> If either error task runs concurrently, it will block forever inside its
> napi_disable() waiting for the NAPI state bits (which were already set by=
 the
> first call in macb_context_swap_start()) to clear.
>
> Consequently, could cancel_work_sync() hang indefinitely waiting for the
> blocked work task to finish?

Wrong because napi_disable() grabs the netdev->lock mutex.

>>  	}
>> =20
>>  	WRITE_ONCE(netdev->mtu, new_mtu);
>> =20
>> +	if (running)
>> +		macb_context_swap_end(bp, new_ctx);
>
> Does macb_context_swap_end() leak pending TX buffers and their DMA mappin=
gs?

> When changing the MTU while the interface is running, macb_context_swap_e=
nd()
> calls macb_free_consistent() to free the old DMA context. While RX buffer=
s are
> properly freed, for the TX queues it appears to only free the tracking ar=
ray
> pointer without iterating through the ring to unmap the DMA mappings and =
free
> the actual buffers.
>
> Any packets queued in the hardware ring at the moment of the MTU swap mig=
ht
> be permanently leaked, which could lead to memory and IOMMU space exhaust=
ion
> under active traffic.

Yes, I have a pending patch for this. Will send soon. It is a bugfix
fixing the close codepath and we'll reuse the code in the swap
operation.

> Will MTU changes on EMAC devices permanently disable hardware interrupts?
>
> macb_context_swap_start() disables all interrupts unconditionally by writ=
ing
> -1 to the IDR register.
>
> However, macb_context_swap_end() restores interrupts via the IER register
> inside an explicit check:
>
>     if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
>         ...
>     }
>
> Since there is no else branch to re-enable interrupts for EMAC devices,
> could changing the MTU on these devices leave interrupts permanently mask=
ed
> and cause the network interface to silently stall?

Ignoring because we will refuse swap for EMAC devices. Their state is
too different; they have different ndo callbacks for everything and
don't use NAPI.

> Is there a missing spinlock when modifying the IER and NCR registers in
> macb_context_swap_end()?
>
> Modifications to the NCR and interrupt registers in macb_context_swap_sta=
rt()
> are protected by the spinlock. However, macb_context_swap_end() performs
> lockless read-modify-write operations on both IER and NCR:
>
>     ctrl =3D macb_readl(bp, NCR);
>     macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
>
> If concurrent hardware events or background tasks take the lock and modif=
y
> NCR during this window, could their updates be silently overwritten?

Yes swap_end needs to wrap its access in the bp->lock spinlock to have
the read-modify-write operation be atomic.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


