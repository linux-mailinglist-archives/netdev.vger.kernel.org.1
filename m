Return-Path: <netdev+bounces-202522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D288AEE1B3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E41E7A58A2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5A28C874;
	Mon, 30 Jun 2025 14:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23E28C01E;
	Mon, 30 Jun 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295527; cv=none; b=X5hp3yLxa3BZ7IIOAKxsmv93qWo9QPaq8LTyBTip+2XK2261lqhG5zanBlg0VgQGhit6DKjSDJldKzBry+Zds4H7IoF0KlOvD6HcoIi65qeCPa4iLJqTVgq9FyZLBKB2CqhNsVe26FMKS+ZSaYuk3IdrXIs2klxqvT3tiz1/Qgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295527; c=relaxed/simple;
	bh=qWIAMHOpGNsFAIlRkgffsmb4NjQSrujnD+g2NtixzSA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gpeeB+ClySThj5ljIRkb42P8aiQ0PyxrcjOBq03g2QMna2JTkrD4t0j0msuYY20iUqMTFSNTK6KxmGqhEI+FtHHzYjcec+o7sL82zV6xfyahiWA2DFANAnA6ug1uSZWyjDmxAIY6jN0kKV33lpbWCrkU0b0i52dOUnXIwOofWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bW8P32D4Xz1R8j9;
	Mon, 30 Jun 2025 22:56:07 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 851D8140257;
	Mon, 30 Jun 2025 22:58:37 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Jun 2025 22:58:36 +0800
Message-ID: <d591574c-80e5-494d-8b67-7b85594fd821@huawei.com>
Date: Mon, 30 Jun 2025 22:58:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 1/3] net: hibmcge: support scenario without
 PHY
To: Larysa Zaremba <larysa.zaremba@intel.com>
References: <20250626020613.637949-1-shaojijie@huawei.com>
 <20250626020613.637949-2-shaojijie@huawei.com>
 <aGJNHsCMwVLqbAq0@soc-5CG4396X81.clients.intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aGJNHsCMwVLqbAq0@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/30 16:38, Larysa Zaremba wrote:
> On Thu, Jun 26, 2025 at 10:06:11AM +0800, Jijie Shao wrote:
>> Currently, the driver uses phylib to operate PHY by default.
>>
>> On some boards, the PHY device is separated from the MAC device.
>> As a result, the hibmcge driver cannot operate the PHY device.
>>
>> In this patch, the driver determines whether a PHY is available
>> based on register configuration. If no PHY is available,
>> the driver use fixed_phy to register fake phydev.
> uses/will use

Thank you, if I need to send v4 for other reasons, I will modify it together.

>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Some minor cosmetic problems, but overall seems like you nicely incorporated v2
> feedback.
>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
>
>> ---
>> ChangeLog:
>> v2 -> v3:
>>    - Use fixed_phy to re-implement the no-phy scenario, suggested by Andrew Lunn
>>    v2: https://lore.kernel.org/all/20250623034129.838246-1-shaojijie@huawei.com/
>> ---
>>   .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
>> index 42b0083c9193..41558fe7770c 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
>> @@ -2,6 +2,7 @@
>>   // Copyright (c) 2024 Hisilicon Limited.
>>   
>>   #include <linux/phy.h>
>> +#include <linux/phy_fixed.h>
>>   #include <linux/rtnetlink.h>
>>   #include "hbg_common.h"
>>   #include "hbg_hw.h"
>> @@ -19,6 +20,7 @@
>>   #define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
>>   
>>   #define HBG_NP_LINK_FAIL_RETRY_TIMES	5
>> +#define HBG_NO_PHY	0xFF
> Number does not align with one in the previous line.


Because the macro name is much shorter than the above,
there is a tab between the numbers and the name in these two lines.

Thanks,
Jijie Shao

>
>>   
>>   static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
>>   {
>> @@ -229,6 +231,39 @@ void hbg_phy_stop(struct hbg_priv *priv)
>>   	phy_stop(priv->mac.phydev);
>>   }
>>   
>> +static void hbg_fixed_phy_uninit(void *data)
>> +{
>> +	fixed_phy_unregister((struct phy_device *)data);
>> +}
>> +
>> +static int hbg_fixed_phy_init(struct hbg_priv *priv)
>> +{
>> +	struct fixed_phy_status hbg_fixed_phy_status = {
>> +		.link = 1,
>> +		.speed = SPEED_1000,
>> +		.duplex = DUPLEX_FULL,
>> +		.pause = 1,
>> +		.asym_pause = 1,
>> +	};
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct phy_device *phydev;
>> +	int ret;
>> +
>> +	phydev = fixed_phy_register(&hbg_fixed_phy_status, NULL);
>> +	if (IS_ERR(phydev)) {
>> +		dev_err_probe(dev, IS_ERR(phydev),
>> +			      "failed to register fixed PHY device\n");
>> +		return IS_ERR(phydev);
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, hbg_fixed_phy_uninit, phydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	priv->mac.phydev = phydev;
>> +	return hbg_phy_connect(priv);
>> +}
>> +
>>   int hbg_mdio_init(struct hbg_priv *priv)
>>   {
>>   	struct device *dev = &priv->pdev->dev;
>> @@ -238,6 +273,9 @@ int hbg_mdio_init(struct hbg_priv *priv)
>>   	int ret;
>>   
>>   	mac->phy_addr = priv->dev_specs.phy_addr;
>> +	if (mac->phy_addr == HBG_NO_PHY)
>> +		return hbg_fixed_phy_init(priv);
>> +
>>   	mdio_bus = devm_mdiobus_alloc(dev);
>>   	if (!mdio_bus)
>>   		return dev_err_probe(dev, -ENOMEM,
>> -- 
>> 2.33.0
>>
>>

