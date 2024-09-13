Return-Path: <netdev+bounces-128126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214DA97828E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9FA1F22A0E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A8441D;
	Fri, 13 Sep 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2VYjpuj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C50E567
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237867; cv=none; b=c6M7nSj7ZEPou5SJIwYmSrgC1NtVoh/k6Cpz7zmAN/DxIg314W4H72hBZ18xxqOmF/chEggc5jYcvp0eaUlLfrLVvVsybMRCw4h4mEaGsUXCkkyEIQG+2A47iotvlJgyYpNqJa+5B1iqTgd6WFinWiZ4BR9Dl/NELVSWypdLR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237867; c=relaxed/simple;
	bh=cvb8fGrUnpYAAUfBe9y8JUzwV5Nt6edI/oLcj4CO1YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqSbZXX2nYB9PEGWUILrQgroFTk9vn4T3v4bpfMwtv/evD9LJ0xfXW2d4xGIPcT6Goh5YYQLcAMgSqh5duXIz53I15kt8YOVCIBjQc0AB3SttKHRGJM3ANY91sMGvfs/n73lDRfVw78ijEf9HdW/a4GvIaaUMTk7ILugKFfXEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2VYjpuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166CBC4CEC7;
	Fri, 13 Sep 2024 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726237867;
	bh=cvb8fGrUnpYAAUfBe9y8JUzwV5Nt6edI/oLcj4CO1YM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D2VYjpuj1793b58gZPnJWvco1Y9fyNCrXl2ZbD8jgN5n2rE1iGxA56hYfliS1zUc6
	 9kUjA02h4XIPtjpcZvXBhDwnaChkEs3UUsRd8vQwu69YL9VKDM2ROmVYnELGVW7yf3
	 xACuaGgOPOQpNHYQ9NZweO0NN6QcSANRzDaw8o+LJ7mpIJLwkfBEvR+NEF+DYdcZiU
	 nCD/mlL3PX4PZpP57M4du97Mnhr6bXmij5/dkH5NUXT25pz8lBDO8mChtfyzHxYJXn
	 wBuAaw+VhSqQBiO2bB3EiwMWkLBpz0sBICDrIYd1NzgyazclQ/4ckgV1JDcI3SKCIs
	 IwqQ3zy2prPMQ==
Message-ID: <ad17817c-5116-4877-83c3-fba41d1f1f53@kernel.org>
Date: Fri, 13 Sep 2024 08:31:06 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: fib_rules: Add DSCP selector support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, gnault@redhat.com
References: <20240911093748.3662015-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240911093748.3662015-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/24 3:37 AM, Ido Schimmel wrote:
> Currently, the kernel rejects IPv4 FIB rules that try to match on the
> upper three DSCP bits:
> 
>  # ip -4 rule add tos 0x1c table 100
>  # ip -4 rule add tos 0x3c table 100
>  Error: Invalid tos.
> 
> The reason for that is that historically users of the FIB lookup API
> only populated the lower three DSCP bits in the TOS field of the IPv4
> flow key ('flowi4_tos'), which fits the TOS definition from the initial
> IPv4 specification (RFC 791).
> 
> This is not very useful nowadays and instead some users want to be able
> to match on the six bits DSCP field, which replaced the TOS and IP
> precedence fields over 25 years ago (RFC 2474). In addition, the current
> behavior differs between IPv4 and IPv6 which does allow users to match
> on the entire DSCP field using the TOS selector.
> 
> Recent patchsets made sure that callers of the FIB lookup API now
> populate the entire DSCP field in the IPv4 flow key. Therefore, it is
> now possible to extend FIB rules to match on DSCP.
> 
> This is done by adding a new DSCP attribute which is implemented for
> both IPv4 and IPv6 to provide user space programs a consistent behavior
> between both address families.
> 
> The behavior of the old TOS selector is unchanged and IPv4 FIB rules
> using it will only match on the lower three DSCP bits. The kernel will
> reject rules that try to use both selectors.
> 
> Patch #1 adds the new DSCP attribute but rejects its usage.
> 
> Patches #2-#3 implement IPv4 and IPv6 support.
> 
> Patch #4 allows user space to use the new attribute.
> 
> Patches #5-#6 add selftests.
> 
> iproute2 changes can be found here [1].
> 
> [1] https://github.com/idosch/iproute2/tree/submit/dscp_rfc_v1
> 
> Ido Schimmel (6):
>   net: fib_rules: Add DSCP selector attribute
>   ipv4: fib_rules: Add DSCP selector support
>   ipv6: fib_rules: Add DSCP selector support
>   net: fib_rules: Enable DSCP selector usage
>   selftests: fib_rule_tests: Add DSCP selector match tests
>   selftests: fib_rule_tests: Add DSCP selector connect tests
> 
>  include/uapi/linux/fib_rules.h                |  1 +
>  net/core/fib_rules.c                          |  4 +-
>  net/ipv4/fib_rules.c                          | 54 ++++++++++-
>  net/ipv6/fib6_rules.c                         | 43 ++++++++-
>  tools/testing/selftests/net/fib_rule_tests.sh | 90 +++++++++++++++++++
>  5 files changed, 184 insertions(+), 8 deletions(-)
> 

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>


