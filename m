Return-Path: <netdev+bounces-269836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A4GF6wDvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:22:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F11DB2D722C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4518E3005AA5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8F364E87;
	Fri, 20 Mar 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1hqN8NW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32BC2C21F2;
	Fri, 20 Mar 2026 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994921; cv=none; b=pman4u7Pe1KLdPP6INEa+ku2n61l+gGLLYgjYTWIDmKs33oKBR/JNfPWAUwWkOZUv3V+t3G0w4+YHQD5JnXlNa0nKq7jl3y55UvElsxsJNVCa/VAnRTMzb9TOy/Nnoie3iaAJp4FvqmmkpEEKmgNI7nNb0LOdzSnGGsPnQYMV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994921; c=relaxed/simple;
	bh=VAwbn9yntjgzOXfCk8e7ClFA69IREB1IE5dTu81tz40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikEXVt/3A824Uh7RD9KQg8p/2YCZyRMEPoC/ZRtg/GIw86SB+Yua7EgA/In6jnQYRufc1NPz+54daLwQr+bHNINBI8Z7Uf6U+EeDm7AB2PV3WfRZ5LKBqS7iuvOnFLA6Ys4VkwUmtJ7ALpFibZ61Ntnon6+SH49ImcgmNsOxJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1hqN8NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA688C4CEF7;
	Fri, 20 Mar 2026 08:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773994921;
	bh=VAwbn9yntjgzOXfCk8e7ClFA69IREB1IE5dTu81tz40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1hqN8NWVhrx3iV85VIY/VtUY6DxrYEkWjdtvN1g7a10Ul46uKui97xoPOR4Ri6VN
	 Y560vYo08S2dty8zgw3WIWH+gJoTMrq/2PxyU6uuCVA/4vr2ShC+hpK82dcGKRus2y
	 RtzRXGyh7aG1nW+R9ny4zKjoKj1V5UR+JDmEIaJfYgOZ+NfQlP/kqHU+BPL5ow+P4e
	 eixYs7PDAGDrLtS+D9w2yb9QY3uwlS76yFiirlht04Y2WTsVIqFKMhru/CPC8z+4Oa
	 P3YdtaXXIxxFuVx6Nwks2F86/mCcajapQOuf0wWrSEvpaK1KIndBGyarSIynJ5i0kL
	 ER7xLCgl4V4Dg==
Date: Fri, 20 Mar 2026 08:21:56 +0000
From: Simon Horman <horms@kernel.org>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, robh@kernel.org, kuba@kernel.org,
	maxime.chevallier@bootlin.com, pabeni@redhat.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, edumazet@google.com,
	davem@davemloft.net, hkallweit1@gmail.com
Subject: Re: [PATCH net-next v9 2/4] net: phy: realtek: add RTL8224 pair
 order support
Message-ID: <20260320082156.GX1753385@horms.kernel.org>
References: <20260318215502.106528-1-dam.dejean@gmail.com>
 <20260318215502.106528-3-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318215502.106528-3-dam.dejean@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269836-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,bootlin.com,redhat.com,vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F11DB2D722C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:54:59PM +0100, Damien Dejean wrote:

...

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c

...

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
> +	if (ret == -EINVAL || ret == -ENOSYS)
> +		return 0;

Checkpatch warns that ENOSYS only means 'invalid syscall nr'.

Looking over the implementation of of_property_read_u32() it seems to me
that -EINVAL is sufficient to detect that a property is not present. Which
may be appropriate here.

Likewise in patch 4/4.

Using a quick grep of the tree, I do notice the same pattern as above is
also present (only?) in aquantia_main.c.  So depending on the outcome of this
discussion it might be appropriate to update that too.

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

...

> @@ -2395,6 +2457,8 @@ static struct phy_driver realtek_drvs[] = {
>  		PHY_ID_MATCH_EXACT(0x001ccad0),
>  		.name		= "RTL8224 2.5Gbps PHY",
>  		.flags		= PHY_POLL_CABLE_TEST,
> +		.probe		= rtl8224_probe,
> +		.config_init	= rtl8224_config_init,
>  		.get_features	= rtl822x_c45_get_features,
>  		.config_aneg	= rtl822x_c45_config_aneg,
>  		.read_status	= rtl822x_c45_read_status,
> -- 
> 2.47.3
> 

