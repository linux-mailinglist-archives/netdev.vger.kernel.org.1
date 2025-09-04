Return-Path: <netdev+bounces-219888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337A7B4398F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9081B281DE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702E2FC886;
	Thu,  4 Sep 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lEWSoEye"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE695EACE;
	Thu,  4 Sep 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984056; cv=none; b=D72pPbhEDuWKS/RGwW0jvh5woy9as3stWgOkfbumkIR19T9zlq0fGy1hoGh681oeVvIOgmdIZkekm+YpES0r6EFsZHcYY/KqylN/bi2/F2PvM9+dqsX+/98H05a46m1Mem3FYI5xxV5CNg91HTOvlRZXEblVhNTBqAJcz7CIoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984056; c=relaxed/simple;
	bh=7dp7b7mY12c/B3coKnSVOPbX3Q9juVts6oIBbdGtT0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZDXQjuwZ+cG0bCncTHnz0Z4L9Hce6sZxFNVpkvbxJgd5hjicLBimhG12VMbN2C48UktMhR6NgzNlCrgRcg1uofJHSBPnCk6g/VhDqgXXS0Uk5/j1cU1xanYlNkp8sIX8nhjtvx2oroenvR7cHdWJ7OgLDJAJwBeQedinfZ4qNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lEWSoEye; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hhNQHJCCEEIbETm8PsRs80LMVSc5JQABFf4Nlp+TIXg=; b=lEWSoEyeyy0AyBUXEFyFioY2Qr
	5ViAolylKJpUMXiqgDYZoq8Q2U5vNy3IYHQiNtDaLOL63OeTSyPUN/fZ58GNpOsaL59AcrLDG1GkW
	4wl4fHb07tolpFqA/OQnNgJqcy4MiF54oENi78ThqDzJrDdEWjk8t+h2hUflqJ2Fhj9uVqfP2k7lr
	C06yWvlC9kho/WlJKl5pyaT7G6AAavlFJksygtaEGJRIhnQgZBdcdkQLvtFLVB3P7g71C2ECvU3oQ
	luqQbLl1fCFMiMjc9FsaQy3lb7KEPPDAz769ltbrReVkWXzsRbf6vBWCoJ5BnppVbbt+P82sEeHz5
	t4bXFjbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45246)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uu7oN-000000001s7-3uL3;
	Thu, 04 Sep 2025 12:07:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uu7oM-000000001SM-3QdA;
	Thu, 04 Sep 2025 12:07:26 +0100
Date: Thu, 4 Sep 2025 12:07:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <aLly7lJ05xQjqCWn@shell.armlinux.org.uk>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
 <b5fbeb3f-9962-444d-85b3-3b8a11f69266@rock-chips.com>
 <aLlyb6WvoBiBfUx3@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLlyb6WvoBiBfUx3@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 04, 2025 at 12:05:19PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 04, 2025 at 07:03:10PM +0800, Chaoyi Chen wrote:
> > 
> > On 9/4/2025 6:58 PM, Russell King (Oracle) wrote:
> > > On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> > > >   	if (plat->phy_node) {
> > > >   		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> > > >   		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> > > > -		/* If it is not integrated_phy, clk_phy is optional */
> > > > +		/*
> > > > +		 * If it is not integrated_phy, clk_phy is optional. But we must
> > > > +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
> > > > +		 * the error code could be wrongly taken as an invalid pointer.
> > > > +		 */
> > > I'm concerned by this. This code is getting the first clock from the DT
> > > description of the PHY. We don't know what type of PHY it is, or what
> > > the DT description of that PHY might suggest that the first clock would
> > > be.
> > > 
> > > However, we're geting it and setting it to 50MHz. What if the clock is
> > > not what we think it is?
> > 
> > We only set integrated_phy to 50M, which are all known targets. For external PHYs, we do not perform frequency settings.
> 
> Same question concerning enabling and disabling another device's clock
> that the other device should be handling.

Let me be absolutely clear: I consider *everything* that is going on
with clk_phy here to be a dirty hack.

Resources used by a device that has its own driver should be managed
by _that_ driver alone, not by some other random driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

