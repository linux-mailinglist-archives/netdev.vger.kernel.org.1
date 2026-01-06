Return-Path: <netdev+bounces-247429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7210ACFB274
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C325309283A
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD598376BC7;
	Tue,  6 Jan 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE1VhAsa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820636D514
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722394; cv=none; b=Z1XJ8RTthjCA3qc2Sp1SYbqede0gjGBag1TsknbWN7cOFeyTW7AFOxtS1XQgFpymg5AD6egUFPqyERnL8eS63GMpC6LVrVTd1wgsRc9eu2w2WHB65iw8AWr7gHwGXdlrs8UO8iX+1pQe+Xjfr/JlKHwHb+c/aygIDbyyrdnVGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722394; c=relaxed/simple;
	bh=ctAcHFLjXWJnEFXRiYzF3EpnGIE1CYGwH0RzT3Ylcz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXRMU4Euxk4fcHW23duaqpUK62aB/QCHJpGzrmMRSmYalBhNdk6ycXrwbvALRMjl0BCT7yhBCJvY3ganOxsoGP6avMaDTeYQAaOp2j6YJs9O0VrrT2RQa/dbywEtfUlbEO7CovLojhApuytC8YkawlC1v3dQOYuBBuVFQITXwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE1VhAsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251C6C116C6;
	Tue,  6 Jan 2026 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767722394;
	bh=ctAcHFLjXWJnEFXRiYzF3EpnGIE1CYGwH0RzT3Ylcz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PE1VhAsawbI1MdOSfpyJBTHr+K+edA1fPrZzKGSjodwZ1U4BM1jhi68ZVeoNxyOZc
	 rR5/hgvUSfhW474oNiBDB6l2IqeBkyTDaEIXmblK0GBFN3nvg5WI+JyFit+IeQB4k8
	 zK6B690d7/nYifsc3vs/MWnPD5glpSz/DeKIoRSGfhG+SxWvskoIIpaae0b/B6Lbwb
	 s+bbgb1bgs3NKqVG07FBHQb55sbHWitpnnFPLDzyICjq/UKFQ1q/UISDtaI2AHR7po
	 nDdyxouImNyCitFyoXp7/+SS7jKMb1hbRX6i4c2nYqpaTi4QKIUlCs/fRVBjb2ORBp
	 gcSlv2ePYr3dQ==
Message-ID: <f2ece8a4-1eaf-45c6-8861-27042d275b92@kernel.org>
Date: Tue, 6 Jan 2026 10:59:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 2/2] selftests: fib_tests: Add test cases for
 route lookup with oif
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org
References: <20251224161801.824589-1-idosch@nvidia.com>
 <20251224161801.824589-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251224161801.824589-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 9:18 AM, Ido Schimmel wrote:
