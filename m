Return-Path: <netdev+bounces-139412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4EE9B221C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 02:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C1C1F21642
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 01:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC114D43D;
	Mon, 28 Oct 2024 01:56:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE29524C
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080597; cv=none; b=kTchxJbPxn13e3AhjM+06USXBkjIhyzPOzj0AZOG5tux91V7gscvXitIHVZh9jVBaZcB77jsnrjuW5fzzhkMfwLoeuUhKhCruEKhkhMV2gx9sfqGpViAI1seqWO419hCPd9W/Gwxx8Hy8S9GcXPR1S+mjN3oHiDWzIl2zriAb8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080597; c=relaxed/simple;
	bh=7QZANj64zWHwbzoX76sk2N4SIroHC4xXZn61qmO06Co=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A6aN2++zYKMhsxajhLdOVnf1ymawoDsGeQMinCvqCtBHp8OugUbRHb4t4uUzXpw/XXFWfEg+71g0nQIoRWsh9fehesZ+iZs13Qkj7Bus5YtTunGjU8cq3sv+ePxLV9z2QBKSHK0MNx5AUWNhBBb1JipW/YD84cd3tFDdTgLI9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XcGbM22g2z1HLN5;
	Mon, 28 Oct 2024 09:51:59 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 413DA180041;
	Mon, 28 Oct 2024 09:56:25 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 09:56:24 +0800
Subject: Re: [PATCH v2 1/2] bna: Remove error checking for debugfs create APIs
To: Simon Horman <horms@kernel.org>
CC: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <20241026034800.450-1-thunder.leizhen@huawei.com>
 <20241026034800.450-2-thunder.leizhen@huawei.com>
 <20241026153513.GI1507976@kernel.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ca02c938-5ebf-9431-eea0-e919688ab50a@huawei.com>
Date: Mon, 28 Oct 2024 09:56:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241026153513.GI1507976@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/26 23:35, Simon Horman wrote:
> On Sat, Oct 26, 2024 at 11:47:59AM +0800, Zhen Lei wrote:
>> Driver bna can work fine even if any previous call to debugfs create
>> APIs failed. All return value checks of them should be dropped, as
>> debugfs APIs say.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 15 +--------------
>>  1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
>> index 97291bfbeea589e..220d20a829c8a84 100644
>> --- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
>> +++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
>> @@ -500,19 +500,12 @@ bnad_debugfs_init(struct bnad *bnad)
>>  	if (!bna_debugfs_root) {
>>  		bna_debugfs_root = debugfs_create_dir("bna", NULL);
>>  		atomic_set(&bna_debugfs_port_count, 0);
>> -		if (!bna_debugfs_root) {
>> -			netdev_warn(bnad->netdev,
>> -				    "debugfs root dir creation failed\n");
>> -			return;
>> -		}
>>  	}
>>  
>>  	/* Setup the pci_dev debugfs directory for the port */
>>  	snprintf(name, sizeof(name), "pci_dev:%s", pci_name(bnad->pcidev));
>>  	if (!bnad->port_debugfs_root) {
>> -		bnad->port_debugfs_root =
>> -			debugfs_create_dir(name, bna_debugfs_root);
>> -
>> +		bnad->port_debugfs_root = debugfs_create_dir(name, bna_debugfs_root);
> 
> nit: This change seems to only change line wrapping from <= 80 columns wide
>      (still preferred for Networking code) to > 80 columns wide (not so good).
> 
>      Probably this part of the patch should be removed.
>      If not, reworked so it is <= 80 columns wide.

Okay, I'll revert this one.

> 
> Otherwise, this patch looks good to me.

then add: Reviewed-by: Simon Horman <horms@kernel.org>

> 
>>  		atomic_inc(&bna_debugfs_port_count);
>>  
>>  		for (i = 0; i < ARRAY_SIZE(bnad_debugfs_files); i++) {
>> @@ -523,12 +516,6 @@ bnad_debugfs_init(struct bnad *bnad)
>>  							bnad->port_debugfs_root,
>>  							bnad,
>>  							file->fops);
>> -			if (!bnad->bnad_dentry_files[i]) {
>> -				netdev_warn(bnad->netdev,
>> -					    "create %s entry failed\n",
>> -					    file->name);
>> -				return;
>> -			}
>>  		}
>>  	}
>>  }
> 

-- 
Regards,
  Zhen Lei

