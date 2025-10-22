Return-Path: <netdev+bounces-231821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B993EBFDCEC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3838318C87D7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D859F34320B;
	Wed, 22 Oct 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KRV2gabI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF61EB193
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157413; cv=none; b=Lyd13AXa3+oA3zVhGMiBoAmqsogZQ/qKrFnY0DIAMVUVQCxffFecgOZ0+jMecEKow3FbI3f8mLixHf+lWnLinqRpeLNG5q46rUM8tp2yKAquZxI6YFzfNxXkVYjBnd3wiJSPYg2cMg51BBwL229HzDGu9NNeRDFlDO5ucYbtMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157413; c=relaxed/simple;
	bh=atBMO1Se5Y2n/HQNiT0O0qKX37XjiOlC8/ZPayU26jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5mtCbi6N/qp4JwvNxBcjdU8m/2BiOGRr7M1eJf0L7dx8bNYQY0vToi+CZHwUb0ntpaHaZUMHVXV4FwE8ADHwoXwRoRL81dIVt0KtAq34lpyQ5W1BTJyFKf2m4uCiwIl6K+ZYJ5gAhYVuCrYxf1Q+ZtWuyg4l6BpFjQEzBZJhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KRV2gabI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kt5HidSb6xkRGWxoBaNt52wPsH3u1Zf7gYVwAQOjbyE=; b=KRV2gabIuAHKCA2bR3TFyg37Ot
	8grILVv1y2mAuzQh8SM6YPUPC6DVTocs8MCRSgLTJTs+luotqmjScfW0CB6UwsnCpZL72KRjpgoFJ
	28sAaCiJ+UjCEel7jcqgd2okiqhaIw36zpO+CtaP4ajUm72ADnAV58C4lbUM4i4kmmDN9okFLtvoH
	IXHu6WJBu70qAWnRCa8AvANYNesWBbgtSyOxAgpPc36uCl6z6iw0b9NTt8zdba21Q0scwDPDDkBVR
	5VviXoafsaPQ2ifn2UwD0JyCO8oHRWh+fRHKvLO0PPIA4EMbOH/5ZBmsGoZBjoPOVzT8tEMfTGtVA
	AcDDVXEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55460)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBdUc-000000005JH-1XpL;
	Wed, 22 Oct 2025 19:23:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBdUa-000000000vO-2zLy;
	Wed, 22 Oct 2025 19:23:24 +0100
Date: Wed, 22 Oct 2025 19:23:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/6] net: phylink: add phylink managed MAC
 Wake-on-Lan support
Message-ID: <aPkhHIMJAYNEj_6Z@shell.armlinux.org.uk>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCT-0000000B2Ob-1yo3@rmk-PC.armlinux.org.uk>
 <6bff48d0-dd19-48d4-91e6-0d991365b8f9@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bff48d0-dd19-48d4-91e6-0d991365b8f9@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 22, 2025 at 04:06:00PM +0200, Maxime Chevallier wrote:
> >  int phylink_ethtool_set_wol(struct phylink *pl, struct ethtool_wolinfo *wol)
> >  {
> > +	struct ethtool_wolinfo w;

...

> > +			phy_ethtool_get_wol(pl->phydev, &w);
> > +
> > +			/* Any Wake-on-Lan modes which the PHY is handling
> > +			 * should not be passed on to the MAC.
> > +			 */
> > +			wolopts &= ~w.wolopts;
> 
> When PHY drivers gets converted to the new model, we'll have to look at
> how the .get_wol() behave WRT how they fill-in their wolopts.
> 
> The Broadcom driver for example may not set w.wolopts to 0 :
> 
>   https://elixir.bootlin.com/linux/v6.17.4/source/drivers/net/phy/broadcom.c#L1121
> 
> You'd probably end-up with garbage here then. But not blocking for your series.

Good point. We should initialise 'w' in the same way other users do, so:

+       struct ethtool_wolinfo w = { .cmd = ETHTOOL_GWOL };

Does your r-b still stand with this change?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

