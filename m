Return-Path: <netdev+bounces-169873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B0AA461A2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56003AB456
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1CB1DC9BA;
	Wed, 26 Feb 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v4V1VDYn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E080BEC;
	Wed, 26 Feb 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578611; cv=none; b=oR/4PvqvF944i7yREBEXbqDE7RirvL3BUcHoWr89XpQ0Ce1L8+NojxVbIuvwDB/rvg79XP0UiEJFzrkFOeZ3T0/GYjV5KOmVGyZ0A78Ry/CyiRMRSsv55IOoRmIlwJoP4Pa2MLlNClgZ+zCoxuOe2o41XxF7WmGXbs3RO082i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578611; c=relaxed/simple;
	bh=3U/m7mcdUbzM4mRU4Dj0YDUMzpreu67sDGs/5f9OvMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj/2XIQsfdLVmbPt/ldD1aYqB+St113VLVnTbE6cQKTQRnlIdc6qYEuyg65payeukU6SeAUQTFluq6cgDcW9wzH+i4lKq+WzaGILSswr+UUae+pqJnrKiIT+DXLsNFth2uxa2P9mk9bW19Ktm5fiaH/avzCE5O8VPSPJb+k4QP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v4V1VDYn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tiK61WpmT0ctKIwY75HnpThFd8ZzC9ffICVu+PpUZ3c=; b=v4V1VDYngPydaUXfGptlcFt9Ck
	Cj2Ecb1U3T5RkWNpXSkx9uWXFyNA7S1bXKT7QCgUHJYLQRJpeOqcVVB8gdFP7f4NU+xNTHf+c/DgK
	ItFKUrCIcOXV1ZK6/n+otAwHVyctwbDJ9farlSRaz7t3gfVsKG7/EdDmZ66z8iapFASxsRQrJT+EV
	DjgsggTsqmH8ID0bZmUczQz6mFEJlmcWP9s+HeHYyVujr9YGxEBnFKvDrYPFCzARVYTkpLq/+1Z8i
	kHIrpg1v6a5Q1r2CatE76keKbiTxdEsVAWoqK6hv7lyd64FIBhJBPw5dIbGuRO0rfbdA5AL79H7tr
	+sQ57tyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41768)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnI0R-0004Q7-0o;
	Wed, 26 Feb 2025 14:03:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnI0O-000790-2L;
	Wed, 26 Feb 2025 14:03:20 +0000
Date: Wed, 26 Feb 2025 14:03:20 +0000
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
Subject: Re: [PATCH net-next v2 11/13] net: phy: phylink: Add a mapping
 between MAC_CAPS and LINK_CAPS
Message-ID: <Z78fKCZl4-77NjeK@shell.armlinux.org.uk>
References: <20250226100929.1646454-1-maxime.chevallier@bootlin.com>
 <20250226100929.1646454-12-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226100929.1646454-12-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 11:09:26AM +0100, Maxime Chevallier wrote:
> phylink allows MAC drivers to report the capabilities in terms of speed,
> duplex and pause support. This is done through a dedicated set of enum
> values in the form of the MAC_ capabilities. They are very close to what
> the LINK_CAPA_xxx can express, with the difference that LINK_CAPA don't
> have any information about Pause/Asym Pause support.
> 
> To prepare converting phylink to using the phy_caps, add the mapping
> between MAC capabilities and phy_caps. While doing so, we move the
> phylink_caps_params array up a bit to simplify future commits.

I still want to know why we need to do this type of thing -
unfortunately I don't have time to review all your patches at the
moment. I haven't reviewed all your patches since you've started
posting them. Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

