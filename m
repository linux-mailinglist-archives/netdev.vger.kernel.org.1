Return-Path: <netdev+bounces-160614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4BA1A8AA
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 18:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6364A16EC8B
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D2212FA2;
	Thu, 23 Jan 2025 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN8FZbNo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B114F9ED;
	Thu, 23 Jan 2025 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652290; cv=none; b=nrsYgOy8NoAVCYkDx4fwsZum+BY0pqKVwSHpwy18Egztgbv4O+Xyll05PCrixSzXcIKIdXbZeg7xSP03Qn0YCXn2C78eMp3C6VqQx18cKu3aTTnfNDwEFCmiUdlzvsXWQ0NcRAplI97+2h9p2lUy9+4LE0xKugIjPZl63TsnIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652290; c=relaxed/simple;
	bh=wwHq81T/WLT7lNSRxgnE+T72GZ2Z2l7QlqYiCMc611s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRCWrXQErq+Lfre5nsrEBWGdnBagKwwzkQqx9RtuWT5+YG9eplvpUwc2VIngCs9Sf/xPAyZ13wGWN2hEQ6ez6LeSJ7WYFUi1tKjBdd379GrIbsaAAaflLtN5abiUwfejDfJyXJP3JG2WxmTHyTHhUx2/ono3DUlqJzOptj/1lTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN8FZbNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F66C4CEE0;
	Thu, 23 Jan 2025 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737652290;
	bh=wwHq81T/WLT7lNSRxgnE+T72GZ2Z2l7QlqYiCMc611s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uN8FZbNoS9yGk0kseafixXenHfT3tHI12YCYMXQP2gJF81DQ57rp7AxFKCEJM4lDz
	 NnLprIrS4mezyBo7aR48cd+7fkbgMeuKCwDO+MuX+qpS1sS3QA33HkMQcMNyiAaJD2
	 DYWukaWUmQyCryxXinFW5eWn4KhH8ZGG2+yOPe5QzozbUhqkHu4JACRSwo3lrckbOi
	 isPF/qxJDmMWaNpQhsZctbEU3UtgqdM3JFwA1gnOZJud1MCBTlabBzd3jpOuAw5cMA
	 VzhQ8yD+O0nEjxXnU4emuY44MIuN3tnbn89noEy9ZApFvqlvch1t7gl3O++Mox76VN
	 bTdvqqNWpyn8A==
Message-ID: <426d4476-e3b4-4a95-84a1-850015651ee6@kernel.org>
Date: Thu, 23 Jan 2025 18:11:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Andrea Righi <arighi@nvidia.com>
References: <20250109182953.2752717-1-kuba@kernel.org>
 <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
 <20250116193821.2e12e728@kernel.org> <Z4uwbqAwKvR4_24t@arm.com>
 <Z45i4YT1YRccf4dH@arm.com> <20250120094547.202f4718@kernel.org>
 <Z4-AYDvWNaUo-ZQ7@arm.com> <20250121074218.52ce108b@kernel.org>
 <Z5AHlDLU6I8zh71D@arm.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <Z5AHlDLU6I8zh71D@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Catalin,

(+ cc Andrea)

On 21/01/2025 21:46, Catalin Marinas wrote:
> On Tue, Jan 21, 2025 at 07:42:18AM -0800, Jakub Kicinski wrote:
>> On Tue, 21 Jan 2025 11:09:20 +0000 Catalin Marinas wrote:
>>>>> Hmm, I don't think this would make any difference as kmemleak does scan
>>>>> the memblock allocations as long as they have a correspondent VA in the
>>>>> linear map.
>>>>>
>>>>> BTW, is NUMA enabled or disabled in your .config?  
>>>>
>>>> It's pretty much kernel/configs/debug.config, with virtme-ng, booted
>>>> with 4 CPUs. LMK if you can't repro with that, I can provide exact
>>>> cmdline.  
>>>
>>> Please do. I haven't tried to reproduce it yet on x86 as I don't have
>>> any non-arm hardware around. It did not trigger on arm64. I think
>>> virtme-ng may work with qemu. Anyway, I'll be off from tomorrow until
>>> the end of the week, so more likely to try it next week.
>>
>> vng -b -f tools/testing/selftests/net/config -f kernel/configs/debug.config
>>
>> vng -r arch/x86_64/boot/bzImage --cpus 4 --user root -v --network loop
> 
> Great, thanks. I managed to reproduce it

Thank you for investigating this issue!

Please note that on our side with MPTCP, I can only reproduce this issue
locally, but not from our CI on GitHub Actions. The main difference is
the kernel (6.8 on the CI, 6.12 here) and the fact our CI is launching
virtme-ng from a VM. The rest should be the same.

> (after hacking vng to allow x86_64 as non-host architecture).

Do not hesitate to report this issue + hack on vng's bug tracker :)

  https://github.com/arighi/virtme-ng/issues/new

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


