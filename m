Return-Path: <netdev+bounces-214437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F3B29734
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 05:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4BF179FED
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583825C83A;
	Mon, 18 Aug 2025 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ugfqU9y4"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886338632B;
	Mon, 18 Aug 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486301; cv=none; b=JTJwSmNiU2BV5gg5I1aSQ9Il44rd0d3r7mIYVtYqDoaIMDCsjppIhEiWtlBJeXkqMdrwUR1Yg7GUIJ6yuvTupIGZxr3SU2YmXjRPrKwKG5+4C9wuFM9lglOYKdg0KGxDoT+t0Nxu1PlxjI2MoqCVuoyayHNxVYAGRzxQq6yLfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486301; c=relaxed/simple;
	bh=xdRMAMoq82aAoif+H8/uL/q+IfDYG2rUsVWlxkx6Nc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mqg609WEkuP0xhGguXxd08FKVUuSqbcLUN/dXBlHdSPnpL3XzfhRebXoWy/seWTBIcHfz3VtWJJVZopbkG2WJh1hZ9PMTTkMnM/+94el0nXrBjPBBvruDgG+NLv570q+2KfTrihf+v4yX6NdLl5Ynl7JbJS189fE/eTPo/wzOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ugfqU9y4; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755486288; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Mr+DysRN3u5GqzLBeBZ3tOHHcVWUSvBBgIRpmmSePag=;
	b=ugfqU9y4O4sp4ZGkR6du+XU+koRcdVXHkwZQOpSL7D+qQVRamE/QdV/L1kxSShy4z3GJofH00sbRp2uL4IfpyEEjGHbz2Lg0fHALIEp5awfPod1le5xXXGddJOIgwXZ3lM75oXwKOIvJV4DKk4dQFFk+8HZLWS64zzwfyKMhjaY=
Received: from 30.221.128.156(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wlv1kXR_1755486287 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 11:04:47 +0800
Message-ID: <c00a30af-89b2-400c-8026-8a987be3e3dd@linux.alibaba.com>
Date: Mon, 18 Aug 2025 11:04:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org>
 <2a98165b-a353-405d-83e0-ffbca1d41340@linux.alibaba.com>
 <729dee1e-3c8c-40c5-b705-01691e3d85d7@lunn.ch>
 <6a467d85-b524-4962-a3f4-bb2dab157ed7@linux.alibaba.com>
 <616e3d48-b449-401c-8c8b-501fce66c59d@lunn.ch>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <616e3d48-b449-401c-8c8b-501fce66c59d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/17 23:56, Andrew Lunn wrote:
> On Sun, Aug 17, 2025 at 11:01:23AM +0800, Wen Gu wrote:
>>
>>
>> On 2025/8/16 23:37, Andrew Lunn wrote:
>>>> These sysfs are intended to provide diagnostics and informations.
>>>
>>> Maybe they should be in debugfs if they are just diagnostics? You then
>>> don't need to document them, because they are not ABI.
>>>
>>> 	Andrew
>>
>> Hi Andrew,
>>
>> Thank you for the suggestion.
>>
>> But these sysfs aren't only for developer debugging, some cloud components
>> rely on the statistics to assess the health of PTP clocks or to perform
>> corresponding actions based on the reg values. So I prefer to use the stable
>> sysfs.
> 
> Doesn't this somewhat contradict what you said earlier:
> 
>     These sysfs are intended to provide diagnostics and informations.
>     For users, interacting with this PTP clock works the same way as with other
>     PTP clock, through the exposed chardev.
> 
> So users don't use just the standard chardev, they additionally need
> sysfs.

No, they are not contradictory.

For cloud users, they only need to use standard ptp chardev exposed to do time
operations. This is no different from using any other PTP clock.

The sysfs are used by Alibaba cloud's components that monitor the health and behavior
of the underlay device to ensure SLAs.

> 
> Maybe take a step back. Do what Jakub suggested:
> 
>     Maybe it's just me, but in general I really wish someone stepped up
>     and created a separate subsystem for all these cloud / vm clocks.
>     They have nothing to do with PTP. In my mind PTP clocks are simple
>     HW tickers on which we build all the time related stuff. While this
>     driver reports the base year for the epoch and leap second status
>     via sysfs.
> 
> Talk with the other cloud vendors and define a common set of
> properties, rather than each vendor having their own incompatible set.
> 
> OS 101: the OS is supposed to abstract over the hardware to make
> different hardware all look the same.

IMHO, the abstraction has been done by PTP layer, e.g. struct ptp_clock_info,
struct ptp_clock and ptp_clock_{un}register(). For users, the PTP clock provide by
any vendors should be same in terms of usage, Alibaba Cloud is no exception.

But the specific implementation of underlay varies from ventor to ventor. Some depends
on ptp4l and NIC with IEEE 1588, some offload 1588 work to underlay infra and get
timestamps directly. I think it is difficult to require all vendors to provide the same
underlying attributes. Besides, Even the underlying implementation and properties are
different, it does not affect the user's use of them and the abstraction as PTP clocks.

Thanks!

> 
> 	Andrew


