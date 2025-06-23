Return-Path: <netdev+bounces-200106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A43AE3361
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBB43A6AFD
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 01:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EE7225D7;
	Mon, 23 Jun 2025 01:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A52F43;
	Mon, 23 Jun 2025 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643018; cv=none; b=rLHzmKdTxEHNu8pSsMulxUIsIaMEYeyU0WMpnV+ckPbHHVozgQap7eBPm58qD4ePhDPnwKEfG56IHO3a0klI5azBLfyu+n6XttCawC3XJ7Tz1e/37xaBwzBepnM6cw9Mo0k75ZV8cTB+Jht5cyfAN7Jgce10nTv/idiz8e75xJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643018; c=relaxed/simple;
	bh=+gdfI7A/tzayixzmDPeS3II3+oUXbkW3kDFTSY2WBHU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qkbMmyiemZvH0YvWbzeDy7Gl875ljtr+hhm5pZGgu6tXybWMrfbQp4VbdpFVFgKRaX8SwfT0J9ZJCd/W9RZimkoZyRXS0q0twJGIPSWkX6/RtquwN5P5yt6mDN0//YR/ywgLlEDYhjLu23VEOqh1aVYXz3IqmvBKgrki8vu/RIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bQW8g5ltbz2QTyp;
	Mon, 23 Jun 2025 09:44:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 13FF4180042;
	Mon, 23 Jun 2025 09:43:25 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 09:43:24 +0800
Message-ID: <8e896bc3-b153-4db2-b874-4374376db9a0@huawei.com>
Date: Mon, 23 Jun 2025 09:43:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: hibmcge: configure FIFO thresholds
 according to the MAC controller documentation
To: Jakub Kicinski <kuba@kernel.org>
References: <20250619144423.2661528-1-shaojijie@huawei.com>
 <20250619144423.2661528-4-shaojijie@huawei.com>
 <20250621083543.67459b3b@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250621083543.67459b3b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/21 23:35, Jakub Kicinski wrote:
> On Thu, 19 Jun 2025 22:44:23 +0800 Jijie Shao wrote:
>> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_FULL_M, full);
>> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_EMPTY_M	, empty);
>> +	}
>> +
>> +	if (dir & HBG_DIR_RX) {
>> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_FULL_M, full);
>> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_EMPTY_M	, empty);
> nit checkpatch says:
>
> WARNING: line length of 81 exceeds 80 columns
> #62: FILE: drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:306:
> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_EMPTY_M	, empty);
>
> ERROR: space prohibited before that ',' (ctx:WxW)
> #62: FILE: drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:306:
> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_EMPTY_M	, empty);
>   		                                                      	^
>
> WARNING: line length of 81 exceeds 80 columns
> #67: FILE: drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:311:
> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_EMPTY_M	, empty);
>
> ERROR: space prohibited before that ',' (ctx:WxW)
> #67: FILE: drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:311:
> +		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_EMPTY_M	, empty);
>   		                                                      	^
>
> total: 2 errors, 2 warnings, 0 checks, 79 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>        mechanically convert to the typical style using --fix or --fix-inplace.

This is my mistake.
Thanks for the guidance.

Thanks
Jijie Shao


