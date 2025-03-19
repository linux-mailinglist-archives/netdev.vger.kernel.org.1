Return-Path: <netdev+bounces-176218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11238A69620
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC04165BBB
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1D1E8323;
	Wed, 19 Mar 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BnEE45AP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE71DDC36;
	Wed, 19 Mar 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404440; cv=none; b=p66ZKlbeNZWvbMp+Mk6jDESL6czC/AEe+VjonMjys91jje7e2SHGOcqN0/0EhAJHsGKdPJ+ThfXKsrSloRG73hjbm28TBwwrh4fY9aw6vE5zXy4Us2+exTch2Aa8wIqELHxG6oP9CiHK67cztHKdFUQgQr8iQJ8g1g4iCRO0ePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404440; c=relaxed/simple;
	bh=wAQQse1JJ2NrTswaol+dHctLRt+H6YYb1Y+zzArtGvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpEWGwiy+dfWh+s9gTe3+vCHw7Ape/1rBaKbg9QE4KMpuoQmprey++0yXMtqCYYsxorcIzS0N7c8lxeVHVTzB6huO2fFYvBIHzxaVI/JEl0URvu/Gn9jXnLjyKBgLnpO3pUKjMoi3qCeB/9ghUgGxjfL9TFciISNyJIRuh+vAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BnEE45AP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pI17Q4nNlTm+hhSsaQohyNStV7Ae92pJPOoQhC5orr0=; b=BnEE45APQwPLklTv+eKyR7FAA5
	SJ57khjn79weVrVU4W/lIe3bRI0hAvSAbRq7iVDDWS3KFOB0MjyTaZAM9Ethxj469sFl4RufLdg2l
	2b/CI/yCV9l8zRP1ZrVS2MM7Q7Tg0ii47AoLbDoOT2tC02xhMfXQahO4PcTQvvCS/NRU2BsWM+//c
	HUI3CspJkIi2cmi/vBQ+7o/Ka0NCKKFI+SEOYMWRjFVtP8jrlxh7VGpo/NxmXp2mWvCC0DWAWoPxR
	X0ls9cAn/VSSor4/NuQrdg0LLj4zRqyEs7G74SKFRhADDBMX+N1zjcU2g3AXVDZHKCpPNp+HzL1yk
	norqMC9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59960)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuwzL-0006ih-03;
	Wed, 19 Mar 2025 17:13:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuwzJ-0005n7-0O;
	Wed, 19 Mar 2025 17:13:53 +0000
Date: Wed, 19 Mar 2025 17:13:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v2 2/2] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <Z9r7UPJUJ_Ds6n-6@shell.armlinux.org.uk>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
 <20250319105813.3102076-3-andriy.shevchenko@linux.intel.com>
 <Z9rYHDL3dNbaK9jZ@shell.armlinux.org.uk>
 <Z9rvXilnPCblbfIv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rvXilnPCblbfIv@smile.fi.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 06:22:54PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 19, 2025 at 02:43:40PM +0000, Russell King (Oracle) wrote:
> > On Wed, Mar 19, 2025 at 12:54:34PM +0200, Andy Shevchenko wrote:
> > > -	char phy_name[20];
> > > +	char phy_name[MII_BUS_ID_SIZE + 3];
> > 
> > MII_BUS_ID_SIZE is sized to 61, and is what is used in struct
> > mii_bus::id. Why there a +3 here, which seems like a random constant to
> > make it 64-bit aligned in size. If we have need to increase
> > MII_BUS_ID_SIZE in the future, this kind of alignment then goes
> > wrong...
> > 
> > If the intention is to align it to 64-bit then there's surely a better
> > and future-proof ways to do that.
> 
> Nope, intention is to cover the rest after %s.

Oops, I had missed that MII_BUS_ID_SIZE is the size of the "%s" part.
I think linux/phy.h should declare:

#define PHY_ID_SIZE (MII_BUS_ID_SIZE + 3)

to cater for the ":XX" that PHY_ID_FMT adds.

So the above would become:

	char phy_name[PHY_ID_SIZE];

I wonder whether keeping PHY_ID_FMT as-is, but casting the argument
to a u8 would solve the issue?

Maybe something like:

static inline void
phy_format_id(char *dst, size_t n, const char *mii_bus_id, u8 phy_dev_id)
{
	BUILD_BUG_ON_MSG(n < PHY_ID_SIZE, "PHY ID destination too small");
	snprintf(dat, n, PHY_ID_FMT, mii_bus_id, phy_dev_id);
}

would solve it?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

