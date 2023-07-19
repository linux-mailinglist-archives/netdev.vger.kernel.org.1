Return-Path: <netdev+bounces-18936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1F75921E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22382816EF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903CC125BB;
	Wed, 19 Jul 2023 09:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83964101D3
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:55:01 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDF10D4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:54:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb1baf55f5so40354535ad.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689760498; x=1692352498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq0rBHazfBb2Q8XFeozld6kgFaWWPW/wuQ0P05Jqm9w=;
        b=UmDy6JkyNlw6fYqwZGIo0u7NWK7sBvmvazzGQ/y2P5q2fpJAng8i+wIllv42P4oWAJ
         0S80oYcrfRHfsYRXz65UGyV2jbE6541cX8VQ/9KqnAIaGXO75uwu8gw4mlTWAqHUxiwG
         WdODBNKgL0GUhBoBs4GG5m/9q5pAjbC1Jv8oPZ59DjTExch4tfnUfDm3jZJAH7p86+44
         nikcy2aAqqX4S5BZ1VwOT/OZjtKuKP/J2NeHZJfkCo/ScLJiXPDiDcRDLDFnlDA8IY8f
         Nza55JPD7TLZBc/EZ43/UhEJG5mZlzG+M9fZ5EyaajdVBhrEN8lf/mhIZSU2ZkRCxPpo
         6U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689760498; x=1692352498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gq0rBHazfBb2Q8XFeozld6kgFaWWPW/wuQ0P05Jqm9w=;
        b=P/iS25HDW1ug/pgvik2u0bV+iC1bTAd32oVi8e3HpKDgP/J+OCvpkoTNH8HB06pnkD
         TsA2W5YVIproNh2XrShsFTfDX9X/THLNmvyl/pg+vZf9/X0Vkwx/27tEFlyqXA8rv2gb
         wwZbvqdQNjzjMRmntw5LEUFHFgKFYfaOtGGeiXCOwekIjR6FAM2azFpM/Ltpu8C187/j
         NNb8ffOnl8Ef0hX+QlrqNaF7DisEWn1210KLAVCxgumn/TcSsvXDxrp3F5t066RGDc22
         HIysjcQhmhz2regjOp5FVoAPrYt984DtfJL56UJpeKADMy3iivydFKYA7Df+dOpjm8g5
         KNjg==
X-Gm-Message-State: ABy/qLagxkQB+87HpNQ2M/s6i+yptIwtS6QYEtYskfonnZPDVIA50Zo3
	dGz3dNUXGvvK15a1/6GQiEnM5WtAFyBVXPv/
X-Google-Smtp-Source: APBJJlG0n90x0DW5xPgSI2O6F1GL2NB8IpGAwhp62OYkLpojyqjYjuUm/ubGDciYiWxqWnofTTaBiA==
X-Received: by 2002:a17:903:191:b0:1b8:9b5e:65c8 with SMTP id z17-20020a170903019100b001b89b5e65c8mr21559049plg.4.1689760498541;
        Wed, 19 Jul 2023 02:54:58 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bb10-20020a170902bc8a00b001b1c4d875f5sm3511015plb.44.2023.07.19.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:54:58 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Thomas Haller <thaller@redhat.com>
Subject: [PATCHv2 net] ipv6: do not match device when remove source route
Date: Wed, 19 Jul 2023 17:54:49 +0800
Message-Id: <20230719095449.2998778-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After deleting an IPv6 address on an interface and cleaning up the
related preferred source entries, it is important to ensure that all
routes associated with the deleted address are properly cleared. The
current implementation of rt6_remove_prefsrc() only checks the preferred
source addresses bound to the current device. However, there may be
routes that are bound to other devices but still utilize the same
preferred source address.

To address this issue, it is necessary to also delete entries that are
bound to other interfaces but share the same source address with the
current device. Failure to delete these entries would leave routes that
are bound to the deleted address unclear. Here is an example reproducer
(I have omitted unrelated routes):

