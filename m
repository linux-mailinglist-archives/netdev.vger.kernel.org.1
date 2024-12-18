Return-Path: <netdev+bounces-152928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A519F659B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E45188784F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB2319F49F;
	Wed, 18 Dec 2024 12:13:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610415957D;
	Wed, 18 Dec 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524022; cv=none; b=CuTjlFnOAnpZMfns1xLx8tjGJgAuZvbtyMTDcp2uaeKMV4BkE/IUHhNkPYnVlD1WahS0VdetW8xJK6hh6geHZ8wIPQWgjEx2UTx7jexHgJZcPpB16tUdeqvsyGV77WuicDJoW5ZDLWJhbqp6LZhBJ/TTZ5zw+qqXTJub6EgMGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524022; c=relaxed/simple;
	bh=+t4X0sKux8BOLBwNktInKhd1dfa6LXrQsEy4I1kmQmU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hyEncg9eu41waLwHXjO2kvk9ggP3fjn+/SmHXhvCGzOvGvf+9FL8QUGEy2gLBWmqCHnXmEhcekyCJ5G8GOlsswrToFJipp0jPMJUau3AagU3AlrBG9Zej//Uxo0IaInUT5wEZjF4ZueY0C41UYmmkPKf3aRUFoKoJgqxflNlmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YCsX24ztWzhZVc;
	Wed, 18 Dec 2024 19:53:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E51C6180105;
	Wed, 18 Dec 2024 19:56:10 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Dec 2024 19:56:10 +0800
Message-ID: <c350f32a-20f5-4bf3-bc30-36f44b4872a5@huawei.com>
Date: Wed, 18 Dec 2024 19:56:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: hisilicon: hns: Remove unused
 hns_dsaf_roce_reset
To: <linux@treblig.org>, <salil.mehta@huawei.com>, <shenjian15@huawei.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20241218005729.244987-1-linux@treblig.org>
 <20241218005729.244987-2-linux@treblig.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241218005729.244987-2-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/18 8:57, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> hns_dsaf_roce_reset() has been unused since 2021's
