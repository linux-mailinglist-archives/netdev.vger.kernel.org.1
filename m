Return-Path: <netdev+bounces-28436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3D77F6F4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D481C213C3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1845F13FF0;
	Thu, 17 Aug 2023 12:57:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3213FEC
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:57:38 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF4E2D7B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:57:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 406CC32002B6;
	Thu, 17 Aug 2023 08:57:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 17 Aug 2023 08:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692277053; x=1692363453; bh=qJyfxRFk5VeM7
	U3WSOpD5hcXrz4/9ZaM/Bsw4RAw5G0=; b=vroOpj9gDtisyFiK5MgvsageZ8VUg
	6GOhvIGXliw2nAK/J+f5ZbcyX5nji2Ta921bgQ5K+mqHPfcGCDGhobuxef2u+LuT
	QyGM20ftvN7lm6NwYPU988Czalf0fkyvOX0OM8zWh3IA0AMHzh8Mle4u+BEltUf1
	gB4CBh/yS6oF4WeIVqqleerMoEB+jlPra/zrRtWxH/sGzVygYX+af1El0uJmxcgi
	3Xxs/slFT4vaKrOJlQ/NrzAXVm8LmMfM3wMT926Alw7+M435Dfs+WYGwWCCcndG/
	Pn/vQout6VcK0LV+WZ0+IS1ELnHUneICgXB9kMPdjcMKMlZXv9R7hdMhw==
X-ME-Sender: <xms:PRneZD32NnglFBLZdrItGFEHakBe1KB_c-_kVfYscvq8HBBQD9yV2Q>
    <xme:PRneZCHC077kdtn-nZcc2RAMpHzN1dB-OiUG4qJrkVa4KiSqs7fnkpbN9DG5FRx6W
    IQ0A-478RZaS8A>
X-ME-Received: <xmr:PRneZD6mXwzgzEbc4wuraCxr9IlX_2T17xj8xhOHccJ949wCFIVPLCLs5SFoCnk_AzwybRlwifDES9ySlMNcCU6-1totxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepgfefgfettdfgudelfeelvefhkeetkeehgfdvkefhfefhleehtddtueejgfef
    leeinecuffhomhgrihhnpehfihgsthgvshhtshdrshhhnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhr
    gh
X-ME-Proxy: <xmx:PRneZI3oIH5AbYWhOAtJi106U2zpBfXvjY5xnvDWFw7Ph6R2yWOX5A>
    <xmx:PRneZGF2MSk2rP9ihc5kgVci_9p607BCP47j7QUn3dOa-gaWHORhpw>
    <xmx:PRneZJ8pvbrWjvXpwEHJNVu1kMKo65834Nq9bcQNK0RS3F5WyCF5TQ>
    <xmx:PRneZCih89p70L9jzvDDl15qH_GUhekLj0Yi1OaC90PQ6IS256cL_w>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Aug 2023 08:57:32 -0400 (EDT)
Date: Thu, 17 Aug 2023 15:57:29 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCHv6 net-next 2/2] selftests: fib_test: add a test case for
 IPv6 source address delete
