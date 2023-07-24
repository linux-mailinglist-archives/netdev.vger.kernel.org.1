Return-Path: <netdev+bounces-20420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7EE75F65A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 14:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78EE1C20B1A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5CD79FE;
	Mon, 24 Jul 2023 12:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9C7498
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 12:29:30 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550AFE73;
	Mon, 24 Jul 2023 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AHqDFUOrJ20UvzLrK9n3xHMPBmD1RBvHYTAfsudz+sM=; b=sncFEc5TAZYLg+bmxmXrDe8SWg
	Ik/Xzn6NhOKwbsHW+AwNvEpZuzSgIW0fYJYlSd3UZS7jcQH+780v9Bik3sQ6CyyLopHncv/iJlXDj
	oswvlDXQoMoVNp6iXByWWrnA1QcS83VOfxCznWe/knzr5JkvaQAIYcgtPCXVp/t6SjvDF46D/wGUU
	Y14U8WPXL+EX+GLYL8ZaNEUEd5tDMErLrIw/azTOzlje2YphQ5AD4/oN3mBvdi1CH+V6DAwWUDWNO
	8OccGlQT6Z5a7R4PtBRmQbw+s/ktShT7rcnKY/tgNW2KOf2g2gBxrOPL1yaWEuCmI3NrgPQ/lJjo4
	U42bF2MA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49146)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qNuga-0008Ue-3A;
	Mon, 24 Jul 2023 13:29:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qNuga-0000nc-Hx; Mon, 24 Jul 2023 13:29:12 +0100
Date: Mon, 24 Jul 2023 13:29:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Revanth Kumar Uppala <ruppala@nvidia.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Message-ID: <ZL5umEYxNHWxhrXm@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-4-ruppala@nvidia.com>
 <ZJw48a4eH0em8kjW@shell.armlinux.org.uk>
 <BL3PR12MB64507235FB47CDF03C4C5669C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB64507235FB47CDF03C4C5669C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 11:29:39AM +0000, Revanth Kumar Uppala wrote:
