Return-Path: <netdev+bounces-249767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD1D1D737
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E273430D977F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9328738736E;
	Wed, 14 Jan 2026 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c0YTSUSH"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25337BE98;
	Wed, 14 Jan 2026 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381609; cv=none; b=Xn1gDDG1MReCzTf09C7Ncab5XljPzQ6mzGBFozNvAncGEurKHxzYSzs3JdCKOrW80JVjMlXxUGU0HOQ6dvVpUVEwTlm0KeVezZJ9hHh1KCzvg2kiaLJw0qfB5hulSnb9dKNpp1IPTh1w0C9I0KiFyy9Ot7UnOUwV9r1oAz14xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381609; c=relaxed/simple;
	bh=DD4FRe13qzGcMMeQdQAaMdobRTMboKZxpDRC40oYCTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQUoVUgCcSjufovN3XamnFK5yYMzrZakf98e1isvkwGBxs/ERIWmLWR1t0sxVWjGYj0gHosdPjanGUSoS1kDzd1J3kyQfeweGTmMyA6N0fzHGy9urrpbhP5Cq6EA9eU1V89WY9hoUW1fdG1sQDyMuHzOVnLMkCvHH3vxP3eAzIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c0YTSUSH; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768381599; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lpPs8J4lvw2Ek7cSAVnZxJCxYhLlmUj/WA28+x+Vssk=;
	b=c0YTSUSHF+BdnxkAh3wkZd0PD/rL2qIKrJ6itLO4oSwim6u32vmPlZMnbEBLe1oKGysYna4uc5ubu4ar7xykT9/c7npp3IMw6BN3ut1iBiOyX+DyS/CLgoY3H4YQpTPOux/3TTmpXbUECEsT1VBmHazLC+btLQB6SDCTfUiWPiU=
Received: from 30.221.145.108(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wx1sMOj_1768381596 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 17:06:37 +0800
Message-ID: <5f3bed2e-b174-4a89-9cde-5c43f9b93702@linux.alibaba.com>
Date: Wed, 14 Jan 2026 17:06:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Dust Li <dust.li@linux.alibaba.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
 Sven Schnelle <svens@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <c4090523151f1994438726686c3bc9e12c977670.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <c4090523151f1994438726686c3bc9e12c977670.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/12 16:04, David Woodhouse wrote:
> 
> Thanks for starting this discussion.
> 
> I agree that the existing 'pure' PHC drivers should keep the option of
> presenting themselves as PTP devices to userspace. I would probably
> have suggested moving them out of drivers/ptp/… to somewhere else under
> drivers/ entirely, but that's bikeshedding.
> 

Thanks for the feedback. The directory and naming will be improved.

> I do think we have slightly different requirements for the pure PHCs
> too though, particularly the virt-focused ones. It would be good if we
> could set a guest's clock from them at startup, and the primary focus
> of them is for calibrating the guest's CLOCK_REALTIME. Which means we
> do actually care about consuming UTC offset and leap second information
> from them, not just TAI.
> 

Yes, we have slightly different requirements. The original motivation
for Alibaba CIPU PTP clock was to provide usable PTP clocks for cloud
services that require precise timing. Guest/VM time synchronization
was not the primary target.

However, I think the idea you mentioned is valuable for virtualization
scenario, eliminating the need for a userspace daemon and directly
calibrating the guest's CLOCK_REALTIME.

> I'd also like microvms to be able to consume time directly, especially
> from vmclock, without needing a full-blown NTP-capable userspace. I've
> experimented with simulating 1PPS support to feed into the kernel's
> timekeeping, although I don't think that's the best answer:
> https://lore.kernel.org/all/87cb97d5a26d0f4909d2ba2545c4b43281109470.camel@infradead.org/
> 
> We could do with harmonising the workarounds for kvmclock too. I made
> sure the vmclock driver reports its timestamp pairs in terms of either
> CSID_X86_TSC or CSID_X86_KVM_CLK as appropriate, but ptp_kvm *only*
> uses kvmclock (which is daft, since anyone who cares about accurate
> time will be using tsc). I was thinking that interface of the pure PHC
> drivers could be really simple, and our new infrastructure could
> provide the ptp_clock_info glue, including the kvmclock conversion if
> needed. And *also* hook them in for setting the clock at startup, and
> even calibrating CLOCK_REALTIME.

I expect the drivers covered by "pure PHC" will be diverse, covering
a range of non-network/IEEE 1588-oriented implementations.
PHC drivers for virtualization scenarios could be one subset. Further
virtualization-specific optimizations can be considered as follow-up
work with the virtualization and timekeeping experts.

Regards.

