Return-Path: <netdev+bounces-208312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D69B0AE76
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A045AA7048
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754B5207A3A;
	Sat, 19 Jul 2025 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fJpOaLhm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1B881E;
	Sat, 19 Jul 2025 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911313; cv=none; b=QKidTtUpFqm43XnbEC2ZiSNPBsDXpMREicTQarz6skp6RbK/bEoaYcP4z7dXEccEDzbGJTDJ3GP/gcGyYKAJ6Drb9siT2Kz69UBqiIltsQ3tHV5OvS0ULsv1hPiFxBbpW3428riW992jbhn32n0b6NXw57yfZZW5ZJsa4MolWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911313; c=relaxed/simple;
	bh=dOTF4TfM5DkdldHHbpLtsX+V527pvOffm6b+AAZX3J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHY2T1SUUf/nX5BbkIRwR1J6fCR5+2sVU2SZaKV8zE65sDGZ7gMFDSqrnXHdxV7hdUGJUR90nijt13OldVg7/E9X0Ke0PIFt8fEpAyXJNAsaww1/uAAGGbUs11bgzyFrCS3pdohdeko0tVO/L1HIsuX1XF6prBOGKtcKTviY/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fJpOaLhm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FcFMDElLC1w3IwQAZkIy/F9GBkkrWViENuKHPwxqZEg=; b=fJpOaLhmWJX0ZsrbDPd4EhqIDy
	TmqDsdiZGMK1CtxQJIZTEFpXBtWaSsGw8N6Khv53+I2DCoD+DVuoaJP/LazbyqQZQwEZVX/zuakQK
	5foc7Ip5F0DjB4GGliacXe8/a8oEtQGxqY51+D1NeNB3dd80S+9ObdUVxpSneplKSRHR6r3ph+CtB
	B4e16AngspEr20Eqn8yJkzj9aHSuFRy4yWj1rgh7XMz1sISMBm5GuTIFvsB3HZWTtAUeEPrGde0J6
	cfnoIoY11Ci7otdtxcx3g32BniWkXEzk4fZpO+aZXqclsO7tCaTe+uk3g+lpWiYDVcWsIN7rF7fVT
	ksKCCI5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41384)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ud2Ix-00046g-1p;
	Sat, 19 Jul 2025 08:48:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ud2Iu-000410-2o;
	Sat, 19 Jul 2025 08:48:20 +0100
Date: Sat, 19 Jul 2025 08:48:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Abid Ali <dev.nuvorolabs@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Fix premature resume by a PHY driver
Message-ID: <aHtNxLODmEHRVfdn@shell.armlinux.org.uk>
References: <aHpyDpI9PW8wPf6I@shell.armlinux.org.uk>
 <20250719062550.652-1-dev.nuvorolabs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719062550.652-1-dev.nuvorolabs@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jul 19, 2025 at 06:25:47AM +0000, Abid Ali wrote:
> On Fri, Jul 18, 2025 at 05:10:54 PM +0100, Russell King (Oracle) wrote:
> > Sorry but no. The PHY will be "resumed" from boot, even if it wasn't
> > "suspended". So the idea that resume should only be called if it was
> > previously suspended is incorrect.
> 
> > E.g. .ndo_open -> ... -> phy_attach_direct() -> phy_resume() ->
> > 	phydrv->resume()
> 
> I do point this path out and there is also a second call
> (2) .ndo_open -> phylink_start -> phy_start -> __phy_resume
> This would mean 2 calls to the PHY resume every time an interface is
> taken UP is expected behaviour?.

The whole point is this:

> > During this path, the PHY may or may not be suspended, depending on
> > the state of the hardware when control was passed to the kernel,
> > which includes kexec().

Thus, the resume function *must* cope with an already resumed PHY,
and thus adding extra complexity to try to ignore calling the resume
function if it wasn't previously suspended is likely to cause
regressions - phydrv->suspended will be clear for the initial call
to ->resume(). Thus, if the PHY was suspended at boot time, it won't
be resumed when one attempts to bring up the interface initially.

Just fix your driver's resume function.

> > PHY drivers must cope with an already functional PHY when their
> > resume() method is called.
> 
> This is not what I expected, but if it is by design I do not see a
> need to fight it. Just to make it clear, if we need to reset a PHY
> after it returns from suspend(or any code thats dependant), the driver`s
> callback should provide this guarantee?.

Hardware or software reset?

How much a software reset disrupts the PHY is PHY dependent. E.g. there
are PHYs that need to be software reset for configuration and
advertisement changes, but all the software configuration is preserved
over such a reset.

So I can't answer your question. It depends how disruptive the reset
you are talking about is to your PHY implementation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

