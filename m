Return-Path: <netdev+bounces-289068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEpWLlYUC2o5/wQAu9opvQ
	(envelope-from <netdev+bounces-289068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE256DA25
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2F4F3030E85
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971947ECD7;
	Mon, 18 May 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="oYoYXNVd"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3EE17A2FB;
	Mon, 18 May 2026 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110248; cv=none; b=euumqymZ/g+6YsSSgIeXoKi9lD5lino+eYXQSJo5mOh91dVR40lCuUya9t7k/Faw9Zv1RHKecPpA2lAGscBt9NE2WdytEzFOvO/q7X8wTxhGfUGFbsop0CQ3USey55bSqgz+H45Pg210qjuCLYj8lhzTtAeZLtiHXv5jPus/6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110248; c=relaxed/simple;
	bh=obJ1nnQGkGCGh/XGwxPulY4pIneCgxr75sF4TQK/H3g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IyFPEVGpBYM8Z4I5Iwg0aFoOkwcvowBOF+a3syXJ13dHl4BzSTwSYQDMcXG+UlPxewdEoe+BUINJTqkSlsn0pVNiyznzdOEpILEE1JWsUU/Vg9j5+AXpPNzNOF3eKktdcqlzfBON1XZCekTBd9Fxmgu8opjGN+Kg3trOo8lbsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=oYoYXNVd; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17B48A4F75;
	Mon, 18 May 2026 15:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779110241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rExU78rWNNx1RdbQOynGzuSZE6npKXAGt0kPHhzjk+A=;
	b=oYoYXNVdVXrf4XsNHZllQxFbW1dPcsHdryewIkmbJFFtB5mb+H6WNTYz8H3YAoJz3Szkel
	vE6MvSfAO3Mfx7ZHr/Y2rBVCS16cFAydOFccMDd2whgOikrenuYSKxchS3W4Rj3YwOHBKk
	fggp9Fo2tYsOUTwgXulhnKMp8JPm1fw3wyjCFTYXPYO9QMm/221FPrHQ5KkghINZHSL7z4
	7xpn/y20p8bkckq/ZUa9qwk5bbZFWt3F2VvOSTFydZvzL3oII10+M6wYMiAtBkmzHMVBIo
	vFUXarJRByOIBAt3cs1xj3Mj3iIRBCAapefz4ycILV1f8JVnlXkfU5lXlbT+Sg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 May 2026 15:17:06 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>, justin.chen@broadcom.com,
 florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, horms@kernel.org, mohsin.bashr@gmail.com,
 opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 hmohsin@meta.com, davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v9 5/7] net: bcmgenet: add XDP_REDIRECT and
 ndo_xdp_xmit support
In-Reply-To: <20260510185546.3960482-1-kuba@kernel.org>
References: <20260506095553.55357-6-nb@tipi-net.de>
 <20260510185546.3960482-1-kuba@kernel.org>
Message-ID: <b4764de038e1e7a21953314eb5692808@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: D2BE256DA25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289068-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,broadcom.com,lunn.ch,google.com,redhat.com,meta.com,davemloft.net,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim]
X-Rspamd-Action: no action

Hi Jacub

