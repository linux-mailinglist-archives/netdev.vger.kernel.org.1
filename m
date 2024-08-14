Return-Path: <netdev+bounces-118507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226DD951D14
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4772A1C2167D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5971B32D0;
	Wed, 14 Aug 2024 14:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473431B1418;
	Wed, 14 Aug 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645774; cv=none; b=p4NX1c4e8v/YtacF1OYd5dHcoQMX4j4zL6ZwrKmp4vkJjeWnRh5VWV3MwN0j4Jr7dex1qzK9+cZCnsuS9RRkSFqldcPdD/l1/DyqM7upY4qKMVEyt5GbH0O+VUEudKGGJT0Gmyv5IdgmQfXZLeh2Y/oMPcmhNuEXyM6RqUi1buo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645774; c=relaxed/simple;
	bh=Lh0yNEnaMUdh9DsnyNc8a4eGtt2xTJdqGUzxmJkB2BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c120GIxkzVnvuAn+OdbVGy5PZlGfmwPxzu9wEJPi0CSQbU007sGNGSWcN5bRDjTE9l6yK+37VU39mb0onhWgvf9g105nlmtL50nXvicrIMp7Qez9fcia6+RlTWF/gUJdeKmNAweV8Yw2K9+mfE5TD6X3/m+hHPKaKGWrXkB5b2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkVy136T0z9sPd;
	Wed, 14 Aug 2024 16:29:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KPD06EKhs4-G; Wed, 14 Aug 2024 16:29:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkVy11ZXfz9rvV;
	Wed, 14 Aug 2024 16:29:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 245CF8B775;
	Wed, 14 Aug 2024 16:29:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id vCVUCpIK8jPT; Wed, 14 Aug 2024 16:29:29 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D941A8B764;
	Wed, 14 Aug 2024 16:29:27 +0200 (CEST)
