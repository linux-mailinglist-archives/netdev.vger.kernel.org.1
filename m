Return-Path: <netdev+bounces-128048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84546977A71
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0261C22D20
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5111BC9EE;
	Fri, 13 Sep 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BxUS37rz"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA1513D89D;
	Fri, 13 Sep 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214486; cv=none; b=nnF5oOHayajQgFTAchQP4ju+deq6GKQnUjMRD+T6DKMUs1daVQOTs3/YsruwUNepL3UlCuV/5wxHBz6B0WyJ3PZDFguWy8L4O2x4cTv8x8qITpHobBj1iIKMrpzxeJBcnxbsXcAfHqNIZHXcYjMW6wEr7gXOpU2afDNIOHPsO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214486; c=relaxed/simple;
	bh=2kwJ+BtuiLcQLk+MsoKNbghxD9PaOnAzAz+VDMPDp1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZavvHVP6nGyT333mMlkl/7IH6y7a7Uy5zKiInIbiSlt/NzJ46O9SbiNMjIqu/8Ptu0g5VwO09rlUB1R/Nz6gdDmV8x2lXUyeY+jWFQ65b8YKIql/GMb1gxum34DddVAtjfT0FUgMwR2vP4YvM5nQgRgKPoa9VD0bwQovKnU49JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BxUS37rz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4D1220010;
	Fri, 13 Sep 2024 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726214481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mJb5b8M7y+63w9Nl8ehjYHcycuEjHwdcbQVGSHrsXU=;
	b=BxUS37rz24vR3RIuK1EfVOI3pGeLCb8RWHGAbYbOuaRLiDNCn9Q5f5YsKvNAPGyef2SjGz
	YZkcuKhXaYMoeQ6yYa0nixBMpak9e25i1fzBN0HnNKiHa0UrgLlcHnKPxiWVBSz7+qi953
	rsok3Anf74PF86idPebzU9Si3w9k0vvKMgFVG4iuIrWhppvk2kouW8JboHbVj0vu5fnV86
	tAcQfXrpLZGNcY3Lv+nuyiQ9EeeaIpalmGyLvc+2fb50/SUBlbYctUIaA/B5LMM1QPoaq3
	Zpz0JMGuiuMzBnpoBR8kzORs9BnpgMfdSZbFgCgPKrpU3pd471KggCXpPTbP7A==
Date: Fri, 13 Sep 2024 10:01:20 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jon Hunter <jonathanh@nvidia.com>,
 kernel@quicinc.com
Subject: Re: [RFC PATCH net v1] net: phy: aquantia: Set phy speed to 2.5gbps
 for AQR115c
Message-ID: <20240913100120.75f9d35c@fedora.home>
In-Reply-To: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
References: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Thu, 12 Sep 2024 18:16:35 -0700
Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:

> Recently we observed that aquantia AQR115c always comes up in
> 100Mbps mode. AQR115c aquantia chip supports max speed up to
> 2.5Gbps. Today the AQR115c configuration is done through
> aqr113c_config_init which internally calls aqr107_config_init.
> aqr113c and aqr107 are both capable of 10Gbps. Whereas AQR115c
> supprts max speed of 2.5Gbps only.
> 
> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
>  drivers/net/phy/aquantia/aquantia_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index e982e9ce44a5..9afc041dbb64 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -499,6 +499,12 @@ static int aqr107_config_init(struct phy_device *phydev)
>  	if (!ret)
>  		aqr107_chip_info(phydev);
>  
> +	/* AQR115c supports speed up to 2.5Gbps */
> +	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		phy_set_max_speed(phydev, SPEED_2500);
> +		phydev->autoneg = AUTONEG_ENABLE;
> +	}
> +

If I get your commit log right, the code above will also apply for
ASQR107, AQR113 and so on, don't you risk breaking these PHYs if they
are in 2500BASEX mode at boot?

Besides that, if the PHY switches between SGMII and 2500BASEX
dynamically depending on the link speed, it could be that it's
configured by default in SGMII, hence this check will be missed.

Is the AQR115c in the same situation as AQR111 for example, where the
PMA capabilities reported are incorrect ? If so, you can take the same
approach as aqr111, which is to create a dedicated .config_init()
callback for the AQR115c, which sets the max speed, then call
aqr113c_config_init() from there ?

Maxime