On 10.5.2026 20:55, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
> 
> This commit adds XDP_REDIRECT handling in the RX path and implements
> ndo_xdp_xmit so other devices can redirect frames into bcmgenet via
> ring 16. It also advertises NETDEV_XDP_ACT_REDIRECT and
> NETDEV_XDP_ACT_NDO_XMIT in xdp_features.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index f1e515526787..4e4fe785f0bf 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> 
> [ ... ]
> 
>> @@ -4027,6 +4048,36 @@ static int bcmgenet_xdp(struct net_device *dev, 
>> struct netdev_bpf *xdp)
>>  	}
>>  }
>> 
>> +static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
>> +			     struct xdp_frame **frames, u32 flags)
>> +{
>> +	struct bcmgenet_priv *priv = netdev_priv(dev);
>> +	struct bcmgenet_tx_ring *ring = &priv->xdp_tx_ring;
>> +	int sent = 0;
>> +	int i;
>> +
>> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>> +		return -EINVAL;
>> +
>> +	if (unlikely(!netif_running(dev)))
>> +		return -ENETDOWN;
>> +
>> +	spin_lock(&ring->lock);
>> +
>> +	for (i = 0; i < num_frames; i++) {
>> +		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
>> +			break;
>> +		sent++;
>> +	}
>> +
>> +	if (sent)
>> +		bcmgenet_xdp_ring_doorbell(priv, ring);
>> +
>> +	spin_unlock(&ring->lock);
>> +
>> +	return sent;
>> +}
> 
> Can this path make forward progress when bcmgenet is used purely as an
> XDP_REDIRECT destination (for example, redirecting from a USB NIC or
> Wi-Fi adapter into the on-SoC bcmgenet)?
> 
> The xdp_tx_ring (ring DESC_INDEX) has no dedicated TX interrupt and no
> TX NAPI.  bcmgenet_init_tx_ring() explicitly skips the TX NAPI for this
> ring:
> 
>     /* Initialize Tx NAPI for priority queues only; ring DESC_INDEX
>      * (XDP TX) has its completions handled inline in RX NAPI.
>      */
>     if (index != DESC_INDEX)
>         netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
> 
> The only place that reclaims completed descriptors on this ring is
> bcmgenet_rx_poll():
> 
>     static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
>     {
>         ...
>         /* Reclaim completed XDP TX frames (ring 16 has no interrupt) 
> */
>         if (priv->xdp_tx_ring.free_bds < priv->xdp_tx_ring.size)
>             bcmgenet_tx_reclaim(priv->dev,
>                                 &priv->xdp_tx_ring, false);
>         ...
>     }
> 
> Before this patch, the only producer on this ring was XDP_TX from
> bcmgenet's own RX path, so reclaim and production were always paired
> with RX NAPI.
> 
> With ndo_xdp_xmit, a remote device becomes a producer on the same
> ring.  If bcmgenet itself has no (or very sparse) RX traffic, its RX
> NAPI is never scheduled, bcmgenet_tx_reclaim() on xdp_tx_ring is never
> called, free_bds drains to 0, and:
> 
>> +	for (i = 0; i < num_frames; i++) {
>> +		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
>> +			break;
>> +		sent++;
>> +	}
> 
> bcmgenet_xdp_xmit_frame() returns false on the free_bds < 1 check and
> bcmgenet_xdp_xmit() returns 0, so bq_xmit_all() in the redirect caller
> counts every frame as a drop.
> 
> There does not appear to be a TX completion IRQ, a watchdog, or a
> napi_schedule() kick from bcmgenet_xdp_xmit() to trigger reclaim
> independently of RX traffic.  Is there something else that drains the
> ring in this configuration, or does ndo_xdp_xmit need to schedule the
> RX NAPI (or an independent reclaim path) when it enqueues frames?
> 
>> @@ -4341,7 +4393,8 @@ static int bcmgenet_probe(struct platform_device 
>> *pdev)
>>  			 NETIF_F_RXCSUM;
>>  	dev->hw_features |= dev->features;
>>  	dev->vlan_features |= dev->features;
>> -	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
>> +	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>> +			    NETDEV_XDP_ACT_NDO_XMIT;
> 
> Relatedly, advertising NETDEV_XDP_ACT_NDO_XMIT tells user space and
> redirect maps that this device is a usable xmit target.  Should this
> bit only be advertised once ring 16 has an independent completion
> source, or is the expectation that users of this feature will always
> have concurrent RX traffic on bcmgenet to drive the reclaim?

You're right, ring 16 has no independent completion source. The
piggyback on RX NAPI works for XDP_TX since RX and TX are always
paired there, but ndo_xdp_xmit has no such guarantee.

I see two paths forward:

1. Drop ndo_xdp_xmit and NETDEV_XDP_ACT_NDO_XMIT from this series.
    XDP_TX, XDP_PASS, XDP_DROP, and XDP_REDIRECT (originating on
    bcmgenet itself) still work. ndo_xdp_xmit support comes back in a
    follow-up with a dedicated completion mechanism (workqueue-based
    reclaim, or scheduling RX NAPI from the xmit path).

2. Keep ndo_xdp_xmit and schedule the RX NAPI from ndo_xdp_xmit so
    reclaim runs regardless of RX traffic. Other XDP drivers either
    have dedicated TX IRQs (bnxt) or share normal TX queues with IRQs
    (mvneta) so there's no direct precedent for this hack.

I'd lean toward (1) for v10 to get the rest of the series merged, and
address the completion infrastructure properly in a follow-up. Does
that work for you?

@Justin / Florian: If you have any other ideas for this, happy to hear
your thoughts.

Thanks
Nicolai