+ ip link add dummy1 type dummy
+ ip link add dummy2 type dummy
+ ip link set dummy1 up
+ ip link set dummy2 up
+ ip addr add 1:2:3:4::5/64 dev dummy1
+ ip route add 7:7:7:0::1 dev dummy1 src 1:2:3:4::5
+ ip route add 7:7:7:0::2 dev dummy2 src 1:2:3:4::5
+ ip -6 route show
1:2:3:4::/64 dev dummy1 proto kernel metric 256 pref medium
7:7:7::1 dev dummy1 src 1:2:3:4::5 metric 1024 pref medium
7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium
+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium
7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium

After fix:

+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium
7:7:7::2 dev dummy2 metric 1024 pref medium

Ido notified that there is a commit 5a56a0b3a45d ("net: Don't delete
routes in different VRFs") to not affect the route in different VRFs.
So let's only remove the rt dev checking and add an table id checking.

I also added a ipv6_del_addr test for fib_tests.sh. Note that instead
of removing the whole route for IPv4, IPv6 only remove the preferred
source address for source routing. So in the testing I use
"grep -q $src_ipv6_address" instead of "grep -q $dst_ipv6_subnet/64"
when checking if the source route deleted.

Here is the fib_tests.sh ipv6_del_addr test result.

Before fix:
IPv6 delete address route tests
    Regular FIB info
    TEST: Route removed from VRF when source address deleted            [ OK ]
    TEST: Route in default VRF not removed                              [FAIL]
    TEST: Route removed in default VRF when source address deleted      [ OK ]
    TEST: Route in VRF is not removed by address delete                 [FAIL]
    Identical FIB info with different table ID
    TEST: Route removed from VRF when source address deleted            [ OK ]
    TEST: Route in default VRF not removed                              [FAIL]
    TEST: Route removed in default VRF when source address deleted      [ OK ]
    TEST: Route in VRF is not removed by address delete                 [FAIL]
    Table ID 0
    TEST: Route removed in default VRF when source address deleted      [ OK ]

After fix:
IPv6 delete address route tests
    Regular FIB info
    TEST: Route removed from VRF when source address deleted            [ OK ]
    TEST: Route in default VRF not removed                              [ OK ]
    TEST: Route removed in default VRF when source address deleted      [ OK ]
    TEST: Route in VRF is not removed by address delete                 [ OK ]
    Identical FIB info with different table ID
    TEST: Route removed from VRF when source address deleted            [ OK ]
    TEST: Route in default VRF not removed                              [ OK ]
    TEST: Route removed in default VRF when source address deleted      [ OK ]
    TEST: Route in VRF is not removed by address delete                 [ OK ]
    Table ID 0
    TEST: Route removed in default VRF when source address deleted      [ OK ]

Reported-by: Thomas Haller <thaller@redhat.com>
Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: checking table id and update fib_test.sh
---
 net/ipv6/route.c                         |  3 +-
 tools/testing/selftests/net/fib_tests.sh | 90 +++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..4f49677e24a2 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4590,10 +4590,11 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
 	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
 	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
 	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
+	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
 
 	if (!rt->nh &&
-	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
 	    rt != net->ipv6.fib6_null_entry &&
+	    rt->fib6_table->tb6_id == tb6_id &&
 	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
 		spin_lock_bh(&rt6_exception_lock);
 		/* remove prefsrc entry */
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..0c24ea973598 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1869,6 +1869,93 @@ ipv4_del_addr_test()
 	cleanup
 }
 
+ipv6_del_addr_test()
+{
+	echo
+	echo "IPv6 delete address route tests"
+
+	setup
+
+	set -e
+	$IP li add dummy1 type dummy
+	$IP li set dummy1 up
+	$IP li add dummy2 type dummy
+	$IP li set dummy2 up
+	$IP li add red type vrf table 1111
+	$IP li set red up
+	$IP ro add vrf red unreachable default
+	$IP li set dummy2 vrf red
+
+	$IP addr add dev dummy1 2001:db8:104::1/64
+	$IP addr add dev dummy1 2001:db8:104::11/64
+	$IP addr add dev dummy1 2001:db8:104::12/64
+	$IP addr add dev dummy1 2001:db8:104::13/64
+	$IP addr add dev dummy2 2001:db8:104::1/64
+	$IP addr add dev dummy2 2001:db8:104::11/64
+	$IP addr add dev dummy2 2001:db8:104::12/64
+	$IP route add 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+	$IP route add 2001:db8:106::/64 dev lo src 2001:db8:104::12
+	$IP route add table 0 2001:db8:107::/64 via 2001:db8:104::2 src 2001:db8:104::13
+	$IP route add vrf red 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+	$IP route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
+	set +e
+
+	# removing address from device in vrf should only remove route from vrf table
+	echo "    Regular FIB info"
+
+	$IP addr del dev dummy2 2001:db8:104::11/64
+	# Checking if the source address exist instead of the dest subnet
+	# as IPv6 only remove the preferred source address, not whole route.
+	$IP -6 ro ls vrf red | grep -q 2001:db8:104::11
+	log_test $? 1 "Route removed from VRF when source address deleted"
+
+	$IP -6 ro ls | grep -q 2001:db8:104::11
+	log_test $? 0 "Route in default VRF not removed"
+
+	$IP addr add dev dummy2 2001:db8:104::11/64
+	$IP route replace vrf red 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+
+	$IP addr del dev dummy1 2001:db8:104::11/64
+	$IP -6 ro ls | grep -q 2001:db8:104::11
+	log_test $? 1 "Route removed in default VRF when source address deleted"
+
+	$IP -6 ro ls vrf red | grep -q 2001:db8:104::11
+	log_test $? 0 "Route in VRF is not removed by address delete"
+
+	# removing address from device in vrf should only remove route from vrf
+	# table even when the associated fib info only differs in table ID
+	echo "    Identical FIB info with different table ID"
+
+	$IP addr del dev dummy2 2001:db8:104::12/64
+	$IP -6 ro ls vrf red | grep -q 2001:db8:104::12
+	log_test $? 1 "Route removed from VRF when source address deleted"
+
+	$IP -6 ro ls | grep -q 2001:db8:104::12
+	log_test $? 0 "Route in default VRF not removed"
+
+	$IP addr add dev dummy2 2001:db8:104::12/64
+	$IP route replace vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
+
+	$IP addr del dev dummy1 2001:db8:104::12/64
+	$IP -6 ro ls | grep -q 2001:db8:104::12
+	log_test $? 1 "Route removed in default VRF when source address deleted"
+
+	$IP -6 ro ls vrf red | grep -q 2001:db8:104::12
+	log_test $? 0 "Route in VRF is not removed by address delete"
+
+	# removing address from device in default vrf should remove route from
+	# the default vrf even when route was inserted with a table ID of 0.
+	echo "    Table ID 0"
+
+	$IP addr del dev dummy1 2001:db8:104::13/64
+	$IP -6 ro ls | grep -q 2001:db8:104::13
+	log_test $? 1 "Route removed in default VRF when source address deleted"
+
+	$IP li del dummy1
+	$IP li del dummy2
+	cleanup
+}
+
 
 ipv4_route_v6_gw_test()
 {
@@ -2211,6 +2298,7 @@ do
 	ipv6_addr_metric)		ipv6_addr_metric_test;;
 	ipv4_addr_metric)		ipv4_addr_metric_test;;
 	ipv4_del_addr)			ipv4_del_addr_test;;
+	ipv6_del_addr)			ipv6_del_addr_test;;
 	ipv6_route_metrics)		ipv6_route_metrics_test;;
 	ipv4_route_metrics)		ipv4_route_metrics_test;;
 	ipv4_route_v6_gw)		ipv4_route_v6_gw_test;;
-- 
2.38.1


