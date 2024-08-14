Return-Path: <netdev+bounces-118533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8070951E22
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F66E1F23262
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FFD1B4C27;
	Wed, 14 Aug 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="G+tNeBGJ"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF81B3F2D
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648129; cv=pass; b=uTDa4Z8dbb79Le0y06QVymjsPGfMmg8gRQAZv7LIDkupZeQkpN/3FpCYOGIuxFzj8Z0HSaRdTVYBRxTnZkjaNo+4CnazTf5SV6gSFlXuqyiYGkYMFR3/Scg5SGXq4dfs2sEUjFWoeaazTOECe+IuaWQ+XRL67crafxUN/4lOAik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648129; c=relaxed/simple;
	bh=tzzNWmIHy7GialirAluI6vdJxJdoWVtSWHbvXFSbyKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8y8UgBJlDIU6GqfddEOqPWg1rCI09lWVGqm6Dwo/Y2oHiUqD62xWErZqOeMYgfDHlyl56uhWGYL5YV/lUv8AChhfL8dZ8UmemYPtcgZTJmdnGELAvsCgHrI3Ov6zxVAtuExhI8wpcNFGtu2THt297t8py59noam+9wTp4OrfcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=G+tNeBGJ; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723648112; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BHSN6lRXaGcDY7bwC35z4DIarfOQhJBxJ0e6CRnplvR+6ues+jRqC5Xuo8pjB52sMSb1/Mzhtbzk1i6VqK+ZSezDmm4T04O1HqVl2lQcFO4Hg1HEM1+StjwY0P0whQyUJyM4ooVFZ/R/DKwCpvc9124l1Bt0ohBnlu0PkkltQmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723648112; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=elmUNn+WwzhQf2ZD0cT0xYadLjMAyv+MK+0Z4/9BIC4=; 
	b=EIeWL3dkMMHRpYI/RGwDBORphFKeHpDFfqyQTMzcvSRT+gQRMXc/NI8yltCpaAoWltOi0jeM7w2Zcq79w41vAzftOIN05c0cj4ns6AiT9UvS3l+FqTFyasXclSqiW2f5EhPAfSIR7557mNohD29eStu3CrHqYUTXWeg52b4muwo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723648112;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=elmUNn+WwzhQf2ZD0cT0xYadLjMAyv+MK+0Z4/9BIC4=;
	b=G+tNeBGJIalM7ckB3p8CcJAOI59Nya7G1gT6Z8I9aLaXGOkEvq2TMJFNSvLTsYqn
	anIqEv1jJkhkSauVFhkLm+9IQ+8XNL6Jj6jrpngrJhjjJSDhpJ8v64wbtuUmd3QlckV
	fzHqKhHa5/d4laSpMubVYDNHes2EaNUp5j2WCYcwSYGzV6Km7iSvPJ8SgVwt3R9tSnp
	YKF7Bzb8PIJNEX1DR0Tr1EV7HuMCrB64nJ2Rz+KfL5kYWCWnX/uvYPLrDZ2ScFlP7Hs
	EUblVMCul2y57pAu9Ov1RZ0raGaMKhBxQdGGuaOQgIv+Grtux8njNQho4RIAR/BS3L3
	4YqMQwJcTA==
Received: by mx.zohomail.com with SMTPS id 1723648109953513.5698680578232;
	Wed, 14 Aug 2024 08:08:29 -0700 (PDT)
Message-ID: <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
Date: Wed, 14 Aug 2024 17:08:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] ptp: Add esterror support
To: Andrew Lunn <andrew@lunn.ch>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 14/08/2024 15:08, Andrew Lunn wrote:
> On Wed, Aug 14, 2024 at 09:44:29AM +0100, Vadim Fedorenko wrote:
>> On 13/08/2024 21:05, Andrew Lunn wrote:
>>> On Tue, Aug 13, 2024 at 12:55:59PM +0000, Maciek Machnikowski wrote:
>>>> This patch series implements handling of timex esterror field
>>>> by ptp devices.
>>>>
>>>> Esterror field can be used to return or set the estimated error
>>>> of the clock. This is useful for devices containing a hardware
>>>> clock that is controlled and synchronized internally (such as
>>>> a time card) or when the synchronization is pushed to the embedded
>>>> CPU of a DPU.
>>>
>>> How can you set the estimated error of a clock? Isn't it a properties
>>> of the hardware, and maybe the network link? A 10BaseT/Half duplex
>>> link is going to have a bigger error than a 1000BaseT link because the
>>> bits take longer on the wire etc.
>>
>> AFAIU, it's in the spec of the hardware, but it can change depending on
>> the environment, like temperature. The link speed doesn't matter here,
>> this property can be used to calculate possible drift of the clock in
>> the micro holdover mode (between sync points).
> 
> Is there a clear definition then? Could you reference a standard
> indicating what is included and excluded from this?
> 
The esterror should return the error calculated by the device. There is
no standard defining this, but the simplest implementation can put the
offset calculated by the ptp daemon, or the offset to the nearest PPS in
cases where PPS is used as a source of time


>>> What is the device supposed to do with the set value?
>>
>> It can be used to report the value back to user-space to calculate the
>> boundaries of "true time" returned by the hardware.
> 
> So the driver itself does not know its own error? It has to be told
> it, so it can report it back to user space. Then why bother, just put
> it directly into the ptp4l configuration file?
> 
> Maybe this is all obvious to somebody who knows PTP inside out, but to
> me it is not. Please could you put a better explanation and
> justification into the commit message. We need PHY driver writers who
> have limited idea about PTP can implement these new calls.
>
> Andrew

It's designed to enable devices that either synchronize its own hw clock
to some source of time on a hardware layer (e.g. a Timecard that uses a
PPS signal from the GNSS), or a device in which the PTP is done on a
different function (multifunction NIC, or a DPU) to convey its best
estimate of the error (see above). In case of a multifunction NIC the
ptp daemon running on a function that synchronizes the clock will use
the ADJ_ESTERROR to push the error estimate to the device. The device
will then be able to
a. provide that information to hardware clocks on different functions
b. prevent time-dependent functionalities from acting when a clock
shifts beyond a predefined limit.

Also esterror is not maxerror and is not designed to include all errors,
but the best estimate

Thanks
Maciek

