Return-Path: <netdev+bounces-126254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568639703EC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FA21C21473
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12E165EFA;
	Sat,  7 Sep 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qRgsX16v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410415C137;
	Sat,  7 Sep 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725737640; cv=none; b=c2ScKb4zrZ1giBoaD1lC44kbZWrVGKx0Qze0ysVuJLV0xZadnBBqi9+SOGW7QTgaYCn0MgUZ1Fr6LXHNSoGFIXrHiAqLPHSUO6Bus+dcGygD2vGx6BozI1WU4pD686pzXlO0fxKT7cWJxcb7Uk7shYsX36ou932uA7QWW3Zg8O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725737640; c=relaxed/simple;
	bh=mfwKaQp5BkSePy1GwPJ36gNgr0xg5Ws/n1CZrgK1FOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDNhsFXwDXWWr6LuJVQjrPWIp9riLSe9yDmYMJtJu1BvBbYIb0jzDd/4QTAugCvXnRmyNgaE1JwFOk1TRYj+RhX+Rp7SDRHr+E0XxqZ+/TJQdGVOHM8zIbhe9oqcsOSZbbxoth8JrTn8AYs30M5lMI5rgcEzTQ4XqJ9Jm6dax4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qRgsX16v; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n1ArsTYyrNe0In1Ars69rC; Sat, 07 Sep 2024 21:32:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725737567;
	bh=Sq/z+LD8a2+GxxnI4fC77Y7QkMmsfuBapxy0sodS/Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qRgsX16vL7teLxJ9tNPQIGM4Vg859G9Jkc/oYDPTs6uHL3nAJTxrx/QnRgzHrXDS0
	 N+mbg5dTEpl6qyfkc2iqWDycVCQmYPygoo7VJpqMpoV7eIGJ9ZW5L7CY87kDnBAm/l
	 Bz3q2wFxbuGwyPYSzhmZSNTWgfSDAOoAOeXzoY1spGsnIHqNnae75cZXtpV7mqKPlb
	 9i8s2NaY53ATs6kKsxh6TnBRq7MYFNxTPPb0isHZvQffQauwfpvYfMCFs13WkvOTXx
	 UR+AgemDbrAqx+ElPEAt9K2Rel8GarXtWCoTyEr1ER4UqLtmk9qdqc8gR79OLdadr4
	 lAHF0viERQijg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 07 Sep 2024 21:32:47 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8f0413fc-42d6-4b26-81e7-affbea66868f@wanadoo.fr>
