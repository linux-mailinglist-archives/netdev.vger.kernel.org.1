Return-Path: <netdev+bounces-208331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88BDB0B0A1
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 17:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B331AA2197
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CA96EB79;
	Sat, 19 Jul 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e0N9W+k1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8A881E;
	Sat, 19 Jul 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939167; cv=none; b=GPky4OqIrUSUYhJzAGg/GJ6lbuRELuOO+sibyfZOm+AM5k3ylgAqxFFzY6QhKGoEP48XCNOnEBJa3AknAwzVXwyAQE5yf6amrrXImkJyp1t46vZ8H0WDGZvt7gKV1ArxhTTWuG2iKswvHC5L1AYtfBnxJKuqIwdXTMJ7H5UvYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939167; c=relaxed/simple;
	bh=NowXulcDyhLjvzO8P4ocT6rsCzUOJjJShXip+oT1o80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFLj9TWufCLAZ/OS+vQfU680XN5vDse6gPSW5Vz10vGsQ9h2daSvQYKZer4beV4/vRMOF7sVCWcVyi2/03HwIj6ZIXq19SUorsccJazFxbdYdx0NKYo5/nT/Kf9bp+EY0vCbiiDRPOFJ0YreFUFz/BsammpKcBmDEs8fJJDNcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e0N9W+k1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MtfWON3kDQoM6dS1kLPkqz9QkAisiUnLOBjGND3FEJQ=; b=e0N9W+k1h0aXygjkBeAS61wQng
	4ZhrHsopcFkTMkSASynwneiTcl/SiF1DQ0ytKlKTcl4hb3C+gmAjQVl5L6jA1rGiaNdg4Le2w7nBC
	eWFNg9um1iAXx022j4iJvZarPMYTEF9OOoaYPNWd9C2WMHwNPjz5IwgO3mgN898XLmpuhTbl2QOlH
	JFLHqz4TUC5ES3iBriyfohZncysqCudh/4Q/Gr+04bvhd2HnYZJ7jn27eLdtBQtKNVB7TCs6TwYZ3
	s0QJNE+kZo90mPB9s7peNz7CSxRvCDgMQdRUDzaPEpdM1xCyEuQqcyyNAG0AyIZMwlNdLExvKNwsJ
	eyrt8MCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36746)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ud9YE-0004TM-1q;
	Sat, 19 Jul 2025 16:32:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ud9YB-0004HL-34;
	Sat, 19 Jul 2025 16:32:35 +0100
Date: Sat, 19 Jul 2025 16:32:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Abid Ali <dev.nuvorolabs@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Fix premature resume by a PHY driver
Message-ID: <aHu6kzOpaoDFR8BM@shell.armlinux.org.uk>
References: <aHtNxLODmEHRVfdn@shell.armlinux.org.uk>
 <20250719113452.7701-1-dev.nuvorolabs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719113452.7701-1-dev.nuvorolabs@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jul 19, 2025 at 11:34:50AM +0000, Abid Ali wrote:
> The PHY we have loses power when the kernel PM goes to suspend and we
> need have a hardware reset upon its bootup in resume.

Other PHY drivers are fine with this.

> As an unintentional consequence this ended with 2 additional
> resets (reset-delay-us in dts + 2 PHY resume) at boot->interface-UP.

Presumably, the resets occur because your PHY driver (which phy driver,
and are the patches for this merged?) is causing the hardware reset to
occur?

> In the end the "phydev->state" in the driver`s resume callback was used to
> prevent it and checking further, it was evident that there were 2
> intentional calls for phy_resume from .ndo_open which didnt look obvious.
> 
> This particular scenario was not the point of the commit but rather
> having some protection for phy_resume but I guess its not possible.
> To keep it simple, these would be my present understanding.
> 
> 1. Should the PHY driver be able handle consecutive resume callbacks?
> a. yes. It would have to be taken care in the driver.

Correct, but I think we need full details.

> 2. Why does phy_resume exec twice in .ndo_open with PHYLINK API?
> a. can happen but still dont have clarity on why .ndo_open does this.

Nothing to do with phylink. Exactly the same would happen with drivers
that use the phylib API, attaching the PHY in .ndo_open and then
calling phy_start(). Phylink is just a wrapper around these.

The problem I have with the idea of changing the behaviour in core
code is that we can't test every driver that is making use of phylib
(whether directly or via phylink.) It would be a monumental task to
do that level of testing.

So, if there's another clean way to solve the issue, I would much
rather that approach was taken.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

