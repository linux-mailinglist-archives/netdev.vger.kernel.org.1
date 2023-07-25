Return-Path: <netdev+bounces-20803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271CD761085
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15402812E7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C971D302;
	Tue, 25 Jul 2023 10:21:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06841EA72
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:21:46 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFBED3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:21:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8bd586086so42730785ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690280503; x=1690885303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOoonzTTXKlr7kcfasR7wwT7eZzSp+VvSFRjFV9P+2M=;
        b=f20ZN2cBaE+eAD2EJpUu1pR7zvI1Ra6rOEqRWKSCScAz+lxjSwDKmitJyi95FiCj7E
         gOHlZgiG2CPZL2l5d8lEBvNCcM31bA80B4OVm30MjyHuOxPCmsd6lzLVi0zrvl3wtbMt
         SRqXP5o7Wob3hNFoG3pMivBWwdicVqHR+q8Ta7U4bxlSMo8PI6PoyYOHdYsfG0CRXk67
         R/5Vbal1La1+Gnd0bK8rsdOk/xZkrTzi0gDJf1Py40VVKUv7cD84Qyk1XlD8eW6Y+mbc
         voEkpHJEYTzeog8rTECJFsUjCVSpd6yZMlWFiy7jq6rumnwDGx4w6zWt8Bdp6uATxTS7
         oBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280503; x=1690885303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOoonzTTXKlr7kcfasR7wwT7eZzSp+VvSFRjFV9P+2M=;
        b=PGN9iQ+5SYmKAxvgUr4TRCA2koaJeUsZfFB6cAz1pzMzzDsahLwi/J6J1uVZQvxVjy
         UnSCPF03BgAPbhJFvVtm2MayT3AAzcaRsi3nPtM1rEFXvm4u5sP0nNuMW0U5aoupYVOc
         RY7BGdvIvUCSobWtGBY7hHk4Czgz2xoyOx1Oi0QyuvL1SYACNWIFO51uJwP2K7V2XD6I
         YpcCj0qvBv9AQuv2KWRRp983xYiGOTxS7zckd3QcVn3QaCi8SXJ7/jxyzYyIrmK0kcie
         SBbjK3YERdi+WLzEK/auiIltE0j3JlRHJnFvYnNTGCKYYGCjdUKoVaXYehTKYZKYU/u+
         GeBw==
X-Gm-Message-State: ABy/qLYKRxod7JowCHOuZ0AMCRldx2pIZRUzBbt53UbSXiNiT7BoAR7w
	MWSkujZkA87d5BfilC5aLxbxyjodedtqN6wl
X-Google-Smtp-Source: APBJJlGUt+sBuSZae6/YDMM5dvBDMCFlEywBoZZIa13hVGUV5Y7wTTrE6sSibQWedzq705KuQGKeog==
X-Received: by 2002:a17:902:f54a:b0:1b8:b29e:b47b with SMTP id h10-20020a170902f54a00b001b8b29eb47bmr15014387plf.44.1690280503080;
        Tue, 25 Jul 2023 03:21:43 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902bcca00b001b850c9af71sm10582240pls.285.2023.07.25.03.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:21:42 -0700 (PDT)
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
Subject: [PATCHv4 net] ipv6: do not match device when remove source route
Date: Tue, 25 Jul 2023 18:21:37 +0800
Message-Id: <20230725102137.299305-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
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

