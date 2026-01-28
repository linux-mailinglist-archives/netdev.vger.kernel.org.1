Return-Path: <netdev+bounces-254072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD5LCCd0eWkHxQEAu9opvQ
	(envelope-from <netdev+bounces-254072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:27:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C09C3D4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA85B3042080
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B62BCF46;
	Wed, 28 Jan 2026 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCNRmhuB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D929D27A;
	Wed, 28 Jan 2026 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567163; cv=none; b=F5MRUETG6llA092lpM+rQ3gJJFzFoVpqe9Z8r8cHzSnqmuLAUEySo/c6xhnzdJAsvpoEmc/+IxAR6luCsKGcR+p7Imp7pf4ieqjvUy4Zx44xaCqbhmFIIJSXjPOOnopaFNG9GNmJTxkhOeZQhPDkqCBDtvtOHEMfUdAlZ/PjhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567163; c=relaxed/simple;
	bh=vMscZPC7Wm4F8hG6O11Kv6/ikZ5BwfwyLFx3n8gvzBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXIk3lOgTKG5MhiIi3E/h2QAyc0otkIQMBdZJ8jVsjpzxiFVisCzu9rGWPYUaZy9qdGG19y4VF3UhYVJ+ewXB2UQvqjMWkrlhBpYZPv9uYkl1O4CgsQSwbamu4K4P52fYZjgYbhDyUl8Pnf+Paa6GaE0xBqXH90BSjW8nhOCd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCNRmhuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E6CC116C6;
	Wed, 28 Jan 2026 02:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567162;
	bh=vMscZPC7Wm4F8hG6O11Kv6/ikZ5BwfwyLFx3n8gvzBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCNRmhuBQjbShiqbz4z31FkueWSDBPkmtn1rJxqTFBzXspIPjbGEAzVXLDAgd1efr
	 MSmmHPpxVDjmAGRVjCh+xx4fIXRbNFWWs6DrHvU+hYAn2hmQvK5SlOlOrMCO4rGt8c
	 iVX3yrMsqOv6g4ch0owr09ljYZH1PwA8p83eVN01KtGUe5mBbBlLe6hPVK1jUXPcyK
	 DcpBM3873zFsafatju0/8VHGPhTm2abxt7qA9izTm+MBpKpQHvW9ihrpTu6d/heT9a
	 XiRVZT97S0cFs5Prmkkk9L2F+IswfLtg+WQZmF+7jm8iqa7Pj0T5VH+uR+RojW+L0b
	 abTanKCTBrgtg==
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
Subject: Re: [net-next,v20,7/7] net: mtip: Extend the L2 switch driver for imx287 with bridge operations
Date: Tue, 27 Jan 2026 18:26:00 -0800
Message-ID: <20260128022600.4151612-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126103400.1683125-8-lukasz.majewski@mailbox.org>
References: <20260126103400.1683125-8-lukasz.majewski@mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254072-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,pengutronix.de,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 514C09C3D4
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
> new file mode 100644
> index 000000000000..f961b9cc4e6a
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
> +			return notifier_from_errno(-EOPNOTSUPP);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Should this return -EOPNOTSUPP instead of notifier_from_errno(-EOPNOTSUPP)?
The caller mtip_netdevice_event() already wraps the return value with
notifier_from_errno(ret), so double-wrapping corrupts the return value.

Looking at similar drivers like cpsw_new.c (cpsw_netdevice_port_link),
the pattern is to return raw errno values here and let the event handler
do the conversion.

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
> +		return err;
> +	}

If switchdev_bridge_port_offload() fails, the state changes made earlier
in the function (br_offload, br_members, master_dev, and the hardware
configuration via mtip_switch_dis_port_separation and mtip_clear_atable)
are not rolled back.

Looking at cpsw_new.c for reference, it modifies br_members after the
switchdev call succeeds, avoiding the need for rollback. Could the state
updates here be reordered to happen after switchdev_bridge_port_offload()
returns successfully?

[ ... ]

> +static int mtip_netdevice_event(struct notifier_block *unused,
> +				unsigned long event, void *ptr)
> +{

[ ... ]

> +	return notifier_from_errno(ret);
> +}

[ ... ]

