Return-Path: <netdev+bounces-244604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38CFCBB41A
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 22:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0833008E8F
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E64275B0F;
	Sat, 13 Dec 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H+0Niu0m"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C581946DF
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765661178; cv=none; b=k2YNhZ17SLhb65BojSfl4lkZsBCzzgX5BP6yhMpTw4v0Uxl+SK7Yasrxo31ZC2Wxg5WcLd/exmg8WXVlPTriJ1FbnhfCzLPKRVCz8NCJPxDDc4+EJzhPtuO+EjJk6A0AeO9Sx6EEkF9hN0F+jSK0eNq4DWO9tti6kKc8oh9SPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765661178; c=relaxed/simple;
	bh=PzbVxl+vo6Fj8ZpBW2xiZNU0BvaEdFf1l+lev2C3b5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGHzeoFNmM+GPDz5u/UJ9ocfUREYbmLkrXAAGLZpHEY+lUEk5AbHmdx4R8ZfbKCPQd7swTWE8RHLEmEzdxg+kzMpF/dApGvTdB4QNBcxRMCvFvgTgXpVSFkPd39IA0mkzc2aCeRK3WZiPZHBRjeSZrRse20RuqaQW7Sr3v3ozPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H+0Niu0m; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8cd00280-08a0-457d-a7c6-a88670595ce8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765661169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvP2bhS8+OprUTrI6vLaQJFRldu6svBTBEgCTjOjp40=;
	b=H+0Niu0mmM+PdQ7cgeb50LynLG4rYc2AJg3+yGyX7kfuBOqgmgGFINdC977s5LL3PQr4l9
	ujBXXIDmJRcSJT0CvS2tXbEs/H3oXaB9lyLTVeqX1eV0tvgIZiEyVsuTn7j43o3pOruUcz
	1Zvp6QjT2P5HHF95NrfUu5bG0gjHVTc=
Date: Sun, 14 Dec 2025 06:26:03 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/2] selftests: fib_nexthops: Add test case for ipv4
 multi nexthops
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
 <20251213135849.2054677-2-vadim.fedorenko@linux.dev>
 <willemdebruijn.kernel.2568c56f18788@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <willemdebruijn.kernel.2568c56f18788@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/12/2025 21:18, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> The test checks that with multi nexthops route the preferred route is the
>> one which matches source ip. In case when source ip is on loopback, it
>> checks that the routes are balanced.
> 
> are balanced [across .. ]

Got it.

> 
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   tools/testing/selftests/net/fib_nexthops.sh | 85 +++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
>> index 2b0a90581e2f..9d6f57399a73 100755
>> --- a/tools/testing/selftests/net/fib_nexthops.sh
>> +++ b/tools/testing/selftests/net/fib_nexthops.sh
>> @@ -31,6 +31,7 @@ IPV4_TESTS="
>>   	ipv4_compat_mode
>>   	ipv4_fdb_grp_fcnal
>>   	ipv4_mpath_select
>> +	ipv4_mpath_select_nogrp
>>   	ipv4_torture
>>   	ipv4_res_torture
>>   "
>> @@ -375,6 +376,17 @@ check_large_res_grp()
>>   	log_test $? 0 "Dump large (x$buckets) nexthop buckets"
>>   }
>>   
>> +get_route_dev_src()
>> +{
>> +	local pfx="$1"
>> +	local src="$2"
>> +	local out
>> +
>> +	if out=$($IP -j route get "$pfx" from "$src" | jq -re ".[0].dev"); then
>> +		echo "$out"
>> +	fi
>> +}
>> +
>>   get_route_dev()
>>   {
>>   	local pfx="$1"
>> @@ -641,6 +653,79 @@ ipv4_fdb_grp_fcnal()
>>   	$IP link del dev vx10
>>   }
>>   
>> +ipv4_mpath_select_nogrp()
> 
> There is more going on than just not using the group feature.
> 
> Would it make sense to split this into two test patches, a base test
> and a follow-on that extends with the loopback special case?

Sounds reasonable, I'll split it in v2

> 
>> +{
>> +	local rc dev match h addr
>> +
>> +	echo
>> +	echo "IPv4 multipath selection no group"
>> +	echo "------------------------"
>> +	if [ ! -x "$(command -v jq)" ]; then
>> +		echo "SKIP: Could not run test; need jq tool"
>> +		return $ksft_skip
>> +	fi
>> +
>> +	IP="ip -netns $peer"
>> +	# Use status of existing neighbor entry when determining nexthop for
>> +	# multipath routes.
>> +	local -A gws
>> +	gws=([veth2]=172.16.1.1 [veth4]=172.16.2.1)
>> +	local -A other_dev
>> +	other_dev=([veth2]=veth4 [veth4]=veth2)
>> +	local -A local_ips
>> +	local_ips=([veth2]=172.16.1.2 [veth4]=172.16.2.2 [veth5]=172.16.100.1)
> 
> Why do both loopback and veth5 exist with the same local ip. Can this just be lo?

Ah, yeah, looks like a leftover from previous version, thanks for
catching!

>> +	local -A route_devs
>> +	route_devs=([veth2]=0 [veth4]=0)
>> +
>> +	run_cmd "$IP address add 172.16.100.1/32 dev lo"
>> +	run_cmd "$IP ro add 172.16.102.0/24 nexthop via ${gws['veth2']} dev veth2 nexthop via ${gws['veth4']} dev veth4"
>> +	rc=0
>> +	for dev in veth2 veth4; do
>> +		match=0
>> +		from_ip="${local_ips[$dev]}"
>> +		for h in {1..254}; do
>> +			addr="172.16.102.$h"
>> +			if [ "$(get_route_dev_src "$addr" "$from_ip")" = "$dev" ]; then
>> +				match=1
>> +				break
>> +			fi
>> +		done
>> +		if (( match == 0 )); then
>> +			echo "SKIP: Did not find a route using device $dev"
>> +			return $ksft_skip
>> +		fi
>> +		run_cmd "$IP neigh add ${gws[$dev]} dev $dev nud failed"
>> +		if ! check_route_dev "$addr" "${other_dev[$dev]}"; then
>> +			rc=1
>> +			break
>> +		fi
>> +		run_cmd "$IP neigh del ${gws[$dev]} dev $dev"
>> +	done
>> +
>> +	log_test $rc 0 "Use valid neighbor during multipath selection"
>> +
>> +	from_ip="${local_ips["veth5"]}"
>> +	for h in {1..254}; do
>> +		addr="172.16.102.$h"
>> +		route_dev=$(get_route_dev_src "$addr" "$from_ip")
>> +		route_devs[$route_dev]=1
>> +	done
>> +	for dev in veth2 veth4; do
>> +		if [ ${route_devs[$dev]} -eq 0 ]; then
>> +			rc=1
>> +			break;
>> +		fi
>> +	done
>> +
>> +	log_test $rc 0 "Use both neighbors during multipath selection"
>> +
>> +	run_cmd "$IP neigh add 172.16.1.2 dev veth1 nud incomplete"
>> +	run_cmd "$IP neigh add 172.16.2.2 dev veth3 nud incomplete"
>> +	run_cmd "$IP route get 172.16.101.1"
>> +	# if we did not crash, success
>> +	log_test $rc 0 "Multipath selection with no valid neighbor"
>> +}
>> +
>>   ipv4_mpath_select()
>>   {
>>   	local rc dev match h addr
>> -- 
>> 2.47.3
>>
> 
> 


