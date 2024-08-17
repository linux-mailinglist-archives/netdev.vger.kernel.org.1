Return-Path: <netdev+bounces-119383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E09555BB
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 08:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4481F22A35
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B47D417;
	Sat, 17 Aug 2024 06:15:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CB1E52C;
	Sat, 17 Aug 2024 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875329; cv=none; b=aRaOGrd33jUPK6O3wfywVTuTtuXh0JUHyNg7SVIg4V5YLL7cSevKeo2VbHmhEqMd6fo8bx0R95uBYnAUFodcjxFoAq8RFOSzN9rjXQyZOPWRZYpx6O8D+5LnNm0tScllUqvLfDcDPlosmmt2Q9JP5w9RQbcoxvKV1xsUPL1aplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875329; c=relaxed/simple;
	bh=AYQp8r4LWRwy7ODCGzAO9/jcbD6lhUJOm65ht+Gm7/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YVOeDcUukK9L96LJpnMN1RiUm5q+xfETbEVXOogOAZIUMewJldaHa22qoXW9lukB+UKVU4yDMJlHyH9Ce2p+OcNJW9nk7iOoYG1DG9hZUfzrAt2f0fkt0kjML8un6aGs2w+H6nC6NDX2BCT118uG5BwlrKAem2yS52uowR6Q2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wm7pD4YMLz1xv56;
	Sat, 17 Aug 2024 14:13:24 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E8DB140138;
	Sat, 17 Aug 2024 14:15:17 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 17 Aug 2024 14:15:16 +0800
Message-ID: <adae952a-6a99-ea21-ac98-c304f4afcba0@huawei.com>
Date: Sat, 17 Aug 2024 14:15:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH net-next] gve: Remove unused declaration
 gve_rx_alloc_rings()
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <jeroendb@google.com>, <pkaligineedi@google.com>, <shailend@google.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <hramamurthy@google.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240816101906.882743-1-yuehaibing@huawei.com>
 <20240816164513.GY632411@kernel.org>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20240816164513.GY632411@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)


On 2024/8/17 0:45, Simon Horman wrote:
> On Fri, Aug 16, 2024 at 06:19:06PM +0800, Yue Haibing wrote:
>> Commit f13697cc7a19 ("gve: Switch to config-aware queue allocation")
>> convert this function to gve_rx_alloc_rings_gqi().
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> In future, please consider grouping similar changes, say up to 10,
> in a patchset.

ok, thanks for your review.
> .

