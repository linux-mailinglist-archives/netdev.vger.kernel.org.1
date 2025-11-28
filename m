Return-Path: <netdev+bounces-242502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4969DC90EF9
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 07:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F51F4E03D3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 06:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4F2C0286;
	Fri, 28 Nov 2025 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YFkxfF6D"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF42C236B;
	Fri, 28 Nov 2025 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310956; cv=none; b=kLRE9JiOYQIBWjsZntrmqWkDSu7l6J9DXNVZ0bN2Xf87zeCSBhTraC0q8w/zkUH0VHIzMcbJw4GcWSyAuNfJ+vBYtlE+UoCCG9m6/d/sOzNTt+hDzML64Sn46ARyNXPMp54b3du7r7vU4DYq5gnWwWMsae0XgElv/umHh7t1C8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310956; c=relaxed/simple;
	bh=qDSeqNApy9ir1EfeEbeSpCtkUM31VehaIZaCF1wznEc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NhAzR5J/GfhWOqqEETAkaQGcgHZ8ZUirOLyzosGATEckY1c0ma2XI6XL1uGRZGGuq3hYGeM/Z++dLfRAfXK7TM1ThM7tK0L3jf9FDTSYxTu/sY7756Hgrl99EIQMmJBz3p6Qbv9Bf9l0Y7tc0Ju+52g8FB79qJKO+FBGbXuWaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YFkxfF6D; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764310943; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=xBWBkm38c4oJhgjAHuhW4noGWW2KiVQjgMllZnZtXNA=;
	b=YFkxfF6Dt2jICWm0wVjl8DqA7oVvsxFT0Sq8DyZmzvVtoW+lxrsp6EQZnOoPQi4B/x1KYKQpM1ARc1Q5HP/VL/8Ep0UBGOdREL9DitnRhgF0ZCA/N/o+KP4gV69F3aCighHesZHeqL8OVmhcDobP+I+q7Ry8GIxpCMnhJYgi0dc=
Received: from 30.221.145.15(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wtai1OV_1764310941 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Nov 2025 14:22:22 +0800
Message-ID: <f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
Date: Fri, 28 Nov 2025 14:22:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
 <20251030121314.56729-2-guwen@linux.alibaba.com>
 <20251031165820.70353b68@kernel.org>
 <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
 <20251105162429.37127978@kernel.org>
 <34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
 <20251127083610.6b66a728@kernel.org>
In-Reply-To: <20251127083610.6b66a728@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/11/28 00:36, Jakub Kicinski wrote:
> On Thu, 27 Nov 2025 13:48:47 +0800 Wen Gu wrote:
>>> We can't delete existing drivers. It used to be far less annoying
>>> until every cloud vendor under the sun decided to hack up their own
>>> implementation of something as simple as the clock.
>>
>> So what kind of drivers do you think are qualified to be placed in the
>> drivers/ptp? I checked some docs, e.g.[1], and codes in drivers/ptp,
>> but I am not sure what the deciding factor is, assuming that exposing
>> a PTP character device is not sufficient.
>>
>> [1] https://docs.kernel.org/driver-api/ptp.html
> 
> Networking ones? I don't have a great answer. My point is basically
> that we are networking maintainers. I have a good understanding of PTP
> (the actual protocol) and TSN as these are networking technologies.
> But I don't feel qualified to review purely time / clock related code.
> I don't even know the UNIX/Linux clock API very well.
> 

Searching the codebase for ptp_clock_register() shows that the PTP
implementations that related to the networking (IEEE 1588) are directly
embedded in the NIC drivers (drivers/net), e.g. ena_phc.c, ice_ptp.c,
igb_ptp.c, instead of being in drivers/ptp.

Most drivers under drivers/ptp are not directly related to networking
and operate independently of NICs. They maintain accuracy through their
own mechanisms.

> Sorry to put you in this position but the VM clocks should have some
> other tree. Or at the very least some clock expert needs to review them.
> 

I noticed you emphasized 'VM clock', but I don’t think it really matters
whether it’s a VM/cloud scenario or not. IMHO whether the PHC is provided
by a chip, FPGA, hypervisor or CIPU makes no fundamental difference.

> Could you go complain to clock people? Or virtualization people?

I understand that the PTP implementations in drivers/ptp aren't closely
related to networking though drivers/ptp is included in NETWORKING DRIVERS
in the MAINTAINER file.

I noticed that drivers/ptp/* is also inclued in PTP HARDWARE CLOCK SUPPORT.
This attribution seems more about 'clock'.

Hi @Richard Cochran, could you please review this? Thanks! :)

Regards.

