Return-Path: <netdev+bounces-119073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD6953F6B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707BD283E99
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59DD219E4;
	Fri, 16 Aug 2024 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e0Ki8uDZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAD250EC;
	Fri, 16 Aug 2024 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774507; cv=none; b=P1T05kH7wgazO8enDDz+neOCcwbJD3mZPwHJ76m8zWr96BU+Kc95wSEO8+bN+7INOIroqTD8NERa9ssq+ooVysdeIiVD03S6N3PJilOy4ZoEOC93zOfIxzf+zBt//go62BTaoq+qz7e398ardv0/tQ/H2S0xdX0eV77vnNHfvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774507; c=relaxed/simple;
	bh=sUGtqu/9PTnQywktUayz/5ZrMur71YH/nvZ881cOjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlINHnbXSFzM/Hz8TArBuYpyEyEJ79Q3PsgTk+ibL6tnp9QAPo29f6Vhjs6QMT5VOOyXm2s2Jwre7WvGzqm4VaLqChKBNaPY8ULT4//dwcfhlPAFouAtUU0csv4O2esYAOspYY+6knHEVuip8RLCAQ54Er0x4uxEpSrNmT/UXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e0Ki8uDZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LeE7IPjDOKU75+xazv9Nvs+lKzEzexvyuxo5v5nivL8=; b=e0Ki8uDZtH3ea0rxPNedpz6kEl
	GxKrZmgADIVSsIgnbJwSw/+RAD7r2bF3MN2chocCHKSxR0St3tGsWcq8zW135DINRvP85LKMJYswN
	4tvmeIbM6dTxk2gasBT8tDKQ9aNWmc3RjvBfHuTlWh9ODqW9YUF8dei/xqPjMcF9v6eQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1semUP-004tLa-0k; Fri, 16 Aug 2024 04:14:53 +0200
Date: Fri, 16 Aug 2024 04:14:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, jdamato@fastly.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 net-next 03/11] net: hibmcge: Add mdio and
 hardware configuration supported in this module
Message-ID: <23628b1a-d3ea-47ed-8289-60e455a90b72@lunn.ch>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
 <20240813135640.1694993-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813135640.1694993-4-shaojijie@huawei.com>

> +int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
> +{
> +	if (speed != HBG_PORT_MODE_SGMII_10M &&
> +	    speed != HBG_PORT_MODE_SGMII_100M &&
> +	    speed != HBG_PORT_MODE_SGMII_1000M)
> +		return -EOPNOTSUPP;
> +
> +	if (duplex != DUPLEX_FULL && duplex != DUPLEX_HALF)
> +		return -EOPNOTSUPP;


Can this happen? We try to avoid defensive code, preferring to ensure
it can never happen. So long as you have told phylib the limits of
your hardware, it should enforce these.

> @@ -26,11 +27,11 @@ static int hbg_init(struct hbg_priv *priv)
>  		return dev_err_probe(dev, PTR_ERR(regmap), "failed to init regmap\n");
>  
>  	priv->regmap = regmap;
> -	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_INIT);
> +	ret = hbg_hw_init(priv);
>  	if (ret)
>  		return ret;
>  
> -	return hbg_hw_dev_specs_init(priv);
> +	return hbg_mdio_init(priv);

I've not read the previous patches, but that looks odd. Why is code
you just added in previous patches getting replaced?

> +static int hbg_phy_connect(struct hbg_priv *priv)
> +{
> +	struct phy_device *phydev = priv->mac.phydev;
> +	struct device *dev = &priv->pdev->dev;
> +	struct hbg_mac *mac = &priv->mac;
> +	int ret;
> +
> +	ret = phy_connect_direct(priv->netdev, mac->phydev, hbg_phy_adjust_link,
> +				 PHY_INTERFACE_MODE_SGMII);
> +	if (ret)
> +		return dev_err_probe(dev, -ENOMEM, "failed to connect phy\n");

Don't replace the error code. Doing so actually makes dev_err_probe()
pointless because it is not going to see the EPROBE_DEFER.


> +int hbg_mdio_init(struct hbg_priv *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct hbg_mac *mac = &priv->mac;
> +	struct phy_device *phydev;
> +	struct mii_bus *mdio_bus;
> +	int ret;
> +
> +	mac->phy_addr = priv->dev_specs.phy_addr;
> +	mdio_bus = devm_mdiobus_alloc(dev);
> +	if (!mdio_bus)
> +		return dev_err_probe(dev, -ENOMEM, "failed to alloc MDIO bus\n");
> +
> +	mdio_bus->parent = dev;
> +	mdio_bus->priv = priv;
> +	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
> +	mdio_bus->name = "hibmcge mii bus";
> +	mac->mdio_bus = mdio_bus;
> +
> +	mdio_bus->read = hbg_mdio_read22;
> +	mdio_bus->write = hbg_mdio_write22;
> +	snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s-%s", "mii", dev_name(dev));
> +
> +	ret = devm_mdiobus_register(dev, mdio_bus);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register MDIO bus\n");
> +
> +	phydev = mdiobus_get_phy(mdio_bus, mac->phy_addr);
> +	if (!phydev)
> +		return dev_err_probe(dev, -EIO, "failed to get phy device\n");

ENODEV is probably better, since the device does not exist.

	Andrew

