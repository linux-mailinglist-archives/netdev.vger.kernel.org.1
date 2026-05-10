Return-Path: <netdev+bounces-286379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILudCbjUAGp8NAEAu9opvQ
	(envelope-from <netdev+bounces-286379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:55:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB83505D2C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C327B3006B53
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B231F9A2;
	Sun, 10 May 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzkVbNnu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C93164C3;
	Sun, 10 May 2026 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439349; cv=none; b=Nmi6tcpVhJWK66GYMmQr9FluGydsLdHcNZfc/8uHtG09aQIOTnOTHW6nd2wrKXpoheYfyKHItP9z2c7E/9lB9xiCwa8/mqIt5h13MgYZqKD71H7fflrPN1ASdEj1wZIm3R4oT/Y9WF6eui2RiSjXlGYgwa00K+leCMDtJ0VILDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439349; c=relaxed/simple;
	bh=G9GToOtS3isqcC/YtQR+Ee64Ud4v2fghkptAbDZiq08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d48NSJJVgZVN4n7TXjSzvqGxbvVaXagdYuTNmUSzYJSAKFQgjXEXD0s5hZcXiAQPk6jmGjiydj5NXti9uF0xU9qEfhlPEpQws9+cxayci3x7Vrz6yuPvWfqrsviWwpGel18fkqPiY5cuqkqIgKInoNIXa7X+pHFPdzfAMPkdxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzkVbNnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1131C2BCB8;
	Sun, 10 May 2026 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778439348;
	bh=G9GToOtS3isqcC/YtQR+Ee64Ud4v2fghkptAbDZiq08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzkVbNnuxTVneo62loO/EcB4gwkRIOl4mD8102tjcEW0PhxyBmYZV4CKRzQBq6+kp
	 IlmdZ7IsH014qL2fuOwBubkP69Hf9Hejrp7KBN5Du0tyzPW1ONBBftDhU6plPErW+C
	 E+gNL/8juYFTwVQaZ1tIMzTiKefFeUu5UvvpSC34e8Avit+G8NaCP+90Wg5M9bRQsF
	 obWraTLSttu40ma0GPDJjyRRLlXVAZ0e2JY9zHNdS9hUXgJm6FUokPO4HEttOfMvFY
	 O3MF0ZkAv7+tn0YCNeujBzQbjtzr+RfrRmFc85/lJmBsY6KRF82egQkH5HXgloVRIG
	 3vd4L+BL5xLKQ==
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
	hmohsin@meta.com,
	davem@davemloft.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v9 5/7] net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
Date: Sun, 10 May 2026 11:55:46 -0700
Message-ID: <20260510185546.3960482-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506095553.55357-6-nb@tipi-net.de>
References: <20260506095553.55357-6-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EB83505D2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,google.com,redhat.com,meta.com,davemloft.net,iogearbox.net,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-286379-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support

This commit adds XDP_REDIRECT handling in the RX path and implements
ndo_xdp_xmit so other devices can redirect frames into bcmgenet via
ring 16. It also advertises NETDEV_XDP_ACT_REDIRECT and
NETDEV_XDP_ACT_NDO_XMIT in xdp_features.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index f1e515526787..4e4fe785f0bf 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -4027,6 +4048,36 @@ static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  	}
>  }
>  
> +static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
> +			     struct xdp_frame **frames, u32 flags)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bcmgenet_tx_ring *ring = &priv->xdp_tx_ring;
> +	int sent = 0;
> +	int i;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	if (unlikely(!netif_running(dev)))
> +		return -ENETDOWN;
> +
> +	spin_lock(&ring->lock);
> +
> +	for (i = 0; i < num_frames; i++) {
> +		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
> +			break;
> +		sent++;
> +	}
> +
> +	if (sent)
> +		bcmgenet_xdp_ring_doorbell(priv, ring);
> +
> +	spin_unlock(&ring->lock);
> +
> +	return sent;
> +}

Can this path make forward progress when bcmgenet is used purely as an
XDP_REDIRECT destination (for example, redirecting from a USB NIC or
Wi-Fi adapter into the on-SoC bcmgenet)?

The xdp_tx_ring (ring DESC_INDEX) has no dedicated TX interrupt and no
TX NAPI.  bcmgenet_init_tx_ring() explicitly skips the TX NAPI for this
ring:

    /* Initialize Tx NAPI for priority queues only; ring DESC_INDEX
     * (XDP TX) has its completions handled inline in RX NAPI.
     */
    if (index != DESC_INDEX)
        netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);

The only place that reclaims completed descriptors on this ring is
bcmgenet_rx_poll():

    static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
    {
        ...
        /* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
        if (priv->xdp_tx_ring.free_bds < priv->xdp_tx_ring.size)
            bcmgenet_tx_reclaim(priv->dev,
                                &priv->xdp_tx_ring, false);
        ...
    }

Before this patch, the only producer on this ring was XDP_TX from
bcmgenet's own RX path, so reclaim and production were always paired
with RX NAPI.

With ndo_xdp_xmit, a remote device becomes a producer on the same
ring.  If bcmgenet itself has no (or very sparse) RX traffic, its RX
NAPI is never scheduled, bcmgenet_tx_reclaim() on xdp_tx_ring is never
called, free_bds drains to 0, and:

> +	for (i = 0; i < num_frames; i++) {
> +		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
> +			break;
> +		sent++;
> +	}

bcmgenet_xdp_xmit_frame() returns false on the free_bds < 1 check and
bcmgenet_xdp_xmit() returns 0, so bq_xmit_all() in the redirect caller
counts every frame as a drop.

There does not appear to be a TX completion IRQ, a watchdog, or a
napi_schedule() kick from bcmgenet_xdp_xmit() to trigger reclaim
independently of RX traffic.  Is there something else that drains the
ring in this configuration, or does ndo_xdp_xmit need to schedule the
RX NAPI (or an independent reclaim path) when it enqueues frames?

> @@ -4341,7 +4393,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
>  			 NETIF_F_RXCSUM;
>  	dev->hw_features |= dev->features;
>  	dev->vlan_features |= dev->features;
> -	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
> +	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			    NETDEV_XDP_ACT_NDO_XMIT;

Relatedly, advertising NETDEV_XDP_ACT_NDO_XMIT tells user space and
redirect maps that this device is a usable xmit target.  Should this
bit only be advertised once ring 16 has an independent completion
source, or is the expectation that users of this feature will always
have concurrent RX traffic on bcmgenet to drive the reclaim?
-- 
pw-bot: cr

