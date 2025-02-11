Return-Path: <netdev+bounces-165117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D91A30862
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D123A33D8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528431F3FD1;
	Tue, 11 Feb 2025 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiPQFCgq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A131F153C;
	Tue, 11 Feb 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269299; cv=none; b=F9/T1cYyd8AqCh0qYJMqHc/V0wC/J59pwtUZeEQ1YF/41kXpzOvV/rAJMZ+fEqM2qkqWiNSz2+Fqcp2oMeGm5Edt3RnNd02FlH9nlTcR4LffplUswVssRB7QNzMB/hhfW0ODVNlIkhzsrs2csdtxGeOKhqGtHj91Tk822TPTZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269299; c=relaxed/simple;
	bh=wAPzJE8RAM+7E5HC0zN2qLr8w7qErCbAccrj8j8QaaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RShd8uxZj5w+GHCuczNsHJZWqDB4VQstrDACKE2hB2HBu0ERR4DXLDbaM5MglPx2+vEtBa70G/v0h/gLzJdsHY7uJAb/QO1+vmVAkGgzxIl9kEnTmUeQ4yrJiEpTNYr2X16Uny0ZXzWZbjHRRVSpqQmrWpgzf3kdaUA41IRUJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiPQFCgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFC0C4CEE4;
	Tue, 11 Feb 2025 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739269298;
	bh=wAPzJE8RAM+7E5HC0zN2qLr8w7qErCbAccrj8j8QaaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PiPQFCgq08iCUkDKlivxpQp6zWuBrv8CpjcE4WTulY6ZdL+ImsJVlC50VFOUlzKMB
	 cAJdWy/eeA+/p+PB9e0a7NnXD9rJJuUES6oRaBI3kmeOBptq9jq1Ll2o/s0TBu6mP6
	 UcW/gSMmHjpxEnPh5jybOU4smzuraDa49qnQvYuJRemjSr+16F90d/FvX04kZJ86A1
	 Rgy0IJq9LSNH59K0FZnXMxSCBntF9uZLmcSL952UizFIUr5U0ibAUHXE04U94OZfyY
	 XZKdt7GktlNclZYQs7eSxPoHnW9yQHAX+esHbWYLPC+kGc73dXIa+JB84BXpBMNStt
	 aSMxgmIASKaVA==
Message-ID: <8b3eb0ea-3c8f-43ee-b756-21ea570c6ea0@kernel.org>
Date: Tue, 11 Feb 2025 11:21:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3 01/15] mptcp: pm: drop info of
 userspace_pm_remove_id_zero_address
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-1-71753ed957de@kernel.org>
 <20250210194934.GO554665@kernel.org>
 <adeff1d6-f80b-4a2c-b4bb-da44ecd5b747@kernel.org>
 <20250211101315.GJ554665@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250211101315.GJ554665@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 11:13, Simon Horman wrote:
> On Tue, Feb 11, 2025 at 10:31:05AM +0100, Matthieu Baerts wrote:
>> Hi Simon,
>>
>> On 10/02/2025 20:49, Simon Horman wrote:
>>> On Fri, Feb 07, 2025 at 02:59:19PM +0100, Matthieu Baerts (NGI0) wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> The only use of 'info' parameter of userspace_pm_remove_id_zero_address()
>>>> is to set an error message into it.
>>>>
>>>> Plus, this helper will only fail when it cannot find any subflows with a
>>>> local address ID 0.
>>>>
>>>> This patch drops this parameter and sets the error message where this
>>>> function is called in mptcp_pm_nl_remove_doit().
>>>>
>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>
>> Thank you for the review, and this message!
>>
>>> A minor nit, perhaps it has been discussed before:
>>>
>>> I'm not sure that your Reviewed-by is needed if you also provide
>>> your Signed-off-by. Because it I think that the latter implies the former.
>>
>> This has been discussed a while ago, but only on the MPTCP list I think.
>> To be honest, we didn't find a precise answer in the doc [1], and maybe
>> we are doing it wrong for all this time :)
>>
>> Technically, when someone shares a patch on the MPTCP ML, someone else
>> does the review, sent the "Reviewed-by" tag, then the patch is queued,
>> and the one sending the patch to the netdev ML adds a "Signed-off-by"
>> tag. With this patch here, I did both.
>>
>> Before, we were removing the RvB tag when it was the same as the SoB
>> one, but we stopped doing that because we thought that was not correct
>> and / or not needed. We can re-introduce this if preferred. My
>> understanding is that the SoB tag is for the authors and the
>> intermediate maintainers -- who might have not done a full review --
>> while the RvB one seems to indicate that a "proper" review has been
>> done. If someone else does a review on a patch, I can add my SoB tag
>> when "forwarding" the patch, trusting the review done by someone else.
>>
>> Do you think it is better to remove the RvB tag if there is a SoB one
>> for the same person?
>>
>> [1] https://docs.kernel.org/process/submitting-patches.html
> 
> Hi Mat,
> 
> Thanks for the explanation. I see that in your process the Reviewed-by
> and Signed-off-by have distinct meanings. Which does make sense.
> 
> I'm ambivalent regarding which way to go (sorry that isn't very helpful).
> But I do suspect I won't be the last person to ask about this.

That's OK, now I have a canned reply ready to be sent for that :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


