Return-Path: <netdev+bounces-58195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F9815840
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 08:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FAE2851AF
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D4134C4;
	Sat, 16 Dec 2023 07:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFF134AF;
	Sat, 16 Dec 2023 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ssd834MT5z2mGx6;
	Sat, 16 Dec 2023 15:32:03 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id C57FB1400DA;
	Sat, 16 Dec 2023 15:32:08 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 16 Dec 2023 15:32:08 +0800
Message-ID: <bbc2e5d4-26db-475b-a3ce-352e83f72282@huawei.com>
Date: Sat, 16 Dec 2023 15:32:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: hns3: add new matainer for the HNS3 ethernet driver
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
References: <20231216062929.4180259-1-shaojijie@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231216062929.4180259-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2023/12/16 14:29, Jijie Shao wrote:
> Jijie Shao will be responsible for
> maintaining the hns3 driver's code in the future,
> so add Jijie to the hns3 driver's matainer list.
>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 012df8ccf34e..9de29720e88f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9581,6 +9581,7 @@ F:	drivers/bus/hisi_lpc.c
>   HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
>   M:	Yisen Zhuang <yisen.zhuang@huawei.com>
>   M:	Salil Mehta <salil.mehta@huawei.com>
> +M:	Jijie Shao <shaojijie@huawei.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   W:	http://www.hisilicon.com

Sorry, this patch not add 'net-next' in subject.V2 has been sent， please ignore this patch.


