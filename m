Return-Path: <netdev+bounces-278262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHV5ABuR3WkLfwkAu9opvQ
	(envelope-from <netdev+bounces-278262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:58:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A833F4AFC
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B18D2301BAD6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95194257435;
	Tue, 14 Apr 2026 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD5bweWb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4623FC5A;
	Tue, 14 Apr 2026 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128225; cv=none; b=Y5xyRhRmIdtjICIKQYHxB2hUJZ7PqgwDVrWjxNddZbE3w0c12AcJxTYtxXDWSx5I6llk0R2MWA+E0Nvc4AQOwYIJkKm9V3HwbfZtv4x634RA9vTSsbQTkX5q9W4DBqNANtqAiPOTmZJ4gDMClWpqnmXcy1Osgni0UJC8V6slfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128225; c=relaxed/simple;
	bh=SZ8bxW248dKFJ2T2i/XeZvhMvF2zAJ0rE686yiH+7wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NThwKyBRX6LbBUs+ZN+lhRiem8Vpp08Vuh+JG/852+fNMQU5P42xZCEfNJdHKBKQSpbT+jX+GysOfPx0aEktHd1mjEk1g/RIuZBCCQB6zVsZ7taWMKGYjm4P28n78Sfj/beQ64FOxkpO6NEV4O2/ErqJd5qnsB0lVStiirxphuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD5bweWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E75C2BCAF;
	Tue, 14 Apr 2026 00:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776128225;
	bh=SZ8bxW248dKFJ2T2i/XeZvhMvF2zAJ0rE686yiH+7wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DD5bweWbCpM/xwhtM+SMM1ZN070/as7OFRmjft/M0o/HN02YnkfX8xlUWvbw/Tbj+
	 1v56vgoecndjh92d/5pc71NLOPv2h1m8ofp7DVpHfS91LeK70wmORpF/5HWllgFPLX
	 G5qoqTCVLwgNW4TEzpXkkYuYaMK7p9fSbrcVE2WttvJ1LRRJEXpC+TckVfuEH6yj3l
	 EjmvHolfhnwvPkiCnPmtqARsnJO35q+LKLZNWI0/pmPFLeAfpZyi/VATBm0gcLVkbu
	 nDmNJTke9mejnRV3vW/atf4mFkXTVkzBUzELf53eH3LORKiM5Kn/LHFq7z5MJJat08
	 AcrOzpZBlOqrg==
From: Jakub Kicinski <kuba@kernel.org>
To: theo.lebrun@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	pvalerio@redhat.com,
	conor@kernel.org,
	nb@tipi-net.de,
	vladimir.kondratiev@mobileye.com,
	gregory.clement@bootlin.com,
	benoit.monin@bootlin.com,
	tawfik.bayouk@mobileye.com,
	thomas.petazzoni@bootlin.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 14/14] net: macb: use context swapping in .ndo_change_mtu()
Date: Mon, 13 Apr 2026 17:56:57 -0700
Message-ID: <20260414005657.3767049-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-macb-context-v2-14-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-14-af39f71d40b6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278262-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2A833F4AFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: macb: use context swapping in .ndo_change_mtu()

This commit introduces a mechanism to perform context swapping when changing
the MTU while the interface is running. It allocates a new context,
reconfigures the hardware via a start and end swap process, and then frees
the old context to avoid PHY reinitialization and gracefully handle memory
pressure.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d1536cb1e40bb..79371718f8392 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3430,11 +3430,25 @@ static int macb_close(struct net_device *netdev)
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

Does macb_context_swap_start() gracefully halt the transmitter before the
context is freed?

It appears to attempt disabling the hardware transmitter by clearing the
TE and RE bits in the NCR register, but does not poll the hardware to ensure
it has reached an idle state.

Immediately after, macb_context_swap_end() frees the descriptor rings and data
buffers via macb_free_consistent().

If the MAC DMA engine is still mid-transfer, could it read or write to kernel
memory that has already been freed or reallocated?

Can this code cause an AB-BA deadlock between napi_disable() and
cancel_work_sync()?

In macb_context_swap_start(), the code calls napi_disable() for all queues,
and then immediately calls cancel_work_sync() on the error tasks.

Both of these work items internally invoke napi_disable().

If either error task runs concurrently, it will block forever inside its
napi_disable() waiting for the NAPI state bits (which were already set by the
first call in macb_context_swap_start()) to clear.

Consequently, could cancel_work_sync() hang indefinitely waiting for the
blocked work task to finish?

>  	}
>  
>  	WRITE_ONCE(netdev->mtu, new_mtu);
>  
> +	if (running)
> +		macb_context_swap_end(bp, new_ctx);

Does macb_context_swap_end() leak pending TX buffers and their DMA mappings?

When changing the MTU while the interface is running, macb_context_swap_end()
calls macb_free_consistent() to free the old DMA context. While RX buffers are
properly freed, for the TX queues it appears to only free the tracking array
pointer without iterating through the ring to unmap the DMA mappings and free
the actual buffers.

Any packets queued in the hardware ring at the moment of the MTU swap might
be permanently leaked, which could lead to memory and IOMMU space exhaustion
under active traffic.

Will MTU changes on EMAC devices permanently disable hardware interrupts?

macb_context_swap_start() disables all interrupts unconditionally by writing
-1 to the IDR register.

However, macb_context_swap_end() restores interrupts via the IER register
inside an explicit check:

    if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
        ...
    }

Since there is no else branch to re-enable interrupts for EMAC devices,
could changing the MTU on these devices leave interrupts permanently masked
and cause the network interface to silently stall?

Is there a missing spinlock when modifying the IER and NCR registers in
macb_context_swap_end()?

Modifications to the NCR and interrupt registers in macb_context_swap_start()
are protected by the spinlock. However, macb_context_swap_end() performs
lockless read-modify-write operations on both IER and NCR:

    ctrl = macb_readl(bp, NCR);
    macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));

If concurrent hardware events or background tasks take the lock and modify
NCR during this window, could their updates be silently overwritten?

> +
>  	return 0;
>  }

