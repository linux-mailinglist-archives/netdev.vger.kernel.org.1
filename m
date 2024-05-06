Return-Path: <netdev+bounces-93837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5218BD57C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06814280F4E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553DB15AAD0;
	Mon,  6 May 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b2XTXZxI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E715AAC9;
	Mon,  6 May 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024115; cv=none; b=TldQnzceTpmUlwafiURAI4fKnquC0KU85romDzsr8N4i0iVR55jS8WTHLcKFpIzrnp4Gg7b+a7KIsWbafjBeL7mtRaArobeI4U1f4rRT2gcTDGZnpqdcQ5XN2j/JLN+vXDXN1SVyLlTutAAMPoHWb45Q5G9UT58rKYeah6JBOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024115; c=relaxed/simple;
	bh=+W2lA0MWv2z0t6GRwxjdfi6W408kM+so6uKqeK9p4ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGp5YwXgoXf5oWHxDAKt/abMjtPA7mnM4oW8MyZbG4NuqNxMLRbJqOePGICRCQfKBRwWz1CbByMmwLWfn2bMEfyzqTsC+kOmRSScLtIEYazN7kHBDa4b6h7mxpOVrDhnUrIVwsB4ir02zjHbfZbUqEWEgsxTRWVZdU0VmXNCoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b2XTXZxI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=F+GVANw34gec2LcUlN4q8Pr0ShGOdG4tQUMwECB93ug=; b=b2
	XTXZxI5nsZ/7IfqX5js6EGbSrInFnKK1CU5366RX0Y7jZcE08wGUhj0uPzaUoYxBLnkMftF0lBdPB
	SFHpVcveRLC8iH9ufx9p7USgnMVBDETgxrQ1iLr4NOecn/mteum5/OkglcIKRkt4z8Bxn/S5ui05H
	VQzwvXYJHE/lNRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s447B-00EnDS-3V; Mon, 06 May 2024 21:35:09 +0200
Date: Mon, 6 May 2024 21:35:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <efaf2c2c-45a9-4b22-8f71-c8e41d680912@lunn.ch>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506144015.2409715-4-kamilh@axis.com>

On Mon, May 06, 2024 at 04:40:15PM +0200, Kamil Horák - 2N wrote:
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle configuration
> of these modes on compatible Broadcom PHYs.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> ---
>  drivers/net/phy/bcm-phy-lib.c | 122 ++++++++++++
>  drivers/net/phy/bcm-phy-lib.h |   4 +
>  drivers/net/phy/broadcom.c    | 338 ++++++++++++++++++++++++++++++++--
>  3 files changed, 449 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
> index 876f28fd8256..9fa2a20e641f 100644
> --- a/drivers/net/phy/bcm-phy-lib.c
> +++ b/drivers/net/phy/bcm-phy-lib.c
> @@ -794,6 +794,46 @@ static int _bcm_phy_cable_test_get_status(struct phy_device *phydev,
>  	return ret;
>  }
>  
> +static int bcm_setup_forced(struct phy_device *phydev)
> +{
> +	u16 ctl = 0;
> +
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	if (phydev->speed == SPEED_100)
> +		ctl |= LRECR_SPEED100;
> +
> +	if (phydev->duplex != DUPLEX_FULL)
> +		return -EOPNOTSUPP;

Is this even possible? I don't actually known, but you don't define a
HALF link mode, so how is this requested?

> +/**
> + * bcm_linkmode_adv_to_mii_adv_t
> + * @advertising: the linkmode advertisement settings
> + *
> + * A small helper function that translates linkmode advertisement
> + * settings to phy autonegotiation advertisements for the
> + * MII_BCM54XX_LREANAA register.
> + */
> +static inline u32 bcm_linkmode_adv_to_mii_adv_t(unsigned long *advertising)

No inline functions in .c files please, let the compiler decide.

> +int bcm_setup_master_slave(struct phy_device *phydev);
> +int bcm_config_aneg(struct phy_device *phydev, bool changed);
> +int bcm_config_advert(struct phy_device *phydev);

These are all BroadReach specific, so i would put something in there
name to indicate this. Otherwise somebody is going to try to use them
when not appropriate.

     Andrew

