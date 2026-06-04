Return-Path: <netdev+bounces-295161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BX16F3hSIWp3DQEAu9opvQ
	(envelope-from <netdev+bounces-295161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:24:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2763EFC5
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:24:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=y7Sw5QAi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295161-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295161-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FB57308B9D9
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A235342C98;
	Thu,  4 Jun 2026 10:18:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0A340281
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:18:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568328; cv=none; b=hQEOuzG9Wg8U0Q3UuqrYj5JgehmSD2YHAoNllXuuCENh0j8IO3WkrLOe7WI7yq9hXIYlvX5pAohMeo8Guz9nfKFqD5PtBn8LO/hSt/S47PVwfTp5gaLQ9lakNHK26LQwrHpnznsXlb9QoWz3rq2FlB5aPQWP1K62KRQyVj1i0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568328; c=relaxed/simple;
	bh=8YYdUODBTYv5fPMlPrfdExePHaQO6eg6B7E5igdzywk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VCT0GzyEHi/8/t8fpvL+s4yGOE4gJ9Xe8+efE1ywUok9X2Z7fAe3/PAMnxuuUV7GL7h3YqoRYy4g3b1PE+ChFz0ZAAtdyZzQ5p52eq2MIEO9OHA9vQgGkxJdk/2NoojQ6KDXiacu3JfUXCXvgYGBasbKfGtxIQawcNr14A4f+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y7Sw5QAi; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BCACA1A05EB;
	Thu,  4 Jun 2026 10:18:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FD645FEF7;
	Thu,  4 Jun 2026 10:18:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 317A0106A1870;
	Thu,  4 Jun 2026 12:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780568323; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PKTOtTKdkbFnPvprYc1/sQl4naTPuVK6cz3+/+APFbo=;
	b=y7Sw5QAiStV4zcrVO7nvk//TXLOaeaSkKotfOEmhi4XRgtt9HdvVzDsJqV9JR/m8LaQWB1
	8P/GaAA4+9+iv4ZFYtoCGHvFqk66oxMY69sPgUzaMiudTw51y1tMK4teGcA2qXwOeUTVDI
	lmkFK0OsQ/sYTTVs12UwRAjUV9bjHUCuflmP/F7Eb3L1zHY+tXw/eYG2YLk3AOIaobrKI4
	BPYW9JD3jI0tUOUfktDTqEHcT3EvvqQjXTZ85OHu/o7rhQR8nE13aT4YZiKYZbdCll9W3X
	CfQFStEQWM4m4Y1KnoiE2nrhG+u/eyWqd8Niny7VWdw8pRVeNjYxZBJ4Yn7kwA==
Message-ID: <074f488f-c028-4e0d-b199-e6353ad92588@bootlin.com>
Date: Thu, 4 Jun 2026 12:18:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: phy: as21xxx: fix read_status speed handling
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601105342.28865-1-ansuelsmth@gmail.com>
 <20260601105342.28865-2-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260601105342.28865-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295161-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1D2763EFC5



On 6/1/26 12:53, Christian Marangi wrote:
> With further test with 2.5G NIC it was discovered that
> phy_resolve_aneg_linkmode is not enough to detect speed higher that 1G
> when autoneg is enabled.
> 
> Also in the switch case there is a typo where the speed mask is AND with
> VEND1_SPEED_STATUS instead of the correct mask VEND1_SPEED_MASK.
> 
> Rework the read_status code to always read the speed from the vendor
> register and parse the generic bit only for the pause frame.
> 
> Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/as21xxx.c | 96 +++++++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index 0db82da8dbdf..97ca37c6929f 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c
> @@ -671,7 +671,7 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
>  
>  static int as21xxx_read_c22_lpa(struct phy_device *phydev)
>  {
> -	int lpagb;
> +	int lpagb, lpa;
>  
>  	/* MII_STAT1000 are only filled in the mapped C22
>  	 * in C45, use that to fill lpagb values and check.
> @@ -698,12 +698,20 @@ static int as21xxx_read_c22_lpa(struct phy_device *phydev)
>  	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
>  					lpagb);
>  
> +	lpa = phy_read_mmd(phydev, MDIO_MMD_AN,
> +			   AS21XXX_MDIO_AN_C22 + MII_LPA);
> +	if (lpa < 0)
> +		return lpa;
> +
> +	mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, lpa);
> +
>  	return 0;
>  }
>  
>  static int as21xxx_read_status(struct phy_device *phydev)
>  {
>  	int bmcr, old_link = phydev->link;
> +	int speed;
>  	int ret;
>  
>  	ret = as21xxx_read_link(phydev, &bmcr);
> @@ -720,58 +728,60 @@ static int as21xxx_read_status(struct phy_device *phydev)
>  	phydev->asym_pause = 0;
>  
>  	if (phydev->autoneg == AUTONEG_ENABLE) {
> -		ret = genphy_c45_read_lpa(phydev);
> -		if (ret)
> -			return ret;
> +		if (!phydev->autoneg_complete) {
> +			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
> +							0);
> +			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> +			return 0;
> +		}
>  
>  		ret = as21xxx_read_c22_lpa(phydev);
>  		if (ret)
>  			return ret;
> -
> -		phy_resolve_aneg_linkmode(phydev);
>  	} else {
> -		int speed;
> -
>  		linkmode_zero(phydev->lp_advertising);
> +	}
>  
> -		speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> -				     VEND1_SPEED_STATUS);
> -		if (speed < 0)
> -			return speed;
> -
> -		switch (speed & VEND1_SPEED_STATUS) {
> -		case VEND1_SPEED_10000:
> -			phydev->speed = SPEED_10000;
> -			phydev->duplex = DUPLEX_FULL;
> -			break;
> -		case VEND1_SPEED_5000:
> -			phydev->speed = SPEED_5000;
> -			phydev->duplex = DUPLEX_FULL;
> -			break;
> -		case VEND1_SPEED_2500:
> -			phydev->speed = SPEED_2500;
> -			phydev->duplex = DUPLEX_FULL;
> -			break;
> -		case VEND1_SPEED_1000:
> -			phydev->speed = SPEED_1000;
> -			if (bmcr & BMCR_FULLDPLX)
> -				phydev->duplex = DUPLEX_FULL;
> -			else
> -				phydev->duplex = DUPLEX_HALF;
> -			break;
> -		case VEND1_SPEED_100:
> -			phydev->speed = SPEED_100;
> +	speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> +			     VEND1_SPEED_STATUS);
> +	if (speed < 0)
> +		return speed;
> +
> +	switch (speed & VEND1_SPEED_MASK) {
> +	case VEND1_SPEED_10000:
> +		phydev->speed = SPEED_10000;
> +		phydev->duplex = DUPLEX_FULL;
> +		break;
> +	case VEND1_SPEED_5000:
> +		phydev->speed = SPEED_5000;
> +		phydev->duplex = DUPLEX_FULL;
> +		break;
> +	case VEND1_SPEED_2500:
> +		phydev->speed = SPEED_2500;
> +		phydev->duplex = DUPLEX_FULL;
> +		break;
> +	case VEND1_SPEED_1000:
> +		phydev->speed = SPEED_1000;
> +		if (bmcr & BMCR_FULLDPLX)
>  			phydev->duplex = DUPLEX_FULL;
> -			break;
> -		case VEND1_SPEED_10:
> -			phydev->speed = SPEED_10;
> -			phydev->duplex = DUPLEX_FULL;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +		else
> +			phydev->duplex = DUPLEX_HALF;
> +		break;
> +	case VEND1_SPEED_100:
> +		phydev->speed = SPEED_100;
> +		phydev->duplex = DUPLEX_FULL;
> +		break;
> +	case VEND1_SPEED_10:
> +		phydev->speed = SPEED_10;
> +		phydev->duplex = DUPLEX_FULL;
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> +	if (phydev->autoneg == AUTONEG_ENABLE)
> +		phy_resolve_aneg_pause(phydev);
> +
>  	return 0;
>  }
>  


