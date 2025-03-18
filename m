Return-Path: <netdev+bounces-175589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BC5A6688A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F97C3BC43A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D9B1B85D1;
	Tue, 18 Mar 2025 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="hSoGjL2u"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-17.ptr.blmpb.com (va-1-17.ptr.blmpb.com [209.127.230.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803781B81C1
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742273020; cv=none; b=fBqQJmjyQdMy/LuyiVpR+lG8rJ4SvSNmUHboPAe850VpbPvZ7jEanQTyxo6NlbJpw24d794Fl/DKl8cq8bVuOANdEgFQ8sk8dRrwjsDNyh0/jSz+DQ112xpAciBP/9cQAylFbLLLowHRVaGnPQP63CEubH8lld/8hB41maqqEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742273020; c=relaxed/simple;
	bh=WfxANpSo7bohwONXxKAmQBxDZ6eFAbH++CcdNJ/l7Is=;
	h=To:Cc:Message-Id:Content-Type:References:From:Subject:Date:
	 Mime-Version:In-Reply-To; b=DyonQQ60CzHvr6bdp20KRivx+VcJcENbJn9174j05eNwitQ9OlakGFBAoZS+Eid701kUduZrRSIC5huwn4MdRENVQ1MZ7oSYTve5OLKSQdzTxs3bMXH0cqqnEM9Q23J/rPOFLyqQiX/lkZC89NZEBeLaa0iS3cHsLmhuL2VtFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=hSoGjL2u; arc=none smtp.client-ip=209.127.230.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1742272198; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=keeBqylyV2NERaUTW9cleHyajGwjOLtukJvapzjtTQU=;
 b=hSoGjL2u/rKVYl80J7EXqfd20x6UqWV7sadPkKGquWk7YAP8UqTQTlQ3vM6L/GLy+gOh3c
 EodWUg5Oo5Y3N70goO7/GpzTv7dPgnzw57Ym5W6VHjT1fcIGjedJeLJ9PFtWSp2bGO7Y4U
 lxBV7dL8d5jigsjbGHtw484JTqPpYwowMEpX67X0zyBnZu2JvKKNna3bGS5IbT0PUM6QTQ
 zYY5kwSzxBR+X/jTU290cH9wkvV9GKG7/B6ixGzMK85g08Bu2Y/2P0j1ABPvU5Nx/pMJ6A
 3B5iX5HJrNirNGwc1wezIxvTRwiy5rhoLmufbDIq9sOqOn+m/Sos/QyRtz1xAg==
To: "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
X-Lms-Return-Path: <lba+267d8f6c4+48668e+vger.kernel.org+tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
Message-Id: <c78dc4e0-a5c6-44ca-b84e-6b23956b71f4@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Tue, 18 Mar 2025 12:29:55 +0800
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100845.555320-10-tianx@yunsilicon.com> <15066f7b-217f-4457-8bff-a4aef614cdf3@redhat.com>
Content-Transfer-Encoding: 7bit
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: Re: [PATCH net-next v8 09/14] xsc: Init net device
Date: Tue, 18 Mar 2025 12:29:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <15066f7b-217f-4457-8bff-a4aef614cdf3@redhat.com>

On 2025/3/11 23:12, Paolo Abeni wrote:
> On 3/7/25 11:08 AM, Xin Tian wrote:
>>   struct xsc_adapter {
>>   	struct net_device	*netdev;
>>   	struct pci_dev		*pdev;
>>   	struct device		*dev;
>>   	struct xsc_core_device	*xdev;
>> +
>> +	struct xsc_eth_params	nic_param;
>> +	struct xsc_rss_params	rss_param;
>> +
>> +	struct workqueue_struct		*workq;
>> +
>> +	struct xsc_sq		**txq2sq;
>> +
>> +	u32	status;
>> +	struct mutex	status_lock; /*protect status */
> You should consider using dev->lock instead.
>
> /P

This |dev| refers to the PCI device and will be used by several drivers. 
So using |dev->lock| may not be a better choice.


Thanks,

Xin

