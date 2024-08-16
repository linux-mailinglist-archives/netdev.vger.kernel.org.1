Return-Path: <netdev+bounces-119101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B7954092
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311522836E1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921B477F2F;
	Fri, 16 Aug 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="GXUJAZWL"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F296F303
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781618; cv=pass; b=iui1fd4TOGTtj/gu6sG9BxoURV6n0K9PbjCo+C5xBMMgXlm2B0FG5xNHM3kDaMKnwwnVeCWvwl15Lj8Am8b72O5rYx5niTeAYpJC8CiRuj05D/ideJATFNJJCQJzEE5Ee9Dnn66PwWea6jsSvTiTCNo+Ps+dBP04eHLYWGBTZ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781618; c=relaxed/simple;
	bh=iUsGJyXj674NiX7cnWAyZEgVTNbjeK2mxa5oooR/4yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI04oE49ZyN+xsdYLXHgLxn6lTsPabD3vu1ydPkDtvNA4D6OT+LFise5lVwgXHwN91SS0IWsP+y6bv21KB0a2wdjP0xMFQKjJyOORKRRQQC+9Y6IxrzbFFeBSPwHBVQsEob0SmFFqCv3yIhr1jCwmPD/pLRiuicWeb4Oud5qToc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=GXUJAZWL; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723781603; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j8K6D4FCPX1mCk5po+iRgvmoIxcSpOH1wEI7sFPAgL7NgtHrdBRSkLncpPjdAzDUox3S/SXHRLV1RDQgjdj3KIeTkmmBvo5+m4HFEMBaac9AX1XI4bE8bQcr7046TQuA/8YZ3rN02eoO7ZxZ7VVas096j4xCNR1YRbCj2y55PWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723781603; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=40/z34dgAer2hdAFHFJmFPVHzhlFT+n/50WygfND6mo=; 
	b=KG5jYLP8PaoN5VbbaUGTUfWphebUPYUDmH16MVNWutrCWJPXzJIAMkYCqTZ9LC0lbKZ080uPFGwbvoizxwALXxqiF1mSFgv7BgNlatPujYiV9yCOMlAfEiGCCzUV+ZfmSyTbRrpzLYvjSsrDzpl+aVZmMGfLTUOyrOkta4cxILE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723781603;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=40/z34dgAer2hdAFHFJmFPVHzhlFT+n/50WygfND6mo=;
	b=GXUJAZWLDtM6JgykMFgyEc93yYHjKNJzNBzaPvHEbHGUO/+vKzHlDE41n9LI4t11
	eh1DnvSQGsdnT5nuvx+PijIN2Ognje41p5a2Wg7uAMArGzs+Do+NsKZCrwS9pUZpK/P
	d2TUlGQB3lCF7zVRK3y0ZNb51BRRTr/spDa9C7+6e+S7LTpIDWhemKBKlzICPcykXzU
	+wtPPhN2ZQfGEur6IlSjAqV7Fl2S+tbIylKb/h4nAH7gNyQJoPZFDxNvdmQvYmjG6Lh
	AXtiEYvOj8YEjuC0ggQq6iBwD0ivb6Bv3/NhpK84HZtN6kyG56LP7G2CZBsvTQL9GdO
	xafN4e7etg==
Received: by mx.zohomail.com with SMTPS id 1723781602864782.4449343686963;
	Thu, 15 Aug 2024 21:13:22 -0700 (PDT)
Message-ID: <8d06b383-03b4-453e-b4f8-f29f68a4bcd0@machnikowski.net>
Date: Fri, 16 Aug 2024 06:13:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] ptp: Add esterror support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
 <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
 <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>
 <21ce3aec-7fd0-4901-bdb0-d782637510d1@lunn.ch>
 <e148e28d-e0d2-4465-962d-7b09a7477910@machnikowski.net>
 <Zr5uV8uLYRQo5qfX@hoboy.vegasvil.org>
 <ed2519db-b3f8-4ab8-9c89-720633100490@machnikowski.net>
 <a1bb18d0-174f-486a-bdfd-295d7c5ce4b2@lunn.ch>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <a1bb18d0-174f-486a-bdfd-295d7c5ce4b2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



