Return-Path: <netdev+bounces-238889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D663C60BA8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EA9B35A68A
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E529AAFD;
	Sat, 15 Nov 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wJ6Vtn25"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80B299AB5;
	Sat, 15 Nov 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240513; cv=none; b=AAB3Q7qT+xUyzs/offTwh5+NK60FmXCMsFgjTkL5c6C6yL+BM5F9HmUGVUH2j15C5mr1B4265XS8Ez02zo6JgnYBgUScxqe+vKK3eK2j1kCrKz31MW/9e8JXykHdX/Nb3s8RCVSc4lBByFQwLGrEwH97MTdZqExzpUrErkeR0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240513; c=relaxed/simple;
	bh=KAaOFr9VMNCdfZiXbOB2v11q96MZ7OkvnzWZrGHZOmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN1Ih+MJIF7d0JAfvfadW4DdevAvgX0cAuOXImGrDQon/d0IBLGM3UJymV8ho/naZM+sUWc8WUBZ/8G4XyFOwfSmqYriogZlHcGMycRG9JMqCYgr8UyHL14J0fI/yLq2sVXJJOz6gAskwyiBzZrSaSn2zDJ7sQ7FcezGiRbjMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wJ6Vtn25; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5svlvKH8KW5n0ke7qMCkQqdtMc7ntU+Iap0Fwxi0NiU=; b=wJ6Vtn257KknkrNwpYIgruGiyp
	c6pSVlISmcwRmM7OBKq8PVpcngqp8RxPjp5X2bM4VwNXUZT4Pfsa6KWKZcGeH18Tw0Yl9ICWXTjlm
	2OSVIQ3iyHRSlOeNqRNIDuKt7cALcR4CJOWf2iM1T+8nW3gb/lj3jrHoRg1ZkzpCdioLq3MeZvx8B
	Zoizq1Uo0UntpjvGYw4rPSVpChBPuWB7G0VDqASp+k5s2CvLpb+ROatb/Xh5/TiXI5d12TsfZCd8w
	RhwJYHzoSvhmPJp9v1itPemqGFYxKWNZkEyFKsaqBjzOSTYwtlg0J0mL5t4dr3xckSm7ednPzIFYh
	fi5QksKA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52092)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vKNOp-000000000Km-3tB9;
	Sat, 15 Nov 2025 21:01:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vKNOm-0000000076k-3af1;
	Sat, 15 Nov 2025 21:01:32 +0000
Date: Sat, 15 Nov 2025 21:01:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wei Fang <wei.fang@nxp.com>, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <aRjqLN8eQDIQfBjS@shell.armlinux.org.uk>
References: <20251114052808.1129942-1-wei.fang@nxp.com>
 <fc57fba2-26c2-4b8a-b0f5-1b3c4d1b9bef@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc57fba2-26c2-4b8a-b0f5-1b3c4d1b9bef@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 15, 2025 at 09:36:44PM +0100, Andrew Lunn wrote:
> On Fri, Nov 14, 2025 at 01:28:08PM +0800, Wei Fang wrote:
> > Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> > initialized, so these link modes will not work for the fixed-link.
> > 
> > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/phy/phylink.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 9d7799ea1c17..918244308215 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -637,6 +637,9 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
> >  
> >  static void phylink_fill_fixedlink_supported(unsigned long *supported)
> >  {
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
> 
> Do these make sense? There is no PHY, so there is no autoneg? So why
> is autoneg in supported?
> 
> You can force pause at the MAC with ethtool:
> 
> ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]

No, not for fixed links. (I have a patch which enables this, but we
mutually agreed not to push it into mainline - I think you've forgotten
that discussion.)

> Maybe you should explain what problem you are seeing?

As explained in this thread, it's the lack of pause. Not having the
pause bits in the supported mask means that phylink can't evaluate
the pause modes to use, because even if they are present in DT,
they get cleared because they're cleared in the supported mask.

At least Pause and Asym_Pause need to be set.

This is because the fixed-link pause specification is in terms of
Pause and Asym_Pause. Having one set of these bits is meaningless in
terms of "should we transmit pause frames" and "should we receive
pause frames" which is what hardware wants to know. It would've
been better had the DT binding defined pause in terms of tx/rx not
the Pause/Asym_Pause bits.

However, with that definition, the only way to give these bits any
sane meaning is to treat them as the capabilities of a virtual link
partner, use the Pause and Asym_Pause capabilities of the local MAC,
and evaluate them according to the 802.3 rules.

However, as we end up masking off the local MAC's Pause and Asym_Pause
bits, this results in that evaluation deciding that pause is
unsupported. This is a *regression* that needs fixing, caused by the
blamed commit.

There is no question that this needs fixing.

The question is whether Autoneg should be set or not. As the
advertising and lp_advertising bitmasks have to be non-empty, and the
swphy reports aneg capable, aneg complete, and AN enabled, then for
consistency with that state, Autoneg should be set. This is how it was
prior to the blamed commit.

So, the patch is the correct approach. The only thing that is missing
is the detailed explanation about the problem the regression is
causing. We have too many patches that fix regressions without
explaining what the effect of the regression was... which is bad when
we look back at the history.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

