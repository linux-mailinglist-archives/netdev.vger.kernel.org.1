Return-Path: <netdev+bounces-104528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED24790D061
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C86C1F233B7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F241741EC;
	Tue, 18 Jun 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek/uyWVV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCC15535F
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715451; cv=none; b=gCiPXqqClbqi6bPJCHdJ10fcKTTVs5BF8uBC32vtGVvr6hu07QweaiFUK5jj5akU/2y+Cx2dixHUM7D7SFIZ5aDUrENQF670XfGe5llyRCRGd8MuuO+5qeI2tC1u7JjoRibj7j1r45eWAB3KyvxuQFeW0olaQhr2/K3N9AQI20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715451; c=relaxed/simple;
	bh=TcDnaUSyStP3xVladGjDo6hyT0s/N6+iHvNvLB9Qgqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1fSS6r3H8aNS45WyZOvDgTCrrVfC4p0VRtLVmH3RauT/zF0scw+xt+vEBJgrgDEUUeEYpb0ELs/PWfgfPmxpALlemGR8/0YrEbsE3FenCJV1wpBW0aXWHjXq9ws2dn7yTsHnFn2WiBfgCn/dIfS3q3jRF2H0dLA9NI+GNdutjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek/uyWVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEB4C4AF1D;
	Tue, 18 Jun 2024 12:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718715451;
	bh=TcDnaUSyStP3xVladGjDo6hyT0s/N6+iHvNvLB9Qgqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ek/uyWVVuFxBC7N2Pl5Tz/IFC2fpI/G+FMEVRvM2g8dSzNB6Z4bm3jo3KvEJt57KI
	 1Z+1nSFCZg+YsRapnGn9+KGLBuKalgBj4fqC0ihgirB8+x7JVx+Pz64qGO6InYj/Xg
	 XY0c6afMrHSVz3QmVRnJtXJlU/qTo0Rv2bHeTz9Sg6+nWikD73GrAQzs5OH8IWkgYq
	 B5ud7QaMPTqNrKDHNvrWWGx//fW99koHFO+aUHDFbwVy1V5PBe4AqCuaHa3VeweMbD
	 mRZ4SxuyBrdOg3f9PoGFWXFgS2tFtzs5lbFQXnfJEdp/vcxa49EDmZt1tVlvVFFoN1
	 /42B5+VcA41bA==
Message-ID: <11ac196a-85cd-4113-97e0-7386c22c9e08@kernel.org>
Date: Tue, 18 Jun 2024 14:57:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [TEST] virtio tests need veth?
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240617072614.75fe79e7@kernel.org>
 <ZnEq3YxtVuwHdFqn@nanopsycho.orion> <ZnE0JaJgxw1Mw1aE@nanopsycho.orion>
 <1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org>
 <ZnFze5vFv6dWwQgL@nanopsycho.orion>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZnFze5vFv6dWwQgL@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2024 13:46, Jiri Pirko wrote:
> Tue, Jun 18, 2024 at 10:21:54AM CEST, matttbe@kernel.org wrote:
>> Hi Jiri,
>>
>> On 18/06/2024 09:15, Jiri Pirko wrote:
>>> Tue, Jun 18, 2024 at 08:36:13AM CEST, jiri@resnulli.us wrote:
>>>> Mon, Jun 17, 2024 at 04:26:14PM CEST, kuba@kernel.org wrote:
>>>>> Hi Jiri!
>>>>>
>>>>> I finally hooked up the virtio tests to NIPA.
>>>>> Looks like they are missing CONFIG options?
>>>>>
>>>>> https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout
>>>>
>>>> Checking that out. Apparently sole config is really missing.
>>>> Also, looks like for some reason veth is used instead of virtio_net.
>>>> Where do you run this command? Do you have 2 virtio_net interfaces
>>>> looped back together on the system?
>>>
>>> I guess you have custom
>>> tools/testing/selftests/net/forwarding/forwarding.config.
>>> Can you send it here?
>>
>> According to the logs from the parent directory [1], the "build/stdout"
>> file shows that only this config file has been used:
>>
>>  tools/testing/selftests/drivers/net/virtio_net/config
>>
>> (see the 'vng -b' command)
>>
>>> CONFIG_NET_L3_MASTER_DEV=y
>>> CONFIG_IPV6_MULTIPLE_TABLES=y
>>> CONFIG_NET_VRF=m
>>> CONFIG_BPF_SYSCALL=y
>>> CONFIG_CGROUP_BPF=y
>>> CONFIG_IPV6=y
>>
>> The "config" file from [1] seems to indicate that all these kconfig are
>> missing, except the BPF ones.
>>
>> Note that if you want to check locally, virtme-ng helps to reproduce the
>> issues reported by the CI, see [2].
>>
>> [1] https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/
> 
> Hmm, looking here, I see only command outputs. Would be actually good to
> see what commands were run to produce those outputs.

I think only the command to launch the VM is missing.

 - In the build logs [1], where we can see 4 commands:
   > TREE CMD: make mrproper
   > TREE CMD: vng -v -b -f
tools/testing/selftests/drivers/net/virtio_net/config
   > TREE CMD: make headers
   > TREE CMD: make -C tools/testing/selftests/drivers/net/virtio_net/

 - In the VM logs [2], we don't see the command to start it. I guess it
is supposed to be closed to what is described in the wiki [3]. At the
end, we see the env vars that are set in the VM.

 - In the test logs [4], we can see the 'make' command at the first line.

I can look at adding the command to start the VM. Do you see anything
else missing?

[1]
https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/build/stdout
[2]
https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/vm-start-thr0-0/stdout
[3]
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-run
[4]
https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


