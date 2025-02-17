Return-Path: <netdev+bounces-166862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB76A379A5
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 03:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D503AA3B1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 02:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646B76026;
	Mon, 17 Feb 2025 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="WXzE5PoC"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-45.ptr.blmpb.com (lf-2-45.ptr.blmpb.com [101.36.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0403145B27
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739758658; cv=none; b=Sl7tOFvGp1c8jUHdhsuDI39emDU6QTpbhTfza3mKbXeKCs6PGU5LhpFwXCDW1If3889iPdaJ4i9OnofxAK6SyExCLZFYe4nK//K7cckQXjBm+phItlIjC7Dcd7jRfi2HPaKAkv3l9haloaBV+QfVsDeIba1cexIoAbJW/uKypn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739758658; c=relaxed/simple;
	bh=8/5JKed0sNAcOnVbarcf7pIHGRajREI1ktIHnRRwZzw=;
	h=From:Message-Id:Content-Type:References:To:Cc:Mime-Version:
	 Subject:Date:In-Reply-To; b=Tie8blAlcL4pNynvG61Sli1/kGQJrTq2PBC2OtBgY/av0QTu33pb7dFb+9IRhU/PSTDFqJMTRrwQ7FITyJBN3Yxgv6xB5HjcMpcKyhplABmNd90Ahoyx8GtfYPsB2P+zDjPNWhOVwiYJQ0XdmHUg0dCTtnzT7cU/dxJtTkrZVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=WXzE5PoC; arc=none smtp.client-ip=101.36.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1739758574; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qoiYzsIrKCWzUoCsHd7X6IHzkK2ea8ZtGgmfTbVYr+o=;
 b=WXzE5PoCaQfkpbAmLCxqFafwZX3zfc+cr89gJavg4XG0heMQZ131hDveW1iYMyWr477Ihm
 3ATWAwWUKb6mk60zQE1q3wCU7rsGO5GM+SIDgfyzYyZEjsv2/gv1A0T6/X0TtdG/DoJ69C
 BbCtQe03tq6tBB3qkFovuN2MC7MUS39oBUWZu4ITnHMSGpTiD23MpPkJNxBKTl6HRpzW2L
 GKEgmLiTT/tOhmmBbk4YIlY2pvXPmlkflr57Ad/miVMhae+NJ9vT+Irj8b69fUtDTUxrA4
 yl3AgDpBvPAGc1bECJY2/L9VyTuK6W0u9ab748guflL5GMKMbILLbHxNOUvbEw==
From: "tianx" <tianx@yunsilicon.com>
Message-Id: <6e8f16e5-6425-47ae-97b1-f9dd1363937b@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
References: <20250213091402.2067626-1-tianx@yunsilicon.com> <20250213091418.2067626-8-tianx@yunsilicon.com> <20250213143702.GN17863@unreal> <0e83c125-b69e-46a0-a760-fe090b53bc70@yunsilicon.com> <20250216095915.GT17863@unreal>
X-Original-From: tianx <tianx@yunsilicon.com>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 07/14] net-next/yunsilicon: Init auxiliary device
Date: Mon, 17 Feb 2025 10:16:10 +0800
In-Reply-To: <20250216095915.GT17863@unreal>
X-Lms-Return-Path: <lba+267b29bec+e4e417+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Mon, 17 Feb 2025 10:16:11 +0800

On 2025/2/16 17:59, Leon Romanovsky wrote:
> On Fri, Feb 14, 2025 at 11:14:45AM +0800, tianx wrote:
>> On 2025/2/13 22:37, Leon Romanovsky wrote:
>>> On Thu, Feb 13, 2025 at 05:14:19PM +0800, Xin Tian wrote:
>>>> Initialize eth auxiliary device when pci probing
>>>>
>>>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>>>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>>>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>>>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>>>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>>>> ---
>>>>    .../ethernet/yunsilicon/xsc/common/xsc_core.h |  12 ++
>>>>    .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
>>>>    .../net/ethernet/yunsilicon/xsc/pci/adev.c    | 110 ++++++++++++++++++
>>>>    .../net/ethernet/yunsilicon/xsc/pci/adev.h    |  14 +++
>>>>    .../net/ethernet/yunsilicon/xsc/pci/main.c    |  10 ++
>>>>    5 files changed, 148 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>>>>    create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
>>> <...>
> <...>
>
>>>> +	[XSC_ADEV_IDX_ETH] = XSC_ETH_ADEV_NAME,
>>>> +};
>>>> +
>>>> +static void xsc_release_adev(struct device *dev)
>>>> +{
>>>> +	/* Doing nothing, but auxiliary bus requires a release function */
>>>> +}
>>> It is unlikely to be true in driver lifetime model. At least you should
>>> free xsc_adev here.
>>>
>>> Thanks
>> Hi Leon, xsc_adev has already been freed after calling
>> auxiliary_device_uninit. If I free it again in the release callback, it
>> will cause a double free.
> You should follow standard driver lifetime model. Your
> auxiliary_device_uninit() is wrong and shouldn't exist from the
> beginning.
>
> Thanks

OK, I'll change it.

Thanks for reviewing.

