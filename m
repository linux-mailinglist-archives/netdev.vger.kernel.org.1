Return-Path: <netdev+bounces-248880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D54D10812
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B3C7304929C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB712F530A;
	Mon, 12 Jan 2026 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ANXzm80j"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32911BC2A;
	Mon, 12 Jan 2026 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768189544; cv=none; b=IfaxWu5IebTAKFzmy/HjAGTrXMSkF8ZxCTVMO3Ql3zdxYZTI1QMSJjwWOBPkxrsoYazQfHunST8PuoncYKv3rAnDSNUAi7Bi8gBaA2jP7OZLfB0ZBZkzotU+K2No7EkYvliqtoIpLlvl4eFH7clCJ6ODf94352rD26haggbwwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768189544; c=relaxed/simple;
	bh=7n8/fftzWtIqx9eTaMDMWRku5j7I4dfPysPoyGPcPfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryF4WtyWbeuyPnq9WRpJ5WY1sPtcG/jQt73PX2hP7LBMAtubU6CTRSzJSUAYNHpQ9zxBn/oIoPKK6q94qfiekhBUWFJ93DPE9WTTnbBMpLj9wbeq3D/cZiH3EJkJUhR65JUTtPOF/3rC77WhUusB3nzEWY8oQ0AgZiKejxDjcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ANXzm80j; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768189540; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eyODC/LsNFhBKntu0IXnbaZH9KhyszqMMJr2jesQQq8=;
	b=ANXzm80jbKv7k7vCty7a7cXX3a/jFcidR4i1qIRVLU6Qmu309xh3ytiQ211bc+yzZgoUHBW8UIOgzSYHPKjPUYJ10l2f2rWFiksS5RXf1TOvwqdyBedOuXlQg3BO7c1joSEdDnAUI1Gwq5mcxzFL+BjRNpPjzyTewhkIKFVmB2E=
Received: from 30.221.145.245(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WwntRfD_1768189539 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 11:45:39 +0800
Message-ID: <028dc6e9-c15a-4258-b72f-a4efe95503cc@linux.alibaba.com>
Date: Mon, 12 Jan 2026 11:45:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: David Woodhouse <dwmw2@infradead.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>, andrew+netdev@lunn.ch,
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
 <957500e7-5753-488d-872d-4dbbdcac0bb2@linux.alibaba.com>
 <20260102115136.239806fa@kernel.org>
 <3e137dbb-4299-4adf-9e19-b78ce6cfe4c8@linux.alibaba.com>
 <de8952121036deb58c07be294a044b5ff5bc00f4.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <de8952121036deb58c07be294a044b5ff5bc00f4.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/9 17:25, David Woodhouse wrote:
> On Sun, 2026-01-04 at 14:11 +0800, Wen Gu wrote:
>>
>> IIUC, the main block is that you don't want to maintain these pure
>> phc clocks, as you mentioned in [3]. I agree with this as well. So I
>> propose to group these pure phc drivers together (e.g. drivers/phc)
>> and move them from the network maintenance domain to the clock maintenance
>> domain.
> 
> I think that makes sense. These clocks can still be registered as PTP
> clocks because that's one of the most sensible interfaces to userspace,
> but the implementations can live elsewhere outside the networking
> maintenance domain.
> 

Yes. The PTP interface has become a common choice for exposing these
clocks to userspace, and it is not limited to NIC-based implementations.

I have posted an RFC to reach a consensus on organizing these clocks:

https://lore.kernel.org/netdev/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com/

> In a lot of cases we'd want to use them for RTC too, so that the
> kernel's CLOCK_REALTIME can be initialised from them. And especially
> for microvms I'd like to *synchronize* the kernel's clock from them
> automatically too.
> 

This is also a good use-case that supports having these clocks available.

Regards.

