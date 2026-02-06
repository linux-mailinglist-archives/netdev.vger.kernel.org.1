Return-Path: <netdev+bounces-257400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMBZBaZRhWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:27:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB7F94BC
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED36E303102D
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF88261B70;
	Fri,  6 Feb 2026 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfpNsewM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AEC25FA29;
	Fri,  6 Feb 2026 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344803; cv=none; b=jPzktJqId46AZlyWclNWRI/3GUsMeOnU+FMacqllgCINESpVpuiwfBSoojxyz3lsW4u1kAPApsW8ABy22fL486+tC7Y3knwZmRT93OHnJG/CX1uMytRwZVto3iEaLsFvxs1xWyiI4gsrIj1fCab1oTIL30Z6TAR5JovGfqTkeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344803; c=relaxed/simple;
	bh=BGxa4AkQjOf9KjNL+3M9JW6M3qf5DIia81SBTdQjZEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie1XvUaaPhE5yxDVJ8HF2ymbuG9F7mjpADSEu/4RRUCZqdKeCJ25x9CrcWOiwwSwevhggabA6Ng0AaJWIdBzl4VxJeP8Ml2vddGyW/3prl2p3oiUgnxVxACS36csQs7PYp3LVQ5odOD6CrH6AW4UeUyrHprm35fQKF691pGp2lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfpNsewM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9857C4CEF7;
	Fri,  6 Feb 2026 02:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344802;
	bh=BGxa4AkQjOf9KjNL+3M9JW6M3qf5DIia81SBTdQjZEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfpNsewMoN7NeiErvzWr4YM0gimRQzHAzsFtl0FtyddxtbpHaim1GNN+9lzxfabgW
	 GyfINDqZa20XmUVpjvxy+B2XGeXYvWa4xJwyRh0WcINTGu6De1eHKpd6ZjA/mYYpWL
	 w2/cVjD9V9/WJ9MFQbofhTr+k+U+CrU9y8GAhAuENocSvKY8qIR0SdD/7sUbMAZhxl
	 xRfpM9OYyf/8vmxBvGm6c8eKQ4RTRl2xLn3JYct2jlOJ53ZAc/nTzW5UBdwoEt3s1Q
	 dhsQd8qtVu9VwwBU7l7nW5dLXLOItnJx5RsTiR6Yq/I59aoJKJYuPCOKPDfVEY3ipN
	 k1KLv2n5GtU1w==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	imx@lists.linux.dev,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org,
	davem@davemloft.net,
	kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	festevam@gmail.com,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	pabeni@redhat.com,
	shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wahrenst@gmx.net,
	richardcochran@gmail.com,
	s.hauer@pengutronix.de,
	netdev@vger.kernel.org,
	edumazet@google.com,
	robh@kernel.org
Subject: Re: [net-next,v23,2/7] net: mtip: The L2 switch driver for imx287
Date: Thu,  5 Feb 2026 18:26:40 -0800
Message-ID: <20260206022640.3197138-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204232135.1024665-3-lukasz.majewski@mailbox.org>
References: <20260204232135.1024665-3-lukasz.majewski@mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,lunn.ch,vger.kernel.org,davemloft.net,pengutronix.de,gmail.com,redhat.com,lists.infradead.org,gmx.net,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-257400-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 83EB7F94BC
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: The L2 switch driver for imx287

This patch provides support for More Than IP L2 switch embedded in the
imx287 SoC, a two port switch placed between uDMA[01] and MAC-NET[01]
for offloading network traffic.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/Kconfig b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> new file mode 100644
> index 000000000000..7767bd7c707b
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config FEC_MTIP_L2SW
> +	tristate "MoreThanIP L2 switch support to FEC driver"

