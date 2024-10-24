Return-Path: <netdev+bounces-138443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7D79AD9A4
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A06AB2228B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 02:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDBB1386DA;
	Thu, 24 Oct 2024 02:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0183D69;
	Thu, 24 Oct 2024 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736403; cv=none; b=ipE9LsXAj7EqiWHRsCjvSgC6bHTRY3Ug3vEzOeQdvG86r4iBU+gnAvECT96uTL/ZuhtELnBQg6Ob3Gc+KoUiTFRgmhOGrD1AkikFV6bkoREDg4PMOYs0lN7dlHPqMQYaGBjcfOwf6DZrA6DP5g5Y5kaJCMxZTL0mryC3JKoD6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736403; c=relaxed/simple;
	bh=qcJBR/6ojF3AtYvRbu8Jv8q91OiVNq1yH2rZf1bKWTQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ItfKjt3x3PVePvkLEEGl9m3/sZDkEXU1MjO9fwirX39LPHM9emp6lN8cp9RThEX0Zus2GJItWRLW8jEfGud1C5TPq2zH1LVBIeVWGGN4d48KazexbB1EYNxaqOdsLnU3YbU8v89MZX7Nm8PQWgkkvJ9cC8o8Zp+ivtCvvGuBtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XYqNT6W3JzQs7x;
	Thu, 24 Oct 2024 10:19:05 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C9E31800A7;
	Thu, 24 Oct 2024 10:19:58 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 10:19:57 +0800
