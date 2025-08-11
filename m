Return-Path: <netdev+bounces-212460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C8B20A51
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01B17AA87E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E632DCF41;
	Mon, 11 Aug 2025 13:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00F314658D;
	Mon, 11 Aug 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919306; cv=none; b=WHI+fbm/NUTrL7jF+ENodKkx+yJb6Lpys2wD6EGgl9aUGfyRmz88azqWU+e3YNhbfgWjzlCi2P+aOwyVpAG13DOwD/nHuOJ7mF6pYgYwsnL8W36yUED9TvCFPMw6L09oH3C862jU4PQUY3bT7UpCi2ATkl56JaLb8sJIRUaLgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919306; c=relaxed/simple;
	bh=P/6clgUfwuZRazSUQ4qaigehTvJmYc83jk/AMjBeDOo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j+CdqrQBcDnruBCYHZDyvYFNV7wycriW/sLHtDaJQSCPF8pqMvp/Y/Kf5skNTVAvx/sD2H0Ndjv8pvwhJZDTu/4SoX1xKV69POb5bEkNEtJkbmFHRoA6paIIoUlfnIMsyZso+txgNwWOmko97IzjN6JjpOyawgkAdbqY+3MtRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c0w7s1X92z1R8xV;
	Mon, 11 Aug 2025 21:14:01 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F9641A0188;
	Mon, 11 Aug 2025 21:16:50 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 21:16:49 +0800
Message-ID: <a5876695-4c10-4789-8dda-8591d71e882d@huawei.com>
Date: Mon, 11 Aug 2025 21:16:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: Add support for PHY
 LEDs on YT8521
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <Frank.Sae@motor-comm.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>
References: <20250716100041.2833168-1-shaojijie@huawei.com>
 <20250716100041.2833168-2-shaojijie@huawei.com> <7978337.lvqk35OSZv@diego>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <7978337.lvqk35OSZv@diego>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/8/7 17:50, Heiko Stübner wrote:
> Am Mittwoch, 16. Juli 2025, 12:00:40 Mitteleuropäische Sommerzeit schrieb Jijie Shao:
>> Add minimal LED controller driver supporting
>> the most common uses with the 'netdev' trigger.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> On a Qnap TS233 NAS using this phy, I get the expected device LEDs
> to light up (with appropriate config via sysfs), so
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
> (haven't found a v2 yet yesterday, so hopefully still the right thread
> to reply to ;-) )
>
> Thanks
> Heiko

Thank you for testing; I will resend this patch shortly.

