Return-Path: <netdev+bounces-152910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8289F64C0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37481884BDA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D7819939D;
	Wed, 18 Dec 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="YoY282Co"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CC192B94
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520915; cv=none; b=bIRUi4pTavQoQEadeKpCQH4wiQOcwpIXSMAWJxzBLLEKA8Jsmdtm8c5gKm0APEfmhxBHnQ3Oj3+QSlyI/ZZ7mUQQt+eoSF280WPiIFXJWel71OWA2peSEQs3Wf+KlpAI4VYKc7BkkOMt2hKIiUVKTZKrD8btIKYtIA1Qqs/PEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520915; c=relaxed/simple;
	bh=UtkjgxRvzhxQnNueRzyoOWPB0rGCgtEcKLxtogvHW0A=;
	h=From:Subject:To:Cc:Message-Id:In-Reply-To:Content-Type:Date:
	 Mime-Version:References; b=gQ8tfNuxskg4CxLfOKb3C6ID+lLJpDUCNbjSfxfLpmz33C2mt2Zrrviz9stB337o8D6duHGBdnR4PhSDtGHDIuoVDD7R/Bx5G4wXWQIU8e4n+sY/LlxAsHXyg1MripcoPapWzf/6R6OfjZhpL9NLW3cp3QlBZmCguA13RFi+3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=YoY282Co; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734520907; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fph7ojaiCaOfgQOsvn1whl75kWY8t7S9C+hcIfXEj3E=;
 b=YoY282CoIbkS7+Mez5nooX/fFAVsrX/YmapSd2dy7EWAxjSF3zsuW5FczyyQn9mFQufHea
 SqebERdMkCni4fNgxye9xQ3H0DKfo6BjY5sHEIbx4as9N1rEMwojQiCwIGM4rpUst+PBz4
 sUVZa0964J37aouAPJCAdsXDsFkZPl9WbBtNvR4qOwy2xlIJ1bqut6KKP/80/pmvtz9OIK
 +pxdzWkqqTGufJxxMlfuhpfPTinqC4g+G0DFE4wE8DdF0JEbaEEt4tQfTLNJJJHrEqNTIh
 TBlyaXcI9920+ACjFOEVQT8xwcDODWe5pMqoDBD48G/FGz54O6KpcOW/dPmKTw==
From: "tianx" <tianx@yunsilicon.com>
Subject: Re: [PATCH 08/16] net-next/yunsilicon: Add ethernet interface
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 19:21:44 +0800
To: "Andrew Lunn" <andrew@lunn.ch>
X-Lms-Return-Path: <lba+26762b049+263cb5+vger.kernel.org+tianx@yunsilicon.com>
X-Original-From: tianx <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <weihg@yunsilicon.com>
Message-Id: <777765c7-c2b0-4347-9795-3b6f0c53dca6@yunsilicon.com>
In-Reply-To: <3b9ec0a5-35b3-4c23-bbf2-c9e509a54da2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Dec 2024 19:21:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209071101.3392590-9-tianx@yunsilicon.com> <3b9ec0a5-35b3-4c23-bbf2-c9e509a54da2@lunn.ch>

OK, the unecessary log have been removed in v1 patch.

On 2024/12/9 21:41, Andrew Lunn wrote:
>> +static void xsc_remove_eth_driver(void)
>> +{
>> +	pr_info("remove ethernet driver\n");
>> +	xsc_unregister_interface(&xsc_interface);
>> +}
>> +
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
>> +
>> +static __init int xsc_net_driver_init(void)
>> +{
>> +	int ret;
>> +
>> +	pr_info("add ethernet driver\n");
> Please don't spam the kernel log with all the pr_info() calls.
>
> 	Andrew

