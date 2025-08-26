Return-Path: <netdev+bounces-216754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF59B350C6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E983245047
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD826C383;
	Tue, 26 Aug 2025 01:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D43265623;
	Tue, 26 Aug 2025 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170551; cv=none; b=WkZSmaW5sDtsYuKrDU/y8OINO2xfDJ7JbbfhGOeRUn7A4wBHNdGrgE9F9cqTehX3teCUJZt1PZHKFO64Toa8kXknoabKHqueUv+O+l3lgvqzghbWYXaPAikyyvVMWSkrSDFBOAwAquBYYRcIe0OXLqqeZZ4OLSMVcyq49QY8dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170551; c=relaxed/simple;
	bh=rGYCICAMdYUKHVW1VWlSGUI+ss2kW4mTJBpUrBFfAqw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m3hzFUQRCoFR1f/1qhBWpV5vHjuN2n0ZVwYUm/60ep6Aa+ab0yMKLGgJbRHRwfoy0zzvMq2vPxk+EhCgea5oAXmjthM5RN1WtTW+hUrPhrp06fsZ7p+tPz3tNDHVgQYbYcmgomaahkSMorG5tbTb4JHywKuBbpiH3en710kzavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c9qLL4wDvz14MD9;
	Tue, 26 Aug 2025 09:08:58 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0143D180481;
	Tue, 26 Aug 2025 09:09:05 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 09:09:04 +0800
Message-ID: <c8d6fd87-c028-40e8-8158-99f636e74538@huawei.com>
Date: Tue, 26 Aug 2025 09:09:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>
Subject: Re: [PATCH] net: hns3: use kcalloc() instead of kzalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>, Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250825142753.534509-1-rongqianfeng@vivo.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250825142753.534509-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/8/25 22:27, Qianfeng Rong wrote:
> As noted in the kernel documentation [1], open-coded multiplication in
> allocator arguments is discouraged because it can lead to integer overflow.
>
> Use devm_kcalloc() to gain built-in overflow protection, making memory
> allocation safer when calculating allocation size compared to explicit
> multiplication.
>
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments #1
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Thanks,
Reviewed-by: Jijie Shao <shaojijie@huawei.com>

>   drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> index 0255c8acb744..4cce4f4ba6b0 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> @@ -843,7 +843,7 @@ static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
>   
>   	entry_dir = hns3_dbg_dentry[hns3_dbg_cmd[cmd].dentry].dentry;
>   	max_queue_num = hns3_get_max_available_channels(handle);
> -	data = devm_kzalloc(&handle->pdev->dev, max_queue_num * sizeof(*data),
> +	data = devm_kcalloc(&handle->pdev->dev, max_queue_num, sizeof(*data),
>   			    GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;

