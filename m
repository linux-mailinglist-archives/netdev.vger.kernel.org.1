Return-Path: <netdev+bounces-255313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLjALpdgfWkARwIAu9opvQ
	(envelope-from <netdev+bounces-255313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:53:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214AC01F6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D6593012262
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9D324B23;
	Sat, 31 Jan 2026 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/kAt6sA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1119F121;
	Sat, 31 Jan 2026 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824403; cv=none; b=hIURfpwhCI+PioxRU1eHDiFGEeh5+7lHFJuu8OG/BLPUDH5PdgSs1rsLyZn/8UgliLJ+TImvHDXyxNksPo1p+KmbYpB3lsoAXwa/qtY6H85vadbxKC8Y8ZtJeJk34Ko00/0HarwJPpy04nRxPTPq9y6Tb9wSDNlCRg2f8yiOtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824403; c=relaxed/simple;
	bh=99KJhPk8+9eW+ygqQJ11pSf6I+P6NX17cvOfztpm/Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaCIdFrZpafFrBMG2zwrqF0A+n3E0qfSIHeqmINzEusKabGy2DnD92ih/WKkf5HTPu53FCop7ywdE8k52xWOpfsCz2PyOflEwjGJ4TqyDPRlazElLDPhNPrf9gGYl7SECxO/94ehvvdDH1cvp94oSA6uXgQZPmHyC4xwJuxBfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/kAt6sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B5CC4CEF7;
	Sat, 31 Jan 2026 01:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824402;
	bh=99KJhPk8+9eW+ygqQJ11pSf6I+P6NX17cvOfztpm/Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/kAt6sAmiu3YK1Yx3s2icYGlVsyVeQ5jwqbyDLkiopyaTmOqEI9Zqc6F3URaxdpT
	 EdgY+LCrvQDHy5yjGlfc6w854JLtZxKkZvcGF6ZpiCv8HTWEApgK3YHiGzaLDOwyvJ
	 BANHrv0vASrR/E5yiDKGwUTdZ9JFYLBpkGoGU8CUDh9JLifXOG7yzGcwlJ88TiwWMz
	 jrWZVbqf7HBxRYpN+JAuAt+134qHEi/Y/+J5RcV9ynOlKrkztUl4t5OsUDS2UtTo9G
	 ZH4iIHdMqWn9GoMFSlROOcrYW94bHJYJGiQ60QA/BpC217s99ZwTU+6APOIPmvtImG
	 fHQpetXJom7jw==
From: Jakub Kicinski <kuba@kernel.org>
To: dam.dejean@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [v4,2/4] net: phy: realtek: add RTL8224 pair order support
Date: Fri, 30 Jan 2026 17:53:20 -0800
Message-ID: <20260131015320.971482-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129101606.33972-2-dam.dejean@gmail.com>
References: <20260129101606.33972-2-dam.dejean@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255313-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,gmail.com,vger.kernel.org,redhat.com,google.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6214AC01F6
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: realtek: add RTL8224 pair order support

This patch adds MDI pair order configuration support for the RTL8224 PHY,
allowing device tree configuration of pair swap (ABCD to DCBA) via the
enet-phy-lane-order property.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c

[ ... ]

> +static int rtl8224_mdi_config_order(struct phy_device *phydev)
> +{
> +	struct device_node *np = phydev->mdio.dev.of_node;
> +	u8 port_offset = phydev->mdio.addr & 3;
> +	u32 order = 0;
> +	int ret, val;
> +
> +	ret = of_property_read_u32(np, "enet-phy-lane-order", &order);
> +
> +	/* Do nothing in case the property is not present */
> +	if (ret == -EINVAL)
> +		return 0;
> +
> +	if (ret)
> +		return ret;
> +
> +	if (order & ~1)
> +		return -EINVAL;
> +
> +	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
> +				     RTL8224_VND1_MDI_PAIR_SWAP);

Should the MDIO bus lock be held before calling __phy_package_read_mmd()?

The __phy_package_read_mmd() documentation states "Same calling rules as
for __phy_read()", and __phy_read() requires: "The caller must have taken
the MDIO bus lock."

Looking at __mdiobus_read(), there is a lockdep_assert_held_once() check
for bus->mdio_lock, which confirms this requirement.

Other PHY drivers using these APIs acquire the lock first. For example,
qca807x_phy_package_config_init_once() wraps its __phy_package_read_mmd()
calls with phy_lock_mdio_bus()/phy_unlock_mdio_bus().

Additionally, since this is a read-modify-write on a shared register that
contains bits for all 4 ports in the package, could concurrent config_init
calls from different ports race and overwrite each other's settings without
the lock protecting the entire sequence?

> +	if (val < 0)
> +		return val;
> +
> +	if (order)
> +		val |= (1 << port_offset);
> +	else
> +		val &= ~(1 << port_offset);
> +
> +	return __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
> +				       RTL8224_VND1_MDI_PAIR_SWAP, val);
> +}
-- 
pw-bot: cr

