Return-Path: <netdev+bounces-210270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C05BB1286F
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 03:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B825827C0
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929F1A704B;
	Sat, 26 Jul 2025 01:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9872635;
	Sat, 26 Jul 2025 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753493491; cv=none; b=pWoUiZS6uUjmTALPgybKSBnGBeflc+PpL90G3eRiSxTfXZv7S4IIEXzLG+i15x7ur5mDrTnWUYx12SQSFSsj3NJYAXiFYpOCEjoiiA0bzZ3zGKwgICuX80RiZElN/JWuNZtUFS0H1CfDxrnPCdBIqwEjf79c5gjdzOX42Zvjesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753493491; c=relaxed/simple;
	bh=RQ6ra1R7nNSjq0Z2srYDXojlaDoiAIXrb8y2ulQ9Q58=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DvqiTtmH7ouSEF8CHgUxDnGgLgVzVb3qCXNqVWINyFhtSdHYHdfM/u1FFzb3R/4JELtCEUJ76Y5Nnq+jMAVku8MqW8uK3cA2pSg3oW5sWzX26lsX+6yobiWL3IwCr7NFcECbR1HwJhFK+wESkVNSmpP2AxxNvtEP0Nu0BumbPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bpnKc0mwDz27j2F;
	Sat, 26 Jul 2025 09:32:20 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 60AF4140118;
	Sat, 26 Jul 2025 09:31:19 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Jul 2025 09:31:18 +0800
Message-ID: <514b2e53-83fd-43e3-aa1f-21b9ff14b31a@huawei.com>
Date: Sat, 26 Jul 2025 09:31:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: mcast: Add ip6_mc_find_idev() helper
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250724115631.1522458-1-yuehaibing@huawei.com>
 <20250725144547.05a48cc1@kernel.org>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250725144547.05a48cc1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/7/26 5:45, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 19:56:31 +0800 Yue Haibing wrote:
>>  net/ipv6/mcast.c | 76 +++++++++++++++++++++++-------------------------
>>  1 file changed, 36 insertions(+), 40 deletions(-)
> 
> Dunno if this is worth the churn to save 4 lines.
> I was waiting to see if anyone will offer a review tag
> but it's getting a bit later in the review cycle, 
> please try again after the merge window.

Ok, thank you for your review.

