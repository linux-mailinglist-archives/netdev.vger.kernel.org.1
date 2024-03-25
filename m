Return-Path: <netdev+bounces-81716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F088AF96
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84342BE36A6
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC947173A;
	Mon, 25 Mar 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZDg6JCa"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E85CDE9
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390372; cv=none; b=Yp30Q13awAAArfTRaB9ferw/AtsngAzd4bp32xP/Dk98OIAIpIrP8icr7moAlzVgujD5YTM8bVbSUwfFzMUheBA1KRvMKSwBcYsH5yPcjFudJEXwrkiH39VmsIsMMKqyl1ZYMIx9iA8KD/MV8epjruAeD85yWLnzXQ2dMUUgNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390372; c=relaxed/simple;
	bh=3js9m8LIdIDOjS15vaBNl4Xy7s/1IUTNRl1J7ho5058=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgnmPN+K+AS+jS2donPlR30k9SxDhSF5f7LSuIgeAjTWenyPoRhYg8m/+NfvFTYrG9NZ5w9GZkRhiryFjlLgDl6+KR/NU7l9eYET3Oa13gAbC7hSHwjpPjlbVOq/6zi8fdZzfaUBvcG19LqN3Z1xKngxOB0ZGAzA8qVO9aCWmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZDg6JCa; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <20e4ebd6-0f75-4472-88f3-96d07af6f665@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711390366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbwcdWTRc+bUk4Dft1mEuyAA2zHW3fKnc5xu7hZzC2A=;
	b=HZDg6JCaizG48xLEOh4+6nCPwIU6zmoorMzWHkis2a+C3Z3zKSMfirPz60RcVPYCf39SJZ
	zzvqtI3hmOZZb/LWghZ6fzBI/rvQYKKEs3r8ZmooAr4MU6BMOe2CC9IdPDQuI23hKbjbIq
	+hBwxhkUHZd3qhMiDeSln/ZT+0xSbX0=
Date: Mon, 25 Mar 2024 11:12:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 2/2] selftests/bpf: Add BPF_FIB_LOOKUP_MARK
 tests
Content-Language: en-US
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20240322140244.50971-1-aspsk@isovalent.com>
 <20240322140244.50971-3-aspsk@isovalent.com>
 <e8062ef6-b630-45e2-8009-4d2cdc0970ea@linux.dev>
 <ZgBA6X0QgP+TMFd9@zh-lab-node-5>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZgBA6X0QgP+TMFd9@zh-lab-node-5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/24/24 8:04 AM, Anton Protopopov wrote:
> On Sat, Mar 23, 2024 at 03:34:10PM -0700, Martin KaFai Lau wrote:
>> On 3/22/24 7:02 AM, Anton Protopopov wrote:
>>> This patch extends the fib_lookup test suite by adding a few test
>>> cases for each IP family to test the new BPF_FIB_LOOKUP_MARK flag
>>> to the bpf_fib_lookup:
>>>
>>>     * Test destination IP address selection with and without a mark
>>>       and/or the BPF_FIB_LOOKUP_MARK flag set
>>>
>>> To test this functionality another network namespace and a new veth
>>> pair were added to the test.
>>>
>>
>> [ ... ]
>>
>>>    static const struct fib_lookup_test tests[] = {
>>> @@ -90,10 +105,47 @@ static const struct fib_lookup_test tests[] = {
>>>    	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>>    	  .expected_src = IPV6_IFACE_ADDR_SEC,
>>>    	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
>>> +	/* policy routing */
>>> +	{ .desc = "IPv4 policy routing, default",
>>> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>> +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
>>> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
>>> +	{ .desc = "IPv4 policy routing, mark doesn't point to a policy",
>>> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>> +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
>>> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
>>> +	  .mark = MARK_NO_POLICY, },
>>> +	{ .desc = "IPv4 policy routing, mark points to a policy",
>>> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>> +	  .expected_dst = IPV4_GW2, .ifname = "veth3",
>>> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
>>> +	  .mark = MARK, },
>>> +	{ .desc = "IPv4 policy routing, mark points to a policy, but no flag",
>>> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>> +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
>>> +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
>>> +	  .mark = MARK, },
>>> +	{ .desc = "IPv6 policy routing, default",
>>> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>> +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
>>> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
>>> +	{ .desc = "IPv6 policy routing, mark doesn't point to a policy",
>>> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>> +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
>>> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
>>> +	  .mark = MARK_NO_POLICY, },
>>> +	{ .desc = "IPv6 policy routing, mark points to a policy",
>>> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>> +	  .expected_dst = IPV6_GW2, .ifname = "veth3",
>>> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
>>> +	  .mark = MARK, },
>>> +	{ .desc = "IPv6 policy routing, mark points to a policy, but no flag",
>>> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>>> +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
>>> +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
>>> +	  .mark = MARK, },
>>>    };
>>> -static int ifindex;
>>> -
>>>    static int setup_netns(void)
>>>    {
>>>    	int err;
>>> @@ -144,12 +196,40 @@ static int setup_netns(void)
>>>    	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth1.forwarding)"))
>>>    		goto fail;
>>> +	/* Setup for policy routing tests */
>>> +	SYS(fail, "ip link add veth3 type veth peer name veth4");
>>> +	SYS(fail, "ip link set dev veth3 up");
>>> +	SYS(fail, "ip link set dev veth4 netns %s up", NS_REMOTE);
>>> +
>>> +	SYS(fail, "ip addr add %s/24 dev veth3", IPV4_LOCAL);
>>> +	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW1);
>>> +	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW2);
>>> +	SYS(fail, "ip addr add %s/64 dev veth3 nodad", IPV6_LOCAL);
>>> +	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW1);
>>> +	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW2);
>>
>> Trying to see if the setup can be simplified.
>>
>> Does it need to add another netns and setup a reachable IPV[46]_GW[12] gateway?
>>
>> The test is not sending any traffic and it is a BPF_FIB_LOOKUP_SKIP_NEIGH test.
> 
> I think this will not work without another namespace, as FIB lookup will
> return DST="final destination", not DST="gateway", as the gateway is in the
> same namespace and can be skipped.

