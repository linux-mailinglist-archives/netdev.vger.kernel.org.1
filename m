Return-Path: <netdev+bounces-190414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AC5AB6C8D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC3E8C72D9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3727934B;
	Wed, 14 May 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="qwJ/bZyS"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC0277807
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229083; cv=none; b=rPsLCLxz/A2noIBX6neubkikxxxmr+re+1lY7ueFNo5lixujsrtetYuzyxM1O7Acxv6n2fwKRIptR5vJIDAZ+xZEDeR+EyfoaQgbIXmWdMJUd8nhqrxfZVY0ObJEQtyLgo/gIBAZg6PXkpCqdV8cPJBpiUgUHl0Y4yQs3HNNDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229083; c=relaxed/simple;
	bh=7obkYwf8rdiMX3PnxORKnuXRRyqKnRS/42/ehfibIbM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ML+uYUfV3ZEzxcJKuVPjKFk2hIfqS6DTPbLSCibTvqvwr+TVOMSRjuoJkoyxPKF8OFzkdXP7ajO54FrdpoyJdFdg/yT4x9tfCGdK/D4VTMpauRU2IkXdXPPUe4EpS//9atq3P9GpzB5B0+g94mM7+ljbWGczp+iJLH09LNpEq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=qwJ/bZyS; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RECT3YDceMgyMxOstYrzCcqdGHbB+skbrFlZFVmP6/I=; b=qwJ/bZySQ27t4lDoyAicOq1nat
	CWh3x03JLNuedC79YWVnbMWdBH82IHv39qe27nFbQhZACjALr5/PwCi0ifKjSb7/ZKQkzYZEP4hPF
	zwb8cF2dgVEuNCC3LQZwlHAvCyQWRR/nmwzFDz++GaAmfVHXYdXwkCkhWI71vKJOUn9Fh2VOny/Jo
	5Ddrix9Ts58F4XnuCPA/EaXd8W3XHvoaCHzaIFTN7Hlo+U52Ngo57ZdxRPVyE/5HJkloYlVbe5cTq
	4cJ2iHN+4ZqRGR8z4QWa+XDn7pRrvLnJuzPoj+QklG+/dczQdaSMfxueVrWfDcG/dp8sxUCHxPHYo
	lXscxvjg==;
