Return-Path: <netdev+bounces-283070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJdONS4F9GnR9gEAu9opvQ
	(envelope-from <netdev+bounces-283070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3124A9ADA
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B854B3006916
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4AC2D23B9;
	Fri,  1 May 2026 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X997a2WI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1E29B8D3;
	Fri,  1 May 2026 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599785; cv=none; b=nVMnKPsfLZA+ZyuAyiZeL6r4jiG6A69tsZWgMtxEk634Kt1n9SzviDwvfqbh3c3dqflkJMbV/6VYGEIanFMhYdFlsGC8vFogp5nd9vI4eeEFwnQE4mn1CalLzFOLD78DoKcwsgp8Nq0D7xhe9GK4fEA9pvkZ2zItV7Xi44U1hJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599785; c=relaxed/simple;
	bh=+l3FOAtZpyLF+Qd2OxZfTnFvT/omrHxmjx391BUCOLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UojvVUg0mltXzWyBIME852GaPL3fFunJZ2KL0h2rZlwRX/jk+Bg3FEzVYl+05xPraVZqmXqhyLAe6dp0UwlsjWe9ty+WtdrqX+f5ThG/ROQpNOfh5Ltz65pNlrIP0/2zPg4kGFb3dQ2WRuOVYGywUVmott6GcLv0eMtrsfXpanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X997a2WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C33DC2BCB3;
	Fri,  1 May 2026 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777599785;
	bh=+l3FOAtZpyLF+Qd2OxZfTnFvT/omrHxmjx391BUCOLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X997a2WI9/+vk5TFxElux2NvtaEu7knHSdUsi6CMCvKCotkH9tqHseiZ9ts6Ibkad
	 8Uiwoeg/uFn/eCJTi8+ZZQe7O6OYLntIAgS9PJJzrxxPfZchEhVopZ3ie0tuinicdD
	 qNKElqcbNZf2rcYM43Nq/Hi+AhINh7kgk8aA7iQE/YscqlQUVDsMB1nvJS7UdKfX5o
	 B1w0+Uy7MfDQQffzOFDSn8FhfSbBH8gFnk7pWTjFCfOzG6XSoBcKOdsWeietIU36dF
	 1XlQyVOsn9VBcmgErco0pX343cVTssFXc9z9rosJMC4rI1qBPIz/Hyzz5QTXN2djsa
	 raKiggsBSaPxg==
From: Jakub Kicinski <kuba@kernel.org>
To: nb@tipi-net.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	justin.chen@broadcom.com,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	rajashekar.hudumula@broadcom.com,
	vikas.gupta@broadcom.com,
	bhargava.marreddy@broadcom.com,
	sashal@kernel.org,
	ebiggers@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 6/7] net: bcmgenet: add XDP statistics counters
Date: Thu, 30 Apr 2026 18:42:34 -0700
Message-ID: <20260501014233.3171164-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428205846.2625550-7-nb@tipi-net.de>
References: <20260428205846.2625550-7-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF3124A9ADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-283070-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmgenet: add XDP statistics counters

This commit adds six per-action XDP counters (xdp_pass, xdp_drop, xdp_tx,
xdp_tx_err, xdp_redirect, xdp_redirect_err) to bcmgenet via the existing
soft MIB infrastructure, exposing them through ethtool -S and
incrementing them from bcmgenet_run_xdp().

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 9dd258567824..02ad2f410d6c 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -1169,6 +1169,13 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
>  	STAT_GENET_SOFT_MIB("tx_realloc_tsb", mib.tx_realloc_tsb),
>  	STAT_GENET_SOFT_MIB("tx_realloc_tsb_failed",
>  			    mib.tx_realloc_tsb_failed),
> +	/* XDP counters */
> +	STAT_GENET_SOFT_MIB("xdp_pass", mib.xdp_pass),
> +	STAT_GENET_SOFT_MIB("xdp_drop", mib.xdp_drop),
> +	STAT_GENET_SOFT_MIB("xdp_tx", mib.xdp_tx),
> +	STAT_GENET_SOFT_MIB("xdp_tx_err", mib.xdp_tx_err),
> +	STAT_GENET_SOFT_MIB("xdp_redirect", mib.xdp_redirect),
> +	STAT_GENET_SOFT_MIB("xdp_redirect_err", mib.xdp_redirect_err),