Message-ID: <5375ce1b-8778-4696-a530-1a002f7ec4c7@huawei.com>
Date: Thu, 24 Oct 2024 10:19:55 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <924e9c5c-f4a8-4db5-bbe8-964505191849@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/23 22:00, Andrew Lunn wrote:
>> +static int hbg_dbg_dev_spec(struct seq_file *s, void *unused)
>> +{
>> +	struct net_device *netdev = dev_get_drvdata(s->private);
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +	struct hbg_dev_specs *specs;
>> +
>> +	specs = &priv->dev_specs;
>> +	seq_printf(s, "mac id: %u\n", specs->mac_id);
>> +	seq_printf(s, "phy addr: %u\n", specs->phy_addr);
>> +	seq_printf(s, "mac addr: %pM\n", specs->mac_addr.sa_data);
>> +	seq_printf(s, "vlan layers: %u\n", specs->vlan_layers);
>> +	seq_printf(s, "max frame len: %u\n", specs->max_frame_len);
>> +	seq_printf(s, "min mtu: %u, max mtu: %u\n",
>> +		   specs->min_mtu, specs->max_mtu);
> I think these are all available via standard APIs. There is no need to
> have them in debugfs as well.

Yes, and these specifications are displayed by running the ethtool -d command. You can delete these specifications,
We will discuss internally, there is a high probability that this debugfs file will be deleted in v2.

>
>> +	seq_printf(s, "mdio frequency: %u\n", specs->mdio_frequency);
> Is this interesting? Are you clocking it greater than 2.5MHz?

MDIO controller supports 1MHz, 2.5MHz, 12.5MHz, and 25MHz
Of course, we chose and tested 2.5M in actual work, but this can be modified.

>
>> +static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
>> +{
>> +	struct net_device *netdev = dev_get_drvdata(s->private);
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +	struct hbg_irq_info *info;
>> +	u32 i;
>> +
>> +	for (i = 0; i < priv->vectors.info_array_len; i++) {
>> +		info = &priv->vectors.info_array[i];
>> +		seq_printf(s,
>> +			   "%-20s: is enabled: %s, print: %s, count: %llu\n",
>> +			   info->name,
>> +			   hbg_get_bool_str(hbg_hw_irq_is_enabled(priv,
>> +								  info->mask)),
>> +			   hbg_get_bool_str(info->need_print),
>> +			   info->count);
>> +	}
> How does this differ from what is available already from the IRQ
> subsystem?

We requested three interrupts: "tx", "rx", "err"
The err interrupt is a summary interrupt. We distinguish different errors
based on the status register and mask.

With "cat /proc/interrupts | grep hibmcge",
we can't distinguish the detailed cause of the error,
so we added this file to debugfs.

the following effects are achieved:
[root@localhost sjj]# cat /sys/kernel/debug/hibmcge/0000\:83\:00.1/irq_info
RX                  : is enabled: true, print: false, count: 2
TX                  : is enabled: true, print: false, count: 0
MAC_MII_FIFO_ERR    : is enabled: false, print: true, count: 0
MAC_PCS_RX_FIFO_ERR : is enabled: false, print: true, count: 0
MAC_PCS_TX_FIFO_ERR : is enabled: false, print: true, count: 0
MAC_APP_RX_FIFO_ERR : is enabled: false, print: true, count: 0
MAC_APP_TX_FIFO_ERR : is enabled: false, print: true, count: 0
SRAM_PARITY_ERR     : is enabled: true, print: true, count: 0
TX_AHB_ERR          : is enabled: true, print: true, count: 0
RX_BUF_AVL          : is enabled: true, print: false, count: 0
REL_BUF_ERR         : is enabled: true, print: true, count: 0
TXCFG_AVL           : is enabled: true, print: false, count: 0
TX_DROP             : is enabled: true, print: false, count: 0
RX_DROP             : is enabled: true, print: false, count: 0
RX_AHB_ERR          : is enabled: true, print: true, count: 0
MAC_FIFO_ERR        : is enabled: true, print: false, count: 0
RBREQ_ERR           : is enabled: true, print: false, count: 0
WE_ERR              : is enabled: true, print: false, count: 0


The irq framework of hibmcge driver also includes tx/rx interrupts.
Therefore, these interrupts are not distinguished separately in debugfs.

>
>> +static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
>> +{
>> +	struct net_device *netdev = dev_get_drvdata(s->private);
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +
>> +	seq_printf(s, "event handling state: %s\n",
>> +		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_EVENT_HANDLING,
>> +					     &priv->state)));
>> +
>> +	seq_printf(s, "tx timeout cnt: %llu\n", priv->stats.tx_timeout_cnt);
> Don't you have this via ethtool -S ?

Although tx_timeout_cnt is a statistical item, it is not displayed in the ethtool -S.

>
>> @@ -209,6 +210,10 @@ static int hbg_init(struct hbg_priv *priv)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = hbg_debugfs_init(priv);
>> +	if (ret)
>> +		return ret;
>> +
> There is no need to test the results from debugfs calls.

ok

>
>> +static int __init hbg_module_init(void)
>> +{
>> +	int ret;
>> +
>> +	hbg_debugfs_register();
>> +	ret = pci_register_driver(&hbg_driver);
>> +	if (ret)
>> +		hbg_debugfs_unregister();
> This seems odd. I would expect that each device has its own debugfs,
> there is nothing global.
>
> 	Andrew

Yes, that's how we designed it.
In this, We register and create the root dir of hibmcge,
And in each probe(), device create their own dir using bdf:

/sys/kernel/debug/hibmcge/0000\:83\:00.1/
/sys/kernel/debug/hibmcge/0000\:83\:00.2/

for each device:
[root@localhost sjj]# ls -n /sys/kernel/debug/hibmcge/0000\:83\:00.1/
-r--r--r--. 1 0 0 0 10月 24 09:42 dev_spec
-r--r--r--. 1 0 0 0 10月 24 09:42 irq_info
-r--r--r--. 1 0 0 0 10月 24 09:42 mac_talbe
-r--r--r--. 1 0 0 0 10月 24 09:42 nic_state
-r--r--r--. 1 0 0 0 10月 24 09:42 rx_ring
-r--r--r--. 1 0 0 0 10月 24 09:42 tx_ring


Thanks a lot!
Jijie Shao


