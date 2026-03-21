Return-Path: <netdev+bounces-270151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PIFHOikAvmn1FAMAu9opvQ
	(envelope-from <netdev+bounces-270151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:19:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA72E2E12
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B029B30158BA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6C752F8B;
	Sat, 21 Mar 2026 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/zJBqRG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450A40DFC3;
	Sat, 21 Mar 2026 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059558; cv=none; b=tuOahgQj6uDo5r2fu3MTiaxFvUxlzHRQqZsm2hY9+w3SXXDA0FePSGRVMvkw0jWtDji5h1Apcmq+h1Zhc8YC7DPpw7X1XrWgw+UuzVcOJwlX07KI5AV/redRw5ms0ggLHMq0YzyKzRKgyIoq1hEJYxAQ+FoEnwHx1Hmc2Fa1KpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059558; c=relaxed/simple;
	bh=V+fGAlqueSjNVvwNKqSgq10iNWEHARBnIs7AMPZWZdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4JWIghfd66q7Jin8Pkz3NWUoYPvn2qW6O93051C13kFhXDbFAP4mU2T/1ldIeG6uXIeeJEE/10FthaS0UjbE1QThQfPj46sIu1Z/u7mhNKKzMSLQy1esb0ULbjjDaMt50PTL4GfnGmyAHo6f64ASEkgwE7rS3MNqpprcHJAhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/zJBqRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A9CC4CEF7;
	Sat, 21 Mar 2026 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059558;
	bh=V+fGAlqueSjNVvwNKqSgq10iNWEHARBnIs7AMPZWZdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/zJBqRG4pcccLwIJWbaMqfCbaItGdzU/eG9KpeSz53PwxW4Zm62t/2fKkI1gb20j
	 BOpkeDD9uSuXgghbFS5VcnDu5ooksvzWJTuvUzoTkJfx00Oc07ydHvXRShgOsc23+R
	 6Q1UfI1v4sM2lClsaqc9gQqc+RRYJkU6TBL2Vm6MZAvCeDRL9GQEoHQeaf3Nadym2Q
	 Me/N2xunxzONk0iqQLzK/UA155uLxkM7WHW8Qrq9iT3FlOJ/H9wnRFCMrcnA1r5r3j
	 Ysssv0lggEQyXxMHOcTxYNOlyjVXc+gKZIDtfxfFCkrE5JPDtR+tm7RJtaNpyh2OEA
	 76xCCY5an75Hw==
From: Jakub Kicinski <kuba@kernel.org>
To: ioana.ciornei@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: dpaa2-mac: export standard statistics
Date: Fri, 20 Mar 2026 19:19:16 -0700
Message-ID: <20260321021916.3948080-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319142346.2483232-4-ioana.ciornei@nxp.com>
References: <20260319142346.2483232-4-ioana.ciornei@nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270151-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 47BA72E2E12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dpaa2-mac: export standard statistics

This commit adds support for exporting MAC statistics through the
standard ethtool statistics structures (rmon, eth-ctrl, eth-mac, and
pause) in the dpaa2-mac driver for both dpaa2-eth and dpaa2-switch.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
> index baab4f1c908d..59f5c778df38 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c

[ ... ]

> @@ -962,4 +1017,8 @@ const struct ethtool_ops dpaa2_ethtool_ops = {
>  	.get_coalesce = dpaa2_eth_get_coalesce,
>  	.set_coalesce = dpaa2_eth_set_coalesce,
>  	.get_channels = dpaa2_eth_get_channels,
> +	.get_rmon_stats = dpaa2_eth_get_rmon_stats,
> +	.get_pause_stats = dpaa2_eth_get_pause_stats,
> +	.get_eth_ctrl_stats = dpaa2_eth_get_ctrl_stats,
> +	.get_eth_mac_stats = dpaa2_eth_get_eth_mac_stats,
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
> index a888f6e6e9b0..f5d9321c7ef9 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c

[ ... ]

> @@ -210,6 +210,49 @@ static void dpaa2_switch_ethtool_get_stats(struct net_device *netdev,
>  	mutex_unlock(&port_priv->mac_lock);
>  }
>
> +static void
> +dpaa2_switch_get_rmon_stats(struct net_device *netdev,
> +			    struct ethtool_rmon_stats *rmon_stats,
> +			    const struct ethtool_rmon_hist_range **ranges)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> +
> +	mutex_lock(&port_priv->mac_lock);
> +
> +	if (dpaa2_switch_port_has_mac(port_priv))
> +		dpaa2_mac_get_rmon_stats(port_priv->mac, rmon_stats, ranges);
> +
> +	mutex_unlock(&port_priv->mac_lock);
> +}
> +
> +static void
> +dpaa2_switch_get_ctrl_stats(struct net_device *net_dev,
> +			    struct ethtool_eth_ctrl_stats *ctrl_stats)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
> +
> +	mutex_lock(&port_priv->mac_lock);
> +
> +	if (dpaa2_switch_port_has_mac(port_priv))
> +		dpaa2_mac_get_ctrl_stats(port_priv->mac, ctrl_stats);
> +
> +	mutex_unlock(&port_priv->mac_lock);
> +}
> +
> +static void
> +dpaa2_switch_get_eth_mac_stats(struct net_device *net_dev,
> +			       struct ethtool_eth_mac_stats *eth_mac_stats)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
> +
> +	mutex_lock(&port_priv->mac_lock);
> +
> +	if (dpaa2_switch_port_has_mac(port_priv))
> +		dpaa2_mac_get_eth_mac_stats(port_priv->mac, eth_mac_stats);
> +
> +	mutex_unlock(&port_priv->mac_lock);
> +}
> +
>  const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
>  	.get_drvinfo		= dpaa2_switch_get_drvinfo,
>  	.get_link		= ethtool_op_get_link,
> @@ -218,4 +261,7 @@ const struct ethtool_ops dpaa2_switch_port_ethtool_ops = {
>  	.get_strings		= dpaa2_switch_ethtool_get_strings,
>  	.get_ethtool_stats	= dpaa2_switch_ethtool_get_stats,
>  	.get_sset_count		= dpaa2_switch_ethtool_get_sset_count,
> +	.get_rmon_stats		= dpaa2_switch_get_rmon_stats,
> +	.get_eth_ctrl_stats	= dpaa2_switch_get_ctrl_stats,
> +	.get_eth_mac_stats	= dpaa2_switch_get_eth_mac_stats,
>  };

