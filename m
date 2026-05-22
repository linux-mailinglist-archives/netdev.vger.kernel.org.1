Return-Path: <netdev+bounces-290637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GE4CbuyD2rmOgYAu9opvQ
	(envelope-from <netdev+bounces-290637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:34:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85A5ADB24
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54AFC300FC5E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89BD246788;
	Fri, 22 May 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a9nb0QVT"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C27202997;
	Fri, 22 May 2026 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413558; cv=none; b=cbP8N+Y8h8zwQamrW7RAyM5goYD0jlK9UcUiVxQZ3TvFUsNFhc5ZlpxrqhvRBX+sgTUdmo8cIJoRxxjY+dmBg82ec0RZOdeD2pCJihJsAB4Zsm+jFvU3tS+JWd6QVecrCiqr3YRJgCSUhtMQhRzxUPe48u4iZrDILIf9iaYOuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413558; c=relaxed/simple;
	bh=I6tFDsviSls0ujJbhE+o0zIxIjbVvq9RV/5NG12trhY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e9q8sT2SFEVwzAfTZxYSALpfl748yk/fKSUY0ac0e3/EfwrN22zkVuGJFL0feQpSzJ0V8da7DgppOCfFDHeLS4NfuSVo5RbhxiqXYZNseWyn4ULU1oP+RON9Ru6vCBONazIYhThS+ACB0WiYc04MvEAcqSJi08uQVaWFNCyWIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a9nb0QVT; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gVprGHcyp7zNtbmaE8h+q0n2zo10k+cWa8PJBUTrGG0=;
	b=a9nb0QVTQ5QW6BdiS0BXtVQxRcAlpksM3cp7FiNzC4yNoBPCUv+fe1cH022eZ5jmRmlH8Qk43
	0XD9I4REf18tfOYgOr34CW9agpBzKp3Kvv+rq0ZEWt6yftEw5tiWvHYauq5R7UuSMFpyPrrCrpE
	w3OKWOJcb1xyUevp7+ztPN8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gM6yB1tnyznTW4;
	Fri, 22 May 2026 09:24:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 70C8540539;
	Fri, 22 May 2026 09:32:34 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 22 May 2026 09:32:33 +0800
Message-ID: <b85d6dd0-f102-4b1f-be10-f75b8cb2cd42@huawei.com>
Date: Fri, 22 May 2026 09:32:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 1/2] net: hibmcge: disable Relaxed Ordering to fix
 RX packet corruption
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>
References: <20260518144253.1568118-1-shaojijie@huawei.com>
 <20260518144253.1568118-2-shaojijie@huawei.com>
 <545dd8a4-662b-49de-a5cf-793d20989571@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <545dd8a4-662b-49de-a5cf-793d20989571@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290637-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A85A5ADB24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


on 2026/5/21 21:54, Paolo Abeni wrote:
> On 5/18/26 4:42 PM, Jijie Shao wrote:
>> When SMMU is disabled, the hibmcge driver may receive corrupted packets.
>> The hardware writes packet data and descriptors to the same page, but
>> with Relaxed Ordering enabled, PCI write transactions may not be
>> strictly ordered. This can cause the driver to observe a valid
>> descriptor before the corresponding packet data is fully written.
>>
>> Fix this by clearing PCI_EXP_DEVCTL_RELAX_EN in the PCI bridge control
>> register to ensure strict write ordering between packet data and
>> descriptors.
>>
>> Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> index 068da2fd1fea..319551caf047 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> @@ -420,6 +420,8 @@ static int hbg_pci_init(struct pci_dev *pdev)
>>   		return -ENOMEM;
>>   
>>   	pci_set_master(pdev);
>> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
>> +				   PCI_EXP_DEVCTL_RELAX_EN);
> Sashiko noted this will not survive a device reset - that performs
> pci_restore_state - and you should likelly call pci_save_state(pdev)
> afterwards.

Yes, thank you. I will fix it in v3.
Jijie Shao


