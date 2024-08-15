Return-Path: <netdev+bounces-118774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F1952C36
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64AC2849F9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA961C460B;
	Thu, 15 Aug 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="WFFZUUTy"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4319DFB3
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714431; cv=pass; b=eTX8hagUYd45+xpnSsMdjvH3udtipxRo/ShNh74RB4vcYwxd6rRsntDyAfRP1w9yvuLN307UlnH3A+leXWAxA2fDNn0fV3ncbtLUe1GD3G7oGKfDKa7S6qHG/61yoND0UKJflPsZpzJpH1gHEyISf8F/Tg5v5uEEhvwnujhz5t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714431; c=relaxed/simple;
	bh=MAMUDLyxhoX6YF68u4As6WmMHJsZg08QP2rC4LzT25E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bzx3mekBCWayT1XSP4jfZ6t3I2JwAU73BCC8AwREAgeDk+1zCowLU6WaJDBaeYviX1j8iPxgMBPmXx/DyznlsOHNcx8GVIjngpxEPPMv0+DoAl+eZqWi+dMbojpifkhxetyPvxB07/GBw3HPAiANK9NwXyHw1w9L9dbiVDxD85k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=WFFZUUTy; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723714413; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LOvHK9JKNAcjnV/FrrJFjou5faKuueGcFxOp/db9VLO4xb+rv3gGJoRR4xlOqgxinYKoHEboVaQhQVgLaao3lWehopQxGzcO3rYpROfc7WIRJtT9rvktR/QGSceZjpXF7pVkFfmmpXcrFCU3pjqc3DDhLImPUZTpYDgbVfxgSCA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723714413; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ebl/34OFFsLZJwxYx472r7pOWzHGBUWf4Me9cey877g=; 
	b=ANJ1S9gpJ6XORQ/lWIAJ5cFbRozmDy355dWb+byaJO9XVW8c5yTLeAqSb6Z+ArLkPdVZzHrkbyIULKnQ3GFbgb+TiLu6G5QaFm72p3eE88+TGvz34ui9BbqfV88t3NubE3fwXNbTOs+cxiKS6oI2lh+bZKyCNA8JksRdj7dEf1U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723714413;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ebl/34OFFsLZJwxYx472r7pOWzHGBUWf4Me9cey877g=;
	b=WFFZUUTyKVpVuvnNNIutd1Tqo13OaYZoXOp0xKODC+8Abww9NIGDVClv4OcKW6G/
	jCKSK17F+ymiT839sGdIc2wD4ktZLQ+ME6g2heSbLml4PsPd1sP8jVi4S8ZSvZ5QbzE
	9qwYLZvabT1NGM47EQDNQy8FTTfw+7xOKpBUVa+lPg11M2zk9f2tVRRdSBCYFuqmMLX
	IPqQy7VayHG+HFxijKdio1T0Z6PWaNcEbIE9Jcvqc6tbm5+T6VJUv9m8MdvoROUwLqM
	Io1VKsIGn3Rgh1Tdo0pZzqA2jPBesXW0r+qT1gH4wNaL6XTgqVXrK36/wmFlkjoi82h
	scsYFlMD3w==
Received: by mx.zohomail.com with SMTPS id 1723714412010473.22450457857326;
	Thu, 15 Aug 2024 02:33:32 -0700 (PDT)
Message-ID: <a17d3806-73cc-4fda-a1db-c516155982fc@machnikowski.net>
Date: Thu, 15 Aug 2024 11:33:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] ptp: Implement timex esterror support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240813125602.155827-2-maciek@machnikowski.net>
 <1c8a12b5-34b8-445d-900d-f027e58b885b@linux.dev>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <1c8a12b5-34b8-445d-900d-f027e58b885b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



