Return-Path: <netdev+bounces-118506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3E9951D1C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318B2B27203
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020AC1B32D2;
	Wed, 14 Aug 2024 14:29:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDFB566A;
	Wed, 14 Aug 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645746; cv=none; b=mNt4LZF89uyACPr24laHJZXad58/YMDZNrfp3LANgKiG14pFlVxRLScv26VEQCYs/9SIaY/pkTRDup4sCXYOJJOj1qHzfhcHEnPr9hP78+KLXfWgz4fTstj4S/9wGvR24Ca4/1mb6/CaMxE5ICov/mhx3jAMMd3MnBFUE0n6KZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645746; c=relaxed/simple;
	bh=qIy65OyRAcpMfWWQMJI3HpVkYeJWxgYLMCg4gPav6oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k53tn0n6o60pDQIBBRFRjqMZXaqXXCp61USqPCsrWq4qT0wJhS3HKpW5x5+9SKti3/0eTFiTA3aMYs9GZ7hjCVeJLvz6bKCa/1iNpCcIjwr1xV2JRYmrq5kZj4t7JCW3oe/+xNdaN4/PWsp61ub7cB/YItHfQzRsYhVoYeHSE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkVxW1RvKz9sPd;
	Wed, 14 Aug 2024 16:29:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cDWoJrEHQenl; Wed, 14 Aug 2024 16:29:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkVxW0Nhrz9rvV;
	Wed, 14 Aug 2024 16:29:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ECCB58B775;
	Wed, 14 Aug 2024 16:29:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TvQGmTsK_0Ff; Wed, 14 Aug 2024 16:29:02 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FE428B764;
	Wed, 14 Aug 2024 16:29:01 +0200 (CEST)
Message-ID: <0938ca9e-01c7-4faa-a418-5871bb5de421@csgroup.eu>
Date: Wed, 14 Aug 2024 16:29:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 02/14] net: sfp: pass the phy_device when
 disconnecting an sfp module's PHY
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
 <20240709063039.2909536-3-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240709063039.2909536-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/07/2024 à 08:30, Maxime Chevallier a écrit :
> Pass the phy_device as a parameter to the sfp upstream .disconnect_phy
> operation. This is preparatory work to help track phy devices across
> a net_device's link.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/net/phy/phylink.c | 3 ++-
>   drivers/net/phy/sfp-bus.c | 4 ++--
>   include/linux/sfp.h       | 2 +-
>   3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 51c526d227fa..ab4e9fc03017 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -3423,7 +3423,8 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
>   	return ret;
>   }
>   
> -static void phylink_sfp_disconnect_phy(void *upstream)
> +static void phylink_sfp_disconnect_phy(void *upstream,
> +				       struct phy_device *phydev)
>   {
>   	phylink_disconnect_phy(upstream);
>   }
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index 2f44fc51848f..56953e66bb7b 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -487,7 +487,7 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
>   			bus->socket_ops->stop(bus->sfp);
>   		bus->socket_ops->detach(bus->sfp);
>   		if (bus->phydev && ops && ops->disconnect_phy)
> -			ops->disconnect_phy(bus->upstream);
> +			ops->disconnect_phy(bus->upstream, bus->phydev);
>   	}
>   	bus->registered = false;
>   }
> @@ -743,7 +743,7 @@ void sfp_remove_phy(struct sfp_bus *bus)
>   	const struct sfp_upstream_ops *ops = sfp_get_upstream_ops(bus);
>   
>   	if (ops && ops->disconnect_phy)
> -		ops->disconnect_phy(bus->upstream);
> +		ops->disconnect_phy(bus->upstream, bus->phydev);
>   	bus->phydev = NULL;
>   }
>   EXPORT_SYMBOL_GPL(sfp_remove_phy);
> diff --git a/include/linux/sfp.h b/include/linux/sfp.h
> index b14be59550e3..54abb4d22b2e 100644
> --- a/include/linux/sfp.h
> +++ b/include/linux/sfp.h
> @@ -550,7 +550,7 @@ struct sfp_upstream_ops {
>   	void (*link_down)(void *priv);
>   	void (*link_up)(void *priv);
>   	int (*connect_phy)(void *priv, struct phy_device *);
> -	void (*disconnect_phy)(void *priv);
> +	void (*disconnect_phy)(void *priv, struct phy_device *);
>   };
>   
>   #if IS_ENABLED(CONFIG_SFP)

