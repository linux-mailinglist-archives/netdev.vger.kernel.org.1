Return-Path: <netdev+bounces-249768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C63D1D6D4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 017723002531
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1538737F;
	Wed, 14 Jan 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a7QohZog"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44FF36C0BC;
	Wed, 14 Jan 2026 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381992; cv=none; b=ed9HTk59W6fGLExcQZi0hX4iEBxeO1UFmMAtZMfhxw7a9zw7Pk7rU+aim/X5PXgsOnjoc4/mGJtng3bWkPsk3sqNKmm3CUav/Pj54lJhtWgr4f0ty7YqIMj2mOM5ATlWvKf+XFdIOhwB0cc6vUT6Tw9nDaGUbxXhd2WRscrb1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381992; c=relaxed/simple;
	bh=DKRt2xewcoFprYqjFM8zwAQwfz3p+YwHvSsuG8tU+sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF2dGGVjBIYm4eJHYZf/pM7Bsu9LgQPYQrzSZKfzInf7utL5dMwicc1wwCH9klcfmzyqqb18Nv5m7WizSsxvzIn0F8NDC/UlTLfk7hdSbtpGzyI4+gr4zoEp02j1Ixf1O2q2PvLYhelixlBWAXInyhjsY7VNksN6JnnBIlPgM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a7QohZog; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768381987; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XCBSysYrffz93weijRBx26v8jzyWfMtm5xKLzvHm/z0=;
	b=a7QohZogu7NNkAoKnLQ+zqSklE2CV1ASTIOGdpw+VU8PcQDQcpM5C5bRujflR7A1d5Syf4x9K/IWsNelYliI2omVm+KWblK/WP9B8HkZ95TwrUga/+iZwGrZChgCsL/Snk4bQnueeh5wIusexENxG4LgwuMxOAi2Ixeuda9jBKg=
Received: from 30.221.145.108(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wx1nFAy_1768381985 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 17:13:05 +0800
Message-ID: <b5a60753-85ed-4d61-a652-568393e0dff3@linux.alibaba.com>
Date: Wed, 14 Jan 2026 17:13:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Woodhouse <dwmw2@infradead.org>,
 virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <yt9decnv6qpc.fsf@linux.ibm.com>
 <6a32849d-6c7b-4745-b7f0-762f1b541f3d@linux.dev>
 <7be41f07-50ab-4363-8a53-dcdda63b9147@lunn.ch>
 <87495044-59a3-49ed-b00c-01a7e9a23f6b@linux.dev>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <87495044-59a3-49ed-b00c-01a7e9a23f6b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/12 22:52, Vadim Fedorenko wrote:
> On 12/01/2026 13:24, Andrew Lunn wrote:
>>>> drivers/ptp/core    - API as written above
>>>> drivers/ptp/virtual - all PtP drivers somehow emulating a PtP clock
>>>>                         (like the ptp_s390 driver)
>>>> drivers/ptp/net     - all NIC related drivers.
>>>>
>>>
>>>
>>> Well, drivers/ptp/virtual is not really good, because some drivers are
>>> for physical devices exporting PTP interface, but without NIC.
>>
>> If the lack of a NIC is the differentiating property:
>>
>>>> drivers/ptp/net     - all NIC related drivers.
>>>> drivers/ptp/netless - all related drivers which are not associated to a NIC.
>>
>> Or
>>
>>>> drivers/ptp/emulating - all drivers emulating a PtP clock
> 
> I would go with "emulating" then.
> 
>>
>>     Andrew

Thank you all for your suggestions.

The drivers under drivers/ptp can be divided into (to my knowledge):

1. Network/1588-oriented clocks, which allow the use of tools like
    ptp4l to synchronize the local PHC with an external reference clock
    (based on the network or other methods) via the 1588 protocol to
    maintain accuracy. Examples include:

    - ptp_dte
    - ptp_qoriq
    - ptp_ines
    - ptp_pch
    - ptp_idt82p33
    - ptp_clockmatrix
    - ptp_fc3
    - ptp_mock (mock/testing)
    - ptp_dfl_tod
    - ptp_netc
    - ptp_ocp (a special case which provides a grandmaster
               clock for a PTP enabled network, generally
               serves as the reference clock)

2. Platform/infrastructure/hypervisor-provided clocks. They don't
    require calibration by ptp4l based on 1588 and reference clocks,
    instead the underlay handle this. Users generally read the time.
    They include:

    - ptp_kvm
    - ptp_vmclock
    - ptp_vmw
    - ptp_s390
    - ptp_cipu (upstreaming)

 From this perspective, I agree that "emulating" could be an appropriate
name for the second ones.

And I would like to further group the first ones to "1588", thus
divide drivers/ptp to:

- drivers/ptp/core
- drivers/ptp/1588
- drivers/ptp/emulating

Regards.

