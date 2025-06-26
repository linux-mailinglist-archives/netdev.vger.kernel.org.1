Return-Path: <netdev+bounces-201556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3583BAE9E1C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA016A34E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCA42E5417;
	Thu, 26 Jun 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L50wm7zX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EA2E336E;
	Thu, 26 Jun 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942956; cv=none; b=bnptRUl/3esDsnxuNSe7GYr4uKi8bDeXLOcdoUfPX2m5PO2FdZVS9R2A1J9PundHRIpNfWpGwytYUHRGFuE/LCtcrHsaGwhYFGElJYdF958zXgNTMY5LXICfl4bwIsEtQYvefohwV+WGiwMfdkuEoYDQYdyMuZqcM+BAwW888DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942956; c=relaxed/simple;
	bh=jlmLk4NgCnLxwPz3TcSBRO0owp1iKVp62VJIE1enHnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfxhJzjCRN3LtWn6wc88ClLrJSrTs3pq3tyZk9WkIQit40Njc3DR+BsiN4r4Ln4Rn6khpfTzxV0Ei0Sgwwq1+ezsc4hCMr6HavwJrU4U5wsM9ajjkOO89zngZ6tn4etzIYBurcILRqOOuYCAfnrRGGEltIOcx9c5C1VQFL3F4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L50wm7zX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cVDiaBAprrueH4nbsn+vuEhFoeflTwQpyVt/8cXAMBI=; b=L50wm7zXljmfRKbZ95Yuv/YTsS
	QtdHJtaK6uLZf/BFV6sN8Lvll54CPnK5mh6IfUe+3SzbWihBi/5D5Y/nzA2/df0Yi1iHtMD1DYer0
	llkpyd3BILIH0/TDGw3q3hJulaB2HFpdcYpaWFwho9Ada+8ejgcvL9uO3JpChitS0IrAfqa2APXW2
	OUXeNU9W3lAOVtbQKNOwlksq51OXA+/nDLRcFj91M6eOtTHkXDt5bTpe8CbynUa0mNsjVHSjOnRY2
	wT+qCD7d+BH8Ynh/Sym/s+XWkw3yN0UzcuxNsc3GFf/0m/WYVuNNiDQ5wUgd10thnNAg6Cq1IJ/Mn
	tED7xW0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46316)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uUmFA-0008UZ-0e;
	Thu, 26 Jun 2025 14:02:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uUmF6-0006Wy-1e;
	Thu, 26 Jun 2025 14:02:16 +0100
Date: Thu, 26 Jun 2025 14:02:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	f.fainelli@gmail.com, robh@kernel.org, andrew+netdev@lunn.ch
Subject: Re: [PATCH 1/3] net: phy: MII-Lite PHY interface mode
Message-ID: <aF1E2G69T4IlkCl9@shell.armlinux.org.uk>
References: <20250626115619.3659443-1-kamilh@axis.com>
 <20250626115619.3659443-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626115619.3659443-2-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 26, 2025 at 01:56:17PM +0200, Kamil Horák - 2N wrote:
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index 9b1de54fd483..7d3b85a07b8c 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -423,6 +423,13 @@ static int bcm54811_config_init(struct phy_device *phydev)
>  	/* With BCM54811, BroadR-Reach implies no autoneg */
>  	if (priv->brr_mode)
>  		phydev->autoneg = 0;

Blank line here to aid readability please.

> +	/* Enable MII Lite (No TXER, RXER, CRS, COL) if configured */
> +	err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
> +				 BCM_EXP_SYNC_ETHERNET_MII_LITE,
> +				 phydev->interface == PHY_INTERFACE_MODE_MIILITE ?
> +				 BCM_EXP_SYNC_ETHERNET_MII_LITE : 0);

In cases like this, where the ternary op leads to less readable code,
it's better to do:

	if (phydev->interface == PHY_INTERFACE_MODE_MIILITE)
		exp_sync_ethernet = BCM_EXP_SYNC_ETHERNET_MII_LITE;
	else
		exp_sync_ethernet = 0;

	err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
				 BCM_EXP_SYNC_ETHERNET_MII_LITE,
				 exp_sync_ethernet);

> +	if (err < 0)
> +		return err;
>  
>  	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
>  }

I'd include this with the above change:

> diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
> index 028b3e00378e..15c35655f482 100644
> --- a/include/linux/brcmphy.h
> +++ b/include/linux/brcmphy.h
> @@ -182,6 +182,12 @@
>  #define BCM_LED_MULTICOLOR_ACT		0x9
>  #define BCM_LED_MULTICOLOR_PROGRAM	0xa
>  
> +/*
> + * Broadcom Synchronous Ethernet Controls (expansion register 0x0E)
> + */
> +#define BCM_EXP_SYNC_ETHERNET		(MII_BCM54XX_EXP_SEL_ER + 0x0E)
> +#define BCM_EXP_SYNC_ETHERNET_MII_LITE	BIT(11)
> +
>  /*
>   * BCM5482: Shadow registers
>   * Shadow values go into bits [14:10] of register 0x1c to select a shadow

... and send the changes below as a separate patch as these changes
below are modifying generic code.

> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> index e177037f9110..b2df06343b7e 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -115,6 +115,7 @@ int phy_interface_num_ports(phy_interface_t interface)
>  		return 0;
>  	case PHY_INTERFACE_MODE_INTERNAL:
>  	case PHY_INTERFACE_MODE_MII:
> +	case PHY_INTERFACE_MODE_MIILITE:
>  	case PHY_INTERFACE_MODE_GMII:
>  	case PHY_INTERFACE_MODE_TBI:
>  	case PHY_INTERFACE_MODE_REVMII:
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index 38417e288611..b4a4dea3e756 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -316,6 +316,10 @@ unsigned long phy_caps_from_interface(phy_interface_t interface)
>  		link_caps |= BIT(LINK_CAPA_100HD) | BIT(LINK_CAPA_100FD);
>  		break;
>  
> +	case PHY_INTERFACE_MODE_MIILITE:
> +		link_caps |= BIT(LINK_CAPA_10FD) | BIT(LINK_CAPA_100FD);
> +		break;
> +
>  	case PHY_INTERFACE_MODE_TBI:
>  	case PHY_INTERFACE_MODE_MOCA:
>  	case PHY_INTERFACE_MODE_RTBI:
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 0faa3d97e06b..766cad40f1b8 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -234,6 +234,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
>  	case PHY_INTERFACE_MODE_SMII:
>  	case PHY_INTERFACE_MODE_REVMII:
>  	case PHY_INTERFACE_MODE_MII:
> +	case PHY_INTERFACE_MODE_MIILITE:
>  		return SPEED_100;
>  
>  	case PHY_INTERFACE_MODE_TBI:
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index e194dad1623d..6aad4b741c01 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -103,6 +103,7 @@ extern const int phy_basic_ports_array[3];
>   * @PHY_INTERFACE_MODE_QUSGMII: Quad Universal SGMII
>   * @PHY_INTERFACE_MODE_1000BASEKX: 1000Base-KX - with Clause 73 AN
>   * @PHY_INTERFACE_MODE_10G_QXGMII: 10G-QXGMII - 4 ports over 10G USXGMII
> + * @PHY_INTERFACE_MODE_MIILITE: MII-Lite - MII without RXER TXER CRS COL
>   * @PHY_INTERFACE_MODE_MAX: Book keeping
>   *
>   * Describes the interface between the MAC and PHY.
> @@ -144,6 +145,7 @@ typedef enum {
>  	PHY_INTERFACE_MODE_QUSGMII,
>  	PHY_INTERFACE_MODE_1000BASEKX,
>  	PHY_INTERFACE_MODE_10G_QXGMII,
> +	PHY_INTERFACE_MODE_MIILITE,
>  	PHY_INTERFACE_MODE_MAX,
>  } phy_interface_t;
>  
> @@ -260,6 +262,8 @@ static inline const char *phy_modes(phy_interface_t interface)
>  		return "qusgmii";
>  	case PHY_INTERFACE_MODE_10G_QXGMII:
>  		return "10g-qxgmii";
> +	case PHY_INTERFACE_MODE_MIILITE:
> +		return "mii-lite";
>  	default:
>  		return "unknown";
>  	}

Otherwise, I think this is fine.

Please remember netdev's rules, which can be found in the tl;dr on:
https://www.kernel.org/doc/html/v6.1/process/maintainer-netdev.html

(There's probably an updated version, but I can never remember the URL.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

