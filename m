Return-Path: <netdev+bounces-200473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DAAE58F4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D7A3B1B16
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D515624D;
	Tue, 24 Jun 2025 01:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEDF70823;
	Tue, 24 Jun 2025 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750727200; cv=none; b=ho6hNqC6h+nZWCI9Vg+mkylALyMGjkifFTv5dEYSkn4odQLkRxmbrSBcd3QZUStKI1RlasyUaL4FadOClr0JW9ZHxPcoy9/mX4JQSgD2zBtPau4Yt3yP76kfNKlxaikdb3M9if2+z7gZ0yl9MhedQk6jhw8FL+SY+1pv49aHNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750727200; c=relaxed/simple;
	bh=rGwARyv8tJA7CfEaxg832PKwn6GR6YzUn0fSflXP0Do=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MjiJsxUeUv3kNJFmWMpOVW85mAAmm0ySlFboz21COd+sjQCpj7/Q+xRlooYxLBxRQqIILDsvcGqGAaGuXfWKBOdGlYrgDpMhIBfoxIAB+yTbBqyYAvv57mDuIz7ByNtkSrWfn9OFp83N3QJJHRyGCIvkRyz+UWhbCXtNSBPP+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bR6B22yxMzPtKl;
	Tue, 24 Jun 2025 09:02:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F72414020C;
	Tue, 24 Jun 2025 09:06:24 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 09:06:23 +0800
Message-ID: <96bc6695-5e9a-4a50-8ea6-c4625806af28@huawei.com>
Date: Tue, 24 Jun 2025 09:06:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 1/3] net: hibmcge: support scenario without
 PHY.
To: Andrew Lunn <andrew@lunn.ch>
References: <20250623034129.838246-1-shaojijie@huawei.com>
 <20250623034129.838246-2-shaojijie@huawei.com>
 <51a9e27a-8a67-4188-8875-8cd81e34765a@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <51a9e27a-8a67-4188-8875-8cd81e34765a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/23 15:32, Andrew Lunn wrote:
> On Mon, Jun 23, 2025 at 11:41:27AM +0800, Jijie Shao wrote:
>> Currently, the driver uses phylib to operate PHY by default.
>>
>> On some boards, the PHY device is separated from the MAC device.
>> As a result, the hibmcge driver cannot operate the PHY device.
>>
>> In this patch, the driver determines whether a PHY is available
>> based on register configuration. If no PHY is available,
>> the driver intercepts phylib operations and operates only MAC device.
>
> The standard way to handle a MAC without a PHY is to use
> fixed_link. It is a fake PHY which follows the usual API, so your MAC
> driver does not need to care there is no PHY.
>
>
>      Andrew


Thank you for the guidance,
I will study and use it.

Thanks
Jijie Shao


