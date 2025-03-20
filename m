Return-Path: <netdev+bounces-176533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BEA6AAFD
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497893A54C4
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42E1DA612;
	Thu, 20 Mar 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHOcTPa7"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E626AEC
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487995; cv=none; b=UNgpODca8GOBm0s8Ehc1qQ15mfgJ5LYLxzn9Kd5aC7dPgoOsssUiGWs8B6a9e+RQ+fP0PU2CWf3jpgKgaG02CapyH5GonQ8tMAu7+EMVXfiGuZtk7ytSkhYXm7b3hDuwt6S3pZKjWw+8L75DIXwyDGJ1pf2RbONsUknTsZVHCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487995; c=relaxed/simple;
	bh=3tT9OwtD1vuBsnPmI2hohXSMsHQA4A2fvR2V/PQaDrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXlIWRfon2ubh+B0yl/UZW4Zzad9oI/rQoa19LjBDnY1R9AmQyfpjmuFR2E5i/TVerJvZDLZurIjN7tmzItzChEIDf+HxxewRkjWLsSCrCd3Ih+Xyp8tTWDh6eNMqusKWF7AVOn8XMGfEWNu2leS9VIj2T4VLWUCnMci663hJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHOcTPa7; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1dc9d113-b4c8-4fd0-8ebc-e4125a0816ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742487990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BELUwE3XBxlF1xOTAqK3M9wE3RLzxmbpXR7zR+MJaMU=;
	b=SHOcTPa7VDgAV58bjOH6++SkZSEZimqQ5Us1vWMIdjsS21fsnrujFg+lzKqgLM5oA02Bad
	uARuSqO2kNQfQjZbQFPhf0G61moLKc0mnpqGYussQHgsYjYk5R4g6G3+RUfGGsCW/xysvh
	BVaZIr6Oo43peC0AtojGGoAI4/tcBG4=
Date: Thu, 20 Mar 2025 16:26:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Kamil Zaripov <zaripov-kamil@avride.ai>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Andrew Gospodarek <andrew.gospodarek@broadcom.com>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <CALs4sv3DtyBSqx0v_FHFUPrB+w7GOsheNOEa0pm6N4xNf-4JUA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALs4sv3DtyBSqx0v_FHFUPrB+w7GOsheNOEa0pm6N4xNf-4JUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 20/03/2025 15:56, Pavan Chebbi wrote:
> On Thu, Mar 20, 2025 at 8:07 PM Kamil Zaripov <zaripov-kamil@avride.ai> wrote:
>>
>> Hi all,
>>
>> I've encountered a bug in the bnxt_en driver and I am unsure about the correct approach to fix it. Every 2^48 nanoseconds (or roughly 78.19 hours) there is a probability that the hardware timestamp for a sent packet may deviate by either 2^48 nanoseconds less or 2^47 nanoseconds more compared to the actual time.
>>
>> This issue likely occurs within the bnxt_async_event_process function when handling the ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE event. It appears that the payload of this event contains bits 48–63 of the PHC timer counter. During event handling, this function reads bits 0–47 of the same counter to combine them and subsequently updates the cycle_last field within the struct timecounter. The relevant code can be found here:
>> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/broadcom/bnxt/bnxt.c#L2829-L2833
>>
>> The issue arises if bits 48–63 of the PHC counter increment by 1 between sending the ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE event and its actual handling by the driver. In such a case, cycle_last becomes approximately 2^48 nanoseconds behind the real-time value.
>>
>> A possibly related issue involves the BCM57502 network card, which seemingly possesses only a single PHC device. However, the bnxt_en driver creates four PHC Linux devices when operating in quad-port mode. Consequently, clock synchronization daemons like phc2sys attempt to independently synchronize the system clock to each of these four PHC clocks. This scenario can lead to unstable synchronization and might also trigger additional ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE events.
>>
>> Given these issues, I have two questions:
>>
>> 1. Would it be beneficial to modify the bnxt_en driver to create only a single PHC Linux device for network cards that physically have only one PHC?
> 
> It's not clear to me if you are facing this issue when the PHC is
> shared between multiple hosts or if you are running a single host NIC.
> In the cases where a PHC is shared across multiple hosts, the driver
> identifies such a configuration and switches to non-real time PHC
> access mode.
> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/drivers/net/ethernet/broadcom/bnxt?id=85036aee1938d65da4be6ae1bc7e5e7e30b567b9
> If you are using a configuration like the multi host, can you please
> make sure you have this patch?
> 
> Let me know if you are not in the multi-host config. Do post the
> ethtool -i output to help know the firmware version.

AFAIU, the setup is single host, but multi port NIC, which exports
several PTP devices, all of them are using RTC mode. But as HW has 
single physical PHC, it's not possible to properly discipline all
of PTP devices in parallel. I think mlx5 was adjusted to export only
single PHC device for multi-port configuration because of the very same
reasons.


