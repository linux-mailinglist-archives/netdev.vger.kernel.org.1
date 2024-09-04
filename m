Return-Path: <netdev+bounces-125286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C3F96CA93
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FDD1C22036
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360C15573D;
	Wed,  4 Sep 2024 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+IR1XPH"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703C154458
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725489775; cv=none; b=R3evKIJGABFxhyFJzpqPlyirikVcradrqiQ1ybvAUTwbChXOEI7oaU2sxOv1Y6lam3vUxeppZslPwU2Ao8sK23Zyz3xubAaYYTt9jXcNo0AYD9HHJXmyRUaw7AFCAlN/KcNB0wXCqDbUjjbekrDMZ8f6oM0YJuMdMinokKVjmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725489775; c=relaxed/simple;
	bh=CV0ra41zlhxf/TSdicMokwLOUzkAKiAPUfKjD3v872w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGdyxno4dPltvP/KZw9SfMiSTGiU5AZ7fxm6Jpg8GadmvPASLwZOQaoLXXjmAvgvE506jjI19FWLJeS+3Rpsa3EyaeZNKJ00etnqDAxPL1HXLe7EEjKz00YbGE82AmPx40KIqc6su0EgDfMzux8mRzM2zqAYdHN/pf5U6Pc8Q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+IR1XPH; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef733d84-3e44-49b9-a7ef-a8c4ff1eca65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725489771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfllydcGdf9mqGWGqPnRPDpuxHyv6je0aZDZtvNoF4U=;
	b=d+IR1XPHsAqdjnh7VZvLII+Slq3nkHkLadlUKCgFHld9Xlg2lAVVRlXh8tH+B+RnO39UI2
	5RE8XfdTx6FJuxrS1KHHWE10jp8Ttlkm4xPFuWgWcvVmv39q0isQIfNBC/f6B/rwet6DrQ
	qbnoEBitWnV1VVLOPxc83w7VLBYPSI4=
Date: Wed, 4 Sep 2024 23:42:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ptp: ocp: Improve PCIe delay estimation
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240904132842.559217-1-vadim.fedorenko@linux.dev>
 <20240904202035.GF1722938@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240904202035.GF1722938@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 21:20, Simon Horman wrote:
> On Wed, Sep 04, 2024 at 01:28:42PM +0000, Vadim Fedorenko wrote:
>> The PCIe bus can be pretty busy during boot and probe function can
>> see excessive delays. Let's find the minimal value out of several
>> tests and use it as estimated value.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/ptp/ptp_ocp.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>> index e7479b9b90cb..22b22e605781 100644
>> --- a/drivers/ptp/ptp_ocp.c
>> +++ b/drivers/ptp/ptp_ocp.c
>> @@ -1561,19 +1561,22 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>>   	ktime_t start, end;
>>   	ktime_t delay;
>>   	u32 ctrl;
>> +	int i;
>>   
>> -	ctrl = ioread32(&bp->reg->ctrl);
>> -	ctrl = OCP_CTRL_READ_TIME_REQ | OCP_CTRL_ENABLE;
>> +	for (i = 0; i < 3; i++) {
>> +		ctrl = ioread32(&bp->reg->ctrl);
>> +		ctrl = OCP_CTRL_READ_TIME_REQ | OCP_CTRL_ENABLE;
>>   
>> -	iowrite32(ctrl, &bp->reg->ctrl);
>> +		iowrite32(ctrl, &bp->reg->ctrl);
>>   
>> -	start = ktime_get_ns();
>> +		start = ktime_get_ns();
>>   
>> -	ctrl = ioread32(&bp->reg->ctrl);
>> +		ctrl = ioread32(&bp->reg->ctrl);
>>   
>> -	end = ktime_get_ns();
>> +		end = ktime_get_ns();
>>   
>> -	delay = end - start;
>> +		delay = min(delay, end - start);
> 
> Hi Vadim,
> 
> It looks like delay is used uninitialised here
> in the first iteration of this loop.
> 
> Flagged by Smatch.

Oh, yes, you are right, Simon. I'll send v2 with INT_MAX init for delay.

Thanks!

> 
>> +	}
>>   	bp->ts_window_adjust = (delay >> 5) * 3;
>>   }
>>   
>> -- 
>> 2.43.0
>>
>>


