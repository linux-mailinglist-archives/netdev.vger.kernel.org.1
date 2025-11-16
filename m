Return-Path: <netdev+bounces-238957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E7C619B4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13C1635FA23
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D32428726D;
	Sun, 16 Nov 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zX61EhgM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92870238D5A;
	Sun, 16 Nov 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763314406; cv=none; b=ZMN5+AQM96ngMXt+WTTsOMa+8jSgds3+jV3SJIjn3ynLHNbaF/SyyOKRWpJgZPuRk4zYX/tNsIc0HsRwgfH7PlsnR5Tzx2ocBUlKUp3heGLqFkjI5p3lOzvpSjKiwqWAXZuNQroS9PykqpHqp2tgP3NdVtsKp0blLJLuwFiCe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763314406; c=relaxed/simple;
	bh=5z4uhDIfG8bBigHHQPzo79QxNSl7kd/oYHvED6VpEUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NflRAAvjZwmGGI68Umztzm0JM48dH3HrOA/AdMvzRY+8xgGXQHZuhxFuqvZIjRe32vPKqCZ6eRnArXcyy4TgX/KwKQcDWyaQ+67W1hsM6XVBa5BtViIBuqpn9l+hKceX6qHc560AD/InQ/nKiSKL6ee3S0u56djFwtX7PVvlqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zX61EhgM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VmDVW2gVlfzf4QxpOM7IKcjuWm9feQlvZEcS75tlafI=; b=zX61EhgMGr5LlnDTQhi81vFRNY
	WRGyjHhANwS/dZQAcTKmRJ6P9lXzzcsGmfxEOJCNJ46CgcnOpfK6PXPWkU+tEjXS7uaJuOiNWU0R1
	xPS2F32BaGrdMj83UW2KZowbG3Bl78oSaIhK/xWjNsKeSdT2eR6pobRHe+fILiCG//DCkAIxZWy6d
	qC5WfrxrWUeewlDwUxWBqd3mWkkOkllQETCwmOSbYHnurN17QhTjZ+RoktpSymdAXj6MSBQZ0942H
	B58KCc/eWYC4NPpKTBV8c+Xl3cvq0JYtM2NkRQbxjXg/2VB40/zJhFBOIZ6CZltYZAf47rpWdMyFI
	t9qMSXxg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44754)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vKgcm-0000000012I-0ipM;
	Sun, 16 Nov 2025 17:33:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vKgci-000000000fX-3Qem;
	Sun, 16 Nov 2025 17:33:12 +0000
Date: Sun, 16 Nov 2025 17:33:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wei Fang <wei.fang@nxp.com>, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <aRoK2A4qh-vLKhpZ@shell.armlinux.org.uk>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
 <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Nov 16, 2025 at 05:10:19PM +0100, Andrew Lunn wrote:
> There is no limit on commit message length, but URLs sometimes
> die. Please just make use of Russells explanation. You can say: As
> explained by Russell King, and just quote it, etc.

I think one of the reasons lore exists is to provide a stable and
reliable source of URLs into archives - it's maintained by the
kernel.org folk.

> This also seems like two fixes: a regression for the AUTONEG bit, and
> allowing pause to be set. So maybe this should be two patches?

The blamed commit caused both to change.

The old code:

	linkmode_fill(pl->supported);
	linkmode_copy(pl->link_config.advertising, pl->supported);
	phylink_validate(pl, pl->supported, &pl->link_config);

This results in pl->supported and pl->link_config.advertising being
the fullest capabilities that the MAC supports.

	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
                               pl->supported, true);

This gets the linkmode bit corresponding to the speed/duplex. We then
construct a mask:

	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
	...
	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mask);

which ends up passing through just these three bits, provided the MAC
supports them:

	linkmode_and(pl->supported, pl->supported, mask);

We ensure that a port type is set:

	phylink_set(pl->supported, MII);

and then we explicitly set a single bit for the speed/duplex:

	if (s) {
		__set_bit(s->bit, pl->supported);
		__set_bit(s->bit, pl->link_config.lp_advertising);
	} else ...

lp_advertising doesn't make sense without Autoneg bit set.

After the blamed commit, rather than pl->supported being filled
prior to the phylink_Validate() call, it is now cleared and the
baseT modes are populated. Everything else is clear. This is
incorrect.

So, I think fixing this breakage in a single patch is justified.
It is restoring the old behaviour which we've had for a long time.
It isn't two bugs, it's one mistake.

> I'm also surprised TCP is collapsing. This is not an unusual setup,
> e.g. a home wireless network feeding a cable modem. A high speed link
> feeding a lower speed link. What RTT is there when TCP gets into
> trouble? TCP should be backing off as soon as it sees packet loss, so
> reducing the bandwidth it tries to consume, and so emptying out the
> buffers. But if you have big buffers in the ENETC causing high
> latency, that might be an issue?  Does ENETC have BQL? It is worth
> implementing, just to avoid bufferbloat problems.

I'd also suggest further evaluating the performance of other ports
when flow control is enabled when one port gets overwhelmed with
packets (and thus the switch starts sending pause frames to the
host port, slowing _all_ traffic to _all_ ports.)

Depending on the application, it may be better to let the congested
port drop packets (Ethernet was designed to drop packets after all)
while allowing other ports to operate, rather than throttling all
ports.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

