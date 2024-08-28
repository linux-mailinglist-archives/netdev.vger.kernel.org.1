Return-Path: <netdev+bounces-122762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A843596278C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B8BB20DB3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27B3176259;
	Wed, 28 Aug 2024 12:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8B17556B;
	Wed, 28 Aug 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849071; cv=none; b=LiZTBEwbLkPk/AHHs49CpV6ksdoNZ2OlZ83XnhAl4045s7d27b2l3wgcxOSHjLIT0yU/lLiYWxfnHMzte5lLIFWGqo9Mz15gi0wgJhFRVtqoYPTT67f/olw+oyggD+7116VKP1TO1S5TJatLP6QFmLvCdmgqDL2lklkX2JcG0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849071; c=relaxed/simple;
	bh=t3uywcFGm9o3vmql59YaUgIrzQFBsGFnNKGCEoIWItw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=corNLL2/iAMy6lgn217b3amt6AluwXATbQUftlBAFkNe4XdDr6YQOpoB+PKOUF0AVlVEzgFlMFbsSdzDgXAlHP3MVLchgDYCrZ1U5VMWKvTkawpxyAIpEJ8yoeKsWKS+mHie6Zd5fpvIVNfvPpqt//++ztsnNnMdGL3bRBsjcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv3tb0pftz6H7Wp;
	Wed, 28 Aug 2024 20:41:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 54F3E140447;
	Wed, 28 Aug 2024 20:44:27 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:44:26 +0100
Date: Wed, 28 Aug 2024 13:44:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
Subject: Re: [PATCH net-next v2 06/13] net: phy: Use
 for_each_available_child_of_node_scoped()
Message-ID: <20240828134425.000042c7@Huawei.com>
In-Reply-To: <20240828032343.1218749-7-ruanjinjie@huawei.com>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
	<20240828032343.1218749-7-ruanjinjie@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 11:23:36 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Avoid need to manually handle of_node_put() by using
> for_each_available_child_of_node_scoped(), which can simplfy code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Ah. I see Andrew mentioned he didn't like the __free change
hence you've only done this one. Fair enough I guess.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> - Split into 2 patches.
> ---
>  drivers/net/phy/phy_device.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 243dae686992..560e338b307a 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3407,7 +3407,7 @@ static int of_phy_led(struct phy_device *phydev,
>  static int of_phy_leds(struct phy_device *phydev)
>  {
>  	struct device_node *node = phydev->mdio.dev.of_node;
> -	struct device_node *leds, *led;
> +	struct device_node *leds;
>  	int err;
>  
>  	if (!IS_ENABLED(CONFIG_OF_MDIO))
> @@ -3420,10 +3420,9 @@ static int of_phy_leds(struct phy_device *phydev)
>  	if (!leds)
>  		return 0;
>  
> -	for_each_available_child_of_node(leds, led) {
> +	for_each_available_child_of_node_scoped(leds, led) {
>  		err = of_phy_led(phydev, led);
>  		if (err) {
> -			of_node_put(led);
>  			of_node_put(leds);
>  			phy_leds_unregister(phydev);
>  			return err;