On 14/08/2024 11:29, Vadim Fedorenko wrote:
> On 13/08/2024 13:56, Maciek Machnikowski wrote:
>> !-------------------------------------------------------------------|
>>    This Message Is From an Untrusted Sender
>>    You have not previously corresponded with this sender.
>> |-------------------------------------------------------------------!
>>
>> The Timex structure returned by the clock_adjtime() POSIX API allows
>> the clock to return the estimated error. Implement getesterror
>> and setesterror functions in the ptp_clock_info to enable drivers
>> to interact with the hardware to get the error information.
>>
>> getesterror additionally implements returning hw_ts and sys_ts
>> to enable upper layers to estimate the maximum error of the clock
>> based on the last time of correction. This functionality is not
>> directly implemented in the clock_adjtime and will require
>> a separate interface in the future.
>>
>> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
>> ---
>>   drivers/ptp/ptp_clock.c          | 18 +++++++++++++++++-
>>   include/linux/ptp_clock_kernel.h | 11 +++++++++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
>> index c56cd0f63909..2cb1f6af60ea 100644
>> --- a/drivers/ptp/ptp_clock.c
>> +++ b/drivers/ptp/ptp_clock.c
>> @@ -164,9 +164,25 @@ static int ptp_clock_adjtime(struct posix_clock
>> *pc, struct __kernel_timex *tx)
>>                 err = ops->adjphase(ops, offset);
>>           }
>> +    } else if (tx->modes & ADJ_ESTERROR) {
>> +        if (ops->setesterror)
>> +            if (tx->modes & ADJ_NANO)
>> +                err = ops->setesterror(ops, tx->esterror * 1000);
> 
> Looks like some miscoding here. The callback doc later says that
> setesterror expects nanoseconds. ADJ_NANO switches the structure to
> provide nanoseconds. But the code here expects tx->esterror to be in
> microseconds when ADJ_NANO is set, which is confusing.
> 
>> +            else
>> +                err = ops->setesterror(ops, tx->esterror);
>>       } else if (tx->modes == 0) {
>> +        long esterror;
>> +
>>           tx->freq = ptp->dialed_frequency;
>> -        err = 0;
>> +        if (ops->getesterror) {
>> +            err = ops->getesterror(ops, &esterror, NULL, NULL);
>> +            if (err)
>> +                return err;
>> +            tx->modes &= ADJ_NANO;
> 
> Here all the flags except possible ADJ_NANO is cleaned, but why?
> 
>> +            tx->esterror = esterror
> And here it doesn't matter what is set in flags, you return nanoseconds
> directly...
> 
You're right - seems I made an inverted logic. The PTP API should work
on nanoseconds and the layer above should convert different units to
nanoseconds.

>> +        } else {
>> +            err = 0;
>> +        }
>>       }
>>         return err;
>> diff --git a/include/linux/ptp_clock_kernel.h
>> b/include/linux/ptp_clock_kernel.h
>> index 6e4b8206c7d0..e78ea81fc4cf 100644
>> --- a/include/linux/ptp_clock_kernel.h
>> +++ b/include/linux/ptp_clock_kernel.h
>> @@ -136,6 +136,14 @@ struct ptp_system_timestamp {
>>    *                   parameter cts: Contains timestamp
>> (device,system) pair,
>>    *                   where system time is realtime and monotonic.
>>    *
>> + * @getesterror: Reads the current error estimate of the hardware clock.
>> + *               parameter phase: Holds the error estimate in
>> nanoseconds.
>> + *               parameter hw_ts: If not NULL, holds the timestamp of
>> the hardware clock.
>> + *               parameter sw_ts: If not NULL, holds the timestamp of
>> the CPU clock.
>> + *
>> + * @setesterror:  Set the error estimate of the hardware clock.
>> + *                parameter phase: Desired error estimate in
>> nanoseconds.
>> + *
> 
> The man pages says that esterror is in microseconds. It makes total
> sense to make it nanoseconds, but we have to adjust the documentation.
> 
>>    * @enable:   Request driver to enable or disable an ancillary feature.
>>    *            parameter request: Desired resource to enable or disable.
>>    *            parameter on: Caller passes one to enable or zero to
>> disable.
>> @@ -188,6 +196,9 @@ struct ptp_clock_info {
>>                   struct ptp_system_timestamp *sts);
>>       int (*getcrosscycles)(struct ptp_clock_info *ptp,
>>                     struct system_device_crosststamp *cts);
>> +    int (*getesterror)(struct ptp_clock_info *ptp, long *phase,
>> +               struct timespec64 *hw_ts, struct timespec64 *sys_ts);
>> +    int (*setesterror)(struct ptp_clock_info *ptp, long phase);
>>       int (*enable)(struct ptp_clock_info *ptp,
>>                 struct ptp_clock_request *request, int on);
>>       int (*verify)(struct ptp_clock_info *ptp, unsigned int pin,
> 

