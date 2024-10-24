Return-Path: <netdev+bounces-138700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456F9AE93A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EB21F22AFD
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D861E1A1D;
	Thu, 24 Oct 2024 14:44:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FB1AF0D0;
	Thu, 24 Oct 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781095; cv=none; b=oUY83/6nexUni7tcPtinY6xRuyX8siONGpJzzGivbZknGmkXcOryzwrHrmHxiehmMuTGW9O5bSexc7xaoNE+NV8KkXp3iPtvgD+V38954JXvT0N9miUs1ChY7H05Q3femNKVmiplEf5fEB40eOdtRLSoc51hZRBEZYloLhl9aKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781095; c=relaxed/simple;
	bh=TC+d9a8JXS0axmvv6B2gj9V/07iduagclGASA9znHqU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y2XJWXP7wea/kfC74nqk1RdDuznMuqQyH+RcvoLcj76hNZD8ZqU1KxenInNebo+e1lIDHtgV+FcVq23xysVFy4+PA/S7Sn5b6MQteoKdL5oKf1kMpr1AXHExssRIJMAh8MHe7deOZICkRs/ZDGrLnkKgaDLWeCuGXGFW1HLxJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZ7tg3fZqzpXC8;
	Thu, 24 Oct 2024 22:42:51 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F3CB180103;
	Thu, 24 Oct 2024 22:44:48 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 22:44:47 +0800
Message-ID: <8254dbdf-79d5-4c90-be7b-bb5cabf499e7@huawei.com>
Date: Thu, 24 Oct 2024 22:44:46 +0800
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
Subject: Re: [PATCH net-next 4/7] net: hibmcge: Add register dump supported in
 this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-5-shaojijie@huawei.com>
 <f34ba74e-f691-409f-b2f1-990ba9a6c5a9@lunn.ch>
 <3a9bf4e6-b764-49b3-af8b-b5fd71cc4e49@huawei.com>
 <e1827d48-7aeb-4f40-9332-8ce1efc5c960@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <e1827d48-7aeb-4f40-9332-8ce1efc5c960@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/24 20:22, Andrew Lunn wrote:
>> We have other considerations:
>>
>> If the dump register changes in the future, we hope that
>> only the kernel needs to be modified, and the ethtool does not need to be modified.
>> In this case, We do not need to consider the mapping between the ethtool and driver versions.
>>
>> So in ethtool, we only need to consider basic formatted printing.
>> like this(not send yet):
>>
>> #define HBG_REG_NAEM_MAX_LEN 32
>> struct hbg_reg_info {
>> 	char name[HBG_REG_NAEM_MAX_LEN];
>> 	u32 offset;
>> 	u32 val;
>> };
>> static void hibmcge_dump_reg_info(struct hbg_reg_info *info)
>> {
>> 	fprintf(stdout, "%-*s[0x%04x]: 0x%08x\n",
>> 		HBG_REG_NAEM_MAX_LEN, info->name, info->offset, info->val);
>> }
>> int hibmcge_dump_regs(struct ethtool_drvinfo *info __maybe_unused,
>> 		      struct ethtool_regs *regs)
>> {
>> 	struct hbg_reg_info *reg_info;
>> 	u32 name_max_len;
>> 	u32 offset = 0;
>> 	if (regs->len % sizeof(*reg_info) != 0)
>> 		return -EINVAL;
>> 	while (offset < regs->len) {
>> 		reg_info = (struct hbg_reg_info *)(regs->data + offset);
>> 		hibmcge_dump_reg_info(reg_info);
>> 		offset += sizeof(*reg_info);
>> 	}
>> 	return 0;
>> }
>>
>> So, In this patch, pass back hbg_reg_info(name, offset, value)
> So this is different to all other drivers doing registers dumps.
>
> 1) Please explain this in the commit message, with a justification why
> your driver is different.

In fact, we don't have anything different with other drivers.

In the customer environment, the ethtool version may not be the latest.

If the driver adds a register to the register dump, the register is unknown
when the ethtool is used to query the register.
Therefore, we want to separate the ethtool from the driver.
No matter how the driver is modified, the ethtool can display all information perfectly.

>
> 2) What is actually specific to your driver here? Why not make this
> available to all drivers? Maybe check if ethtool_regs.version ==
> MAX_U32 is used by any of the other drivers, and if not, make that a
> magic value to indicate your special format.

In fact, it would be best if ethtool could provide a unified framework to
elegantly display all register information.
The existing framework prints the information in hexadecimal format,
which is not intuitive enough.

>
> 3) Maybe consider that there does not appear to be a netlink version
> of this ethtool ioctl. Could this be nicely integrated into a netlink
> version, where you have more flexibility with attributes?

Okay, I'll analyze it.

Thanks a lot.
Jijie Shao