Message-ID: <ZN4ZOfg5dQ50oUwD@shredder>
References: <20230816060724.1398842-1-liuhangbin@gmail.com>
 <20230816060724.1398842-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816060724.1398842-3-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This no longer applies after commit a63e10da42e7 ("selftests: fib_tests:
Add a test case for IPv6 garbage collection") so you will need to
rebase.

Thanks for the test cases. See a few comments below.

On Wed, Aug 16, 2023 at 02:07:24PM +0800, Hangbin Liu wrote:
> Add a test case for IPv6 source address delete. As David suggested, add tests:
> - Single device using src address
> - Two devices with the same source address
> - VRF with single device using src address
> - VRF with two devices using src address
> 
> As Ido points out, in IPv6, the preferred source address is looked up in
> the same VRF as the first nexthop device. This will give us similar results
> to IPv4 if the route is installed in the same VRF as the nexthop device, but
> not when the nexthop device is enslaved to a different VRF. So add tests:
> - src address and nexthop dev in same VR
> - src address and nexthop device in different VRF
> 
> The link local address delete logic is different from the global address.
> It should only affect the associate device it bonds to. Add tests cases
> for link local address testing.
> 
> The table 0 and same FIB info tests are copied from IPv4 tests.
> 
> Here is the test result:
> 
> IPv6 delete address route tests
>     Single device using src address
>     TEST: Prefsrc removed when src address removed on other device      [ OK ]
>     Two devices with the same source address
>     TEST: Prefsrc not removed when src address exist on other device    [ OK ]
>     VRF with single device using src address
>     TEST: Prefsrc removed when src address removed on other device      [ OK ]
>     VRF with two devices using src address
>     TEST: Prefsrc not removed when src address exist on other device    [ OK ]
>     src address and nexthop dev in same VRF
>     TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
>     TEST: Prefsrc in default VRF not removed                            [ OK ]
>     TEST: Prefsrc not removed from VRF when source address exist        [ OK ]
>     TEST: Prefsrc in default VRF removed                                [ OK ]
>     src address and nexthop device in different VRF
>     TEST: Prefsrc not removed from VRF when nexthop dev in diff VRF     [ OK ]
>     TEST: Prefsrc not removed in default VRF                            [ OK ]
>     TEST: Prefsrc removed from VRF when nexthop dev in diff VRF         [ OK ]
>     TEST: Prefsrc removed in default VRF                                [ OK ]
>     Same FIB info with different table ID
>     TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
>     TEST: Prefsrc in default VRF not removed                            [ OK ]
>     TEST: Prefsrc not removed from VRF when source address exist        [ OK ]
>     TEST: Prefsrc in default VRF removed                                [ OK ]
>     Table ID 0
>     TEST: Prefsrc removed from default VRF when source address deleted  [ OK ]
>     Link local source route
>     TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
>     TEST: Prefsrc removed when delete ll addr                           [ OK ]
>     TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
>     TEST: Prefsrc removed even ll addr still exist on other dev         [ OK ]
> 
> Tests passed:  21
> Tests failed:   0
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v7: add more tests as Ido and David suggested. Remove the IPv4 part as I want
>     to focus on the IPv6 fixes.
> ---
>  tools/testing/selftests/net/fib_tests.sh | 163 ++++++++++++++++++++++-
>  1 file changed, 162 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index 35d89dfa6f11..0aa17b2ac8e1 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -9,7 +9,7 @@ ret=0
>  ksft_skip=4
>  
>  # all tests in this script. Can be overridden with -t option
> -TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
> +TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
>  
>  VERBOSE=0
>  PAUSE_ON_FAIL=no
> @@ -1869,6 +1869,166 @@ ipv4_del_addr_test()
>  	cleanup
>  }
>  
> +ipv6_del_addr_test()
> +{
> +	echo
> +	echo "IPv6 delete address route tests"
> +
> +	setup
> +
> +	set -e
> +	for i in $(seq 6); do
> +		$IP li add dummy${i} up type dummy
> +	done
> +
> +	$IP li add red up type vrf table 1111
> +	$IP ro add vrf red unreachable default
> +	for i in $(seq 4 6); do
> +		$IP li set dummy${i} vrf red
> +	done
> +
> +	$IP addr add dev dummy1 fe80::1/128
> +	$IP addr add dev dummy1 2001:db8:101::1/64
> +	$IP addr add dev dummy1 2001:db8:101::10/64
> +	$IP addr add dev dummy1 2001:db8:101::11/64
> +	$IP addr add dev dummy1 2001:db8:101::12/64
> +	$IP addr add dev dummy1 2001:db8:101::13/64
> +	$IP addr add dev dummy1 2001:db8:101::14/64
> +	$IP addr add dev dummy1 2001:db8:101::15/64
> +	$IP addr add dev dummy2 fe80::1/128
> +	$IP addr add dev dummy2 2001:db8:101::1/64
> +	$IP addr add dev dummy2 2001:db8:101::11/64
> +	$IP addr add dev dummy3 fe80::1/128
> +
> +	$IP addr add dev dummy4 2001:db8:101::1/64
> +	$IP addr add dev dummy4 2001:db8:101::10/64
> +	$IP addr add dev dummy4 2001:db8:101::11/64
> +	$IP addr add dev dummy4 2001:db8:101::12/64
> +	$IP addr add dev dummy4 2001:db8:101::13/64
> +	$IP addr add dev dummy4 2001:db8:101::14/64
> +	$IP addr add dev dummy5 2001:db8:101::1/64
> +	$IP addr add dev dummy5 2001:db8:101::11/64
> +
> +	# Single device using src address
> +	$IP route add 2001:db8:110::/64 dev dummy3 src 2001:db8:101::10
> +	# Two devices with the same source address
> +	$IP route add 2001:db8:111::/64 dev dummy3 src 2001:db8:101::11
> +	# VRF with single device using src address
> +	$IP route add vrf red 2001:db8:110::/64 dev dummy6 src 2001:db8:101::10
> +	# VRF with two devices using src address
> +	$IP route add vrf red 2001:db8:111::/64 dev dummy6 src 2001:db8:101::11
> +	# src address and nexthop dev in same VRF
> +	$IP route add 2001:db8:112::/64 dev dummy3 src 2001:db8:101::12
> +	$IP route add vrf red 2001:db8:112::/64 dev dummy6 src 2001:db8:101::12
> +	# src address and nexthop device in different VRF
> +	$IP route add 2001:db8:113::/64 dev lo src 2001:db8:101::13
> +	$IP route add vrf red 2001:db8:113::/64 dev lo src 2001:db8:101::13
> +	# Same FIB info with different table ID

I suggest removing this test case as in IPv6 there is no sharing of FIB
info, unlike in IPv4.

> +	$IP route add 2001:db8:114::/64 via 2001:db8:101::2 src 2001:db8:101::14
> +	$IP route add vrf red 2001:db8:114::/64 via 2001:db8:101::2 src 2001:db8:101::14
> +	# table ID 0
> +	$IP route add table 0 2001:db8:115::/64 via 2001:db8:101::2 src 2001:db8:101::15
> +	# Link local source route
> +	$IP route add 2001:db8:116::/64 dev dummy2 src fe80::1
> +	$IP route add 2001:db8:117::/64 dev dummy3 src fe80::1
> +	set +e
> +
> +	echo "    Single device using src address"
> +
> +	$IP addr del dev dummy1 2001:db8:101::10/64
> +	$IP -6 route show | grep -q "src 2001:db8:101::10 "
> +	log_test $? 1 "Prefsrc removed when src address removed on other device"
> +
> +	echo "    Two devices with the same source address"
> +
> +	$IP addr del dev dummy1 2001:db8:101::11/64
> +	$IP -6 route show | grep -q "src 2001:db8:101::11 "
> +	log_test $? 0 "Prefsrc not removed when src address exist on other device"

What about deleting the address from dummy2 and checking that the
preferred source address is removed from the route? I know it's similar
to the previous case, but still a good test case.

> +
> +	echo "    VRF with single device using src address"
> +
> +	$IP addr del dev dummy4 2001:db8:101::10/64
> +	$IP -6 route show vrf red | grep -q "src 2001:db8:101::10 "
> +	log_test $? 1 "Prefsrc removed when src address removed on other device"
> +
> +	echo "    VRF with two devices using src address"
> +
> +	$IP addr del dev dummy4 2001:db8:101::11/64
> +	$IP -6 route show vrf red | grep -q "src 2001:db8:101::11 "
> +	log_test $? 0 "Prefsrc not removed when src address exist on other device"

Likewise.

> +
> +	echo "    src address and nexthop dev in same VRF"
> +
> +	$IP addr del dev dummy4 2001:db8:101::12/64
> +	$IP -6 route show vrf red | grep -q "src 2001:db8:101::12 "
> +	log_test $? 1 "Prefsrc removed from VRF when source address deleted"
> +	$IP -6 route show | grep -q " src 2001:db8:101::12 "
> +	log_test $? 0 "Prefsrc in default VRF not removed"
> +
> +	$IP addr add dev dummy4 2001:db8:101::12/64
> +	$IP route replace vrf red 2001:db8:112::/64 dev dummy6 src 2001:db8:101::12
> +	$IP addr del dev dummy1 2001:db8:101::12/64
> +	$IP -6 route show vrf red | grep -q "src 2001:db8:101::12 "
                                             ^
Please be consistent about the space before "src". In some places you
have it and in some you don't.

> +	log_test $? 0 "Prefsrc not removed from VRF when source address exist"
> +	$IP -6 route show | grep -q " src 2001:db8:101::12 "
> +	log_test $? 1 "Prefsrc in default VRF removed"
> +
> +	echo "    src address and nexthop device in different VRF"
> +
> +	$IP addr del dev dummy4 2001:db8:101::13/64
> +	$IP -6 route show vrf red | grep -q "src 2001:db8:101::13 "
> +	log_test $? 0 "Prefsrc not removed from VRF when nexthop dev in diff VRF"
> +	$IP -6 route show | grep -q " src 2001:db8:101::13 "
> +	log_test $? 0 "Prefsrc not removed in default VRF"
> +
> +	$IP addr add dev dummy4 2001:db8:101::13/64
> +	$IP addr del dev dummy1 2001:db8:101::13/64
> +	$IP -6 route show vrf red | grep -q "src 2001:db8:101::13 "
> +	log_test $? 1 "Prefsrc removed from VRF when nexthop dev in diff VRF"
> +	$IP -6 route show | grep -q " src 2001:db8:101::13 "
> +	log_test $? 1 "Prefsrc removed in default VRF"
> +
> +	echo "    Same FIB info with different table ID"
> +
> +	$IP addr del dev dummy4 2001:db8:101::14/64
> +	$IP -6 route show vrf red | grep -q "src 2001:db8:101::14 "
> +	log_test $? 1 "Prefsrc removed from VRF when source address deleted"
> +	$IP -6 route show | grep -q " src 2001:db8:101::14 "
> +	log_test $? 0 "Prefsrc in default VRF not removed"
> +
> +	$IP addr add dev dummy4 2001:db8:101::14/64
> +	$IP route replace vrf red 2001:db8:114::/64 via 2001:db8:101::2 src 2001:db8:101::14
> +	$IP addr del dev dummy1 2001:db8:101::14/64
> +	$IP -6 route show vrf red | grep -q "src 2001:db8:101::14 "
> +	log_test $? 0 "Prefsrc not removed from VRF when source address exist"
> +	$IP -6 route show | grep -q " src 2001:db8:101::14 "
> +	log_test $? 1 "Prefsrc in default VRF removed"
> +
> +	echo "    Table ID 0"
> +
> +	$IP addr del dev dummy1 2001:db8:101::15/64
> +	$IP -6 route show | grep -q "src 2001:db8:101::15"
> +	log_test $? 1 "Prefsrc removed from default VRF when source address deleted"
> +
> +	echo "    Link local source route"
> +	$IP addr del dev dummy1 fe80::1/128
> +	$IP -6 route show | grep -q "2001:db8:116::/64 dev dummy2 src fe80::1"
> +	log_test $? 0 "Prefsrc not removed when delete ll addr from other dev"
> +	$IP addr del dev dummy2 fe80::1/128
> +	$IP -6 route show | grep -q "2001:db8:116::/64 dev dummy2 src fe80::1"
> +	log_test $? 1 "Prefsrc removed when delete ll addr"
> +	$IP -6 route show | grep -q "2001:db8:117::/64 dev dummy3 src fe80::1"
> +	log_test $? 0 "Prefsrc not removed when delete ll addr from other dev"
> +	$IP addr add dev dummy1 fe80::1/128
> +	$IP addr del dev dummy3 fe80::1/128
> +	$IP -6 route show | grep -q "2001:db8:117::/64 dev dummy3 src fe80::1"
> +	log_test $? 1 "Prefsrc removed even ll addr still exist on other dev"
> +
> +	for i in $(seq 6); do
> +		$IP li del dummy${i}
> +	done
> +	cleanup
> +}
>  
>  ipv4_route_v6_gw_test()
>  {
> @@ -2211,6 +2371,7 @@ do
>  	ipv6_addr_metric)		ipv6_addr_metric_test;;
>  	ipv4_addr_metric)		ipv4_addr_metric_test;;
>  	ipv4_del_addr)			ipv4_del_addr_test;;
> +	ipv6_del_addr)			ipv6_del_addr_test;;
>  	ipv6_route_metrics)		ipv6_route_metrics_test;;
>  	ipv4_route_metrics)		ipv4_route_metrics_test;;
>  	ipv4_route_v6_gw)		ipv4_route_v6_gw_test;;
> -- 
> 2.38.1
> 