Message-ID: <994fc35f-92aa-4c1c-93ca-7893bc242a69@csgroup.eu>
Date: Wed, 14 Aug 2024 16:29:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 03/14] net: phy: add helpers to handle sfp
 phy connect/disconnect
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-4-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> There are a few PHY drivers that can handle SFP modules through their
> sfp_upstream_ops. Introduce Phylib helpers to keep track of connected
> SFP PHYs in a netdevice's namespace, by adding the SFP PHY to the
> upstream PHY's netdev's namespace.
> 
> By doing so, these SFP PHYs can be enumerated and exposed to users,
> which will be able to use their capabilities.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/net/phy/marvell-88x2222.c |  2 ++
>   drivers/net/phy/marvell.c         |  2 ++
>   drivers/net/phy/marvell10g.c      |  2 ++
>   drivers/net/phy/phy_device.c      | 42 +++++++++++++++++++++++++++++++
>   drivers/net/phy/qcom/at803x.c     |  2 ++
>   drivers/net/phy/qcom/qca807x.c    |  2 ++
>   include/linux/phy.h               |  2 ++
>   7 files changed, 54 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell-88x2222.c b/drivers/net/phy/marvell-88x2222.c
> index b88398e6872b..0b777cdd7078 100644
> --- a/drivers/net/phy/marvell-88x2222.c
> +++ b/drivers/net/phy/marvell-88x2222.c
> @@ -553,6 +553,8 @@ static const struct sfp_upstream_ops sfp_phy_ops = {
>   	.link_down = mv2222_sfp_link_down,
>   	.attach = phy_sfp_attach,
>   	.detach = phy_sfp_detach,
> +	.connect_phy = phy_sfp_connect_phy,
> +	.disconnect_phy = phy_sfp_disconnect_phy,
>   };
>   
>   static int mv2222_probe(struct phy_device *phydev)
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index b89fbffa6a93..9964bf3dea2f 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -3613,6 +3613,8 @@ static const struct sfp_upstream_ops m88e1510_sfp_ops = {
>   	.module_remove = m88e1510_sfp_remove,
>   	.attach = phy_sfp_attach,
>   	.detach = phy_sfp_detach,
> +	.connect_phy = phy_sfp_connect_phy,
> +	.disconnect_phy = phy_sfp_disconnect_phy,
>   };
>   
>   static int m88e1510_probe(struct phy_device *phydev)
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index ad43e280930c..6642eb642d4b 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -503,6 +503,8 @@ static int mv3310_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
>   static const struct sfp_upstream_ops mv3310_sfp_ops = {
>   	.attach = phy_sfp_attach,
>   	.detach = phy_sfp_detach,
> +	.connect_phy = phy_sfp_connect_phy,
> +	.disconnect_phy = phy_sfp_disconnect_phy,
>   	.module_insert = mv3310_sfp_insert,
>   };
>   
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index e68acaba1b4f..a3309782220c 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1370,6 +1370,48 @@ phy_standalone_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(phy_standalone);
>   
> +/**
> + * phy_sfp_connect_phy - Connect the SFP module's PHY to the upstream PHY
> + * @upstream: pointer to the upstream phy device
> + * @phy: pointer to the SFP module's phy device
> + *
> + * This helper allows keeping track of PHY devices on the link. It adds the
> + * SFP module's phy to the phy namespace of the upstream phy
> + *
> + * Return: 0 on success, otherwise a negative error code.
> + */
> +int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
> +{
> +	struct phy_device *phydev = upstream;
> +	struct net_device *dev = phydev->attached_dev;
> +
> +	if (dev)
> +		return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(phy_sfp_connect_phy);
> +
> +/**
> + * phy_sfp_disconnect_phy - Disconnect the SFP module's PHY from the upstream PHY
> + * @upstream: pointer to the upstream phy device
> + * @phy: pointer to the SFP module's phy device
> + *
> + * This helper allows keeping track of PHY devices on the link. It removes the
> + * SFP module's phy to the phy namespace of the upstream phy. As the module phy
> + * will be destroyed, re-inserting the same module will add a new phy with a
> + * new index.
> + */
> +void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
> +{
> +	struct phy_device *phydev = upstream;
> +	struct net_device *dev = phydev->attached_dev;
> +
> +	if (dev)
> +		phy_link_topo_del_phy(dev, phy);
> +}
> +EXPORT_SYMBOL(phy_sfp_disconnect_phy);
> +
>   /**
>    * phy_sfp_attach - attach the SFP bus to the PHY upstream network device
>    * @upstream: pointer to the phy device
> diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
> index c8f83e5f78ab..105602581a03 100644
> --- a/drivers/net/phy/qcom/at803x.c
> +++ b/drivers/net/phy/qcom/at803x.c
> @@ -770,6 +770,8 @@ static const struct sfp_upstream_ops at8031_sfp_ops = {
>   	.attach = phy_sfp_attach,
>   	.detach = phy_sfp_detach,
>   	.module_insert = at8031_sfp_insert,
> +	.connect_phy = phy_sfp_connect_phy,
> +	.disconnect_phy = phy_sfp_disconnect_phy,
>   };
>   
>   static int at8031_parse_dt(struct phy_device *phydev)
> diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
> index 672c6929119a..5eb0ab1cb70e 100644
> --- a/drivers/net/phy/qcom/qca807x.c
> +++ b/drivers/net/phy/qcom/qca807x.c
> @@ -699,6 +699,8 @@ static const struct sfp_upstream_ops qca807x_sfp_ops = {
>   	.detach = phy_sfp_detach,
>   	.module_insert = qca807x_sfp_insert,
>   	.module_remove = qca807x_sfp_remove,
> +	.connect_phy = phy_sfp_connect_phy,
> +	.disconnect_phy = phy_sfp_disconnect_phy,
>   };
>   
>   static int qca807x_probe(struct phy_device *phydev)
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 2d477eb2809a..f7ef7ed6d5ce 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1762,6 +1762,8 @@ int phy_suspend(struct phy_device *phydev);
>   int phy_resume(struct phy_device *phydev);
>   int __phy_resume(struct phy_device *phydev);
>   int phy_loopback(struct phy_device *phydev, bool enable);
> +int phy_sfp_connect_phy(void *upstream, struct phy_device *phy);
> +void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy);
>   void phy_sfp_attach(void *upstream, struct sfp_bus *bus);
>   void phy_sfp_detach(void *upstream, struct sfp_bus *bus);
>   int phy_sfp_probe(struct phy_device *phydev,

