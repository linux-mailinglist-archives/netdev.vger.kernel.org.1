Return-Path: <netdev+bounces-134186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39699852C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363D12833D7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8B1C460B;
	Thu, 10 Oct 2024 11:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE41C579D;
	Thu, 10 Oct 2024 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560229; cv=none; b=kFoj7Jj9P+saLSP+s7rOGoc4v3gTuYNuAEnhXMedqc5EmLNR+auQe3JF5IZ7sCcW+X5Wa56WxXbl30iR/dtPqn3sI1g9Iqkslc9dYZbtXD8hX68bx2HAskLpEDsLY7u9klsu1AHl6W9CyUChoARfURXl6KnyNHfbBZ6znJQdVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560229; c=relaxed/simple;
	bh=YbnyJmpvU4EcQJVRyA/cXbEEzA7lbQ/nhBxqeUhjHMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pOgxNYUpUZ5ly+o297ZeeTPy9kRghyXV2pBJujdiM4BLNk7GLIv58+Y19BPpJicbPLehrYqu31Oea/I+bJ3rQDLj556gDCTlVSB17enNAJZCq6YK+uYQD8OmnbXZSIC6cqeTtIDypvlXDNEpnyJ/95m6vAL6RNmZW+KKyf4VNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPSPG2CS0zySyh;
	Thu, 10 Oct 2024 19:35:46 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B8D701402CA;
	Thu, 10 Oct 2024 19:37:03 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 19:37:03 +0800
Message-ID: <159495c8-71be-4a11-8c49-d528e8154841@huawei.com>
Date: Thu, 10 Oct 2024 19:37:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 14/14] mm: page_frag: add an entry in
 MAINTAINERS for page_frag
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-15-linyunsheng@huawei.com>
 <20241008174350.7b0d3184@kernel.org>
 <a3f94649-9880-4dc0-a8ab-d43fab7c9350@huawei.com>
 <be4be68a-caff-4657-9a49-67b3eaefe478@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <be4be68a-caff-4657-9a49-67b3eaefe478@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/10 0:32, Paolo Abeni wrote:
> Hi,

Hi,

> 
> On 10/9/24 06:01, Yunsheng Lin wrote:
>> On 2024/10/9 8:43, Jakub Kicinski wrote:
>>> On Tue, 8 Oct 2024 19:20:48 +0800 Yunsheng Lin wrote:
>>>> +M:    Yunsheng Lin <linyunsheng@huawei.com>
>>>
>>> The bar for maintaining core code is very high, if you'd
>>> like to be a maintainer please start small.
>>
>> I did start small with the page_pool case, as mentioned in
>> [1] of a similar comment, and the page_frag is a small
>> subsystem/library as mentioned in commit log.
>>
>> I think I still might need a second opinion here.
>>
>> 1. https://lore.kernel.org/linux-kernel/dea82ac3-65fc-c941-685f-9d4655aa4a52@huawei.com/
> 
> Please note that the 'small' part here does not refer strictly to code size. Any core networking code has the bar significantly higher than i.e. NIC drivers - even if the latter could count order of magnitude more LoC.
> AFAICS there is an unwritten convention that people are called to maintain core code, as opposed to people appointing themself to maintain driver code.

Is there any discussion that is referring to above 'unwritten convention'?
As my pool community experience tells me the above 'unwritten
convention' is mainly referring to well-established subsystem that is
already in the MAINTAINERS, and page_frag is not really a subsystem or
library before this patchset, it seems common to me that someone being
willing and able to turn it into a subsystem or library might become the
co-maintainer if she/he is also willing to co-maintain it.

> 
> Cheers,
> 
> Paolo
> 
> 

