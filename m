Return-Path: <netdev+bounces-104417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050AE90C70A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C70EB237F8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64014E2C6;
	Tue, 18 Jun 2024 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1tDJ12o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1F14D6E5
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698919; cv=none; b=ghm0uDCwplLl149JKzgoYUcGGMkC5rBOZl9FhrzQb+BqEksWOV7krMzyrO/6Erd9JezMXzej4rAtRDqB899uJUN8BghalQn0o7dIiPf/oUbA4vbWQ/xMjnyYK03cwEY04uE2dGFaOnAb0qRKkJ7FhT+XwUzwbZTlufx8+IA5r6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698919; c=relaxed/simple;
	bh=BvRL7jZ8JiG3CMIXWuu3HjnL/HxvIXmz0SH8H8p9rDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHkf5SuPg0PLs01mrrh6KnbrGY1RG5mUvgHsgTELYhE+EMW9u6GrBVa4PEV9abn4w+oVRG6eQB2w9A+4U4G8QwIRTIFVWreft/LLaH8gmT/cSdt8KmZbxNpbF/jFYomv7hDzsolF5G+xYbrVPAGHTRKx8PjmPywGbGUC7QiPXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1tDJ12o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57774C4AF1D;
	Tue, 18 Jun 2024 08:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718698919;
	bh=BvRL7jZ8JiG3CMIXWuu3HjnL/HxvIXmz0SH8H8p9rDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p1tDJ12oP47HGujgvRVoSlN8QyiBZp6bRCHbXRMqKS7U7C/kX3RzkwufiB6PBzv20
	 wIZ1PYfbwW4G3Ypu01dqePhOHs84yVdtPwKsJMfE7/WE6zJKDL84kzSgsNslip4ftp
	 ilaPShmGMY5rXCpyKnbkeua0xwnAHLqYPDgmTrdvhNErM6cUmS2md/gj3N3yE2xp+C
	 NJ7Qpi5PUmgWkH78EOROrKNHCudGYCojetOc86AMAc2SHf5+6AImIS9piVSfg+IPtf
	 Ycd1LDjBZXczw8gpYOyk0n91/b0s6ooDw+cb90RwBAhH2STa3VmGXBGCT/+jnetcql
	 BpzlA2faYVZIw==
Message-ID: <1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org>
Date: Tue, 18 Jun 2024 10:21:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [TEST] virtio tests need veth?
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240617072614.75fe79e7@kernel.org>
 <ZnEq3YxtVuwHdFqn@nanopsycho.orion> <ZnE0JaJgxw1Mw1aE@nanopsycho.orion>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZnE0JaJgxw1Mw1aE@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiri,

On 18/06/2024 09:15, Jiri Pirko wrote:
> Tue, Jun 18, 2024 at 08:36:13AM CEST, jiri@resnulli.us wrote:
>> Mon, Jun 17, 2024 at 04:26:14PM CEST, kuba@kernel.org wrote:
>>> Hi Jiri!
>>>
>>> I finally hooked up the virtio tests to NIPA.
>>> Looks like they are missing CONFIG options?
>>>
>>> https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout
>>
>> Checking that out. Apparently sole config is really missing.
>> Also, looks like for some reason veth is used instead of virtio_net.
>> Where do you run this command? Do you have 2 virtio_net interfaces
>> looped back together on the system?
> 
> I guess you have custom
> tools/testing/selftests/net/forwarding/forwarding.config.
> Can you send it here?

According to the logs from the parent directory [1], the "build/stdout"
file shows that only this config file has been used:

  tools/testing/selftests/drivers/net/virtio_net/config

(see the 'vng -b' command)

> CONFIG_NET_L3_MASTER_DEV=y
> CONFIG_IPV6_MULTIPLE_TABLES=y
> CONFIG_NET_VRF=m
> CONFIG_BPF_SYSCALL=y
> CONFIG_CGROUP_BPF=y
> CONFIG_IPV6=y

The "config" file from [1] seems to indicate that all these kconfig are
missing, except the BPF ones.

Note that if you want to check locally, virtme-ng helps to reproduce the
issues reported by the CI, see [2].

[1] https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/
[2]
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


