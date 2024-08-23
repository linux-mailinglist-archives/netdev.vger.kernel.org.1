Return-Path: <netdev+bounces-121210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B4E95C32D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 04:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937CA1F23B18
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226B1C694;
	Fri, 23 Aug 2024 02:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF71BDD0;
	Fri, 23 Aug 2024 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379669; cv=none; b=rH47h5i14D5A/OTWBYHESaOB9oQx1xFiy6thiKZMWhpSWo7gzDwiKO3TxQmAyrkWZXDvmzC+EBjQ2B4ZjnoMDsvsvgQ4J6hNId7nTVKO1wgYQMzUdEeJcvz+GbEHvI8DVMGzDMKO1yWV45n4rn4rgHVgD81hQgtOeDjSxR45Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379669; c=relaxed/simple;
	bh=+CzMAqyESps2Nlf43Au9f38lBI4mQgp+HawBJzeZ28w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iONuLTeoVMJjnDJTMLebJJCPjZqnXv7HiGqX9dz7Qvi6yZW/yNn+OZ5jJhRWyA1q0SLPl0aRyGVZLbpjjJmKX2tktrQSIyuiPFlh5jy7V6NMR+AM+xxTa9bzi7+guqnLRz713GAv8kUHA4JxIBAFhlw3ueJXuBwDsYmx3RzuccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WqkM92r1vz1S87j;
	Fri, 23 Aug 2024 10:20:53 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 644E218001B;
	Fri, 23 Aug 2024 10:20:58 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Aug 2024 10:20:57 +0800
Message-ID: <f1842060-0613-db53-a8c6-d0704d500f98@huawei.com>
Date: Fri, 23 Aug 2024 10:20:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] net: dsa: Simplify with scoped for each OF child
 loop
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240820065804.560603-1-ruanjinjie@huawei.com>
 <20240821171817.3b935a9d@kernel.org>
 <2d67e112-75a0-3111-3f3a-91e6a982652f@huawei.com>
 <d44d2e53-6684-4fe5-bcc3-60d387044b63@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <d44d2e53-6684-4fe5-bcc3-60d387044b63@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/22 22:39, Krzysztof Kozlowski wrote:
> On 22/08/2024 04:07, Jinjie Ruan wrote:
>>
>>
>> On 2024/8/22 8:18, Jakub Kicinski wrote:
>>> On Tue, 20 Aug 2024 14:58:04 +0800 Jinjie Ruan wrote:
>>>> Use scoped for_each_available_child_of_node_scoped() when iterating over
>>>> device nodes to make code a bit simpler.
>>>
>>> Could you add more info here that confirms this works with gotos?
>>> I don't recall the details but I thought sometimes the scoped
>>> constructs don't do well with gotos. I checked 5 random uses
>>> of this loop and 4 of them didn't have gotos.
>>
>> Hi, Jakub
>>
>> >From what I understand, for_each_available_child_of_node_scoped() is not
>> related to gotos, it only let the iterating child node self-declared and
>> automatic release, so the of_node_put(iterating_child_node) can be removed.
>>
>> For example, the following use case has goto and use this macro:
>>
>> Link:
>> https://lore.kernel.org/all/20240813-b4-cleanup-h-of-node-put-other-v1-6-cfb67323a95c@linaro.org/
> 
> Jinjie,
> You started this after me, shortly after my series, taking the commit
> msgs and subjects, and even using my work as reference or explanation of
> your patches. Basically you just copy-paste. That's ok, thouogh, but you
> could at least Cc me to tell me that you are doing it to avoid
> duplication. That would be nice... And you could *try to* understand
> what you are doing, so you can answer to such concerns as Jakub raised.
> Otherwise how can we know that your code is correct?

Thank you very much, I'll Cc you for other patches.

> 
> Jakub,
> Scoped uses in-place variable declarations, thus earlier jumps over it
> are not allowed. The code I was converting did not have such jumps, so
> was fine. Not sure if this is the case here, because Jinjie Ruan should
> have checked it and explained that it is safe.
> 
> Best regards,
> Krzysztof
> 

