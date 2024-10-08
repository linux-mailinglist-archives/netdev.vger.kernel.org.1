Return-Path: <netdev+bounces-133102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC4994BAF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48095284F20
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26311DEFC7;
	Tue,  8 Oct 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n2YqT1ht"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AE1D54D1;
	Tue,  8 Oct 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391522; cv=none; b=higuAt1AYXP8o223iyVQazGEFB3eamWmrPNAipBzQhRZBcvnQgRyEPfol0ETcCBhj4TKdSKRJdPi0sKuladjPXLuDqAgvpWNKMlccImGKsbV6HPjvVL2ZkWiMDbtAYtadVKyC4FXsRHaWdAjumvFUxwIAZ9yR8MAzrBM8fWkqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391522; c=relaxed/simple;
	bh=6/oRyMPGcEvKaeHehfhl0jhkiZ7lkj95bl89PM8ACeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvQ9WFoHdZdE+8xPCi2ZH1OwvNjOm69YD0c/Z7ds/lO+mrou+zn0EnC0+N1q+VFqAO2IDh2QJr7RxrqYWzRsvyKP5mleMVU3YUgxRh2z62n8m4+hnpmAlJHslaORGMUEPXcpTgkYJSFA7XDkxZtX4Y6BJM9WJN32E9GMqBoUzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n2YqT1ht; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ziYKzvwTaL9dyu14C75glV0SIgO4lRAt54BLxcOvLxw=; b=n2YqT1htWKBQNRwsAmQZOrwkJM
	O+q9G6hZCLXiyJd3NASg1Uoc+zZFZffO6lgWkzEydPxNjf8cPIGVxGxsifly19iV8OJbVcl8gxsVL
	smxPa2NK6lcoXemL+jBZ8olNcaXFeyPmfucKVqinWa9cpdlKJ9dQqs4gZjC+Uq6kFkvZ9hWbH9A7V
	7GWunnOOGml851pwJVWCgjORW+WKG4qnD9P3t+jSEc5LOPksOSs8EFFFdj4MMhqoATsXWu6lcWG0r
	qFLtwCQ9IAXvHFZpfrf5uy5ezZ6G3Kc1tJU/UlgJxT6BdU+WGxErKvqbxZN37omJbtYkQ2BUlz2ET
	h60nyOPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39966)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sy9aO-0007St-0I;
	Tue, 08 Oct 2024 13:45:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sy9aJ-0005CQ-1Q;
	Tue, 08 Oct 2024 13:45:03 +0100
Date: Tue, 8 Oct 2024 13:45:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <ZwUpT9HRdl33gv_G@shell.armlinux.org.uk>
References: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>
 <8fb5c25d-8ef5-4126-b709-0cfe2d722330@lunn.ch>
 <ZwBmycWDB6ui4Y7j@makrotopia.org>
 <ZwUTDw0oqJ1dvzPq@shell.armlinux.org.uk>
 <ZwUelSBiPSP_JDSy@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUelSBiPSP_JDSy@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 08, 2024 at 12:59:17PM +0100, Daniel Golle wrote:
