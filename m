Return-Path: <netdev+bounces-158794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683E9A134A1
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4A4166C8F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E5B198A38;
	Thu, 16 Jan 2025 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="eY3SXb1c"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC5381AA
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014704; cv=none; b=Enig5HstWKibdQyDw7pZlJQEE5PvMRFTGhoksZn+qjuhay9cx5vhHcU/sUflqeamOHkK/QtxiHUcyPFuXkLKUtQ2o+bKtc9RMxb8teblXR0jiSucdcMB0NAT5gEQA6q8n+8T61BMGiIT/ABUiZkY6D2wvKaij1Sdgkki8rrYt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014704; c=relaxed/simple;
	bh=qtNhhWaYVNIQ1W7ff/AqT3OpVKqnXiZmtxv2hLFGQ94=;
	h=In-Reply-To:Date:Content-Type:From:Subject:Message-Id:
	 Mime-Version:Cc:References:To; b=HLyvGlmSVRh3lRktSsj2kcy2738YizqAREIiCum7wWV73LqC6PdM0dyxWeJTr6ghPbfugcNqZXobGVs2hUBHVbaLXb4hh+AtdeacbvkzilmCPvcSPG/F4R+I4V9ofcZK8F8R4BGJrohHB4yncy0Pv75rgdmr5Gc0f0CRBxwzroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=eY3SXb1c; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1737014692; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qtNhhWaYVNIQ1W7ff/AqT3OpVKqnXiZmtxv2hLFGQ94=;
 b=eY3SXb1ciE4fCLk/5C/6bkxka/IsJHC9Nhe/uWQANbvzDNiJHJQP+ZIT1ufaebuofrTMtP
 HA/84korwVAS6eOR+1RcJQTrSZZ3m4yg4lGLBX50EocVUSjUOZOo2FO6/1tXKZZdiSj3R5
 +I1QyU0C5vRDKg+UAhtQALWPI+En2pMvxspJi4JzChxEkAQSWKZJ39msoxCsAgOIATgBo0
 DPX1RT7sbIf8i27yXN1lfwGJVEi+x0D3QnUZ4duSkWEWHT85ynyJjofxXruUct0mROpLt7
 Gdlc5PqszOpeRi8wW5yKn2KZb19Qule4KEWmONxVhTSWMRlUTfbypn3VdUt9+A==
In-Reply-To: <20250115160412.GQ5497@kernel.org>
Date: Thu, 16 Jan 2025 16:04:47 +0800
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
From: "tianx" <tianx@yunsilicon.com>
Subject: Re: [PATCH v3 01/14] net-next/yunsilicon: Add xsc driver basic framework
Message-Id: <a1951ab6-3ef1-441f-877f-ae2ca7c8f1c5@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: tianx <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>
References: <20250115102242.3541496-1-tianx@yunsilicon.com> <20250115102242.3541496-2-tianx@yunsilicon.com> <20250115160412.GQ5497@kernel.org>
X-Lms-Return-Path: <lba+26788bda2+df0a32+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.137.133]) by smtp.feishu.cn with ESMTPS; Thu, 16 Jan 2025 16:04:49 +0800
Content-Transfer-Encoding: 7bit
To: "Simon Horman" <horms@kernel.org>

On 2025/1/16 0:04, Simon Horman wrote:
> On Wed, Jan 15, 2025 at 06:22:44PM +0800, Xin Tian wrote:
>> Add yunsilicon xsc driver basic framework, including xsc_pci driver
>> and xsc_eth driver
>>
>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> new file mode 100644
>> index 000000000..709270df8
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +
>> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
>> +
>> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
>> +
>> +xsc_pci-y := main.o
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>> new file mode 100644
>> index 000000000..4859be58f
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>> @@ -0,0 +1,251 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#include "common/xsc_core.h"
> Hi Xin Tian, all,
>
> Sorry for not noticing this before sending my previous email.
>
> Please consider a relative include like the following,
> rather than the above combined with a -I directive in the Makefile.
>
> #include "../common/xsc_core.h"
>
> This is common practice in Networking code.
> And, for one thing, allows the following to work:
>
> make drivers/net/ethernet/yunsilicon/xsc/pci/main.o

Hi, Simon

I don't fully understand the benefit of using relative includes in this case,
as|"make drivers/net/ethernet/yunsilicon/xsc/pci/main.o|" already works with the current setup.

>
> ...

