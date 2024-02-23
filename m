Return-Path: <netdev+bounces-74250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A708609A5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2A41F266AC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB4C2E3;
	Fri, 23 Feb 2024 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1tKtziX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85624101CA
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660346; cv=none; b=t/7dbrq5qfuQmUIdZ1r343DKQKYV+IsDLiRZRNbTeb35u0/7rpcKwZyaGfnwE8dqAMG43HpeWyyBuKBVtLnxCZ0j7q5vf4tLaKiXWd4hGoFQ1vKqV7zFa/5ZyfMsk0Cqp82df8Bz3J7pN1srvJf0Yvb9EMTGBefUNSIDUc5fWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660346; c=relaxed/simple;
	bh=IhiVFQYrwSpre8wZw4ecuZpVVmiM7jqsZor1QRF9WBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TITjy5yDefB0fkpluktmNPbkoOf2sE5jhIkw9V6bx1FQ2k/Ox5QQhS4Esk8E/3aUzdu2o94o6DMDLEvVDttys47FTKKcmxLxsmXsIDG+MhMkGGocNrnC2OxYjfgeQ6o3BIodLwhgm2G4KGGlPV69ebZRoms8Qt8NPBdZCus09gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1tKtziX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D2EC433F1;
	Fri, 23 Feb 2024 03:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708660346;
	bh=IhiVFQYrwSpre8wZw4ecuZpVVmiM7jqsZor1QRF9WBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1tKtziX/UR+XHwAmminJIfdhhVafo0rfm6S+35hKJ7n29WI25ALUlZGCK0k4vBme
	 wgLdM75lLDVEP0Zg76o4AmvhDpMOJxRV0G+Z/rNcZt6YO3/0deGYATMsDfBzmT+by8
	 ELgHSS9VngDvhqflTPBQysM3Icz+hTJj5QOTsoIqpOvSho7fPpVwNtcKE4hBaCCZ1L
	 eRH2k+ja8jbD+OCW+fzMKYqwUltzeJvMhGuRHHqP7jFljIboTS7SYyKo7gSTPF74UD
	 O+LCOqAKyspozPerM1jbG5j5cJTORSPqlmIJIITnNaBCtiycPzMyaTmw/7wcDfonox
	 /RH9km7NCZxDw==
Date: Thu, 22 Feb 2024 19:52:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, liuhangbin@gmail.com,
 sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next v6 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Message-ID: <20240222195224.7ff5c5e0@kernel.org>
In-Reply-To: <20240208220653.374773-6-thinker.li@gmail.com>
References: <20240208220653.374773-1-thinker.li@gmail.com>
	<20240208220653.374773-6-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 14:06:53 -0800 thinker.li@gmail.com wrote:
>  	# Permanent routes
> -	for i in $(seq 1 5000); do
> +	for i in $(seq 1 5); do
>  	    $IP -6 route add 2001:30::$i \
>  		via 2001:10::2 dev dummy_10
>  	done
>  	# Temporary routes
> -	for i in $(seq 1 1000); do
> +	for i in $(seq 1 5); do
>  	    # Expire route after $EXPIRE seconds
>  	    $IP -6 route add 2001:20::$i \
>  		via 2001:10::2 dev dummy_10 expires $EXPIRE
>  	done
> -	sleep $(($EXPIRE * 2))
> -	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> -	if [ $N_EXP_SLEEP -ne 0 ]; then
> -	    echo "FAIL: expected 0 routes with expires," \
> -		 "got $N_EXP_SLEEP (5000 permanent routes)"
> -	    ret=1
> -	else
> -	    ret=0
> +	sleep $(($EXPIRE * 2 + 1))
> +	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
> +	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"

Looks like fib_tests.sh have gotten flaky since this got merged :(

https://netdev.bots.linux.dev/contest.html?test=fib-tests-sh&executor=vmksft-net&pass=0

# Fib6 garbage collection test
#     TEST: ipv6 route garbage collection                                 [ OK ]
# FAIL: Expected 0 routes, got 1
#     TEST: ipv6 route garbage collection (with permanent routes)         [FAIL]
#     TEST: ipv6 route garbage collection (replace with expires)          [ OK ]
#     TEST: ipv6 route garbage collection (replace with permanent)        [ OK ]
https://netdev-3.bots.linux.dev/vmksft-net/results/477081/6-fib-tests-sh/stdout

# Fib6 garbage collection test
#     TEST: ipv6 route garbage collection                                 [ OK ]
# FAIL: Expected 0 routes, got 3
#     TEST: ipv6 route garbage collection (with permanent routes)         [FAIL]
#     TEST: ipv6 route garbage collection (replace with expires)          [ OK ]
#     TEST: ipv6 route garbage collection (replace with permanent)        [ OK ]
https://netdev-3.bots.linux.dev/vmksft-net/results/467181/6-fib-tests-sh/stdout

# Fib6 garbage collection test
#     TEST: ipv6 route garbage collection                                 [ OK ]
# FAIL: Expected 0 routes, got 3
#     TEST: ipv6 route garbage collection (with permanent routes)         [FAIL]
#     TEST: ipv6 route garbage collection (replace with expires)          [ OK ]
#     TEST: ipv6 route garbage collection (replace with permanent)        [ OK ]
https://netdev-3.bots.linux.dev/vmksft-net/results/466641/18-fib-tests-sh/stdout

Could you take a look?

