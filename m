Return-Path: <netdev+bounces-193907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D934AC63A0
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0612D3A60ED
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA7244677;
	Wed, 28 May 2025 08:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4E2A1BA;
	Wed, 28 May 2025 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419532; cv=none; b=qelZ6LqqpZTLBOHHGsjeZw/kcBvlXBkK0zsi4EJlUamiFapc/kO9sw1YAIymHm1jYtrkHgSOyfxVW5gqyysS7vmI0oUmZV4NEerFYSjzmYtMYF5oYvHcfNloDqgUZDWkEodWlGxyBopvfBTwCSlUnlMbPMcFfB0dqL1FPXaFLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419532; c=relaxed/simple;
	bh=ZDPLgkg3MtN9+MqqFoZLuB0esX0Y9CnOOIuDP2Tdf48=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AM09Inz88WedF44FoxiXENwyhK945wQzLHkn79szKycRBmZ0NP1O+xzt2K4PgVMBnkid6IUdGXlISW4d5d7Jn1GaxDEE9d4a+Sw+lDTybyYyTFTTsNu55i8X0lMaBjyQUF+NT1kvYihkfWVAw4Xol8btB3wle6eB9uO6fKODXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4b6hnZ5HvZz1d0ym;
	Wed, 28 May 2025 16:02:58 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D24BE18007F;
	Wed, 28 May 2025 16:04:42 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 May 2025 16:04:42 +0800
Message-ID: <012a9ce8-bc38-4b0b-b344-2e4a7a9a344e@huawei.com>
Date: Wed, 28 May 2025 16:04:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] [net-next] hns3: Demote load and progress messages to
 debug level
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jian Shen
	<shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <0df556d6b5208e4e5f0597c66e196775b45dac60.1748357693.git.geert+renesas@glider.be>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <0df556d6b5208e4e5f0597c66e196775b45dac60.1748357693.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/5/28 3:30, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> No driver should spam the kernel log when merely being loaded.
> The message in hclge_init() is clearly a debug message.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks,
Reviewed-by: Jijie Shao<shaojijie@huawei.com>

> ---
> Alternatively, the printing in hns3_init_module() could be removed
> completely, but that would make hns3_driver_string[] and
> hns3_copyright[] unused, which HiSilicon legal may object against?
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 4 ++--
>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index b03b8758c7774ec2..5c8c62ea6ac0429f 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -5961,8 +5961,8 @@ static int __init hns3_init_module(void)
>   {
>   	int ret;
>   
> -	pr_info("%s: %s - version\n", hns3_driver_name, hns3_driver_string);
> -	pr_info("%s: %s\n", hns3_driver_name, hns3_copyright);
> +	pr_debug("%s: %s - version\n", hns3_driver_name, hns3_driver_string);
> +	pr_debug("%s: %s\n", hns3_driver_name, hns3_copyright);
>   
>   	client.type = HNAE3_CLIENT_KNIC;
>   	snprintf(client.name, HNAE3_CLIENT_NAME_LENGTH, "%s",
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 3e28a08934abd2e1..6bfff77ea7e67e8d 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -12904,7 +12904,7 @@ static struct hnae3_ae_algo ae_algo = {
>   
>   static int __init hclge_init(void)
>   {
> -	pr_info("%s is initializing\n", HCLGE_NAME);
> +	pr_debug("%s is initializing\n", HCLGE_NAME);
>   
>   	hclge_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, HCLGE_NAME);
>   	if (!hclge_wq) {