> 
> 
> > -----Original Message-----
> > From: Russell King <linux@armlinux.org.uk>
> > Sent: Wednesday, June 28, 2023 7:13 PM
> > To: Revanth Kumar Uppala <ruppala@nvidia.com>
> > Cc: andrew@lunn.ch; hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> > tegra@vger.kernel.org; Narayan Reddy <narayanr@nvidia.com>
> > Subject: Re: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jun 28, 2023 at 06:13:26PM +0530, Revanth Kumar Uppala wrote:
> > > @@ -109,6 +134,10 @@
> > >  #define VEND1_GLOBAL_CFG_10M                 0x0310
> > >  #define VEND1_GLOBAL_CFG_100M                        0x031b
> > >  #define VEND1_GLOBAL_CFG_1G                  0x031c
> > > +#define VEND1_GLOBAL_SYS_CONFIG_SGMII   (BIT(0) | BIT(1))
> > > +#define VEND1_GLOBAL_SYS_CONFIG_AN      BIT(3)
> > > +#define VEND1_GLOBAL_SYS_CONFIG_XFI     BIT(8)
> > 
> > My understanding is that bits 2:0 are a _bitfield_ and not individual bits, which
> > contain the following values:
> I will define bitfield instead of defining individual bits in V2 series
> > 
> > 0 - 10GBASE-R (XFI if you really want to call it that)
> > 3 - SGMII
> > 4 - OCSGMII (2.5G)
> > 6 - 5GBASE-R (XFI5G if you really want to call it that)
> > 
> > Bit 3 controls whether the SGMII control word is used, and this is the only
> > applicable mode.
> > 
> > Bit 8 is already defined - it's part of the rate adaption mode field, see
> > VEND1_GLOBAL_CFG_RATE_ADAPT and
> > VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE.
> Sure, I will use above mentioned macros and will set the register values with help of FIELD_PREP in V2 series
> > 
> > These bits apply to all the VEND1_GLOBAL_CFG_* registers, so these should be
> > defined after the last register (0x031f).
> Will take care of this.
> > 
> > > +static int aqr113c_wol_enable(struct phy_device *phydev) {
> > > +     struct aqr107_priv *priv = phydev->priv;
> > > +     u16 val;
> > > +     int ret;
> > > +
> > > +     /* Disables all advertised speeds except for the WoL
> > > +      * speed (100BASE-TX FD or 1000BASE-T)
> > > +      * This is set as per the APP note from Marvel
> > > +      */
> > > +     ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
> > MDIO_AN_10GBT_CTRL,
> > > +                            MDIO_AN_LD_LOOP_TIMING_ABILITY);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     val = (ret & MDIO_AN_VEND_MASK) |
> > > +           (MDIO_AN_VEND_PROV_AQRATE_DWN_SHFT_CAP |
> > MDIO_AN_VEND_PROV_1000BASET_FULL);
> > > +     ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV,
> > val);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* Enable the magic frame and wake up frame detection for the PHY */
> > > +     ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT,
> > MDIO_C22EXT_GBE_PHY_RSI1_CTRL6,
> > > +                            MDIO_C22EXT_RSI_WAKE_UP_FRAME_DETECTION);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT,
> > MDIO_C22EXT_GBE_PHY_RSI1_CTRL7,
> > > +                            MDIO_C22EXT_RSI_MAGIC_PKT_FRAME_DETECTION);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* Set the WoL enable bit */
> > > +     ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
> > MDIO_AN_RSVD_VEND_PROV1,
> > > +                            MDIO_MMD_AN_WOL_ENABLE);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* Set the WoL INT_N trigger bit */
> > > +     ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT,
> > MDIO_C22EXT_GBE_PHY_RSI1_CTRL8,
> > > +                            MDIO_C22EXT_RSI_WOL_FCS_MONITOR_MODE);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* Enable Interrupt INT_N Generation at pin level */
> > > +     ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT,
> > MDIO_C22EXT_GBE_PHY_SGMII_TX_INT_MASK1,
> > > +                            MDIO_C22EXT_SGMII0_WAKE_UP_FRAME_MASK |
> > > +                            MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
> > VEND1_GLOBAL_INT_STD_MASK,
> > > +                            VEND1_GLOBAL_INT_STD_MASK_ALL);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
> > VEND1_GLOBAL_INT_VEND_MASK,
> > > +                            VEND1_GLOBAL_INT_VEND_MASK_GBE);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* Set the system interface to SGMII */
> > > +     ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > +                         VEND1_GLOBAL_CFG_100M,
> > VEND1_GLOBAL_SYS_CONFIG_SGMII |
> > > +                         VEND1_GLOBAL_SYS_CONFIG_AN);
> > 
> > How do you know that SGMII should be used for 100M?
> > 
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > +                         VEND1_GLOBAL_CFG_1G,
> > VEND1_GLOBAL_SYS_CONFIG_SGMII |
> > > +                         VEND1_GLOBAL_SYS_CONFIG_AN);
> > 
> > How do you know that SGMII should be used for 1G?
> > 
> > Doesn't this depend on the configuration of the host MAC and the capabilities of
> > it? If the host MAC only supports 10G, doesn't this break stuff?
> > 
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* restart auto-negotiation */
> > > +     genphy_c45_restart_aneg(phydev);
> > > +     priv->wol_status = 1;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int aqr113c_wol_disable(struct phy_device *phydev) {
> > > +     struct aqr107_priv *priv = phydev->priv;
> > > +     int ret;
> > > +
> > > +     /* Disable the WoL enable bit */
> > > +     ret = phy_clear_bits_mmd(phydev, MDIO_MMD_AN,
> > MDIO_AN_RSVD_VEND_PROV1,
> > > +                              MDIO_MMD_AN_WOL_ENABLE);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /* Restore the SERDES/System Interface back to the XFI mode */
> > > +     ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > +                         VEND1_GLOBAL_CFG_100M,
> > VEND1_GLOBAL_SYS_CONFIG_XFI);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > +                         VEND1_GLOBAL_CFG_1G, VEND1_GLOBAL_SYS_CONFIG_XFI);
> > > +     if (ret < 0)
> > > +             return ret;
> > 
> > Conversely, how do you know that configuring 100M/1G to use 10GBASE-R on
> > the host interface is how the PHY was provisioned in firmware? I think at the
> > very least, you should be leaving these settings alone until you know that the
> > system is entering a low power mode, saving the settings, and restoring them
> > when you wake up.
> 
> Regarding all the above comments ,
> We are following the app note AN-N4209 by Marvell semiconductors for enabling and disabling of WOL.
> Below are the steps in brief as mentioned in app note

So basically what I gather is that the answer to "how do you know that
configuring 100M/1G to use 10GBASE-R the host interface is how the PHY
was provisioned in firmware?" is that you don't know, and you're just
blindly following what someone's thrown into an application note but
haven't thought enough about it.

> For remote WAKEUP via magic packet,
> 1.MAC detects INT from PHY and confirm Wake request.
> 2. Disable the WoL mode by unsetting the WoL enable bit.
> 3. Restore the SERDES/System Interface back to the original mode before WoL was initialized using SGMII mode i.e; back to XFI mode.
> MDIO write 1e.31b = 0x100 (Reverts the 100M setup to original mode)
> MDIO write 1e.31c = 0x100 (Reverts the 1G setup to original mode

I think you have misunderstood step 3. "Restore ... back to the
original mode" when interpreting the application note.

Since these registers are set during the provisioning on the PHY,
there is *no* guarantee that they were originally in XFI mode before
WoL was enabled. Hence, in order to "restore" their state, you need
to "save" their state at some point, and it would probably be a good
idea to do that when:

1) the PHY is probed to get the power-up status.
2) update the saved registers whenever the driver reconfigures the PHY
   for a different interface mode (I don't think it does this.)
3) use this saved information to restore these registers when WoL is
   disabled, _or_ when the PHY device is detached from the PHY driver
   i.o.w. when the ->remove method is called, so that if the driver
   re-probes, it can get at the _original_ information.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

