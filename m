Return-Path: <netdev+bounces-153651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835779F9073
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 11:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF6F1888E8C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144E1C07DF;
	Fri, 20 Dec 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="kDvZh7AG"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F719C56D
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691421; cv=none; b=rvABUB2cmwvie6SixJNwccUJFS5evRHKFfSKFEftO+juPpBMC40dYOpgOiLY9mXsnos/oZtg2dpeqDAqx5quoIrYLJqF685Ecn1jNneB7PsBERy/70kpYc/2c/DygKkK5787DQQ3hp0Yri+IUZdhixh68Zm1zBt9F26tooNgIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691421; c=relaxed/simple;
	bh=xXWeLDGAumpUH2jxa7j63JztULL2647s/oX4hoMmHl4=;
	h=Cc:From:Date:Mime-Version:References:Subject:To:Message-Id:
	 In-Reply-To:Content-Type; b=hsAwa9U13giKbCRcr8cpHD2X9kb/8v6cKUQT5GMZegTUn0F295qtbblkOkYNciPOQAD8+M5nMct/87oPbrYeMwKKa656eJCgos4tQJiQ58W1opLsb+536ySY0+/FUlMndA5ecUT3uttKPYi6yqB3Ke878dgTazwoZr4FxM1b7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=kDvZh7AG; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734691401; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YqKnZ1e7eWkgWhS3+nSBpZ5hk2XWH/ugUrG5iO3Efj0=;
 b=kDvZh7AGU7eh50ix/WF9gMZXSKNVLLb/i6l4rUcipgSNTX+0bdlrN/EWIIikus2j2vGCma
 CIUNd8Aa5jtylVfedolcgfr8Q87GYf4/liZj2jS2kIfRY/4eDOJCs+KXq2fNBqc8+Z6uy+
 cBluRML8mXIpY1dIsUOklUvnF0cPjTCCbUS3Nu2vcsaPKVdN/ZENXLhwxh6OiV1d2l1yoy
 RHfQodjvdUE6fbM7CMuBKChtPtTE/6cyIqD8IqIOY/uJFpWxbXJyPpRAI+ESpicXwt0c+f
 K1RL9qAN4VO6RgMXv7OnreeoyD1nAUlaLL8rInBU5RikGtLk1ZokezkFH9Dfmg==
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
From: "tianx" <tianx@yunsilicon.com>
Date: Fri, 20 Dec 2024 18:43:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+267654a48+b05423+vger.kernel.org+tianx@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com> <20241218105041.2237645-10-tianx@yunsilicon.com> <51fa5341-4e7b-4c76-8fd5-9ca1f4b57de7@lunn.ch>
Subject: Re: [PATCH v1 09/16] net-next/yunsilicon: Init net device
To: "Andrew Lunn" <andrew@lunn.ch>
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Fri, 20 Dec 2024 18:43:19 +0800
Content-Transfer-Encoding: 7bit
Message-Id: <d4ae26f7-e7c8-4332-ae2f-0e51ecdbf05f@yunsilicon.com>
In-Reply-To: <51fa5341-4e7b-4c76-8fd5-9ca1f4b57de7@lunn.ch>
X-Original-From: tianx <tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8

On 2024/12/19 2:28, Andrew Lunn wrote:
>> +static int xsc_attach_netdev(struct xsc_adapter *adapter)
>> +{
>> +	int err = -1;
>> +
>> +	err = xsc_eth_nic_enable(adapter);
>> +	if (err)
>> +		return err;
>> +
>> +	xsc_core_info(adapter->xdev, "%s ok\n", __func__);
> ...
>
>> +static int xsc_eth_attach(struct xsc_core_device *xdev, struct xsc_adapter *adapter)
>> +{
>> +	int err = -1;
>> +
>> +	if (netif_device_present(adapter->netdev))
>> +		return 0;
>> +
>> +	err = xsc_attach_netdev(adapter);
>> +	if (err)
>> +		return err;
>> +
>> +	xsc_core_info(adapter->xdev, "%s ok\n", __func__);
> Don't spam the log like this. _dbg() or nothing.
OK, will fix in v2.
>> +	err = xsc_eth_nic_init(adapter, rep_priv, num_chl, num_tc);
>> +	if (err) {
>> +		xsc_core_warn(xdev, "xsc_nic_init failed, num_ch=%d, num_tc=%d, err=%d\n",
>> +			      num_chl, num_tc, err);
>> +		goto err_free_netdev;
>> +	}
>> +
>> +	err = xsc_eth_attach(xdev, adapter);
>> +	if (err) {
>> +		xsc_core_warn(xdev, "xsc_eth_attach failed, err=%d\n", err);
>> +		goto err_cleanup_netdev;
>> +	}
>> +
>>   	err = register_netdev(netdev);
>>   	if (err) {
>>   		xsc_core_warn(xdev, "register_netdev failed, err=%d\n", err);
>> -		goto err_free_netdev;
>> +		goto err_detach;
>>   	}
>>   
>>   	xdev->netdev = (void *)netdev;
> Before register_netdev() returns, the device is live and sending
> packets, especially if you are using NFS root. What will happen if
> xdev->netdev is NULL with those first few packets?

It's OK because xdev->netdev is never used before register_netdev() returns.

>
> And why the void * cast?

unnecessary cast, will fix that

>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>> +/*
>> + * Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
>> + *
>> + * This software is available to you under a choice of one of two
>> + * licenses.  You may choose to be licensed under the terms of the GNU
>> + * General Public License (GPL) Version 2, available from the file
>> + * COPYING in the main directory of this source tree, or the
>> + * OpenIB.org BSD license below:
>> + *
>> + *     Redistribution and use in source and binary forms, with or
>> + *     without modification, are permitted provided that the following
>> + *     conditions are met:
>> + *
>> + *      - Redistributions of source code must retain the above
>> + *        copyright notice, this list of conditions and the following
>> + *        disclaimer.
>> + *
>> + *      - Redistributions in binary form must reproduce the above
>> + *        copyright notice, this list of conditions and the following
>> + *        disclaimer in the documentation and/or other materials
>> + *        provided with the distribution.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> + * SOFTWARE.
>> + */
> The /* SPDX-License-Identifier: line replaces all such license
> boilerplate. Please delete this.
>
> 	Andrew
will delete that in v2

