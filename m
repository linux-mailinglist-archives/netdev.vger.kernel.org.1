Return-Path: <netdev+bounces-244462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38741CB80EF
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 07:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4E92300ADAE
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 06:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD330EF96;
	Fri, 12 Dec 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PVhDcPRO"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FE02F6569;
	Fri, 12 Dec 2025 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765522230; cv=none; b=dwzkzY3tQ/ryDyIRRoGKTj96mliJqp3XpL55es00ZwBlrgtgBOue/Qk96E1n8FEm2j5gcRYLCOHj7I7bpKWdmnf2x6EEcbsyLF3OWj7wjDjOf14lHtlblXC/8+6wqvu9n+DEWskjSEEREZa3NCc/7wNzGYtL8EwVSSPM0I64jak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765522230; c=relaxed/simple;
	bh=+c1MAB5EwW4T7Q8EJQbHiyIAymFu+PD/okJff73t/+o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KBn9ioIb6LDK7s+4E5O16lCeYdh2u3fRbTcEkhCcSPk7eurfSoZAeihIoYBjG/jCHFiigD/+PmXrYnA+7E2tCWOcIBi+xPKn5GMjh92Ji+Q073gz5sV9nJURNE10bWYWOktbk92qgUb9ZFMxB4P0xNdpEHbZPqk/h8A6NgolEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PVhDcPRO; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765522222; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=MsJVSWhNq3rE3HurXTce8VbnsysGEyaJspLDI8MhOM4=;
	b=PVhDcPROtW5gh/T3rUChNHoJz4TprYpvSOe9W094d96bu2jR2GcrI6/1UsAYWdHusUTzrNPFYu8fPfHY/yBq/wvw31WXHUssltnFc7IxRvYSco3QkxxhncaxFaFlKsNCiaJcnoQg8c67w4i9cZ39BIDAptXYU8ApR1XeQoUzjPM=
Received: from 30.221.129.89(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WudL14G_1765522213 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 14:50:21 +0800
Message-ID: <c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
Date: Fri, 12 Dec 2025 14:50:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
From: Wen Gu <guwen@linux.alibaba.com>
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
 <9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
In-Reply-To: <9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/12/1 14:04, Wen Gu wrote:
> 
> 
> On 2025/11/29 02:24, Jakub Kicinski wrote:
>> On Fri, 28 Nov 2025 14:22:21 +0800 Wen Gu wrote:
>>>> Could you go complain to clock people? Or virtualization people?
>>>
>>> I understand that the PTP implementations in drivers/ptp aren't closely
>>> related to networking though drivers/ptp is included in NETWORKING DRIVERS
>>> in the MAINTAINER file.
>>>
>>> I noticed that drivers/ptp/* is also inclued in PTP HARDWARE CLOCK SUPPORT.
>>> This attribution seems more about 'clock'.
>>>
>>> Hi @Richard Cochran, could you please review this? Thanks! :)
>>
>> It's Thanksgiving weekend in the US, Richard may be AFK so excuse my
>> speaking for him, but he mentioned in the past that he is also not
>> interested in becoming a maintainer for general clocks, unrelated
>> to PTP.
>>
> 
> Wishing you a Happy Thanksgiving!
> 
> I think you misunderstood. I didn't encourage Richard to maintain
> general clocks unrelated to PTP. Rather, I believe this driver should
> belong to the PTP subsystem, and here are my reasons (which have been
> mentioned in previous emails):
> 
> 1. CIPU provides high-precision PHCs for VMs or bare metals, which
>     are exposed as ptp_clock according to the definition in [1]. its
>     usage is no different from other ptp devices. So this is a PTP
>     driver.
> 
> [1] https://docs.kernel.org/driver-api/ptp.html
> 
> 2. The PTP implementations that are independent of networking and
>     NICs are placed under drivers/ptp. These devices are provided from
>     chip/FPGA/hypervisor and maintain clock accuracy in their own unique
>     ways. CIPU ptp driver is no different and should also be placed
>     under the drivers/ptp from this perspective.
> 
> According to the MAINTAINERS file, drivers/ptp/* is maintained by the
> NETWORKING DRIVERS and PTP HARDWARE CLOCK SUPPORT subsystems. Considering
> you mentioned that drivers/ptp is not closely related to networking, I
> think it might be more appropriate for the PTP HARDWARE CLOCK SUPPORT
> subsystem maintainer to review it. After it merges into the upstream,
> we will be its maintainers.
> 
>> Search the mailing list, there are at least 3 drivers like yours being
>> proposed. Maybe you can get together with also the KVM and VMclock
>> authors and form a new subsystem?
> 
> I think drivers under drivers/ptp are all similar. But aside from the
> fact that they are all exposed as PTP devices and therefore classified
> in the PTP subsystem, I haven't been able to find a way to classify
> them into another class (note that CIPU ptp can't be considered a
> VM/hypervisor clock class since bare metal scenario is also applicable).
> 
> Regards.


Given that net-next is closed and the EOY break is here, I was wondering
whether the review discussion might continue during this period or should
wait until after the break.

Thanks.


