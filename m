Return-Path: <netdev+bounces-69973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E9884D256
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A241F24403
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D58662E;
	Wed,  7 Feb 2024 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLx/JptS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003221B7E5
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335102; cv=none; b=csfGILMeAyzMyumGV8Bj9oZ7l2Ic9Xss0OSAf9YLNNKL1d/JWQI0HnQBGHcwBqIf+bAHHQa7QybQv7sPZI59Rzs1VdWV7tHcZ57c+Uzl6NqKG3j7eIVlRux6wkZ9viuz5UDVATRV6V2aD/6s3KfD2prAli/05MOuW85WevBBP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335102; c=relaxed/simple;
	bh=mMLuca8XgOTb3fTTQ5E00oQ+Dn9by07ek7d8ZQ9Kqcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpGocyV2kJn9DBsqCMaZv/u1IV1B4KamcPiLygK1eO8zCOo82p08OvPaqUspn1lEfbvDpmsXzC70p7dEDsjEDag/ehuAqbrrx0m7dwwC4YVrrfRl1yQPC6iFSK+LUdWJRWdTp0O6fO2uu/M04aW5T7bfVCrRMP8RzkVZUQna0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLx/JptS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C77EC433F1;
	Wed,  7 Feb 2024 19:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707335101;
	bh=mMLuca8XgOTb3fTTQ5E00oQ+Dn9by07ek7d8ZQ9Kqcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tLx/JptSxeHzuukTuwYS+5HtAwhapmfyM6y2dN6lGEykg4JTXomW1rkhUlZ/qpz38
	 sqDrpuLjlnGWvbB4nbcNm8qmex6e62Y/QjfChuTrBf3NL5pEs/p9iMw5q+ZQYLh2h2
	 aXWdUfU6HLsr6tAQl0tGfbFkJcJ9QOeqAaweNB1jHI46nQzModwE/rbvR9SGs8PfoP
	 gVxcYqTkYX+zDrcLJazgd+uoEemvynj9hz3229TKqqB3o0Cb0zdZ+HCEv3qWR8lRIr
	 K1y0r5RN/FXMGabeZtXNQed+jU6HKGXnaOejt0cZ2vCLk9Qo7bUlyPRXToCVjEK2DN
	 2PhDEU81iMpLQ==
Message-ID: <1dddd3ba-aabe-4ad8-aefa-fd5e337c88d0@kernel.org>
Date: Wed, 7 Feb 2024 12:45:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] The no-kvm CI instances going away
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240205174136.6056d596@kernel.org>
 <c5be3d50-0edb-424b-b592-7c539acd3e3b@kernel.org>
 <20240207105507.3761b12e@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240207105507.3761b12e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 11:55 AM, Jakub Kicinski wrote:
> On Wed, 7 Feb 2024 10:45:26 -0700 David Ahern wrote:
>> On 2/5/24 6:41 PM, Jakub Kicinski wrote:
>>> because cloud computing is expensive I'm shutting down the instances
>>> which were running without KVM support. We're left with the KVM-enabled
>>> instances only (metal) - one normal and one with debug configs enabled.  
>>
>> who is covering the cost of the cloud VMs?
> 
> Meta
> 
>> Have you considered cheaper alternatives to AWS?
> 
> If I'm completely honest it's more a time thing than cost thing.
> I have set a budget for the project in internal tooling to 3x
> what I expected just the build bot to consume, so it can fit one
> large instance without me having to jump thru any hoops.
> I will slowly jump thru hoops to get more as time allows,
> but I figured the VM instance was a mistake in the first place,
> so I can as well just kill it off already. The -dbg runners
> are also slow. Or do you see benefit to running without KVM?
> Another potential extension is running on ARM.
> 
> And yes, it was much cheaper when the builder run in Digital Ocean.
> 
> But why do you ask? :) Just to offer cheaper alternatives or do you
> happen to have the ability to get a check written to support the
> effort? :)

I have no such ability :-) I cover the costs myself when I use VMs on
DigitalOcean and Vultr for Linux development and testing.

Kernel builds and selftests just need raw compute power, none of the
fancy enterprise features that AWS provides (and bills accordingly).

The first question about who is covering the cost is to avoid
assumptions and acknowledge the service (and costs) provided to the
community. Having the selftests tied to patchsets is really helpful to
proactively identify potential regressions.

For the second question I was just curious as to whether you had tried
the cheaper options (DO, Vultr, Linode, ...) and if they worked ok for
you. ie., why AWS. I like the range of OS versions that are accessible
within minutes.

