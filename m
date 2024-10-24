Return-Path: <netdev+bounces-138456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB66C9ADAC3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 06:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F481F22765
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016773446;
	Thu, 24 Oct 2024 04:02:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD62C9A;
	Thu, 24 Oct 2024 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729742574; cv=none; b=h44Falcr+5CfkcdlGgar4FFFqAgdSsVfEu8KC/QleuiRbZRzIBMMrMfofzdeXD8lXN7/uTIj37/MISUpTLHD+gXjkhI24senqD+1OkrQoWE3A5PzwqioVe5QviRICMv+DjV5yZBV8vi2+F5qe1Rb7U4+rlAh4ZNTDPNH2TvrGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729742574; c=relaxed/simple;
	bh=p4vz/I+LUfLqMAZcf+vUDq99wBEjHdBGk6IDiE4L6YE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jS/n+wSoQfEUUNTaX5iuyG1Srv8V9mxOSPm10FmK19aYmRzqRQnBN0kxhe0WhnnXcBgrcGW2m0mBKuD8kzW1BufOwO1djZQSY7opEx8MzIjct9K6qODmkuXnzufxx1fi9exxdbD+Aj5fZECy494pyZ5hvGSGGSDhtD7qTR0qMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYsfM42rSzyTTc;
	Thu, 24 Oct 2024 12:01:15 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id D2894180103;
	Thu, 24 Oct 2024 12:02:47 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 12:02:46 +0800
Message-ID: <5688a15f-48d1-4560-9358-ec83fb623205@huawei.com>
Date: Thu, 24 Oct 2024 12:02:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/7] net: hibmcge: Add register dump supported in
 this module
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-5-shaojijie@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241023134213.3359092-5-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/23 21:42, Jijie Shao wrote:
>   
> +#define HBG_REG_NAEM_MAX_LEN	24
> +#define HBG_REG_TYPE_MAX_LEN	8

......

> +
> +struct hbg_reg_offset_name_map {
> +	u32 reg_offset;
> +	char name[HBG_REG_NAEM_MAX_LEN];
> +};
> +
> +struct hbg_reg_type_info {
> +	char name[HBG_REG_TYPE_MAX_LEN];
> +	u32 offset_base;
> +	const struct hbg_reg_offset_name_map *reg_maps;
> +	u32 reg_num;
> +};
> +
> +struct hbg_reg_info {
> +	char name[HBG_REG_NAEM_MAX_LEN + HBG_REG_TYPE_MAX_LEN];
> +	u32 offset;
> +	u32 val;

......

> +
> +static u32 hbg_get_reg_info(struct hbg_priv *priv,
> +			    const struct hbg_reg_type_info *type_info,
> +			    const struct hbg_reg_offset_name_map *reg_map,
> +			    struct hbg_reg_info *info)
> +{
> +	info->val = hbg_reg_read(priv, reg_map->reg_offset);
> +	info->offset = reg_map->reg_offset - type_info->offset_base;
> +	snprintf(info->name, sizeof(info->name),
> +		 "[%s] %s", type_info->name, reg_map->name);
> +

In addition, there are compilation warning here:
../drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c: In function ‘hbg_ethtool_get_regs’:
../drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c:322:20: warning: ‘%s’ directive output may be truncated writing up to 127 bytes into a region of size 31 [-Wformat-truncation=]
   322 |                  "[%s] %s", type_info->name, reg_map->name);
       |                    ^~
In function ‘hbg_get_reg_info’,
     inlined from ‘hbg_ethtool_get_regs’ at ../drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c:338:14:
../drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c:321:9: note: ‘snprintf’ output between 4 and 154 bytes into a destination of size 32
   321 |         snprintf(info->name, sizeof(info->name),
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   322 |                  "[%s] %s", type_info->name, reg_map->name);


But in fact, sizeof(info->name) is (24+8), type_info->name length is 8, and reg_map->name length is 24.
I understand that it should be fine to use here.

Thanks,
Jijie Shao



