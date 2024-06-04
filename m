Return-Path: <netdev+bounces-100594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6428FB44D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B1D282954
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637178F6A;
	Tue,  4 Jun 2024 13:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F268F45;
	Tue,  4 Jun 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509027; cv=none; b=FgqKR/0zu8rd+IzOyNGvc8WvEdLxOdH/R0ZxXulTthUlbBJesfksF/tdHD2yTFrxY/5O4pqSTSXtFloMTCsnh33qXFAH4nqqrpFuPcfgd//KO8zg3aq8us0U8k9SBgfsG+jNR2ECOx/F2Q2z7TCpkkg3wKnA40ybo/d4iseWyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509027; c=relaxed/simple;
	bh=QrESTg3xOlpbJQk9QQ3lCDr1YLfKPK3Pdpa0PJwR9hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7/F5L8q2GX0e3Q6AFKUg3u5MjT8p+5CQEQsXcvuiFDlVt+vtAGdDG46UGHyLOekOFDrbdF4bJuU5qnr3pGaJv91KP65BMRy2CxJYrdwh/buhnLje0G7AyawJ14ZkROWFA/Uq/G4RLQ8msAXiN4nkMJOKhCJFEnLlUoA2xoN3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sEUYF-000000007pM-3kyt;
	Tue, 04 Jun 2024 13:50:12 +0000
Date: Tue, 4 Jun 2024 14:50:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <Zl8bjNzdB7g1fRyn@makrotopia.org>
References: <20240603121834.27433-1-SkyLake.Huang@mediatek.com>
 <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
 <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk>
 <Zl3Fwoiv1bJlGaQZ@makrotopia.org>
 <Zl3IGN5ZHCQfQfmt@shell.armlinux.org.uk>
 <Zl3Yo3dwQlXEfP3i@makrotopia.org>
 <Zl3lkIDqnt4JD//u@shell.armlinux.org.uk>
 <Zl32waW34yTiuF9u@makrotopia.org>
 <Zl4LvKlhty/9o38y@shell.armlinux.org.uk>
 <864a09b213169bc20f33af2f35239c6154ca81e3.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <864a09b213169bc20f33af2f35239c6154ca81e3.camel@mediatek.com>

