Return-Path: <netdev+bounces-173462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82AA590CD
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDE4188EA1A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C0225413;
	Mon, 10 Mar 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FqsZU7h4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50672248A8;
	Mon, 10 Mar 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601510; cv=none; b=WlRmj74Z505FQtCX0U3xAb9FWXx+r0KTc+SM+NxtRzEt3esqd0Y3f+VZMd3uwVzMmrEnZ5gIuLJ0vPEPIY8X1ZjxgGFozp6B98RlPfbkoL5dlS6/s2ZnLRUGsrrcywumN81wFUhGsYeg5BaV9V2OZauCuAPlGbPnjphaE/4g/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601510; c=relaxed/simple;
	bh=S2CAI/GwCWwg1zpG0amZRD2jcsE02Fs8i/iVqiK1tmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IppMduDZaBDnnzMKlw6qsOv5JakmVAlzqsw8iv3KKyeCZb9apmJm9EVD+N64nFNeFwV8HQA8z4rQC2iBCuiTKrTpZXb4cMHTdcsKHpjNCFEvb90elgFJE0K6e143E2d7J8KTQRnB+VafKF4jUKgC5xOFEhkcM4v5LGChwdpat/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FqsZU7h4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=65ElcLaZXauxRclZo3e6HBBHjana+/mlWD2Luml/jxU=; b=FqsZU7h4CqwEIbzGsqc7lXV4xk
	ctKf+8scSkmTeuYEGWDrDgzdWqopyOX9zZjoE7wlFTuD8Xp96jrvSeDN25kku5A9AOKPotIEsdIk/
	ubL+/4sQBytzg4hPGloN2nbEgvg6CkE4o6p7ADKXW9SkFQeUoHsKTd+7ebJXiSgGqNhkTbPM1YIiJ
	khHA5+3DCRMzv7jsbHamDI+QGpDE+B/I5yctI7j6DSvf5jdexXkFNAYPR8x+pkOb98P9j+Ov2HGhp
	yuxQCJXXTbOYo4eQwlFQDqyd3RTmREGCLpdvyNse1UL/EwyCG6uBH3miJUGvbNXc8qghT1CIBf5Jh
	4jbL0dsQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43554)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tra6f-0002Mc-0j;
	Mon, 10 Mar 2025 10:11:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tra6b-0002NY-2M;
	Mon, 10 Mar 2025 10:11:29 +0000
Date: Mon, 10 Mar 2025 10:11:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thangaraj.S@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	Rengarajan.S@microchip.com, Woojung.Huh@microchip.com,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	phil@raspberrypi.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z8660bKssi3rX_ny@shell.armlinux.org.uk>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
 <20250307182432.1976273-2-o.rempel@pengutronix.de>
 <1bb51aad80be4bb5e0413089e1b1bf747db4e123.camel@microchip.com>
 <Z863zsYNM8hkfB19@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z863zsYNM8hkfB19@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 10, 2025 at 10:58:38AM +0100, Oleksij Rempel wrote:
> Hi Thangaraj,
> 
> On Mon, Mar 10, 2025 at 09:29:45AM +0000, Thangaraj.S@microchip.com wrote:
> > > -       mii_adv_to_linkmode_adv_t(fc, mii_adv);
> > > -       linkmode_or(phydev->advertising, fc, phydev->advertising);
> > > +       phy_suspend(phydev);
> > > 
> > 
> > Why phy_suspend called in the init? Is there any specific reason?
> 
> In my tests with EVB-LAN7801-EDS, the attached PHY stayed UP in initial
> state.

Why is that an issue?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

