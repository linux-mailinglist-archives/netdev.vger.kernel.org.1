Return-Path: <netdev+bounces-170719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75836A49AD6
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E29C3BB945
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F926D5D0;
	Fri, 28 Feb 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="HF6g7Fec"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-18.ptr.blmpb.com (va-1-18.ptr.blmpb.com [209.127.230.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1726D5DA
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750218; cv=none; b=VGJjR8sfCB8r2/hXzyvUKOfrLiHCFYw/ky5aPeNLOBhOMGGb0jzYFrkNritkeI+o6SLVv4xdickEf9+j4W4CQR9dDCE1fXUx9j8rHJq/LCrdQVWvBqyiWP81Um5X0P6HMtfZo+MQC1G2aVR8yF6nsYf9H05D75wjqUAzgxysMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750218; c=relaxed/simple;
	bh=nyveHrpi2mHu3E3KCcr5lLpzCZk11ZQMjKH9mF4C1dA=;
	h=In-Reply-To:To:Cc:Message-Id:Subject:Date:From:Mime-Version:
	 References:Content-Type; b=dgrNuM5rkYb4De4SVxJ5rrOrUHSgMg2BKLuoTrGbdk9l7wTkUw19B4PV++wiq8sBjhFE8YM9hLFKSZjfLDsnViQ7nwbKuiFjchJISja5CVV1kiFxkF9jU50PJocbkL5G8bS2tuXfaJ76akGVZtE94FmZWEeTuhhND1hmZfpCDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=HF6g7Fec; arc=none smtp.client-ip=209.127.230.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740750203; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nyveHrpi2mHu3E3KCcr5lLpzCZk11ZQMjKH9mF4C1dA=;
 b=HF6g7Fec9ABlvjr3+oxWlPfle4HI70A91TXPLURCRMaGpbHIB8u+/CtuzLEO/M/w268azH
 HWtcEubnLU3bUxoI+8wDAUOJcaoLNI7JpK1NwL1snhbhTpfNqGedLLx1YxaHx5ERwi7olX
 WJ/eEOxQaVvUmFt6mYCGzU73NtdyEyb7BNLfKuVdM7jV4zsXKvuujV7dZkQyVIPlT7mplh
 yhlHVtwKyTcbJdQBzfmWpPNl5paBDUk9t73kBHgwlGH2GDP2QvtMpu7THqB9MqQmVFz8pg
 7K9eWBWnxhyAq0vuyna4MFDVfD4LRxg64Gf2UE/Zh0GavMXzrmk3mT6kalokOw==
In-Reply-To: <20250227082316.5bd669a3@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Message-Id: <f9b85c0e-b9eb-4676-9c09-8617220115d6@yunsilicon.com>
Received: from [127.0.0.1] ([183.193.164.49]) by smtp.feishu.cn with ESMTPS; Fri, 28 Feb 2025 21:43:20 +0800
Subject: Re: [PATCH net-next v6 00/14] xsc: ADD Yunsilicon XSC Ethernet Driver
Date: Fri, 28 Feb 2025 21:43:19 +0800
Content-Transfer-Encoding: 7bit
X-Original-From: Xin Tian <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267c1bd79+17a704+vger.kernel.org+tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
From: "Xin Tian" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227082558.151093-1-tianx@yunsilicon.com> <20250227082316.5bd669a3@kernel.org>
Content-Type: text/plain; charset=UTF-8

On 2025/2/28 0:23, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 16:26:36 +0800 Xin Tian wrote:
>> The patch series adds the xsc driver, which will support the YunSilicon
>> MS/MC/MV series of network cards. These network cards offer support for
>> high-speed Ethernet and RDMA networking, with speeds of up to 200Gbps.
>>
>> The Ethernet functionality is implemented by two modules. One is a
>> PCI driver(xsc_pci), which provides PCIe configuration,
>> CMDQ service (communication with firmware), interrupt handling,
>> hardware resource management, and other services, while offering
>> common interfaces for Ethernet and future InfiniBand drivers to
>> utilize hardware resources. The other is an Ethernet driver(xsc_eth),
>> which handles Ethernet interface configuration and data
>> transmission/reception.
>>
>> - Patches 1-7 implement the PCI driver
>> - Patches 8-14 implement the Ethernet driver
>>
>> This submission is the first phase, which includes the PF-based Ethernet
>> transmit and receive functionality. Once this is merged, we will submit
>> additional patches to implement support for other features, such as SR-IOV,
>> ethtool support, and a new RDMA driver.
> drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c:525:14-15: WARNING: *_pool_zalloc should be used for mailbox -> buf, instead of *_pool_alloc/memset
> drivers/net/ethernet/yunsilicon/xsc/pci/hw.c:40:17-24: WARNING: vzalloc should be used for board_info [ i ], instead of vmalloc/memset
> drivers/net/ethernet/yunsilicon/xsc/net/main.c:1946:21-22: WARNING kvmalloc is used to allocate this memory at line 1933
> drivers/net/ethernet/yunsilicon/xsc/net/main.c:1968:22-28: ERROR: adapter is NULL but dereferenced.
> drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c:284:14-21: WARNING: Unsigned expression compared with zero: num_dma < 0
Thanks, I'll fix them.

