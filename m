Return-Path: <netdev+bounces-119347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6957F955489
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 03:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6011C21C9E
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FC71FBA;
	Sat, 17 Aug 2024 01:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F879CF;
	Sat, 17 Aug 2024 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723857096; cv=none; b=SKBizIQM1AS/kQBRnoqE3UFb1K11KUZxz8a6wepzmBSA3KvtdSM0Qbpo6bV+35rqfmTRifsKC4znTQj82YdxbRM+9Ko161dOq11swhsJV2nkudFbGJ+/xA5GJ8LLJatiEJ2rjvwp0+BmaH6QEQNXTn6L2wgeBPHi/0arWXNREQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723857096; c=relaxed/simple;
	bh=e6Ih+qDjS8hZTeJnLYRBVww5GDd/zQv2Vr3ZEKTKLX0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H1Fx+qzFBRQ7s4w0QyoWbOm5zKDFTciD+BK85b7SVe8Gvmj/pyecfpUeaRA4nyVxFbhNM9rbBz6eXCjV3iRFJqde4Cm3k84B8WubpngLhgMkw+hMVw2TG0U5hjt2w+Rh7dlqCTU49SyhsxhxmEx/D8WtYiwfOjmVykg1+zUZK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wm13W4F8CzhXrp;
	Sat, 17 Aug 2024 09:09:27 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D185180100;
	Sat, 17 Aug 2024 09:11:26 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 17 Aug 2024 09:11:25 +0800
Message-ID: <ef78137e-d977-4da5-acfb-00865e3a9837@huawei.com>
Date: Sat, 17 Aug 2024 09:11:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
 <20240813135640.1694993-4-shaojijie@huawei.com>
 <79122634-093b-44a3-bbcd-479d6692affc@lunn.ch>
 <1ff7ba7c-3a25-46b5-a9de-a49d96926e64@huawei.com>
 <7bab865c-b5f6-4319-ba0f-1d0ddc09f9cd@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <7bab865c-b5f6-4319-ba0f-1d0ddc09f9cd@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/17 5:04, Andrew Lunn wrote:
> On Fri, Aug 16, 2024 at 02:10:36PM +0800, Jijie Shao wrote:
>> on 2024/8/16 10:25, Andrew Lunn wrote:
>>>> +struct hbg_mdio_command {
>>>> +	union {
>>>> +		struct {
>>>> +			u32 mdio_devad : 5;
>>>> +			u32 mdio_prtad :5;
>>>> +			u32 mdio_op : 2;
>>>> +			u32 mdio_st : 2;
>>>> +			u32 mdio_start : 1;
>>>> +			u32 mdio_clk_sel : 1;
>>>> +			u32 mdio_auto_scan : 1;
>>>> +			u32 mdio_clk_sel_exp : 1;
>>>> +			u32 rev : 14;
>>>> +		};
>>>> +		u32 bits;
>>>> +	};
>>>> +};
>>> This is generally not the way to do this. Please look at the macros in
>>> include/linux/bitfield.h. FIELD_PREP, GENMASK, BIT, FIELD_GET
>>> etc. These are guaranteed to work for both big and little endian, and
>>> you avoid issues where the compiler decides to add padding in your
>>> bitfields.
>>>
>>> 	Andrew
>> Thanks, I already know about macros like FIELD_PREP or FIELD_GET.
>> and these macros are already used in parts of this patch set.
>>
>> But I think this writing style in here very convenient.
>> Although padding needs to be added during definition,
>> but you can use command.mdio_start or command->mdio_start
>> to access specific bitfields.
>>
>> Although FIELD_PREP/FIELD_GET is convenient,
>> But it also needs to define the mask using BIT or GENMASK,
>> and the mask can only be a static constant,
>> which makes it difficult to use sometimes.
> Have a look around. How many drivers use this sort of union? How many
> use bitfield.h. There is a reason the union is not used. I suspect
> there is nothing in the C standard which guarantees it works.
>
>        Andrew

Ok, thanks for the comment.
I'll fix it in the next version.
	
	Jijie Shao



