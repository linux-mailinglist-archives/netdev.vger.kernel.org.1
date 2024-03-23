Return-Path: <netdev+bounces-81386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0692887AA0
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 23:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF50B21369
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 22:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D657383B9;
	Sat, 23 Mar 2024 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGm9z0WJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9341F168
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233264; cv=none; b=KXO2Loh8uKhcEPuMnM57sgLc3dXRtAqrjOBd8Y/t+YxvSbMY/zz3caJL23k5zxS/GK987ganYpTHA5+Z0qkuQv6oMMaREuoiUpF0ALfqBFps62gStuzWgFOVWr+guIjiwTkdduZWbQc1SQjGoOlulib5hrJHGoDEvs8H+IAdEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233264; c=relaxed/simple;
	bh=jSc/f6KNrT4dRGrDfXkgMbmzfQSuHTd5xlGEYqjjS+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bULbeMKLeE8lHI2RFvxi6TGJhPFkGfhjLM/qpW1n1RFnz93hNc9BiXHcV7iVnOuRoQfwhfREx+EVNkB4V6JnncFqHeDY8461mJnM1BFdvrtezVdkZEfDNL6A3YJFp5fj3GAfb4QRdWNxK8/fvdyPnIpy/QYKbnscQJDV1PpKYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGm9z0WJ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8062ef6-b630-45e2-8009-4d2cdc0970ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711233259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xCKYtbmHcZMip7AQYLMjc8FFzO4rsGABhN/J5Ub8Sc=;
	b=iGm9z0WJgwpGRlvLB0hx1ObsOUTZu/ZeP7YY53fgHADIqJ+w9SIH1MWTS1zTJcGWmFzKsW
	uMufMt4uFbWmOvr1XZ2+D4jqCf26OvEheDoFiElhaKOacvs3SgJwUKxA2PVQ+iG6lyww84
	dFN5CI8VEIe7vDL6RF1hDs+Z6y1m0hY=
Date: Sat, 23 Mar 2024 15:34:10 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240322140244.50971-3-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/22/24 7:02 AM, Anton Protopopov wrote:
> This patch extends the fib_lookup test suite by adding a few test
> cases for each IP family to test the new BPF_FIB_LOOKUP_MARK flag
> to the bpf_fib_lookup:
> 
>    * Test destination IP address selection with and without a mark
>      and/or the BPF_FIB_LOOKUP_MARK flag set
> 
> To test this functionality another network namespace and a new veth
> pair were added to the test.
> 

[ ... ]

>   static const struct fib_lookup_test tests[] = {
> @@ -90,10 +105,47 @@ static const struct fib_lookup_test tests[] = {
>   	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
>   	  .expected_src = IPV6_IFACE_ADDR_SEC,
>   	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> +	/* policy routing */
> +	{ .desc = "IPv4 policy routing, default",
> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> +	{ .desc = "IPv4 policy routing, mark doesn't point to a policy",
> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK_NO_POLICY, },
> +	{ .desc = "IPv4 policy routing, mark points to a policy",
> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV4_GW2, .ifname = "veth3",
> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK, },
> +	{ .desc = "IPv4 policy routing, mark points to a policy, but no flag",
> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK, },
> +	{ .desc = "IPv6 policy routing, default",
> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> +	{ .desc = "IPv6 policy routing, mark doesn't point to a policy",
> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK_NO_POLICY, },
> +	{ .desc = "IPv6 policy routing, mark points to a policy",
> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV6_GW2, .ifname = "veth3",
> +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK, },
> +	{ .desc = "IPv6 policy routing, mark points to a policy, but no flag",
> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK, },
>   };
>   
> -static int ifindex;
> -
>   static int setup_netns(void)
>   {
>   	int err;
> @@ -144,12 +196,40 @@ static int setup_netns(void)
>   	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth1.forwarding)"))
>   		goto fail;
>   
> +	/* Setup for policy routing tests */
> +	SYS(fail, "ip link add veth3 type veth peer name veth4");
> +	SYS(fail, "ip link set dev veth3 up");
> +	SYS(fail, "ip link set dev veth4 netns %s up", NS_REMOTE);
> +
> +	SYS(fail, "ip addr add %s/24 dev veth3", IPV4_LOCAL);
> +	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW1);
> +	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW2);
> +	SYS(fail, "ip addr add %s/64 dev veth3 nodad", IPV6_LOCAL);
> +	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW1);
> +	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW2);

Trying to see if the setup can be simplified.

Does it need to add another netns and setup a reachable IPV[46]_GW[12] gateway?

The test is not sending any traffic and it is a BPF_FIB_LOOKUP_SKIP_NEIGH test.

> +	SYS(fail, "ip route add %s/32 via %s", IPV4_REMOTE_DST, IPV4_GW1);
> +	SYS(fail, "ip route add %s/32 via %s table %s", IPV4_REMOTE_DST, IPV4_GW2, MARK_TABLE);
> +	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_REMOTE_DST, IPV6_GW1);
> +	SYS(fail, "ip -6 route add %s/128 via %s table %s", IPV6_REMOTE_DST, IPV6_GW2, MARK_TABLE);
> +	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
> +	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
> +
> +	err = write_sysctl("/proc/sys/net/ipv4/conf/veth3/forwarding", "1");
> +	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf.veth3.forwarding)"))
> +		goto fail;
> +
> +	err = write_sysctl("/proc/sys/net/ipv6/conf/veth3/forwarding", "1");
> +	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth3.forwarding)"))
> +		goto fail;
> +
>   	return 0;
>   fail:
>   	return -1;
>   }

[ ... ]

> @@ -248,6 +337,7 @@ void test_fib_lookup(void)
>   	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
>   
>   	SYS(fail, "ip netns add %s", NS_TEST);
> +	SYS(fail, "ip netns add %s", NS_REMOTE);



