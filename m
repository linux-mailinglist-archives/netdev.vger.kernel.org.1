Return-Path: <netdev+bounces-151268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B85D9EDD22
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F23283434
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB382558BC;
	Thu, 12 Dec 2024 01:35:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE9DDDC;
	Thu, 12 Dec 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967309; cv=none; b=fXH5fRuhQVpVNCM90ciymOS/VY+/TRqHRdEon8wVODta8AGcuJdIIuuZZOl3wOAbmqqjr2n3TMuTcOPqxZs2W/pCH2/Y2O4sN8ZRsACcVGy8GCasq+5kxYuphkPw4GQIlUTHafctCEDD8pW8swaU+it9YZfzbFnxbQKt+XURf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967309; c=relaxed/simple;
	bh=D4YFkHe+pmij//3bwf3VapR3LAwQSJt/FP2BXUevGVI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iWI7LbiA3fPbqKbEqFlxYe6igoVx8xdBCYEOn+9j1J5IMMQ8DHNgpdTJ9lG7jR3cY2oNhvqzeXt6W/RXCEu3L4yAubnpsi5ZfqeeMCuMfIXa+r6af4Bqbf2vGNeCY/XZxZDYxMdpdFqetpFHj8kmmlMymdq1NqBzFI4xfqnaf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y7w320Ttwz21msJ;
	Thu, 12 Dec 2024 09:33:18 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 94EE41A0188;
	Thu, 12 Dec 2024 09:35:03 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Dec 2024 09:35:02 +0800
Message-ID: <c36b6423-720f-4bb0-ac7e-8e69a5c2a81b@huawei.com>
Date: Thu, 12 Dec 2024 09:35:02 +0800
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/11 22:00, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 21:48:49 +0800 Jijie Shao wrote:
>> +		debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
>> +					    root, hbg_dbg_infos[i].read);
> Like I said last time, if you devm_ the entire folder you don't have to
> devm_ each individual file. debugfs_remove_recursive() removes all files
> under specified directory.


Sorry, there's something wrong with the format of the last reply.


I think debugfs_create_devm_seqfile() is a better choice,
if not use it, I might need to code like so：

static const struct file_operations hbg_dbg_fops = {
	.owner   = THIS_MODULE,
...
};

static int hbg_dbg_file_init(struct hbg_priv *priv, u32 cmd, const char *name)
{
	struct hbg_dbg_pri_data *data;

	data = devm_kzalloc(&priv->pdev->dev, sizeof(*data), GFP_KERNEL);
	if (!data)
		return -ENOMEM;

	data->priv = priv;
	data->cmd = cmd;
	debugfs_create_file(name, HBG_DBG_FILE_MODE,
			    priv->debugfs.root, data, &hbg_dbg_fops);

	return 0;
}

int hbg_debugfs_init(struct hbg_priv *priv)
{
...
	for (i = 0; i < ARRAY_SIZE(hbg_dbg_infos); i++) {
		ret = hbg_dbg_file_init(priv, i, hbg_dbg_infos[i].name);
...
	}


But use debugfs_create_devm_seqfile(), I only need:

void hbg_debugfs_init(struct hbg_priv *priv)
{
...
     for (i = 0; i < ARRAY_SIZE(hbg_dbg_infos); i++)
         debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
                         root, hbg_dbg_infos[i].read);


Actually I think debugfs_create_devm_seqfile() is actually similar to hbg_dbg_file_init().
And in debugfs_create_devm_seqfile(), debugfs_create_file() is also called, and the code is simplified.

Thanks,
Jijie Shao




