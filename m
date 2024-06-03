Return-Path: <netdev+bounces-100305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F38D878B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69E61F2227C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C4130E44;
	Mon,  3 Jun 2024 17:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A72562E;
	Mon,  3 Jun 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434072; cv=none; b=M41V+dtogt4HbYLG1dQzm+ed4i/Y/YmxGWzla1zdwTgq3OHwGRiQ5EA/zowjwdmdUbxLnoJIWwYFuz8ibiwn3aM2rtOY9GzPJ4NGIZaBHZ3oH5/wIjLSVPoSHzINDj2D1Q049ftr+sj474gIVTTu+8/S0hSUUM1mjkdOGGrFEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434072; c=relaxed/simple;
	bh=g0urmVYosNcFn5Vrer0s4W3kW7EhZLaLDQ8k8VjSfgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILGgXO3r7O752sZP2dYwOyG/S7DIdAfRSHcFsBPKcaXjSKs9qSAVPESCMTMx98I/RPLCuxVgMfF7Lcmyu7RnYQxKTzE4ImRThTpRI29K5iQO1My3Ld6jFnZ3+CsK9C6D37IthM1NU9A1Tk8z83bwZnf1F4cPjL7vF7LnqrnH7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sEB3I-000000002Nq-1Sjk;
	Mon, 03 Jun 2024 17:00:56 +0000
Date: Mon, 3 Jun 2024 18:00:49 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <Zl32waW34yTiuF9u@makrotopia.org>
References: <20240603121834.27433-1-SkyLake.Huang@mediatek.com>
 <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
 <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk>
 <Zl3Fwoiv1bJlGaQZ@makrotopia.org>
 <Zl3IGN5ZHCQfQfmt@shell.armlinux.org.uk>
 <Zl3Yo3dwQlXEfP3i@makrotopia.org>
 <Zl3lkIDqnt4JD//u@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl3lkIDqnt4JD//u@shell.armlinux.org.uk>

On Mon, Jun 03, 2024 at 04:47:28PM +0100, Russell King (Oracle) wrote:
> On Mon, Jun 03, 2024 at 03:52:19PM +0100, Daniel Golle wrote:
> > On Mon, Jun 03, 2024 at 02:41:44PM +0100, Russell King (Oracle) wrote:
> > > On Mon, Jun 03, 2024 at 02:31:46PM +0100, Daniel Golle wrote:
> > > > On Mon, Jun 03, 2024 at 02:25:01PM +0100, Russell King (Oracle) wrote:
> > > > > On Mon, Jun 03, 2024 at 08:18:34PM +0800, Sky Huang wrote:
> > > > > > Add support for internal 2.5Gphy on MT7988. This driver will load
> > > > > > necessary firmware, add appropriate time delay and figure out LED.
> > > > > > Also, certain control registers will be set to fix link-up issues.
> > > > > 
> > > > > Based on our previous discussion, it may be worth checking in the
> > > > > .config_init() method whether phydev->interface is one of the
> > > > > PHY interface modes that this PHY supports. As I understand from one
> > > > > of your previous emails, the possibilities are XGMII, USXGMII or
> > > > > INTERNAL. Thus:
> > > > > 
> > > > > > +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> > > > > > +{
> > > > > > +	struct pinctrl *pinctrl;
> > > > > > +	int ret;
> > > > > 
> > > > > 	/* Check that the PHY interface type is compatible */
> > > > > 	if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL &&
> > > > > 	    phydev->interface != PHY_INTERFACE_MODE_XGMII &&
> > > > > 	    phydev->interface != PHY_INTERFACE_MODE_USXGMII)
> > > > > 		return -ENODEV;
> > > > 
> > > > The PHY is built-into the SoC, and as such the connection type should
> > > > always be "internal". The PHY does not exist as dedicated IC, only
> > > > as built-in part of the MT7988 SoC.
> > > 
> > > That's not how it was described to me by Sky.
> > > 
> > > If what you say is correct, then the implementation of
> > > mt798x_2p5ge_phy_get_rate_matching() which checks for interface modes
> > > other than INTERNAL is not correct. Also it means that config_init()
> > > should not permit anything but INTERNAL.
> > 
> > The way the PHY is connected to the MAC *inside the chip* is XGMII
> > according the MediaTek. So call it "internal" or "xgmii", however, up to
> > my knowledge it's a fact that there is **only one way** this PHY is
> > connected and used, and that is being an internal part of the MT7988 SoC.
> > 
> > Imho, as there are no actual XGMII signals exposed anywhere I'd use
> > "internal" to describe the link between MAC and PHY (which are both
> > inside the same chip package).
> 
> I don't care what gets decided about what's acceptable for the PHY to
> accept, just that it checks for the acceptable modes in .config_init()
> and the .get_rate_matching() method is not checking for interface
> modes that are not permitted.

What I meant to express is that there is no need for such a check, also
not in config_init. There is only one way and one MAC-side interface mode
to operate that PHY, so the value will anyway not be considered anywhere
in the driver.

