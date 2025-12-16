Return-Path: <netdev+bounces-244871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D90CC0922
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C991F3023790
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 02:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3132D8DA8;
	Tue, 16 Dec 2025 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ibSCGHiN"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEDA2641CA
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765850881; cv=none; b=Iy+d1nh/QidalHZaM16mDYqcEVWrnhgP84hfJIoGZ/ntzsfmFIK/4PxKoHcSguDsEFXNgAOPl4HZLWYmG42Orzklfv7jZriDgIsoYWFTFKsrNMN3wiDNSy5uWP+Q+8feLb5dfkurjnJP10V4n1eE2jHxH2exQ7Yx16Ghku+M2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765850881; c=relaxed/simple;
	bh=bIQ6IcNZeBjRNiHyZJt0848kAV2lLn17BQZPhUtOLLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEKXYs2B2rWxLxUxOWuKclB8P3qLpfzw2zNENUV4N7nIctYwnQFEiO2ue1pDOHGlb+n5Qpp8qMrQgSJ1J/aR6W972G20sd5j87ROJNvalcfDARfCvnyGqrLhns1XAV+Xao3RRTEJgwLGrXnCLkW9IuQglPBV1sHq83aGjg7CVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ibSCGHiN; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03d63f28-01f7-4195-9210-f6ce0c8a4dcd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765850867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKCNhAdUISI5J2FgHdslWi3UHrTEte2sHYUrKfSgadc=;
	b=ibSCGHiNA5a/mNju1S2HZH15z1nJnD64aegFhK+10DG3oH+rnSuPpTqysZq3isOKHdx4z/
	dZoO00JWc16SHFzyo8YQA9NQ4MHOCt44mzM0sVxdWk0zBlmAWcfNn0h17esS1RLa8HtEus
	OsiYfTqVuXgGangiO8Ss/2UeUX2/jlk=
Date: Mon, 15 Dec 2025 18:07:20 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] next/pending-fixes: (build) error: unknown warning
 option '-Wno-suggest-attribute=format'; did...
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, KernelCI bot <bot@kernelci.org>,
 kernelci@lists.linux.dev, kernelci-results@groups.io,
 Linux Regressions <regressions@lists.linux.dev>, gus@collabora.com,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <176584314280.2550.10885082269394184097@77bfb67944a2>
 <20251216122514.7ee70d5f@canb.auug.org.au>
 <3cd2c37e-458f-409c-86e9-cd3c636fb071@linux.dev>
 <CAADnVQKB1Ubr8ntTAb0Q6D1ek+2tLk1yJucLOXouaF_vMqP3GA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKB1Ubr8ntTAb0Q6D1ek+2tLk1yJucLOXouaF_vMqP3GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/15/25 5:37 PM, Alexei Starovoitov wrote:
> On Mon, Dec 15, 2025 at 5:32 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 12/15/25 5:25 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> On Mon, 15 Dec 2025 23:59:03 -0000 KernelCI bot <bot@kernelci.org> wrote:
>>>>
>>>> Hello,
>>>>
>>>> New build issue found on next/pending-fixes:
>>>>
>>>> ---
>>>>  error: unknown warning option '-Wno-suggest-attribute=format'; did you mean '-Wno-property-attribute-mismatch'? [-Werror,-Wunknown-warning-option] in kernel/bpf/helpers.o (scripts/Makefile.build:287) [logspec:kbuild,kbuild.compiler.error]
>>>> ---
>>>>
>>>> - dashboard: https://d.kernelci.org/i/maestro:32e32983183c2c586f588a4a3a7cda83311d5be9
>>>> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>> - commit HEAD:  326785a1dd4cea4065390fb99b0249781c9912bf
>>>>
>>>> [...]
>>>>
>>>
>>> Presumably caused by commit
>>>
>>>  ba34388912b5 ("bpf: Disable false positive -Wsuggest-attribute=format warning")
>>
>> Hi Stephen,
>>
>> A potential hotfix is here:
>> https://lore.kernel.org/bpf/d80c77cf-c570-4f3b-960f-bbd2d0316fac@linux.dev/
>>
>> Needs acks/nacks.
> 
> I removed the offending patch from bpf tree.

Thanks. The CI is green now at bpf/master tip (1d528e794f3d):
https://github.com/kernel-patches/bpf/actions/runs/20253601894

