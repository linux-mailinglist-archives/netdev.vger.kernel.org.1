Return-Path: <netdev+bounces-242892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AE8C95BFC
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 07:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3560341CE5
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 06:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67B22E3F0;
	Mon,  1 Dec 2025 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VjW2dD7R"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E92229B2A;
	Mon,  1 Dec 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764569112; cv=none; b=ryH4zRCRt4xk7/RO2StQQ9SMeTl5NySNNH2Z35OzPx+wwB60H0UF8aM0A8mvOkpCDeXVOyq96uCLXdMmI1LzMqr3AVJbG5uPrpxFZrjUvLw4+KIYI5OOouVEr0rvhPQSYiZ0T/9B+MJcLe5MbfvrLqjrfXqcXnMJv42SXeGaFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764569112; c=relaxed/simple;
	bh=Ud9g2Bcti0ViS/cO9GVYleAX19SkiB7ZfHACfKgHNZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzzhvHTQy8k8thTly50H93OZYnahcQGA6s9vEKBhsJGFmFlZyK0WQwO0LKrFQyKnAx7wOV/9Dw24cLWgzba/za0lqNFVAPcpZomU3KcnCxNojzzgKeANZN78FVtiAAQIiYIjs58Fcgnsdif2hQi8ifGHTIONMWWZSvkXr2u8+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VjW2dD7R; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764569099; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=icuWV4fS+7IDzs1gMNWLxbwa/xoEMhaLFLpYh8hPNL4=;
	b=VjW2dD7RMjkidkY9ZcYv2MSq3JaYNLLIYTPdAUI0Ea6meoDhb2vYzToIjaS+FWLv4XqopU3rs/+q4XO0Eyk/H/Svu350HKjFn5BMon8ErTzIx5wGPyMnBg/D+M1Z4P0xHRlCy3mnExwQ36aeBRLErM5LI181LDR7763lXBc5nhU=
Received: from 30.221.145.112(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WtmfeuK_1764569098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 14:04:58 +0800
Message-ID: <9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
Date: Mon, 1 Dec 2025 14:04:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: Jakub Kicinski <kuba@kernel.org>
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
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20251128102437.7657f88f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/29 02:24, Jakub Kicinski wrote:
> On Fri, 28 Nov 2025 14:22:21 +0800 Wen Gu wrote:
>>> Could you go complain to clock people? Or virtualization people?
>>
>> I understand that the PTP implementations in drivers/ptp aren't closely
>> related to networking though drivers/ptp is included in NETWORKING DRIVERS
>> in the MAINTAINER file.
>>
>> I noticed that drivers/ptp/* is also inclued in PTP HARDWARE CLOCK SUPPORT.
>> This attribution seems more about 'clock'.
>>
>> Hi @Richard Cochran, could you please review this? Thanks! :)
> 
> It's Thanksgiving weekend in the US, Richard may be AFK so excuse my
> speaking for him, but he mentioned in the past that he is also not
> interested in becoming a maintainer for general clocks, unrelated
> to PTP.
> 

Wishing you a Happy Thanksgiving!

I think you misunderstood. I didn't encourage Richard to maintain
general clocks unrelated to PTP. Rather, I believe this driver should
belong to the PTP subsystem, and here are my reasons (which have been
mentioned in previous emails):

1. CIPU provides high-precision PHCs for VMs or bare metals, which
    are exposed as ptp_clock according to the definition in [1]. its
    usage is no different from other ptp devices. So this is a PTP
    driver.

[1] https://docs.kernel.org/driver-api/ptp.html

2. The PTP implementations that are independent of networking and
    NICs are placed under drivers/ptp. These devices are provided from
    chip/FPGA/hypervisor and maintain clock accuracy in their own unique
    ways. CIPU ptp driver is no different and should also be placed
    under the drivers/ptp from this perspective.

According to the MAINTAINERS file, drivers/ptp/* is maintained by the
NETWORKING DRIVERS and PTP HARDWARE CLOCK SUPPORT subsystems. Considering
you mentioned that drivers/ptp is not closely related to networking, I
think it might be more appropriate for the PTP HARDWARE CLOCK SUPPORT
subsystem maintainer to review it. After it merges into the upstream,
we will be its maintainers.

> Search the mailing list, there are at least 3 drivers like yours being
> proposed. Maybe you can get together with also the KVM and VMclock
> authors and form a new subsystem?

I think drivers under drivers/ptp are all similar. But aside from the
fact that they are all exposed as PTP devices and therefore classified
in the PTP subsystem, I haven't been able to find a way to classify
them into another class (note that CIPU ptp can't be considered a
VM/hypervisor clock class since bare metal scenario is also applicable).

Regards.