Should these counters be exposed through the standard netdev netlink
qstats interface rather than as driver-private ethtool -S strings?

Per-action XDP statistics are a generic, cross-driver category that
already has a standard uAPI: the netdev netlink family exposes per-device
and per-queue XDP counters (rx-xdp-packets, rx-xdp-bytes, rx-xdp-errors,
tx-xdp-xmit-*, etc.) via the qstats ops, retrievable with ynl.

Documentation/networking/statistics.rst reserves ethtool -S for
driver-private counters, and the networking subsystem guidance is that
new counters should be plumbed through the standard interface rather
than added as private strings, even when the driver does not currently
implement that interface.

Jakub: no, this is wrong, there are no standard counters for XDP today

>  	/* Per TX queues */
>  	STAT_GENET_Q(0),
>  	STAT_GENET_Q(1),
> @@ -2428,6 +2435,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
>  
>  	switch (act) {
>  	case XDP_PASS:
> +		priv->mib.xdp_pass++;
>  		return XDP_PASS;
>  	case XDP_TX:
>  		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
> @@ -2440,6 +2448,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
>  		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
>  			page_pool_put_full_page(ring->page_pool, rx_page,
>  						true);
> +			priv->mib.xdp_tx_err++;
>  			return XDP_DROP;
>  		}
>  		xdp->data -= sizeof(struct status_64);
> @@ -2459,19 +2468,24 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
>  						      xdpf, false))) {
>  			spin_unlock(&tx_ring->lock);
>  			xdp_return_frame_rx_napi(xdpf);
> +			priv->mib.xdp_tx_err++;
>  			return XDP_DROP;
>  		}
>  		bcmgenet_xdp_ring_doorbell(priv, tx_ring);
>  		spin_unlock(&tx_ring->lock);
> +		priv->mib.xdp_tx++;
>  		return XDP_TX;

Is the XDP_TX path missing an increment on one of its failure exits?
The headroom check and the bcmgenet_xdp_xmit_frame() failure both bump
xdp_tx_err, but the xdp_convert_buff_to_frame() failure in between:

	xdpf = xdp_convert_buff_to_frame(xdp);
	if (unlikely(!xdpf)) {
		page_pool_put_full_page(ring->page_pool, rx_page,
					true);
		return XDP_DROP;
	}

returns XDP_DROP without touching any counter.

With this path in place, does the identity

	xdp_pass + xdp_drop + xdp_tx + xdp_tx_err +
	xdp_redirect + xdp_redirect_err == packets_processed

still hold?

>  	case XDP_REDIRECT:
>  		if (unlikely(xdp_do_redirect(priv->dev, xdp, prog))) {
> +			priv->mib.xdp_redirect_err++;
>  			page_pool_put_full_page(ring->page_pool, rx_page,
>  						true);
>  			return XDP_DROP;
>  		}
> +		priv->mib.xdp_redirect++;
>  		return XDP_REDIRECT;
>  	case XDP_DROP:
> +		priv->mib.xdp_drop++;
>  		page_pool_put_full_page(ring->page_pool, rx_page, true);
>  		return XDP_DROP;
>  	default:
> @@ -2479,6 +2493,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
>  		fallthrough;
>  	case XDP_ABORTED:
>  		trace_xdp_exception(priv->dev, prog, act);
> +		priv->mib.xdp_drop++;
>  		page_pool_put_full_page(ring->page_pool, rx_page, true);
>  		return XDP_ABORTED;
>  	}

Does folding XDP_ABORTED and the unsupported-action default case into
xdp_drop match the commit message's description of "per-action XDP
counters"?

The function returns XDP_ABORTED (not XDP_DROP) in those cases, and the
existing trace_xdp_exception() call distinguishes aborts and unknown
actions from intentional XDP_DROP.

With the current mapping, operators cannot tell an explicit XDP_DROP
from a program abort or an invalid action return when looking at
xdp_drop.  Would a separate xdp_aborted (or xdp_errors) counter for the
XDP_ABORTED and default cases be more appropriate?

