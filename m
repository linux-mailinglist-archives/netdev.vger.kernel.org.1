Return-Path: <netdev+bounces-57019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2081199B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAAD28245B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60F2FC21;
	Wed, 13 Dec 2023 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HhTNMn2z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6EB134;
	Wed, 13 Dec 2023 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8Rz0Hd4GHebEk04ieni7Igt9GqSHOkY56E1iGl+TH3g=; b=HhTNMn2zzCcbcLo4rK6OhTBKdI
	JRzY3ih3wjCvsBt99HBVNYjBY3pbJCCC31gHvb0hpbIPBXLa226D1sFzW0ZbvfqLNFfaQf6bGf+Pt
	9qD5JSQGk9L5twNvMyWSlr+zyEnoYd8ZeWiVl60I7ePhCMKdCPRDw34sk8j+IEXfH4DNVqx6XmNig
	6zVHVDD2MXDQFykTMnpVPsuaTdezA2VmbBtJ3u8o9NGbGjk1QMz4F5wicDeAfe/PW1EzD43aF73SV
	V0px6EytF81VS1Pi2kKbj9xDDw1m9fhsXJ1IDxNvwiL77CALxqb83KCguiYjl6Rb/Vi/+oQQoqYDq
	p/PvYgvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55264)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDSC8-0000Hm-2E;
	Wed, 13 Dec 2023 16:34:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDSCA-0001eb-I9; Wed, 13 Dec 2023 16:34:50 +0000
Date: Wed, 13 Dec 2023 16:34:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 1/3] net: phy: extend PHY package API to
 support multiple global address
Message-ID: <ZXndKlCTq12jf53y@shell.armlinux.org.uk>
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
 <ZXnRlERUGhwxKJxi@shell.armlinux.org.uk>
 <6579d2cc.050a0220.e6ea.d8cf@mx.google.com>
 <ZXnX6GuooQQwu8Bs@shell.armlinux.org.uk>
 <6579dab5.050a0220.8552a.d827@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6579dab5.050a0220.8552a.d827@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 13, 2023 at 05:24:18PM +0100, Christian Marangi wrote:
> On Wed, Dec 13, 2023 at 04:12:24PM +0000, Russell King (Oracle) wrote:
> > On Wed, Dec 13, 2023 at 04:50:33PM +0100, Christian Marangi wrote:
> > > On Wed, Dec 13, 2023 at 03:45:24PM +0000, Russell King (Oracle) wrote:
> > > > On Wed, Dec 13, 2023 at 11:57:28AM +0100, Christian Marangi wrote:
> > > > > -static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
> > > > > +static inline int phy_package_read(struct phy_device *phydev,
> > > > > +				   unsigned int addr_offset, u32 regnum)
> > > > >  {
> > > > >  	struct phy_package_shared *shared = phydev->shared;
> > > > > +	int addr = shared->base_addr + addr_offset;
> > > > >  
> > > > > -	if (!shared)
> > > > > +	if (addr >= PHY_MAX_ADDR)
> > > > >  		return -EIO;
> > > > 
> > > > If we're going to check the address, I think we should check it
> > > > properly, which means also checking whether it's become negative.
> > > > 
> > > > Alternatively, we could consider making "addr" and "base_addr"
> > > > unsigned types, since they should never be negative. However,
> > > > that probably should be done as a separate patch before this one.
> > > >
> > > 
> > > Maybe I'm confused but isn't already like that?
> > > On phy_package_join base_addr is already checked if it's negative (and
> > > rejected)
> > > 
> > > addr_offset is unsigned so it can't be negative.
> > 
> > True, but with base_addr being an int, addr_offset being unsigned int,
> > and addr being an int, if addr_offset is a very large number,
> > 2-complement arithmetic will have the effect of treating it as a
> > negative number.
> > 
> > So, base_addr=0, addr_offset=~0 results in addr being -1.
> > 
> > If "addr" were unsigned int, and as we've already established,
> > "base_addr" can't be less than zero because of the checks already done
> > (thus it can also be unsigned int) then we'll end up with the checks
> > you're adding automatically doing the right thing, because...
> > 
> > base_addr=0, addr_offset=~0 results in addr being ~0 (a large
> > positive unsigned number).
> > 
> 
> Oh ok... now it makes sense. So I guess I should change "addr" to
> unsigned.
> 
> Considering I'm changing addr in phy_package_shared to base_addr would
> it be ok to change that also to unsigned (doesn't make sense to have
> that int) in this patch? Or should I create first a small patch before
> this to change addr type?

What I said when I mooted the use of unsigned was:

"Alternatively, we could consider making "addr" and "base_addr"
 unsigned types, since they should never be negative. However,
 that probably should be done as a separate patch before this
 one."

so my thoughts are that it should be a separate small patch - it's a
single logical change.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

