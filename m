Return-Path: <netdev+bounces-216529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AA7B344AA
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEEC176A66
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3747F2FB999;
	Mon, 25 Aug 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ii8xug9m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1E2F9C29;
	Mon, 25 Aug 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133658; cv=none; b=j5fBcW3DuHRw2xYoGDUDwJSpfjD5ycQglnWhsOdq25vTOemz4Dkir/TOMDNltMu13p7gu+uC/Vt+qBw601N3X+fIxVKnejzX2aHgrAQ4X+ehUILusFqN4ahd1pgstePoYrkhvGbuiYnArmpygMO4HRnF0jvtudnZKyZ5UQ34+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133658; c=relaxed/simple;
	bh=kU5NffYo6z7siXKutRKlSBWEEkjrHDU5wEaZXOeH1qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0xX2CjsC7NdbJga9TRZCNGB5bHOp811JVcXVmmyxXpNUvfqY1Elzv9sy60jIoHONzwa2Cy+N76TwP+JXy4TnAju4DKrUeGe9SWacv67Yguh15MBhtoN70iAjgtiHE/9GmKx9hHwXenzeIjvTEQV6JLsmBMzkt2syaYPWkZxMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ii8xug9m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/MDZLJVE8OPf4cqXc8XG53ybrbOv5YqoOYJd4mZDqNI=; b=Ii8xug9mYRGJW3B9t9qms0CB1T
	D+wc3s4SyIcTmik+IEMZF5AhBGzWHP86AhexiFdDef3GZLftjCSRRMg4771nzvuhSR7qwkUDHm71p
	Oy3cYkxudhaDFccZ2aPNhyXXvwkRW1hHXQfmMxFcYWWnSayGBpRUB7BzlTRu78zRxXhZgziA8bYK0
	cbKsU+EN6YyKQ8crxjFFtiFhfbShYnhxVp3+GBWAO6tCSCjoOuMBWrJlCtxTKzC5kv3MspZ9GluIZ
	8OhbWTQBNh/dGb0av4Z6ftFzA5HG3h6Ess4ECnFvjY1zrncb7QdaERK/FE/vE3mby+u1uPvt+PoI3
	RSL2VaIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54734)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uqYaG-000000006dz-08AH;
	Mon, 25 Aug 2025 15:54:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uqYaD-000000008GB-1DUp;
	Mon, 25 Aug 2025 15:54:05 +0100
Date: Mon, 25 Aug 2025 15:54:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdiobus: Move all reset registration to
 `mdiobus_register_reset()`
Message-ID: <aKx5DX09QZcbrXA6@shell.armlinux.org.uk>
References: <20250825-b4-phy-rst-mv-prep-v1-1-6298349df7ca@prolan.hu>
 <aKxwVNffu9w8Mepl@shell.armlinux.org.uk>
 <724f69f0-7eab-40aa-84f0-07055f051175@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <724f69f0-7eab-40aa-84f0-07055f051175@prolan.hu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 25, 2025 at 04:39:12PM +0200, Csókás Bence wrote:
> Hi,
> 
> On 2025. 08. 25. 16:16, Russell King (Oracle) wrote:
> > On Mon, Aug 25, 2025 at 04:09:34PM +0200, Bence Csókás wrote:
> > > Make `mdiobus_register_reset()` function handle both gpiod and
> > > reset-controller-based reset registration.
> > 
> > The commit description should include not only _what_ is being done but
> > also _why_.
> 
> Well, my question was, when I saw this part of code: why have it separate?
> Users shouldn't care whether a device uses gpiod or reset-controller when
> they call `mdio_device_reset()`, so why should they have to care here and
> call two separate register functions, one after another? In fact, the whole
> thing should be moved to mdio_device.c honestly. Along with the setting of
> mdiodev->reset_{,de}assert_delay.
> 
> The end goal is fixing this "Can't read PHY ID because the PHY was never
> reset" bug that's been plaguing users for years.

I wasn't asking for an explanation in reply to my comment. I was
telling you that you had to do something to modify your commit message
to make your patch acceptable.

Now, I could nitpick your "because the PHY was never reset" - that's
untrue. The common problem is the PHY is _held_ in reset mode making
the PHY unresponsive on the MDIO bus.

If your goal is to fix this, then rather than submitting piecemeal
patches with no explanation, I suggest you work on the problem and
come up with a solution as a series of patches (with commit
descriptions that explain _what_ and _why_ changes are being made)
and submit it with a cover message explaining the overall issue
that is being addressed.

That means we can review the patch series as a whole rather than
being drip-fed individual patches, which is going to take a very
long time to make forward progress.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

