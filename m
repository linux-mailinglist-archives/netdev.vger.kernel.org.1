Return-Path: <netdev+bounces-211340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB273B1815E
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B00A833F4
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D151E5B9A;
	Fri,  1 Aug 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eflKgEa4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDE6F2F2;
	Fri,  1 Aug 2025 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049517; cv=none; b=XgGVp4Ii2Hg0HQUKFs+rH2IWHn7fB0XtC47rYbphSEk/uJaKLGcCfrPmvSiPLH//VfkW+ryZQOELieexuLdznytWsCcWLIzUGLtzTHFEbLmTvho8KxeCyju4x512c4Hh6N/shxvs5z9AEaN5VNUbPqrnWpwoY5O5ODy4y8/wY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049517; c=relaxed/simple;
	bh=pA8N/TTX1WCGVc1IBITzHRNGif+57V+aW56voZbdrbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnM0oT3b2mNt3GBT2NRa6XJmt4/nbdcG6xmXo+UtnwJq/cvoEEZLGeAL/asJd+HvzU2U8tonF1kRCYPRsuo0ewd4N3liHaxSegT0NK20VD7RZGtzSQ0OfUBKRHraui8S8UzOjAUPc029MFqjY9sW0D3jUrxzn6crKh3Zq2ktLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eflKgEa4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D5KPU80E4H2T7rI9jz2XF0ZixdePau7LRr3FpNQNO2Q=; b=eflKgEa4orYoa1pE+odu395rCl
	Kik4463ZzXUnTbmGBs40ufQy8FVCKZplTMVvI1/1H68Qkb2bGHzcEwabuL8faKfycRigZ6zY3oCYZ
	0vV/jVIDPxY69OMUCtOoSqUxqe+OueW7pEnZtY72opfuR2+p3C8YPqyffDrgl6TB9SfKtn1fYPP90
	XdfVcTZpxE6TUTIcQKsVPaIKkeWMurMetnZDGiGZl0pylK577mA5hBK4tEU6SwRDWhoMWmvuWxGo7
	0repF3cCMlIylNvq434dXAZqcndGZ3c2aHasbEY7euBhpwIhPG260yTonisUvlKC4Tj2LLSJvdY2v
	nQkmxd4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34982)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhoP4-0006RN-2D;
	Fri, 01 Aug 2025 12:58:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhoP1-00022U-2E;
	Fri, 01 Aug 2025 12:58:23 +0100
Date: Fri, 1 Aug 2025 12:58:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
 <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 01, 2025 at 01:54:29PM +0200, Alexander Wilhelm wrote:
> Am Fri, Aug 01, 2025 at 02:01:06PM +0300 schrieb Vladimir Oltean:
> > On Thu, Jul 31, 2025 at 08:26:43PM +0100, Russell King (Oracle) wrote:
> > > and this works. So... we could actually reconfigure the PHY independent
> > > of what was programmed into the firmware.
> > 
> > It does work indeed, the trouble will be adding this code to the common
> > mainline kernel driver and then watching various boards break after their
> > known-good firmware provisioning was overwritten, from a source of unknown
> > applicability to their system.
> 
> You're right. I've now selected a firmware that uses a different provisioning
> table, which already configures the PHY for 2500BASE-X with Flow Control.
> According to the documentation, it should support all modes: 10M, 100M, 1G, and
> 2.5G.
> 
> It seems the issue lies with the MAC, as it doesn't appear to handle the
> configured PHY_INTERFACE_MODE_2500BASEX correctly. I'm currently investigating
> this further.

Which MAC driver, and is it using phylink?

phylib doesn't know about rate matching, so either you need to replicate
much of what phylink does, or make sure the MAC driver uses phylink.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

