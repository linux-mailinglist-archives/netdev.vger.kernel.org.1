Return-Path: <netdev+bounces-219535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A7FB41CEF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DAF3AE492
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7102E8E0F;
	Wed,  3 Sep 2025 11:21:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672552749C6;
	Wed,  3 Sep 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898474; cv=none; b=VC3NnzAIzrr0RlRVor0UM6zUlJb9uJU/2RxBTVmq8PobMynGoVx566gIptimbub3t2ndpo+9YNLPfbVlFWJMj20BOimZEPgfRzd4Yna7+wj16I2GzyyEFDJJcE7QMKFPRfNZzMk7i3rVP6T0eCqYf/5dI8QPGCv31FUT5xe858A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898474; c=relaxed/simple;
	bh=gp+bJM4VN7gLolk7dRG6TtcNbcDtZwGJ4SCCC1Qr23o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JDXaveXLGBkKuAcMmESK6cEdshMbdKMnlUVej5LH4Eo2/kOHImzKOBQsGfNZpdGWJ/NURDzt/b10iloNNk2gS6VW9xYGc+xQutHjk6rTOLj6kDKeQmLycMkM3Ynvhm9rsLMqP6J9VurQpv/Hr5xNa3GDMXYyFgzZMiqirWoQcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cH0Rk19fmz1b104;
	Wed,  3 Sep 2025 19:16:34 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7968B180B67;
	Wed,  3 Sep 2025 19:21:03 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 19:21:02 +0800
Message-ID: <5d597234-f858-4527-b6fd-111356af3705@huawei.com>
Date: Wed, 3 Sep 2025 19:21:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: Add sanity checks on
 ipv6_devconf.seg6_enabled
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250903093948.3030670-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250903093948.3030670-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Sorry, pls ignore this error patch.

On 2025/9/3 17:39, Yue Haibing wrote:
> In ipv6_srh_rcv() we use min(net->ipv6.devconf_all->seg6_enabled,
> idev->cnf.seg6_enabled) is intended to return 0 when either value is zero,
> but if one of the values is negative it will in fact return non-zero.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/addrconf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 40e9c336f6c5..87f14532cb7e 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7193,6 +7193,8 @@ static const struct ctl_table addrconf_sysctl[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
>  	},
>  #ifdef CONFIG_IPV6_SEG6_HMAC
>  	{

