Return-Path: <netdev+bounces-69760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E5284C7CB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD2B2851A9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A901D552;
	Wed,  7 Feb 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAEnpwTS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070A22F0F;
	Wed,  7 Feb 2024 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299058; cv=none; b=SNOPl4SVMcUEe3AWBv82hbiABmF/vj5WyBZS3Gr2cp5h+RcFKL7brGwOX36qBqyIGyQQnKMqtC4CNa4YbjmdpA79jOsMM+nJHC5yiJ6W2ClmTF8vcao5yH0rj+G9VWF48iRJCXfEUqcmJLB4PLd/KcDD+6getnXkLLCcrd9D5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299058; c=relaxed/simple;
	bh=7jNVCpwsgDiNmVx1fmu5d69kDGlgYIBfl2P0AQQ4F8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJHQEkWtNIutn7N1QPM3P96eSQFKt/lNqTOU7kbD7Wak8pGkoCykNqJYA1whAJpa69QmHc1mkdHDjYhepWT5KdeNABHkxKkI8C9jZc738ss7O6cbboWtWRnmSRloPiEmkdKkcW2uVFzEsMf1fkB2xS848lyB700CXVAMzXNT06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAEnpwTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF5BC433C7;
	Wed,  7 Feb 2024 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299058;
	bh=7jNVCpwsgDiNmVx1fmu5d69kDGlgYIBfl2P0AQQ4F8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NAEnpwTSwi+zsvpyJk0dLAFnMNQ4LfCyIxrq/SO+SrjcXHHrVnM0NM/4Z35rvrSvU
	 bMLI/lx4iTxLJPTWfHsivHxivOrT1c7uyIfrIFYT4HgNq2XbMn4k9SKoR8szhfv2a+
	 uu97y2EE/DVXaIi0T10qOhBU88vOvWKFj0tN9lwO1JFBx0Uu9pm+IWqpKPUoD0gzHh
	 m/TR2oTRoYJQL+ko82EY7H1wW08bbbTCBlD5S4QS4+SHc6bmRc5xxxB4ptAiNfKC1+
	 5sNuDoKMwCec6lbUwYY/uOMXtLWtIT0FXpbLFVwNjX7UeXVJN0O8JMylHQ+VEC+d++
	 3bw29Bw2/tTcw==
Message-ID: <2d0eb4ef-dd07-4800-8fcf-637a924570fa@kernel.org>
Date: Wed, 7 Feb 2024 10:44:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] The no-kvm CI instances going away
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <martineau@kernel.org>
References: <20240205174136.6056d596@kernel.org>
 <f6437533-b0c9-422b-af00-fb8a236b1956@kernel.org>
 <20240206174407.36ca59c4@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240206174407.36ca59c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 07/02/2024 02:44, Jakub Kicinski wrote:
> On Tue, 6 Feb 2024 12:16:43 +0100 Matthieu Baerts wrote:
>> Hi Jakub,
>>
>> On 06/02/2024 02:41, Jakub Kicinski wrote:
>>> because cloud computing is expensive I'm shutting down the instances
>>> which were running without KVM support. We're left with the KVM-enabled
>>> instances only (metal) - one normal and one with debug configs enabled.  
>>
>> Thank you for the notification!
>>
>> It sounds like good news if the non-support of KVM was causing issues :)
>>
>> I think we can then no longer ignore the two MPTCP tests that were
>> unstable in the previous environment.
>>
>> The results from the different tests running on the -dbg instances don't
>> look good. Maybe some debug kconfig have a too big impact? [1]
> 
> Sorry, I'm behind on the reading the list. FWIW if you want to reach me
> quickly make sure the To: doesn't include anyone else. That gets sorted
> to a higher prio folder :S

Sorry, there was no urgency, I only wanted to add a link to the previous
discussion for those who wanted more details about that.

Thank you for the note!

>> For MPTCP, one test always hits the selftest timeout [2] when using a
>> debug kconfig. I don't know what to do in this case: if we need to set a
>> timeout value that is supported by debug environments, the value will be
>> so high, it will no longer catch issues "early enough" in "normal"
>> environments.
>> Or could it be possible to ignore or double the timeout value in this
>> debug environment?
>>
>> Also, what is the plan with this debug env? It looks like the results
>> are not reported to patchwork for the moment. Maybe only "important"
>> issues, like kernel warnings, could be reported? Failed tests could be
>> reported as "Warning" instead of "Fail"?
> 
> Unfortunately I'm really behind on my "real job". I don't have a clear
> plan. I think we should scale the timeout by 2x or so, but I haven't
> looked how to do that.

No hurry, I understand.

It is not clear to me how the patches you add on top of the ones from
patchwork are managed. Then, I don't know if it can help, but on the
debug instance, this command could be launched before starting the tests
to double the timeout values in all the "net" selftests:

  $ find tools/testing/selftests/net -name settings -print0 | xargs -0 \
       awk -i inplace -F '=' \
           '{if ($1 == "timeout") { print $1 "=" $2*2 } else { print }}'

> I wish the selftest subsystem had some basic guidance.

Me too :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

