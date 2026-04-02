Return-Path: <netdev+bounces-274486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P/GIh9RzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:21:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 939773883DE
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD94F300E189
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088023CC9E4;
	Thu,  2 Apr 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="JNs2zx/x"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1272C3C6A57;
	Thu,  2 Apr 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128489; cv=none; b=P94/vSiO4LdpcR7h+TYTANJpuGRzSZnvpw/nwtEQ5ONTAkO0yTmLgNKp+gVgDqe84yAQk3UIP06LWvM237ZTYlFtP8oXPxlQBLDrTaxLYFp1i2ecfG9z4khEIh+M576yo+chPU8FZX1MfjwyF5SdHDyGyqULo0qrIfQA/uWyZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128489; c=relaxed/simple;
	bh=4RhBNhKcsFbgETGzQwQwApcr8sOec8NZYKKO7MP6HbI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=X7DDXYSOmwo4n4o+VtoilFEl8aZvKpH4kJZ+Eq5Ms9+Cd+Y5lFy0o7qTLl1piZLA0Hhwk22odYgu3v+e3fR68XXSHRUXNsVEMrv9Ea2hC/XDa+IpcaHivh1VN6brO9avvtywpnbE27LbUAc+egOpiN0MNPc6R48FsL2BV85j1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=JNs2zx/x; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E80A1A587B;
	Thu,  2 Apr 2026 13:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775128471; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6L7U/QSQ/ZiOW10Eg+wDe9ziOx1mvX2pLJoLIimivdk=;
	b=JNs2zx/xFxWmBSVLL2oRoQbRnO1w8hFIkiGgNjWPrdfL30r7sROz8ktaclu4gY8qGVThJ0
	QDmqsGiMM4yzoYoK8ICUuXqfhGvWImtTp3ETuXfOfjRqYPQdHahB/v8Ty02WHt8TZiAVWt
	A48QgAseyBtSXNX8wMush1UBmTJb9BJmqH8gQMxvx6ezKTYZNX/3Iq1bS+6X4w5qVhJZJu
	HbWfkOM6H0gpLl0Ql6zN3X2VwBysBLzBALYYQt1zNYfmMZd0MXKB5H9fTLd9h7p8vD2CDo
	r5n9VpMMsTThqA4uC0m4XhzJwacedx77+TbLLeQbG72yLq3cjl0oipXt1zo8sQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 13:14:28 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>, Paolo
 Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/11] net: macb: allocate tieoff descriptor once
 across device lifetime
In-Reply-To: <20260401-macb-context-v1-5-9590c5ab7272@bootlin.com>
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-5-9590c5ab7272@bootlin.com>
Message-ID: <8c500ccc919ac2d7b350eacca0ab6ccf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274486-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,mobileye.com,bootlin.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 939773883DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 18:39, Théo Lebrun wrote:
> The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
> configured onto queues for Wake-on-LAN during system-wide suspend when
> hardware does not support disabling individual queues
> (MACB_CAPS_QUEUE_DISABLE).
> 
> MACB/GEM driver allocates it alongside the main RX ring
> inside macb_alloc_consistent() at open. Free is done by
> macb_free_consistent() at close.
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
>  drivers/net/ethernet/cadence/macb_main.c | 70 
> ++++++++++++++++----------------

> [...]

> 
> +static int macb_alloc_tieoff(struct macb *bp)
> +{
> +	/* Tieoff is a workaround in case HW cannot disable queues, for PM. 
> */
> +	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
> +		return 0;
> +
> +	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
> +						macb_dma_desc_get_size(bp),
> +						&bp->rx_ring_tieoff_dma,
> +						GFP_KERNEL);
> +	if (!bp->rx_ring_tieoff)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

The old macb_init_tieoff() that wrote WRAP+USED into the
descriptor is deleted but its work is not replicated here.
dma_alloc_coherent zeroes the memory, so RX_USED=0 and the
hardware will treat it as a valid receive buffer pointing to
DMA address 0 during suspend.

Shouldn't this have a macb_set_addr() + ctrl=0 after the
allocation?

> [...]

Thanks
Nicolai

