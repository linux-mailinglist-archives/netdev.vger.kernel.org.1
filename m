Return-Path: <netdev+bounces-185037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47463A984ED
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7B175909
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2DF2749CA;
	Wed, 23 Apr 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gG7lonYa"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45660269817
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399154; cv=none; b=Wb9GX4gsZdsC44n1uCtKcS9Yj3LNeXYy9ejYkUZnmX6c0RCOIPqB7VPkYZpS9kMqa0E3178zyH369YIPqu4lKVgnNSrFXvgqJ/uQpQkGu3R5m2UySSERiTNVuanjP/sRls6zWeEHlutIDkIm1Q83Q7buf3J8OWNTLq+WrifhYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399154; c=relaxed/simple;
	bh=APq3mglsUDP2ejj4lVqBbe9+wTdyYYcqey16yOlR2Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk35AhFrE50Iqy1PHFswDKhPyvRyC8tmZiK48otoYgtf+eshlTm00HMAjkuuimcVQfEAfhg9X78Zxx3n282sdhzl5CqdhAmnF9q99lidKPnoq+EKa7JizggcBUn67VO7l4aeJ+g23y/4MHgPfwNN7RMJLuswAyAxldpQScaBkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gG7lonYa; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EE4A11402A8;
	Wed, 23 Apr 2025 05:05:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Apr 2025 05:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745399151; x=1745485551; bh=rjf+2TL4EimRk5tYzHajyRdl6LlmS0LDbCK
	c0X19gCg=; b=gG7lonYajXZjvVjkghXZi32iImVfnDTGMiBcL+HehcAnZT344SH
	kdxWJou+0j0AEcmJE2ienDglIbOzrf7k1kJGCVMZ0jpz+Ct7qmelRKknBydtdPdI
	ZyeI2EW2nJrOmtXnUB0PP3+R5qNdprncc+9EGXrjJLEQ4XLq+ImsSJKLcdKbaoru
	9nKSnPiQ25vcvtI3u7s7h4KhN2FFLcO8dJc9UsJC/UbZyRFTHbwKSYy/r5IN2V5p
	v0Taev2Z1ot8NecmcBK/jjy/dm1y5qMnUg+sPqaepWu6BmaEp9x9mbLOhJdmWtOj
	bZnAL1of2Nzg1P1v3ajgsC312TSgq4AvkrA==
X-ME-Sender: <xms:bq0IaLI6UptANHijCOTGwnTwFn5UCgLWrLQ0TilCoQN_M8woDtMGnA>
    <xme:bq0IaPIFzcJ-DFgINxkVi9ZnvH-zhI5LmpnhktUmbqxiNXQJbAn1wYZqnX1FCFynt
    Xzb4gTwVKwmNtQ>
X-ME-Received: <xmr:bq0IaDtMG3Oj9Ng9t5rjgi4BkaKKpjLY5DDJq_v1Sb1lQsKqqgiMbg8AcWVi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhllhgvmhguvg
    gsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprg
    gsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepihguohhstghhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:bq0IaEbjYz6_wqW0G9sciNaXvHnXpqIpN32iNti247Mxv05op8cigw>
    <xmx:bq0IaCZthMOrtBiUWTjI4a2UEbKUMMB3ApGWEBCZq9zZDJ-fP-zESg>
    <xmx:bq0IaIA5YU2YfewE3OlHPPz_uwnNrWTc9bmiE2-NJHiV_qZncep2rQ>
    <xmx:bq0IaAYNrMBCU-TXVLrrqk7UOA55mVLrwsOdEJDLBt9epn6lWtyxtA>
    <xmx:b60IaDXt4Ycvm8T6zuhCixqtDsb0mhzHQW3DH2pTrKfVhtvH8i2LxB8J>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 05:05:50 -0400 (EDT)
Date: Wed, 23 Apr 2025 12:05:46 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	horms@kernel.org, idosch@nvidia.com, kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 3/3] selftests/net: test tcp connection load
 balancing
Message-ID: <aAitarcdcgq9x6uL@shredder>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
 <20250420180537.2973960-4-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420180537.2973960-4-willemdebruijn.kernel@gmail.com>

On Sun, Apr 20, 2025 at 02:04:31PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Verify that TCP connections use both routes when connecting multiple
> times to a remote service over a two nexthop multipath route.
> 
> Use netcat to create the connections. Use tc prio + tc filter to
> count routes taken, counting SYN packets across the two egress
> devices.
> 
> To avoid flaky tests when testing inherently randomized behavior,
> set a low bar and pass if even a single SYN is observed on both
> devices.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> Integrated into fib_nexthops.sh as it covers multipath nexthop
> routing and can reuse all of its setup(), but technically the test
> does not use nexthop *objects* as is, so I can also move into a
> separate file and move common setup code to lib.sh if preferred.

No strong preference, but fib_nexthops.sh explicitly tests nexthop
objects, so including here a test that doesn't use them is a bit weird.
Did you consider putting this in fib_tests.sh instead?