>
>
>> ---
>>   drivers/net/phy/motorcomm.c | 120 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 120 insertions(+)
>>
>> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
>> index 0e91f5d1a4fd..e1a1c3a1c9d0 100644
>> --- a/drivers/net/phy/motorcomm.c
>> +++ b/drivers/net/phy/motorcomm.c
>> @@ -213,6 +213,23 @@
>>   #define YT8521_RC1R_RGMII_2_100_NS		14
>>   #define YT8521_RC1R_RGMII_2_250_NS		15
>>   
>> +/* LED CONFIG */
>> +#define YT8521_MAX_LEDS				3
>> +#define YT8521_LED0_CFG_REG			0xA00C
>> +#define YT8521_LED1_CFG_REG			0xA00D
>> +#define YT8521_LED2_CFG_REG			0xA00E
>> +#define YT8521_LED_ACT_BLK_IND			BIT(13)
>> +#define YT8521_LED_FDX_ON_EN			BIT(12)
>> +#define YT8521_LED_HDX_ON_EN			BIT(11)
>> +#define YT8521_LED_TXACT_BLK_EN			BIT(10)
>> +#define YT8521_LED_RXACT_BLK_EN			BIT(9)
>> +/* 1000Mbps */
>> +#define YT8521_LED_GT_ON_EN			BIT(6)
>> +/* 100Mbps */
>> +#define YT8521_LED_HT_ON_EN			BIT(5)
>> +/* 10Mbps */
>> +#define YT8521_LED_BT_ON_EN			BIT(4)
>> +
>>   #define YTPHY_MISC_CONFIG_REG			0xA006
>>   #define YTPHY_MCR_FIBER_SPEED_MASK		BIT(0)
>>   #define YTPHY_MCR_FIBER_1000BX			(0x1 << 0)
>> @@ -1681,6 +1698,106 @@ static int yt8521_config_init(struct phy_device *phydev)
>>   	return phy_restore_page(phydev, old_page, ret);
>>   }
>>   
>> +static const unsigned long supported_trgs = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
>> +					     BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
>> +					     BIT(TRIGGER_NETDEV_LINK)        |
>> +					     BIT(TRIGGER_NETDEV_LINK_10)     |
>> +					     BIT(TRIGGER_NETDEV_LINK_100)    |
>> +					     BIT(TRIGGER_NETDEV_LINK_1000)   |
>> +					     BIT(TRIGGER_NETDEV_RX)          |
>> +					     BIT(TRIGGER_NETDEV_TX));
>> +
>> +static int yt8521_led_hw_is_supported(struct phy_device *phydev, u8 index,
>> +				      unsigned long rules)
>> +{
>> +	if (index >= YT8521_MAX_LEDS)
>> +		return -EINVAL;
>> +
>> +	/* All combinations of the supported triggers are allowed */
>> +	if (rules & ~supported_trgs)
>> +		return -EOPNOTSUPP;
>> +
>> +	return 0;
>> +}
>> +
>> +static int yt8521_led_hw_control_set(struct phy_device *phydev, u8 index,
>> +				     unsigned long rules)
>> +{
>> +	u16 val = 0;
>> +
>> +	if (index >= YT8521_MAX_LEDS)
>> +		return -EINVAL;
>> +
>> +	if (test_bit(TRIGGER_NETDEV_LINK, &rules)) {
>> +		val |= YT8521_LED_BT_ON_EN;
>> +		val |= YT8521_LED_HT_ON_EN;
>> +		val |= YT8521_LED_GT_ON_EN;
>> +	}
>> +
>> +	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
>> +		val |= YT8521_LED_BT_ON_EN;
>> +
>> +	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
>> +		val |= YT8521_LED_HT_ON_EN;
>> +
>> +	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
>> +		val |= YT8521_LED_GT_ON_EN;
>> +
>> +	if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
>> +		val |= YT8521_LED_HDX_ON_EN;
>> +
>> +	if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
>> +		val |= YT8521_LED_FDX_ON_EN;
>> +
>> +	if (test_bit(TRIGGER_NETDEV_TX, &rules) ||
>> +	    test_bit(TRIGGER_NETDEV_RX, &rules))
>> +		val |= YT8521_LED_ACT_BLK_IND;
>> +
>> +	if (test_bit(TRIGGER_NETDEV_TX, &rules))
>> +		val |= YT8521_LED_TXACT_BLK_EN;
>> +
>> +	if (test_bit(TRIGGER_NETDEV_RX, &rules))
>> +		val |= YT8521_LED_RXACT_BLK_EN;
>> +
>> +	return ytphy_write_ext(phydev, YT8521_LED0_CFG_REG + index, val);
>> +}
>> +
>> +static int yt8521_led_hw_control_get(struct phy_device *phydev, u8 index,
>> +				     unsigned long *rules)
>> +{
>> +	int val;
>> +
>> +	if (index >= YT8521_MAX_LEDS)
>> +		return -EINVAL;
>> +
>> +	val = ytphy_read_ext(phydev, YT8521_LED0_CFG_REG + index);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	if (val & YT8521_LED_TXACT_BLK_EN)
>> +		set_bit(TRIGGER_NETDEV_TX, rules);
>> +
>> +	if (val & YT8521_LED_RXACT_BLK_EN)
>> +		set_bit(TRIGGER_NETDEV_RX, rules);
>> +
>> +	if (val & YT8521_LED_FDX_ON_EN)
>> +		set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
>> +
>> +	if (val & YT8521_LED_HDX_ON_EN)
>> +		set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
>> +
>> +	if (val & YT8521_LED_GT_ON_EN)
>> +		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
>> +
>> +	if (val & YT8521_LED_HT_ON_EN)
>> +		set_bit(TRIGGER_NETDEV_LINK_100, rules);
>> +
>> +	if (val & YT8521_LED_BT_ON_EN)
>> +		set_bit(TRIGGER_NETDEV_LINK_10, rules);
>> +
>> +	return 0;
>> +}
>> +
>>   static int yt8531_config_init(struct phy_device *phydev)
>>   {
>>   	struct device_node *node = phydev->mdio.dev.of_node;
>> @@ -2920,6 +3037,9 @@ static struct phy_driver motorcomm_phy_drvs[] = {
>>   		.soft_reset	= yt8521_soft_reset,
>>   		.suspend	= yt8521_suspend,
>>   		.resume		= yt8521_resume,
>> +		.led_hw_is_supported = yt8521_led_hw_is_supported,
>> +		.led_hw_control_set = yt8521_led_hw_control_set,
>> +		.led_hw_control_get = yt8521_led_hw_control_get,
>>   	},
>>   	{
>>   		PHY_ID_MATCH_EXACT(PHY_ID_YT8531),
>>
>
>
>
>

