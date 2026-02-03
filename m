Return-Path: <netdev+bounces-256074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDMgJFRTgWnGFgMAu9opvQ
	(envelope-from <netdev+bounces-256074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:45:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D069D3772
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424213015CBB
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680E029DB88;
	Tue,  3 Feb 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSweUKQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C021770A;
	Tue,  3 Feb 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083067; cv=none; b=mZa91EdmNh3+gecGzG/RBvaFoVqw5YtLurTNycRdO9dHTc9sRIAOt4w0I68sbUHzTX9dYLA34IddBMHzlsIlQmidvvlMCzMpDZONeFfjDsulHeJ9LQQTIIKskp8zJoKCLbNaE+zfIfBltaTJ83hkDiclQmzYvzBh43t0pXKQeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083067; c=relaxed/simple;
	bh=uniYDI0bTTA8++3uJAQoOjtAdjCqnnfCLvtGF7pr7Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RW2F2VXgjUbB7TLlw4JAvg+SWorZ2vYnFWgOyHWPvtJ45wvd5OQysEJb2jbCGhZhccl75mdbsCZUAqDps3ebArU20B4jQNZPkmZfgvAZUn+Y7tqLrZ3u5yhqO+FAzbJLhDRWP0XgNRn5gv71Je7WENI0ZBAHiPD+CsxmxJpMcek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSweUKQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025F1C116C6;
	Tue,  3 Feb 2026 01:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770083066;
	bh=uniYDI0bTTA8++3uJAQoOjtAdjCqnnfCLvtGF7pr7Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSweUKQbO6ntU9uzE0+2CGsGehX5MKkDQGvDDPMLXyYUfhHUlHEPnQjUJoeC8JyGT
	 vUJfryFNq0NvbnLbaUajc0cTzpBIMKP6qcPWUjOoyEDo3i/5Z3nW64laUu0aAJcdtU
	 AqJb74XI4bxpUsvYAE3SsofXg1YniULwWrxo2foLJoDk9FsOqYb3EkJZ1eg5npii4Y
	 KvJ27eKXhTPS7idTQ68jji9H+SBhVhtIhU40/0hBf4SaZD5W6Mbc2tUyZ4FqwjeQsR
	 +F/DDMhNsO5TYLnZzL+7bkzX7cemi6RAZSgCVlmHmL+TWYKGnfmW9TsqAeQwv7OPwv
	 /ik84nTmwEa3w==
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
Subject: Re: [net-next,v22,7/7] net: mtip: Extend the L2 switch driver for imx287 with bridge operations
Date: Mon,  2 Feb 2026 17:44:07 -0800
Message-ID: <20260203014406.825146-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131233459.1625279-8-lukasz.majewski@mailbox.org>
References: <20260131233459.1625279-8-lukasz.majewski@mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,google.com,redhat.com,davemloft.net,gmail.com,lists.linux.dev,lists.infradead.org,gmx.net,pengutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-256074-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 3D069D3772
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Extend the L2 switch driver for imx287 with bridge operations

This commit adds bridge offloading support to the MTIP L2 switch driver,
allowing the switch to offload packet switching when a bridge is
created on its interfaces.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
> @@ -0,0 +1,132 @@

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
> +	err = switchdev_bridge_port_offload(ndev, ndev, NULL, NULL, NULL,
> +					    false, extack);
> +	if (err) {
> +		dev_err(&ndev->dev, "can't offload bridge port %s [err: %d]\n",
> +			ndev->name, err);
> +		return err;
> +	}

When switchdev_bridge_port_offload() fails after the second port joins the
same bridge, should the error path also revert br_offload and port
separation state?

In mtip_ndev_port_link() when the second port joins, the code sets
fep->br_offload = 1 and calls mtip_switch_dis_port_separation() before
attempting switchdev_bridge_port_offload(). If that call fails, the error
returns without reverting these changes.

This could leave the hardware with port separation disabled and br_offload
set to 1, even though only one port is actually bridged.

This concern was raised by Jakub Kicinski:
https://lore.kernel.org/netdev/20260131015440.972531-1-kuba@kernel.org/

