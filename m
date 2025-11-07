Return-Path: <netdev+bounces-236786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4274C40232
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3A1189B2BC
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13462E6CB3;
	Fri,  7 Nov 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dGuSN6kT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DE2E6127
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522498; cv=none; b=YFUddyr42VysexXkmoMIOqqp9hqsU9cJfQm526mB9XIDJ8zyhRgSuJP0XQAFTHhYbpDPe4NBhsauvTVh4Ta8qzbLEpcctjxC54z5OhEWfwnl1dPopzfeOtqMjAotXLs/MTuBoQYsppy6Z8mj4UmaJiyenA6GiCOXvu9og/E802M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522498; c=relaxed/simple;
	bh=846807pXerjmWoyc71HLc3qyEfFQwjc2HD4heNhIGdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMFsU81dZF1XA1zEWwwg5LKUoiIFygTXhU7X5GqLJXh62C33O1b6hDepcTjbGG1q223zSwltUqJ1J3BsXBtaA+45yyaAtdP2seD1UZ8Zzg3rJ3MqPJsO7hgvbNLDwpG2gwCcPiihpu7I8mRdxHjHKUkYuNAtjVa1zFGEf5LJLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dGuSN6kT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IF/it3WctiHfz9q44MFsumCsJZWTYGXYPnCO/rFokSs=; b=dGuSN6kTCZDihU2P/4sZbg0RuF
	FWhpMAAR0hMVevag1FPQchsFQ9Qxb6cJ2sv0jwOAteMxOns48CVYCSz+i2T9urbw/srmbfjjo+WPA
	kAk047cy2hOUw7qhAxvUsFnD20LBL6Li/StQSdWmr/j3IKJoE9WWFeNIAkBpOCD/XEyA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHMcA-00DEMM-Om; Fri, 07 Nov 2025 14:34:54 +0100
Date: Fri, 7 Nov 2025 14:34:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 6/6] net: phy: realtek: create
 rtl8211f_config_phy_eee() helper
Message-ID: <56b1deb7-2cc4-46fc-9890-bb7d984bed55@lunn.ch>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-7-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107110817.324389-7-vladimir.oltean@nxp.com>

On Fri, Nov 07, 2025 at 01:08:17PM +0200, Vladimir Oltean wrote:
> To simplify the rtl8211f_config_init() control flow and get rid of
> "early" returns for PHYs where the PHYCR2 register is absent, move the
> entire logic sub-block that deals with disabling PHY-mode EEE to a
> separate function. There, it is much more obvious what the early
> "return 0" skips, and it becomes more difficult to accidentally skip
> unintended stuff.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: patch is new
> 
>  drivers/net/phy/realtek/realtek_main.c | 29 ++++++++++++++++----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 4501b8923aad..6e75e124f27a 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -684,6 +684,23 @@ static int rtl8211f_config_aldps(struct phy_device *phydev)
>  				mask, mask);
>  }
>  
> +static int rtl8211f_config_phy_eee(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* RTL8211FVD has no PHYCR2 register */
> +	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
> +		return 0;
> +
> +	/* Disable PHY-mode EEE so LPI is passed to the MAC */
> +	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
> +			       RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
> +	if (ret)
> +		return ret;
> +
> +	return genphy_soft_reset(phydev);

Is this soft reset only required for EEE? None of the other
configuration needs it?

For the Marvell PHYs, lots of registers need a soft reset to put
changes into effect. I would not want to hide the soft reset inside a
helper, because of the danger more calls to helps are added
afterwards.

	Andrew

