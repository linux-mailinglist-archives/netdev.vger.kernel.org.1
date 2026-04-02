Return-Path: <netdev+bounces-274494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBcyAUdXzmnrmwYAu9opvQ
	(envelope-from <netdev+bounces-274494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D5B388893
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E873230CD2FB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499873CBE90;
	Thu,  2 Apr 2026 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="y7TTmySF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99753A4F27;
	Thu,  2 Apr 2026 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129418; cv=none; b=FAjA7yHXlyS/eYlC5aaW/uBnoaBEbMRvHDdVOFx2VZGNlp53MfBS5kgAcQiYh0TLCw4vc2ri1o7ZQyfz7e4klqgbB+PQ32EUxC6TcrFWhP7thuJ5+37tLb+IbILvF2B1j884t268NySR1q8Fyfl+3J/ow2Uhseftc8qGk15M3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129418; c=relaxed/simple;
	bh=28q/qCK+gXZEGqjCyA3H3EaAd/1c+2kSz/DGqlu2Uzk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Hm2/xaKPK0XLDRy/A5qntg4p1ehLWtXX3Lf/GdM7w08YZDmRuRLsDbZ1KvktMPS1/69r0FqhaAc9wqN6LRZs+tIj62JmaF2/IdifJB7v34BxhYQJLBigNqlq+i/wKGLkiEn2pPMEBe6mueCPs5BCW37IP4ZElp18eyHj8lB8Ras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=y7TTmySF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06D10A5889;
	Thu,  2 Apr 2026 13:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775129405; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Gs4YsqLpgH7F2095RsCXRJucsAAhFfMRogLbPZ89ycI=;
	b=y7TTmySF6jcNFRMgzyX01wlgeVzF/IRZvL42jVKVHpjXITht7IIwgCHk0in1nhQTrXAsZ+
	89pPrAYS9czgHPR56xURaVbKrxLFf3OH5Jb3bjxHzAeaiZ++iTGX/3lhK3AYRhUYGDKDnf
	321Oj/TrOvqrjdsxsdojljUhI+eLKH30Eqtx1+mIU3q1F8NDoYcb26zSGFqHC8lTXud/3W
	SXUOD+hCHHIQzKt+94HyN6bFjcwy+zZ/PhEkkf8tLeBYdRH/XOkqND0gp25Fu32JvbyIOi
	VxDVBftOIBH17kXb/Tg5Blts0mjLzwJX2QK3TS2rTom4ObLxy6kUFOWIMt6YLg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 13:30:05 +0200
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
Subject: Re: [PATCH net-next 11/11] net: macb: use context swapping in
 .ndo_change_mtu()
In-Reply-To: <20260401-macb-context-v1-11-9590c5ab7272@bootlin.com>
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-11-9590c5ab7272@bootlin.com>
Message-ID: <450f62fea63766cd21e57b3a63a39d0c@tipi-net.de>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,mobileye.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:mid,bootlin.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3D5B388893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 18:39, Théo Lebrun wrote:
> Use newly introduced context buffer management to implement
> .ndo_change_mtu() as a context swap: allocate new context ->
> reconfigure HW -> free old context.
> 
> This resists memory pressure well by failing without closing the
> interface and it is much faster by avoiding PHY reinit.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 543356554c11..e10791bf1f4d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3438,11 +3438,25 @@ static int macb_close(struct net_device 
> *netdev)
> 
>  static int macb_change_mtu(struct net_device *netdev, int new_mtu)
>  {
> -	if (netif_running(netdev))
> -		return -EBUSY;
> +	struct macb *bp = netdev_priv(netdev);
> +	bool running = netif_running(netdev);
> +	struct macb_context *new_ctx;
> +
> +	if (running) {
> +		new_ctx = macb_context_alloc(bp, new_mtu,
> +					     bp->configured_rx_ring_size,
> +					     bp->configured_tx_ring_size);
> +		if (IS_ERR(new_ctx))
> +			return PTR_ERR(new_ctx);
> +
> +		macb_context_swap_start(bp);
> +	}
> 
>  	WRITE_ONCE(netdev->mtu, new_mtu);
> 
> +	if (running)
> +		macb_context_swap_end(bp, new_ctx);

Same issues from patch 10 apply here, plus:

macb_context_swap_end() never calls macb_configure_dma(). The
new context has a different rx_buffer_size (derived from new_mtu),
but the DMACFG register's RXBS field still reflects the old
value. If new MTU > old MTU, the hardware will DMA past the end
of the new buffers using the old (smaller) RXBS. Shouldn't
macb_configure_dma() be called after the swap?

> +
>  	return 0;
>  }

