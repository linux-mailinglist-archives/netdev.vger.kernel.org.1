Return-Path: <netdev+bounces-255318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKN+AylhfWkARwIAu9opvQ
	(envelope-from <netdev+bounces-255318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:55:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D201C025B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 047693029C35
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C04332EAE;
	Sat, 31 Jan 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkPomI6Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A67274B32;
	Sat, 31 Jan 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824482; cv=none; b=UXCt5ZyswuR/dHNBF9r/jiLmRY8+MdO7qvZOvLk1SCOQ6hsUvMAzkhKGT3Gqg2/Hd/CgehFAvk0QjsSwIqfM+4FC8b8Dt/diuWaKer932+ig1l7U+tmlKOryJhtpgGhoBC5jJ8kjOILV0JVUbIl5psf2F2hMrvqiYXQkvDiqO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824482; c=relaxed/simple;
	bh=TsyqeOrPuckAqP0Hj4KXTJnB1l2bVSsm7IOcY61ZTe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1I1Fi/eAZQm7+Mpg4H5W16q7Un6ukhQ4jVWux6o1Ojh0/c7sk6ECKqH4XPK1aGEHI6Q2ddzIi8bZKveoeDF4K4xtb/kpwdS4SVpzCjLW5g509hfN4jLiNEPLmbcH9WcGMTF49sYtjOyqPfhPwFYepN+2zboI+/VKvQuuPDHzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkPomI6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B21C19421;
	Sat, 31 Jan 2026 01:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824482;
	bh=TsyqeOrPuckAqP0Hj4KXTJnB1l2bVSsm7IOcY61ZTe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkPomI6Q0yax9KU0rc40lebfnQzP7qWqBJUMuw1c0L65LGVBshpN49QaTGfvBXj85
	 Hqq97zQvMxDDTgzkyFjphw/VBXKvzGRMPPMp/OG6yjF55IPgywh3+WAVwIBoqI2XAE
	 J0IepQAxgBIIuUA5WbNvpGXEsLcwGISZWy+B8tEkLtdYlYTvnxh5SYM5p8itnPIk3y
	 f0IIfMzUCqNkuJUo0YJn1azFrKMDJJRsgH1GAElPnfzDWyjpnob5MN5EZcAHEjCztX
	 IEQT5lpGe3zs5gVXOTHKs7niJbJDTXA+sCiBqsbs6H83yvq5J5XblNJmkEiyClwD/W
	 Rf8nHrg+IaUwQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	richardcochran@gmail.com,
	shawnguo@kernel.org,
	edumazet@google.com,
	linux-arm-kernel@lists.infradead.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	wahrenst@gmx.net,
	davem@davemloft.net,
	festevam@gmail.com,
	conor+dt@kernel.org,
	imx@lists.linux.dev,
	andrew@lunn.ch,
	robh@kernel.org
Subject: Re: [net-next,v21,7/7] net: mtip: Extend the L2 switch driver for imx287 with bridge operations
Date: Fri, 30 Jan 2026 17:54:40 -0800
Message-ID: <20260131015440.972531-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129110154.1699976-8-lukasz.majewski@mailbox.org>
References: <20260129110154.1699976-8-lukasz.majewski@mailbox.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255318-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,pengutronix.de,gmail.com,google.com,lists.infradead.org,lunn.ch,redhat.com,gmx.net,davemloft.net,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7D201C025B
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Extend the L2 switch driver for imx287 with bridge operations

This patch adds bridge operations support to the MTIP L2 switch driver,
enabling hardware offloading for packet switching when a bridge is
created on the switch interfaces.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c

[ ... ]

> +static int mtip_ndev_port_link(struct net_device *ndev,
> +			       struct net_device *br_ndev,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(ndev), *other_priv;
> +	struct switch_enet_private *fep = priv->fep;
> +	struct net_device *other_ndev;
> +	int err;
> +
> +	/* Check if one port of MTIP switch is already bridged */
> +	if (fep->br_members && !fep->br_offload) {
> +		/* Get the second bridge ndev */
> +		other_ndev = fep->ndev[fep->br_members - 1];
> +		other_priv = netdev_priv(other_ndev);
> +		if (other_priv->master_dev != br_ndev) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "L2 offloading only possible for the same bridge!");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		fep->br_offload = 1;
> +		mtip_switch_dis_port_separation(fep);
> +		mtip_clear_atable(fep);
> +	}
> +
> +	if (!priv->master_dev)
> +		priv->master_dev = br_ndev;
> +
> +	fep->br_members |= BIT(priv->portnum - 1);
> +
> +	err = switchdev_bridge_port_offload(ndev, ndev, NULL, NULL, NULL,
> +					    false, extack);
> +	if (err) {
> +		dev_err(&ndev->dev, "can't offload bridge port %s [err: %d]\n",
> +			ndev->name, err);
> +
> +		fep->br_members &= ~BIT(priv->portnum - 1);
> +		priv->master_dev = NULL;
> +
> +		return err;
> +	}

When switchdev_bridge_port_offload() fails, should the error path also
revert the state changes made earlier? Specifically, when the second port
joins the same bridge and passes the bridge check, the code sets
fep->br_offload = 1 and calls mtip_switch_dis_port_separation(). However,
the error handling only clears br_members and master_dev.

If switchdev_bridge_port_offload() fails at this point, fep->br_offload
remains set to 1 and port separation stays disabled, even though only
one port is actually bridged. This could leave the hardware in an
inconsistent state.

Looking at the TI cpsw driver for comparison, it modifies br_members
after switchdev_bridge_port_offload() succeeds, avoiding this ordering
issue.