Ido notified that there is a commit 5a56a0b3a45d ("net: Don't delete
routes in different VRFs") to not affect the route in different VRFs.
To fix all these issues. Here are what we do:
1. In fib6_remove_prefsrc, remove the rt dev checking and add an table
   id checking to not remove the route in different VRFs.
2. In fib6_remove_prefsrc, remove the !rt-nh checking to clear the IPv6
   routes that are using a nexthop object. This would be consistent with
   IPv4.
3. In rt6_remove_prefsrc, add a check to make sure not remove the src
   route if the address still exists on other device(in same VRF).

After fix:
+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium
7:7:7::2 dev dummy2 metric 1024 pref medium

An ipv6_del_addr test is also added for fib_tests.sh. Note that instead
of removing the whole route for IPv4, IPv6 only remove the preferred
source address for source routing. So in the testing use
"grep -q src $src_ipv6_address" instead of "grep -q $dst_ipv6_subnet/64"
when checking if the source route deleted.

Here is the fib_tests.sh ipv6_del_addr test result.

Before fix:
IPv6 delete address route tests
    Regular FIB info
    TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    TEST: Prefsrc in VRF is not removed by address delete               [ OK ]
    Identical FIB info with different table ID
    TEST: Prefsrc removed from VRF when source address deleted          [FAIL]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc removed in default VRF when source address deleted    [FAIL]
    TEST: Prefsrc in VRF is not removed by address delete               [ OK ]
    Table ID 0
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    Identical address on different devices
    TEST: Prefsrc not removed when src address exists on other device   [ OK ]

After fix:
IPv6 delete address route tests
    Regular FIB info
    TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    TEST: Prefsrc in VRF is not removed by address delete               [ OK ]
    Identical FIB info with different table ID
    TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    TEST: Prefsrc in VRF is not removed by address delete               [ OK ]
    Table ID 0
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    Identical address on different devices
    TEST: Prefsrc not removed when src address exists on other device   [ OK ]

Reported-by: Thomas Haller <thaller@redhat.com>
Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v4: check if the prefsrc address still exists on other device
v3: remove rt nh checking. update the ipv6_del_addr test descriptions
v2: checking table id and update fib_test.sh
---
 net/ipv6/route.c                         |  10 +-
 tools/testing/selftests/net/fib_tests.sh | 113 ++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..44e980109e30 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4590,10 +4590,10 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
 	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
 	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
 	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
+	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
 
-	if (!rt->nh &&
-	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
-	    rt != net->ipv6.fib6_null_entry &&
+	if (rt != net->ipv6.fib6_null_entry &&
+	    rt->fib6_table->tb6_id == tb6_id &&
 	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
 		spin_lock_bh(&rt6_exception_lock);
 		/* remove prefsrc entry */
@@ -4611,7 +4611,9 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
 		.net = net,
 		.addr = &ifp->addr,
 	};
-	fib6_clean_all(net, fib6_remove_prefsrc, &adni);
+
+	if (!ipv6_chk_addr_and_flags(net, adni.addr, adni.dev, true, 0, IFA_F_TENTATIVE))
+		fib6_clean_all(net, fib6_remove_prefsrc, &adni);
 }
 
 #define RTF_RA_ROUTER		(RTF_ADDRCONF | RTF_DEFAULT)
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..618aceb7497d 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1796,6 +1796,8 @@ ipv4_del_addr_test()
 	$IP li set dummy1 up
 	$IP li add dummy2 type dummy
 	$IP li set dummy2 up
+	$IP li add dummy3 type dummy
+	$IP li set dummy3 up
 	$IP li add red type vrf table 1111
 	$IP li set red up
 	$IP ro add vrf red unreachable default
@@ -1808,11 +1810,13 @@ ipv4_del_addr_test()
 	$IP addr add dev dummy2 172.16.104.1/24
 	$IP addr add dev dummy2 172.16.104.11/24
 	$IP addr add dev dummy2 172.16.104.12/24
+	$IP addr add dev dummy3 172.16.104.1/24
 	$IP route add 172.16.105.0/24 via 172.16.104.2 src 172.16.104.11
 	$IP route add 172.16.106.0/24 dev lo src 172.16.104.12
 	$IP route add table 0 172.16.107.0/24 via 172.16.104.2 src 172.16.104.13
 	$IP route add vrf red 172.16.105.0/24 via 172.16.104.2 src 172.16.104.11
 	$IP route add vrf red 172.16.106.0/24 dev lo src 172.16.104.12
+	$IP route add 172.16.108.0/24 via 172.16.104.2 src 172.16.104.1
 	set +e
 
 	# removing address from device in vrf should only remove route from vrf table
@@ -1864,11 +1868,117 @@ ipv4_del_addr_test()
 	$IP ro ls | grep -q 172.16.107.0/24
 	log_test $? 1 "Route removed in default VRF when source address deleted"
 
+	# removing address from one device while other device still has this
+	# address should not remove the source route
+	echo "    Identical address on different device"
+	$IP addr del dev dummy3 172.16.104.1/24
+	$IP ro ls | grep -q 172.16.108.0/24
+	log_test $? 0 "Route not removed when source address exists on other device"
+
 	$IP li del dummy1
 	$IP li del dummy2
+	$IP li del dummy3
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
+	$IP li add dummy1 up type dummy
+	$IP li add dummy2 up type dummy
+	$IP li add dummy3 up type dummy
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
+	$IP addr add dev dummy3 2001:db8:104::1/64
+	$IP route add 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+	$IP route add 2001:db8:106::/64 dev lo src 2001:db8:104::12
+	$IP route add table 0 2001:db8:107::/64 via 2001:db8:104::2 src 2001:db8:104::13
+	$IP route add vrf red 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+	$IP route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
+	$IP route add 2001:db8:108::/64 via 2001:db8:104::2 src 2001:db8:104::1
+	set +e
+
+	# removing address from device in vrf should only remove it as a
+	# preferred source address from routes in vrf table
+	echo "    Regular FIB info"
+
+	$IP addr del dev dummy2 2001:db8:104::11/64
+	# Checking if the source address exists instead of the dest subnet
+	# as IPv6 only removes the preferred source address, not whole route.
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::11"
+	log_test $? 1 "Prefsrc removed from VRF when source address deleted"
+
+	$IP -6 ro ls | grep -q " src 2001:db8:104::11"
+	log_test $? 0 "Prefsrc in default VRF not removed"
+
+	$IP addr add dev dummy2 2001:db8:104::11/64
+	$IP route replace vrf red 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+
+	$IP addr del dev dummy1 2001:db8:104::11/64
+	$IP -6 ro ls | grep -q "src 2001:db8:104::11"
+	log_test $? 1 "Prefsrc removed in default VRF when source address deleted"
+
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::11"
+	log_test $? 0 "Prefsrc in VRF is not removed by address delete"
+
+	# removing address from device in vrf should only remove preferred
+	# source address from vrf table even when the associated fib info
+	# only differs in table ID
+	echo "    Identical FIB info with different table ID"
+
+	$IP addr del dev dummy2 2001:db8:104::12/64
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::12"
+	log_test $? 1 "Prefsrc removed from VRF when source address deleted"
+
+	$IP -6 ro ls | grep -q "src 2001:db8:104::12"
+	log_test $? 0 "Prefsrc in default VRF not removed"
+
+	$IP addr add dev dummy2 2001:db8:104::12/64
+	$IP route replace vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
+
+	$IP addr del dev dummy1 2001:db8:104::12/64
+	$IP -6 ro ls | grep -q "src 2001:db8:104::12"
+	log_test $? 1 "Prefsrc removed in default VRF when source address deleted"
+
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::12"
+	log_test $? 0 "Prefsrc in VRF is not removed by address delete"
+
+	# removing address from device in default vrf should remove preferred
+	# source address from the default vrf even when route was inserted
+	# with a table ID of 0.
+	echo "    Table ID 0"
+
+	$IP addr del dev dummy1 2001:db8:104::13/64
+	$IP -6 ro ls | grep -q "src 2001:db8:104::13"
+	log_test $? 1 "Prefsrc removed in default VRF when source address deleted"
+
+	# removing address from one device while other device still has this
+	# address should not remove the source route
+	echo "    Identical address on different devices"
+	$IP addr del dev dummy3 2001:db8:104::1/64
+	$IP -6 ro ls | grep -q "src 2001:db8:104::1 "
+	log_test $? 0 "Prefsrc not removed when src address exists on other device"
+
+	$IP li del dummy1
+	$IP li del dummy2
+	$IP li del dummy3
+	cleanup
+}
 
 ipv4_route_v6_gw_test()
 {
@@ -2211,6 +2321,7 @@ do
 	ipv6_addr_metric)		ipv6_addr_metric_test;;
 	ipv4_addr_metric)		ipv4_addr_metric_test;;
 	ipv4_del_addr)			ipv4_del_addr_test;;
+	ipv6_del_addr)			ipv6_del_addr_test;;
 	ipv6_route_metrics)		ipv6_route_metrics_test;;
 	ipv4_route_metrics)		ipv4_route_metrics_test;;
 	ipv4_route_v6_gw)		ipv4_route_v6_gw_test;;
-- 
2.38.1


