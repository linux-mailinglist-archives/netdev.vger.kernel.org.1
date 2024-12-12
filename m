Return-Path: <netdev+bounces-151266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC39EDD04
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D0318892FC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 01:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C342AA9;
	Thu, 12 Dec 2024 01:21:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E27225A8;
	Thu, 12 Dec 2024 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733966491; cv=none; b=OM4yeEvXoANQuNrwLGbCmIgxOkspnDdecBk/XZDj3OnnMpSP9ltx/BO5LcDpxrGbgd07AZzeIeLMsykaDnR3ocolMxDRg7f4nk3aRt3yFI6MnNnxp8XCsYwMPtUjhKITIat6N9MYn7UGCcIzgLTqruL4zWhECjojwGOLh/ZcRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733966491; c=relaxed/simple;
	bh=TMW033nVrGyiTEV4a/l0sGFVH3R2oR6fu0kElFUfkVo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ETgbr6d16erRC8qeq9zaeds5s4KJy0byKh0AFAMs2NpWQqjg+v7yDwYX0Netls4MAnOqrs+nat8y7QbVebNWFpGCziZp/zKIXyf/q+KIh9FvvXKHKvZvg8O8OIj5Te1sKhxsquGj7R6QMV/aGr3yCWM3mY1k9lHcuUQHRFdvN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y7vkN3cYBz1kvcv;
	Thu, 12 Dec 2024 09:18:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DA441140156;
	Thu, 12 Dec 2024 09:21:18 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Dec 2024 09:21:17 +0800
Message-ID: <74eae7ad-151c-4dd4-a14d-44da0d000e54@huawei.com>
Date: Thu, 12 Dec 2024 09:21:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hkelam@marvell.com>
Subject: Re: [PATCH V6 net-next 1/7] net: hibmcge: Add debugfs supported in
 this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20241210134855.2864577-1-shaojijie@huawei.com>
 <20241210134855.2864577-2-shaojijie@huawei.com>
 <20241211060018.14f56635@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241211060018.14f56635@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/11 22:00, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 21:48:49 +0800 Jijie Shao wrote:
>> +		debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
>> +					    root, hbg_dbg_infos[i].read);
> Like I said last time, if you devm_ the entire folder you don't have to
> devm_ each individual file. debugfs_remove_recursive() removes all files
> under specified directory.

I think debugfs_create_devm_seqfile()is a better choice, if not use it.  and I might need to code like so： static const struct file_operations 
hbg_dbg_fops = { .owner = THIS_MODULE, ... }; static int 
hbg_dbg_file_init(struct hbg_priv *priv, u32 cmd, const char *name) { 
struct hbg_dbg_pri_data *data; data = devm_kzalloc(&priv->pdev->dev, 
sizeof(*data), GFP_KERNEL); if (!data) return -ENOMEM; data->priv = 
priv; data->cmd = cmd; debugfs_create_file(name, HBG_DBG_FILE_MODE, 
priv->debugfs.root, data, &hbg_dbg_fops); return 0; } int 
hbg_debugfs_init(struct hbg_priv *priv) { ... for (i = 0; i < ARRAY_SIZE(hbg_dbg_infos); i++) { ret = hbg_dbg_file_init(priv, i, hbg_dbg_infos[i].name); ... } But use debugfs_create_devm_seqfile(), I only need：void hbg_debugfs_init(struct hbg_priv *priv)
{
...
	for (i = 0; i < ARRAY_SIZE(hbg_dbg_infos); i++)
		debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
					    root, hbg_dbg_infos[i].read);


Actually i think debugfs_create_devm_seqfile() is actually similar to hbg_dbg_file_init().
And in debugfs_create_devm_seqfile(), debugfs_create_file() is also called, and the code is simplified.

Thanks,
Jijie Shao




