Return-Path: <netdev+bounces-208836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D8B0D587
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BF118841A4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736342DAFCE;
	Tue, 22 Jul 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u/nfxHQb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E628A41B;
	Tue, 22 Jul 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175653; cv=none; b=FwxaS52/gY7/GDu0tuz/htAuhdjDhnj8UPHVjdI6kMWxOsTT+BnH8iN1Wp6i7qyRBpiq7NqyX3aT7/BfhbqLJJqGFxablVafV0k3PpfSG9D1U7qXmdcOjHKq1dLdRYUx5WzJhyPTZqmypzoWrTljtGrIYOTJx1lEjALtmMhBWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175653; c=relaxed/simple;
	bh=6I2J+jle/ELUqLINDZ2CMKxGZXVtXDUdJEEej3F4Gmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox007gZanCxjxJThw7WaUE78zNeUSsGWmF2hvIjYVzIdfSr5B4nubF02Sg0iyJdJfBaoeOXVZVHQhxOvCfyguvRX4VFmyJBP4uxwheJHYA4HeGjEDu5F1H8mytQvfXulSKP61/j8VdHOXy1VOZQ2KDNMuHWgx9w/yCMpUWf8//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u/nfxHQb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xnES4CkHik4n+XCGU7bJoql3BaxRdweXbLtakclHrz4=; b=u/nfxHQbWSa54l6Q24jW2OAPoX
	6Yj4+uH0hBvTF+kb6dENrFod4oSsYqikrJzzCEzGxBoEtih/Zm5LtJDHAZz3mPqIYIyTZbZC9AVts
	FJgoWVYUEL3EqlXJthKYUSxUQadSpYz9xqY5TxZha6h/I5HPyPMMdU9YzX96ch9JsIWpPGG2XI/mh
	rTntgtN0DsVjmK1lSXDYXlUc8IdGkV68hmBuwOltT9+ymQhFFnlomQHoapJWhQ19w1VhArh0+OsC6
	PAOLE2tr9DgBWoaryTp/9sVO06DPoEhKUEZYZdVabSXOt3rgWY/yjJCERjHz+n+XhKh8UP53zYLtJ
	cFjESOiw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36626)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ue94M-00088E-02;
	Tue, 22 Jul 2025 10:13:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ue94H-00072H-35;
	Tue, 22 Jul 2025 10:13:49 +0100
Date: Tue, 22 Jul 2025 10:13:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <aH9WTYwty-tso66J@shell.armlinux.org.uk>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 21, 2025 at 07:07:11PM +0200, Andrew Lunn wrote:
> > Regarding this property, somewhat similar to "mediatek,mac-wol",
> > I need to position a flag at the mac driver level. I thought I'd go
> > using the same approach.
> 
> Ideally, you don't need such a flag. WoL should be done as low as
> possible. If the PHY can do the WoL, the PHY should be used. If not,
> fall back to MAC.
> 
> Many MAC drivers don't support this, or they get the implementation
> wrong. So it could be you need to fix the MAC driver.
> 
> MAC get_wol() should ask the PHY what it supports, and then OR in what
> the MAC supports.
> 
> When set_wol() is called, the MAC driver should ask the PHY driver to
> do it. If it return 0, all is good, and the MAC driver can be
> suspended when times comes. If the PHY driver returns EOPNOTSUPP, it
> means it cannot support all the enabled WoL operations, so the MAC
> driver needs to do some of them. The MAC driver then needs to ensure
> it is not suspended.
> 
> If the PHY driver is missing the interrupt used to wake the system,
> the get_wol() call should not return any supported WoL modes. The MAC
> will then do WoL. Your "vendor,mac-wol" property is then pointless.
> 
> Correctly describe the PHY in DT, list the interrupt it uses for
> waking the system.

This would be a good idea if we were talking about a new PHY and MAC
driver, but we aren't.

Given the number of platform drivers that stmmac has with numerous
PHY drivers, changing how this works _now_ will likely break current
setups. Whether PHY-side WoL is used is dependent on a
priv->plat->pmt flag which depends on MAC capabilties and also
whether the platform glue sets/clears the STMMAC_FLAG_USE_PHY_WOL
flag.

Yes, it's a mess, and it could do with being improved, which will
likely take considerable time to do to shake out any regressions
caused - both in stmmac and PHY drivers.

I bet there are _numerous_ PHY drivers that report and accept WoL
even when the hardware isn't wired to support WoL. For example,
AT8031 reports that it supports WAKE_KAGIC irrespective of whether
WOL_INT is wired, and whether or not the INT pin is capable of
waking the system. I don't think we have any way that a driver can
determine whether a particular interrupt _can_ wake the system.

The problem for stmmac is that the PHY driver may support WAKE_MAGIC,
but so can the MAC core. If the PHY isn't electrically capable of
waking the system for whatever reason, but the PHY driver still
reports that it can (like AT803x) and we don't program the MAC core,
then under your idea, WoL will no longer work.

The only thing I can think we can now do is to have yet another
STMMAC_FLAG_xxx which platform glue can set to enable a new behaviour.
Yay, a driver with multiple different behaviours depending on flags
for the same feature.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

