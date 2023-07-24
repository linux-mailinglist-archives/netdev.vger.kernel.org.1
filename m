Return-Path: <netdev+bounces-20408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7040F75F569
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF72281207
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC9612A;
	Mon, 24 Jul 2023 11:47:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21BEC2
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:47:25 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB77EE61;
	Mon, 24 Jul 2023 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qt65iVIysC/IYhlufKXMzTRfFYaF4aQEGwEXCapI7ik=; b=JbDQLqfjBSwW/9ggul3F1GqbCB
	xNAgJQxJCwI3fwzwiQ2ce97DiGqTCjLOHj1nkKzZ7EA8CrqpOU8/AEmCMB/Rnob5+NY8B0SKIFufj
	fVrugwMS620YEFuAgb8rDryTITDjJC8X5sjp4qfSU2qCPsdj6e2hRLaHPUyYLH+eYdM1DB5JhRoWL
	V4o6JzaCBG6BEVzLSVUI5qBHEIaOyyHTnZUzqYujkdmr5ccAiXDAPCROxXqGuz/eVzMMeE4rEqTI7
	uMU6P6XWK9wP/AKAlbGNco4JRKwNe3pNgI8k/wjFQMCFjUH5cyUSHjG/N4LIw7Zlqphi+xi/dv0uI
	eaDbpSCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57574)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qNu22-0008Pt-2Y;
	Mon, 24 Jul 2023 12:47:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qNu22-0000lp-Fd; Mon, 24 Jul 2023 12:47:18 +0100
Date: Mon, 24 Jul 2023 12:47:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Revanth Kumar Uppala <ruppala@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame support
 in aquantia PHY
Message-ID: <ZL5kxvUOJb6xHiPR@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <ZJw2CKtgqbRU/3Z6@shell.armlinux.org.uk>
 <ce4c10b5-c2cf-489d-b096-19b5bcd8c49e@lunn.ch>
 <BL3PR12MB6450050A7423D4ADF4E4CFE9C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6450050A7423D4ADF4E4CFE9C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 11:29:18AM +0000, Revanth Kumar Uppala wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Wednesday, June 28, 2023 7:17 PM
> > To: Russell King (Oracle) <linux@armlinux.org.uk>
> > Cc: Revanth Kumar Uppala <ruppala@nvidia.com>; hkallweit1@gmail.com;
> > netdev@vger.kernel.org; linux-tegra@vger.kernel.org; Narayan Reddy
> > <narayanr@nvidia.com>
> > Subject: Re: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame support
> > in aquantia PHY
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jun 28, 2023 at 02:30:48PM +0100, Russell King (Oracle) wrote:
> > > On Wed, Jun 28, 2023 at 06:13:23PM +0530, Revanth Kumar Uppala wrote:
> > > > From: Narayan Reddy <narayanr@nvidia.com>
> > > >
> > > > Enable flow control support using pause frames in aquantia phy driver.
> > > >
> > > > Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
> > > > Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
> > >
> > > I think this is over-complex.
> > >
> > > >  #define MDIO_PHYXS_VEND_IF_STATUS          0xe812
> > > >  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK        GENMASK(7, 3)
> > > >  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR  0 @@ -583,6 +585,17
> > @@
> > > > static int aqr107_config_init(struct phy_device *phydev)
> > > >     if (!ret)
> > > >             aqr107_chip_info(phydev);
> > > >
> > > > +   /* Advertize flow control */
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev-
> > >supported);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev-
> > >supported);
> > > > +   linkmode_copy(phydev->advertising, phydev->supported);
> > >
> > > This is the wrong place to be doing this, since pause support depends
> > > not only on the PHY but also on the MAC. There are phylib interfaces
> > > that MACs should call so that phylib knows that the MAC supports pause
> > > frames.
> > >
> > > Secondly, the PHY driver needs to tell phylib that the PHY supports
> > > pause frames, and that's done through either setting the .features
> > > member in the PHY driver, or by providing a .get_features
> > > implementation.
> > >
> > > Configuration of the pause advertisement should already be happening
> > > through the core phylib code.
> > 
> > I really should do a LPC netdev talk "Everybody gets pause wrong..."
> > 
> > genphy_c45_an_config_aneg() will configure pause advertisement. The PHY
> > driver does not need to configure it, if the PHY follows the standard and has the
> > configuration in the correct place. As Russell said, please check the PHYs ability
> > to advertise pause is being reported correctly, by .get_features, of the default
> > implementation of .get_features if that is being used. And then check your MAC
> > driver is also indicating it supports pause.
> From .get_features, it is not possible to check PHY's ability to advertise pause is being reported as there is no such register present for AQR PHY to check capabilities in its datasheet.
> Hence, we are directly configuring the pause frames from  aqr107_config_init().

... and thus creating a trashy implementation... so NAK.

The first thing to get straight is that in "normal" non-rate adapting
setups, pause frames are no different from normal Ethernet frames as
far as a PHY is concerned. The PHY should be doing absolutely nothing
special with pause frames - it should merely forward them to the MAC,
and it's the MAC that deals with pause frames.

The only thing that a non-rate adapting baseT PHY has to deal with is
the media advertisement and nothing else.

So, whether pause frames are supported has more to do with the MAC
than the PHY.

The way phylib works is that when a PHY is probed, phy_probe() will
set the Pause and Asym_Pause bits in the ->supported bitmap. It is
then up to the MAC driver (or phylink) to call phy_support_asym_pause()
or phy_support_sym_pause() to tell phylib what the MAC supports.

PHY drivers must *not* override this in their config_init() function,
and most certainly must not copy the supported bitmap to the advertising
bitmap there either.

If you need pause-mode rate adaption, this has nothing to do with the
media side, and ->supported and ->advertising are not relevant for
that. Non-phylink based MAC drivers have to use phy_get_rate_matching()
to find out whether the PHY will be using rate adaption and act
accordingly. phylink based MAC drivers have this dealt with for them
and as long as they do what phylink tells them to do, everything
should be fine.

So, basically, do not mess with setting bits in the ->supported bitmap
nor the ->advertising bitmap in config_init. It is wrong, and we will
NAK it.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

