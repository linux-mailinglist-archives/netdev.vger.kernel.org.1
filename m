Return-Path: <netdev+bounces-149569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADCC9E641F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103601679F2
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847C15B102;
	Fri,  6 Dec 2024 02:29:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB293D6B;
	Fri,  6 Dec 2024 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452141; cv=none; b=Zfitg8zkt9kiVKGh83ewi38FqYUmLKyc3Cs/xM1cK8iogB9In0nUuCeLRRW1onxces+d1HvCyAOVptHQVdNNU6F8tq8igd0pDrZLr3cbU0qlu2QmSwGebhqMHCkAVyUQvc6uChbVJEuH3J9zy/hVCWAwVI5LiupAn8wEsLnmbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452141; c=relaxed/simple;
	bh=wbLhQT3zz+yC6Xn7uDEsUyEfxjn1dhwRYtWQogfi448=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hQ1WtKhDX9qjxiykKjo6zKDnoSaj6l4FVnFG/C8OvAExYZL0k5axgieumx5aZLuyEBofZwFhbd07d323gjGjm/1/Ce6CPI3W7iBhorO/5aldUGgQx7L1Yex0j9E0HGDs3ZB9NOnmTnVjisL+s+xRGfrTkEYeZtb+brEjtLkYiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y4FZB0sSFz1yrgv;
	Fri,  6 Dec 2024 10:29:06 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BAB81A016C;
	Fri,  6 Dec 2024 10:28:50 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 10:28:49 +0800
Message-ID: <09cd08cf-9c6b-4c5f-b0da-e9a74ef120a5@huawei.com>
Date: Fri, 6 Dec 2024 10:28:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V4 RESEND net-next 1/7] net: hibmcge: Add debugfs
 supported in this module
To: Jakub Kicinski <kuba@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
 <20241203150131.3139399-2-shaojijie@huawei.com>
 <20241205175006.318f17d9@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241205175006.318f17d9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/6 9:50, Jakub Kicinski wrote:
> On Tue, 3 Dec 2024 23:01:25 +0800 Jijie Shao wrote:
>> +static void hbg_debugfs_uninit(void *data)
>> +{
>> +	debugfs_remove_recursive((struct dentry *)data);
>> +}
>> +
>> +void hbg_debugfs_init(struct hbg_priv *priv)
>> +{
>> +	const char *name = pci_name(priv->pdev);
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct dentry *root;
>> +	u32 i;
>> +
>> +	root = debugfs_create_dir(name, hbg_dbgfs_root);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hbg_dbg_infos); i++)
>> +		debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
>> +					    root, hbg_dbg_infos[i].read);
>> +
>> +	/* Ignore the failure because debugfs is not a key feature. */
>> +	devm_add_action_or_reset(dev, hbg_debugfs_uninit, root);
> There is nothing specific to this driver in the devm action,
> also no need to create all files as devm if you remove recursive..
>
> Hi Greg, are you okay with adding debugfs_create_devm_dir() ?

Of course, it's my pleasure. I will add a patch in V5 to try to add this interface.

Thanks,
Jijie Shao