This isn't a bug, but the vendor name formatting is inconsistent between
the description line ("MoreThanIP") and the help text below ("MoreThan
IP"). The vendor should be consistently named throughout the file.

> +	depends on OF
> +	depends on NET_SWITCHDEV
> +	depends on BRIDGE
> +	depends on SOC_IMX28 || COMPILE_TEST
> +	help
> +	  This enables support for the MoreThan IP L2 switch on i.MX
> +	  SoCs (e.g. iMX287). It offloads bridging to this IP block's

The SoC name "iMX287" should be "i.MX287" to match NXP's standard naming
convention used throughout the kernel for i.MX SoCs.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> new file mode 100644
> index 000000000000..0a193a12e160
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c

[ ... ]

> +static void mtip_mgnt_timer(struct timer_list *t)
> +{
> +	struct switch_enet_private *fep = timer_container_of(fep, t,
> +							     timer_mgnt);

Does this code cause undefined behavior? The timer_container_of macro
expands to container_of(t, typeof(*fep), timer_mgnt), which dereferences
the uninitialized 'fep' variable in the typeof() expression. This is the
first statement in the function where 'fep' is being declared and assigned
simultaneously.

Looking at how other timer callbacks use this macro, shouldn't this be:

	struct switch_enet_private *fep = container_of(t,
		struct switch_enet_private, timer_mgnt);

This will cause a crash when the timer fires at the mod_timer() call site
in mtip_config_switch().

[ ... ]

> +static void mtip_switch_tx(struct switch_enet_private *fep)
> +{
> +}
> +
> +static int mtip_switch_rx(struct net_device *dev, int budget)
> +{
> +	return -ENOMEM;
> +}

Can the driver actually send or receive packets with these implementations?

Looking at the call chain:
  mtip_interrupt() schedules NAPI on RX interrupt ->
  mtip_rx_napi() calls mtip_switch_rx() ->
  mtip_switch_rx() always returns -ENOMEM

This means all receive interrupts are treated as out-of-memory conditions
and no packets are ever delivered to the network stack. Similarly,
mtip_switch_tx() is an empty stub that does nothing.

The commit message states "It can be used interchangeably with current
FEC driver" which suggests a functional driver, but the network interface
cannot actually send or receive packets. Should the commit message clarify
this is an incomplete implementation, or are these functions missing their
implementation?

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
> +		if (!(port_num == 1 || port_num == 2)) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: The switch supports up to %d ports!\n",
> +				__func__, SWITCH_EPORT_NUMBER);
> +			goto of_get_err;
> +		}
> +
> +		fep->n_ports = port_num;
> +		ret = of_get_mac_address(port, &fep->mac[port_num - 1][0]);
> +		if (ret)
> +			dev_dbg(&fep->pdev->dev,
> +				"of_get_mac_address(%pOF) failed (%d)!\n",
> +				port, ret);
> +
> +		ret = of_property_read_string(port, "label",
> +					      &fep->ndev_name[port_num - 1]);
> +		if (ret < 0) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: Cannot get ethernet port name (%d)!\n",
> +				__func__, ret);
> +			goto of_get_err;
> +		}
> +
> +		ret = of_get_phy_mode(port, &fep->phy_interface[port_num - 1]);
> +		if (ret < 0) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: Cannot get PHY mode (%d)!\n", __func__,
> +				ret);
> +			goto of_get_err;
> +		}
> +
> +		fep->phy_np[port_num - 1] = of_parse_phandle(port,
> +							     "phy-handle", 0);

Can this code leak OF node references?

If the first port (port_num=1) successfully obtains its PHY handle via
of_parse_phandle() and stores the reference in phy_np[0], but a
subsequent port fails during of_property_read_string() for the 'label'
property or of_get_phy_mode(), the error path jumps to of_get_err which
only releases the parent node 'p'. The PHY handle reference obtained for
the first port is never released.

The error path returns to mtip_sw_probe() which returns error without
calling mtip_parse_of_cleanup(), leaking the phy_np[0] reference. Note
that line 1191 correctly calls mtip_parse_of_cleanup(fep) before goto,
showing the cleanup is needed for these earlier error paths too.

> +		if (!fep->phy_np[port_num - 1]) {
> +			mtip_parse_of_cleanup(fep);
> +			dev_err(&fep->pdev->dev,
> +				"%s: PHY handle not defined!\n", __func__);
> +			ret = -ENODEV;
> +			goto of_get_err;
> +		}
> +	}
> +
> + of_get_err:
> +	of_node_put(p);
-- 
pw-bot: cr