> Test that both address families respect the oif parameter when a
> matching multipath route is found, regardless of the presence of a
> source address.
> 
> Output without "ipv6: Honor oif when choosing nexthop for locally
> generated traffic":
> 
>  # ./fib_tests.sh -t "ipv4_mpath_oif ipv6_mpath_oif"
> 
>  IPv4 multipath oif test
>      TEST: IPv4 multipath via first nexthop                              [ OK ]
>      TEST: IPv4 multipath via second nexthop                             [ OK ]
>      TEST: IPv4 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv4 multipath via second nexthop with source address         [ OK ]
> 
>  IPv6 multipath oif test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [FAIL]
>      TEST: IPv6 multipath via second nexthop with source address         [FAIL]
> 
>  Tests passed:   6
>  Tests failed:   2
> 
> Output with "ipv6: Honor oif when choosing nexthop for locally generated
> traffic":
> 
>  # ./fib_tests.sh -t "ipv4_mpath_oif ipv6_mpath_oif"
> 
>  IPv4 multipath oif test
>      TEST: IPv4 multipath via first nexthop                              [ OK ]
>      TEST: IPv4 multipath via second nexthop                             [ OK ]
>      TEST: IPv4 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv4 multipath via second nexthop with source address         [ OK ]
> 
>  IPv6 multipath oif test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv6 multipath via second nexthop with source address         [ OK ]
> 
>  Tests passed:   8
>  Tests failed:   0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 108 ++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index a88f797c549a..8ae0adbcafe9 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -12,7 +12,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
>         ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
>         ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
>         ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
> -       fib6_ra_to_static"
> +       ipv4_mpath_oif ipv6_mpath_oif fib6_ra_to_static"
>  
>  VERBOSE=0
>  PAUSE_ON_FAIL=no
> @@ -2776,6 +2776,110 @@ ipv6_mpath_balance_test()
>  	forwarding_cleanup
>  }
>  
> +ipv4_mpath_oif_test_common()
> +{
> +	local get_param=$1; shift
> +	local expected_oif=$1; shift
> +	local test_name=$1; shift
> +	local tmp_file
> +
> +	tmp_file=$(mktemp)
> +
> +	for i in {1..100}; do
> +		$IP route get 203.0.113.${i} $get_param >> "$tmp_file"
> +	done
> +
> +	[[ $(grep "$expected_oif" "$tmp_file" | wc -l) -eq 100 ]]
> +	log_test $? 0 "$test_name"
> +
> +	rm "$tmp_file"
> +}
> +
> +ipv4_mpath_oif_test()
> +{
> +	echo
> +	echo "IPv4 multipath oif test"
> +
> +	setup
> +
> +	set -e
> +	$IP link add dummy1 type dummy
> +	$IP link set dev dummy1 up
> +	$IP address add 192.0.2.1/28 dev dummy1
> +	$IP address add 192.0.2.17/32 dev lo
> +
> +	$IP route add 203.0.113.0/24 \
> +		nexthop via 198.51.100.2 dev dummy0 \
> +		nexthop via 192.0.2.2 dev dummy1
> +	set +e
> +
> +	ipv4_mpath_oif_test_common "oif dummy0" "dummy0" \
> +		"IPv4 multipath via first nexthop"
> +
> +	ipv4_mpath_oif_test_common "oif dummy1" "dummy1" \
> +		"IPv4 multipath via second nexthop"
> +
> +	ipv4_mpath_oif_test_common "oif dummy0 from 192.0.2.17" "dummy0" \
> +		"IPv4 multipath via first nexthop with source address"
> +
> +	ipv4_mpath_oif_test_common "oif dummy1 from 192.0.2.17" "dummy1" \
> +		"IPv4 multipath via second nexthop with source address"
> +
> +	cleanup
> +}
> +
> +ipv6_mpath_oif_test_common()
> +{
> +	local get_param=$1; shift
> +	local expected_oif=$1; shift
> +	local test_name=$1; shift
> +	local tmp_file
> +
> +	tmp_file=$(mktemp)
> +
> +	for i in {1..100}; do
> +		$IP route get 2001:db8:10::${i} $get_param >> "$tmp_file"
> +	done
> +
> +	[[ $(grep "$expected_oif" "$tmp_file" | wc -l) -eq 100 ]]
> +	log_test $? 0 "$test_name"
> +
> +	rm "$tmp_file"
> +}
> +
> +ipv6_mpath_oif_test()
> +{
> +	echo
> +	echo "IPv6 multipath oif test"
> +
> +	setup
> +
> +	set -e
> +	$IP link add dummy1 type dummy
> +	$IP link set dev dummy1 up
> +	$IP address add 2001:db8:2::1/64 dev dummy1
> +	$IP address add 2001:db8:100::1/128 dev lo
> +
> +	$IP route add 2001:db8:10::/64 \
> +		nexthop via 2001:db8:1::2 dev dummy0 \
> +		nexthop via 2001:db8:2::2 dev dummy1
> +	set +e
> +
> +	ipv6_mpath_oif_test_common "oif dummy0" "dummy0" \
> +		"IPv6 multipath via first nexthop"
> +
> +	ipv6_mpath_oif_test_common "oif dummy1" "dummy1" \
> +		"IPv6 multipath via second nexthop"
> +
> +	ipv6_mpath_oif_test_common "oif dummy0 from 2001:db8:100::1" "dummy0" \
> +		"IPv6 multipath via first nexthop with source address"
> +
> +	ipv6_mpath_oif_test_common "oif dummy1 from 2001:db8:100::1" "dummy1" \
> +		"IPv6 multipath via second nexthop with source address"
> +
> +	cleanup
> +}
> +
>  ################################################################################
>  # usage
>  
> @@ -2861,6 +2965,8 @@ do
>  	ipv6_mpath_list)		ipv6_mpath_list_test;;
>  	ipv4_mpath_balance)		ipv4_mpath_balance_test;;
>  	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
> +	ipv4_mpath_oif)			ipv4_mpath_oif_test;;
> +	ipv6_mpath_oif)			ipv6_mpath_oif_test;;
>  	fib6_ra_to_static)		fib6_ra_to_static;;
>  
>  	help) echo "Test names: $TESTS"; exit 0;;

if VRF versions of the test also pass, I am good with the proposed change.