On 16/08/2024 01:11, Andrew Lunn wrote:
> On Fri, Aug 16, 2024 at 12:06:51AM +0200, Maciek Machnikowski wrote:
>>
>>
>> On 15/08/2024 23:08, Richard Cochran wrote:
>>> On Thu, Aug 15, 2024 at 05:00:24PM +0200, Maciek Machnikowski wrote:
>>>
>>>> Think about a Time Card
>>>> (https://opencomputeproject.github.io/Time-Appliance-Project/docs/time-card/introduction).
>>>
>>> No, I won't think about that!
>>>
>>> You need to present the technical details in the form of patches.
>>>
>>> Hand-wavey hints don't cut it.
>>>
>>> Thanks,
>>> Richard
>>
>> This implementation addresses 3 use cases:
>>
>> 1. Autonomous devices that synchronize themselves to some external
>> sources (GNSS, NTP, dedicated time sync networks) and have the ability
>> to return the estimated error from the HW or FW loop to users
> 
> So this contradicts what you said earlier, when you said the device
> does not know its own error, it has to be told it.

No - it’s a different type of device.

> So what is user space supposed to do with this error? And given that
> you said it is undefined what this error includes and excludes, how is
> user space supposed to deal with the error in the error? Given how
> poorly this is defined, what is user space supposed to do when the
> device changes the definition of the error?

Esterror returns the last error to the master clock that the device
synchronizes to.
In the case of PPS - is the last error registered on the top of the second.
In the case of PTP - the last error is calculated based on a transaction.

> The message Richard has always given is that those who care about
> errors freeze their kernel and do measurement campaign to determine
> what the real error is and then configure user space to deal with
> it. Does this error value negate the need for this?

AFIR, this comment was relevant to measuring errors coming from delays
inside the system.

>> 2. Multi function devices that may have a single isolated function
>> synchronizing the device clock (by means of PTP, or PPS or any other)
>> and letting other functions access the uncertainty information
> 
> So this is the simple message passing API, which could be implemented
> purely in the core? This sounds like it should be a patch of its own,
> explaining the use case. 

If functions are isolated then there is no path for passing the messages
other than through the device.
The trusted function that can control the clock will push the last error
and control the clock to synchronize it as best as it can, other
functions will get the time from the clock and additional info to
calculate the uncertainty.

>> 3. Create a common interface to read the uncertainty from a device
>> (currently you can use PMC for PTP, but there is no way of receiving
>> that information from ts2phc)
> 
> That sounds like a problem with ts2phc? Please could you expand on why
> the kernel should be involved in feature deficits of user space tools?

Not really. Why would all userspace processes need to understand what
synchronizes the time currently and talk to the relevant tool?
All it cares is what the time is and the primitives for calculating
error boundaries and understand if the clock is synchronized good enough
for a given application.

>> Also this is an RFC to help align work on this functionality across
>> different devices ] and validate if that's the right direction. If it is
>> - there will be a patch series with real drivers returning uncertainty
>> information using that interface. If it's not - I'd like to understand
>> what should I improve in the interface.
> 
> I think you took the wrong approach. You should first state in detail
> the use cases. Then show how you solve each use cases, both the user
> and kernel space parts, and include the needed changes to a real
> device driver.
> 
> 	Andrew

Also there is one more use case I missed in that summary:
4. Device need to consume the information about the uncertainty to act
upon it. This is the case when you want to allow certain features to
work only if error boundaries requirements are met. For example you
don't want to allow launch time to work when the error of the clock is
huge, as your packets will launch precisely at unprecise time.

The current adjtime() API call without any flags can fill the time of
day and the last frequency correction. At the same time, the API's timex
structure consists of many other helpful information that are not
populated for PTP hardware clocks. This information consist of esterror
field which is there since kernel 0.99.13k. I'm not inventing a new API,
just trying to add hooks to implement existing APIs inside the PTP
subsystem.




