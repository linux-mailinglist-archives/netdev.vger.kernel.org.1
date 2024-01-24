Return-Path: <netdev+bounces-65655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E699E83B440
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F131C21508
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87943134737;
	Wed, 24 Jan 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjmQwLl/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9201353F6;
	Wed, 24 Jan 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132884; cv=none; b=ZCj2b0As3mMYvf9DRLRfv7QdMC+GVRg+6wkK9hufaLNwyIo5Gs6JF9h+rac52HRdaPcAmlR+KckMOWZN4tpoV9/xyzjvdO+VHTGKqUvHkVN0tbV2kKvvimJWOi67kXRTVpkuHJzoK9I00B0ooh8ddLRYF0h44jf7kHFX/O9ykMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132884; c=relaxed/simple;
	bh=RGtonvax3uapi4rH4NaONNxIfvhQULoG+v5mKWQIIiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4LSZ5nue2TczcudS7m0uKvChTjP/YVGjX8hutDV/KsfPCCmV+j06T1NSQu64woJhCA00gtZj4y84VkCutXVLzsMMyl5IdpbvPJooGBAcwqwxX19BObs8QMvZh+97/aXsxCf/d5P8XKLRLd8nUj3CdH7oLRLt+B1E/U988xqSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjmQwLl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A23C433C7;
	Wed, 24 Jan 2024 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706132883;
	bh=RGtonvax3uapi4rH4NaONNxIfvhQULoG+v5mKWQIIiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AjmQwLl/q71OAnoRhmNsQhK4W9dS35CXVP4MvI49fssz9ruZMTxDGzqfTAIiFOD6C
	 x+INVNs3HlgYIDC0z7fzhIfxgQGXsCDbxCVWtpdn7dF3pym8vvzyK+qUc40MCsnhHU
	 r64trbzUjIbq7j543UrQQFmcKdncoaiAL2UfryYJOrQ2hamD0xAfClLFxxTSANVFTt
	 /25wFYnYHMKYzwhK9pSKC/TJwkYtW+sin/SWeH1gdyufKeG+7tyr+a7iaSbfh6WY55
	 wNaWl7XGNofrXn5y4eH99ExKqiLG1dXBNavrSSaCh7xMqyGVhnoS05zStKBaIv7Qps
	 RFFsDXHbbY02g==
Message-ID: <bd985576-cc99-49c5-a2e0-09622fd6027a@kernel.org>
Date: Wed, 24 Jan 2024 14:48:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org> <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
 <20240123133925.4b8babdc@kernel.org>
 <256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
 <7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
 <20240124070755.1c8ef2a4@kernel.org> <20240124081919.4c79a07e@kernel.org>
 <aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
 <20240124085919.316a48f9@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240124085919.316a48f9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 9:59 AM, Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 09:35:09 -0700 David Ahern wrote:
>>> This is the latest run:
>>>
>>> https://netdev-2.bots.linux.dev/vmksft-net-mp/results/435141/1-fcnal-test-sh/stdout
>>>
>>> the nettest warning is indeed gone, but the failures are the same:  
>>
>> yep, I will send a formal patch. I see the timeout is high enough, so
>> good there.
> 
> Well, kinda, to be honest I did bump the time to 4000s locally.
> The runtime of the entire net suite 1h 10min - that's pretty much
> the runtime of this one test :) The VMs run the tests without

one *script* = 900+ tests. :-)


> HW virtualization, so they are a bit slower, but it'd be nice
> if no local hacks were necessary. 
> 
> I haven't sent a patch to bump it because it may make more sense
> to split the test into multiple. But as a stop gap we can as well
> bump the timeout.

The script has the tests in groups and each group can be run in parallel
(with Hangbin's recent namespace changes). I can look at splitting that
script into many (or write wrappers to run specific groups), but even
then most of those test groups need more than 45 seconds. There are lot
of permutations covered (with and without vrf, different address types,
different uapis, ...).

> 
>>> $ grep FAIL stdout 
>>> # TEST: ping local, VRF bind - VRF IP                 [FAIL]
>>> # TEST: ping local, device bind - ns-A IP             [FAIL]
>>> # TEST: ping local, VRF bind - VRF IP                 [FAIL]
>>> # TEST: ping local, device bind - ns-A IP             [FAIL]
>>>
>>> :(  
>>
>> known problems. I can disable the tests for now so we avoid regressions,
>> and add to the TO-DO list for someone with time.

Sent a PR to fix a few things. I did not have to disable any tests -
everything passes cleanly with the changes. If tests fail after those
are applied, let's compare OS environments - maybe some sysctl is
enabled or disabled (or a CONFIG) in your environment.

