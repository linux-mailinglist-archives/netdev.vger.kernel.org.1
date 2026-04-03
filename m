Return-Path: <netdev+bounces-274832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGZYGnEVz2k2swYAu9opvQ
	(envelope-from <netdev+bounces-274832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:18:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E484C38FF1A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03E11304AD3B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616A1283CBF;
	Fri,  3 Apr 2026 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhBBdA+E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2212820A9;
	Fri,  3 Apr 2026 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179063; cv=none; b=c2gvxYMfGd4G1ojVxwYinj9ASWZyJaah9B+ncHlz2uaAnaF9qx0ESbmxlBqA3EqQq1SQ6oF/k6/69GO8naZfgXIeiKQQaLwxdAZYLtV8AzAUG2ibojhhAcRJyJU957N6p7vha2bbunqmPwcEPj+nITfhC4ydqLkrPKJQffOOZ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179063; c=relaxed/simple;
	bh=EFAVMQZdeYp3p63+e+4293CsTLGyJdiSV230CSFVXgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7cQ5HvUiOPsNa0u2C3Kx8CXtR51o+wb38XUyeP/MV/gx+FBmHFQCZKqPSDH5BXbm7yJciMSUDvOsUKNE4l2nMiwVLf972ExPhbUj42Gp+b0g0p+XzLPCnzUtOuxwDrOpr1RPFigYl+qAEfm0pOAFf4vr2G6smYmjfUDOQHeHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhBBdA+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC292C2BCB2;
	Fri,  3 Apr 2026 01:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179062;
	bh=EFAVMQZdeYp3p63+e+4293CsTLGyJdiSV230CSFVXgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhBBdA+EJaT7h1MeQGXuyT3xlz3LIwg2zub97gRs8+YKaNLTv9i3rQJ6KpghcbHBC
	 bSg9iIQ2UYl/BkWpegwYnRNu9yg/bqXeQHBU1j1XL/LBJtrQL2OinJ9KooKqP5APzT
	 mSMO9yiM8d5S4EEnHiHcmnxiw6ufdRrtxI8MpsplXg/m1C6DGWFSf5Eq2P8XcE8eAv
	 +6Prlu8zJJKuZnwhBJTP51sZZLpvHpSlP8iSlCifsp2LEt5tzZOUEA1I6B+UUZlx4D
	 8ua3RGw2eDYd/hEgp8w8qRloHWD29H+5oB+SzhbqzuSC1mWSJBHDFc9f9KXHm13Qe0
	 iGvMa0Nb+Zbhg==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 11/14] net: dsa: netc: add phylink MAC operations
Date: Thu,  2 Apr 2026 18:17:40 -0700
Message-ID: <20260403011740.1795694-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-12-wei.fang@nxp.com>
References: <20260331113025.1566878-12-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-274832-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E484C38FF1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: netc: add phylink MAC operations

Different versions of NETC switches have different numbers of ports and
MAC capabilities, so add .phylink_get_caps() to struct netc_switch_info.
In addition, related interfaces of struct phylink_mac_ops are added.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 5828fd3e342e..f11f5d0f6a6d 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
[ ... ]
> +static void netc_port_set_mac_mode(struct netc_port *np,
> +				   unsigned int mode,
> +				   phy_interface_t phy_mode)
> +{
> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII;
> +	u32 val = 0;
> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
[ ... ]
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		val |= IFMODE_SGMII;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> +}

In imx94_switch_phylink_get_caps(), PHY_INTERFACE_MODE_1000BASEX is
advertised as supported for ports 0 and 1. Does it need to be handled
in this switch statement? As written, it appears it will fall through
to the default case and clear the IFMODE bits, leaving the MAC in an
undefined mode.

[ ... ]
> +static void netc_port_mac_rx_enable(struct netc_port *np)
> +{
> +	netc_port_rmw(np, NETC_POR, PCR_RXDIS, 0);
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
> +			  PM_CMD_CFG_RX_EN);
> +}

Pseudo ports (like the CPU port) bypass PMAC register accesses during
graceful stop via is_netc_pseudo_port(). Should there be a similar check
here, and in netc_port_set_mac_mode(), to prevent accessing physical MAC
registers on pseudo ports?

Additionally, when np->caps.pmac is true, netc_port_mac_rx_graceful_stop()
disables the preemption MAC via NETC_PM_CMD_CFG(1). Should this function
re-enable it when bringing the link back up?

> +static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
> +{
> +	u32 val;
> +
> +	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
> +			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
> +		dev_warn(np->switch_priv->dev,
> +			 "MAC %d of swp%d RX is not empty\n", mac,
> +			 np->dp->index);
> +}

Is NETC_PM_IEVENT a sticky write-1-to-clear register? If the RX FIFO had
previously emptied during normal operation, could this bit already be set,
causing read_poll_timeout() to return immediately without waiting?

> +static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
> +{
> +	u32 val;
> +
> +	if (is_netc_pseudo_port(np))
> +		goto check_rx_busy;
> +
> +	if (np->caps.pmac) {
> +		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
> +		netc_port_wait_rx_empty(np, 1);
> +	}
> +
> +	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
> +	netc_port_wait_rx_empty(np, 0);
> +
> +check_rx_busy:
> +	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
> +			      100, 10000, false, np, NETC_PSR))
> +		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
> +			 np->dp->index);
> +
> +	netc_port_rmw(np, NETC_POR, PCR_RXDIS, PCR_RXDIS);
> +}

For pseudo ports, the code jumps directly to check_rx_busy and polls for
PSR_RX_BUSY to clear. Since PCR_RXDIS is only set after the polling
completes, will the RX pipeline continue accepting traffic and cause this
poll to always timeout on an active link?

> +static void netc_mac_link_up(struct phylink_config *config,
> +			     struct phy_device *phy, unsigned int mode,
> +			     phy_interface_t interface, int speed,
> +			     int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct netc_port *np;
> +
> +	np = NETC_PORT(dp->ds, dp->index);
> +	netc_port_set_speed(np, speed);
> +
> +	if (phy_interface_mode_is_rgmii(interface))
> +		netc_port_set_rgmii_mac(np, speed, duplex);
> +
> +	if (interface == PHY_INTERFACE_MODE_RMII ||
> +	    interface == PHY_INTERFACE_MODE_REVMII ||
> +	    interface == PHY_INTERFACE_MODE_MII)
> +		netc_port_set_rmii_mii_mac(np, speed, duplex);
> +
> +	netc_port_mac_rx_enable(np);
> +}

The callback imx94_switch_phylink_get_caps() advertises MAC_ASYM_PAUSE and
MAC_SYM_PAUSE capabilities. Is it expected that tx_pause and rx_pause are
ignored here? If flow control is implemented in a subsequent patch, should
the advertisement be deferred until then?

> +static void netc_mac_link_down(struct phylink_config *config,
> +			       unsigned int mode,
> +			       phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +
> +	netc_port_mac_rx_graceful_stop(NETC_PORT(dp->ds, dp->index));
> +}

This correctly stops the RX pipeline, but should the TX path
(PM_CMD_CFG_TX_EN or PCR_TXDIS) also be disabled when the link goes down?

