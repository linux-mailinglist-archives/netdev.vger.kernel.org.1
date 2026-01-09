Return-Path: <netdev+bounces-248503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F70D0A65A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371FC3021072
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BA435BDD9;
	Fri,  9 Jan 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0uLwSaiT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC93596F1;
	Fri,  9 Jan 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964713; cv=none; b=ZgF7YHOWmazyLUUvonbO4UwLo+cv2uCl0georbcjy7UD/U9cBp89/+W/DIFU2LsRWfTrXG8yI9PzK/WxEdIbgRQZK6kaxkviFjhsyi/jr/J2h2Tt6m9h5I8rYER8emrN96f9K26SX5TnIcXZVhVciJPpbjt5xxnjDcP2dc0LL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964713; c=relaxed/simple;
	bh=jRw4jyai3MSwilDoSO/UVNtEZBloCZfbXt0ftHp3TPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+ezxG4L/bOtzZodjrdAQ+1NF3t2FvzxcWOqU/yS8Jz0x93ZOV4P10nHOXHPW3//BEf2wP9+1LlqYeRjTeUYuqQ1Wv4aI0kypu8lEa+gCLda0qOyBFkWsA4t+qOZQ0b9Pfm2g2PzINMYr2twF5Xls64gVxEQoUhMQu+CqoBT1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0uLwSaiT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5R1BxBO/fP28VxSx8PixX92HsrbwoPJtVTzynUlh2Tc=; b=0uLwSaiTmlpYdM1oNdQ1jGCf6g
	Y4rGAU9rAEhMixdOA8ad1Fc61QLGlSHDbJZDbK+il6DRs/8UhPHV7FniYHx7QivPj9MTZZusFEkzB
	TNjLzvkhpK5mf15YLi4YsnVqr89LBRMCdrZ311d51sprbcKCSpFTbuIHfPcKVtZzrGBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1veCNa-00271D-57; Fri, 09 Jan 2026 14:18:14 +0100
Date: Fri, 9 Jan 2026 14:18:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: phy: realtek: reunify C22 and C45
 drivers
Message-ID: <131c6552-f487-4790-99c6-cd4776875de9@lunn.ch>
References: <cover.1767926665.git.daniel@makrotopia.org>
 <d8d6265c1555ba2ce766a19a515511753ae208bd.1767926665.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8d6265c1555ba2ce766a19a515511753ae208bd.1767926665.git.daniel@makrotopia.org>

On Fri, Jan 09, 2026 at 03:03:33AM +0000, Daniel Golle wrote:
> Reunify the split C22/C45 drivers for the RTL8221B-VB-CG 2.5Gbps and
> RTL8221B-VM-CG 2.5Gbps PHYs back into a single driver.
> This is possible now by using all the driver operations previously used
> by the C45 driver, as transparent access to all MMDs including
> MDIO_MMD_VEND2 is now possible also over Clause-22 MDIO.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 72 ++++++--------------------
>  1 file changed, 16 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 886694ff995f6..d07d60bc1ce34 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -1879,28 +1879,18 @@ static int rtl8221b_match_phy_device(struct phy_device *phydev,
>  	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
>  }
>  
> -static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev,
> -					       const struct phy_driver *phydrv)
> +static int rtl8221b_vb_cg_match_phy_device(struct phy_device *phydev,
> +					   const struct phy_driver *phydrv)
>  {
> -	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
> +	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true) ||
> +	       rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);

Are there any calls left to rtlgen_is_c45_match() which don't || true
and false? If not, maybe add another patch which removes the bool
parameter?

	Andrew

