Return-Path: <netdev+bounces-249078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C1AD13A8D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D523C300AC52
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3278C2EDD74;
	Mon, 12 Jan 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQNrrWmY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3B2DA760
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231546; cv=none; b=d71xLQKSDrAXjrP72o8cotAad8kz5jJWDCS9Wvl5UqSKI0JF6aNkbHLSh2p4r18JcbeAN4UAKT6TeO8AA1fuOwxp+OIjCBjPivDyEK/+LwCO+w2JQJtLEtr/75JnuCxazShY/thLpymeZzyC27zObVib+JmCBYF2wIDw5mCYTQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231546; c=relaxed/simple;
	bh=p9/rXlB7+qyBnWVxII1rjmj6j6gPEAqqk7QWk6kZDvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVA2r5Sg23GocPoSuLT/DpdVsx7mkpgt8+EI2MrYcFOH6NywBoyHLpeporKJlS7YrBzdp1ytMwRYsEfKv9CwoSsUxdl9glhDFTJOZXNOhysVkJ7kUNfeumgxIog4Ab4kjBCjWs5VB5nWhVBYo3wpGO6tUjzwZyFGtfHchFoP91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQNrrWmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AEAC16AAE;
	Mon, 12 Jan 2026 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768231546;
	bh=p9/rXlB7+qyBnWVxII1rjmj6j6gPEAqqk7QWk6kZDvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HQNrrWmYjMAgY0CKnqBMZT6KzBtY+RklSIDhMf3uOIcSjhZa5ptl5S6RZFAXoJuSM
	 +OKQaPAFadTKQCMnMC3eR/QCIJMay7NyVJWC8TaPx1bbBCXPQBKvUKCHbq6DsBl1eH
	 Aq0WrImiUvIAlSl9ttjC/EGJdxQ4KDExcod1Jvym2tmDSudxRbls/lwV515J7Dk0QN
	 1xTvZFKEl+kQcHp/XSIbLpGX+UV+mYnM3K4s1AWootR2BlkRsbKywszIY1rYIYjqoN
	 Bds1kwnJVfbf/CRF3QBeHYVQXsfK2SIm6MjBvGiMuugAMYFCRhX8VLuSZUPBHal4uw
	 jH23efIRq3Qng==
Message-ID: <c36dceb4-8128-4fe7-ba19-e8bcafa0ba4b@kernel.org>
Date: Mon, 12 Jan 2026 08:25:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] selftests: fib-onlink: Remove "wrong nexthop
 device" IPv6 tests
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com
References: <20260111120813.159799-1-idosch@nvidia.com>
 <20260111120813.159799-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260111120813.159799-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/26 5:08 AM, Ido Schimmel wrote:
> The command in the test fails as expected because IPv6 forbids a nexthop
> device mismatch:
> 
>  # ./fib-onlink-tests.sh -v
>  [...]
>  COMMAND: ip -6 ro add table 1101 2001:db8:102::103/128 via 2001:db8:701::64 dev veth5 onlink
>  Error: Nexthop has invalid gateway or device mismatch.
> 
>  TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
>  [...]
> 
> Where:
> 
>  # ip route get 2001:db8:701::64 vrf lisa
>  2001:db8:701::64 dev veth7 table 1101 proto kernel src 2001:db8:701::1 metric 256 pref medium
> 
> This is in contrast to IPv4 where a nexthop device mismatch is allowed
> when "onlink" is specified:
> 
>  # ip route get 169.254.7.2 vrf lisa
>  169.254.7.2 dev veth7 table 1101 src 169.254.7.1 uid 0
>  # ip ro add table 1101 169.254.102.103/32 via 169.254.7.2 dev veth5 onlink
>  # echo $?
>  0
> 
> Remove these tests in preparation for aligning IPv6 with IPv4 and
> allowing nexthop device mismatch when "onlink" is specified.
> 
> A subsequent patch will add tests that verify that both address families
> allow a nexthop device mismatch with "onlink".
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib-onlink-tests.sh | 7 -------
>  1 file changed, 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



