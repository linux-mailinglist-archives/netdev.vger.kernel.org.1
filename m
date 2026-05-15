Return-Path: <netdev+bounces-288150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEUvDsp6BmqFkAIAu9opvQ
	(envelope-from <netdev+bounces-288150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:45:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7D54883C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36E17302F3AC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54215263C9F;
	Fri, 15 May 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iWpYpmae"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4311DF26E;
	Fri, 15 May 2026 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809539; cv=none; b=P/Ha4yNQxJq0OBx3F4vF/b9rvvqHeHgxZTEysjCiHQjV+DNH2FhZve4VtmhPidP0wgHRFVBN25ycY6mC3uap/3gbfqT25WII1Wm8AmGR0isAVc5ulfU5hSZzoUdVJN6rXoG1o35HxOmLsUKJ+DzB6sCxGmuXgFmOTxy3+r+iJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809539; c=relaxed/simple;
	bh=HojsEqe/ZE00/5FtnUWKwLEEonCZRaCPMwEdROaACyg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B12YHqFRlAyDbWyXK+foQiwYY3B8Z5JXEof2OpcpKK2ESseObPhx/y5s2HB3AuJ1katVOXI5NdCwshAteSsHABm6qtGHB8V8dkMGnSDK5MDDajqhXbVKC13BxoHaDnzFLj1MvbYUGjv/VbCgRRdtJdp5EIuxyNwxpm8sKtwFD6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iWpYpmae; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NZylT/MpD46LKACFxAI54Gx5Q6OyGg4L2emvwO6hNhg=;
	b=iWpYpmae1UUwAnXvW0heug3y+zzckKABnYfamrs0h15gKqFSZY1Lmnylrkq8eNl/mCeH2XeT7
	70Tm8ow71ZkdNHpr2E5t72IRO8pAV/dUfzPKGscH6kwY4AGR9zrY+mpFlcpiDHz3KAiNn8qtkgl
	c6dyf/YlTqrgD9c6boZVMeg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gGqZl14DFzRhTs;
	Fri, 15 May 2026 09:37:51 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E446C4056A;
	Fri, 15 May 2026 09:45:28 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 15 May 2026 09:45:28 +0800
Message-ID: <c61ee5db-2578-401f-a4fb-f2fb697af731@huawei.com>
Date: Fri, 15 May 2026 09:45:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: hibmcge: fix incorrect packets in the RX path
 issue
To: Jakub Kicinski <kuba@kernel.org>
References: <20260512123456.3786635-1-shaojijie@huawei.com>
 <20260514171621.02b2ffb1@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260514171621.02b2ffb1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Queue-Id: DCD7D54883C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288150-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action


on 2026/5/15 8:16, Jakub Kicinski wrote:
> On Tue, 12 May 2026 20:34:56 +0800 Jijie Shao wrote:
>> Therefore, this patch disables the Relaxed Ordering to ensure the
>> strict order of packets and descriptors.
>>
>> Additionally, during the process of analyzing the issue,
>> it was discovered that the position of dma_rmb() was incorrect.
>> It should first execute dma_sync_single_for_cpu(), and then dma_rmb().
>> This patch has also made the corresponding modifications.
> Should be a separate patch.

ok

>
>> Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 4 +++-
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 6 +++---
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> index 068da2fd1fea..5b91b596349c 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> @@ -420,6 +420,8 @@ static int hbg_pci_init(struct pci_dev *pdev)
>>   		return -ENOMEM;
>>   
>>   	pci_set_master(pdev);
>> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
>> +				   PCI_EXP_DEVCTL_RELAX_EN);
>>   	return 0;
>>   }
>>   
>> @@ -525,4 +527,4 @@ module_exit(hbg_module_exit);
>>   MODULE_LICENSE("GPL");
>>   MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
>>   MODULE_DESCRIPTION("hibmcge driver");
>> -MODULE_VERSION("1.0");
>> +MODULE_VERSION("2.0");
> Please don't change MODULE_VERSIONs they are meaningless for in-tree
> modules.

Our users typically compile the driver as a separate ko (CONFIG_HIBMCGE=M).
I want to use the version to quickly determine whether the user's driver code has this patch.

Thanks,
Jijie Shao


