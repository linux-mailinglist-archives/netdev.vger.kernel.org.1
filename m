Return-Path: <netdev+bounces-245120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FECC727E
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9394304D449
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558043BB813;
	Wed, 17 Dec 2025 10:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FAB3BB807;
	Wed, 17 Dec 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967829; cv=none; b=KfnH8Zzg3t6Js4TdBUvRDx09wyXGugreI6hNisEwn3vHmYxUixqJWg28IZzyFtTVpBdZTg7dJ4SW2WA/7Ri/6hOaCXGKMi8/L48CMfl3yTwpq+Bp69d1tb36n2BqwzxLeosUOfScRmbMWwJb8mRjcNCOEYdNl9G14+MNWrha/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967829; c=relaxed/simple;
	bh=ZAurbEn4Rjr/4IqGe33WeHKAIf4V/9sq6tfp6SS8Jc4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VroGwBOy81e7KJayjrA4H+0aICAXURuX8a7sdGosXCF/WVpKC+w6xOMdSdxHdiSp2s1b/Ld7+vCfqAM4WxkYbpbOyR8dh/b8surkPwxXJfy4eIqPtmK7uCx5kN5h1/DlcdJSjR2/9+hhcre88acJqPWNc9pDU4oJmCsBXNWKjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWVbB5PQzzHnGdQ;
	Wed, 17 Dec 2025 18:36:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C116C4056A;
	Wed, 17 Dec 2025 18:37:03 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 10:37:02 +0000
Date: Wed, 17 Dec 2025 10:37:01 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 1/6] net: phy: change of_phy_leds() to
 fwnode_phy_leds()
Message-ID: <20251217103701.000066f8@huawei.com>
In-Reply-To: <20251215125705.1567527-2-shaojijie@huawei.com>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
	<20251215125705.1567527-2-shaojijie@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 15 Dec 2025 20:57:00 +0800
Jijie Shao <shaojijie@huawei.com> wrote:

> Change of_phy_leds() to fwnode_phy_leds(), to support
> of node, acpi node, and software node together.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

One minor suggestion inline. It is a 'while you are here'
and whilst there are uses of the _scoped loops
in drivers/net I'm not sure how much appetite there is
for using them wider.

Jonathan


> ---
>  drivers/net/phy/phy_device.c | 37 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 81984d4ebb7c..c5ce057f88ff 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c


> -static int of_phy_leds(struct phy_device *phydev)
> +static int fwnode_phy_leds(struct phy_device *phydev)
>  {
> -	struct device_node *node = phydev->mdio.dev.of_node;
> -	struct device_node *leds;
> +	struct fwnode_handle *fwnode = dev_fwnode(&phydev->mdio.dev);
> +	struct fwnode_handle *leds, *led;
>  	int err;
>  
> -	if (!IS_ENABLED(CONFIG_OF_MDIO))
> -		return 0;
> -
> -	if (!node)
> +	if (!fwnode)
>  		return 0;
>  
> -	leds = of_get_child_by_name(node, "leds");
> +	leds = fwnode_get_named_child_node(fwnode, "leds");
>  	if (!leds)
>  		return 0;
>  
> @@ -3311,17 +3308,17 @@ static int of_phy_leds(struct phy_device *phydev)
>  		goto exit;
>  	}
>  
> -	for_each_available_child_of_node_scoped(leds, led) {
> -		err = of_phy_led(phydev, led);
> +	fwnode_for_each_available_child_node(leds, led) {

Maybe use the _scoped version to simplify this a little given
you are changing it.

> +		err = fwnode_phy_led(phydev, led);
>  		if (err) {
> -			of_node_put(leds);
> +			fwnode_handle_put(leds);
>  			phy_leds_unregister(phydev);
>  			return err;
>  		}
>  	}
>  
>  exit:
> -	of_node_put(leds);
> +	fwnode_handle_put(leds);
>  	return 0;
>  }
>  
> @@ -3516,7 +3513,7 @@ static int phy_probe(struct device *dev)
>  	 * LEDs for them.
>  	 */
>  	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
> -		err = of_phy_leds(phydev);
> +		err = fwnode_phy_leds(phydev);
>  
>  out:
>  	/* Re-assert the reset signal on error */


