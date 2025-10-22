Return-Path: <netdev+bounces-231541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F4BFA30D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0C71A021F1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019A2DF3FD;
	Wed, 22 Oct 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CDsYfdq0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9C246BB0;
	Wed, 22 Oct 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113904; cv=none; b=R0MHQcLlE6UCb4LxUTk3qgSIxeLQ65XVFYseGtzJA0hKp1zSNTCbopAPc7k0/kWBYTWxJKQAw90qE50LUnnrSCvI3NwNqjG5wvgWK+5Db3igRl/uLttx39EgVhNtZau18lS+w3rjCSY5Iv6q29dYzQoNrls9x+kiJV1AaF+fVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113904; c=relaxed/simple;
	bh=ppbfRlG7JlLYLu+398lxp7AuiwAtObi0J8Jh7AuG+08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKOOmLYKytLN3RvroIqWXO/ioblQBDzUpfHGztDdgtrRjPFNvzmctf0xuMhYrsome5CTl1RLn3hjtE3HjJNNO9v9F8CRE86VqDraI7ynEc++nhIwsFAQO4tGby3xNnN1fkvxkYP0QRpLWk07/TGMxCpJm3XFZbQm3hdLIxcwsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CDsYfdq0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2rzaSr7IWXWN5ctGh5yOkfPLJnyHgM1S+mUwIFD3akg=; b=CDsYfdq0MnQGmUv76QU0vTgpX7
	dLswUmCe11a5UnOuLzCzgCzr7AKYCftFAylCQ/n6azjm7W9F9D9Czud2zYRcoOiQvKtZANSeG5NH1
	EoqILtH0SXDsUYqJp/LdcX9CzDVNr+iuUgCz8FrbT0FFTEmbYafQ1guOl5WXJLBsHzg/jOGKEx2a9
	MFZVNFkE79n7CNxiEDuG9sTef19RD/9en+rSEdD0JULWszSeIbnuh0CiH4xqr38tm0rB1XHon4IAM
	x/TvZX5jsHWbj+ZsWBt1qDQaX3rUsMFohDJKyNaf6HGBgQ7TE0JvJtHXSzdNpUQWsaLFELrQFynRv
	KLOv/lvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37758)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBSAm-000000004Ph-27lq;
	Wed, 22 Oct 2025 07:18:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBSAh-000000000Uw-3SML;
	Wed, 22 Oct 2025 07:18:07 +0100
Date: Wed, 22 Oct 2025 07:18:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: Re: [PATCH net-next 0/6] net: add phylink managed WoL and convert
 stmmac
Message-ID: <aPh3H-B7RQIad12O@shell.armlinux.org.uk>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series is now marked in PW as "Needs ACK"... please can someone
review this.

Thanks.

On Fri, Oct 17, 2025 at 01:03:54PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> This series is implementing the thoughts of Andrew, Florian and myself
> to improve the quality of Wake-on-Lan (WoL) implementations.
> 
> This changes nothing for MAC drivers that do not wish to participate in
> this, but if they do, then they gain the benefit of phylink configuring
> WoL at the point closest to the media as possible.
> 
> We first need to solve the problem that the multitude of PHY drivers
> report their device supports WoL, but are not capable of waking the
> system. Correcting this is fundamental to choosing where WoL should be
> enabled - a mis-reported WoL support can render WoL completely
> ineffective.
> 
> The only PHY drivers which uses the driver model's wakeup support is
> drivers/net/phy/broadcom.c, and until recently, realtek. This means
> we have the opportunity for PHY drivers to be _correctly_ converted
> to use this method of signalling wake-up capability only when they can
> actually wake the system, and thus providing a way for phylink to
> know whether to use PHY-based WoL at all.
> 
> However, a PHY driver not implementing that logic doesn't become a
> blocker to MACs wanting to convert. In full, the logic is:
> 
> - phylink supports a flag, wol_phy_legacy, which forces phylink to use
>   the PHY-based WoL even if the MDIO device is not marked as wake-up
>   capable.
> 
> - when wol_phy_legacy is not set, we check whether the PHY MDIO device
>   is wake-up capable. If it is, we offer the WoL request to the PHY.
> 
> - if neither wol_phy_legacy is set, or the PHY is not wake-up capable,
>   we do not offer the WoL request to the PHY.
> 
> In both cases, after setting any PHY based WoL, we remove the options
> that the PHY now reports are enabled from the options mask, and offer
> these (if any) to the MAC. The mac will get a "mac_set_wol()" method
> call when any settings change.
> 
> Phylink mainatains the WoL state for the MAC, so there's no need for
> a "mac_get_wol()" method. There may be the need to set the initial
> state but this is not supported at present.
> 
> I've also added support for doing the PHY speed-up/speed-down at
> suspend/resume time depending on the WoL state, which takes another
> issue from the MAC authors.
> 
> Lastly, with phylink now having the full picture for WoL, the
> "mac_wol" argument for phylink_suspend() becomes redundant, and for
> MAC drivers that implement mac_set_wol(), the value passed becomes
> irrelevant.
> 
> Changes since RFC:
> - patch 3: fix location of phylink_xxx_supports_wol() helpers
> - patch 3: handle sopass for WAKE_MAGICSECURE only when the MAC is
>   handling magic secure.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       | 11 +--
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 31 +-------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 45 +++++++----
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  4 +-
>  drivers/net/phy/phy_device.c                       | 14 +++-
>  drivers/net/phy/phylink.c                          | 92 +++++++++++++++++++++-
>  include/linux/phy.h                                | 21 +++++
>  include/linux/phylink.h                            | 28 +++++++
>  8 files changed, 182 insertions(+), 64 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

