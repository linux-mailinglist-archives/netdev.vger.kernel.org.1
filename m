Return-Path: <netdev+bounces-226613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE1BA2FED
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8F07B0487
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C42580F2;
	Fri, 26 Sep 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hUKOltdz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6ABA4A;
	Fri, 26 Sep 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876331; cv=none; b=Ds3Imkj7qSmTvctLukdJYltzCr6XbJZD7PKAQS3J7+NIzL+9kAtFdaqcE2ZZ5UzCYlisLlipYOHUQvvEF4pN/+OqZcLaIlvdK7w/9XUCMEc3/2eeuYc80fvFMtkuwpOXgQxJEhVzO6sSwMnQ/IBNRG6pmIu3FI0m9kxq5vuy/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876331; c=relaxed/simple;
	bh=1WMTrV25ftvQGUWLkCsps0ILDMd4wd+U7u71dECBK7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErZKWUVyQ744NPdMrdreJBSVI6my0dAce5rXeCHJLruJHESPYXxV1mPZ6zDqTHJwcxLuoKSM5NFq1b1DukOrsiMpBMIjKj9/SvqjsSvoOjYmVehMbjcrBXkPEynAN+kPr0QRYG4PaAHBYhYV6cI0jRS0cVU7vzoAUCkGwVjRtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hUKOltdz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CpuPALWXV16JEBeqyBvRZypVB/YduO9IBL4wItC6JBY=; b=hUKOltdzuC3BkmP9w6Ne3O+dzC
	jMDI9Sm7xxD/liKdBY853BX6QrzdFrFu8X5vc8WcyYxLaAynKzAkPwFricK3V1DjPB81t3QbtFYEC
	MbbkKTaxZE7tW0UoR14TPgwkQPxaTKHWWMa8epJD3xi8xnY+DRhYiu/aoIBg1nsK397m5HNRVQ+mm
	dRVHy/88KY1sEp2I95IRg2P4Bkppb4ePoDq6v4lZY0pWr8sAr6yZ7brGDXnE2gwL9hniEWsIXIlL9
	ywFefCHuvtqtBgug9tJV+GLNSpA0RBp9Kbc/AOPXIlBt40bDAYYrp1M0MhXYGjOFm7cdY4rtCD3Hh
	sC8Ynxhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41368)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v244x-000000003Ff-2ATD;
	Fri, 26 Sep 2025 09:45:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v244u-000000000Wg-3OHt;
	Fri, 26 Sep 2025 09:45:20 +0100
Date: Fri, 26 Sep 2025 09:45:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yangfl <mmyangfl@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
Message-ID: <aNZSoHGgBCxs5rh3@shell.armlinux.org.uk>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
 <20250922131148.1917856-3-mmyangfl@gmail.com>
 <aNQvW54sk3EzmoJp@shell.armlinux.org.uk>
 <fe6a4073-eed0-499d-89ee-04559967b420@lunn.ch>
 <aNREByX9-8VtbH0n@shell.armlinux.org.uk>
 <CAAXyoMPmwvxsk0vMD5aUvx9ajbeAENtengzUgBteV_CFJoqXWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMPmwvxsk0vMD5aUvx9ajbeAENtengzUgBteV_CFJoqXWg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 26, 2025 at 02:30:25PM +0800, Yangfl wrote:
> On Thu, Sep 25, 2025 at 3:18 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Sep 24, 2025 at 08:41:06PM +0200, Andrew Lunn wrote:
> > > In theory, {R}GMII does have inband signalling, but it is pretty much
> > > never used. REV for GMII could thus indicate what role the device is
> > > playing in this in-band signalling?
> >
> > For RGMII, as you say, the in-band signalling is pretty much never used.
> > The stmmac code as it stands today does have support for using it, but
> > the code has been broken for longer than six years:
> >
> > 1. the longest historical breakage, it's conditional on the hardware
> >    reporting that it has a PCS integrated into the design, but a PCS
> >    won't be integrated into the design for RGMII-only cases.
> >
> > 2. even if (1) was fixed, that would result in the driver manipulating
> >    the netif carrier state from interrupt context, always beating
> >    phylink's resolve worker, meaning that mac_link_(down|up) never get
> >    called. This results in no traffic flow and a non-functional
> >    interface.
> >
> > So, maybe we should just ignore the RGMII in-band signalling until
> > someone pops up with a hard and fast requirement for it.
> >
> > > For any SERDES based links likes like SGMII, 1000Base-X and above,
> > > clocking is part of the SERDES, so symmetrical. There clearly is
> > > inband signalling, mostly, when it is not broken because of
> > > overclocked SGMII. But we have never needed to specify what role each
> > > end needs to play.
> >
> > 100base-X is intentionally symmetric, and designed for:
> >
> >         MAC----PCS---- some kind of link ----PCS----MAC
> >
> > where "some kind of link" is fibre or copper. There is no reverse mode
> > possible there, because "reverse" is just the same as "normal".
> >
> > For SGMII though, it's a different matter. The PHY-like end transmits
> > the link configuration. The MAC-like end receives the link
> > configuration and configures itself to it - and never sends a link
> > configuration back.
> >
> > So, the formats of the in-band tx_config_reg[15:0] are different
> > depending on the role each end is in.
> >
> > In order for a SGMII link with in-band signalling to work, one end
> > has to assume the MAC-like role and the other a PHY-like role.
> >
> > PHY_INTERFACE_MODE_SGMII generally means that the MAC is acting in a
> > MAC-like role. However, stmmac had the intention (but broken) idea
> > that setting the DT snps,ps-speed property would configure it into a
> > PHY-like role. It almost does... but instead of setting the "transmit
> > configuration" (TC) bit, someone typo'd and instead set the "transmit
> > enable" (TE) bit. So no one has actually had their stmmac-based
> > device operating in a PHY-like role, even if they _thought_ it was!
> >
> > > > However, stmmac hardware supports "reverse" mode for more than just
> > > > SGMII, also RGMII and SMII.
> > >
> > > How does the databook describe reverse SGMII? How does it differ from
> > > SGMII?
> >
> > It doesn't describe "reverse SGMII". Instead, it describes:
> >
> > 1. The TC bit in the MAC configuration register, which makes the block
> >    transmit the speed and duplex from the MAC configuration register
> >    over RGMII, SGMII or SMII links (only, not 1000base-X.)
> >
> > 2. The SGMIIRAL bit in the PCS control register, which switches where
> >    the SGMII rate adapter layer takes its speed configuration from -
> >    either the incoming in-band tx_config_reg[15:0] word, or from the
> >    MAC configuration register. It is explicitly stated for this bit
> >    that it is for back-to-back MAC links, and as it's specific to
> >    SGMII, that means a back-to-back SGMII MAC link.
> >
> > Set both these bits while the MAC is configured for SGMII mode, and
> > you have a stmmac MAC which immitates a SGMII PHY as far as the
> > in-band tx_config_reg[15:0] word is concerned.
> 
> So any conclusion? Should I go on with REV*MII, or wait for (or write
> it myself) reverse-mode flag?

Clearly not as there's been no discussion beyond my response to Andrew.
I don't know what to suggest, as whatever decision we make here, we
will have to live with the consequences of it for a very long time.

I suspect no one really knows the answer, so given the lack of
engagement on the issue, my suggestion would be to just press ahead
with your current approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

