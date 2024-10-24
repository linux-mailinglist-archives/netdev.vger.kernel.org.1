Return-Path: <netdev+bounces-138649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098189AE78B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BB628A77C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D61EB9FF;
	Thu, 24 Oct 2024 14:06:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811B1E285D;
	Thu, 24 Oct 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778783; cv=none; b=SCh9EKYF1DNvaHpdbok60vFWaJlQx2ISGkD/u2j2l9KvG99Oz/V9F3T9rM3+NnvLsOp3Qd+OD2ixgRC2kXS7xTXUABoZsOmjwTZ2OinELV9w0Ir1vOa4iSvvsfIr/4bHjG0xX86U7vydyEimc1uBRMti+jVObaJOClBPAy6cq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778783; c=relaxed/simple;
	bh=HtTUQ2nfCVxqvs52SvfCUte+akCJyiK2RSivJbAGDn4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eBwUFPPoIPelZX4s7wVyBQt4zJ0+km2XVqAAr8it8QfhPe8sBksn4TozeL7IlWALfjZHv1KUnCm0pFbla4qdLIXB3xeNH+v+nWnPZRWIbsovz5aKfUJxCRrB7zRun0YBqUuegcL/xAY9wkWRa3Z1BdjppSJwfLaWKxlEggAQFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZ72C51ZXzpXM8;
	Thu, 24 Oct 2024 22:04:19 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D7E41800E4;
	Thu, 24 Oct 2024 22:06:16 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 22:06:15 +0800
Message-ID: <0c0de40c-7bf3-4d98-9d25-9b4f36a91e0b@huawei.com>
Date: Thu, 24 Oct 2024 22:06:14 +0800
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
Subject: Re: [PATCH net-next 2/7] net: hibmcge: Add debugfs supported in this
 module
To: Andrew Lunn <andrew@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-3-shaojijie@huawei.com>
 <924e9c5c-f4a8-4db5-bbe8-964505191849@lunn.ch>
 <5375ce1b-8778-4696-a530-1a002f7ec4c7@huawei.com>
 <6103ee00-175d-4a35-9081-2c500ad3c123@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <6103ee00-175d-4a35-9081-2c500ad3c123@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/24 20:05, Andrew Lunn wrote:
>>>> +	seq_printf(s, "mdio frequency: %u\n", specs->mdio_frequency);
>>> Is this interesting? Are you clocking it greater than 2.5MHz?
>> MDIO controller supports 1MHz, 2.5MHz, 12.5MHz, and 25MHz
>> Of course, we chose and tested 2.5M in actual work, but this can be modified.
> How? What API are you using it allow it to be modified? Why cannot you
> get the value using the same API?

This frequency cannot be modified dynamically.
There are some specification registers that store some initialization configuration parameters
written by the BMC, such as the default MAC address and hardware FIFO size and mdio frequency.

When the device is in prob, the driver reads the related configuration information and
initializes the device based on the configuration.

>
>> We requested three interrupts: "tx", "rx", "err"
>> The err interrupt is a summary interrupt. We distinguish different errors
>> based on the status register and mask.
>>
>> With "cat /proc/interrupts | grep hibmcge",
>> we can't distinguish the detailed cause of the error,
>> so we added this file to debugfs.
>>
>> the following effects are achieved:
>> [root@localhost sjj]# cat /sys/kernel/debug/hibmcge/0000\:83\:00.1/irq_info
>> RX                  : is enabled: true, print: false, count: 2
>> TX                  : is enabled: true, print: false, count: 0
>> MAC_MII_FIFO_ERR    : is enabled: false, print: true, count: 0
>> MAC_PCS_RX_FIFO_ERR : is enabled: false, print: true, count: 0
>> MAC_PCS_TX_FIFO_ERR : is enabled: false, print: true, count: 0
>> MAC_APP_RX_FIFO_ERR : is enabled: false, print: true, count: 0
>> MAC_APP_TX_FIFO_ERR : is enabled: false, print: true, count: 0
>> SRAM_PARITY_ERR     : is enabled: true, print: true, count: 0
>> TX_AHB_ERR          : is enabled: true, print: true, count: 0
>> RX_BUF_AVL          : is enabled: true, print: false, count: 0
>> REL_BUF_ERR         : is enabled: true, print: true, count: 0
>> TXCFG_AVL           : is enabled: true, print: false, count: 0
>> TX_DROP             : is enabled: true, print: false, count: 0
>> RX_DROP             : is enabled: true, print: false, count: 0
>> RX_AHB_ERR          : is enabled: true, print: true, count: 0
>> MAC_FIFO_ERR        : is enabled: true, print: false, count: 0
>> RBREQ_ERR           : is enabled: true, print: false, count: 0
>> WE_ERR              : is enabled: true, print: false, count: 0
>>
>>
>> The irq framework of hibmcge driver also includes tx/rx interrupts.
>> Therefore, these interrupts are not distinguished separately in debugfs.
> Please make this a patch of its own, and include this in the commit
> message.
>
> Ideally you need to show there is no standard API for what you want to
> put into debugfs, because if there is a standard API, you don't need
> debugfs...

Because standard API don't meet my needs, I added detailed interrupt information to debugfs.
I'll add a detailed description to the commit message of v2.

>
>>>> +static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
>>>> +{
>>>> +	struct net_device *netdev = dev_get_drvdata(s->private);
>>>> +	struct hbg_priv *priv = netdev_priv(netdev);
>>>> +
>>>> +	seq_printf(s, "event handling state: %s\n",
>>>> +		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_EVENT_HANDLING,
>>>> +					     &priv->state)));
>>>> +
>>>> +	seq_printf(s, "tx timeout cnt: %llu\n", priv->stats.tx_timeout_cnt);
>>> Don't you have this via ethtool -S ?
>> Although tx_timeout_cnt is a statistical item, it is not displayed in the ethtool -S.
> Why?
>
> 	Andrew

This was decided by our internal discussion before,
and we'll revisit it, and move it to ethtool -S in the next version if it's okay with us.

Thanks,
Jijie Shao


