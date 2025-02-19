Return-Path: <netdev+bounces-167774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDEA3C388
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039E0188C553
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E71EFFAB;
	Wed, 19 Feb 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnbkHvvm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58208199237
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978576; cv=none; b=uBbUfNVdzkXdcc4D8jlmt5vF2gjt9NgCibIHskE148fte2Z5efUpVaBn+/3BM/U5zPy6xK4VQLlOO49k6D/t4HA8Lvyo+2m2qmFmN0qrNe7iC9egSfhw9dqzePvNI17N79yW5dEafd4qOEd8+nGmRRxgkpFQPeuhxUM0MwobU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978576; c=relaxed/simple;
	bh=iCShM6dMfchXUH1xVrsrvefhLW9VtaeS/gyRxgOTRX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF9gPFgZqmvGlDmIp8lRdh7kdk/DhjpGhnU2Ef/1fCPVDGx3ZROdGinuY8VjgxuXFmSK8lgUEXHBiLXG8pzzjtRRvTWaHNZ/IQQu2i9LeCI5YJbXjWkgLxjcxWN+iwCDx5x8gAf5q3yfjSCzOAxiA4wZ6xvsUg/zYtHRX0osCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnbkHvvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603B8C4CED1;
	Wed, 19 Feb 2025 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739978575;
	bh=iCShM6dMfchXUH1xVrsrvefhLW9VtaeS/gyRxgOTRX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BnbkHvvmUHnxX8TqdaT99zvL+EipnlnJMYgOJHI3TYTY04gb39uuV2U4Hf8fZSI5r
	 qdrqGgLDx5gLK2EwLtw/QxATkQLN39f9vea93pP67+rmNQNK3YTUJC8hvMuofVW+iW
	 AdNFdfJv1kV5AerygYKVdCeuOsvruevb8gGPVzi8UFFHkQQSbIcFaK6ZJXWWLaX1AQ
	 RGUYwhsH8PTrRresbJKMpNcJkz6aguZTpmZqhktYGTng5zmNFuNPqpC5KKikUWimc+
	 UE9f+tVwZtkjY+zUu1x3J9SV8BFXzULQJL5urQ6J7DvqO3MlSh04/mp4FGBSW2t3Zl
	 fjlc0IpPU4S+g==
Message-ID: <c125747a-8300-4282-894c-73c19ad7ce2f@kernel.org>
Date: Wed, 19 Feb 2025 08:22:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: fib_rules: Add port mask support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, donald.hunter@gmail.com,
 petrm@nvidia.com, gnault@redhat.com
References: <20250217134109.311176-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250217134109.311176-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 6:41 AM, Ido Schimmel wrote:
> In some deployments users would like to encode path information into
> certain bits of the IPv6 flow label, the UDP source port and the DSCP
> field and use this information to route packets accordingly.
> 
> Redirecting traffic to a routing table based on specific bits in the UDP
> source port is not currently possible. Only exact match and range are
> currently supported by FIB rules.
> 
> This patchset extends FIB rules to match on layer 4 ports with an
> optional mask. The mask is not supported when matching on a range. A
> future patchset will add support for matching on the DSCP field with an
> optional mask.
> 
> Patches #1-#6 gradually extend FIB rules to match on layer 4 ports with
> an optional mask.
> 
> Patches #7-#8 add test cases for FIB rule port matching.
> 
> iproute2 support can be found here [1].
> 
> [1] https://github.com/idosch/iproute2/tree/submit/fib_rule_mask_v1
> 
> Ido Schimmel (8):
>   net: fib_rules: Add port mask attributes
>   net: fib_rules: Add port mask support
>   ipv4: fib_rules: Add port mask matching
>   ipv6: fib_rules: Add port mask matching
>   net: fib_rules: Enable port mask usage
>   netlink: specs: Add FIB rule port mask attributes
>   selftests: fib_rule_tests: Add port range match tests
>   selftests: fib_rule_tests: Add port mask match tests
> 
>  Documentation/netlink/specs/rt_rule.yaml      | 10 +++
>  include/net/fib_rules.h                       | 19 +++++
>  include/uapi/linux/fib_rules.h                |  2 +
>  net/core/fib_rules.c                          | 69 ++++++++++++++++++-
>  net/ipv4/fib_rules.c                          |  8 +--
>  net/ipv6/fib6_rules.c                         |  8 +--
>  tools/testing/selftests/net/fib_rule_tests.sh | 36 ++++++++++
>  7 files changed, 143 insertions(+), 9 deletions(-)
> 

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>