> On Tue, Oct 08, 2024 at 12:10:07PM +0100, Russell King (Oracle) wrote:
> > On Fri, Oct 04, 2024 at 11:06:01PM +0100, Daniel Golle wrote:
> > > On Fri, Oct 04, 2024 at 11:17:28PM +0200, Andrew Lunn wrote:
> > > > On Fri, Oct 04, 2024 at 04:50:36PM +0100, Daniel Golle wrote:
> > > > > Only use link-partner advertisement bits for 10GbE modes if they are
> > > > > actually valid. Check LOCALOK and REMOTEOK bits and clear 10GbE modes
> > > > > unless both of them are set.
> > > > > This prevents misinterpreting the stale 2500M link-partner advertisement
> > > > > bit in case a subsequent linkpartner doesn't do any NBase-T
> > > > > advertisement at all.
> > > > > 
> > > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > > ---
> > > > >  drivers/net/phy/realtek.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > > > > index c4d0d93523ad..d276477cf511 100644
> > > > > --- a/drivers/net/phy/realtek.c
> > > > > +++ b/drivers/net/phy/realtek.c
> > > > > @@ -927,6 +927,10 @@ static int rtl822x_read_status(struct phy_device *phydev)
> > > > >  		if (lpadv < 0)
> > > > >  			return lpadv;
> > > > >  
> > > > > +		if (!(lpadv & MDIO_AN_10GBT_STAT_REMOK) ||
> > > > > +		    !(lpadv & MDIO_AN_10GBT_STAT_LOCOK))
> > > > > +			lpadv = 0;
> > > > > +
> > > > >  		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
> > > > >  						  lpadv);
> > > > 
> > > > I know lpadv is coming from a vendor register, but does
> > > > MDIO_AN_10GBT_STAT_LOCOK and MDIO_AN_10GBT_STAT_REMOK apply if it was
> > > > also from the register defined in 802.3? I'm just wondering if this
> > > > test should be inside mii_10gbt_stat_mod_linkmode_lpa_t()?
> > > 
> > > Yes, it does apply and I thought the same, but as
> > > mii_10gbt_stat_mod_linkmode_lpa_t is used in various places without
> > > checking those two bits we may break other PHYs which may not use
> > > them (and apparently this is mostly a problem on RealTek PHYs where
> > > all the other bits in the register persist in case of a non-NBase-T-
> > > capable subsequent link-partner after initially being connected to
> > > an NBase-T-capable one).
> > > 
> > > Maybe we could introduce a new function
> > > mii_10gbt_stat_mod_linkmode_lpa_validate_t()
> > > which calls mii_10gbt_stat_mod_linkmode_lpa_t() but checks LOCOK and
> > > REMOK as a precondition?
> > 
> > Isn't the link status supposed to indicate link down of LOCOK
> > is clear?
> > 
> > Maybe checking these bits should be included in the link status
> > check, and if not set, then phydev->link should be cleared?
> 
> At least in case of those RealTek PHYs the situation is a bit different:
> The AN_10GBT bits do get set according to the link partner advertisement
> in case the link partner does any 10GBT advertisement at all.
> Now, if after being connected to a link partner which does 10GBT
> advertisement you subsequently connect to a link partner which doesn't
> do any 10GBT advertisement at all, the previously advertised bits
> remain in the register, just REMOK and LOCOK aren't set.
> That obviously doesn't imply that the link is down.
> I noticed it because I would see a downshift warning in kernel logs
> even though the new link partner was not capable of connecting with
> speeds higher than 1000MBit/s.
> Note that some that this doesn't happen with all 1GBE NICs, because
> some seem to carry out 10GBT advertisement but just all empty while
> others just don't do any 10GBT advertisement at all.

Let's start checking what we're doing with regards to this register.

7.33.11 (Link Partner 10GBASE-T capability) states that this is only
valid when the Page received bit (7.1.6) has been set. This is the
BMSR_ANEGCOMPLETE / MDIO_AN_STAT1_COMPLETE bit.

Looking at rtl822x_read_status, which is called directly as a
.read_status() method, it reads some register that might be the
equivalent of MMD 7 Register 33 (if that's what 0xa5d, 0x13 is,
0xa5d, 0x12 seems to be MDIO_AN_10GBT_CTRL) whether or not the link
is up and whether or not AN has completed. It's only conditional on
Autoneg being enabled.

However, we don't look at 7.1.6, which is wrong according to 802.3.
So I think the first thing that's needed here is that needs fixing
- we should only be reading the LP ability registers when (a) we
have link, and (b) when the PHY indicates that config pages have
been received.

The next thing that needs fixing is to add support for checking
these LOCOK/REMOK bits - and if these are specific to the result of
the negotiation (there's some hints in 802.3 that's the case, as
there are other registers with similar bits in, but I haven't
looked deeply at it) then, since the resolution is done in core
PHY code, I think we need another method into drivers to check
these bits once resolution has occurred.

However, I need to do more reading to work this out.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

