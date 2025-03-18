Return-Path: <netdev+bounces-175632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC28A66F80
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549CB7AB1CD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444C1DE4CA;
	Tue, 18 Mar 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="Rs4Y0zOn"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-18.ptr.blmpb.com (va-1-18.ptr.blmpb.com [209.127.230.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B176206F12
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289340; cv=none; b=Cu8Z00M6SkOgPPOWz/VvmT8jOJPjts1Pks0/L6evG6hUKTdVjHNM+z3rc4SUdlhCwrADD6SiHx4OIH9yKTsyQIPq7g94WVyszqd7K4vyKYiwKK6L2HVYenXV8bVmvdIWvGd6QaIvUyTFiJFZLPrPLVB/T/FBdG7P6OxcVba/5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289340; c=relaxed/simple;
	bh=0mBoijR5Pu+hwhvFHtkD3FtNSBRDQ4s6JgDCmbVsxV8=;
	h=To:Message-Id:Mime-Version:In-Reply-To:Content-Type:Cc:From:
	 Subject:Date:References; b=abrjKNNe0bHzjFu7ejFi8pnzG1eRyH2QbS/57CidVbIZQ+BX5JM2pOvu5fz+jPSEhF4lJsaZFtA9xFp4Oh6DWbCyprs4dhEzZZjX/JCcE2UfN4VcuS7uLog0tY4sZfuM2QOHyuh4EjQ7RmCf4ZRS9y+UBWzwBkXvgjEWTx6uq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=Rs4Y0zOn; arc=none smtp.client-ip=209.127.230.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1742288425; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=X9gRHxUxC8Naom7b7ca+0s6MwlgkXHSzwOTJsQ7+FNE=;
 b=Rs4Y0zOnDxzMspdKL+sH7jYlVKwg84gXdgGr3gdKHlIMOLOsHovhbC3W4GMBVv+2jK6fPk
 Do0XRULDznc37Pn8GyjJta4a5z4PMlVkYLaKl0GL38mdDO2f1jIaTmrlZ5QviOrfUPXOQR
 4G+M9JFNMLRI8fBzCxlvp+wMoMbL9vNUAJ2OHLbjdOfPapRewX3cdg16T+PnnoGGOQv6ry
 XfsuyaPAjpzC2Yn7ktG0RjADaolzkOSN+yZV3obgAe0uYrXD2n760jUHFdhOiGwLRR7opk
 J06q58AeCywlfFqlr/mxN0xqAXw+Yfllhn5ORjlQjjf5s1hQwZdJcNHvpq+28g==
To: "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
Message-Id: <2fe60393-494a-4708-b1a3-559b647c6ce7@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <45010804-3eec-4517-98de-a7c87fa5b07c@yunsilicon.com>
X-Lms-Return-Path: <lba+267d93627+f1969a+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: Re: [PATCH net-next v8 14/14] xsc: add ndo_get_stats64
Date: Tue, 18 Mar 2025 17:00:19 +0800
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Tue, 18 Mar 2025 17:00:22 +0800
X-Original-From: Xin Tian <tianx@yunsilicon.com>
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100858.555320-15-tianx@yunsilicon.com> <c6d1c981-7a5a-4d63-baeb-1d81c388f526@redhat.com> <45010804-3eec-4517-98de-a7c87fa5b07c@yunsilicon.com>

On 2025/3/12 17:37, Xin Tian wrote:
> On 2025/3/11 23:28, Paolo Abeni wrote:
>> On 3/7/25 11:08 AM, Xin Tian wrote:
>>> +void xsc_eth_fold_sw_stats64(struct xsc_adapter *adapter,
>>> +			     struct rtnl_link_stats64 *s)
>>> +{
>>> +	int i, j;
>>> +
>>> +	for (i = 0; i < xsc_get_netdev_max_channels(adapter); i++) {
>>> +		struct xsc_channel_stats *channel_stats;
>>> +		struct xsc_rq_stats *rq_stats;
>>> +
>>> +		channel_stats = &adapter->stats->channel_stats[i];
>>> +		rq_stats = &channel_stats->rq;
>>> +
>>> +		s->rx_packets   += rq_stats->packets;
>>> +		s->rx_bytes     += rq_stats->bytes;
>> This likely needs a u64_stats_fetch_begin/u64_stats_fetch_retry() pair,
>> and u64_stats_update_begin()/end() on the write side.
>>
>> /P
> Good suggestion, I will change it.

Sorry Paolo, I was mistaken earlier.

I confirmed that our device only supports 64-bit architectures, x86_64 
and ARM64, so this is not needed.

Thanks,

Xin

