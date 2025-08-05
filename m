Return-Path: <netdev+bounces-211822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777BAB1BCC4
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C773A8826
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B032609CC;
	Tue,  5 Aug 2025 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="p3KwjVJL"
X-Original-To: netdev@vger.kernel.org
Received: from mta-102a.earthlink-vadesecure.net (mta-102b.earthlink-vadesecure.net [51.81.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0824679B
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433865; cv=none; b=JgVRaBGDGlw0WO8zGgsfhjUxWI29Ri9ZZXZERxzR5jUU9Cq0gGp0GK8ZL3rrMjf36PQcQkAppx/gPYzcw9dpI5BqZ2LqZuQj0F5UR73ClMrqpfOE+QF3yiQfzna6XMAzuPxul92mLek5u8Dij59DHLa6f7Ee3tMQrybAN2DL62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433865; c=relaxed/simple;
	bh=fvYs4C6jGElZomsNh0d99vp+BM++9pKt+YX/5uexv1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFKlGP87wmtB/U5VMbOUQTqgv5ywBI3VH/7WeYWC5tBPaZNmIcgzAk99JWVqiBYDQK2R914U9I8+DV+1lDEnfX/hrLsUiwiNweNi3an1EbuGWAvWO2F3VFvNnsX7KYutx6XYOO0+tKcA/R4OqdUonEaSBbY3n2E750bGz966jA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=p3KwjVJL; arc=none smtp.client-ip=51.81.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=FNaGHqdAYm0tWOTnL+0gPswJwqmMDAhWr7+DMl
 fyfWA=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1754432924; x=1755037724; b=p3KwjVJLmQWB/ElEsmXPTBE60kh
 0cCXXBwBDutoP/UJ0V0NR4wMphC6PbcbEY89jZvIdjJj1LHUGhhZ4k5EZKvQrM5FujSZVik
 QGdV5jR+uiQkFkToZd6b4GHMKq5K543P6oH5CbyvTxVbdo4gTLc1KYiUSFhKlTM1zDFkand
 +/jcLNe3Cop6Gbq7ELWH22yn0wuVVCfRzzsBndvwAv5xRool9NpR53VpklFiuaweSs0Cuyc
 Zx1i3JvTjZEEO7dK1MNjZW9oU2fiZrM79sDKfuMYFuxRaOjJMOjGhX7oHtAk8k13XL1ypVx
 WLXuHBfmR5mA1sz0E6UMkt8U/yeb4ZA==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id 47e7f90e-1858ff72800b37ab; Tue, 05 Aug 2025 22:28:44 +0000
Message-ID: <3cdbb79a-7c98-4172-9c74-4ae968054fda@onemain.com>
Date: Tue, 5 Aug 2025 15:28:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] pds_core: add simple AER handler
To: Brett Creeley <bcreeley@amd.com>, Lukas Wunner <lukas@wunner.de>,
 Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io
References: <20240216222952.72400-1-shannon.nelson@amd.com>
 <20240216222952.72400-2-shannon.nelson@amd.com> <aJIcyjyGxlKm382t@wunner.de>
 <48ffde5c-084f-4ad6-8be7-314afb14b2ac@amd.com>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <48ffde5c-084f-4ad6-8be7-314afb14b2ac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/25 3:10 PM, Brett Creeley wrote:
> On 8/5/2025 8:01 AM, Lukas Wunner wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> On Fri, Feb 16, 2024 at 02:29:50PM -0800, Shannon Nelson wrote:
>>> Set up the pci_error_handlers error_detected and resume to be
>>> useful in handling AER events.
>>
>> The above was committed as d740f4be7cf0 ("pds_core: add simple
>> AER handler").
>>
>> Just noticed the following while inspecting the pci_error_handlers
>> of this driver:
>>
>>> +static pci_ers_result_t pdsc_pci_error_detected(struct pci_dev *pdev,
>>> + pci_channel_state_t error)
>>> +{
>>> +     if (error == pci_channel_io_frozen) {
>>> +             pdsc_reset_prepare(pdev);
>>> +             return PCI_ERS_RESULT_NEED_RESET;
>>> +     }
>>> +
>>> +     return PCI_ERS_RESULT_NONE;
>>> +}
>>
>> The ->error_detected() callback of this driver invokes
>> pdsc_reset_prepare(), which unmaps BARs and calls pci_disable_device(),
>> but there is no corresponding ->slot_reset() callback which would invoke
>> pdsc_reset_done() to re-enable the device after reset recovery.
>>
>> I don't have this hardware available for testing, hence do not feel
>> comfortable submitting a fix.  But this definitely looks broken.
>
> Hi Lukas,
>
> Thanks for the note. It's been a bit since I have looked at this, but 
> I believe that it's working in the following way:
>
> 1. pds_core's pci_error_handlers.error_detected callback returns 
> PCI_ERS_RESULT_NEED_RESET
> 2. status is initialized to PCI_ERS_RESULT_RECOVERED in the pci core 
> and since pds_core doesn't have a slot_reset callback then status 
> remains PCI_ERS_RESULT_RECOVERED
> 3. pds_core's pci_error_handlers.resume callback is called, which will 
> attempt reset/recover the device to a functional state

Thanks, Brett - yes this sounds about right by my memory.  The resume 
callback takes care of getting the device reset and re -enabled.

>
> I also know that, at the very least, Shannon tested this when adding 
> it to the driver.

Yep, several cycles, several scenarios.

Cheers,
sln

>
> Let me know if you still think otherwise.
>
> Thanks again for the feedback,
>
> Brett
>
>


