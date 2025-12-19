Return-Path: <netdev+bounces-245511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F7CCF79E
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 11:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C684630B8610
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A83301012;
	Fri, 19 Dec 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7bqolvB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EF2EC541;
	Fri, 19 Dec 2025 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141326; cv=none; b=PfUp8feIqYgbMPyKfW16U+sTGE5z1eKabEUJWdQ+iQ+YFDN1imYSNlJQ3+t6ku7U8a9wUscowpcptMJzU9qURCfSpIqTKj77ze2K+hCY7u5AGti9+P22+JFxdscqFjXukYrBcf4hWTfRd+GdtxFryy6IImlBHcgIteezJ+roVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141326; c=relaxed/simple;
	bh=YjLoTYKDjQc7ykxQOyqOUVAmPo1a4U7SoiPnS819chY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laYrgEIlbJeQFqQ1Eha/tkUIMFbLwiHzevx3YTqXFCrG8f3PpSEvkibFuToFXuXjyjIPeTAxY7KPN2yjDQiq2osMO7SDMneYK96jWvHmj6yHqjEQ1nE7bfZNEVQ20Iz/AYdDX6V5Bn0gFl542enVhBC1lvIl7VCAmLki5nd72Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7bqolvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61349C4CEF1;
	Fri, 19 Dec 2025 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766141325;
	bh=YjLoTYKDjQc7ykxQOyqOUVAmPo1a4U7SoiPnS819chY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L7bqolvBFOR101dxP5KRLI3a89z2sYRaD5NMDs6Ftuij/N0gZwi4QNAdCHeojZTnS
	 sTmw64BxfL5fRcmcwE0zNkijE6ByCan7iAD/1xcIEITD9mANijFwiu6u4vqpCvBmdx
	 rVhNGqtC3jylNs9DFq/plyoUdZN6FTZ9+Du71noT/eH0gK7qafW3x9wk2b66h1QmFU
	 iHh8MIDUnindvn/xXUhcuigCG4S2n7szUwb9sjTlMSO4EFH89QNRR+Vpz3uEOG5TRA
	 AIiZ2NmPwbFxNkh03fN6c4S2gDllgUQR+Es2ZssCD5m0x4BgFYlPkruIu6nqAfp3Rr
	 aU7NU187DIl/g==
Message-ID: <96b827e5-d8b7-4e0d-b5a8-1729f5177134@kernel.org>
Date: Fri, 19 Dec 2025 11:48:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/44] net/mptcp: Change some dubious min_t(int, ...) to
 min()
Content-Language: en-GB, fr-BE
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-45-david.laight.linux@gmail.com>
 <cd5d45f7-0d76-4f82-849e-2f2c1544d907@kernel.org>
 <20251218201517.2f2d91d4@pumpkin>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251218201517.2f2d91d4@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

Thank you for your reply!

On 18/12/2025 21:15, David Laight wrote:
> On Thu, 18 Dec 2025 18:33:26 +0100
> Matthieu Baerts <matttbe@kernel.org> wrote:
> 
>> Hi David,
>>
>> On 19/11/2025 23:41, david.laight.linux@gmail.com wrote:
>>> From: David Laight <david.laight.linux@gmail.com>
>>>
>>> There are two:
>>> 	min_t(int, xxx, mptcp_wnd_end(msk) - msk->snd_nxt);
>>> Both mptcp_wnd_end(msk) and msk->snd_nxt are u64, their difference
>>> (aka the window size) might be limited to 32 bits - but that isn't
>>> knowable from this code.
>>> So checks being added to min_t() detect the potential discard of
>>> significant bits.
>>>
>>> Provided the 'avail_size' and return of mptcp_check_allowed_size()
>>> are changed to an unsigned type (size_t matches the type the caller
>>> uses) both min_t() can be changed to min().  
>>
>> Thank you for the patch!
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> I'm not sure what the status on your side: I don't know if you still
>> plan to send a specific series for all the modifications in the net, but
>> just in case, I just applied your patch in the MPTCP tree. I removed the
>> "net/" prefix from the subject. I will send this patch with others for
>> including in the net-next tree later on if you didn't do that in between.
> 
> I'll go through them again at some point.

Great, thank you!

> I'll check against 'next' (but probably not net-next).

net-next is in linux-next, so that should be fine.

> I actually need to look at the ones that seemed like real bugs when I
> did an allmodconfig build - that got to over 200 patches to get 'clean'.
> 
> It would be nice to get rid of a lot of the min_t(), but I might try
> to attack the dubious ones rather than the ones that appear to make
> no difference.
> 
> I might propose some extra checks in minmax.h that would break W=1 builds.
> Detecting things like min_t(u8, u32_value, 0xff) where the cast makes the
> comparison always succeed.
> In reality any calls with casts to u8 and u16 are 'dubious'.
> 
> That and changing checkpatch.pl to not suggest min_t() at all, and
> to reject the more dubious uses.
> After all with:
> 	min(x, (int)y)
> it is clear to the reader that 'y' is being possibly truncated and converted
> to a signed value, but with:
> 	min_t(int, x, y)
> you don't know which value needed the cast (and the line isn't even shorter).
> But what I've found all to often is actually:
> 	a = min_t(typeof(a), x, y);
> and the similar:
> 	x = min_t(typeof(x), x, y);
> where the type of the result is used and high bits get discarded.

Good idea to add extra checks and prevent future issues!
> I've just been trying to build with #define clamp_val clamp.
> That requires a few minor changes and I'm pretty sure shows up
> a real bug.

Thank you for looking at that!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


