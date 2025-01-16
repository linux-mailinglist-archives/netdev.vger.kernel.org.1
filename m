Return-Path: <netdev+bounces-158780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A64A13388
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C033A3646
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F1339A1;
	Thu, 16 Jan 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="ImX7e7Ei"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7851C695
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737011008; cv=none; b=mxAoo5DgecxkVLOtstAKOXOezC2SsBZax9my3aQFJeus33r3HhKl318nxuswq/0ENN/0fSwRmUnOuYvxtpsj42eBUFRty3+8AVbCLOMa+2BIiEwrEgjCYo+FvjYBvAWdr9SAJQIYNMq4kKISkU7Mwar/knbtq2s4Dx3M0f1qBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737011008; c=relaxed/simple;
	bh=a9DCon87GuxdzCTo0uWi2JE7YsTD1M2qPWG0DBnbrmY=;
	h=From:Message-Id:Mime-Version:In-Reply-To:To:Cc:Subject:Date:
	 Content-Type:References; b=sGf7yXfJL2KAlJ638ThnTPZ/+V+4I6A4d5XiouWpe1nvn5OpBSVzGNf8hVCX9XixSUSJjf7w7q1eM/Vnd5vi4VqCW0Pa8YnfgzQv7Tv+I3gV+FC4Lj/8ExeEpdniD5bLBxpvb2gpf1roL5o4+a4hlZcxc4PflTXVbeCj0LgJJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=ImX7e7Ei; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1737010995; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=OThfLn33ywkOHGz2Q0/OH6rDyMjzLA4HJWBI7izUAUI=;
 b=ImX7e7EiSeKmiwUJ0VjLCpahZFArmV8XIu6rjf3NCpWJprPf9W2Ve7aTBhg/CbV/SRy4lp
 Tn8MsZC2kOvW3AaBaNVLlCKLTLoR3CIFqFzl5APABq3Vpef7GWxvBaUSbyGuF5XhVf2ulc
 LwHrfixMIpbDKpdrqX5SyYsxzmidUd1j9BsUfqDuyc/Cjw66OBRO3vjWNr5XBkiQShrjyY
 wve40oRz/W1rt2OTflpcgMCc2pqvcre/na9sAZB6S1LTyyqPUYKSjYUIBE52BB5tdGpmLh
 Pk6vB7MR28SD9814fLY8r++a2vIt+SiBADiWMQRTppQyrcrun/0LO17CsN1T8w==
From: "tianx" <tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
X-Original-From: tianx <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+26788af31+cc1f8f+vger.kernel.org+tianx@yunsilicon.com>
Message-Id: <9616014e-49ed-44c0-81f2-526cefac59ab@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250115155452.GP5497@kernel.org>
To: "Simon Horman" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>
Subject: Re: [PATCH v3 01/14] net-next/yunsilicon: Add xsc driver basic framework
Date: Thu, 16 Jan 2025 15:03:10 +0800
Content-Type: text/plain; charset=UTF-8
References: <20250115102242.3541496-1-tianx@yunsilicon.com> <20250115102242.3541496-2-tianx@yunsilicon.com> <20250115155452.GP5497@kernel.org>
Received: from [127.0.0.1] ([218.1.137.133]) by smtp.feishu.cn with ESMTPS; Thu, 16 Jan 2025 15:03:12 +0800

On 2025/1/15 23:54, Simon Horman wrote:
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
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> ...
>
>> +struct xsc_dev_resource {
>> +	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */
> nit: allocation
OK, will fix
>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> ...
>
>> +static int xsc_pci_init(struct xsc_core_device *xdev, const struct pci_device_id *id)
>> +{
>> +	struct pci_dev *pdev = xdev->pdev;
>> +	void __iomem *bar_base;
>> +	int bar_num = 0;
>> +	int err;
>> +
>> +	xdev->numa_node = dev_to_node(&pdev->dev);
>> +
>> +	err = xsc_pci_enable_device(xdev);
>> +	if (err) {
>> +		pci_err(pdev, "failed to enable PCI device: err=%d\n", err);
>> +		goto err_ret;
>> +	}
>> +
>> +	err = pci_request_region(pdev, bar_num, KBUILD_MODNAME);
>> +	if (err) {
>> +		pci_err(pdev, "failed to request %s pci_region=%d: err=%d\n",
>> +			KBUILD_MODNAME, bar_num, err);
>> +		goto err_disable;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +
>> +	err = set_dma_caps(pdev);
>> +	if (err) {
>> +		pci_err(pdev, "failed to set DMA capabilities mask: err=%d\n", err);
>> +		goto err_clr_master;
>> +	}
>> +
>> +	bar_base = pci_ioremap_bar(pdev, bar_num);
>> +	if (!bar_base) {
>> +		pci_err(pdev, "failed to ioremap %s bar%d\n", KBUILD_MODNAME, bar_num);
> Should err, which will be the return value of the function,
> be set to a negative error value here? As is, the function will
> return 0.
Thank you for pointing this out, Simon. I'll correct it in next version.
>> +		goto err_clr_master;
>> +	}
>> +
>> +	err = pci_save_state(pdev);
>> +	if (err) {
>> +		pci_err(pdev, "pci_save_state failed: err=%d\n", err);
>> +		goto err_io_unmap;
>> +	}
>> +
>> +	xdev->bar_num = bar_num;
>> +	xdev->bar = bar_base;
>> +
>> +	return 0;
>> +
>> +err_io_unmap:
>> +	pci_iounmap(pdev, bar_base);
>> +err_clr_master:
>> +	pci_clear_master(pdev);
>> +	pci_release_region(pdev, bar_num);
>> +err_disable:
>> +	xsc_pci_disable_device(xdev);
>> +err_ret:
>> +	return err;
>> +}
> ...

