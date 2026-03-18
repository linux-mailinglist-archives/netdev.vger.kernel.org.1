Return-Path: <netdev+bounces-268854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dA9CGw4KumkrQwIAu9opvQ
	(envelope-from <netdev+bounces-268854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:12:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7692B5203
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72AFB3048B05
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1111C3BF7;
	Wed, 18 Mar 2026 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bojTxDSz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5529CE1;
	Wed, 18 Mar 2026 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773799947; cv=none; b=I0H6/OE00qKmkzaBDbGzspsKLGgoi7qlYxJwshZNwz84k3n5fZexGN/ozs0JuGeL5qbsN9XurWFbP0LUouw8FM0KG+LEKBPlqM435l1ckJWTqOSzMbO/SqQAEJaUSodB/xtLRc3QB8fGU4vkUdLfOUBcRivBvXX5MH3DdL6RDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773799947; c=relaxed/simple;
	bh=x5LFqDjMsxepnMIkeF4PD5RcLu1KHMEXZb/pfgA4YgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrm8ZtXidoNTkXRoJkxLicLjgbCRc2iMPPV3liKTzCPRzKcu1RKPiuyuf53ifE7fbdCuKPFZWN52vqNqEhp1fwqE6gmbe8dgMQHW9+sa57Z9Ce4iclzWynLqGXodYypsPnws4pY8RHcSeC2d8XSVW87dERVF+p1Bg30Cnm0LVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bojTxDSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA65DC4CEF7;
	Wed, 18 Mar 2026 02:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773799947;
	bh=x5LFqDjMsxepnMIkeF4PD5RcLu1KHMEXZb/pfgA4YgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bojTxDSzmkr8iEiTftL6O81v9A+kbD4HWJT/vmaNiM1YZYpbaVK1RkccfG7DSoHnP
	 nm5noqZS49GWTZo1fIh7TePW2ZjqMYEgZhK6yvE6BAP1KRZisvbIKzwvW5Ku7HKsNP
	 8VycDRGWGeOahkJCMV6FbHbkesR1e41kJld2KGAEloMpunWGW3xFp86dxeMn2MpKg1
	 7lE+uLwjLsPZd1wBlwzkSqqZvt0nwm9KmS8523vScDTE1v75uQUTI/aPINfSt89PVq
	 aZ1O3uV8PluvjhrzI5dMv1d1XyGIpPCPEtfxKlteli35gE23+2lx0cqtw61aO/cfMH
	 tZvfgFe32asPA==
From: Jakub Kicinski <kuba@kernel.org>
To: dam.dejean@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	hkallweit1@gmail.com,
	andrew@lunn.ch,
	edumazet@google.com,
	maxime.chevallier@bootlin.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v8,2/4] net: phy: realtek: add RTL8224 pair order support
Date: Tue, 17 Mar 2026 19:12:22 -0700
Message-ID: <20260318021222.1391487-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315204454.124544-3-dam.dejean@gmail.com>
References: <20260315204454.124544-3-dam.dejean@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268854-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,davemloft.net,gmail.com,lunn.ch,google.com,bootlin.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA7692B5203
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: realtek: add RTL8224 pair order support

The RTL8224 has a register to configure a pair swap (from ABCD order to
DCBA) providing PCB designers more flexbility when wiring the chip. The
swap parameter has to be set correctly for each of the 4 ports before
the chip can detect a link.

> diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
> index b05c2a1e9024..a741b34d193e 100644
> --- a/drivers/net/phy/realtek/Kconfig
> +++ b/drivers/net/phy/realtek/Kconfig

[ ... ]

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 530b4e26d16e..2feb085f5c9e 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c

[ ... ]

> @@ -1820,6 +1822,66 @@ static int rtl8224_cable_test_get_status(struct phy_device *phydev, bool *finish
>  	return rtl8224_cable_test_report(phydev, finished);
>  }
>
> +static int rtl8224_package_modify_mmd(struct phy_device *phydev, int devad,
> +				      u32 regnum, u16 mask, u16 set)
> +{
> +	int val, ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	val = __phy_package_read_mmd(phydev, 0, devad, regnum);
> +	if (val < 0) {
> +		ret = val;
> +		goto exit;
> +	}
> +
> +	val &= ~mask;
> +	val |= set;
> +
> +	ret = __phy_package_write_mmd(phydev, 0, devad, regnum, val);
> +
> +exit:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
> +static int rtl8224_mdi_config_order(struct phy_device *phydev)
> +{
> +	struct device_node *np = phydev->mdio.dev.of_node;
> +	u8 port_offset = phydev->mdio.addr & 3;
> +	u32 order = 0;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "enet-phy-pair-order", &order);
> +
> +	/* Do nothing in case the property is not present */
> +	if (ret == -EINVAL)
> +		return 0;

Does this handle the CONFIG_OF=n case correctly?

When CONFIG_OF is disabled, of_property_read_u32() returns -ENOSYS (see
include/linux/of.h:736), not -EINVAL. The check above only handles -EINVAL,
so the subsequent error check propagates -ENOSYS:

static int rtl8224_mdi_config_order(struct phy_device *phydev)
{
	...
	ret = of_property_read_u32(np, "enet-phy-pair-order", &order);

	if (ret == -EINVAL)
		return 0;

	if (ret)
		return ret;  /* -ENOSYS propagates here */
	...
}

This causes rtl8224_config_init() to return -ENOSYS, which then propagates
through phy_init_hw(), failing RTL8224 PHY initialization on non-OF kernel
configurations.

REALTEK_PHY has no 'depends on OF' in its Kconfig, so CONFIG_OF=n is a valid
build configuration. Before this patch, RTL8224 had no config_init callback,
so this is a new failure path.

Could the code handle -ENOSYS in addition to -EINVAL, or use
device_property_read_u32() which is firmware-agnostic?

> +
> +	if (ret)
> +		return ret;
> +
> +	if (order & ~1)
> +		return -EINVAL;
> +
> +	return rtl8224_package_modify_mmd(phydev, MDIO_MMD_VEND1,
> +					  RTL8224_VND1_MDI_PAIR_SWAP,
> +					  BIT(port_offset),
> +					  order ? BIT(port_offset) : 0);
> +}
> +
> +static int rtl8224_config_init(struct phy_device *phydev)
> +{
> +	return rtl8224_mdi_config_order(phydev);
> +}

[ ... ]
-- 
pw-bot: cr

