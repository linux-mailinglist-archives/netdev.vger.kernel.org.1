Return-Path: <netdev+bounces-69733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DCE84C6A9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4BB283B18
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AAD1F608;
	Wed,  7 Feb 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKW3ykga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E6208BC;
	Wed,  7 Feb 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295851; cv=none; b=jZ0YYnbm9pd25WFD2TnQUdYi8WmE518BZSuFtZ5sGvNCBMITewp/lEaPnWh4CdZVKJvAJZTEXBq6CH1kzybQ2TnziVuJUsH6utyeMFKydCy+F+F8GvLz44ys3CK3YcQqRAgTh0joVtNlE4YgMIHPMOhYDPMbDrw4Y7Sg2gggEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295851; c=relaxed/simple;
	bh=6+WjTOtk9ihAjDsB9el69tA9SqT6ItUXIejrK/cXJUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0e72DgXTHj/lRHOM+cv7FDYxNZh/F39Cki/fxRj/oOz1f5J8dfMRri+GyebKhzNO0o2BKJDoNDrNeHWIuUiwsmysJoMMZa3EnKGkQXwodzk/HeWAYT6P/0tgzSbb+f+C8HYB+/jBnuuEu54Z2YnMHmbUfu2mnEsi0MEvnbU6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKW3ykga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA0C433C7;
	Wed,  7 Feb 2024 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295851;
	bh=6+WjTOtk9ihAjDsB9el69tA9SqT6ItUXIejrK/cXJUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nKW3ykgaWY/6rcf2c3EZkvZpCEJfz9DH5A1QHLLmO1lEoUm2EGDNYNNwykoCRnFds
	 Ej3wrj9i7R/rNjuU94kbPk12FUOV+f9ubGv6YnYn2YeG9muWNR2v2unvmOp7xv0Xxv
	 H2LDO6PPGZImeHzdF7wtCKW3372rEXPt7qFP53pCs86mPGuBgSJZI2hR+zMDp31adw
	 0eQEjJEYRQ36bIbkVBlIh5R+MGNtzjjEsNKLYU8Jj2MxB6IHwpfFCb0HYOnwnMlwLl
	 p6oHryIdAkM41ooqkfKp8JawdxjxHSa6qbK/ArzGAVfpu+AzkdNdf8BObPuyOpkZYn
	 6FIHH3I1Ikyfw==
Message-ID: <bd1462f0-83e9-4c0d-8591-e76eb002fb08@kernel.org>
Date: Wed, 7 Feb 2024 09:50:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] Wiki / instructions
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
References: <20240202093148.33bd2b14@kernel.org>
 <90c6d9b6-0bc4-468a-95fe-ebc2a23fffc1@kernel.org>
 <20240206173705.544f4cb2@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240206173705.544f4cb2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

Thank you for your reply!

On 07/02/2024 02:37, Jakub Kicinski wrote:
> On Mon, 5 Feb 2024 18:21:56 +0100 Matthieu Baerts wrote:
>> Thank you for this wiki page, and all the work with the CI infrastructure!
>>
>> For the debug options, I see that you are using:
>>
>>   kernel/configs/x86_debug.config
>>
>> It looks like this is specific for the 'tip' tree:
>>
>>   Debugging options for tip tree testing
>>
>> I don't know if it is still maintained, e.g. it includes DEBUG_SLAB
>> option. But also, it enables options that are maybe not needed: GCOV?
>> X86_DEBUG_FPU?
>> Maybe it is better not to use this .config file, no?
> 
> I haven't looked to closely. I noticed that the basic debug config
> doesn't enable LOCKDEP ?! so I put the x86 one on top.

I was surprised not to see LOCKDEP there, but in fact, it is: it enables
PROVE_LOCKING, which selects LOCKDEP and a few other DEBUG_xxx ones.

So maybe it is not needed to include the x86 one?

> I added a local patch to cut out all the obviously pointless stuff from
> x86_debug.config

Thank you!

> we should probably start our own config for networking
> at some stage.

Good idea!

On our side, we always enable DEBUG_NET, and the "debug" environment
also has NET_NS_REFCNT_TRACKER. We should probably enable
NET_DEV_REFCNT_TRACKER too.

Do you want me to add a new file in "kernel/configs" for net including
these 3 options?

Not directly related to "Net", we also enable DEBUG_INFO (+ compressed)
everywhere + KFENCE in the "non-debug" env only, disable RETPOLINE (+
mitigations=off) not to slow down the tests in already slow envs, and
disable a few components we don't need to accelerate the build and boot:
DRM, SOUND, etc.

https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/blob/latest/entrypoint.sh#L284

It is also possible to add some kconfig in the selftests if preferred,
e.g. in

  ./tools/testing/selftests/net/debug.config

>> For our CI validating MPTCP tests in a "debug" mode, we use
>> "debug.config" without "x86_debug.config". On top of that, we also
>> disable "SLUB_DEBUG_ON", because the impact on the perf is too
>> important, especially with slow environments. We think it is not worth
>> it for our case. You don't have the same hardware, but if you have perf
>> issues, don't hesitate to do the same ;)
> 
> The mptcp tests take <60min to run with debug enabled, and just 
> a single thread / VM. I think that's fine for now. But thanks for 
> the heads up that SLUB_DEBUG_ON is problematic, for it may matter for
> forwarding or net tests.

The longest MPTCP selftest is currently stopped after 30 minutes due to
the selftest timeout. I will see what we can do. That's not just because
of SLUB_DEBUG_ON, that's normal to be very slow in such particular env.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

