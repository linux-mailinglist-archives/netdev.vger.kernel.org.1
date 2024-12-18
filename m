Return-Path: <netdev+bounces-153042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA19F6A20
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E7916A5B3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71132139579;
	Wed, 18 Dec 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="HAQ2IHWe"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9E1DFF7
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536152; cv=none; b=UhfqvdaDHg4EO2ktgyIlo6KcivWDha8KAkVm09FvMnWTpQr1BclhjHf7L0kRcpq4gPpr70R+8vQ6E9owdPxqRyeE5P5eL6FCjVyHzeJ9nrqYNCwR6fsknvgqO3pN4L2T78pcfemFwo09zmFSJEcWJZkdY6K1qpGuBGmBiBu5Z74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536152; c=relaxed/simple;
	bh=y8UXqVvqITfwm/uG5lrIxCuIm9wAy9suHCzyz/GVqP4=;
	h=Content-Type:References:Cc:Subject:To:From:Mime-Version:Date:
	 Message-Id:In-Reply-To; b=NfJRGJij/UA56ee6BcnhnM1ONjgK1gGqzSO6D6fu6km9+BiHaBgHzCFt6EB8KJU4dt0jvqB3d9Tvv4volrhaIlEMPevfaGyq2fQN+mLb6ddk0fPPQUmzGQsCcuYG4g866hXt4D4AILJWdRo5mLy8HI4NbT2FErSRdcXaoQ0ZV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=HAQ2IHWe; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734536143; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=lMIJUM9yRFJNNwc9TRMUezYg1jRJpB57M3OOStW85VI=;
 b=HAQ2IHWeWMpR6k2+Lkb1SN1vRq8O04Oe86TeSomO371gGYV8xhg6SeOOO8kE9lzdiII9Qe
 iYqoUikUlHWTauKHoOrnkfv1awGtgPb3XGhb9RvbU9NeFVQqiymBYF5e+HhQIiZSXANnHv
 MGzYhLAc5McbuwXcvXSceBQjcVE9Ba03NhBjytmpF45+BUeW7wbNN3xG2vnsnxQkUs72pX
 ii0WyBPJlyCbQPDyCBgkR9hJiGMJbr0sh7k37o7gJH49eUdjzvbP9d63VLD+aaNPPlvO6E
 kywhji/dXTMYXBegQw3+X5i4CYXJ2QBxTC6xHGu7o2rPI3gAghL6YJf0ZXeiVA==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
References: <20241209071101.3392590-9-tianx@yunsilicon.com> <f4292a69-6956-4028-b5a2-c1b54893718f@lunn.ch>
Received: from [127.0.0.1] ([183.193.167.29]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 23:35:40 +0800
X-Lms-Return-Path: <lba+26762ebcd+2e5a40+vger.kernel.org+tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <weihg@yunsilicon.com>
Subject: Re: [PATCH 08/16] net-next/yunsilicon: Add ethernet interface
To: "Andrew Lunn" <andrew@lunn.ch>
From: "tianx" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Original-From: tianx <tianx@yunsilicon.com>
Date: Wed, 18 Dec 2024 23:35:39 +0800
Message-Id: <7cb1bf46-2a6f-4fde-a6da-3d01bec4293b@yunsilicon.com>
In-Reply-To: <f4292a69-6956-4028-b5a2-c1b54893718f@lunn.ch>

We need to do some cleanup work when the machine shutdown. But it's not 
necessary in current series, so the reboot callback have been removed in 
v1 code

On 2024/12/9 21:40, Andrew Lunn wrote:
> On Mon, Dec 09, 2024 at 03:10:53PM +0800, Tian Xin wrote:
>> From: Xin Tian <tianx@yunsilicon.com>
>>
>> Build a basic netdevice driver
>>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> ---
>>   drivers/net/ethernet/yunsilicon/Makefile      |   2 +-
>>   .../ethernet/yunsilicon/xsc/common/xsc_core.h |   1 +
>>   .../net/ethernet/yunsilicon/xsc/net/main.c    | 135 ++++++++++++++++++
>>   .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  16 +++
>>   .../yunsilicon/xsc/net/xsc_eth_common.h       |  15 ++
>>   5 files changed, 168 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
>>
>> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
>> index 950fd2663..c1d3e3398 100644
>> --- a/drivers/net/ethernet/yunsilicon/Makefile
>> +++ b/drivers/net/ethernet/yunsilicon/Makefile
>> @@ -4,5 +4,5 @@
>>   # Makefile for the Yunsilicon device drivers.
>>   #
>>   
>> -# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
>> +obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
>>   obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
>> \ No newline at end of file
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> index 88d4c5654..5d2b28e2e 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> @@ -498,6 +498,7 @@ struct xsc_core_device {
>>   	struct pci_dev		*pdev;
>>   	struct device		*device;
>>   	struct xsc_priv		priv;
>> +	void			*netdev;
>>   	void			*eth_priv;
>>   	struct xsc_dev_resource	*dev_res;
>>   
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
>> new file mode 100644
>> index 000000000..243ec7ced
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
>> @@ -0,0 +1,135 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#include <linux/reboot.h>
> reboot.h in an ethernet driver?
>
>> +static int xsc_net_reboot_event_handler(struct notifier_block *nb, unsigned long action, void *data)
>> +{
>> +	pr_info("xsc net driver recv %lu event\n", action);
>> +	xsc_remove_eth_driver();
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +struct notifier_block xsc_net_nb = {
>> +	.notifier_call = xsc_net_reboot_event_handler,
>> +	.next = NULL,
>> +	.priority = 1,
>> +};
> This needs a comment explanation why this driver needs something
> special during reboot.
>
>      Andrew
>
> ---
> pw-bot: cr

