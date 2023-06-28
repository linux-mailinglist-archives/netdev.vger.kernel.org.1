Return-Path: <netdev+bounces-14430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533E7412C6
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603F61C20621
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF231C14A;
	Wed, 28 Jun 2023 13:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A3C148
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 13:43:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDFA198E;
	Wed, 28 Jun 2023 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1wmmspi530xOoe8Q2zeo6bhbHaaSxwUw61R++tDFKPw=; b=oopEw3VJIyih2qocq3vY8C/2YT
	pOPePbf6Nrt+hrjXNJydNkzprEvq732RObAYk4w0kPbTYnTzapgxI2QAsNpp+zE2EdqMihwd22At3
	yoPX/p9pax0i1RY4YzOp7EzHJb35WlY0ZSRkBSaOkXjogTOeQCuIsSeWJ0hqgTL+qj+Ammn/i17dz
	CnFUd1dnRyFgJpkbQQweUsqgAE47spf7+7sOY6VrepnCJjt7xIRwTHcbBcz/8dpojNWBten3o4lue
	aYDCRX5qT/e5gZ5Wfx6ifRVm59t4ZJe0XvPAkBurwT+iN0ObLWA8AhsVnKdAXjcVvVgXQPc4srQlT
	DqNw4/Zg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58088)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qEVRy-0007YY-0i;
	Wed, 28 Jun 2023 14:43:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qEVRx-0006oj-8w; Wed, 28 Jun 2023 14:43:13 +0100
Date: Wed, 28 Jun 2023 14:43:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Revanth Kumar Uppala <ruppala@nvidia.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-tegra@vger.kernel.org, Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Message-ID: <ZJw48a4eH0em8kjW@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-4-ruppala@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124326.55732-4-ruppala@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 06:13:26PM +0530, Revanth Kumar Uppala wrote:
> @@ -109,6 +134,10 @@
>  #define VEND1_GLOBAL_CFG_10M			0x0310
>  #define VEND1_GLOBAL_CFG_100M			0x031b
>  #define VEND1_GLOBAL_CFG_1G			0x031c
> +#define VEND1_GLOBAL_SYS_CONFIG_SGMII   (BIT(0) | BIT(1))
> +#define VEND1_GLOBAL_SYS_CONFIG_AN      BIT(3)
> +#define VEND1_GLOBAL_SYS_CONFIG_XFI     BIT(8)

My understanding is that bits 2:0 are a _bitfield_ and not individual
bits, which contain the following values:

0 - 10GBASE-R (XFI if you really want to call it that)
3 - SGMII
4 - OCSGMII (2.5G)
6 - 5GBASE-R (XFI5G if you really want to call it that)

Bit 3 controls whether the SGMII control word is used, and this is the
only applicable mode.

Bit 8 is already defined - it's part of the rate adaption mode field,
see VEND1_GLOBAL_CFG_RATE_ADAPT and VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE.

These bits apply to all the VEND1_GLOBAL_CFG_* registers, so these
should be defined after the last register (0x031f).

> +static int aqr113c_wol_enable(struct phy_device *phydev)
> +{
> +	struct aqr107_priv *priv = phydev->priv;
> +	u16 val;
> +	int ret;
> +
> +	/* Disables all advertised speeds except for the WoL
> +	 * speed (100BASE-TX FD or 1000BASE-T)
> +	 * This is set as per the APP note from Marvel
> +	 */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +			       MDIO_AN_LD_LOOP_TIMING_ABILITY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (ret & MDIO_AN_VEND_MASK) |
> +	      (MDIO_AN_VEND_PROV_AQRATE_DWN_SHFT_CAP | MDIO_AN_VEND_PROV_1000BASET_FULL);
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable the magic frame and wake up frame detection for the PHY */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_RSI1_CTRL6,
> +			       MDIO_C22EXT_RSI_WAKE_UP_FRAME_DETECTION);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_RSI1_CTRL7,
> +			       MDIO_C22EXT_RSI_MAGIC_PKT_FRAME_DETECTION);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set the WoL enable bit */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RSVD_VEND_PROV1,
> +			       MDIO_MMD_AN_WOL_ENABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set the WoL INT_N trigger bit */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_RSI1_CTRL8,
> +			       MDIO_C22EXT_RSI_WOL_FCS_MONITOR_MODE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable Interrupt INT_N Generation at pin level */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_SGMII_TX_INT_MASK1,
> +			       MDIO_C22EXT_SGMII0_WAKE_UP_FRAME_MASK |
> +			       MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_INT_STD_MASK,
> +			       VEND1_GLOBAL_INT_STD_MASK_ALL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_INT_VEND_MASK,
> +			       VEND1_GLOBAL_INT_VEND_MASK_GBE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set the system interface to SGMII */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +			    VEND1_GLOBAL_CFG_100M, VEND1_GLOBAL_SYS_CONFIG_SGMII |
> +			    VEND1_GLOBAL_SYS_CONFIG_AN);

How do you know that SGMII should be used for 100M?

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +			    VEND1_GLOBAL_CFG_1G, VEND1_GLOBAL_SYS_CONFIG_SGMII |
> +			    VEND1_GLOBAL_SYS_CONFIG_AN);

How do you know that SGMII should be used for 1G?

Doesn't this depend on the configuration of the host MAC and the
capabilities of it? If the host MAC only supports 10G, doesn't this
break stuff?

> +	if (ret < 0)
> +		return ret;
> +
> +	/* restart auto-negotiation */
> +	genphy_c45_restart_aneg(phydev);
> +	priv->wol_status = 1;
> +
> +	return 0;
> +}
> +
> +static int aqr113c_wol_disable(struct phy_device *phydev)
> +{
> +	struct aqr107_priv *priv = phydev->priv;
> +	int ret;
> +
> +	/* Disable the WoL enable bit */
> +	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RSVD_VEND_PROV1,
> +				 MDIO_MMD_AN_WOL_ENABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Restore the SERDES/System Interface back to the XFI mode */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +			    VEND1_GLOBAL_CFG_100M, VEND1_GLOBAL_SYS_CONFIG_XFI);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +			    VEND1_GLOBAL_CFG_1G, VEND1_GLOBAL_SYS_CONFIG_XFI);
> +	if (ret < 0)
> +		return ret;

Conversely, how do you know that configuring 100M/1G to use 10GBASE-R on
the host interface is how the PHY was provisioned in firmware? I think
at the very least, you should be leaving these settings alone until you
know that the system is entering a low power mode, saving the settings,
and restoring them when you wake up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

