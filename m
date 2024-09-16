Return-Path: <netdev+bounces-128568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86197A5DD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6216B2C403
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429B23746;
	Mon, 16 Sep 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QKsIEDMr"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFE18B1A
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503331; cv=none; b=c1xGoBOpa5THGeGcyV9JB1bUoiJZ4G+biJQ7HQmSSLyn+FEe6Eg/9cvrLDIYK1mLttAzjXpevb5XkvA/sHuImEFbRcjyHz3mr3vnotQAdgvNCg3jwI1y1/mBHqjlLHbHqSJw+GkuMz59QjzALZeqhPG7eZE6BjC+1aVdaPVd7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503331; c=relaxed/simple;
	bh=1pMBZe3CZS7KCVlHuAKU0Q0Vubg12C2rCijxOKy/0tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swhGordXiyPfJFfPZGIQIxAFKsIu5zDAnZYKg8Nm3StwrTcZXGV4rdLW7OxXSnm+BMpSQCdttfRuAbJeqhB/315oG6ZNkmSTaYzCABsAgh/sWfoxtd/4PtOMWAxesSMrSGEhbWPPA2lULZExDmC46aFa6YIc26maailzQrRC5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QKsIEDMr; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A8AE73C006A;
	Mon, 16 Sep 2024 16:15:20 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.35.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 96CC213C2B0;
	Mon, 16 Sep 2024 09:15:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 96CC213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1726503317;
	bh=1pMBZe3CZS7KCVlHuAKU0Q0Vubg12C2rCijxOKy/0tA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QKsIEDMr7J/Hj/q126qbAO5c4q9Q4S/LCGsUCRjUV8zK2X0e/vuCpmdhOHj3kYt/5
	 q87fVuyCSxmIJPYe4l5UjGz4RHYxA3QMTtl5b16tHW0v+GygbVhvGzSbnEJjnq71EX
	 kPTZkGftIxcNwJOdWrO+APArk7o1s8YCXrWmsPCM=
Message-ID: <66479f9e-fd0b-41d0-b7b8-07a336c3341b@candelatech.com>
Date: Mon, 16 Sep 2024 09:15:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tcp_ack __list_del crash in 6.10.3+ hacks
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jan Glaza <jan.glaza@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 netdev <netdev@vger.kernel.org>
References: <9ac75ea7-84de-477c-b586-5115ce844dc7@candelatech.com>
 <b833aea6-b499-4b9c-90fe-aab31510544d@intel.com>
 <3547078e-acdf-4189-9a1d-98f581896706@intel.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <3547078e-acdf-4189-9a1d-98f581896706@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1726503321-V6bNT80edoyE
X-MDID-O:
 us5;at1;1726503321;V6bNT80edoyE;<greearb@candelatech.com>;8dc78dbb4e7cf902f842fac31f92f42e

On 9/16/24 04:09, Przemek Kitszel wrote:
> On 9/16/24 12:32, Przemek Kitszel wrote:
>> On 9/14/24 07:27, Ben Greear wrote:
>>> Hello,
>>>
>>> We found this during a long duration network test where we are using
>>> lots of wifi network devices in a single system, talking with
>>
>> It will be really hard to repro for us. Still would like to help.

We also have trouble reproducing this.  Thanks for suggestions on
debugging tips below...we'll try to get some better debugging
to share (on stock kernels).

>>
>>> an intel 10g
>>
>> It's more likely to get Intel's help if you mail (also) to our IWL list
>> (CCed, +Aleksandr for ixgbe expertise).
>>
>>
>>> NIC in the same system (using vrfs and such).  The system ran around
>>> 7 hours before it crashed.  Seems to be a null pointer in a list, but
>>> I'm not having great luck understanding where exactly in the large tcp_ack
>>> method this is happening.  Any suggestions for how to get more relevant
>>> info out of gdb?
> 
> I would also enable kmemleak, lockdep, ubsan to get some easy helpers.
> 
>>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000008^M
>>> #PF: supervisor write access in kernel mode^M
> 
> could you share your virtualization config?

We are using vrf for each of the network devices.  We're using mac-vlans
and 12 intel ax210 as well, though I need to verify the netdevs to make sure I'm
not confusing it with a second mostly unrelated problem we are tracking.

>>> #PF: error_code(0x0002) - not-present page^M
>>> PGD 115855067 P4D 115855067 PUD 283ed3067 PMD 0 ^M
>>> Oops: Oops: 0002 [#1] PREEMPT SMP^M
>>> CPU: 6 PID: 115673 Comm: btserver Tainted: G           O       6.10.3+ 
> 
> so, what hacks do you have? those are to aid debugging or to enable some
> of the wifi devices?

Great piles of wifi related hacks mostly.

> I don't have any insightful comment unfortunately, sorry.

We are able to reproduce on upstream 6.11.0 as well.  Or, we reproduced a soft-lockup
at least.  We are trying again now with lockdep and list debugging and some other
debugging enabled.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


