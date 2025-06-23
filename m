Return-Path: <netdev+bounces-200142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7407AE359A
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713BC1891B91
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489011E5B7D;
	Mon, 23 Jun 2025 06:21:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91DC1D2F42;
	Mon, 23 Jun 2025 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659682; cv=none; b=rrDxvGiEu12xgnV4Jz4MtOx7MY1bsDhZmobCUDidaYrnl2Psq9P3u15EoJEvc+RuztLVrUM8+ZtYTA6hTEKFgM0ULJtUXxcNYsYet+ivAy2kkQlwAuZVQrawN0sLl9/+fhI+vSRrWXnFn8CmisOMzpGktUfPJJMZZn1LBVF6EFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659682; c=relaxed/simple;
	bh=+bwLU6ymdrAg/EKWtfqIW8dc231VI/HkxW+vEMW+RpE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k+r5Q2DgSwskY+9SyAdWTWTSEJNbZMsCAo5auAMCqWrI0J1BhnMIFB4Yk91zYd0+OJ3iCL4z1NNYkpAHYBt4jq/vDMaoj1XvkVkLFxgWFP5nK+Nuh4qQBrokZ19HSFFxuJLaz17v6gl3PQ3KsTUHAAXzkqbZGrkAqs40ZM9kXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bQdFW3RYPz1d1WK;
	Mon, 23 Jun 2025 14:18:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3928D14074D;
	Mon, 23 Jun 2025 14:21:13 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 14:21:12 +0800
Message-ID: <791a8e4e-8bcf-4638-8bd7-d9e8785a9320@huawei.com>
Date: Mon, 23 Jun 2025 14:21:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Hao Lan
	<lanhao@huawei.com>, Guangwei Zhang <zhangwangwei6@huawei.com>, Netdev
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
Subject: Re: [PATCH] hns3: work around stack size warning
To: Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>
References: <20250610092113.2639248-1-arnd@kernel.org>
 <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
 <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
 <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
 <20250612083309.7402a42e@kernel.org>
 <02b6bd18-6178-420b-90ab-54308c7504f7@huawei.com>
 <cb286135-466f-40b2-aaa5-a2b336d3a87c@huawei.com>
 <13cf4327-f04f-455e-9a3a-1c74b22f42d0@app.fastmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <13cf4327-f04f-455e-9a3a-1c74b22f42d0@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/23 13:56, Arnd Bergmann wrote:
> On Mon, Jun 23, 2025, at 05:19, Jijie Shao wrote:
>>> on 2025/6/12 23:33, Jakub Kicinski wrote:
>>>
>> *Hi Jakub, Arnd We have changed the impleament as your suggestion. Would
>> you please help check it ? If it's OK, we will rewrite the rest parts of
>> our debugfs code. Thanks! *
> The conversion to seq_file looks good to me, this does address the
> stack usage problems I was observing.
> Thanks for cleaning this up!
>
>> -    sprintf(result[j++], "%u", index);
>> -    sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
>> -        HNS3_RING_TX_RING_BD_NUM_REG));
>> +    seq_printf(s, "%-4u%6s", index, " ");
>> +    seq_printf(s, "%-5u%3s",
>> +           readl_relaxed(base + HNS3_RING_TX_RING_BD_NUM_REG), " ");
> I'm not sure I understand the format string changes here, I did
> not think they were necessary.
>
> Are you doing this to keep the output the same as before, or are
> you reformatting the contents for readability?

yeah, just to keep the output the same as before


>
>> +static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32
>> cmd)
>> +{
>> +    struct device *dev = &handle->pdev->dev;
>> +    struct dentry *entry_dir;
>> +    read_func func = NULL;
>> +
>> +    switch (hns3_dbg_cmd[cmd].cmd) {
>> +    case HNAE3_DBG_CMD_TX_QUEUE_INFO:
>> +        func = hns3_dbg_tx_queue_info;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    entry_dir = hns3_dbg_dentry[hns3_dbg_cmd[cmd].dentry].dentry;
>> +    debugfs_create_devm_seqfile(dev, hns3_dbg_cmd[cmd].name, entry_dir,
>> +                    func);
>> +
>> +    return 0;
> This will work fine as well, but I think you can do slightly better
> by having your own file_operations with a read function based
> on single_open() and your current hns3_dbg_read_cmd().
>
> I don't think you gain anything from using debugfs_create_devm_seqfile()
> since you use debugfs_remove_recursive() for cleaning it up anyway.
>
>       Arnd

Using debugfs_create_devm_seqfile() is just to simplify the code.
We only need to focus on the implementation of .read() function.

Thanks
Jijie Shao