> ---
>  tools/testing/selftests/net/fib_nexthops.sh | 83 +++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> index b39f748c2572..93d19e92bd5b 100755
> --- a/tools/testing/selftests/net/fib_nexthops.sh
> +++ b/tools/testing/selftests/net/fib_nexthops.sh
> @@ -31,6 +31,7 @@ IPV4_TESTS="
>  	ipv4_compat_mode
>  	ipv4_fdb_grp_fcnal
>  	ipv4_mpath_select
> +	ipv4_mpath_balance
>  	ipv4_torture
>  	ipv4_res_torture
>  "
> @@ -45,6 +46,7 @@ IPV6_TESTS="
>  	ipv6_compat_mode
>  	ipv6_fdb_grp_fcnal
>  	ipv6_mpath_select
> +	ipv6_mpath_balance
>  	ipv6_torture
>  	ipv6_res_torture
>  "
> @@ -2110,6 +2112,87 @@ ipv4_res_torture()
>  	log_test 0 0 "IPv4 resilient nexthop group torture test"
>  }
>  
> +# Install a prio qdisc with separate bands counting IPv4 and IPv6 SYNs
> +tc_add_syn_counter() {
> +	local -r dev=$1
> +
> +	# qdisc with band 1 for no-match, band 2 for ipv4, band 3 for ipv6
> +	ip netns exec $me tc qdisc add dev $dev root handle 1: prio bands 3 \
> +		priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> +	ip netns exec $me tc qdisc add dev $dev parent 1:1 handle 2: pfifo
> +	ip netns exec $me tc qdisc add dev $dev parent 1:2 handle 4: pfifo
> +	ip netns exec $me tc qdisc add dev $dev parent 1:3 handle 6: pfifo
> +
> +	# ipv4 filter on SYN flag set: band 2
> +	ip netns exec $me tc filter add dev $dev parent 1: protocol ip u32 \
> +		match ip protocol 6 0xff \
> +		match ip dport 8000 0xffff \
> +		match u8 0x02 0xff at 33 \
> +		flowid 1:2
> +
> +	# ipv6 filter on SYN flag set: band 3
> +	ip netns exec $me tc filter add dev $dev parent 1: protocol ipv6 u32 \
> +		match ip6 protocol 6 0xff \
> +		match ip6 dport 8000 0xffff \
> +		match u8 0x02 0xff at 53 \
> +		flowid 1:3
> +}
> +
> +tc_get_syn_counter() {
> +	ip netns exec $me tc -j -s qdisc show dev $1 handle $2 | jq .[0].packets
> +}
> +
> +ip_mpath_balance() {
> +	local -r ipver="-$1"
> +	local -r daddr=$2
> +	local -r handle="$1:"
> +	local -r num_conn=20
> +
> +	tc_add_syn_counter veth1
> +	tc_add_syn_counter veth3
> +
> +	for i in $(seq 1 $num_conn); do
> +		ip netns exec $remote nc $ipver -l -p 8000 >/dev/null &
> +		echo -n a | ip netns exec $me nc $ipver -q 0 $daddr 8000

I don't have the '-q' option in Fedora:

# ./fib_nexthops.sh -t ipv4_mpath_balance
nc: invalid option -- 'q'
[...]
Tests passed:   0
Tests failed:   1
Tests skipped:  0

We had multiple problems in the past with 'nc' because of different
distributions using different versions. See for example:

ba6fbd383c12dfe6833968e3555ada422720a76f
5e8670610b93158ffacc3241f835454ff26a3469

Maybe use 'socat' instead?

> +	done
> +
> +	local -r syn0="$(tc_get_syn_counter veth1 $handle)"
> +	local -r syn1="$(tc_get_syn_counter veth3 $handle)"
> +	local -r syns=$((syn0+syn1))
> +
> +	[ "$VERBOSE" = "1" ] && echo "multipath: syns seen: ($syn0,$syn1)"
> +
> +	[[ $syns -ge $num_conn ]] && [[ $syn0 -gt 0 ]] && [[ $syn1 -gt 0 ]]

IIUC, this only tests that connections to the same destination address
and destination port are load balanced across all the paths (patch #2),
but it doesn't test that each connection uses the source address of the
egress interface (patch #1). Any reason not to test both? I'm asking
because I expect the current test to pass even without both patches.

I noticed that you are using tc-u32 for the matching, but with tc-flower
you can easily match on both 'src_ip' and 'tcp_flags'.

> +}
> +
> +ipv4_mpath_balance()
> +{
> +	$IP route add 172.16.101.1 \
> +		nexthop via 172.16.1.2 \
> +		nexthop via 172.16.2.2
> +
> +	ip netns exec $me \
> +		sysctl -q -w net.ipv4.fib_multipath_hash_policy=1
> +
> +	ip_mpath_balance 4 172.16.101.1
> +
> +	log_test $? 0 "Multipath loadbalance"
> +}
> +
> +ipv6_mpath_balance()
> +{
> +	$IP route add 2001:db8:101::1\
> +		nexthop via 2001:db8:91::2 \
> +		nexthop via 2001:db8:92::2
> +
> +	ip netns exec $me \
> +		sysctl -q -w net.ipv6.fib_multipath_hash_policy=1
> +
> +	ip_mpath_balance 6 2001:db8:101::1
> +
> +	log_test $? 0 "Multipath loadbalance"
> +}
> +
>  basic()
>  {
>  	echo
> -- 
> 2.49.0.805.g082f7c87e0-goog
> 
> 

