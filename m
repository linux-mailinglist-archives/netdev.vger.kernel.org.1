Return-Path: <netdev+bounces-118519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8E3951D86
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3098B2C641
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C61B32CB;
	Wed, 14 Aug 2024 14:33:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3C1B1402;
	Wed, 14 Aug 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646027; cv=none; b=hTHE5SqI6W6zpM5k3byzoEnSJuVuUtlh2/2T4+OW59uznHT7uGxrrYN4+fE62qGSdiWA+mCJGbRoHgVjuYdSrSMiKryRvkzeCoN28rsdWqJf/y2Kz1DQLQUgVEAzV23s2ci7Lbri3gGY2PQHSKYT7v9OG05QSnRCzP4DOxmZOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646027; c=relaxed/simple;
	bh=M71zOwwtJia4FmprmPWrLM/gnkWUkqhTUT+ZEK7eSKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQtPrR4ysNR2fuxQlLyHPaWKkgnZNPHd3nljnnQPth/WUKyHSbQ7Pc226iwAs3pGH7Povui2XaPe6r+4sfvYXZeGdmcoIE40tMTgOvT/SZxoA7NN1eVKyojDk9m8+FzSztP1Ei3X8yo5ZLB/N3nR91lGNmLBh7bP2EwRgjlIQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkW2w3rsqz9sPd;
	Wed, 14 Aug 2024 16:33:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gYk_3pGPQQOr; Wed, 14 Aug 2024 16:33:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkW2w2c35z9rvV;
	Wed, 14 Aug 2024 16:33:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 49C378B775;
	Wed, 14 Aug 2024 16:33:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id X5IG7sr2BP6P; Wed, 14 Aug 2024 16:33:44 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D05C8B764;
	Wed, 14 Aug 2024 16:33:43 +0200 (CEST)
Message-ID: <2af8aef7-6428-461b-a35c-81e61769f65b@csgroup.eu>
Date: Wed, 14 Aug 2024 16:33:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 04/14] net: sfp: Add helper to return the SFP
 bus name
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
 <20240709063039.2909536-5-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-5-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> Knowing the bus name is helpful when we want to expose the link topology
> to userspace, add a helper to return the SFP bus name.
> 
> This call will always be made while holding the RTNL which ensures
> that the SFP driver won't unbind from the device. The returned pointer
> to the bus name will only be used while RTNL is held.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/net/phy/sfp-bus.c | 22 ++++++++++++++++++++++
>   include/linux/sfp.h       |  6 ++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index 56953e66bb7b..f13c00b5b449 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -722,6 +722,28 @@ void sfp_bus_del_upstream(struct sfp_bus *bus)
>   }
>   EXPORT_SYMBOL_GPL(sfp_bus_del_upstream);
>   
> +/**
> + * sfp_get_name() - Get the SFP device name
> + * @bus: a pointer to the &struct sfp_bus structure for the sfp module
> + *
> + * Gets the SFP device's name, if @bus has a registered socket. Callers must
> + * hold RTNL, and the returned name is only valid until RTNL is released.
> + *
> + * Returns:
> + *	- The name of the SFP device registered with sfp_register_socket()
> + *	- %NULL if no device was registered on @bus
> + */
> +const char *sfp_get_name(struct sfp_bus *bus)
> +{
> +	ASSERT_RTNL();
> +
> +	if (bus->sfp_dev)
> +		return dev_name(bus->sfp_dev);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(sfp_get_name);
> +
>   /* Socket driver entry points */
>   int sfp_add_phy(struct sfp_bus *bus, struct phy_device *phydev)
>   {
> diff --git a/include/linux/sfp.h b/include/linux/sfp.h
> index 54abb4d22b2e..60c65cea74f6 100644
> --- a/include/linux/sfp.h
> +++ b/include/linux/sfp.h
> @@ -576,6 +576,7 @@ struct sfp_bus *sfp_bus_find_fwnode(const struct fwnode_handle *fwnode);
>   int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
>   			 const struct sfp_upstream_ops *ops);
>   void sfp_bus_del_upstream(struct sfp_bus *bus);
> +const char *sfp_get_name(struct sfp_bus *bus);
>   #else
>   static inline int sfp_parse_port(struct sfp_bus *bus,
>   				 const struct sfp_eeprom_id *id,
> @@ -654,6 +655,11 @@ static inline int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
>   static inline void sfp_bus_del_upstream(struct sfp_bus *bus)
>   {
>   }
> +
> +static inline const char *sfp_get_name(struct sfp_bus *bus)
> +{
> +	return NULL;
> +}
>   #endif
>   
>   #endif

