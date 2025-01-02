Return-Path: <netdev+bounces-154806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C39FFD3E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98673162C0E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F91885B4;
	Thu,  2 Jan 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L0q8Ip1o"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3755156871
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735840633; cv=none; b=FxYu20ZUr4zbtK51hYor8pQIzkeVEV4jK/UoRf3AUVOfV7Uz0A3/aa3bSTkdMhswzsWj5RxHuJPtmJJv9iafn13aZy6n08d3KXLBAJlWEQ5bxGG920Yhb7GsyFHuM60GndMADeWxNChjQpuINWqdXo5k0Xw1aFyU3/P9cpthtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735840633; c=relaxed/simple;
	bh=yjjKYqNnwma0lKd0ax0+yMLjOYLWUz/VZbcvJGqm7zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgEZ7QZVZkrfIID5kW6EivuqB08Mk9Si+8yoL+7x4tBHVuWeqddGz28FiS46CFk0l5Z3l/AhV+Ilnrf/WoXvKSYgyJol5L26g+rhf8jOlJhn6X6TmGSPu5ggtDsXc5UZRkO/t8OHfzqMavOrhM3fLHicsACUESvhwmWftV+8opQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L0q8Ip1o; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EApyJhlsEkQWO/RN0WMQhY5Xg0l8ci0uA+/cQjTx8Js=; b=L0q8Ip1oILkhfJX7ETDGW9AuP3
	rENg5xC8+WGeHaQA23kk2NMVvpMCJOO0KvkjWhC37qtr7CLhTaJYpcU19qNr/t99PzWTnRKsPhuBn
	J471mmH1eniOI04E50yGqbelC3vc1+5hQc49OVmGXCfzNCkVjoQET5AM/WdCMfDbqTQ+bbK3eVXac
	QjCNxnG/i+P97+aCLYL+6McVVvoXVlw5J4ou+gNy2uUVxm2WSA5O9Mx0RJT1ULotwdZs/jCYa6hvN
	ybRnI4Jb0iNM4pRs2X4ykxPgM5VuzEIDm0vSQEuUymcQFt4XKNt3wakeHB6uGFRMSD8UMg8nRPatM
	44+ArPhg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTPRP-0002Ft-1V;
	Thu, 02 Jan 2025 17:57:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTPRL-0000TU-1c;
	Thu, 02 Jan 2025 17:56:59 +0000
Date: Thu, 2 Jan 2025 17:56:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH RFC net-next 2/7] net: dsa: no longer call
 ds->ops->get_mac_eee()
Message-ID: <Z3bTa0Sq_GG8Khww@shell.armlinux.org.uk>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
 <E1tL1Br-006cnA-KV@rmk-PC.armlinux.org.uk>
 <20241212194419.4cbb776hc47yyl6z@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212194419.4cbb776hc47yyl6z@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 12, 2024 at 09:44:19PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 10, 2024 at 02:26:19PM +0000, Russell King (Oracle) wrote:
> >  	/* Check whether the switch supports EEE */
> >  	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
> >  		return -EOPNOTSUPP;
> >  
> > -	/* Port's PHY and MAC both need to be EEE capable */
> > -	if (!dev->phydev)
> > -		return -ENODEV;
> 
> It may well be that removing this test is ok given the later call to
> phylink_ethtool_get_eee() which will fail with the same return code,
> but this change does not logically pertain to a patch titled
> "no longer call ds->ops->get_mac_eee()", and no justification is brought
> for it in the commit message (my previous sentence should be sufficient).
> Please move this to a separate patch, for traceability purposes.

Let's say we split this from the patch, and leave the check in place for
this patch.

We then end up with:

	/* Port's PHY and MAC both need to be EEE capable */
	if (!dev->phydev)
		return -ENODEV;

	return phylink_ethtool_get_eee(dp->pl, e);

here.

At this point, we end up with this code:

	if (!dev->phydev)
		return -ENODEV;
followed by:
	ret = -EOPNOTSUPP;

	if (pl->phydev)
		ret = phy_ethtool_get_eee(pl->phydev, eee);

	return ret;

You seem to want that, so I'll drop the removal of this from the patch
series, especially as it changes the error that userspace sees - even
though it's different from what other ethernet drivers do. If we want
to address the !phydev return code issue, that can be done some other
time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

