Return-Path: <netdev+bounces-292683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJypCzA4GGqkgwgAu9opvQ
	(envelope-from <netdev+bounces-292683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:42:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 819835F2317
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 831E0315C87A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06813EFD00;
	Thu, 28 May 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vTNG3HfA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15063E833F;
	Thu, 28 May 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972014; cv=none; b=akQ2FKgffUeUKMdCHksleV7ULtjFVMmNPu1zgU5oI1PSUz3ICSJK3NU2ZcWS7U1gPOZ9Citt39JsuK6xeFQibK+lprmWj+L+/kFpBdUubFHhx0qaymnQbQG9QI5SiFRGfuQkr52DYLQuT4NyvrUyKZL3JYKNtrQL9sbYngRLK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972014; c=relaxed/simple;
	bh=TUaKSSYzOh+tCNAPuYkd6Rh0mn5Q5LNmZrKQiU/rzoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX53zMTqsxDWD4VJFk144U5ZI4X3kasPBNn/nAtA/BEPQtaXzf698ste6NthpnG71zuqTH2M2Z7EtRkFEQQ8TNSsJLsb19xBBfr34gt6KnzGznZvn4q3WNVtfeUKAOiPoBUuZiX9R8l10ViRBw79i2pnARwDUfNBTv9gbS+w8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vTNG3HfA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tl4dkmOXE83LrtwSDbBI8r2aOtU+kjp1aSTVhNG/37g=; b=vTNG3HfANGUqSlk7KcL7wn/vZR
	AGN++yyagZVgLgPDbgQYVOWj1lAkSdsRdTexm+dvkkMDXtLuP0q1BhTSrBHJGDR2DRraqeHXBQerM
	+YTn+Bv786tMkdPq2xeOO8pkCDrjyfOTY8gVy73/6JIHNp2Nq5Kz62J/v3DFjLVFkPyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSa1l-004tuZ-9z; Thu, 28 May 2026 14:39:57 +0200
Date: Thu, 28 May 2026 14:39:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Message-ID: <a9f0800b-7aa6-41e9-bab2-bdd1f4dd9534@lunn.ch>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528075226.1054-2-javen_xu@realsil.com.cn>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 819835F2317
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static int rtl8261x_soft_reset(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, MDIO_CTRL1_RESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
> +					 MDIO_CTRL1, val,
> +					 !(val & MDIO_CTRL1_RESET),
> +					 5000, 100000, true);

We have a few copies of this function in various PHY drivers. Please
add a genphy_c45_soft_reset() helper.

> +}
> +
> +static int rtl8261x_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct rtl8261x_priv *priv;
> +	int sub_phy_id, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_ADDR_REG,
> +			    RTL_8261X_SUB_PHY_ID_ADDR);
> +	if (ret < 0)
> +		return ret;

blank line

> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_DATA_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	sub_phy_id = (ret >> 8) & 0xff;
> +	priv->sub_phy_id = sub_phy_id;
> +	priv->is_generic = false;
> +
> +	switch (sub_phy_id) {
> +	case RTL8261C_CE_MODEL:
> +		priv->model = RTL8261_MODEL_C_CE;
> +		phydev_info(phydev, "RTL8261C/CE detected (sub_id 0x%02x)\n", sub_phy_id);
> +		break;
> +
> +	case RTL8261D_MODEL:
> +		priv->model = RTL8261_MODEL_D;
> +		phydev_info(phydev, "RTL8261D detected (sub_id 0x%02x)\n", sub_phy_id);
> +		break;
> +
> +	default:
> +		priv->model = RTL8261_MODEL_GENERIC;
> +		priv->is_generic = true;
> +		phydev_warn(phydev, "Unknown sub_id 0x%02x! Using GENERIC mode. Update driver for full support.\n",
> +			    sub_phy_id);
> +		break;

This will get ignored. It is better to return -ENODEV so the probe
fails.

	Andrew

