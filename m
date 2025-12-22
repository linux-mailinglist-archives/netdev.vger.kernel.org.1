Return-Path: <netdev+bounces-245675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF48CD4DA8
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 08:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2D53008E99
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD1219303;
	Mon, 22 Dec 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BQKDIotx"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5C1DF963;
	Mon, 22 Dec 2025 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387954; cv=none; b=k+o4q20NOUFcdvcr8d2/dVe5vfaIUAsV6/gXqOLT4n0zzR0A7YNsPFHPxlWUfPgzmGX7tjwsUhQ1n6yzO/ICgKLAIe+QJy5FGy8yJOVgJBSwXwSfvX5f22n1La6hL1jLsq+VJ+ai/vVtqYOZ6E2gRNDAtjN+o8JeHOf1T4Zo0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387954; c=relaxed/simple;
	bh=gKrVj/b3vzYU0nS6L7oQCHNd5I4NDUKlkrmxZ4IBe/g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PaOVeN6SPXgptXmmVqy+sKFs3PyQaQ8evNa2RAaTgJAwZpPxPIOsXhjh8hkPR6H6NTuU/00BCsiql8TMWunna5DO2PFPjr7AOIrgtf+IYOUETxdcC7gUX3nyOKLqWaMdbNQLzbJXkCf5AHx5J+vaiWsTo9k956FgPBIa1DvgBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BQKDIotx; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766387940; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=oEB9Yb9iwUuBjbpOCOGlEyboO6qKpx5MuNSNNkj0O/Q=;
	b=BQKDIotxITS5pjxhR4N7KCmgCGfn+Uxn9wCuVpkwrYxZyxMQj2wsubHA/QeKZRPP9jt1SM/eivNAuWyQd/1Zq3vAuL6JIpZfJ8whBqO1/oHE6i1sy+vwIgPjBS+l0wFNJnqt08TRJnMjfBzc6PHZtybwKaEAFVIoKo0HD1pwz5c=
Received: from 30.221.129.67(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WvMt44U_1766387899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 15:18:59 +0800
Message-ID: <957500e7-5753-488d-872d-4dbbdcac0bb2@linux.alibaba.com>
Date: Mon, 22 Dec 2025 15:18:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Cochran <richardcochran@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
 <20251030121314.56729-2-guwen@linux.alibaba.com>
 <20251031165820.70353b68@kernel.org>
 <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
 <20251105162429.37127978@kernel.org>
 <34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
 <20251127083610.6b66a728@kernel.org>
 <f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
 <20251128102437.7657f88f@kernel.org>
 <9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
 <c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
 <20251213075028.2f570f23@kernel.org>
 <fb01b35d-55a8-4313-ad14-b529b63c9e04@linux.alibaba.com>
 <20251216135848.174e010f@kernel.org>
In-Reply-To: <20251216135848.174e010f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/17 05:58, Jakub Kicinski wrote:
> On Sun, 14 Dec 2025 22:03:57 +0800 Wen Gu wrote:
>> If you're suggesting creating a new subsystem, I think we should first
>> answer this question: why can't it be part of the current ptp subsystem,
>> and what are the differences between the drivers under `drivers/ptp`
>> and those in the new subsystem?
> 
> I can't explain it any better than I already did here:
> https://lore.kernel.org/all/20251127083610.6b66a728@kernel.org/
> 
> I talked to Thomas Gleixner (added to CC) during LPC and he seemed
> open to creating a PHC subsystem for pure time devices in virtualized
> environments. Please work with him and other vendors trying to
> upstream similar drivers.

Hi Jakub and Thomas,

I thought about it a bit more. If we create a new clock class
(say a "ptc"), its helpers and structure would likely end up being
almost identical to the current ptp ones, since the pure phc drivers
under drivers/ptp (e.g. ptp_kvm, ptp_vmw, ptp_s390, ptp_cipu) are
implemented on top of the existing ptp helpers. That would give us
two near-identical classes, which may be confusing.

Also, changing the userspace device node for existing pure phc drivers
from /dev/ptpX to something else (e.g. /dev/ptcX) seems impractical.
The same applies to ptp_cipu, since it is already used and relies on
exposing /dev/ptpX.

Given the historical baggage, it seems better to keep using the
existing ptp framework, but separate these pure phc drivers into a
new subsystem with a dedicated directory (e.g. drivers/phc/) and a
MAINTAINERS entry, moving them out of the netdev maintenance scope.
This should also address the concern that these pure phc drivers are
not a good fit to be maintained under the networking subsystem.

If this works for you, I'll send an RFC about this.

Regards.





