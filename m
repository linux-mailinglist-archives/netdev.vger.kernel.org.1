Return-Path: <netdev+bounces-283069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D5DAA0F9GnR9gEAu9opvQ
	(envelope-from <netdev+bounces-283069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05C4A9AC3
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACEDC3003EF8
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148329A9E9;
	Fri,  1 May 2026 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp3Naciw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57219D065;
	Fri,  1 May 2026 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599754; cv=none; b=NefQOWnuss8EP1X8b8BjyFYdlA4ocEpAlwSzB3tyG1DMNHU6dumO2fm8wIaoFY2ybykLOGvxfk/DM/GjdEWR+ByGNjnIXavpGr1KEparenXqjKABT4voOexzpC5ac5qAhjD3BDQetR8QNqXuB3U5s5QBpdl5h0Abo8g+n5ZbIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599754; c=relaxed/simple;
	bh=ZdITBZENdOr+jdgX2h9Hp07AHixOH3K6o/nDArx9E8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=outsubApZi1yRUQl0feWLgDuW5NzPy8ljtR80+3NOwuD1l+q3eXX6as75WbXHwJRidX3EaQrGpc6KcCbVbaqe0GB5jlcVE0S8ZfRmjT+HTuREgIQ89e/WXbqwGeNy+8MxYz5knurCajlWtyoH8AohGfKWAwsF2Sc1y/PgTJSUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp3Naciw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4654C2BCB8;
	Fri,  1 May 2026 01:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777599753;
	bh=ZdITBZENdOr+jdgX2h9Hp07AHixOH3K6o/nDArx9E8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sp3Naciw8kXhqIxT/jWZpHQhn3KsrHcbaKofLw1R6zy4qxQCiV1XwfApTH9vpiQXe
	 nA99huSzA6F2onnYfNsrvdL9JcyZxK0F8vMakROj56LI9J6fCZUNv3E2Hg4mYa8gVl
	 UKQIAnM2O57sqBkrV43Bn+GQrIeSNXJOVULCgdPRw+NQWCK8vsngIWLnVsANDLvGWe
	 QArizcDDSLxTEf4W+e9+lPWFd0KmZeyMmrOLaRrQXLmDevXgbe3zZwE3MF07XPTWIB
	 7Vx9FG9Bw5U3PPHj3B0QeG8/9WraIdeTCF0Ch6RS+hcB6ZnXy/jkCxsgAyTz20emzx
	 yh8xAddQqhv+Q==
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
Subject: Re: [PATCH net-next v8 5/7] net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
Date: Thu, 30 Apr 2026 18:40:02 -0700
Message-ID: <20260501014007.3169322-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428205846.2625550-6-nb@tipi-net.de>
References: <20260428205846.2625550-6-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C05C4A9AC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283069-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support

This patch adds XDP_REDIRECT support in the RX path and implements
ndo_xdp_xmit for receiving redirected frames from other devices, batching
frames into ring 16 under a single spinlock. It also advertises
NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_NDO_XMIT in xdp_features.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 3c3b0c44ea8a..9dd258567824 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -3996,10 +4017,16 @@ static int bcmgenet_xdp_setup(struct net_device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (!prog)
> +		xdp_features_clear_redirect_target(dev);
> +
>  	old_prog = xchg(&priv->xdp_prog, prog);
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
>  
> +	if (prog)
> +		xdp_features_set_redirect_target(dev, false);
> +

Does this leave NETDEV_XDP_ACT_NDO_XMIT permanently cleared after a
single attach+detach cycle?

bcmgenet_probe() unconditionally sets:

    dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
                        NETDEV_XDP_ACT_NDO_XMIT;

but on any call to bcmgenet_xdp_setup() with prog == NULL this code
runs xdp_features_clear_redirect_target(dev), which clears both
NETDEV_XDP_ACT_NDO_XMIT and NETDEV_XDP_ACT_NDO_XMIT_SG in
xdp_features_clear_redirect_target_locked() (net/core/xdp.c).

bcmgenet_xdp_xmit() does not depend on priv->xdp_prog — it only needs
netif_running() and priv->xdp_tx_ring, which is initialized
unconditionally in bcmgenet_init_tx_queues(). So after attach+detach,
is_valid_dst() in kernel/bpf/devmap.c:__xdp_enqueue() will see
NETDEV_XDP_ACT_NDO_XMIT cleared and reject every redirected frame with
-EOPNOTSUPP until another program is attached.

The paired xdp_features_set_redirect_target(dev, false) call only fires
for prog != NULL, so it does not restore the bit after a no-op detach,
and it is redundant with the probe-time advertisement when prog is
non-NULL.

>  	return 0;
>  }
>  
> @@ -4013,6 +4040,36 @@ static int bcmgenet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
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

Is there a use-after-free window between this check and a concurrent
bcmgenet_close()?

netif_running() is an unlocked test_bit on __LINK_STATE_START.
__dev_close_many() clears that bit and then calls ndo_stop, which
reaches bcmgenet_close() -> bcmgenet_netif_stop() -> bcmgenet_fini_dma(),
where kfree(priv->tx_cbs) frees the backing array that ring->cbs points
into.

The synchronize_net() inside dev_deactivate_many() only waits for
outstanding qdisc enqueuers, not for a remote device's NAPI loop that
is inside xdp_do_flush() -> __dev_flush() -> bq_xmit_all() ->
bcmgenet_xdp_xmit() on another CPU.

A caller that passed the netif_running() test just before
__LINK_STATE_START was cleared can then execute bcmgenet_get_txcb() and
dmadesc_set() against freed tx_cbs memory after bcmgenet_fini_dma() has
run.

Would an RCU-protected "xmit enabled" flag cleared on close followed by
synchronize_rcu() before freeing the ring be needed here?

Jakub: I think this is worried that sync_net will be skipped if the device
has no qdiscs on down(). I don't think we care.

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

How are completions reclaimed on priv->xdp_tx_ring (ring 16) when the
device has no local RX traffic?

The existing ring 16 has no TX interrupt and is reclaimed only from
bcmgenet_rx_poll(); the driver comment states:

    /* ring 16 has no interrupt */

bcmgenet_xdp_xmit() itself has no completion path. When this device is
used purely as a redirect target (receiving frames via ndo_xdp_xmit
from other NICs) with little or no local RX traffic, bcmgenet_rx_poll()
is not scheduled, completed descriptors are never reclaimed,
ring->free_bds stays at 0 after the first burst, and
bcmgenet_xdp_xmit_frame() returns false for every subsequent frame.
bcmgenet_xdp_xmit() then returns 0 (all frames dropped) until unrelated
RX traffic happens to arrive.

The XDP_TX path does not hit this because it runs from inside
bcmgenet_rx_poll(), which drains the ring on each call.

Would scheduling tx reclaim from ndo_xdp_xmit, or installing a
completion interrupt or timer for ring 16, be appropriate here?

> +
>  static const struct net_device_ops bcmgenet_netdev_ops = {
>  	.ndo_open		= bcmgenet_open,
>  	.ndo_stop		= bcmgenet_close,

[ ... ]

> @@ -4327,7 +4385,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
>  			 NETIF_F_RXCSUM;
>  	dev->hw_features |= dev->features;
>  	dev->vlan_features |= dev->features;
> -	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
> +	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			    NETDEV_XDP_ACT_NDO_XMIT;
>  
>  	netdev_sw_irq_coalesce_default_on(dev);

