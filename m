Return-Path: <netdev+bounces-215877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747AAB30BAA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CAC9B66BDC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337AB1A316C;
	Fri, 22 Aug 2025 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Me+Zx6gk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875F1DFCB;
	Fri, 22 Aug 2025 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828466; cv=none; b=dT4vtDBqm8zi0PfgyaA4jIYnlkatYnHOT24k9wU3LsYjn/1JfSO4p5iK3DO/6Mm0E8y6BxdFmPoMKTMOz5b7/msa5TRZh0MWeksfuyiTw5zrO8Yj/qVswp+VL10MkEjdM62OYTgZuiCf8ZSwVdFSc3hZI1LuHvv029gwJHKPeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828466; c=relaxed/simple;
	bh=1pBUX+vDFl3U44u3TQQHSIPd3ezq6gaNCl2KWdzmA/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0uitN14FdjYKZZCbUEKP/VBl5oqhH+mCidWXc5enCP7yDH9fl/oGcBlPWmu6O8+dY3jxBSyXhDeKMLB819Q10JkqT9z07ESzlzWAW/0ZROdYpbAKnEzMxlEtoTuABM7+63UntaxZiTa0K7x2/mFs2YklWHc8CV292A75SkqCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Me+Zx6gk; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755828453; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BZG5wn6OOzkGvybk2tGzkZrM8NPuvCMbIDppxpIKqq0=;
	b=Me+Zx6gktf+tsRUnOXAwFDlwj306sK3eWfx6OoZTMqN0zJzRraUG0VKIrGumV8tat4vzV1th/qXbnOm3ZBKg8JITAD2y5m8qzHP6fkYy447VjupCVeJJJVz19yYTnB60Zt+VBmN7NSIvs+0GuHahk1NeyeacKEv3Qwb1OnLfGWw=
Received: from 30.221.128.112(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WmHvIJ3_1755828452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 10:07:33 +0800
Message-ID: <b4c54718-648b-44e6-baed-2a08f287c24a@linux.alibaba.com>
Date: Fri, 22 Aug 2025 10:07:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org> <aKd8AtiXq0o09pba@hoboy.vegasvil.org>
 <91008c3cd2502b3726992b0f490aac54a1efa186.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <91008c3cd2502b3726992b0f490aac54a1efa186.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/22 04:12, David Woodhouse wrote:
> On Thu, 2025-08-21 at 13:05 -0700, Richard Cochran wrote:
>> On Fri, Aug 15, 2025 at 11:38:14AM -0700, Jakub Kicinski wrote:
>>
>>> Maybe it's just me, but in general I really wish someone stepped up
>>> and created a separate subsystem for all these cloud / vm clocks.
>>> They have nothing to do with PTP. In my mind PTP clocks are simple HW
>>> tickers on which we build all the time related stuff. While this driver
>>> reports the base year for the epoch and leap second status via sysfs.
>>
>> Yeah, that is my feeling as well.
> 
> Agreed. While vmclock is presented as a PTP clock for compatibility,
> it's more than that because it can do better than simply giving a
> single precise point in time. It actually tells the guest the precise
> relationship between the hardware counter and real time, much like the
> private data structure exposed from the kernel to vDSO gettimeofday.
> 
> We should work on having the kernel consume that *directly* and feed
> its CLOCK_REALTIME with it. Having hundreds of guests on the same host
> all recalculate the same thing based on a set of points in time,
> obtained through /dev/ptpX or otherwise, is just daft.

Hi David,

How does vmclock work in a bare‑metal scenario, given that there is no
guest–hypervisor architecture?

You mentioned "vmclock over PCI", do you mean passing a PCI device to the
bare‑metal? What is this PCI device, and which driver does it use?

Thanks.