Is the .get_pause_stats callback missing from the dpaa2-switch driver?

The commit message states that rmon, eth-ctrl, eth-mac, and pause
statistics are exported for both dpaa2-eth and dpaa2-switch drivers.

Looking at dpaa2-ethtool.c, the dpaa2-eth driver registers all four
callbacks in dpaa2_ethtool_ops:

	.get_rmon_stats = dpaa2_eth_get_rmon_stats,
	.get_pause_stats = dpaa2_eth_get_pause_stats,
	.get_eth_ctrl_stats = dpaa2_eth_get_ctrl_stats,
	.get_eth_mac_stats = dpaa2_eth_get_eth_mac_stats,

But dpaa2_switch_port_ethtool_ops only registers three callbacks. The
underlying MAC layer function dpaa2_mac_get_pause_stats() exists and is
declared in dpaa2-mac.h.

Also, dpaa2_mac_open() allocates DMA memory for mac->pause_stats when
DPAA2_MAC_FEATURE_STANDARD_STATS is set:

drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:dpaa2_mac_open() {
	...
	if (mac->features & DPAA2_MAC_FEATURE_STANDARD_STATS) {
		dpaa2_mac_setup_stats(mac, &mac->rmon_stats,
				      DPAA2_MAC_NUM_RMON_STATS,
				      dpaa2_mac_rmon_stats);

		dpaa2_mac_setup_stats(mac, &mac->pause_stats,
				      DPAA2_MAC_NUM_PAUSE_STATS,
				      dpaa2_mac_pause_stats);

		dpaa2_mac_setup_stats(mac, &mac->eth_ctrl_stats,
				      DPAA2_MAC_NUM_ETH_CTRL_STATS,
				      dpaa2_mac_eth_ctrl_stats);

		dpaa2_mac_setup_stats(mac, &mac->eth_mac_stats,
				      DPAA2_MAC_NUM_ETH_MAC_STATS,
				      dpaa2_mac_eth_mac_stats);
	}
	...
}

Without the .get_pause_stats callback in the switch driver, would the
pause_stats DMA resources be allocated but never used?
-- 
pw-bot: cr