> commit 38d220882426 ("RDMA/hns: Remove support for HIP06")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 109 ------------------
>   .../ethernet/hisilicon/hns/hns_dsaf_main.h    |   2 -
>   2 files changed, 111 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> index 851490346261..6b6ced37e490 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> @@ -3019,115 +3019,6 @@ static struct platform_driver g_dsaf_driver = {
>   
>   module_platform_driver(g_dsaf_driver);
>   
> -/**
> - * hns_dsaf_roce_reset - reset dsaf and roce
> - * @dsaf_fwnode: Pointer to framework node for the dasf
> - * @dereset: false - request reset , true - drop reset
> - * return 0 - success , negative -fail
> - */
> -int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
> -{
> -	struct dsaf_device *dsaf_dev;
> -	struct platform_device *pdev;
> -	u32 mp;
> -	u32 sl;
> -	u32 credit;
> -	int i;
> -	static const u32 port_map[DSAF_ROCE_CREDIT_CHN][DSAF_ROCE_CHAN_MODE_NUM] = {
> -		{DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0},

It would be better to delete these roce-related definitions together:
DSAF_ROCE_PORT_1, DSAF_ROCE_SL_0,DSAF_ROCE_6PORT_MODE and so on

Thanks,
Jijie Shao

> -		{DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0, DSAF_ROCE_PORT_0},
> -		{DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0},
> -		{DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1, DSAF_ROCE_PORT_0},
> -		{DSAF_ROCE_PORT_4, DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1},
> -		{DSAF_ROCE_PORT_4, DSAF_ROCE_PORT_2, DSAF_ROCE_PORT_1},
> -		{DSAF_ROCE_PORT_5, DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1},
> -		{DSAF_ROCE_PORT_5, DSAF_ROCE_PORT_3, DSAF_ROCE_PORT_1},
> -	};
> -	static const u32 sl_map[DSAF_ROCE_CREDIT_CHN][DSAF_ROCE_CHAN_MODE_NUM] = {
> -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_0},
> -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_1, DSAF_ROCE_SL_1},
> -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_2},
> -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_1, DSAF_ROCE_SL_3},
> -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_0},
> -		{DSAF_ROCE_SL_1, DSAF_ROCE_SL_1, DSAF_ROCE_SL_1},
> -		{DSAF_ROCE_SL_0, DSAF_ROCE_SL_0, DSAF_ROCE_SL_2},
> -		{DSAF_ROCE_SL_1, DSAF_ROCE_SL_1, DSAF_ROCE_SL_3},
> -	};
> -
> -	/* find the platform device corresponding to fwnode */
> -	if (is_of_node(dsaf_fwnode)) {
> -		pdev = of_find_device_by_node(to_of_node(dsaf_fwnode));
> -	} else if (is_acpi_device_node(dsaf_fwnode)) {
> -		pdev = hns_dsaf_find_platform_device(dsaf_fwnode);
> -	} else {
> -		pr_err("fwnode is neither OF or ACPI type\n");
> -		return -EINVAL;
> -	}
> -
> -	/* check if we were a success in fetching pdev */
> -	if (!pdev) {
> -		pr_err("couldn't find platform device for node\n");
> -		return -ENODEV;
> -	}
> -
> -	/* retrieve the dsaf_device from the driver data */
> -	dsaf_dev = dev_get_drvdata(&pdev->dev);
> -	if (!dsaf_dev) {
> -		dev_err(&pdev->dev, "dsaf_dev is NULL\n");
> -		put_device(&pdev->dev);
> -		return -ENODEV;
> -	}
> -
> -	/* now, make sure we are running on compatible SoC */
> -	if (AE_IS_VER1(dsaf_dev->dsaf_ver)) {
> -		dev_err(dsaf_dev->dev, "%s v1 chip doesn't support RoCE!\n",
> -			dsaf_dev->ae_dev.name);
> -		put_device(&pdev->dev);
> -		return -ENODEV;
> -	}
> -
> -	/* do reset or de-reset according to the flag */
> -	if (!dereset) {
> -		/* reset rocee-channels in dsaf and rocee */
> -		dsaf_dev->misc_op->hns_dsaf_srst_chns(dsaf_dev, DSAF_CHNS_MASK,
> -						      false);
> -		dsaf_dev->misc_op->hns_dsaf_roce_srst(dsaf_dev, false);
> -	} else {
> -		/* configure dsaf tx roce correspond to port map and sl map */
> -		mp = dsaf_read_dev(dsaf_dev, DSAF_ROCE_PORT_MAP_REG);
> -		for (i = 0; i < DSAF_ROCE_CREDIT_CHN; i++)
> -			dsaf_set_field(mp, 7 << i * 3, i * 3,
> -				       port_map[i][DSAF_ROCE_6PORT_MODE]);
> -		dsaf_set_field(mp, 3 << i * 3, i * 3, 0);
> -		dsaf_write_dev(dsaf_dev, DSAF_ROCE_PORT_MAP_REG, mp);
> -
> -		sl = dsaf_read_dev(dsaf_dev, DSAF_ROCE_SL_MAP_REG);
> -		for (i = 0; i < DSAF_ROCE_CREDIT_CHN; i++)
> -			dsaf_set_field(sl, 3 << i * 2, i * 2,
> -				       sl_map[i][DSAF_ROCE_6PORT_MODE]);
> -		dsaf_write_dev(dsaf_dev, DSAF_ROCE_SL_MAP_REG, sl);
> -
> -		/* de-reset rocee-channels in dsaf and rocee */
> -		dsaf_dev->misc_op->hns_dsaf_srst_chns(dsaf_dev, DSAF_CHNS_MASK,
> -						      true);
> -		msleep(SRST_TIME_INTERVAL);
> -		dsaf_dev->misc_op->hns_dsaf_roce_srst(dsaf_dev, true);
> -
> -		/* enable dsaf channel rocee credit */
> -		credit = dsaf_read_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG);
> -		dsaf_set_bit(credit, DSAF_SBM_ROCEE_CFG_CRD_EN_B, 0);
> -		dsaf_write_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG, credit);
> -
> -		dsaf_set_bit(credit, DSAF_SBM_ROCEE_CFG_CRD_EN_B, 1);
> -		dsaf_write_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG, credit);
> -	}
> -
> -	put_device(&pdev->dev);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(hns_dsaf_roce_reset);
> -
>   MODULE_LICENSE("GPL");
>   MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
>   MODULE_DESCRIPTION("HNS DSAF driver");
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> index 0eb03dff1a8b..c90f41c75500 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> @@ -463,6 +463,4 @@ int hns_dsaf_clr_mac_mc_port(struct dsaf_device *dsaf_dev,
>   			     u8 mac_id, u8 port_num);
>   int hns_dsaf_wait_pkt_clean(struct dsaf_device *dsaf_dev, int port);
>   
> -int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset);
> -
>   #endif /* __HNS_DSAF_MAIN_H__ */

