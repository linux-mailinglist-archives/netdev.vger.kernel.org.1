Return-Path: <netdev+bounces-185940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F8A9C355
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A241BA3862
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A5523645D;
	Fri, 25 Apr 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GziSayXt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCF21638A;
	Fri, 25 Apr 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573119; cv=none; b=p2xyKyxeEv/XRbYHCGnjFla3byyLY8UTlcRp8OcEJHalX9u726UuErGdJBTT9OiXFACqDQewdipJUgjNjbUjka4i2kYfqznDxXLWJooRKYKJDvFvnNKyTfQBoDguMpT9ptVBQoMoggIha6e0IGOvu08R7tRmar2xo+BG5wBbkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573119; c=relaxed/simple;
	bh=cLDw/pFiQMKKNBt2vgKzSce0c1mxZowhfJuiq/FLoMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOOrqdjrZwI3KRTo7p1zpjuqVdxuoubpDNPqFT2iQ8cqv663QQIoc6xPHx4YHq6tvnZgoN9zCWVFK56fLnMBkcnN7QLDz0TraTzSygQTaiG6pV73BpPkux033Tu9NmBouFro7jCQrWb64VB2E4wpBR/25bDrXPjGIIo1x+EAuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GziSayXt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lxGr4WcpRX1IjJ/LypAJtCvOD84z/5iROdqFg9S4Asc=; b=GziSayXtt09diC+kfs0/9nXHRZ
	ieNIDpJPy1pHf705DcK2RkuJ0u2udgnRQEIg3YWp3qcbgwPStTt2CHPpGO+qKX5xUzbBv8YCm2dLn
	q6WR2sxlJpNUW5wCuQq54EcJMFzD7gVgaOgTkO2tjg2Oj5xYut+atmYaA94Ofd2dvaZwdAgo35q/H
	FrTDW/t1PrxTwU41GtxLo7fTFjqF8MR6Fbmcxgj7nR0voxO/sPRtmZzhlp6E3gCP7+NkHOaUadY8l
	okMGCMPIUg0wc3OYsUmmL3ihHfp7D4n+TyfkyWj/MuxcVFiZIj/BKFm3ziDa3W1dNodxjjLLxZCPO
	Y9rhxgcA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52702)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u8FIn-00005f-2k;
	Fri, 25 Apr 2025 10:24:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u8FIh-00021A-1a;
	Fri, 25 Apr 2025 10:24:51 +0100
Date: Fri, 25 Apr 2025 10:24:51 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] Documentation: networking: expand and
 clarify EEE_GET/EEE_SET documentation
Message-ID: <aAtU45S6HChgb0_V@shell.armlinux.org.uk>
References: <20250425084941.253961-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425084941.253961-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 25, 2025 at 10:49:41AM +0200, Oleksij Rempel wrote:
> +``ETHTOOL_A_EEE_ACTIVE`` indicates whether EEE is currently active on the link.
> +This is determined by the kernel as a combination of the currently active link
> +mode, locally advertised EEE modes, and peer-advertised EEE modes:
> +
> +    active = (current_link_mode & advertised & link_partner)

... and EEE is enabled.

EEE active is more "EEE is enabled and has been successfully negotiated
at the current link speed", rather than "the link is in LPI state"
which I think some people have thought it meant in the past. I'm also
wondering whether this should also include "and autonegotiation via
ETHTOOL_SLINKSETTINGS is enabled" as that is necessary to allow the
PHY to exchange autoneg pages which include the EEE page.

> +Detailed behavior:
> +
> +``ETHTOOL_A_EEE_MODES_OURS`` can specify the list of advertised link modes.
> +
> +``ETHTOOL_A_EEE_ENABLED`` is a software flag that tells the kernel to prepare
> +EEE functionality. If autonegotiation is enabled, this means writing the EEE
> +advertisement register so that the PHY includes the EEE-capable modes in the
> +autonegotiation pages it transmits. The actual advertisement set is a subset
> +derived from PHY-supported modes, MAC capabilities, and possible blacklists.
> +This subset can be further restricted by ``ETHTOOL_A_EEE_MODES_OURS``. If
> +autonegotiation is disabled, EEE advertisement is not transmitted and EEE will
> +not be negotiated or used.

Maybe similar here.

> +
> +``ETHTOOL_A_EEE_TX_LPI_ENABLED`` controls whether the system should enter the
> +Low Power Idle (LPI) state. In this state, the MAC typically notifies the PHY,
> +which then transitions the medium (e.g., twisted pair) side into LPI. The exact
> +behavior depends on the active link mode:
> +
> + - In **100BaseT/Full**, an asymmetric LPI configuration (local off, peer on)
> +   leads to asymmetric behavior: the local TX line remains active, while the RX
> +   line may enter LPI.
> + - In **1000BaseT/Full**, there are no separate TX/RX lines; the wire is silent
> +   only if both sides enter the LPI state.

I'm not sure this belongs in the API documentation, as (1) this is part
of the hardware specification and (2) it brings up "what about faster
link modes" which do support EEE as well.

If they're going to be looking at whether the physical signals are
entering low power mode, they're going to have hardware to probe the
signals, thus they've probably got hardware experience and thus would
surely refer to the documentation to work out what's supposed to be
happening, and probably wouldn't look at API documentation.

> +
> +- ``ETHTOOL_A_EEE_TX_LPI_TIMER`` configures the delay after the last
> +  transmitted frame before the MAC enters the LPI state. This single timer
> +  value applies to all link modes, although using the same value for all modes
> +  may not be optimal in practice. A value that is too high may effectively
> +  prevent entry into the LPI state.

As an interesting side note, stmmac defaults to one second, and it
doesn't prevent LPI entry.

Having a high value might be what an application wants - EEE introduces
additional latency to an ethernet link, and one may wish LPI mode to be
entered when e.g. a machine in a data centre has all users migrated off
it, thus allowing the ethernet connection to it to fall silent.
Otherwise one may wish the link to stay out of LPI mode, so choosing a
high LPI timer would suit that.

So, this is policy. I'm not sure statements about that should be in an
API specification. I'm also thinking that surely one would understand
that if one sets this to 1 second, then there needs to be no traffic
for 1 second before the link enters LPI state.

Finally, I'm wondering about the duplication of documentation between
this document and include/uapi/linux/ethtool.h. The struct definitions
are documented in the header file, and it seems we're describing the
same thing in two different places which means there's a possibility
for things to be described differently thus creating confusion. I
think we should have only one description and reference it from
other places.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

