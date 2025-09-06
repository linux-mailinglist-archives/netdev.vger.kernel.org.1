Return-Path: <netdev+bounces-220564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE93FB46950
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 07:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01B65C3A2A
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 05:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6269321D5B3;
	Sat,  6 Sep 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Pc2NVmAH"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280D4C85;
	Sat,  6 Sep 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757137047; cv=none; b=imAE6qiEqoMBaIOYYUgJRBgSMnNmzeD0YFPbKytfpLA7lORHa75CcHUkful5htmOm4g/Z25NmZqsBlkI4OzWSl41qqfV/bWXoyJQtQQUQLRm1em1iVi5xPLvMzoXS2a7GnU2QZ0csuBpJrXd3l2cZ+A9CEpoDJ6SN3/XGjqvJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757137047; c=relaxed/simple;
	bh=wI0wevMGuuWRJUTVju5J6qPVfzuWW/OeRDSlbWe/Uh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIAQyWojnGclqHI9U76zImf2yAw7OLUo3uN9Wf7Yw0Ph/V8251g3l5M167e9vcBYl6MUenIr/dh9EB8zoZcfxJqg8hRZ5b8o0fB3fmPoHEFSjQW4Y8bDXTWAkIWyrb8HK+/jmgOSczCNRt70eKc2s1yWGzbuRBFvooAaTWF5mN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Pc2NVmAH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 46ADD22FBA;
	Sat,  6 Sep 2025 07:37:16 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FNfilUzRkkX6; Sat,  6 Sep 2025 07:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757137032; bh=wI0wevMGuuWRJUTVju5J6qPVfzuWW/OeRDSlbWe/Uh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pc2NVmAH3A/h9UswdB5Zwb7wYJRw31J3IXwZrZenSw6QoBmAZjI9ibSO87/kEIUul
	 iOdnSjO6Z0bsB+GdZ6UoCpWjTiR9pSIrcArMD5vKSJb1p2CZaAT7RkkyBMKBKGE8KC
	 xd2WxeZRmwFeZ74F+BPLS20j5S3TKMJcRCpw1UWpy59Jy/KwIEbtVXyg0TRskhvAF8
	 huq5kEpgVs3MUnfIw5rZvp3NMPruOWqRQ/SYYyBgSHweaWEqtoIyXshIvFG7TPdS4O
	 yeGlodGUv6jA2Kn6l1JlIZOimbrshSbsWBpJ/qGpge5h/cCfshgQNuoaKII4OZ0xeF
	 xu+8C5lL2LBbQ==
Date: Sat, 6 Sep 2025 05:36:44 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <aLvIbPfWWNa6TwNv@pie>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
 <b5fbeb3f-9962-444d-85b3-3b8a11f69266@rock-chips.com>
 <aLlyb6WvoBiBfUx3@shell.armlinux.org.uk>
 <aLly7lJ05xQjqCWn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLly7lJ05xQjqCWn@shell.armlinux.org.uk>

On Thu, Sep 04, 2025 at 12:07:26PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 04, 2025 at 12:05:19PM +0100, Russell King (Oracle) wrote:
> > On Thu, Sep 04, 2025 at 07:03:10PM +0800, Chaoyi Chen wrote:
> > > 
> > > On 9/4/2025 6:58 PM, Russell King (Oracle) wrote:
> > > > On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> > > > >   	if (plat->phy_node) {
> > > > >   		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> > > > >   		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> > > > > -		/* If it is not integrated_phy, clk_phy is optional */
> > > > > +		/*
> > > > > +		 * If it is not integrated_phy, clk_phy is optional. But we must
> > > > > +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
> > > > > +		 * the error code could be wrongly taken as an invalid pointer.
> > > > > +		 */
> > > > I'm concerned by this. This code is getting the first clock from the DT
> > > > description of the PHY. We don't know what type of PHY it is, or what
> > > > the DT description of that PHY might suggest that the first clock would
> > > > be.
> > > > 
> > > > However, we're geting it and setting it to 50MHz. What if the clock is
> > > > not what we think it is?
> > > 
> > > We only set integrated_phy to 50M, which are all known targets. For external PHYs, we do not perform frequency settings.
> > 
> > Same question concerning enabling and disabling another device's clock
> > that the other device should be handling.
> 
> Let me be absolutely clear: I consider *everything* that is going on
> with clk_phy here to be a dirty hack.
> 
> Resources used by a device that has its own driver should be managed
> by _that_ driver alone, not by some other random driver.

Agree on this. Should we drop the patch, or fix it up for now to at
least prevent the oops? Chaoyi, I guess there's no user of the feature
for now, is it?

Best regards,
Yao Zi

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

