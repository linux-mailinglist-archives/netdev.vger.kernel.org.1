Return-Path: <netdev+bounces-243019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F8C984E4
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78E6B4E284C
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21F0336ECB;
	Mon,  1 Dec 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bSjgtfRi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB73358D1
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607118; cv=none; b=l/TrS7lpMMdBLX06jnnBeefG6Jx+9GtccjFAIVBlHi/WdFoXdjC6/V258H0XMDb6dbolkqpS7NiUMBSiv/tJHfaf0D49JkJIjtMQZreEMOb8Q8OnyoHVzUq+Yp02rFkdaCsEVGmqUfzmYtBMbEqNLgc9cCjhZTpVS1+Sa8SZev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607118; c=relaxed/simple;
	bh=mAC0YZyitBsZeGGDTbwOudrYWr2Ek14k9InI/n+9Kr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewpPAeN1/S4UCnwZ2YQ5swwJ7eYcUYga0Fk2m62pZcrT/zDN216pHwPLbWSFLcEqT1zhawto0zfc1+AdMdNWavBl1wkjPRZchXXpa7TPHoIygoTm/2QktetFfWib1nHaCzXa53CA8lqILaWf5xJwMBQKjnBr7K1eSGSLk79C8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bSjgtfRi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kGl7SM2seAnZb0MwfSY+i9t4y1zT3BYhdFJfFDtJktw=; b=bSjgtfRiEoSeXqz5HE779+QRoV
	MgpQsNPROlusFGq9HSqlAQXT0zvARqbLusTkXBhgPONL7nuUA1UT2d6LrQBTYrNO9rOypoGXtpPTJ
	8XsDYxgkOrV7g+OpGYymsoHIY2uEFKj9fHc6UYs4mHUGfTmLqxeh1GUl1C7CsP2IpLaRrRbrwzFru
	RCXc4BKcri3pV1hEWttMzdzMcbxpmlCA/Ul/Rm0U7Kr2JIlTAnOXRYy3FR8MCH+PvawcjdhCS95Bv
	m+VEBkb8B/6yh71ijhfUDnhZFKSeAeDnly7BlxHcF7QRvJ4jdpqFrlSt376vlvkdCfEuDfd1Yctmt
	Ndj2yauQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52260)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQ6uw-000000000pK-01R0;
	Mon, 01 Dec 2025 16:38:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQ6us-000000006bg-1DIa;
	Mon, 01 Dec 2025 16:38:22 +0000
Date: Mon, 1 Dec 2025 16:38:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 00/15] net: stmmac: rk: cleanups galore
Message-ID: <aS3EfuypsaGK6Ww_@shell.armlinux.org.uk>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
 <05db9d3e-88fa-42db-8731-b77039c60efa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05db9d3e-88fa-42db-8731-b77039c60efa@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 01, 2025 at 04:55:21PM +0100, Andrew Lunn wrote:
> > One of the interesting things is that this appears to deal with RGMII
> > delays at the MAC end of the link, but there's no way to tell phylib
> > that's the case. I've not looked deeply into what is going on there,
> > but it is surprising that the driver insists that the delays (in
> > register values?) are provided, but then ignores them depending on the
> > exact RGMII mode selected.
> 
> Yes, many Rockchip .dts files use phy-mode = 'rgmii', and then do the
> delays in the MAC. I've been pushing back on this for a while now, and
> in most cases, it is possible to set the delays to 0, and use
> 'rgmii-id'.
> 
> Unfortunately, the vendor version of the driver comes with a debugfs
> interface which puts the PHY into loopback, and then steps through the
> different delay values to find the range of values which result in no
> packet loss. The vendor documentation then recommends
> phy-mode='rgmii', and set the delays to the middle value for this
> range. So the vendor is leading developers up the garden path.
> 
> These delay values also appear to be magical. There has been at least
> one attempt to reverse engineer the values back to ns, but it was not
> possible to get consistent results across a collection of boards.

Oh yes, I remember that. I also remember that I had asked for the
re-use of "phy_power_on()" to be fixed:

https://lore.kernel.org/netdev/aDne1Ybuvbk0AwG0@shell.armlinux.org.uk/

but that never happened... which makes me wonder whether we *shouldn't*
have applied "sensor101"'s patch until such a requested patch was
available. In my experience, this is the standard behaviour - as a
reviewer, you ask a contributor to do something as part of their
patch submission, and as long as their patch gets merged, they
couldn't give a monkeys about your request.

So, in future, I'm going to take the attitude that I will NAK
contributions if I think there's a side issue that the contributor
should also be addressing until that side issue is addressed.

This shouldn't be necessary, I wish this weren't necessary, and I wish
people could be relied upon to do the right thing, but apparently it is
going to take a stick (not merging their patches) to get them to co-
operate. More fool me for trusting someone to do something.

I now have a couple of extra patches addressing my point raised in
that email... which I myself shouldn't have had to write.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

