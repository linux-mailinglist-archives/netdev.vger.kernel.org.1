Return-Path: <netdev+bounces-304126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a5qeKvZERmrFNQsAu9opvQ
	(envelope-from <netdev+bounces-304126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:01:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C10F86F655A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:01:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b="YQ/oMU9g";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304126-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304126-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 941BB30B0C7E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777983C65F4;
	Thu,  2 Jul 2026 10:54:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C93C2BBA;
	Thu,  2 Jul 2026 10:54:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989669; cv=none; b=FUZjQjDIU6Ho/CE24Ck/DyOd5PsCJvv041c/aVK7NDoILYRkLLXc62Anhrx0+A482h0b3Ft56alWrXmf+MW+yOUtBinedDDcM8nOjvGTNPPKCUraZAlS93F5VTYCzBzyJzxRYcqbSX/niSNzjnK2Zi3dNT2T2+Oy9GJGqR0d60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989669; c=relaxed/simple;
	bh=SQaFlu2/+vnHwsMGbND9PirtCqaj2Vyqceq89Mu6Q4s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=raOJIIIxYuRWZzqNIHIwiO75+CnoJK1EESrEmUFCmu9D84my7Xsh42VDpN3O8cdATq67YRIGsozdQlOFH8v7+Zj+WD/foSQZODJYtBMMhHaAauRGWKVQLvCAsRwtpcCWg/GmO9E+diazZH2tBtzMMiaSNCJBEme/P2nwRZkGlU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YQ/oMU9g; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2CF7A47CA;
	Thu,  2 Jul 2026 12:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782989665; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PLWQjlPt3Zj1Xo0h1ky6h63PhE9ufnEXlxieZ+G+DQ8=;
	b=YQ/oMU9g3Jk6fBb5DiDCK7zjEBJ1Vke26zHGIYPOMM9rfLFAg8IGE93JZkN2gr4zAcJXcp
	0F6fDpKGtn3AO5FpSxXUG/HR7eOPb++RuTjPUOvc81bSXPF6+TR2mTNjRWki13ycuXZO5c
	fjDCXLdhK+gVLvwvUNyhJVu+rNbCyO6yJ9s7JPJ3Cx3FKXyjRR5aRIs595PMdnSde2DhaQ
	GsQaCrxqM/ipFyABq9TVocjwWznpmMSN/yUpjTyKyTNuBSxWZxDJ+skmQBaRmRMCNdSkrn
	ecNld3ErvMRnaqQRMCthwKDpyAkQ6/SQ+/vtF3QhTU+6Pt4fmv8kl5Vv+lT3nw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 12:54:24 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 06/15] net: macb: allocate tieoff descriptor
 once across device lifetime
In-Reply-To: <20260701-macb-context-v3-6-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-6-00268d5b1502@bootlin.com>
Message-ID: <6e449ee7d40ec885e8a53fa18fe70e86@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-304126-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tipi-net.de:dkim,tipi-net.de:mid,tipi-net.de:from_mime,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C10F86F655A

Hi Théo

On 1.7.2026 17:59, Théo Lebrun wrote:
> The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
> configured onto queues for Wake-on-LAN during system-wide suspend when
> hardware does not support disabling individual queues
> (MACB_CAPS_QUEUE_DISABLE).
> 
> MACB/GEM driver allocates it alongside the main RX ring
> inside macb_alloc() at open. Free is done by macb_free() at close.
> 
> Change to allocate once at probe and free on probe failure or device
> removal. This makes the tieoff descriptor lifetime much longer,
> avoiding repeating coherent buffer allocation on each open/close cycle.
> 
> Main benefit: we dissociate its lifetime from the main ring's lifetime.
> That way there is less work to be doing on resources (re)alloc. This
> currently happens on close/open, but will soon also happen on context
> swap operations (set_ringparam, change_mtu, set_channels, etc).
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 75 
> +++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 8b52122bc134..951a7f080225 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

> [...]

>  static void macb_init_rings(struct macb *bp)
> @@ -2832,8 +2801,6 @@ static void macb_init_rings(struct macb *bp)
>  	bp->queues[0].tx_head = 0;
>  	bp->queues[0].tx_tail = 0;
>  	desc->ctrl |= MACB_BIT(TX_WRAP);
> -
> -	macb_init_tieoff(bp);
>  }
> 
>  static void macb_reset_hw(struct macb *bp)
> @@ -5518,6 +5485,38 @@ static int eyeq5_init(struct platform_device 
> *pdev)
>  	return ret;
>  }
> 
> +static int macb_alloc_tieoff(struct macb *bp)
> +{
> +	/* Tieoff is a workaround in case HW cannot disable queues, for PM. 
> */
> +	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
> +		return 0;

Before, the tieoff was allocated in macb_alloc(), which the at91ether 
path
never called. Now it's allocated from macb_probe() for all variants, 
gated only
on MACB_CAPS_QUEUE_DISABLE, so EMAC gets a coherent descriptor it never 
uses.

Add MACB_CAPS_MACB_IS_EMAC to the if statement?

> [...]

Thanks
Nicolai