Date: Sat, 7 Sep 2024 21:32:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 6/9] net: ibm: emac: use netdev's phydev
 directly
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, jacob.e.keller@intel.com,
 horms@kernel.org, sd@queasysnail.net, chunkeey@gmail.com
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-7-rosenp@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240905201506.12679-7-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/09/2024 à 22:15, Rosen Penev a écrit :
> Avoids having to use own struct member.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/ibm/emac/core.c | 47 +++++++++++++---------------
>   drivers/net/ethernet/ibm/emac/core.h |  3 --
>   2 files changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index e2abda947a51..cda368701ae4 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -2459,7 +2459,7 @@ static int emac_read_uint_prop(struct device_node *np, const char *name,
>   static void emac_adjust_link(struct net_device *ndev)
>   {
>   	struct emac_instance *dev = netdev_priv(ndev);
> -	struct phy_device *phy = dev->phy_dev;
> +	struct phy_device *phy = ndev->phydev;
>   
>   	dev->phy.autoneg = phy->autoneg;
>   	dev->phy.speed = phy->speed;
> @@ -2510,22 +2510,20 @@ static int emac_mdio_phy_start_aneg(struct mii_phy *phy,
>   static int emac_mdio_setup_aneg(struct mii_phy *phy, u32 advertise)
>   {
>   	struct net_device *ndev = phy->dev;
> -	struct emac_instance *dev = netdev_priv(ndev);
>   
>   	phy->autoneg = AUTONEG_ENABLE;
>   	phy->advertising = advertise;
> -	return emac_mdio_phy_start_aneg(phy, dev->phy_dev);
> +	return emac_mdio_phy_start_aneg(phy, ndev->phydev);
>   }
>   
>   static int emac_mdio_setup_forced(struct mii_phy *phy, int speed, int fd)
>   {
>   	struct net_device *ndev = phy->dev;
> -	struct emac_instance *dev = netdev_priv(ndev);
>   
>   	phy->autoneg = AUTONEG_DISABLE;
>   	phy->speed = speed;
>   	phy->duplex = fd;
> -	return emac_mdio_phy_start_aneg(phy, dev->phy_dev);
> +	return emac_mdio_phy_start_aneg(phy, ndev->phydev);
>   }
>   
>   static int emac_mdio_poll_link(struct mii_phy *phy)
> @@ -2534,20 +2532,19 @@ static int emac_mdio_poll_link(struct mii_phy *phy)
>   	struct emac_instance *dev = netdev_priv(ndev);
>   	int res;
>   
> -	res = phy_read_status(dev->phy_dev);
> +	res = phy_read_status(ndev->phydev);
>   	if (res) {
>   		dev_err(&dev->ofdev->dev, "link update failed (%d).", res);
>   		return ethtool_op_get_link(ndev);
>   	}
>   
> -	return dev->phy_dev->link;
> +	return ndev->phydev->link;
>   }
>   
>   static int emac_mdio_read_link(struct mii_phy *phy)
>   {
>   	struct net_device *ndev = phy->dev;
> -	struct emac_instance *dev = netdev_priv(ndev);
> -	struct phy_device *phy_dev = dev->phy_dev;
> +	struct phy_device *phy_dev = ndev->phydev;
>   	int res;
>   
>   	res = phy_read_status(phy_dev);
> @@ -2564,10 +2561,9 @@ static int emac_mdio_read_link(struct mii_phy *phy)
>   static int emac_mdio_init_phy(struct mii_phy *phy)
>   {
>   	struct net_device *ndev = phy->dev;
> -	struct emac_instance *dev = netdev_priv(ndev);
>   
> -	phy_start(dev->phy_dev);
> -	return phy_init_hw(dev->phy_dev);
> +	phy_start(ndev->phydev);
> +	return phy_init_hw(ndev->phydev);
>   }
>   
>   static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
> @@ -2622,26 +2618,28 @@ static int emac_dt_mdio_probe(struct emac_instance *dev)
>   static int emac_dt_phy_connect(struct emac_instance *dev,
>   			       struct device_node *phy_handle)
>   {
> +	struct phy_device *phy_dev;
> +
>   	dev->phy.def = devm_kzalloc(&dev->ofdev->dev, sizeof(*dev->phy.def),
>   				    GFP_KERNEL);
>   	if (!dev->phy.def)
>   		return -ENOMEM;
>   
> -	dev->phy_dev = of_phy_connect(dev->ndev, phy_handle, &emac_adjust_link,
> +	phy_dev = of_phy_connect(dev->ndev, phy_handle, &emac_adjust_link,
>   				      0, dev->phy_mode);
> -	if (!dev->phy_dev) {
> +	if (!phy_dev) {
>   		dev_err(&dev->ofdev->dev, "failed to connect to PHY.\n");
>   		return -ENODEV;
>   	}
>   
> -	dev->phy.def->phy_id = dev->phy_dev->drv->phy_id;
> -	dev->phy.def->phy_id_mask = dev->phy_dev->drv->phy_id_mask;
> -	dev->phy.def->name = dev->phy_dev->drv->name;
> +	dev->phy.def->phy_id = phy_dev->drv->phy_id;
> +	dev->phy.def->phy_id_mask = phy_dev->drv->phy_id_mask;
> +	dev->phy.def->name = phy_dev->drv->name;
>   	dev->phy.def->ops = &emac_dt_mdio_phy_ops;
>   	ethtool_convert_link_mode_to_legacy_u32(&dev->phy.features,
> -						dev->phy_dev->supported);
> -	dev->phy.address = dev->phy_dev->mdio.addr;
> -	dev->phy.mode = dev->phy_dev->interface;
> +						phy_dev->supported);
> +	dev->phy.address = phy_dev->mdio.addr;
> +	dev->phy.mode = phy_dev->interface;
>   	return 0;
>   }
>   
> @@ -2695,11 +2693,11 @@ static int emac_init_phy(struct emac_instance *dev)
>   				return res;
>   
>   			res = of_phy_register_fixed_link(np);
> -			dev->phy_dev = of_phy_find_device(np);
> -			if (res || !dev->phy_dev)
> +			ndev->phydev = of_phy_find_device(np);
> +			if (res || !ndev->phydev)
>   				return res ? res : -EINVAL;
>   			emac_adjust_link(dev->ndev);
> -			put_device(&dev->phy_dev->mdio.dev);
> +			put_device(&ndev->phydev->mdio.dev);
>   		}
>   		return 0;
>   	}
> @@ -3254,9 +3252,6 @@ static void emac_remove(struct platform_device *ofdev)
>   	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII))
>   		zmii_detach(dev->zmii_dev, dev->zmii_port);
>   
> -	if (dev->phy_dev)
> -		phy_disconnect(dev->phy_dev);
> -

Hi,

I guess that this call was to balance the of_phy_connect() from 
emac_dt_phy_connect().

Is it ok to just remove this phy_disconnect()?

CJ

>   	busy_phy_map &= ~(1 << dev->phy.address);
>   	DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
>   
> diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
> index f4bd4cd8ac4a..b820a4f6e8c7 100644
> --- a/drivers/net/ethernet/ibm/emac/core.h
> +++ b/drivers/net/ethernet/ibm/emac/core.h
> @@ -188,9 +188,6 @@ struct emac_instance {
>   	struct emac_instance		*mdio_instance;
>   	struct mutex			mdio_lock;
>   
> -	/* Device-tree based phy configuration */
> -	struct phy_device		*phy_dev;
> -
>   	/* ZMII infos if any */
>   	u32				zmii_ph;
>   	u32				zmii_port;


