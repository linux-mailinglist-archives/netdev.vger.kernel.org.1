Return-Path: <netdev+bounces-247732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 169D1CFDD99
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 191EB3010294
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C631AA95;
	Wed,  7 Jan 2026 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lykwJu0v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1831985D;
	Wed,  7 Jan 2026 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791073; cv=none; b=mICZlX6894rn5M9axVNEP+5zk66W7zGdvAbR399oB5u7RDdnllwuKIrdNNiO7lMwWJhScYNULPNxlffEOpZ+iidpyrg8nAh69ixRsLwyzTRb0I6XrokGTO9HTIYqxv7DXAmLiCwY9syiPMnD4UVZ1RmBvoN8NkiqwBA/LAoJIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791073; c=relaxed/simple;
	bh=peGwaqXfHNkN0+FbN07K4rXSLf2iSDcLFcxx/j4KLsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSLZZ2biRJDFct28waeMyKQJgIHdqEOAyIcACmkbXtGSmhAQeI31h45nn3Zk9aDO/DSxCAwQQKikZnjNLvQp1jNeQov0gjuyYEa4hKIkmv+LVuVD5QeNAVOEp3aXuiYdh60Z1Bvgz/SftJHukfGp0BrlZjTjeIG3vBgbNa2mqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lykwJu0v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ram/biDe3G1l5MdFNfqzl8rK3FkNylw8l1WJTYBhI3c=; b=lykwJu0vN0ZLkPDoK8yPZg88cC
	FVO/PizvLD4xApSmusU10wDFw35uxGHuOQaWHYdVVk/idTZDadnCaozbzy97tvSYw7a4q1l29gz2C
	y1/XVQeX/I2sjQlPi/Ko8BY5be71nhzpMRq1gyDLx/Fy/ghZjkrp6uEqKokZPq5fLkYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdTCm-001nkD-Co; Wed, 07 Jan 2026 14:04:04 +0100
Date: Wed, 7 Jan 2026 14:04:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/6] net: hibmcge: create a software node
 for phy_led
Message-ID: <eaf25bd7-4211-45ca-a747-5039d69bd57c@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-4-shaojijie@huawei.com>
 <543efb90-da56-4190-afa7-665d32303c8c@lunn.ch>
 <fd6f70bc-b563-4eff-97c3-1b7ad79ca093@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd6f70bc-b563-4eff-97c3-1b7ad79ca093@huawei.com>

On Wed, Jan 07, 2026 at 06:09:28PM +0800, Jijie Shao wrote:
> 
> on 2025/12/16 15:17, Andrew Lunn wrote:
> > On Mon, Dec 15, 2025 at 08:57:02PM +0800, Jijie Shao wrote:
> > 
> > > +int hbg_mdio_init(struct hbg_priv *priv)
> > > +{
> > > +	struct device *dev = &priv->pdev->dev;
> > > +	struct hbg_mac *mac = &priv->mac;
> > >   	struct mii_bus *mdio_bus;
> > >   	int ret;
> > > @@ -281,7 +389,7 @@ int hbg_mdio_init(struct hbg_priv *priv)
> > >   	mdio_bus->parent = dev;
> > >   	mdio_bus->priv = priv;
> > > -	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
> > > +	mdio_bus->phy_mask = 0xFFFFFFFF; /* not scan phy device */
> > >   	mdio_bus->name = "hibmcge mii bus";
> > >   	mac->mdio_bus = mdio_bus;
> > I think you are taking the wrong approach.
> > 
> > Please consider trying to use of_mdiobus_register(). Either load a DT
> > overlay, or see if you can construct a tree of properties as you have
> > been doing, and pass it to of_mdiobus_register(). You then don't need
> > to destroy and create PHY devices.
> 
> This is not easy.
> `of_mdiobus_register()` requires a device_node, but I currently don't have one.
> It is precisely because there is no DT or ACPI node that I am using a software node as a substitute.

Which is why i suggested DT overlay.

drivers/misc/lan966x_pci.dtso

	Andrew

