Return-Path: <netdev+bounces-168083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8EA3D4E9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F5E17B8AC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284C31F03CF;
	Thu, 20 Feb 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EWigDSfe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564E1F03C0;
	Thu, 20 Feb 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044233; cv=none; b=tjVBuTg6FCwpvrZBIJUHAGC1vpgS8jRr63okakyu15OqMVz0TH4vue37G7U7u0uyzy4hFjwxMDIYRiFIiYmP/hlq/073qyTkVYcxhLSxgg0AFP63NAPZDnmIqxotzkqIhPPg/8MzOmRzfmUtWV0yapV/UFEbnBimgd9Q3WdbmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044233; c=relaxed/simple;
	bh=vCuWbxJpcKdKcAOe66DlD/TFiXV9c8xBVuKcplE64B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHhhheURehTYz3Ukug/u7T6g39fphz6zfX+a7yfeQWJYUPQFvlRQmAfbt9LvL27juKjhB+P8zLNoxRoVt3wNhSWekmZIqEsIDGloH6BFwweqiv/ff5V41EnNYaoFdahLkVp53/FnLN+EVKsFGcplLSYQeKT5urtwcdGSW0J8UXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EWigDSfe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=phIkeiMZbtKUkz8zihSHcjuzyHiG/Jl1jNrls12kH7c=; b=EWigDSfeke3Is6poNt82ic9DKy
	LhGt4BFhdRKjrhFXh61yP1/4ws6LRKr4izRndhA0qKS+JgDlCWSxoO1OPzUX4zx0A083kHiPMgLrx
	NqEa9T0gE32L8XAw9IXMcBGwO3tXZcEkqLHyMRrQnSBoa4dCEUuYpAI1BYgx3AhApmVftBylYbRNR
	1AHhF8PD6tTrkK4SdlMUI7xzbJyjjrxbwvF6tmCfDejTMxms3UAmWrJSfKTtib6WkKw956FV8FlXb
	fvZzSHHgQjRi0VkiPQnUywi43pPXqs42QQQJnYR4uc+2GESkLu5bKF31Cy9yD2VI3+gW6fFOP1Nv6
	7OfYuSjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38750)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tl2zF-0000Vk-2E;
	Thu, 20 Feb 2025 09:36:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tl2zB-0000rj-36;
	Thu, 20 Feb 2025 09:36:49 +0000
Date: Thu, 20 Feb 2025 09:36:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: marvell-88q2xxx: Prevent hwmon
 access with asserted reset
Message-ID: <Z7b3sU0w2daShkBH@shell.armlinux.org.uk>
References: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
 <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-2-78b2838a62da@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-2-78b2838a62da@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 20, 2025 at 09:11:12AM +0100, Dimitri Fedrau wrote:
> If the PHYs reset is asserted it returns 0xffff for any read operation.
> This might happen if the user admins down the interface and wants to read
> the temperature. Prevent reading the temperature in this case and return
> with an network is down error. Write operations are ignored by the device
> when reset is asserted, still return a network is down error in this
> case to make the user aware of the operation gone wrong.

If we look at where mdio_device_reset() is called from:

1. mdio_device_register() -> mdiobus_register_device() asserts reset
   before adding the device to the device layer (which will then
   cause the driver to be searched for and bound.)

2. mdio_probe(), deasserts the reset signal before calling the MDIO
   driver's ->probe method, which will be phy_probe().

3. after a probe failure to re-assert the reset signal.

4. after ->remove has been called.

That is the sum total. So, while the driver is bound to the device,
phydev->mdio.reset_state is guaranteed to be zero.

Therefore, is this patch fixing a real observed problem with the
current driver?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

