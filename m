Return-Path: <netdev+bounces-249801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBEFD1E3C9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BBD030055B5
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC86395DAE;
	Wed, 14 Jan 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X4Now13q"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9C394478
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388019; cv=none; b=LKJamde/zsz/4WlvLQf14YL6uB0bt37vMGY8AiM1VBO7Gs4Ew6X99cytZeKFKrqlvNmUFZg6WoNjb4+f1DRYpZlkeiCwigZBgtzEQBKh3IVyBdHeRF2kjMcjrVDoeMvGKFbwnI2mG6ZHMgJTF6sOQogHMh/vW0euwg7FgIlmIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388019; c=relaxed/simple;
	bh=SP1C5ECn6qTrc/ADnDGMjhhdfGm40PhkP1D0vbgxzkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAx1eG6zGl7wqIg5ou4tBp/YQYVUDIeshLsYUFXE9grYC5o2D4/mgoWrApwtIn/0UCh1WId5xY4Zx/r7WNeIIpcmKgda3Esea/5YG0m+Uais6c5VtOZAk89e+O97YVUDUZs9qJaRr/58ESKzwXesip1eo1MO6DUvnr44cEEBXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X4Now13q; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c85c77bc-9a8c-4336-ab79-89a981c43e01@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768387856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MglISJSdDcSFcnyvQNdU82M1uemIRPK39gzYMnHql/s=;
	b=X4Now13qTN/viHhNP4N1Z2ONBdtxfKZiA0ArDQgEpfyRmsi8HtuJPMtQA20rvH1BCujEQS
	Uuv6G9O7wwnr4IyXrr+7EpnPu5z1+w+4UW9TPf6456yI2uDiV7XPM3RbLg/pbJFh7dBDmg
	XMJ4mOhzwuiTeSWh6sKLs88D/dWvvio=
Date: Wed, 14 Jan 2026 10:50:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Wen Gu <guwen@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>,
 Sven Schnelle <svens@linux.ibm.com>
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
 <b5a60753-85ed-4d61-a652-568393e0dff3@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <b5a60753-85ed-4d61-a652-568393e0dff3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 14/01/2026 09:13, Wen Gu wrote:
> 
> 
> On 2026/1/12 22:52, Vadim Fedorenko wrote:
>> On 12/01/2026 13:24, Andrew Lunn wrote:
>>>>> drivers/ptp/core    - API as written above
>>>>> drivers/ptp/virtual - all PtP drivers somehow emulating a PtP clock
>>>>>                         (like the ptp_s390 driver)
>>>>> drivers/ptp/net     - all NIC related drivers.
>>>>>
>>>>
>>>>
>>>> Well, drivers/ptp/virtual is not really good, because some drivers are
>>>> for physical devices exporting PTP interface, but without NIC.
>>>
>>> If the lack of a NIC is the differentiating property:
>>>
>>>>> drivers/ptp/net     - all NIC related drivers.
>>>>> drivers/ptp/netless - all related drivers which are not associated 
>>>>> to a NIC.
>>>
>>> Or
>>>
>>>>> drivers/ptp/emulating - all drivers emulating a PtP clock
>>
>> I would go with "emulating" then.
>>
>>>
>>>     Andrew
> 
> Thank you all for your suggestions.
> 
> The drivers under drivers/ptp can be divided into (to my knowledge):
> 
> 1. Network/1588-oriented clocks, which allow the use of tools like
>     ptp4l to synchronize the local PHC with an external reference clock
>     (based on the network or other methods) via the 1588 protocol to
>     maintain accuracy. Examples include:
> 
>     - ptp_dte
>     - ptp_qoriq
>     - ptp_ines
>     - ptp_pch
>     - ptp_idt82p33
>     - ptp_clockmatrix
>     - ptp_fc3
>     - ptp_mock (mock/testing)
>     - ptp_dfl_tod
>     - ptp_netc
>     - ptp_ocp (a special case which provides a grandmaster
>                clock for a PTP enabled network, generally
>                serves as the reference clock)

ptp_ocp is a timecard driver, which doesn't require calibration by
ptp4l/ts2phc. OCP TimeCards have their own Atomic Clock onboard which
is disciplined by 1-PPS or 10mhz signal from configurable source. The
disciplining algorithm is implemented in Atomic Clock package
controller. The driver exposes ptp device mostly for reading the time.
So I believe it belongs to group 2 rather than 1588 group.

> 
> 2. Platform/infrastructure/hypervisor-provided clocks. They don't
>     require calibration by ptp4l based on 1588 and reference clocks,
>     instead the underlay handle this. Users generally read the time.
>     They include:
> 
>     - ptp_kvm
>     - ptp_vmclock
>     - ptp_vmw
>     - ptp_s390
>     - ptp_cipu (upstreaming)
> 
>  From this perspective, I agree that "emulating" could be an appropriate
> name for the second ones.
> 
> And I would like to further group the first ones to "1588", thus
> divide drivers/ptp to:
> 
> - drivers/ptp/core
> - drivers/ptp/1588
> - drivers/ptp/emulating
> 
> Regards.


