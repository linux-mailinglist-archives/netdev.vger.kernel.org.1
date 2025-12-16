Return-Path: <netdev+bounces-244901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8156CC1439
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 08:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 637793030953
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 07:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4033D6CD;
	Tue, 16 Dec 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MBdOlMlm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804333E341;
	Tue, 16 Dec 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869437; cv=none; b=uIfne/2/4TPMNUNc8vpKAu69NkxGDH05t4lpy7B0+LUlkX076U9edyYRq+XOz1D9zBDLxHY7SjNx2jx3OjiHmccQwKdbAyWaZXazvhZbE/Xlxdbwv4URgBH2vypa558J8tCd/MpyvTnpqvfZASWO0RJEKa4Ikb/9PEz3mPxs4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869437; c=relaxed/simple;
	bh=c808WuGAyZI4zqBqYSbmcmiiiWQWPvV3qanVjGKgI0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBCeFithsgi78BuQu515gelcUSE4mdWCJdirHYOb3OXfwLAd/0MLIejmHa47rXtVbuNEzVN9z/cr+LLembntsKpAAZOI/l8X8ANaKNkx8wh+Qm4rt7LxH05hKBJ8YKqpxSPcqZ2914UMC/6N6Ry6Xi8PLCwDHjMm86B5p9eJWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MBdOlMlm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1FaSxGWl623nhf/igwzpOIlbpVSPc5Psdpdd1R5loRA=; b=MBdOlMlmAwMuWKwltBlu4ndwNI
	2Lxvi96++6NZ4onTkcj62GwZ21xfu0ssgpoSf6iWcUNtoThuM+w6B3B9MDi5BFJzmFFyVPXhnByiG
	l/kfcDa++wWWg6rTNhGKjFt/qEjaEzt1zyGSbx/LjDzU4zTBs7xJNY1Tmyb91kDHtkM0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVPIq-00H5Ph-64; Tue, 16 Dec 2025 08:17:00 +0100
Date: Tue, 16 Dec 2025 08:17:00 +0100
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
Message-ID: <543efb90-da56-4190-afa7-665d32303c8c@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215125705.1567527-4-shaojijie@huawei.com>

On Mon, Dec 15, 2025 at 08:57:02PM +0800, Jijie Shao wrote:
> Currently, phy_led supports of node, acpi node, and software node.
> The hibmcge hardware(including leds) is on the BMC side, while
> the driver runs on the host side.
> 
> An apic or of node needs to be created on the host side to
> support phy_led; otherwise, phy_led will not be supported.
> 
> Therefore, in order to support phy_led, this patch will create
> a software node when it detects that the phy device is not
> bound to any fwnode.
> 
> Closes: https://lore.kernel.org/all/023a85e4-87e2-4bd3-9727-69a2bfdc4145@lunn.ch/
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hibmcge/hbg_common.h   |  11 ++
>  .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 120 +++++++++++++++++-
>  2 files changed, 124 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
> index 8e134da3e217..d20dd324e129 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
> @@ -5,8 +5,10 @@
>  #define __HBG_COMMON_H
>  
>  #include <linux/ethtool.h>
> +#include <linux/fwnode.h>
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/property.h>
>  #include <net/page_pool/helpers.h>
>  #include "hbg_reg.h"
>  
> @@ -130,6 +132,9 @@ struct hbg_vector {
>  	u32 info_array_len;
>  };
>  
> +#define HBG_LED_MAX_NUM			(sizeof(u32) / sizeof(u8))
> +#define HBG_LED_SOFTWARE_NODE_MAX_NUM	(HBG_LED_MAX_NUM + 2)
> +
>  struct hbg_mac {
>  	struct mii_bus *mdio_bus;
>  	struct phy_device *phydev;
> @@ -140,6 +145,12 @@ struct hbg_mac {
>  	u32 autoneg;
>  	u32 link_status;
>  	u32 pause_autoneg;
> +
> +	struct software_node phy_node;
> +	struct software_node leds_node;
> +	struct software_node led_nodes[HBG_LED_MAX_NUM];
> +	struct property_entry leds_props[HBG_LED_MAX_NUM][4];
> +	const struct software_node *nodes[HBG_LED_SOFTWARE_NODE_MAX_NUM + 1];
>  };
>  
>  struct hbg_mac_table_entry {
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> index b6f0a2780ea8..edd8ccefbb62 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> @@ -263,11 +263,119 @@ static int hbg_fixed_phy_init(struct hbg_priv *priv)
>  	return hbg_phy_connect(priv);
>  }
>  
> -int hbg_mdio_init(struct hbg_priv *priv)
> +static void hbg_phy_device_free(void *data)
> +{
> +	phy_device_free((struct phy_device *)data);
> +}
> +
> +static void hbg_phy_device_remove(void *data)
> +{
> +	phy_device_remove((struct phy_device *)data);
> +}

Alarm bells are ringing! A MAC driver should not be doing anything
like this.

> +int hbg_mdio_init(struct hbg_priv *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct hbg_mac *mac = &priv->mac;
>  	struct mii_bus *mdio_bus;
>  	int ret;
>  
> @@ -281,7 +389,7 @@ int hbg_mdio_init(struct hbg_priv *priv)
>  
>  	mdio_bus->parent = dev;
>  	mdio_bus->priv = priv;
> -	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
> +	mdio_bus->phy_mask = 0xFFFFFFFF; /* not scan phy device */
>  	mdio_bus->name = "hibmcge mii bus";
>  	mac->mdio_bus = mdio_bus;

I think you are taking the wrong approach.

Please consider trying to use of_mdiobus_register(). Either load a DT
overlay, or see if you can construct a tree of properties as you have
been doing, and pass it to of_mdiobus_register(). You then don't need
to destroy and create PHY devices.

	Andrew

