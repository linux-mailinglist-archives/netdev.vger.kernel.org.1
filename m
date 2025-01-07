Return-Path: <netdev+bounces-155875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C235CA0426F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23CC168A78
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B301EF08A;
	Tue,  7 Jan 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UqQqARgM"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDDC1EB9EF
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259837; cv=none; b=NvuLo2jd9xNq0GLqV+E8JrZHuLVIZ4LP0lVZWwtdmbyDXVXUbHsH6HvmeCzS6hyBkPZWf4T5QISjtNEcP865kjyzPShnZyxnxcaMfg+sIQ1DtYOEwaJNnT81gWdDINqAKilSWqfZ9I0Notzei8RyJq5X6+7SiUg4blUtO3p7u7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259837; c=relaxed/simple;
	bh=jwR7Bkzv9Hf4HEgntDuQl3JIpUp9H7lXZLE/KHwYcig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=re6WIhTUWP6VJmLCf2Zxeu9nTGwLt3+ebQmGRd8cVqz1sS7LzqQ0E9qp9/RXrlxIXiyqoGSjNTJDUxfDLFA4DF4CLcklB0FP/sGtiDD4SoQcGZYcL/FQkmdK1ubJtipD0kyFZQYe9j4U/hmA/jakwbg1qFay21KjMgnah8DSQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UqQqARgM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03D1E240002;
	Tue,  7 Jan 2025 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736259827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A82lxYyhSD5ChdUVhMeGsq5U/lXEl+8Tc1PjYUQHda0=;
	b=UqQqARgMR/kfteTsO+1UbznFhlQgK3n7fgTlg0atANm8moCe9gC5H/ou8al40SuRdTsNnb
	5UHQu8fWWW8IXCjy0hTJ5QV6UZbML9Y4T5ZviV4WSoGpho3WCEcvZz0Lp/5sSY6+1BAntg
	crn0bwZAY/P8U7dpLSPPrfF6fzUxJBl9zOabyJRTcbzOcc85DDKPflGZEAcpIAW8tvUMdH
	AK2fuKq6Gxn1ANa9Fa8iPF9LEdUN8eyIcf8h1rmrdHhq4xgIIjfPx5KWxK5crzd7ZP3kZj
	7XmUZ8LHvNdso/bvsO+DQdthAYnJLbx1xJ82vNf8FvyovoYqEB1f286Xp0iPIA==
Date: Tue, 7 Jan 2025 15:23:45 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net] net: phy: fix phylib's dual eee_enabled
Message-ID: <20250107152345.6bbb9853@bootlin.com>
In-Reply-To: <Z302oI--ENXvPiyW@pengutronix.de>
References: <E1tBXAF-00341F-EQ@rmk-PC.armlinux.org.uk>
	<20250107144048.1c747bf1@bootlin.com>
	<Z302oI--ENXvPiyW@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Tue, 7 Jan 2025 15:13:52 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Jan 07, 2025 at 02:40:48PM +0100, Herve Codina wrote:
> > Hi,
> > 
> > On Thu, 14 Nov 2024 10:33:27 +0000
> > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> >   
> > > phylib has two eee_enabled members. Some parts of the code are using
> > > phydev->eee_enabled, other parts are using phydev->eee_cfg.eee_enabled.
> > > This leads to incorrect behaviour as their state goes out of sync.
> > > ethtool --show-eee shows incorrect information, and --set-eee sometimes
> > > doesn't take effect.
> > > 
> > > Fix this by only having one eee_enabled member - that in eee_cfg.
> > > 
> > > Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/net/phy/phy-c45.c    | 4 +---
> > >  drivers/net/phy/phy_device.c | 4 ++--
> > >  include/linux/phy.h          | 2 --
> > >  3 files changed, 3 insertions(+), 7 deletions(-)
> > >   
> > 
> > I observed a regression with this patch applied.
> > 
> > My system is based on a i.MX8MP soc with a TI DP83867 ethernet PHY and was
> > working with the kernel v6.12 release.  
> 
> Which ethernet interface is used on this system? FEC or stmmac?

It is the FEC (ethernet@30be0000).

> 
> Is it the correct PHY?
> https://www.ti.com/product/de-de/DP83867E

Yes, it is this PHY.

Best regards,
Hervé