hmm... not sure I understand why it would get "final destination". Am I missing something?
To be specific, there is no need to configure the IPV[46]_GW[12] address:

-	SYS(fail, "ip link set dev veth4 netns %s up", NS_REMOTE);

	SYS(fail, "ip addr add %s/24 dev veth3", IPV4_LOCAL);
-	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW1);
-	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW2);
	SYS(fail, "ip addr add %s/64 dev veth3 nodad", IPV6_LOCAL);
-	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW1);
-	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW2);
	SYS(fail, "ip route add %s/32 via %s", IPV4_REMOTE_DST, IPV4_GW1);
	SYS(fail, "ip route add %s/32 via %s table %s", IPV4_REMOTE_DST, IPV4_GW2, MARK_TABLE);
	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_REMOTE_DST, IPV6_GW1);
	SYS(fail, "ip -6 route add %s/128 via %s table %s", IPV6_REMOTE_DST, IPV6_GW2, MARK_TABLE);
	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);

[root@arch-fb-vm1 ~]# ip netns exec fib_lookup_ns /bin/bash

[root@arch-fb-vm1 ~]# ip -6 rule
0:	from all lookup local
2:	from all fwmark 0x2a lookup 200
32766:	from all lookup main

[root@arch-fb-vm1 ~]# ip -6 route show table main
be:ef::b0:10 via fd01::1 dev veth3 metric 1024 linkdown pref medium

[root@arch-fb-vm1 ~]# ip -6 route show table 200
be:ef::b0:10 via fd01::2 dev veth3 metric 1024 linkdown pref medium

[root@arch-fb-vm1 ~]# ip -6 route get be:ef::b0:10
be:ef::b0:10 from :: via fd01::1 dev veth3 src fd01::3 metric 1024 pref medium

[root@arch-fb-vm1 ~]# ip -6 route get be:ef::b0:10 mark 0x2a
be:ef::b0:10 from :: via fd01::2 dev veth3 table 200 src fd01::3 metric 1024 pref medium

> 
> Instead of adding a new namespace I can move the second interface to the
> root namespace. This will work, but then we're interfering with the root
> namespace.
> 
>>> +	SYS(fail, "ip route add %s/32 via %s", IPV4_REMOTE_DST, IPV4_GW1);
>>> +	SYS(fail, "ip route add %s/32 via %s table %s", IPV4_REMOTE_DST, IPV4_GW2, MARK_TABLE);
>>> +	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_REMOTE_DST, IPV6_GW1);
>>> +	SYS(fail, "ip -6 route add %s/128 via %s table %s", IPV6_REMOTE_DST, IPV6_GW2, MARK_TABLE);
>>> +	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
>>> +	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
>>> +
>>> +	err = write_sysctl("/proc/sys/net/ipv4/conf/veth3/forwarding", "1");
>>> +	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf.veth3.forwarding)"))
>>> +		goto fail;
>>> +
>>> +	err = write_sysctl("/proc/sys/net/ipv6/conf/veth3/forwarding", "1");
>>> +	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth3.forwarding)"))
>>> +		goto fail;
>>> +
>>>    	return 0;
>>>    fail:
>>>    	return -1;
>>>    }
>>
>> [ ... ]
>>
>>> @@ -248,6 +337,7 @@ void test_fib_lookup(void)
>>>    	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
>>>    	SYS(fail, "ip netns add %s", NS_TEST);
>>> +	SYS(fail, "ip netns add %s", NS_REMOTE);
>>
>>


