Return-Path: <netdev+bounces-179070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ED5A7A5CB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EAC3B08F9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A922500D0;
	Thu,  3 Apr 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BxUrl5yb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BB2459EE
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692157; cv=none; b=kpjxpcXDD0mGOyGhEUTdz2YN7NhP3lHm/+B3M1l2HnuE39wBdb1IcXxSspg+9Z5uQBK35uWuFaOhbe4EOvWt5Qd+TdHS7hBbck4lXnKcEqi5irttamnMKOA20V4Nv96/W8mKAr1frBj7VHyVPzIT/mOoqWrSNWf14XuZSoAOJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692157; c=relaxed/simple;
	bh=M9BC9cmfcjPwGJJRxuVT1l3E/BUHTdGEDFZ7Jl1dOAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE9rZ2suH76B0iau37sDSSFgcp22vgnvB/MZP7gywIaVcI2qvSCCG7BH7+8t3xRYyrfasX1/H8olPJ6ISo1qgb2zEj3MPkCPvQYDqX8DRjeMuGcP3S4gzAuEe79zeofnZwfu7a3+L2+RQsp14T5C6oyONc0y6Z8133HV2Rpyty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BxUrl5yb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kuiVlbx2kfYIhaf81qOxtGTTxyZS4KbiOR1XX91AjLs=; b=BxUrl5ybBFQJoec8dQxfDqtWw0
	wUNjAzxjUlujJEXB0euJ8NMRaWiEPKgGRhSiZ6RkVY75AWVOTxRJEK+qjXkNK9NlO+gINEjWh4xpD
	fmMUJ0lbLd9BpwDgztq9XpRUyANfufgWZfMCbvSnkb/i3819GRNt6Fg2n0bLlo4UDmYXb+rzl0v+B
	BefhgfHrt9UvZ0tGz9xUOw8otwN6fApKN+o/KEYxdlS3HTqULcRqTodwMmUnDg2nCNq94zxghmNHZ
	QKcjOpfCFEEbqnqdBSVwZsOtUBXVF19aCd2iYdcBOBNUlx2j7h+xo+3F1W0r3wtZvMWc8MbEXb2mC
	23Nsfg2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44000)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u0Lyu-0000Xt-34;
	Thu, 03 Apr 2025 15:55:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u0Lyr-0004pe-1K;
	Thu, 03 Apr 2025 15:55:45 +0100
Date: Thu, 3 Apr 2025 15:55:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 01, 2025 at 02:30:06PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The blamed commit introduced an issue where it was limiting the link
> configuration so that we couldn't use fixed-link mode for any settings
> other than twisted pair modes 10G or less. As a result this was causing the
> driver to lose any advertised/lp_advertised/supported modes when setup as a
> fixed link.
> 
> To correct this we can add a check to identify if the user is in fact
> enabling a TP mode and then apply the mask to select only 1 of each speed
> for twisted pair instead of applying this before we know the number of bits
> set.
> 
> Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/net/phy/phylink.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 16a1f31f0091..380e51c5bdaa 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -713,17 +713,24 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>  		phylink_warn(pl, "fixed link specifies half duplex for %dMbps link?\n",
>  			     pl->link_config.speed);
>  
> -	linkmode_zero(pl->supported);
> -	phylink_fill_fixedlink_supported(pl->supported);
> -
> +	linkmode_fill(pl->supported);
>  	linkmode_copy(pl->link_config.advertising, pl->supported);
>  	phylink_validate(pl, pl->supported, &pl->link_config);
>  
>  	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
>  			    pl->supported, true);
> -	if (c)
> +	if (c) {
>  		linkmode_and(match, pl->supported, c->linkmodes);
>  
> +		/* Compatbility with the legacy behaviour:
> +		 * Report one single BaseT mode.
> +		 */
> +		phylink_fill_fixedlink_supported(mask);
> +		if (linkmode_intersects(match, mask))
> +			linkmode_and(match, match, mask);
> +		linkmode_zero(mask);
> +	}
> +

I'm still wondering about the wiseness of exposing more than one link
mode for something that's supposed to be fixed-link.

For gigabit fixed links, even if we have:

	phy-mode = "1000base-x";
	speed = <1000>;
	full-duplex;

in DT, we still state to ethtool:

        Supported link modes:   1000baseT/Full
        Advertised link modes:  1000baseT/Full
        Link partner advertised link modes:  1000baseT/Full
        Link partner advertised auto-negotiation: No
        Speed: 1000Mb/s
        Duplex: Full
        Auto-negotiation: on

despite it being a 1000base-X link. This is perfectly reasonable,
because of the origins of fixed-links - these existed as a software
emulated baseT PHY no matter what the underlying link was.

So, is getting the right link mode for the underlying link important
for fixed-links? I don't think it is. Does it make sense to publish
multiple link modes for a fixed-link? I don't think it does, because
if multiple link modes are published, it means that it isn't fixed.

As for arguments about the number of lanes, that's a property of the
PHY_INTERFACE_MODE_xxx. There's a long history of this, e.g. MII/RMII
is effectively a very early illustration of reducing the number of
lanes, yet we don't have separate link modes for these.

So, I'm still uneasy about this approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

