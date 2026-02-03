Return-Path: <netdev+bounces-256073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GB+KOlSgWmLFgMAu9opvQ
	(envelope-from <netdev+bounces-256073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:44:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D3D3746
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ABCD3018759
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41F27B353;
	Tue,  3 Feb 2026 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eksgF6Ke"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CF17BA2;
	Tue,  3 Feb 2026 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083046; cv=none; b=Sw4YJvjcmMzm/LBGmIcalBcz7o8GMZFvk2WTNzqnbnGp7AG2+6GCk+ZI3vT0W6HAvTB3Oe/WnlubPKO40gJ1mLMm9rQuLc+n1tQf6l5K6WUmZVZSMCqG+aEb/cCQk4T7UnbCdUKr00w1IRAw0gIv9s6DOLy8ubEGQfM+CQx4bAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083046; c=relaxed/simple;
	bh=Qjhb1uOmk8zQdQk9UtlBXnrX95dGDnTVIYt+n3+66Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESvui1hgQy5p7uwefFwuHUxnxdNF8lVhtm523C/tivmiHXzpm4Nlhr9AqIdi7IdPyWHxSiVqwPQdJDtnVwywSVEBWUCSIrfUzVvWChDNdav1A8mXa2PGhQ5y3/2v5nuwViL+AUe/s9BBbjA9A+FvorEYgony408W7596bh6ZdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eksgF6Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B55EC116C6;
	Tue,  3 Feb 2026 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770083046;
	bh=Qjhb1uOmk8zQdQk9UtlBXnrX95dGDnTVIYt+n3+66Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eksgF6KeSDnB22KMtBo4iJ1Lw6l5LB0Idkr5dSU5b4hvPfdIKuaJM59ukY1kKP0iY
	 tbZ0t6e+vv0TpkmZjnQErC5DJil6gKCSVdLJheYCRy8eX8JdQxYkwlIok9TBoz4RMc
	 qPzAk69z8z4HMVrVlazeKNepwvKCB9T54+IeUnA2uX8nwZJCpG9lKosv+Kg/Ly+eB1
	 +lrjojCZ1j3P6QWeKWumZk3muazz2C4xRQsF57BiL4uNX99XXD5+X1yPYaMpuoNJIi
	 hUxcZDpZQINEQ1McfRcwYPmxnUBu0Su2WzWixKw9dI5lUuRRGfzNvNeBaLJShsKOyn
	 MV83gK3DiXOJg==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	shawnguo@kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	conor+dt@kernel.org,
	horms@kernel.org,
	richardcochran@gmail.com,
	robh@kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	wahrenst@gmx.net,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: Re: [net-next,v22,4/7] net: mtip: Add net_device_ops functions to the L2 switch driver
Date: Mon,  2 Feb 2026 17:42:48 -0800
Message-ID: <20260203014247.824561-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131233459.1625279-5-lukasz.majewski@mailbox.org>
References: <20260131233459.1625279-5-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,google.com,redhat.com,davemloft.net,gmail.com,lists.linux.dev,lists.infradead.org,gmx.net,pengutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-256073-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 164D3D3746
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Add net_device_ops functions to the L2 switch driver

This patch adds net_device_ops callbacks for the MTIP L2 switch driver,
including transmit, multicast configuration, MAC address handling, and
timeout recovery functions.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> +					struct net_device *dev, int port)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status;
> +	unsigned int index;
> +	struct cbd_t *bdp;
> +	void *bufaddr;
> +
> +	spin_lock_bh(&fep->hw_lock);

[ ... ]

> +	/* Save skb pointer. */
> +	fep->tx_skbuff[index] = skb;

mtip_start_xmit_port() stores sk_buffs in fep->tx_skbuff[index] and creates
DMA mappings, but mtip_switch_tx() which should complete TX operations is
empty:

static void mtip_switch_tx(struct switch_enet_private *fep)
{
}

The NAPI poll handler mtip_rx_napi() calls mtip_switch_tx() to reclaim
transmitted buffers. Since it does nothing, won't every transmitted packet
leak the skb and DMA mapping? Also, dirty_tx is never advanced, so the TX
ring will fill (cur_tx == dirty_tx) and stop accepting packets.

jakub: maybe add a TODO comment transiently here, since later patch implements
       the cleanup?

> +static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +
> +	dev->stats.tx_errors++;

Jakub Kicinski noted in v16 review that tx_errors are already counted by
the network stack, and the statistic is exposed per-queue in sysfs. Does
incrementing tx_errors here double-count timeout events?

https://lore.kernel.org/all/20250725151618.0bc84bdb@kernel.org/

> +	DO_ONCE(mtip_print_hw_state, dev);
> +
> +	schedule_work(&priv->tx_timeout_work);
> +}