On Tue, Jun 04, 2024 at 08:42:57AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Mon, 2024-06-03 at 19:30 +0100, Russell King (Oracle) wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Mon, Jun 03, 2024 at 06:00:49PM +0100, Daniel Golle wrote:
> > > On Mon, Jun 03, 2024 at 04:47:28PM +0100, Russell King (Oracle)
> > wrote:
> > > > On Mon, Jun 03, 2024 at 03:52:19PM +0100, Daniel Golle wrote:
> > > > > On Mon, Jun 03, 2024 at 02:41:44PM +0100, Russell King (Oracle)
> > wrote:
> > > > > > On Mon, Jun 03, 2024 at 02:31:46PM +0100, Daniel Golle wrote:
> > > > > > > On Mon, Jun 03, 2024 at 02:25:01PM +0100, Russell King
> > (Oracle) wrote:
> > > > > > > > On Mon, Jun 03, 2024 at 08:18:34PM +0800, Sky Huang
> > wrote:
> > > > > > > > > Add support for internal 2.5Gphy on MT7988. This driver
> > will load
> > > > > > > > > necessary firmware, add appropriate time delay and
> > figure out LED.
> > > > > > > > > Also, certain control registers will be set to fix
> > link-up issues.
> > > > > > > > 
> > > > > > > > Based on our previous discussion, it may be worth
> > checking in the
> > > > > > > > .config_init() method whether phydev->interface is one of
> > the
> > > > > > > > PHY interface modes that this PHY supports. As I
> > understand from one
> > > > > > > > of your previous emails, the possibilities are XGMII,
> > USXGMII or
> > > > > > > > INTERNAL. Thus:
> > > > > > > > 
> > > > > > > > > +static int mt798x_2p5ge_phy_config_init(struct
> > phy_device *phydev)
> > > > > > > > > +{
> > > > > > > > > +struct pinctrl *pinctrl;
> > > > > > > > > +int ret;
> > > > > > > > 
> > > > > > > > /* Check that the PHY interface type is compatible */
> > > > > > > > if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL &&
> > > > > > > >     phydev->interface != PHY_INTERFACE_MODE_XGMII &&
> > > > > > > >     phydev->interface != PHY_INTERFACE_MODE_USXGMII)
> > > > > > > > return -ENODEV;
> > > > > > > 
> > > > > > > The PHY is built-into the SoC, and as such the connection
> > type should
> > > > > > > always be "internal". The PHY does not exist as dedicated
> > IC, only
> > > > > > > as built-in part of the MT7988 SoC.
> > > > > > 
> > > > > > That's not how it was described to me by Sky.
> > > > > > 
> > > > > > If what you say is correct, then the implementation of
> > > > > > mt798x_2p5ge_phy_get_rate_matching() which checks for
> > interface modes
> > > > > > other than INTERNAL is not correct. Also it means that
> > config_init()
> > > > > > should not permit anything but INTERNAL.
> > > > > 
> > > > > The way the PHY is connected to the MAC *inside the chip* is
> > XGMII
> > > > > according the MediaTek. So call it "internal" or "xgmii",
> > however, up to
> > > > > my knowledge it's a fact that there is **only one way** this
> > PHY is
> > > > > connected and used, and that is being an internal part of the
> > MT7988 SoC.
> > > > > 
> > > > > Imho, as there are no actual XGMII signals exposed anywhere I'd
> > use
> > > > > "internal" to describe the link between MAC and PHY (which are
> > both
> > > > > inside the same chip package).
> > > > 
> > > > I don't care what gets decided about what's acceptable for the
> > PHY to
> > > > accept, just that it checks for the acceptable modes in
> > .config_init()
> > > > and the .get_rate_matching() method is not checking for interface
> > > > modes that are not permitted.
> > > 
> > > What I meant to express is that there is no need for such a check,
> > also
> > > not in config_init. There is only one way and one MAC-side
> > interface mode
> > > to operate that PHY, so the value will anyway not be considered
> > anywhere
> > > in the driver.
> > 
> > No, it matters. With drivers using phylink, the PHY interface mode is
> > used in certain circumstances to constrain what the net device can
> > do.
> > So, it makes sense for new PHY drivers to ensure that the PHY
> > interface
> > mode is one that they can support, rather than just accepting
> > whatever
> > is passed to them (which then can lead to maintainability issues for
> > subsystems.)
> > 
> > So, excuse me for disagreeing with you, but I do want to see such a
> > check in new PHY drivers.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> Hi Russell/Daniel,
>   IMO, we can check PHY_INTERFACE_MODE_INTERNAL &
> PHY_INTERFACE_MODE_XGMII in config_init() or probe(). However,
> PHY_INTERFACE_MODE_USXGMII isn't supported by this phy, and
> drivers/net/ethernet/mediatek/mtk_eth_path.c uses
> PHY_INTERFACE_MODE_USXGMII to switch netsys pcs mux (set
> MUX_G2_USXGMII_SEL bit in TOP_MISC_NETSYS_PCS_MUX) so that XFI-MAC can
> be connected to external 10Gphy.
>   So, basically, for 1st XFI-MAC on mt7988:
> - PHY_INTERFACE_MODE_XGMII/PHY_INTERFACE_MODE_INTERNAL: built-in
> 2.5Gphy

Why both? Wouldn't just PHY_INTERFACE_MODE_INTERNAL be more clear?
There is no XGMII interface exposed anywhere and both "internal" and
"xgmii" would be used to express the exact same thing.

> - PHY_INTERFACE_MODE_USXGMII: external 10Gphy
> 
>   I add check in config_init():
> /* Check if PHY interface type is compatible */
> if (phydev->interface != PHY_INTERFACE_MODE_XGMII &&
>     phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
> 	return -ENODEV;
> 
>   Also, test with different phy mode in dts:
> [PHY_INTERFACE_MODE_USXGMII]
> [   18.702102] mtk_soc_eth 15100000.ethernet eth1: mtk_open: could not
> attach PHY: -19
> root@OpenWrt:/# cat /proc/device-tree/soc/ethernet@15100000/mac@1/phy-c
> onnection-type
> usxgmii
> 
> [PHY_INTERFACE_MODE_INTERNAL]
> [   18.329513] mtk_soc_eth 15100000.ethernet eth1: PHY [mdio-bus:0f]
> driver [MediaTek MT7988 2.5GbE PHY] (irq=POLL)
> [   18.339708] mtk_soc_eth 15100000.ethernet eth1: configuring for
> phy/internal link mode
> root@OpenWrt:/# cat /proc/device-tree/soc/ethernet@15100000
> /mac@1/phy-connection-type
> internal
> 
> Sky

