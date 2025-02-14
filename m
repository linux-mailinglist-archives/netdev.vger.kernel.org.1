Return-Path: <netdev+bounces-166280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D577A35540
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 04:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6C118918DF
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861562CCC5;
	Fri, 14 Feb 2025 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="io0RN+xs"
X-Original-To: netdev@vger.kernel.org
Received: from lf-1-19.ptr.blmpb.com (lf-1-19.ptr.blmpb.com [103.149.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF92F24
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503110; cv=none; b=jaEpRUv9hxGp0raCdQWbydkk39+zdAMj2nME5S1s7ypxWMTwtuP/O0W4SpElH+uF8kbYqzcmfluae8Na/KiITdWX+guwK2YAG4krvOr1KyeqXdltuPhnlZojU0AZ6ZYLH5rZMYrQWQ9CDyKftYVk2MsASXowpeuOeDP/yku8ihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503110; c=relaxed/simple;
	bh=qGODg8jGyA23k+4nMcy9P9ClWkhf9vxdjPv8R0mieuE=;
	h=Cc:Message-Id:Mime-Version:References:To:From:Date:Content-Type:
	 Subject:In-Reply-To; b=uqwu9GVnJrc256NAHyoeR+lsBo7+2KvHs4WYS2Y8NSg1JhPdWBp9bMWXThBN1Huds0CRM1MGRyq3VLr/6z/tkJe1DIrn0+2UbVvx3N0Bu3SsQZnAII1jUhpW2n6tDY/RMqKXbLm97A27Zz496DmB4CvSoUFIGpr4XGxy075bb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=io0RN+xs; arc=none smtp.client-ip=103.149.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1739502890; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=M72yQnSpGEJg1NFY+l1/WlfXPlkL683KCsCQh285I70=;
 b=io0RN+xs9OkrMvmMcr3XVFC4hXyH7OUeyesXJ94YMGi+/HLQq+j6uf5La1NRX/WdrVhod2
 R3BU5M86Q0HpSfKbupXe+cXd+hxXxslzkkrxNW0p/pOB8MZbyWiF2+WTfwG+ITNNy+CGEV
 rxcKlS3IcbliIA6e3UMQofNTl7Cy3u+ksHR3+N1h11ZDuf2wnB/cTlX92CyXBWXGsdE6ru
 fQQKfTLa/A3M2oJKHu5NyBpt9NX5rpPMwk/Pd1xKEkFEpKdu+N34P0jrw7aCXukIHdXqef
 PH9clPtlkb1mbz1LIeFkMej0L27tnFHTQ7Uk5rdVZq+ClLvY/7mf1BglWxV4dw==
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
X-Original-From: tianx <tianx@yunsilicon.com>
Message-Id: <0e83c125-b69e-46a0-a760-fe090b53bc70@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213091402.2067626-1-tianx@yunsilicon.com> <20250213091418.2067626-8-tianx@yunsilicon.com> <20250213143702.GN17863@unreal>
To: "Leon Romanovsky" <leon@kernel.org>
From: "tianx" <tianx@yunsilicon.com>
Date: Fri, 14 Feb 2025 11:14:45 +0800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Fri, 14 Feb 2025 11:14:47 +0800
Subject: Re: [PATCH v4 07/14] net-next/yunsilicon: Init auxiliary device
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+267aeb528+5039d0+vger.kernel.org+tianx@yunsilicon.com>
In-Reply-To: <20250213143702.GN17863@unreal>

On 2025/2/13 22:37, Leon Romanovsky wrote:
> On Thu, Feb 13, 2025 at 05:14:19PM +0800, Xin Tian wrote:
>> Initialize eth auxiliary device when pci probing
>>
>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>> ---
>>   .../ethernet/yunsilicon/xsc/common/xsc_core.h |  12 ++
>>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
>>   .../net/ethernet/yunsilicon/xsc/pci/adev.c    | 110 ++++++++++++++++++
>>   .../net/ethernet/yunsilicon/xsc/pci/adev.h    |  14 +++
>>   .../net/ethernet/yunsilicon/xsc/pci/main.c    |  10 ++
>>   5 files changed, 148 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
> <...>
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>> new file mode 100644
>> index 000000000..1f8f27d72
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>> @@ -0,0 +1,110 @@
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
>> +};
>> +
>> +static const char * const xsc_adev_name[] = {
>> +	[XSC_ADEV_IDX_ETH] = XSC_ETH_ADEV_NAME,
>> +};
>> +
>> +static void xsc_release_adev(struct device *dev)
>> +{
>> +	/* Doing nothing, but auxiliary bus requires a release function */
>> +}
> It is unlikely to be true in driver lifetime model. At least you should
> free xsc_adev here.
>
> Thanks

Hi Leon, xsc_adev has already been freed after calling 
auxiliary_device_uninit. If I free it again in the release callback, it 
will cause a double free.

>> +
>> +static int xsc_reg_adev(struct xsc_core_device *xdev, int idx)
>> +{
>> +	struct auxiliary_device	*adev;
>> +	struct xsc_adev *xsc_adev;
>> +	int ret;
>> +
>> +	xsc_adev = kzalloc(sizeof(*xsc_adev), GFP_KERNEL);
>> +	if (!xsc_adev)
>> +		return -ENOMEM;
>> +
>> +	adev = &xsc_adev->adev;
>> +	adev->name = xsc_adev_name[idx];
>> +	adev->id = xdev->adev_id;
>> +	adev->dev.parent = &xdev->pdev->dev;
>> +	adev->dev.release = xsc_release_adev;
>> +	xsc_adev->xdev = xdev;
>> +
>> +	ret = auxiliary_device_init(adev);
>> +	if (ret)
>> +		goto err_free_adev;
>> +
>> +	ret = auxiliary_device_add(adev);
>> +	if (ret)
>> +		goto err_uninit_adev;
>> +
>> +	xdev->xsc_adev_list[idx] = xsc_adev;
>> +
>> +	return 0;
>> +err_uninit_adev:
>> +	auxiliary_device_uninit(adev);
>> +err_free_adev:
>> +	kfree(xsc_adev);
>> +

>> +	return ret;
>> +}

