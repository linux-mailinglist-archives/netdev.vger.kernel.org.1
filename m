Return-Path: <netdev+bounces-203086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3549AF07B0
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041B817A8DE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91062A1AA;
	Wed,  2 Jul 2025 01:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8A20311;
	Wed,  2 Jul 2025 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418282; cv=none; b=D/hH4jGCGW5cWdHZJgDunFPzlPlNiffLxYnYUwW5gIJLQWEUxUkcjvobtQzSNlKX/raCk/pB0opb83VwgxYvVK5n0f1CY3GFdXjVJhXidUgJ6Stn2urLM/dunMarudzOzfrlSl1HIlqkvvGuPQqDy8prA+GZQXl+crJYZRVlrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418282; c=relaxed/simple;
	bh=XAafEd/BG8qoJXRKDepV1XfLCyhQ+O787ct9l00N54o=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aj4vkkxeKgHMinbIhnLm4z8EyMAG2Jlkgu8wqSAE6dfnEda1jOi3/AO9SfN+fMPqPISqkY9NVb/xB2JNkSqDF7eKnFkza/731IyXANWjpQDSRJAeWe0sBR3LSH5R08a/qwtsESMY66oBck2ji1jQINhgA/poLeKLNtc4kcxwn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bX1m40KKgzmZB9;
	Wed,  2 Jul 2025 09:00:36 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C6F2D140277;
	Wed,  2 Jul 2025 09:04:36 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 09:04:36 +0800
Message-ID: <0c0d95ce-7c38-42d7-b45e-e7d388b57ede@huawei.com>
Date: Wed, 2 Jul 2025 09:04:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 1/3] net: hibmcge: support scenario without
 PHY
To: Andrew Lunn <andrew@lunn.ch>
References: <20250701125446.720176-1-shaojijie@huawei.com>
 <20250701125446.720176-2-shaojijie@huawei.com>
 <9b45bab6-dc6e-40b5-b37c-2b296213e8ed@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <9b45bab6-dc6e-40b5-b37c-2b296213e8ed@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/7/2 6:07, Andrew Lunn wrote:
>> +	phydev = fixed_phy_register(&hbg_fixed_phy_status, NULL);
>> +	if (IS_ERR(phydev)) {
>> +		dev_err_probe(dev, IS_ERR(phydev),
> IS_ERR() returns a bool, where as dev_err_probe() expects an int.

Yeah,
PTR_ERR(phydev) should be used in there

Thanks,
Jijie Shao

>
>> +			      "failed to register fixed PHY device\n");
>> +		return IS_ERR(phydev);
> This also looks wrong.
>
>      Andrew
>
> ---
> pw-bot: cr

