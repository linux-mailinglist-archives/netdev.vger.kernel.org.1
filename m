Return-Path: <netdev+bounces-169693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3FFA453EB
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF8C1888659
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4678125485A;
	Wed, 26 Feb 2025 03:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B625484A;
	Wed, 26 Feb 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540124; cv=none; b=lHi/gCBzPa84DgS6DUSJxi9EcKpsSZCZELqMbLuvb2Zrhv3+/1A2WK86M6AC80cK78tFtvFwo1R4IXDUxRt693JHvXQFqxQkJsXb8clSQAGPi+3j2g8KcFh7BzAL4Tsv5dRueFpjpRQ8D9PGMHBigfGGG3WrC4/cWKG7bujrt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540124; c=relaxed/simple;
	bh=tVlWiS96X3TtgIYukU3/d9sRgA+TKxIF0lIF6OM0+So=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nfgzVcfE0CHutXAqCKXlIsE5iqQiqzX4j3mu/aS8K/t5zbdFOdzkZwXZZjH6xywoH5cLAjeOsvEhHNaXi2dRyJm+LyX5EZqwv11f92NAInmt5yYkFyKRpvXSI5e0rk35gFGe1QiWFd6XFIUhb2l0KTcHEM0vXEYufe6MT2NsOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z2fnp190zz9wCL;
	Wed, 26 Feb 2025 11:18:54 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D742614034E;
	Wed, 26 Feb 2025 11:21:58 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Feb 2025 11:21:58 +0800
Message-ID: <da799a9f-f0c7-4ee0-994b-4f5a6992e93b@huawei.com>
Date: Wed, 26 Feb 2025 11:21:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman
	<horms@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR
 annotation
To: Arnd Bergmann <arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>, Salil
 Mehta <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250225163341.4168238-1-arnd@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250225163341.4168238-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/26 0:33, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building with W=1 shows a warning about hns_mdio_acpi_match being unused when
> CONFIG_ACPI is disabled:
>
> drivers/net/ethernet/hisilicon/hns_mdio.c:631:36: error: unused variable 'hns_mdio_acpi_match' [-Werror,-Wunused-const-variable]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/hisilicon/hns_mdio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
> index a1aa6c1f966e..6812be8dc64f 100644
> --- a/drivers/net/ethernet/hisilicon/hns_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
> @@ -640,7 +640,7 @@ static struct platform_driver hns_mdio_driver = {
>   	.driver = {
>   		   .name = MDIO_DRV_NAME,
>   		   .of_match_table = hns_mdio_match,
> -		   .acpi_match_table = ACPI_PTR(hns_mdio_acpi_match),
> +		   .acpi_match_table = hns_mdio_acpi_match,
>   		   },
>   };
>   


Thank you.


But I think it can be changed to:

+ #ifdef CONFIG_ACPI
static const struct acpi_device_id hns_mdio_acpi_match[] = {
	{ "HISI0141", 0 },
	{ },
};
MODULE_DEVICE_TABLE(acpi, hns_mdio_acpi_match);
+ #endif

static struct platform_driver hns_mdio_driver = {
	.probe = hns_mdio_probe,
	.remove = hns_mdio_remove,
	.driver = {
		   .name = MDIO_DRV_NAME,
		   .of_match_table = hns_mdio_match,
		   .acpi_match_table = ACPI_PTR(hns_mdio_acpi_match),
		   },
};

Thansk,
Jijie Shao










