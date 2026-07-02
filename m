Return-Path: <netdev+bounces-304104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h9hcMZpDRmqRNAsAu9opvQ
	(envelope-from <netdev+bounces-304104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C86F6440
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:55:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=pByd+uT1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304104-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304104-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797CE31616D8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B338E5ED;
	Thu,  2 Jul 2026 10:41:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AD2853E0;
	Thu,  2 Jul 2026 10:41:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988891; cv=none; b=iLhdkEZ4/GztPG7V1FoWrFu+uwqvgnDb4lHCanql6eh2706aLJb8QDHpTvKFj1aFvTFW2iCu7buHOmiE86NShGUnHo4ZeJa+N1P6sdLIjItpR2oHIvuQutKrzIl7crtMyWxwj/91fsZrEU3JrCoQDxscJADIxurA2AHLpJxP2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988891; c=relaxed/simple;
	bh=M3UoqmL5niQg2OIf2suRv7Ya/uc+RVEF7hNQr6UkIMY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IZvCUOUC8cr96aLc68JWY+wO0PcJQxE0ySYixfN/vfcJYE8MGfopoz0fl7qKQixf3wnYK0XS+LSdKEtzn9vCEgNvp4F7/0sjr9giQNGeGeJ/kW250JV86bUvt/4QQcnm5TYPVrkhBhS8bLw1iNqQBjf+rqurI1iETI5z2krMW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pByd+uT1; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B0DEA47FB;
	Thu,  2 Jul 2026 12:41:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782988887; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CXkw62+8yRFpZqUrO/8MVocZDBemKbTQnFeIui1gwNo=;
	b=pByd+uT1lM5pBEHvnD+/KTdBrmlkPULX9sr5EkrUz/0EX5kCZO3J1KtWQ9Uo3vj4TnP4QQ
	gLMFaNMrJ6aMkby94nRKbZbE/d0VryE9hP+xskb4sIkvefBCinJxkwo+VRChnq4aAnegde
	B7mEl7OqQXOSvsC4Nn/MJcx1ssA6YzMp/IH7ETlusJwWEc6M5ZLEToH6+C7Xdk767g5l09
	k65IlbBKyGii7Npa96+8ZPywc+tSMdsfiQ2U+oPb7RkX6FtGe11hELNkNgWUu2khtmCdjX
	nsmZeOL86MHX/yrp/4M4l02gIR/8AF4TXki/0SzaLFdNezaojZUToP+B+ylJ4w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 12:41:26 +0200
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
Subject: Re: [PATCH net-next v3 01/15] net: macb: drop "consistent" from
 alloc/free function names
In-Reply-To: <20260701-macb-context-v3-1-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-1-00268d5b1502@bootlin.com>
Message-ID: <a59a3d38c2f9653aabdcde8cedc58b8a@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-304104-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,vger.kernel.org:from_smtp,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F4C86F6440

On 1.7.2026 17:59, Théo Lebrun wrote:
> Since commit 4df95131ea80 ("net/macb: change RX path for GEM") those
> functions have not been only allocating or freeing consistent memory
> mappings.
> 
> Rename from macb_alloc_consistent() to macb_alloc() and
>        from macb_free_consistent()  to macb_free().
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index fd282a1700fb..d677a93b9d72 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2646,7 +2646,7 @@ static unsigned int 
> macb_rx_ring_size_per_queue(struct macb *bp)
>  	return macb_dma_desc_get_size(bp) * bp->rx_ring_size + 
> bp->rx_bd_rd_prefetch;
>  }
> 
> -static void macb_free_consistent(struct macb *bp)
> +static void macb_free(struct macb *bp)
>  {
>  	struct device *dev = &bp->pdev->dev;
>  	struct macb_queue *queue;
> @@ -2711,7 +2711,7 @@ static int macb_alloc_rx_buffers(struct macb *bp)
>  	return 0;
>  }
> 
> -static int macb_alloc_consistent(struct macb *bp)
> +static int macb_alloc(struct macb *bp)
>  {
>  	struct device *dev = &bp->pdev->dev;
>  	dma_addr_t tx_dma, rx_dma;
> @@ -2769,7 +2769,7 @@ static int macb_alloc_consistent(struct macb *bp)
>  	return 0;
> 
>  out_err:
> -	macb_free_consistent(bp);
> +	macb_free(bp);
>  	return -ENOMEM;
>  }
> 
> @@ -3157,7 +3157,7 @@ static int macb_open(struct net_device *dev)
>  	/* RX buffers initialization */
>  	macb_init_rx_buffer_size(bp, bufsz);
> 
> -	err = macb_alloc_consistent(bp);
> +	err = macb_alloc(bp);
>  	if (err) {
>  		netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
>  			   err);
> @@ -3202,7 +3202,7 @@ static int macb_open(struct net_device *dev)
>  		napi_disable(&queue->napi_rx);
>  		napi_disable(&queue->napi_tx);
>  	}
> -	macb_free_consistent(bp);
> +	macb_free(bp);
>  pm_exit:
>  	pm_runtime_put_sync(&bp->pdev->dev);
>  	return err;
> @@ -3235,7 +3235,7 @@ static int macb_close(struct net_device *dev)
>  	netif_carrier_off(dev);
>  	spin_unlock_irqrestore(&bp->lock, flags);
> 
> -	macb_free_consistent(bp);
> +	macb_free(bp);
> 
>  	if (bp->ptp_info)
>  		bp->ptp_info->ptp_remove(dev);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

