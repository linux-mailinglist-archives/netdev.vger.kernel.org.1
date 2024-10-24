Return-Path: <netdev+bounces-138454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D557E9ADAA5
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 05:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C7B282D15
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 03:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F215887C;
	Thu, 24 Oct 2024 03:44:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6031EB3D;
	Thu, 24 Oct 2024 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741446; cv=none; b=t9acevD1CLqZVOy9FoMrrJnsZGhOKX9Zdb9FoWH9ednk8zeUGClSfH9v+tLZv7Bn4E2wz/phi5eHQqQ3Mt/90W+GDLJIAt/3MiTdGHgvyOZLvOWV++CTcfMM5HNorqhVxqwq45VsY+I1h/oRQq2hdID1kecFWFh3z0hGVpNM2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741446; c=relaxed/simple;
	bh=gVUEapQDCf37RDsXgPwycmmfmIJU77J994Ruz0CKgKs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YdV9SgJmZuF41hVryE2P5pAZktarSHxgykvZQQrd4gQzn8RD929K5XI0BlS9qL+PGnX/iRzxV8088AKqQ+v1QO1xHeacv0ga0Db+xlljvLkCBLhmLWm8Fh2vcgX/ahiYd6O+Vvdttg291Q6X2rGj/vCvkzP7564EEBkBn5yOnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XYsGb5lkyz1ynS2;
	Thu, 24 Oct 2024 11:44:07 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 60F9414022D;
	Thu, 24 Oct 2024 11:44:00 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 11:43:59 +0800
Message-ID: <3a9bf4e6-b764-49b3-af8b-b5fd71cc4e49@huawei.com>
Date: Thu, 24 Oct 2024 11:43:58 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <f34ba74e-f691-409f-b2f1-990ba9a6c5a9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/23 22:13, Andrew Lunn wrote:
> On Wed, Oct 23, 2024 at 09:42:10PM +0800, Jijie Shao wrote:
>> With the ethtool of a specific version,
>> the following effects are achieved:
>>
>> [root@localhost sjj]# ./ethtool -d enp131s0f1
>> [SPEC] VALID                    [0x0000]: 0x00000001
>> [SPEC] EVENT_REQ                [0x0004]: 0x00000000
>> [SPEC] MAC_ID                   [0x0008]: 0x00000002
>> [SPEC] PHY_ADDR                 [0x000c]: 0x00000002
>> [SPEC] MAC_ADDR_L               [0x0010]: 0x00000808
>> [SPEC] MAC_ADDR_H               [0x0014]: 0x08080802
>> [SPEC] UC_MAX_NUM               [0x0018]: 0x00000004
>> [SPEC] MAX_MTU                  [0x0028]: 0x00000fc2
>> [SPEC] MIN_MTU                  [0x002c]: 0x00000100
> Seems like this makes your debugfs patches redundant?

Yes, the debugfs will be removed.

>
>> +static u32 hbg_get_reg_info(struct hbg_priv *priv,
>> +			    const struct hbg_reg_type_info *type_info,
>> +			    const struct hbg_reg_offset_name_map *reg_map,
>> +			    struct hbg_reg_info *info)
>> +{
>> +	info->val = hbg_reg_read(priv, reg_map->reg_offset);
>> +	info->offset = reg_map->reg_offset - type_info->offset_base;
>> +	snprintf(info->name, sizeof(info->name),
>> +		 "[%s] %s", type_info->name, reg_map->name);
>> +
>> +	return sizeof(*info);
>> +}
>> +
>> +static void hbg_ethtool_get_regs(struct net_device *netdev,
>> +				 struct ethtool_regs *regs, void *data)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +	const struct hbg_reg_type_info *info;
>> +	u32 i, j, offset = 0;
>> +
>> +	regs->version = 0;
>> +	for (i = 0; i < ARRAY_SIZE(hbg_type_infos); i++) {
>> +		info = &hbg_type_infos[i];
>> +		for (j = 0; j < info->reg_num; j++)
>> +			offset += hbg_get_reg_info(priv, info,
>> +						   &info->reg_maps[j],
>> +						   data + offset);
>> +	}
>> +}
> data is supposed to be just raw values, dumped from registers in the
> device. You appear to be passing back ASCII text. It is supposed to be
> ethtool which does the pretty print, not the kernel driver.
>
>      Andrew

We have other considerations:

If the dump register changes in the future, we hope that
only the kernel needs to be modified, and the ethtool does not need to be modified.
In this case, We do not need to consider the mapping between the ethtool and driver versions.

So in ethtool, we only need to consider basic formatted printing.
like this(not send yet):
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#define HBG_REG_NAEM_MAX_LEN 32
  
struct hbg_reg_info {
	char name[HBG_REG_NAEM_MAX_LEN];
	u32 offset;
	u32 val;
};
  
static void hibmcge_dump_reg_info(struct hbg_reg_info *info)
{
	fprintf(stdout, "%-*s[0x%04x]: 0x%08x\n",
		HBG_REG_NAEM_MAX_LEN, info->name, info->offset, info->val);
}
  
int hibmcge_dump_regs(struct ethtool_drvinfo *info __maybe_unused,
		      struct ethtool_regs *regs)
{
	struct hbg_reg_info *reg_info;
	u32 name_max_len;
	u32 offset = 0;
  
	if (regs->len % sizeof(*reg_info) != 0)
		return -EINVAL;
  
	while (offset < regs->len) {
		reg_info = (struct hbg_reg_info *)(regs->data + offset);
		hibmcge_dump_reg_info(reg_info);
		offset += sizeof(*reg_info);
	}
  
	return 0;
}
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

So, In this patch, pass back hbg_reg_info(name, offset, value)

Thanks,
Jijie Shao


