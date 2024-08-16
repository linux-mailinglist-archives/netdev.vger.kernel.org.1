Return-Path: <netdev+bounces-119117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0D95418A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB11D2867BF
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519B382863;
	Fri, 16 Aug 2024 06:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B282890;
	Fri, 16 Aug 2024 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788644; cv=none; b=U2XyRGikVpbqdeZAJQEWmI6t0MyKD52qqWe9+C6dHKoWzexJK6Par2JNtvcjsX/Nf8EDKO56d0eu/IzYVoAd44purJIkqMabpjOcJtq6vtaK/SseGAz+4PuOhD+KRqPksHl7MwYUl1Nfc/+QOs+VnxlT5tBAnOGDfc0O2QP3DX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788644; c=relaxed/simple;
	bh=f5I40ueG+GA6DczC0K//AvWMSZ9tmjRqZd2y2qq7HtY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aryc1QHoWbteg8xCJJm7KdwIJ6zKOjpZJXGTB7gsIjNx/Bzzy/Csfa7/UWQtOfo80NJUFwDB/Q/AKRRsmGOAijLLy1YQQFia/Czo1Br/DZhFurCo+vwS3Gpd18IQxFyJ6i4dfd/cynZRrTEvSC1OAd2tyFrSjsXWt1iAC5vGKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WlWgq35zCz1S823;
	Fri, 16 Aug 2024 14:05:43 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 175F014010C;
	Fri, 16 Aug 2024 14:10:38 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:10:37 +0800
Message-ID: <1ff7ba7c-3a25-46b5-a9de-a49d96926e64@huawei.com>
Date: Fri, 16 Aug 2024 14:10:36 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <79122634-093b-44a3-bbcd-479d6692affc@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/16 10:25, Andrew Lunn wrote:
>> +struct hbg_mdio_command {
>> +	union {
>> +		struct {
>> +			u32 mdio_devad : 5;
>> +			u32 mdio_prtad :5;
>> +			u32 mdio_op : 2;
>> +			u32 mdio_st : 2;
>> +			u32 mdio_start : 1;
>> +			u32 mdio_clk_sel : 1;
>> +			u32 mdio_auto_scan : 1;
>> +			u32 mdio_clk_sel_exp : 1;
>> +			u32 rev : 14;
>> +		};
>> +		u32 bits;
>> +	};
>> +};
> This is generally not the way to do this. Please look at the macros in
> include/linux/bitfield.h. FIELD_PREP, GENMASK, BIT, FIELD_GET
> etc. These are guaranteed to work for both big and little endian, and
> you avoid issues where the compiler decides to add padding in your
> bitfields.
>
> 	Andrew

Thanks, I already know about macros like FIELD_PREP or FIELD_GET.
and these macros are already used in parts of this patch set.

But I think this writing style in here very convenient.
Although padding needs to be added during definition,
but you can use command.mdio_start or command->mdio_start
to access specific bitfields.

Although FIELD_PREP/FIELD_GET is convenient,
But it also needs to define the mask using BIT or GENMASK,
and the mask can only be a static constant,
which makes it difficult to use sometimes.

Thanks a lot!
	
	Jijie Shao


