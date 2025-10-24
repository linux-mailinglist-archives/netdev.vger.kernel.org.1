Return-Path: <netdev+bounces-232355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B139AC048BB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAFB3BA818
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C391923A9AE;
	Fri, 24 Oct 2025 06:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C581EE7DC;
	Fri, 24 Oct 2025 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288257; cv=none; b=kp7FZIcwrj4W+pMjOrfh0WTon48GYaMT23KrL4xoVacy6cqdjO8Woz7IDlWARAtUi4H5HvnVQaJsJuW+ysL/kz25DLrn18sYFcw/8QaH5gAnv39t4BmW+1M55Pa/r+fx7ubxfS50O8fpHb7/9YY+A6KbVKbpjz9V5e955o76rpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288257; c=relaxed/simple;
	bh=KJpXpAKN9nyKg+2cpmeiSgbQlrzUvUr7V7KWuCjx5Wc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Elph4DtkpOPcCC0pCuBVxZv7uDL2G46xbHb8ibGPJHwHEqQk+cn6tXYvcZXrpYNY5kTItuGtPoWUz+vYckUW7juNEaI6WdM1ZzOkLAIUSYT1oHmFifU2jDD0jHZcsnyqrs2sa4IK5aTLEBE799p7x/6k01XF88O4rGHyNnQfXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ctCtJ3JgJz2Cg9b;
	Fri, 24 Oct 2025 14:39:20 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 842A21A016C;
	Fri, 24 Oct 2025 14:44:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 14:44:11 +0800
Message-ID: <b89389e7-7939-4c10-8522-6c8b6ce71b77@huawei.com>
Date: Fri, 24 Oct 2025 14:44:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/3] net: hibmcge: remove unnecessary check for
 np_link_fail in scenarios without phy.
To: Jacob Keller <jacob.e.keller@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-3-shaojijie@huawei.com>
 <ebc90ce4-382b-4a0f-891a-5305599f9ae2@intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ebc90ce4-382b-4a0f-891a-5305599f9ae2@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/10/24 9:10, Jacob Keller wrote:
>
> On 10/21/2025 7:00 AM, Jijie Shao wrote:
>> hibmcge driver uses fixed_phy to configure scenarios without PHY,
>> where the driver is always in a linked state. However,
>> there might be no link in hardware, so the np_link error
>> is detected in hbg_hw_adjust_link(), which can cause abnormal logs.
>>
> Perhaps I am missing something here. You mention the driver is always in
> a linked state, but that there could be no link in hardware?
>
> I'm not sure I properly understand whats going wrong here..

No, fixed_phy is a fake PHY that is always in link state and will call adjust_link().

If you are interested, you can take a look at the code for initializing the fixed PHY
in the hibmcge driver: hbg_fixed_phy_init()

Thanks,
Jijie Shao

>
>> Therefore, in scenarios without a PHY, the driver no longer
>> checks the np_link status.
>>
>> Fixes: 1d7cd7a9c69c ("net: hibmcge: support scenario without PHY")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h | 1 +
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c     | 3 +++
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c   | 1 -
>>   3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
>> index ea09a09c451b..2097e4c2b3d7 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
>> @@ -17,6 +17,7 @@
>>   #define HBG_PCU_CACHE_LINE_SIZE		32
>>   #define HBG_TX_TIMEOUT_BUF_LEN		1024
>>   #define HBG_RX_DESCR			0x01
>> +#define HBG_NO_PHY			0xFF
>>   
>>   #define HBG_PACKET_HEAD_SIZE	((HBG_RX_SKIP1 + HBG_RX_SKIP2 + \
>>   				  HBG_RX_DESCR) * HBG_PCU_CACHE_LINE_SIZE)
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
>> index d0aa0661ecd4..d6e8ce8e351a 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
>> @@ -244,6 +244,9 @@ void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
>>   
>>   	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
>>   
>> +	if (priv->mac.phy_addr == HBG_NO_PHY)
>> +		return;
>> +
>>   	/* wait MAC link up */
>>   	ret = readl_poll_timeout(priv->io_base + HBG_REG_AN_NEG_STATE_ADDR,
>>   				 link_status,
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
>> index 37791de47f6f..b6f0a2780ea8 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
>> @@ -20,7 +20,6 @@
>>   #define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
>>   
>>   #define HBG_NP_LINK_FAIL_RETRY_TIMES	5
>> -#define HBG_NO_PHY			0xFF
>>   
>>   static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
>>   {

