Return-Path: <netdev+bounces-172980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A058CA56B01
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79B67A5B50
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057821C9E3;
	Fri,  7 Mar 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aq0.de header.i=@aq0.de header.b="UX9ZEvlV"
X-Original-To: netdev@vger.kernel.org
Received: from mail.aq0.de (mail.aq0.de [168.119.229.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095A21B1BC
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.229.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359604; cv=none; b=G2byAOYy+FGt/9zsD1Mx0LbTzmm7rRh5Vqea0owYHfSuOCw5bFafYyhSp/Z492T9YriMcKTFTAcHvA13NfIyiK6RVEvTeU/qP9uy3n3ZUoQb+9akqKdMsCHPb7JQiP1YQ1lZh8OYNhA2I7y1S4NUUA8ZpOrRx2dLbEzoNioTKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359604; c=relaxed/simple;
	bh=7JhqMB3jPHY0d8os7MJjR5o2DK8mUmR4TkTYjTl175I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bd7LzLiDV+zhPL6pbZl+yZvbjsm0QbhgMr1F1f5cdtSvjsy/+uE6NRrYzm3KcdEsvO3B9U3gRUUnN6s436+tj1Na7n7ez/nXxyIBlnRT9igMIwkVcW1qj/Rc5tXRA/9hQUITIpyQqaS2KOkrmr6eBQcQLnmixkQr8TJ7PbkTzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aq0.de; spf=pass smtp.mailfrom=aq0.de; dkim=pass (1024-bit key) header.d=aq0.de header.i=@aq0.de header.b=UX9ZEvlV; arc=none smtp.client-ip=168.119.229.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aq0.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aq0.de
Message-ID: <2f2ba7b1-f923-4eb7-b90a-1cfa4d5c2f8d@aq0.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aq0.de; s=mail;
	t=1741359600; bh=Fhy30rZoqFM13kWpIpOj++rp74qs8rWyosYRLmkPNMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UX9ZEvlVAScYjei679dVu/CJ1x9wBA7KWbw0JrDYAcGpxky1zdNwWbltlvqBIHlz6
	 VkzoDQylg4PwC+k9d1UQUZdqZYNL13Sl9R/7/9U+s71vJio00Q4xD700L9McsB5kog
	 2Ir9kN0tT/zXZCV5U/2zwTjzowSPWMNn/FlCTVbo=
Date: Fri, 7 Mar 2025 15:59:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: liquidio: fix typo
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org
References: <20250304181651.1123778-2-janik@aq0.de>
 <20250306122248.GA3666230@kernel.org>
Content-Language: en-US
From: Janik Haag <janik@aq0.de>
In-Reply-To: <20250306122248.GA3666230@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Simon,

I just submitted a v2 version of the patch, like you asked me to.
Thanks for the kind review and enjoy your weekend!

With kind regards,
Janik Haag

On 06.03.25 13:22, Simon Horman wrote:
> On Tue, Mar 04, 2025 at 07:16:52PM +0100, Janik Haag wrote:
>> Dear Linux maintainers, this is my first patch, hope everything is
>> correct.
>>
>> While reading through some pcie realted code I notice this small
>> spelling mistake of doorbell registers.
>> I added Dave in the TO field since they signed-off on by far the most
>> commits touching this file.
>>
>> With kind regards,
>> Janik Haag
>>
>> Signed-off-by: Janik Haag <janik@aq0.de>
>> ---
>>   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Hi Jainik,
>
> Thanks for your patch.
> It looks good, but I think we can make it better.
>
>
> Firstly, it's normal practice to describe your patch in the patch
> description, which is the bit above the scissors ("---") and add any notes
> below. Something like this.
>
>    Subject: net: liquidio: fix typo
>
>    Correct spelling of doorbells.
>
>    Found by inspection
>
>    Signed-of-by: ...
>    ---
>
>    Dear Linux Maintainers,
>
>    ...
>
> Secondly, as this is a non-bug-fix for Networking code it is for the
> net-next tree. It is preferable to note that net-next is the target
> tree in the subject, like this:
>
>    Subject: [PATCH net-next] net: liquidio: fix typo
>
> Last, I do see that codespell flags some other spelling errors in
> this file: "corressponding", "cant", and "Fomat".
> Perhaps they can be fixed at the same time?
>
>
> Could you consider posting a v2 patch, as a new thread, which
> addresses the above? The subject should be something like this:
>
>    Subject: [PATCH net-next v2] net: liquidio: fix typo
>
> As an aside, the b4 tool can be helpful for managing patch revisions.
>
> More information on Netdev process can be found here;
> https://docs.kernel.org/process/maintainer-netdev.html
>
> ...
>

