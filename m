Return-Path: <netdev+bounces-178355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4CA76B8F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3065F7A38AD
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706A21147A;
	Mon, 31 Mar 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R3wW+UyG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC524685;
	Mon, 31 Mar 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437071; cv=none; b=WGX2/XVsXCYhck1m+vBx4h8ZI9ZLVVW1pwkcAVG5Tu7foDNYOm32C84GsvwIIND7s5H0HvxEbJdoeKOa7v8Uqua0dKOAJfJPMd+VO+rlk0xVM+CeX1/YAbw2faCNWZhqDFatMvN1u/9JJT6+YJ7e0Z1MzjmAfHTY1i+zFT+/wrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437071; c=relaxed/simple;
	bh=vht1Iberwe9SEyQjA0RuxdyfISFNIXIpFNZGxlXVcus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHgsU9x9BuL67+GYuqaBmGF/1njoj/ROrkJ3CNFHUpiFqQ3gKRFLh7o5sU0XRTLJqAURxJ/7/80L1fYvV859st9gZUopqmAqRmwdIchyI3jKjW0MjbkXtz0fHgqV+bBHCmwaD3QlG0Uvj7XFE0wGTwdxgB9TVy1a4niy0bOQXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R3wW+UyG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9xQnbwDVP7S4C3Pg6DpMBzM5zbf4kbUH15XLw0VYsiM=; b=R3wW+UyGPRxQyDU30WQTd4H2NZ
	tjl/pUEKpKD3SpcaPR/G03YMsmfFJ7Jg0ArMe2ZV2ttweyzPR3sTwcfLyvt+AXfDalAuiDiKNa9es
	R64Kw23zn/qWmD1fTdckcJSbj29wJ45yHmjBP9Hw7b6XqQepR4JtLLNUi90pfEDpeIvB02dRObzvW
	qJajwwdAs+/nxZ0oTZCPZ+ZnK5Tj9e07Nfj5PISMKLS/EzuAj6JiGvWWwmklRWAXEVDaEw7IXFHAB
	gx6p5n3dBdCgL/oB6wtnGv0AujkioCNtjyWTjYIC+eUIkCtTYBCIoYg9TTFNY+HVhu8q7uLgwdF1t
	pcv6o4jQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36008)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzHce-0004Nz-15;
	Mon, 31 Mar 2025 17:04:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzHca-0001o1-2f;
	Mon, 31 Mar 2025 17:04:20 +0100
Date: Mon, 31 Mar 2025 17:04:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: lynx: fix phylink validation regression
 for phy-mode = "10g-qxgmii"
Message-ID: <Z-q9BCY9MUzLv-LE@shell.armlinux.org.uk>
References: <20250331153906.642530-1-vladimir.oltean@nxp.com>
 <Z-q44uKCRUtWmojl@shell.armlinux.org.uk>
 <20250331155436.zmor5g3h67773qcc@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331155436.zmor5g3h67773qcc@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 31, 2025 at 06:54:36PM +0300, Vladimir Oltean wrote:
> On Mon, Mar 31, 2025 at 04:46:42PM +0100, Russell King (Oracle) wrote:
> > On Mon, Mar 31, 2025 at 06:39:06PM +0300, Vladimir Oltean wrote:
> > > Added by commit ce312bbc2351 ("net: pcs: lynx: accept phy-mode =
> > > "10g-qxgmii" and use in felix driver"), this mode broke when the
> > > lynx_interfaces[] array was introduced to populate
> > > lynx->pcs.supported_interfaces, because it is absent from there.
> > 
> > This commit is not in net-next:
> > 
> > $ git log -p ce312bbc2351
> > fatal: ambiguous argument 'ce312bbc2351': unknown revision or path not in the working tree.
> > 
> > Checking Linus' tree, it's the same.
> > 
> > Are you sure lynx in mainline supports this mode?
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> Oops, you're right, please ignore me. I was working on a rebase and I
> didn't even think to check whether the driver support for this new PHY
> mode wasn't upstream. Now I'm starting to remember how the QCA8084 also
> required it, and Luo Jie upstreamed the core support without users, and
> without the Felix driver patch.

Oh no. A feature merged that didn't get any users, which happened six
months ago. :(

Can we please have a user of it in mainline soon?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

