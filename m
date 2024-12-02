Return-Path: <netdev+bounces-148038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528FA9DFF28
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 11:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE0DB25CF4
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC61FC0E5;
	Mon,  2 Dec 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F6xCyeqp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25731FA829;
	Mon,  2 Dec 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135020; cv=none; b=nWQFbiskufLhnnaWxHKDvaJhpb/g/K2TuANgb7RKZIrCG0NQoKdVzN5p7wDXh6rVxibdpfeJ3td2G9HoXpPy9tDsors6nWObyeGOpZQNFCUT6fhSWYUlzRDWwsiVtw0UdJBOLjQbcj2qm1zEXb2Bt3QxWtlASNzjaxmbK/O6Mt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135020; c=relaxed/simple;
	bh=9rXkJs8GJ2KJjcbbFKbajRIP+OStJGl8D8Um2C3Jz0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH+27J3Fzkuz+MST/ofGXiEuLAsKWcpnFCmMrw4FG61wzHK+i86GT3SUFtk4FqgNHGMdboK8Li+qzOIKFprZWCSdSRfkbXrS4UG2qZKcUSDdWV8iFaoshB7glVxeitwx/AwkAMGqRJSX1RsmlV0j0LVTRBeZn9sR5Q1d1pDBcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F6xCyeqp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H4h/aHUFpAywuKRQIgpMKtSocX0yJxNZ5Hq0bZw0Etc=; b=F6xCyeqpRayMepDDcu4n+Yfzx4
	ctgTBNyBDgPAqsciGzYI+uzMVYhBW+CNO+D4rSKuz5rcl5hTddi17BT09mu8Zh0PNGLthevONHMNm
	3nB7Kmo6W/c0HqJXbEYeuvge9d8FYnW++d3BA54ZREW417osCToVcLsjtWcJ5+8YrRarxKSxgFA3n
	ZkcqKEOlww7h32DZy23okuAx0ZqB92DUZDK0jNHaxiCMc/l8nYOvdzQ6IuciEHLyg2mH9K689hwBp
	/UgFubbponush6Bq3W+K21h7eXlJ4drwPAuULm+SK3qYVShEEWm+kRpbBX2mYi44dIAGLh83riXWD
	SPF+PxvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53000)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tI3aW-0008AU-0F;
	Mon, 02 Dec 2024 10:23:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tI3aT-0003Uh-1V;
	Mon, 02 Dec 2024 10:23:29 +0000
Date: Mon, 2 Dec 2024 10:23:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Message-ID: <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 02, 2024 at 03:17:08PM +0500, Nikita Yushchenko wrote:
> > > To get two such PHYs talk to each other, one of the two has to be manually configured as slave.
> > > (e.g. ethtool -s tsn0 master-slave forced-slave).
> > 
> > I don't see what that has to do with whether AN is enabled or not.
> > Forcing master/slave mode is normally independent of whether AN is
> > enabled.
> > 
> > There's four modes for it. MASTER_PREFERRED - this causes the PHY to
> > generate a seed that gives a higher chance that it will be chosen as
> > the master. SLAVE_PREFERRED - ditto but biased towards being a slace.
> > MASTER_FORCE and SLAVE_FORCE does what it says on the tin.
> > 
> > We may not be implementing this for clause 45 PHYs.
> 
> Right now, 'ethtool -s tsn0 master-slave forced-slave' causes a call to
> driver's ethtool set_link_ksettings method. Which does error out for me
> because at the call time, speed field is 2500.

Are you saying that the PHY starts in fixed-speed 2.5G mode?

What does ethtool tsn0 say after boot and the link has come up but
before any ethtool settings are changed?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

