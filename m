Return-Path: <netdev+bounces-65215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A456839ABD
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33102285488
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9602538D;
	Tue, 23 Jan 2024 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwaller.net header.i=@pwaller.net header.b="Ar/aGfIr"
X-Original-To: netdev@vger.kernel.org
Received: from mail.foo.to (mail.foo.to [144.76.29.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291AF9D8
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.29.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043733; cv=none; b=iGQbwLeq9hI7pR60qxWI6ylG8vQyhmFPsl7MdGsGmMkEcNCi72rvKQ1SrABDYQXuCsIoHv+D2X2Fg2SJklIJiBdN3pwPiKNSYGNLWJ/jbk/FHGmBPGpCHVMYwGin2IlqmI5OOqRITem3uwqRdy2vjr53caMLEv0bpIJ7sB9LgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043733; c=relaxed/simple;
	bh=8qHo+ftKJOzaPnKdBKTks7d0X+soiClQ3km+6qGPlLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XLpHM/89yykfKWFHFrxaYj39QtQp6ORHW+LUvCUf1BMDZIoPWw2yIKMRu/1X7l4BjigCvAOEnsb89jGFxst3P7CpDDX72oLbfc+PJSRyMqcPw5h9dj3i0fAVo3uWcFXaboWoVWMIMYABNcwNLDaabBadx72S5dY8rZcbirz0eL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwaller.net; spf=pass smtp.mailfrom=pwaller.net; dkim=pass (1024-bit key) header.d=pwaller.net header.i=@pwaller.net header.b=Ar/aGfIr; arc=none smtp.client-ip=144.76.29.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwaller.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwaller.net
Message-ID: <32a0ccb2-9570-4099-961c-6a53e1a553d7@pwaller.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pwaller.net; s=mail;
	t=1706043729; bh=8qHo+ftKJOzaPnKdBKTks7d0X+soiClQ3km+6qGPlLs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Ar/aGfIrlLn/NRmjolfgyDRbwnHmjLcqr0ccNdDxtzxCidhnRAKMdcb2mu64NMuV3
	 33JM7fc+nOQQqDSugpfmEU9kaLuBpzk29qjH02T/9eDyQB6To0dHUawb/Rb3DKGlvi
	 X5sXzgSID1Vlmm73F8UYTm1dpMrPtmxx2itV8AXI=
Date: Tue, 23 Jan 2024 21:02:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
From: Peter Waller <p@pwaller.net>
To: Igor Russkikh <irusskikh@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Netdev <netdev@vger.kernel.org>
References: <3b607ba8-ef5a-56b3-c907-694c0bde437c@marvell.com>
 <E8060D65-F6C2-4AF5-AE3F-8ED8A30F95EF@pwaller.net>
Content-Language: en-US
In-Reply-To: <E8060D65-F6C2-4AF5-AE3F-8ED8A30F95EF@pwaller.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Here's part of the log, I can provide more off list if it helps. - Peter

<previous boot> Filesystems sync: 0.014 seconds
<n>.678271 Freezing user space processes
<n>.678366 Freezing user space processes completed (elapsed 0.001 seconds)
<n>.678383 OOM killer disabled.
<n>.678397 Freezing remaining freezable tasks
<n>.678407 Freezing remaining freezable tasks completed (elapsed 0.000 
seconds)
<n>.678423 printk: Suspending console(s) (use no_console_suspend to debug)
<n>.678437 serial 00:04: disabled
<n>.678654 queueing ieee80211 work while going to suspend
<n>.678680 sd 9:0:0:0: [sda] Synchronizing SCSI cache
<n>.678884 ata10.00: Entering standby power mode
<n>.678900 atlantic 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0014 address=0xfc80b000 flags=0x0020]
<n>.679124 atlantic 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0014 address=0xffeae520 flags=0x0020]
<n>.679270 atlantic 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0014 address=0xfc80c000 flags=0x0020]
<n>.679411 atlantic 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0014 address=0xffeae530 flags=0x0020]
<n>.679541 ACPI: EC: interrupt blocked
<n>.679554 amdgpu 0000:03:00.0: amdgpu: MODE1 reset
<n>.679682 amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
<n>.679803 amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
<n>.679919 ACPI: PM: Preparing to enter system sleep state S3
<n>.679931 ACPI: EC: event blocked
<n>.679942 ACPI: EC: EC stopped
<n>.679952 ACPI: PM: Saving platform NVS memory
<n>.679959 Disabling non-boot CPUs ...
<snip>
<n>.682471 atlantic 0000:0c:00.0 eno2: atlantic: link change old 1000 new 0
<snip>
<n>.687497 PM: suspend exit

On 23/01/2024 15:13, Peter Waller wrote:
> True, it is a warning rather than a hard crash, though shutdown hangs. Thanks for the workaround.
>
> I can provide more dmesg when I’m back at my computer. Do you need the whole thing or is there something in particular you want from it? From memory there isn’t much more in the way of messages that looked connected to me.
>
> Sent from my mobile, please excuse brevity
>
>> On 23 Jan 2024, at 14:59, Igor Russkikh <irusskikh@marvell.com> wrote:
>>
>> ﻿
>>> On 1/21/2024 10:05 PM, Peter Waller wrote:
>>> I see a fix for double free [0] landed in 6.7; I've been running that
>>> for a few days and have hit a resume from suspend issue twice. Stack
>>> trace looks a little different (via __iommu_dma_map instead of
>>> __iommu_dma_free), provided below.
>>>
>>> I've had resume issues with the atlantic driver since I've had this
>>> hardware, but it went away for a while and seems as though it may have
>>> come back with 6.7. (No crashes since logs begin on Dec 15 till Jan 12,
>>> Upgrade to 6.7; crashes 20th and 21st, though my usage style of the
>>> system has also varied, maybe crashes are associated with higher memory
>>> usage?).
>> Hi Peter,
>>
>> Are these hard crashes, or just warnings in dmesg you see?
>>  From the log you provided it looks like a warning, meaning system is usable
>> and driver can be restored with `if down/up` sequence.
>>
>> If so, then this is somewhat expected, because I'm still looking into
>> how to refactor this suspend/resume cycle to reduce mem usage.
>> Permanent workaround would be to reduce rx/tx ring sizes with something like
>>
>>     ethtool -G rx 1024 tx 1024
>>
>> If its a hard panic, we should look deeper into it.
>>
>>> Possibly unrelated but I also see fairly frequent (1 to ten times per
>>> boot, since logs begin?) messages in my logs of the form "atlantic
>>> 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0014
>>> address=0xffce8000 flags=0x0020]".
>> Seems to be unrelated, but basically indicates HW or FW tries to access unmapped
>> memory addresses, and iommu catches that.
>> Full dmesg may help analyze this.
>>
>> Regards
>>   Igor



