Return-Path: <netdev+bounces-254069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL1IJbVzeWkHxQEAu9opvQ
	(envelope-from <netdev+bounces-254069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:25:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC249C380
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80E333006512
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8F296BB8;
	Wed, 28 Jan 2026 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9o+jUi4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994928C864;
	Wed, 28 Jan 2026 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567154; cv=none; b=DI7wvRAxF4n6t97MS4nHPtcHYt4A6I5Tv+aD0lztoNvN1yiICtkqkaHHOzAJtYZNV/3R8wDiXqEo2dUDBxEniHMgY1YE+LlBOY7OTHrxAKwOcQ2kJf9/5QnE40mb4yOvXZjOBGknwvqotSs8YplWkR4ZQqBPlx23pdw7z7tONDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567154; c=relaxed/simple;
	bh=Mk9opi2AbVbBe/HXNJ/y7O89/iCTOme85Hdg19/TiCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLakOS5qogD3qUQ6KUOOhFJDnGSFLgp+fankuGHx64XE4nmzqQqkDPeT+FfFG17DVLzq3H3LKhsQjkyLiA49pnubucfqkTUxtj0S/dbVXzuoTVf7Sof1np95wBwSPZuFlcnOVFCs2RKdOIPUrvYJ/+Qgv8oqnXbkMLY6WxLJOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9o+jUi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34568C116C6;
	Wed, 28 Jan 2026 02:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567154;
	bh=Mk9opi2AbVbBe/HXNJ/y7O89/iCTOme85Hdg19/TiCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9o+jUi408eCNacnUmeDFNf/xEWzoBKRpV1QdqJIXBucZXBfPXgHnmbrnld7N2S+z
	 2cA0cXhxrD4M8IZf89k+rndSotQUAPzsCXrOr2PjpXDhl7RvuL+aoqd/39cbtSGFm3
	 oxg9Olnmo+Rvxn6VffmjYcOl9P3i3xL1hwUYJv6LnznKT4tWzdZc/K8RKjy42rOXfh
	 q/97s6dI6PaiEmJmn5uC5N2DuQ5KwbnkK9DTv7SI8EK4t2Z4XuaEs03RH4sPtM9HBl
	 BujDDi5NU/qLb1KrT6Fcl04UD7eXGM+QjOXRqpNbjBPg6ARqWeH74Rp6tFli6loO8B
	 Ykd7K6HZBEAEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	horms@kernel.org,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	wahrenst@gmx.net,
	pabeni@redhat.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	andrew@lunn.ch
Subject: Re: [net-next,v20,2/7] net: mtip: The L2 switch driver for imx287
Date: Tue, 27 Jan 2026 18:25:49 -0800
Message-ID: <20260128022549.4151341-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126103400.1683125-3-lukasz.majewski@mailbox.org>
References: <20260126103400.1683125-3-lukasz.majewski@mailbox.org>
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,pengutronix.de,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-254069-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FC249C380
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: The L2 switch driver for imx287

This patch adds support for the More Than IP L2 switch embedded in the
imx287 SoC. It creates a two-port switch driver that can be used
interchangeably with the FEC driver.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> new file mode 100644
> index 000000000000..03c5163d6508
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> +static void mtip_netif_stop_queues(struct switch_enet_private *fep)
> +{
> +	for (int i = 0; i < SWITCH_EPORT_NUMBER; i++)
> +		netif_stop_queue(fep->ndev[0]);
                                      ^^^

Should this be fep->ndev[i] instead of fep->ndev[0]? The loop iterates
with variable i but always uses index 0, so port 1's queue is never
stopped.

> +}
> +
> +static void mtip_netif_wake_queues(struct switch_enet_private *fep)
> +{
> +	for (int i = 0; i < SWITCH_EPORT_NUMBER; i++)
> +		netif_wake_queue(fep->ndev[0]);
                                      ^^^

Same here - should this be fep->ndev[i]?

> +}

[ ... ]

> +static int mtip_mii_probe(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct phy_device *phy_dev = NULL;
> +	int port_idx = priv->portnum - 1;
> +
> +	if (fep->phy_np[port_idx]) {
> +		phy_dev = of_phy_connect(dev, fep->phy_np[port_idx],
> +					 &mtip_adjust_link, 0,
> +					 fep->phy_interface[port_idx]);
> +		if (!phy_dev) {
> +			netdev_err(dev, "Unable to connect to phy\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	phy_set_max_speed(phy_dev, 100);
                          ^^^^^^^

If fep->phy_np[port_idx] is NULL (no phy-handle in DT for this port),
the if block is skipped and phy_dev remains NULL. Can this cause a NULL
pointer dereference in phy_set_max_speed()?

> +	fep->phy_dev[port_idx] = phy_dev;

[ ... ]

> +static int mtip_parse_of(struct switch_enet_private *fep,
> +			 struct device_node *np)
> +{
> +	struct device_node *p;
> +	unsigned int port_num;
> +	int ret = 0;
> +
> +	p = of_get_child_by_name(np, "ethernet-ports");
> +
> +	for_each_available_child_of_node_scoped(p, port) {
> +		if (of_property_read_u32(port, "reg", &port_num))
> +			continue;
> +
> +		if (port_num > SWITCH_EPORT_NUMBER) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This only validates the upper bound. If the device tree contains
reg = <0>, would fep->mac[port_num - 1] access fep->mac[-1]? Perhaps
the check should also verify port_num is at least 1?

> +			dev_err(&fep->pdev->dev,
> +				"%s: The switch supports up to %d ports!\n",
> +				__func__, SWITCH_EPORT_NUMBER);
> +			goto of_get_err;
> +		}
> +
> +		fep->n_ports = port_num;
> +		ret = of_get_mac_address(port, &fep->mac[port_num - 1][0]);

[ ... ]

> +	ret = mtip_mii_init(fep, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Cannot init phy bus (%d)!\n", __func__,
> +			ret);
> +		goto dma_free_coherent_memory;
> +	}
> +
> +	ret = mtip_ndev_init(fep, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Failed to create virtual ndev (%d)\n",
> +			__func__, ret);
> +		goto mdiobus_free_memory;
> +	}

[ ... ]

> + mdiobus_free_memory:
> +	mdiobus_free(fep->mii_bus);

mtip_mii_init() calls of_mdiobus_register() which registers the bus.
Should mdiobus_unregister() be called here before mdiobus_free()?
Compare with mtip_mii_remove() which does call mdiobus_unregister().

> + dma_free_coherent_memory:
> +	dma_free_coherent(&fep->pdev->dev, PAGE_SIZE, fep->rx_bd_base,
> +			  fep->bd_dma);
> +	fep->rx_bd_base = NULL;
> +	fep->tx_bd_base = NULL;
> +
> +	return ret;
> +}
> +
> +static void mtip_sw_remove(struct platform_device *pdev)
> +{
> +	struct switch_enet_private *fep = platform_get_drvdata(pdev);
> +
> +	mtip_ndev_cleanup(fep);
> +
> +	mtip_mii_remove(fep);
> +
> +	timer_delete_sync(&fep->timer_mgnt);
> +	platform_set_drvdata(pdev, NULL);
> +}

mtip_sw_probe() allocates DMA memory with dma_alloc_coherent() in
mtip_switch_dma_init(), but mtip_sw_remove() does not appear to free it.
Is this a memory leak on driver removal?
-- 
pw-bot: cr

