Return-Path: <netdev+bounces-171919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32517A4F604
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 05:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C961885F46
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 04:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09208193062;
	Wed,  5 Mar 2025 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="DBvHO/Uc"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634D15749C
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148271; cv=none; b=bmlLdIpDao1VHUW9G0Y19ehN7Ub0ONguWSkRmW+dTPe55wseXPakD9VK48vLxX5pElPOwZHsQr0p40xB+cJ6gldB+YofuwspsCNiQTcWdYaNeabSe7RvEtObRZH5bothjIc7TABV2QB9bfN7b44dPtf2DunMPTSsQHpGeLAfS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148271; c=relaxed/simple;
	bh=gf1vCeIYW/tU4JLszFsmSkMmSGYph87fs8T0zc8B3qI=;
	h=In-Reply-To:Subject:Date:Mime-Version:References:Message-Id:
	 Content-Type:To:Cc:From; b=sYk3jAJFhi2wNyJ+IjmVILeRxX/Nj5JdCiVAZvZc/Cwyitq8U5WG6gjmjvab70rvLAY41vZmdzl3IuWBHIDO39ls1I5xIEQUn8wwde8r6SqLlhWC2jqtSIDqWCOhOJVabsOL/pbSnQIEMow8HNOZwrmNPHi9X52Ps8b1ad+/11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=DBvHO/Uc; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741148262; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=d23xR35t8Zj0HdI9r08jOc+TPTLVTFFZxAF+8Y3vY6c=;
 b=DBvHO/UcDYbdKK/p61G/v1QpAx2SfwFf9AcnfOo48taBkRkmUfytMLk6jCfsf2iI9Aox8G
 MyoxqZJspz/LuOngoz1Z9IzhUinJYmzRIUOO5nQEuZYzJUYFoSsDGm2e6yfKvIroXm3GMF
 FPFWf7DHvCxjJy6UJLoOI1p75tJaS8Oyhmqw4RZsOUqnGLpp5unkNh84VB+uhOYMbh9gk0
 h+Xsv9yVHDR25QJi806YC5BKvmGn5d0l7u6CZ596iEflimpDqBhklo8cH3ihmFw4BGtaW5
 lFkNCxgohs8IBaCB95PGxOmirb/TG2rqESL9BHuIt1qbeHTRjUJAus3XSd7oug==
In-Reply-To: <20250304184819.6e28c29a@kernel.org>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Wed, 05 Mar 2025 12:17:39 +0800
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v7 01/14] xsc: Add xsc driver basic framework
Date: Wed, 5 Mar 2025 12:17:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267c7d064+96df17+vger.kernel.org+tianx@yunsilicon.com>
References: <20250228154122.216053-1-tianx@yunsilicon.com> <20250228154122.216053-2-tianx@yunsilicon.com> <20250304184819.6e28c29a@kernel.org>
Message-Id: <4478921b-067d-484d-ab09-0789c0cdb2ed@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird

On 2025/3/5 10:48, Jakub Kicinski wrote:
> On Fri, 28 Feb 2025 23:41:24 +0800 Xin Tian wrote:
>> +config NET_VENDOR_YUNSILICON
>> +	depends on ARM64 || X86_64
> || COMPILE_TEST please ?
OK
>
>> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
>> new file mode 100644
>> index 000000000..6fc8259a7
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/Makefile
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +# Makefile for the Yunsilicon device drivers.
>> +#
>> +
>> +# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
> Why are you adding commented out lines? Add them where needed
ack
>
>> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
>> \ No newline at end of file
> new line missing
ack
>
>> new file mode 100644
>> index 000000000..de743487e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +# Yunsilicon driver configuration
>> +#
>> +
>> +config YUNSILICON_XSC_ETH
>> +	tristate "Yunsilicon XSC ethernet driver"
>> +	default n
> n is the default, you don't have to specify it
ack
>
>> +xsc_eth-y := main.o
>> \ No newline at end of file
> new line
ack
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>> new file mode 100644
>> index 000000000..2b6d79905
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +# Yunsilicon PCI configuration
>> +#
>> +
>> +config YUNSILICON_XSC_PCI
>> +	tristate "Yunsilicon XSC PCI driver"
>> +	default n
> no need
ack
>
>> +	select PAGE_POOL
> Why is this in the PCI driver, not the ETH driver?
> Please add this line in a patch which actually makes use of page pool
OK, should be in the ETH driver, thanks for pointing that out
>> +static int set_dma_caps(struct pci_dev *pdev)
>> +{
>> +	int err;
>> +
>> +	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +	if (err)
>> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> +	else
>> +		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> Please grep git history for dma_set_mask_and_coherent
> The fallback is unnecessary, just:
>
> 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));

OK

Thanks

>
>> +	if (!err)
>> +		dma_set_max_seg_size(&pdev->dev, SZ_2G);
>> +
>> +	return err;
>> +}