Received: from [122.175.9.182] (port=36014 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uFC66-0000000015n-2jR1;
	Wed, 14 May 2025 18:54:34 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id DB34117840BC;
	Wed, 14 May 2025 18:54:30 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id CDCE017823F8;
	Wed, 14 May 2025 18:54:30 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oeDt37bfFapV; Wed, 14 May 2025 18:54:30 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B2C171782000;
	Wed, 14 May 2025 18:54:30 +0530 (IST)
Date: Wed, 14 May 2025 18:54:30 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: pabeni <pabeni@redhat.com>
Cc: netdev <netdev@vger.kernel.org>
Message-ID: <337432675.1282729.1747229070648.JavaMail.zimbra@couthit.local>
In-Reply-To: <cbba5990-959b-476f-a3fd-6b346a7d58ee@redhat.com>
References: <20250503121107.1973888-1-parvathi@couthit.com> <20250503131139.1975016-5-parvathi@couthit.com> <ce36ce0e-ad16-4950-b601-ae1a555f2cfb@redhat.com> <1918420534.1246603.1746786066099.JavaMail.zimbra@couthit.local> <1183e3e4-fa93-4fe6-bfe5-e58b7852d294@redhat.com> <876351908.1270745.1747138715014.JavaMail.zimbra@couthit.local> <cbba5990-959b-476f-a3fd-6b346a7d58ee@redhat.com>
Subject: Re: [PATCH net-next v7 04/11] net: ti: prueth: Adds link detection,
 RX and TX support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC135 (Mac)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds link detection, RX and TX support.
Thread-Index: l9+gi0FaKZMBzCWiVYrODcBt7ep9wg==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> Apparently you unintentionally stripped the recipients list. Let me
> re-add the ML.
> 
> On 5/13/25 2:18 PM, Parvathi Pudi wrote:
>>> On 5/9/25 12:21 PM, Parvathi Pudi wrote:
>>>>> On 5/3/25 3:11 PM, Parvathi Pudi wrote:
>>>>>> +/**
>>>>>> + * icssm_emac_rx_thread - EMAC Rx interrupt thread handler
>>>>>> + * @irq: interrupt number
>>>>>> + * @dev_id: pointer to net_device
>>>>>> + *
>>>>>> + * EMAC Rx Interrupt thread handler - function to process the rx frames in a
>>>>>> + * irq thread function. There is only limited buffer at the ingress to
>>>>>> + * queue the frames. As the frames are to be emptied as quickly as
>>>>>> + * possible to avoid overflow, irq thread is necessary. Current implementation
>>>>>> + * based on NAPI poll results in packet loss due to overflow at
>>>>>> + * the ingress queues. Industrial use case requires loss free packet
>>>>>> + * processing. Tests shows that with threaded irq based processing,
>>>>>> + * no overflow happens when receiving at ~92Mbps for MTU sized frames and thus
>>>>>> + * meet the requirement for industrial use case.
>>>>>
>>>>> The above statement is highly suspicious. On an non idle system the
>>>>> threaded irq can be delayed for an unbound amount of time. On an idle
>>>>> system napi_poll should be invoked with a latency comparable - if not
>>>>> less - to the threaded irq. Possibly you tripped on some H/W induced
>>>>> latency to re-program the ISR?
>>>>>
>>>>> In any case I think we need a better argumented statement to
>>>>> intentionally avoid NAPI.
>>>>>
>>>>> Cheers,
>>>>>
>>>>> Paolo
>>>>
>>>> The above comment was from the developer to highlight that there is an
>>>> improvement in
>>>> performance with IRQ compared to NAPI. The improvement in performance was
>>>> observed due to
>>>> the limited PRU buffer pool (holds only 3 MTU packets). We need to service the
>>>> queue as
>>>> soon as a packet is written to prevent overflow. To achieve this, IRQs with
>>>> highest
>>>> priority is used. We will clean up the comments in the next version.
>>>
>>> Do you mean 'IRQ _thread_ with the highest priority'? I'm possibly
>>> missing something, but I don't see the driver setting the irq thread
>>> priority.
>>>
>>> Still it's not clear to me why/how scheduling a thread should guarantee
>>> lower latency than serving the irq is softirq context, where no
>>> reschedule is needed.
>>>
>>> I think you should justify this statement which sounds counter-intuitive
>>> to me.
>>>
>>> Thanks,
>>>
>>> Paolo
>> 
>> I might not have been clear in my earlier communication. The driver does not
>> configure the IRQ thread to run at the highest priority. Instead, the highest
>> real-time priority is assigned to the user applications using "chrt" to ensure
>> timely processing of network traffic.
> 
> I don't follow. Setting real-time priority for the user-space
> application thread will possibly increase the latency for the irq thread.
> 
>> This commit in the TI Linux kernel can be used as a reference for the transition
>> from NAPI-based polling to IRQ-driven packet processing:
>> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?id=7db2c2eb0e33821c2f1abea14f079bc23b7bde56
>> 
>> This change is based on performance limitations observed with NAPI polling under
>> high UDP traffic. Specifically, during iperf tests with UDP traffic at 92 Mbps
>> and MTU-sized frames, ingress queue overflows were observed. This occurs because
>> the hardware ingress queues have limited buffering capacity, resulting in
>> dropped
>> frames.
>> 
>> Based on the stated limitations with NAPI polling, we believe that switching to
>> a
>> threaded IRQ handler is a reasonable solution. I'll follow up with the
>> developers
>> in the background to gather additional context on this implementation and will
>> try
>> to collect relevant bench-marking data to help justify the approach further. In
>> the meantime, do you see any concern moving forward with the use of threaded
>> IRQs
>> for now?
> 
> The IRQ thread is completely under the scheduler control. It can
> experience unbound latency (i.e. if there are many other running thread
> in the same CPU). You need to tune the scheduling priority for the
> specific setup/host, and likely will not work well (or at all) in other
> scenarios.
> 
> See commit 4cd13c21b207 and all it's follow-ups to get an idea of the
> things that could go wrong. Note that such commit moved the network
> processing into thread scope only on quite restrictive conditions.
> Having the packet processing unconditionally threaded could be much worse.
> 
> /P

Thank you for clarifying where you are coming from and sharing the references
to the discussions. We will review thoroughly and revert back with more
details soon.


Thanks and Regards,
Parvathi.

