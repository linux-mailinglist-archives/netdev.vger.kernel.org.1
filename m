Return-Path: <netdev+bounces-17396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0EE75170F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED1C1C21242
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481FD468C;
	Thu, 13 Jul 2023 04:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7464437
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:00:24 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A611FD7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HCCbc9dS3Rkl9GwfyawmEYlu85U025YSKjXy+dXGU4U=; b=zecyfIoWoTPG8HH87lSCM6SrOo
	xCwN+29/7tJ+JvYobmj86mTFFrmYjFH8XKABvuGXMH3oV2ROR4cVbFZwITMfJCfSNZs9X+j4u8x6k
	z4zF6H2gesYCwWvvv7KnCMkfScvi4GpS8V/3krl2pp0CVssjdMnAX437CvVjc/56ivYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJnUo-001CT0-Bs; Thu, 13 Jul 2023 06:00:02 +0200
Date: Thu, 13 Jul 2023 06:00:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
Message-ID: <9e0b3466-10e1-4267-ab9b-d9f8149b6b6b@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 10:46:53AM +0800, Feiyang Chen wrote:
> Add support for the Loongson PHY.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> ---
>  drivers/net/phy/Kconfig        |  5 +++
>  drivers/net/phy/Makefile       |  1 +
>  drivers/net/phy/loongson-phy.c | 69 ++++++++++++++++++++++++++++++++++

Please drop -phy from the filename. No other phy driver does this.

>  drivers/net/phy/phy_device.c   | 16 ++++++++
>  include/linux/phy.h            |  2 +
>  5 files changed, 93 insertions(+)
>  create mode 100644 drivers/net/phy/loongson-phy.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 93b8efc79227..4f8ea32cbc68 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -202,6 +202,11 @@ config INTEL_XWAY_PHY
>  	  PEF 7061, PEF 7071 and PEF 7072 or integrated into the Intel
>  	  SoCs xRX200, xRX300, xRX330, xRX350 and xRX550.
>  
> +config LOONGSON_PHY
> +	tristate "Loongson PHY driver"
> +	help
> +	  Supports the Loongson PHY.
> +
>  config LSI_ET1011C_PHY
>  	tristate "LSI ET1011C PHY"
>  	help
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index f289ab16a1da..f775373e12b7 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_DP83TD510_PHY)	+= dp83td510.o
>  obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
>  obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
>  obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
> +obj-$(CONFIG_LOONGSON_PHY)	+= loongson-phy.o
>  obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
>  obj-$(CONFIG_LXT_PHY)		+= lxt.o
>  obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
> diff --git a/drivers/net/phy/loongson-phy.c b/drivers/net/phy/loongson-phy.c
> new file mode 100644
> index 000000000000..d4aefa2110f8
> --- /dev/null
> +++ b/drivers/net/phy/loongson-phy.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LS7A PHY driver
> + *
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + *
> + * Author: Zhang Baoqi <zhangbaoqi@loongson.cn>
> + */
> +
> +#include <linux/mii.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +#include <linux/phy.h>
> +
> +#define PHY_ID_LS7A2000		0x00061ce0

What is Loongson OUI?

> +#define GNET_REV_LS7A2000	0x00
> +
> +static int ls7a2000_config_aneg(struct phy_device *phydev)
> +{
> +	if (phydev->speed == SPEED_1000)
> +		phydev->autoneg = AUTONEG_ENABLE;

Please explain.

> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +	    phydev->advertising) ||
> +	    linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +	    phydev->advertising) ||
> +	    linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +	    phydev->advertising))
> +	    return genphy_config_aneg(phydev);
> +
> +	netdev_info(phydev->attached_dev, "Parameter Setting Error\n");

This also needs explaining. How can it be asked to do something it
does not support?

> +	return -1;

Always use error codes. In this case EINVAL.

> +}
> +
> +int ls7a2000_match_phy_device(struct phy_device *phydev)
> +{
> +	struct net_device *ndev;
> +	struct pci_dev *pdev;
> +
> +	if ((phydev->phy_id & 0xfffffff0) != PHY_ID_LS7A2000)
> +		return 0;
> +
> +	ndev = phydev->mdio.bus->priv;
> +	pdev = to_pci_dev(ndev->dev.parent);
> +
> +	return pdev->revision == GNET_REV_LS7A2000;

That is very unusual. Why is the PHY ID not sufficient?

> +}
> +
> +static struct phy_driver loongson_phy_driver[] = {
> +	{
> +		PHY_ID_MATCH_MODEL(PHY_ID_LS7A2000),
> +		.name			= "LS7A2000 PHY",
> +		.features		= PHY_LOONGSON_FEATURES,

So what are the capabilities of this PHY? You seem to have some very
odd hacks here, and no explanation of why they are needed. If you do
something which no other device does, you need to explain it.

Does the PHY itself only support full duplex? No half duplex? Does the
PHY support autoneg? Does it support fixed settings? What does
genphy_read_abilities() return for this PHY?

	Andrew

