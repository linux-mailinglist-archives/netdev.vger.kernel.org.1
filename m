Return-Path: <netdev+bounces-238894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B34C60BC2
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 412A34E0EC3
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6952223DCF;
	Sat, 15 Nov 2025 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YTEt+d9Q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586D75809
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763242682; cv=none; b=VYMaji60AOG+CZp6duYDZ0PYUJxkLCNkl8NWzE0fG4x8ypw0U8AcptghuC+bYvFnG+bs5sLdMF8pDoKUpJ43dGsYk8c46SSzbrxS8yihfwN+AeulquJLOAOVVBRgIG5aeu0hzEOKWZUNYEqe3DqcgxnDJXt2nxH1KEd3QgP6B9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763242682; c=relaxed/simple;
	bh=G6JRxuM9z/0jb0sS+FjWV71r2IJ7KX6IbR+KD0Ndu7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7yfLhsqyg8tOoLBFtpE8FXWg9c/xzUYeHVqVmHMr3F2dq5tDn8G+P0yyT9Mh+t41wdj3W3vJGdTxf5RbxCtLyL/TeeNpY7d9XDQNj+RN86I4mVXG8tE0hjbEIr7OWBan6Ye/bDZW+iJA/mTtK/kGsmTVsgo2cTVWZpsKtYqEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YTEt+d9Q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fV/XR/ayVhz3T4nEC3nc0xxXiQ9siMQyFBX5ezYei0Q=; b=YTEt+d9Q9Ypbe0EH1lkI+iQ+uf
	MinpZYFSLxrYvyqXxtUjs7u+gQVFCDEsPX+ki1S//wq9mn/wK1Tft4XWxdfZwraPsiZaeKmMN3Jpl
	A+2fB5mUG1dWE/fVsRiHdyBKTPd0xSTaj3tURc/rhgiZp6ExpA7V9BicCreDksDMzwpxrs0mbyQcL
	96/60D7HHVhvxJv0qWy8emdQ6wOCUX/6eXp+vHU0xKJKoVMj+e66fD09bjilkJX+VI+DkrVI6img3
	LO5DpnwUzA0SkwuFz8oMJbEib21RdDgmHxoMTpSNO5piSDwYxkLiHdRtH/e3MHWHr1MxiGkxF7Q4l
	erZGLSTg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51448)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vKNy2-000000000MI-0mwz;
	Sat, 15 Nov 2025 21:37:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vKNy0-0000000077t-3UL4;
	Sat, 15 Nov 2025 21:37:56 +0000
Date: Sat, 15 Nov 2025 21:37:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Fabio Estevam <festevam@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, edumazet <edumazet@google.com>,
	netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on
 i.MX6Q
Message-ID: <aRjytF103DHLnmEQ@shell.armlinux.org.uk>
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
 <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
 <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 15, 2025 at 06:01:38PM -0300, Fabio Estevam wrote:
> Hi Heiner,
> 
> On Fri, Nov 14, 2025 at 6:33 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
> > The smsc PHY driver for LAN8720 has a number of callbacks and flags.
> > Try commenting them out one after the other until it works.
> >
> > .read_status    = lan87xx_read_status,
> > .config_init    = smsc_phy_config_init,
> > .soft_reset     = smsc_phy_reset,
> > .config_aneg    = lan95xx_config_aneg_ext,
> > .suspend        = genphy_suspend,
> > .resume         = genphy_resume,
> > .flags          = PHY_RST_AFTER_CLK_EN,
> >
> > All of them are optional. If all are commented out, you should have
> > the behavior of the genphy driver.
> >
> > Once we know which callback is problematic, we have a starting point.
> 
> Thanks for the suggestion.
> 
> After removing the '.soft_reset = smsc_phy_reset,' line, there is no
> packet loss anymore.
> 
> If you have any other suggestions regarding smsc_phy_reset(), please
> let me know.

What happens if you replace this with genphy_soft_reset() ?

Is the hardware reset signal wired on this PHY, and does the kernel
control the hardware reset?

I note that phy_init_hw() will deassert the hardware reset, and with
.soft_reset populated, we will immediately thump the PHY with a
soft reset unless a reset_deassert_delay is specified (e.g. via DT
reset-deassert-us prioerty). This is probably not a good idea if the
PHY is still recovering from hardware reset.

For reference, LAN8720 requires a minimum period of 100µs for hardware
reset assertion, and then between 2 and 800ns before the PHY starts
driving the configuration pin outputs. This _probably_ (it's not
specified) means we shouldn't be talking to the PHY for approx. the
first 1µs.

Finally, and this is probably not relevant given that the PHY works
with the genphy driver, the PHY requires the XTAL1/CLKIN to be running
during a hardware reset.

This is from https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/LAN8720A-LAN8720Ai-Data-Sheet-DS00002165.pdf

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

