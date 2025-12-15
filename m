Return-Path: <netdev+bounces-244831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A536CBF79E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 20:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6189430164CE
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EEC28C862;
	Mon, 15 Dec 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pLyLtFSt"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AA2494F0
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825294; cv=none; b=SmaWD/ETS6c+9d+xhvf13vFoVCEJ1PMCWeIZ/TQjd15xdpYX9NlMEetSljZLkTrkA+5M3iMTsbq9CpuUVBClHSN6PAIdFLyAPwU06khdNAwVhjOrar1J6PRK85hlnP9IsQNGYZuoijip4NSqnqaE1wAlcA3ro/GbL2cHCDqzglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825294; c=relaxed/simple;
	bh=Cz9syAheLkwg8RSqR+wRynFTx1zZ4dlT7aiaNsNBNrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JittIaLDEF+iQj4fQNBhWvkHHKVlSuXGZk2OepM8FpZHssi8rkRdZRdL+oLA2DM/0dOGReaMYJhvwzt91iOZqml6XyfaMwOJoVliNryOB7xpPc12MzCLd1NLv4MU6269xF/tXSdnEk+DqG4sGwdhJUfA043craofkG/Gbqkuets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pLyLtFSt; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8bdd9a18-018e-4b87-a2e0-e7d1080b3bf3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765825289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+a5hShS2j3JyVxg/IWCFAXcQwoVvcFKqUQww0+gsUd4=;
	b=pLyLtFSt/PetCs2bM8wlzHoE2Al7OaXjlvl2gzCDL/iuM6+ILPbUEF6BWpNQ3I/LZatrPm
	mNjk3xrHwxfIiJTGAYsMKN1T4zNuQXHQzhw8ssar9LAuj3INLkwK7pyH9gtMKkuTMgy6bL
	gYxPJOgZpGAzNEiXnpF4YkOXX7DhSUg=
Date: Mon, 15 Dec 2025 20:01:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/2] selftests: fib_nexthops: Add test case for ipv4
 multi nexthops
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
 <20251213135849.2054677-2-vadim.fedorenko@linux.dev>
 <aT-x1ZQtu4rsGxgI@shredder>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aT-x1ZQtu4rsGxgI@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/12/2025 06:59, Ido Schimmel wrote:
> On Sat, Dec 13, 2025 at 01:58:49PM +0000, Vadim Fedorenko wrote:
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
>> +	local -A route_devs
>> +	route_devs=([veth2]=0 [veth4]=0)
>> +
>> +	run_cmd "$IP address add 172.16.100.1/32 dev lo"
>> +	run_cmd "$IP ro add 172.16.102.0/24 nexthop via ${gws['veth2']} dev veth2 nexthop via ${gws['veth4']} dev veth4"
> 
> fib_nexthops.sh is for tests using nexthop objects: "This test is for
> checking IPv4 and IPv6 FIB behavior with nexthop objects".
> 
> I suggest moving this to fib_tests.sh. See commit 4d0dac499bf3
> ("selftests/net: test tcp connection load balancing") that was added as
> a test for the blamed commit.

Yep, got it. Will move in v2


