Return-Path: <netdev+bounces-231684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D0BFCA55
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8B96E7578
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26E435BDCC;
	Wed, 22 Oct 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EfUfHj6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4E35BDAB
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143315; cv=none; b=cGYL//ds9R9unpoWYRMBsv5MNA+SwHEyQynCzeoLbluCXiFPoa0EFBKTexrmZTfksC1EAiFgekxkUQl2Wj/TOtAkEvxnUbAmoZvH8aFu7wIB4RmNI4XF2X6yb1fsmSTS/1SpZBKhoi889UXaocCvc3CS0XjnTh/nVqjWuoJYqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143315; c=relaxed/simple;
	bh=t+y8IgVVrp7RnjGSKCVtQgJW5QxLAPENScnX/etBWwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYWq2Fnbf2X7LCIyHRpjacvgG6utFPQiEV1KJRUvmO4qc62z/q+u8pOrYBhdJmWeyFARisysDD9MMX14XhYW4D5RxaokKz0EDsuzLWmJiTjTgestfvhXCC43J9Y/tpwWIVr5oAqkpXIGlBEqXolViX7MYkathIkjM7ojijAiHfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EfUfHj6T; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7EFCEC0AFF6;
	Wed, 22 Oct 2025 14:28:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D2A8606DC;
	Wed, 22 Oct 2025 14:28:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECA3C102F243E;
	Wed, 22 Oct 2025 16:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761143309; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Rile4f14cDJIakjmIfK3sT/0p2MCzB68TdqYyaWZuXk=;
	b=EfUfHj6TGyD85vx69BNLmM9lTYrjeeIyiEMZC+be04ailGl2Q8ZdwxWyqvaufndbyYjWUe
	ojVSXNeyQnT3Tl5zDP9APeAm1CcTdqL2qNBsUcKHuOiqpdYW+Xjy2b3vwMMZjJPGhfYC9X
	+yfzDHBiRPH44Vxw4VW3sLphgBtACQNXX2Vb6MJ/OP1ntVUOkywzDRiXDhZSm7G9ozY+Zz
	dMzKLxvBF/Tco4nJLoaCWhkcqwyX8EyLhFmjaJdvs48d/HDN533WWSx8kfoPGqNfcwMIE9
	Z7DFASR+DWFtEKW7wx/HqgSeum/GPR680fiQqq4RABycvJDJwUQiynS0Yva5bA==
Message-ID: <eb0d1b55-307b-4b51-953f-fdcc1a8fbe27@bootlin.com>
Date: Wed, 22 Oct 2025 16:28:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: phylink: add phylink managed
 wake-on-lan PHY speed control
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCZ-0000000B2PP-2cuM@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v9jCZ-0000000B2PP-2cuM@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 17/10/2025 14:04, Russell King (Oracle) wrote:
> Some drivers, e.g. stmmac, use the speed_up()/speed_down() APIs to
> gain additional power saving during Wake-on-LAN where the PHY is
> managing the state.
> 
> Add support to phylink for this, which can be enabled by the MAC
> driver. Only change the PHY speed if the PHY is configured for
> wake-up, but without any wake-up on the MAC side, as MAC side
> means changing the configuration once the negotiation has
> completed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 12 ++++++++++++
>  include/linux/phylink.h   |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 939438a6d6f5..26bd4b7619dd 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -2576,6 +2576,12 @@ static bool phylink_phy_supports_wol(struct phylink *pl,
>  	return phydev && (pl->config->wol_phy_legacy || phy_can_wakeup(phydev));
>  }
>  
> +static bool phylink_phy_pm_speed_ctrl(struct phylink *pl)
> +{
> +	return pl->config->wol_phy_speed_ctrl && !pl->wolopts_mac &&
> +	       pl->phydev && phy_may_wakeup(pl->phydev);
> +}
> +
>  /**
>   * phylink_suspend() - handle a network device suspend event
>   * @pl: a pointer to a &struct phylink returned from phylink_create()
> @@ -2625,6 +2631,9 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
>  	} else {
>  		phylink_stop(pl);
>  	}
> +
> +	if (phylink_phy_pm_speed_ctrl(pl))
> +		phy_speed_down(pl->phydev, false);

Should this rather be phylink_speed_down, to take into account the fact
 that the PHY might be on SFP ? either here or directly in
phylink_phy_pm_speed_ctrl() above ?

Maxime

