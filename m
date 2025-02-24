Return-Path: <netdev+bounces-169031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182FCA42269
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F18E3ABC7E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F701A29A;
	Mon, 24 Feb 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tqfi03od"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C07083F;
	Mon, 24 Feb 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405683; cv=none; b=J5zbTYiWI79NVKjF1auL4PYy8hwy1yhBXHdBtKILrSIB2DqHEOHwZVg0SPBJMdQLVRr6EaNmWKJat0hz6Cz3EeY+sqRYGr+s3bFGWtN5dm9m7tkYhFzDNKcX0JsfmNGWceDTwcMKrUONTjnD9oAURNSUfStIqnVxox9K7P2Z1G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405683; c=relaxed/simple;
	bh=+AKGTAVxvBd9V/GwcXqWRQnTMOO2sy6yYmow9Aivit4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH+cPW2TLjDae/9RVHASbuoevhMD/aJW43tAzjHMzY8vEVpGlc6ATRLxzjSqYTY6xzN0ou5pu3WJV2DSlK2CDLGO9GAobjvu4is+ylZAIyP6Y7V8T/OdW2YG+8tg5ZhTrmoU9jCjnVn08XUpVx4DXlD8X8HD2ONeEmGVJinXmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tqfi03od; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g3pKjimdpYHYRgRlkEN2TeR5MtbKLWDqPslqiEwTKl0=; b=Tqfi03odd2+9ApJmXuG5zGIJn1
	Zow5gKtlUufYs/nsd2wd1D7M1NMeAjhJx2Shk8aM9+oZ3+8CLXQXjVLhEnt1OTlLby5v80W5bCtts
	CzamauiUl0gsK/XkFcOoy3jCqrOiTVYBZkthwApVgF4LftlsryTI5DC3rCu/FIJI85K87jdLb97Ib
	rsBJGWAQvN2BQdiqvcgLr7K/SyfqgKW3H/HfW5gxUng30HcW1s91E5pmJMwn5n3QKyUie2hEt3MVW
	gC9jEtoXGj2j0CMfYdAQUtGmADQk/MQXsYbaaVpteWjSWgRCHLktDSWv8Q5Drbgk3Nr29OMPsnJl/
	RLTFQgfg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47558)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmZ1F-0006W1-0p;
	Mon, 24 Feb 2025 14:01:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmZ1D-000535-1W;
	Mon, 24 Feb 2025 14:01:11 +0000
Date: Mon, 24 Feb 2025 14:01:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 01/13] net: phy: Extract the speed/duplex to
 linkmode conversion from phylink
Message-ID: <Z7x7p3W0ZpkFu44m@shell.armlinux.org.uk>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
 <20250222142727.894124-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222142727.894124-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 22, 2025 at 03:27:13PM +0100, Maxime Chevallier wrote:
> Phylink uses MAC capabilities to represent the Pause, AsymPause, Speed
> and Duplex capabilities of a given MAC device. These capabilities are
> used internally by phylink for link validation and get a coherent set of
> linkmodes that we can effectively use on a given interface.
> 
> The conversion from MAC capabilities to linkmodes is done in a dedicated
> function, that associates speed/duplex to linkmodes.
> 
> As preparation work for phy_port, extract this logic away from phylink
> and have it in a dedicated file that will deal with all the conversions
> between capabilities, linkmodes and interfaces.

Fundamental question: why do you want to extract MAC capabilities from
phylink?

At the moment, only phylink uses the MAC capabilities (they're a phylink
thing.) Why should they be made generic, and what use will they be
applied to as something generic?

If there's no answer for that, then I worry that they'll get abused.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

