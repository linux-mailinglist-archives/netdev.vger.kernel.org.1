Return-Path: <netdev+bounces-169776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66FBA45A94
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A433AC890
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E9226D00;
	Wed, 26 Feb 2025 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="UA5QNp/8"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77967224259
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563421; cv=none; b=lcGwYdZ5JLzw/4co9kPyVdQuWMODiSedS9aL1iyRdJKvZrQa7eIIBaw2tMRAieVe+7qA3dxHeye7sUSbMIVdBAACnqFMW7OUKVnXY8NsDpL4T2Kg1U2x9RtTlCU5AYdiQJg5q1n3NJdJq0z663h9hCCiei/PTvZbllVrX7GGlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563421; c=relaxed/simple;
	bh=IfWmL5CTxazmcbqkMgTjBpL6xlFFgi9Yi0pPCf85Hx0=;
	h=In-Reply-To:From:Message-Id:References:To:Cc:Subject:Date:
	 Mime-Version:Content-Type; b=LPVZMe9Qd2tIljPtuegCqr5uezX3hDejdbsasnsx/rLo4sELFe+PjZNQngq0D+uY6eBe2TurYYyWdwzvG3Bbi8gDnb7fHrHnxe94/bvxsRikYhVp10LXtS5xI5apXINhYY64mZ2qPulfOhYYtZpe3v2VWWa50NcZFRTNBcv6QO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=UA5QNp/8; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740563406; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4IUHJdCVuvt+Vk5Y+XPn7UZLKLTk6h/w2hnUQtqAvyM=;
 b=UA5QNp/8nqwydW3g1842hIXLKZrD4L/IHTf9PECPrY1cxtjEnvSfAZKlNplNlrL0oGt/cX
 wEs34YF97xxGXLxmY1zsNzJ/yTjbLEuVvxXiEmGnZqlCJ4qjkfePhQldpPqE5qbT29iZh7
 swXDUpLTcyRe92FOjRp2bIZhpvOqJqR7RDXkXtg0iB65VXJbh5MVUk0LS0SMfhmLHema3M
 TSJ4iloAry0bAKhXuwvIoHKBVIb68JCHA6fRPVwdZGe/hU8/+852a3Li+Aqc/1jv9vWK56
 FEIeZsZg7d81XoPVGkTKcQOdLsArEzNdUBOYyvF/irSJ62bnNUHLQR2wA0K5kQ==
In-Reply-To: <20250226072215.GI53094@unreal>
X-Lms-Return-Path: <lba+267bee3cc+d0efcb+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <ca44497f-84ef-4f16-81ff-ca39a2b7a936@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Wed, 26 Feb 2025 17:50:03 +0800
References: <20250224172416.2455751-1-tianx@yunsilicon.com> <20250224172429.2455751-8-tianx@yunsilicon.com> <20250226072215.GI53094@unreal>
To: "Leon Romanovsky" <leon@kernel.org>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Subject: Re: [PATCH net-next v5 07/14] xsc: Init auxiliary device
Date: Wed, 26 Feb 2025 17:50:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8

On 2025/2/26 15:22, Leon Romanovsky wrote:
> On Tue, Feb 25, 2025 at 01:24:31AM +0800, Xin Tian wrote:
>> Our device supports both Ethernet and RDMA functionalities, and
>> leveraging the auxiliary bus perfectly addresses our needs for
>> managing these distinct features. This patch utilizes auxiliary
>> device to handle the Ethernet functionality, while defining
>> xsc_adev_list to reserve expansion space for future RDMA
>> capabilities.
>>
>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>> ---
>>   .../ethernet/yunsilicon/xsc/common/xsc_core.h |  14 +++
>>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
>>   .../net/ethernet/yunsilicon/xsc/pci/adev.c    | 112 ++++++++++++++++++
>>   .../net/ethernet/yunsilicon/xsc/pci/adev.h    |  14 +++
>>   .../net/ethernet/yunsilicon/xsc/pci/main.c    |  10 ++
>>   5 files changed, 152 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
> <...>
>
>> +// adev
> Please follow standard C comment style // -> /* ... */ for one line
> comments. Also this "adev" comment doesn't add any information.

The |xsc_core.h| file is quite large and includes definitions from 
various modules,

so I added markers to separate them. I'll modify the commenting style.

>> +#define XSC_PCI_DRV_NAME "xsc_pci"
>> +#define XSC_ETH_ADEV_NAME "eth"
>> +
>> +struct xsc_adev {
>> +	struct auxiliary_device	adev;
>> +	struct xsc_core_device	*xdev;
>> +
>> +	int			idx;
>> +};
>> +
>>   // hw
>>   struct xsc_reg_addr {
>>   	u64	tx_db;
>> @@ -354,6 +366,8 @@ enum xsc_interface_state {
>>   struct xsc_core_device {
>>   	struct pci_dev		*pdev;
>>   	struct device		*device;
>> +	int			adev_id;
>> +	struct xsc_adev		**xsc_adev_list;
>>   	void			*eth_priv;
>>   	struct xsc_dev_resource	*dev_res;
>>   	int			numa_node;
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> index 3525d1c74..ad0ecc122 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> @@ -6,4 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
>>   
>>   obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
>>   
>> -xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o
>> +xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o adev.o
>> +
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>> new file mode 100644
>> index 000000000..94db3893a
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/*
>> + * Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/idr.h>
>> +
>> +#include "adev.h"
>> +
>> +static DEFINE_IDA(xsc_adev_ida);
>> +
>> +enum xsc_adev_idx {
>> +	XSC_ADEV_IDX_ETH,
>> +	XSC_ADEV_IDX_MAX
> There is no need in XSC_ADEV_IDX_MAX, please rely on ARRAY_SIZE(xsc_adev_name).
OK, I'll change, thanks.
>> +};
>> +
>> +static const char * const xsc_adev_name[] = {
>> +	[XSC_ADEV_IDX_ETH] = XSC_ETH_ADEV_NAME,
>> +};
> <...>
>
>> +int xsc_adev_init(struct xsc_core_device *xdev)
>> +{
>> +	struct xsc_adev **xsc_adev_list;
>> +	int adev_id;
>> +	int ret;
>> +
>> +	xsc_adev_list = kzalloc(sizeof(void *) * XSC_ADEV_IDX_MAX, GFP_KERNEL);
> kcalloc(ARRAY_SIZE(xsc_adev_name), sizeof(struct xsc_adev *), GFP_KERNEL);
>
> Thanks

Ack.

Thanks


