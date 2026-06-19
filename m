Return-Path: <netdev+bounces-300668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +GidF2wNNWq9mQYAu9opvQ
	(envelope-from <netdev+bounces-300668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:35:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263C6A4FA2
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:35:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nse81hVr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300668-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300668-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E51F3006D7A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0333655CC;
	Fri, 19 Jun 2026 09:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D13624D7
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:35:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861735; cv=none; b=PiBxCGB2EGFyo3gfTZ+v6HjrYZl9WwWvCrx3VKm0Xj14z4h4zAmbCD7Y2mDbozzMMLItz6HGHOpDiBWv+nEnRNo1nKba4IqoRGOUDXYVh6ibGMaovXt0uxN31Ih86XcdomLFfO80ewD2Nm9e36AsswOG5CtNRMEuaWR216nwkOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861735; c=relaxed/simple;
	bh=pY013jS0LPZ9UmNvcXGdBCVyqQQa+Ob7vs00yyRlIXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUfxLfm0XoomkMgYDGnVX34wW3Dan8eM4Wh3EjffWdKlJHIYWKRk+0R1C35x//w2taQAdE/ZZdh8FjZ/7JBKtietkZKiCchKEqzIx4aiJblhPjbC8q6j0IIG3YLzCOTjGoChvoahWaJGTA//ntKK+dGb7EwMX16SswE2M2VfYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nse81hVr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AA61F000E9;
	Fri, 19 Jun 2026 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781861733;
	bh=5+2frUvJgyuU1DhxH6tVVVczOdx415NKr3b/JAICXF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nse81hVraxu2A6OSRWpKQJEIGXFRP2qifVav3Ziipg5rdn2/t0CZ2pAmWemSBgQH3
	 0JhGdoSNPIMFDpfIBsyvg55s+s0VEK1z+nBGTsZhfzv5CczW/jAOmnye/RSrW2RjiD
	 tYvjVH6zuytfF+GrAZeWK5vTT1FyZyKSrMWwEabWeiM5XIz+7RDb1uThtqHZDhvIF0
	 Q3raaGck5eafPQgaWaVfb/3LWWidW14r9o/jABA2rVPsTk73WnoCMjunVbQKvCXlza
	 jdZvZotA8gY/OWVfW6EaoEI4TY2kuV/SDhEeXE5+ufc5qXpQqdJQG2ovj6IDfi/lcc
	 eA0yoLFHa1YyA==
Date: Fri, 19 Jun 2026 10:35:29 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: airoha: fix netif_set_real_num_tx_queues
 for sparse QoS channels
Message-ID: <20260619093529.GV827683@horms.kernel.org>
References: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
 <20260618-airoha-qos-fixes-v1-2-37192652157f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-airoha-qos-fixes-v1-2-37192652157f@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300668-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5263C6A4FA2

On Thu, Jun 18, 2026 at 08:00:30AM +0200, Lorenzo Bianconi wrote:
> airoha_tc_htb_alloc_leaf_queue() assigns queue IDs based on the channel
> index (opt->qid = AIROHA_NUM_TX_RING + channel), but updates
> real_num_tx_queues with a simple increment (num_tx_queues + 1). When QoS
> channels are allocated sparsely (e.g., channels 0 and 3 without 1 and
> 2), the returned qid can exceed real_num_tx_queues, causing out-of-bounds
> accesses in the networking stack.
> For example, allocating channel 0 then channel 3 results in
> real_num_tx_queues = 34 but qid = 35, which is out of range [0, 34).
> Fix this by computing real_num_tx_queues based on the highest active
> channel index rather than using a simple counter, in both the allocation
> and deletion paths.
> 
> Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c

...

> @@ -2806,7 +2806,10 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
>  	if (err)
>  		goto error;
>  
> -	err = netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
> +	if (num_tx_queues <= netdev->real_num_tx_queues)
> +		goto set_qos_sq_bmap;
> +
> +	err = netif_set_real_num_tx_queues(netdev, num_tx_queues);
>  	if (err) {
>  		airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
>  					      opt->quantum);
> @@ -2815,6 +2818,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
>  		goto error;
>  	}
>  
> +set_qos_sq_bmap:

I would prefer if this could be achieved without a goto.

>  	set_bit(channel, dev->qos_sq_bmap);
>  	opt->qid = AIROHA_NUM_TX_RING + channel;
>  

...

