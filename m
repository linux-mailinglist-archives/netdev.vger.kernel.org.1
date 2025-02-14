Return-Path: <netdev+bounces-166272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1694FA354B9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C007A12FD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 02:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA9136326;
	Fri, 14 Feb 2025 02:30:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F5171C9;
	Fri, 14 Feb 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500218; cv=none; b=QOxWEFqwckSgFuKlHR1fMC3x55u2+AM4kT0M3Gy+xYYcPhGth9JDD4mU24TLEMBD041/CadVDPHY0Yv/ct7dG5Vyj2FEC7FN7oM8Vf8LhaO7PK4CzkXrZO3BkQWV1pMBjQ9PqY1BvDvjGrYknU0ZkpV7TPEWIfoNgg86W4tdK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500218; c=relaxed/simple;
	bh=sFpDGUnerwF3suoWQ9Vhbi6FtbcRuLTbWnx0G65op8Y=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u02X0OwUJrxhF8ARwBsk7di7z5fUbnH77O+yS0pMcZRPRJvZIB6ctlol7xKyZyHSpyY/hyHhPhdOJJ/jdoC3N0wuIRrDp6O4FNQVYXct3TsmgE2ipFFU+gdNfEjlz92uUw4GTyYtjnKnoOAQu6Itj70vVBfO3jEQUn/xlq/yGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YvGCn34V0z22mtc;
	Fri, 14 Feb 2025 10:27:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B3DB1A0188;
	Fri, 14 Feb 2025 10:30:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 10:30:11 +0800
Message-ID: <26c18304-5f91-4a15-b8f2-49b7ba36bc57@huawei.com>
Date: Fri, 14 Feb 2025 10:30:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] net: hibmcge: Add ioctl supported in this
 module
To: Andrew Lunn <andrew@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-8-shaojijie@huawei.com>
 <c1d557b6-7f11-449e-aff7-dad974e1c7c9@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <c1d557b6-7f11-449e-aff7-dad974e1c7c9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/14 4:13, Andrew Lunn wrote:
> On Thu, Feb 13, 2025 at 11:55:29AM +0800, Jijie Shao wrote:
>> This patch implements the ioctl interface to
>> read and write the PHY register.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   .../net/ethernet/hisilicon/hibmcge/hbg_main.c  | 18 ++++++++++++++++++
>>   .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c  | 10 ++++++++++
>>   .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h  |  2 ++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> index 78999d41f41d..afd04ed65eee 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> @@ -273,6 +273,23 @@ static netdev_features_t hbg_net_fix_features(struct net_device *netdev,
>>   	return features & HBG_SUPPORT_FEATURES;
>>   }
>>   
>> +static int hbg_net_eth_ioctl(struct net_device *dev, struct ifreq *ifr, s32 cmd)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(dev);
>> +
>> +	if (test_bit(HBG_NIC_STATE_RESETTING, &priv->state))
>> +		return -EBUSY;
>> +
>> +	switch (cmd) {
>> +	case SIOCGMIIPHY:
>> +	case SIOCGMIIREG:
>> +	case SIOCSMIIREG:
>> +		return hbg_mdio_ioctl(priv, ifr, cmd);
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
> No need for this switch statement. phy_mii_ioctl() will return
> EOPNOTSUPP for any it does not support.
>
> The general structure of an IOCTL handler is to have a switch
> statements for any IOCTL which are handled at this level and the
> default: case then calls into the next layer down.
>
>> +int hbg_mdio_ioctl(struct hbg_priv *priv, struct ifreq *ifr, int cmd)
>> +{
>> +	struct hbg_mac *mac = &priv->mac;
>> +
>> +	if (!mac->phydev)
>> +		return -ENODEV;
>> +
>> +	return phy_mii_ioctl(mac->phydev, ifr, cmd);
> phy_do_ioctl(). This is assuming you follow the normal pattern of
> keeping the phydev pointer in the net_device structure.
>
> 	Andrew

Yes, of course

So I think I can just use:
  .ndo_eth_ioctl = phy_do_ioctl,

No other code is required.

Thanks,
Jijie Shao


