Return-Path: <netdev+bounces-27921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5877DA34
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A16281762
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB2C2EF;
	Wed, 16 Aug 2023 06:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF6C8CA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:07:56 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17822127
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 23:07:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc6535027aso52242125ad.2
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692166056; x=1692770856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOIf1AyxpwfEd347Ti+n/9y1iZQZCkIXtv7IQUWlfq0=;
        b=G9LhOQ5E78H1/u6VlFdiyIq7zTjB/aQwnxnSaK3gc/cHNXCRsmutcK3qzXVku6pDMi
         S6LnwwXTOCvYFAquznn3HtwVs5y6G7KSGxHAaIGXrghauRk534ZFy1i0cg81EjWwBAY6
         Pe60xhTvwuZXgunFFqpkbefHDuz/5BEipMmC0qn38OkR+V/M+O1THLA3sLR03T710xQZ
         C0VqmZtZD/MFzjOtK1fDnQ8aY1U3Z8wMXbAZEc3xAn8Gn4lyCkelOtMXf6PrXjLN6RsB
         /jh7khYIp70hQ492hHH4sRmpEUu5Pj6BOj6sl4R7YJTzmVdhh2Jf4KYAZlCGArBbiHv0
         Qj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692166056; x=1692770856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOIf1AyxpwfEd347Ti+n/9y1iZQZCkIXtv7IQUWlfq0=;
        b=cg6+ixtOpH4RoEGi3aHuhWYaK92ZFc+gSSe/wckzANfJ1oflNYloBDdlQKhX4PErJ7
         VqlG+QhKO2BsFvKL//+y9OrKo6r3mHhmwp6suxI2i+yvbE/+meXe76bJPAm44cA7RKIv
         B/cI34UgSuOFWAnfoEN9ydqlu+J2zO1LoixEgwrKijNcPefjtYpXM1PE/zVmpKXFPaTM
         dvOHwoOXRUyUUmPwVQvC7gVy+ufgjGDKasY5V6qoLZw8kIGa/idtpHKcA/vmCEfUXZgO
         X32y2RAoDe+/DOU5TobqW0np5uBHvs1/XSGFJ8JlvsTxeiOx0/y7JUadCjJz/7wT4+EM
         xu1Q==
X-Gm-Message-State: AOJu0YxIaV4Yr2whs2pA+HZuowSyQqP4ixFaN1IPv1ndgkk0Tw4ICqG9
	e5OM1QjJYAWaaIMbI7VtuVko+djcqFqYKMyY
X-Google-Smtp-Source: AGHT+IGUy95CV/Qrr/Q1DiCSryuvyYvdhzE22/IPyY2bMC3DM7RUsxe56z59Rm/M+xsfwrTG7xHOng==
X-Received: by 2002:a17:902:7408:b0:1bc:5855:f108 with SMTP id g8-20020a170902740800b001bc5855f108mr1037655pll.46.1692166055951;
        Tue, 15 Aug 2023 23:07:35 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902b11600b001bb24cb9a40sm12097090plr.39.2023.08.15.23.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:07:35 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 2/2] selftests: fib_test: add a test case for IPv6 source address delete
Date: Wed, 16 Aug 2023 14:07:24 +0800
Message-Id: <20230816060724.1398842-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816060724.1398842-1-liuhangbin@gmail.com>
References: <20230816060724.1398842-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a test case for IPv6 source address delete. As David suggested, add tests:
- Single device using src address
- Two devices with the same source address
- VRF with single device using src address
- VRF with two devices using src address

As Ido points out, in IPv6, the preferred source address is looked up in
the same VRF as the first nexthop device. This will give us similar results
to IPv4 if the route is installed in the same VRF as the nexthop device, but
not when the nexthop device is enslaved to a different VRF. So add tests:
- src address and nexthop dev in same VR
- src address and nexthop device in different VRF

The link local address delete logic is different from the global address.
It should only affect the associate device it bonds to. Add tests cases
for link local address testing.

The table 0 and same FIB info tests are copied from IPv4 tests.

Here is the test result:

IPv6 delete address route tests
    Single device using src address
    TEST: Prefsrc removed when src address removed on other device      [ OK ]
    Two devices with the same source address
    TEST: Prefsrc not removed when src address exist on other device    [ OK ]
    VRF with single device using src address
    TEST: Prefsrc removed when src address removed on other device      [ OK ]
    VRF with two devices using src address
    TEST: Prefsrc not removed when src address exist on other device    [ OK ]
    src address and nexthop dev in same VRF
    TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc not removed from VRF when source address exist        [ OK ]
    TEST: Prefsrc in default VRF removed                                [ OK ]
    src address and nexthop device in different VRF
    TEST: Prefsrc not removed from VRF when nexthop dev in diff VRF     [ OK ]
    TEST: Prefsrc not removed in default VRF                            [ OK ]
    TEST: Prefsrc removed from VRF when nexthop dev in diff VRF         [ OK ]
    TEST: Prefsrc removed in default VRF                                [ OK ]
    Same FIB info with different table ID
    TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc not removed from VRF when source address exist        [ OK ]
    TEST: Prefsrc in default VRF removed                                [ OK ]
    Table ID 0
    TEST: Prefsrc removed from default VRF when source address deleted  [ OK ]
    Link local source route
    TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
    TEST: Prefsrc removed when delete ll addr                           [ OK ]
    TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
    TEST: Prefsrc removed even ll addr still exist on other dev         [ OK ]

Tests passed:  21
Tests failed:   0

Suggested-by: Ido Schimmel <idosch@idosch.org>
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v7: add more tests as Ido and David suggested. Remove the IPv4 part as I want
    to focus on the IPv6 fixes.
---
 tools/testing/selftests/net/fib_tests.sh | 163 ++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..0aa17b2ac8e1 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1869,6 +1869,166 @@ ipv4_del_addr_test()
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
+	for i in $(seq 6); do
+		$IP li add dummy${i} up type dummy
+	done
+
+	$IP li add red up type vrf table 1111
+	$IP ro add vrf red unreachable default
+	for i in $(seq 4 6); do
+		$IP li set dummy${i} vrf red
+	done
+
+	$IP addr add dev dummy1 fe80::1/128
+	$IP addr add dev dummy1 2001:db8:101::1/64
+	$IP addr add dev dummy1 2001:db8:101::10/64
+	$IP addr add dev dummy1 2001:db8:101::11/64
+	$IP addr add dev dummy1 2001:db8:101::12/64
+	$IP addr add dev dummy1 2001:db8:101::13/64
+	$IP addr add dev dummy1 2001:db8:101::14/64
+	$IP addr add dev dummy1 2001:db8:101::15/64
+	$IP addr add dev dummy2 fe80::1/128
+	$IP addr add dev dummy2 2001:db8:101::1/64
+	$IP addr add dev dummy2 2001:db8:101::11/64
+	$IP addr add dev dummy3 fe80::1/128
+
+	$IP addr add dev dummy4 2001:db8:101::1/64
+	$IP addr add dev dummy4 2001:db8:101::10/64
+	$IP addr add dev dummy4 2001:db8:101::11/64
+	$IP addr add dev dummy4 2001:db8:101::12/64
+	$IP addr add dev dummy4 2001:db8:101::13/64
+	$IP addr add dev dummy4 2001:db8:101::14/64
+	$IP addr add dev dummy5 2001:db8:101::1/64
+	$IP addr add dev dummy5 2001:db8:101::11/64
+
+	# Single device using src address
+	$IP route add 2001:db8:110::/64 dev dummy3 src 2001:db8:101::10
+	# Two devices with the same source address
+	$IP route add 2001:db8:111::/64 dev dummy3 src 2001:db8:101::11
+	# VRF with single device using src address
+	$IP route add vrf red 2001:db8:110::/64 dev dummy6 src 2001:db8:101::10
+	# VRF with two devices using src address
+	$IP route add vrf red 2001:db8:111::/64 dev dummy6 src 2001:db8:101::11
+	# src address and nexthop dev in same VRF
+	$IP route add 2001:db8:112::/64 dev dummy3 src 2001:db8:101::12
+	$IP route add vrf red 2001:db8:112::/64 dev dummy6 src 2001:db8:101::12
+	# src address and nexthop device in different VRF
+	$IP route add 2001:db8:113::/64 dev lo src 2001:db8:101::13
+	$IP route add vrf red 2001:db8:113::/64 dev lo src 2001:db8:101::13
+	# Same FIB info with different table ID
+	$IP route add 2001:db8:114::/64 via 2001:db8:101::2 src 2001:db8:101::14
+	$IP route add vrf red 2001:db8:114::/64 via 2001:db8:101::2 src 2001:db8:101::14
+	# table ID 0
+	$IP route add table 0 2001:db8:115::/64 via 2001:db8:101::2 src 2001:db8:101::15
+	# Link local source route
+	$IP route add 2001:db8:116::/64 dev dummy2 src fe80::1
+	$IP route add 2001:db8:117::/64 dev dummy3 src fe80::1
+	set +e
+
+	echo "    Single device using src address"
+
+	$IP addr del dev dummy1 2001:db8:101::10/64
+	$IP -6 route show | grep -q "src 2001:db8:101::10 "
+	log_test $? 1 "Prefsrc removed when src address removed on other device"
+
+	echo "    Two devices with the same source address"
+
+	$IP addr del dev dummy1 2001:db8:101::11/64
+	$IP -6 route show | grep -q "src 2001:db8:101::11 "
+	log_test $? 0 "Prefsrc not removed when src address exist on other device"
+
+	echo "    VRF with single device using src address"
+
+	$IP addr del dev dummy4 2001:db8:101::10/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::10 "
+	log_test $? 1 "Prefsrc removed when src address removed on other device"
+
+	echo "    VRF with two devices using src address"
+
+	$IP addr del dev dummy4 2001:db8:101::11/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::11 "
+	log_test $? 0 "Prefsrc not removed when src address exist on other device"
+
+	echo "    src address and nexthop dev in same VRF"
+
+	$IP addr del dev dummy4 2001:db8:101::12/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::12 "
+	log_test $? 1 "Prefsrc removed from VRF when source address deleted"
+	$IP -6 route show | grep -q " src 2001:db8:101::12 "
+	log_test $? 0 "Prefsrc in default VRF not removed"
+
+	$IP addr add dev dummy4 2001:db8:101::12/64
+	$IP route replace vrf red 2001:db8:112::/64 dev dummy6 src 2001:db8:101::12
+	$IP addr del dev dummy1 2001:db8:101::12/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::12 "
+	log_test $? 0 "Prefsrc not removed from VRF when source address exist"
+	$IP -6 route show | grep -q " src 2001:db8:101::12 "
+	log_test $? 1 "Prefsrc in default VRF removed"
+
+	echo "    src address and nexthop device in different VRF"
+
+	$IP addr del dev dummy4 2001:db8:101::13/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::13 "
+	log_test $? 0 "Prefsrc not removed from VRF when nexthop dev in diff VRF"
+	$IP -6 route show | grep -q " src 2001:db8:101::13 "
+	log_test $? 0 "Prefsrc not removed in default VRF"
+
+	$IP addr add dev dummy4 2001:db8:101::13/64
+	$IP addr del dev dummy1 2001:db8:101::13/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::13 "
+	log_test $? 1 "Prefsrc removed from VRF when nexthop dev in diff VRF"
+	$IP -6 route show | grep -q " src 2001:db8:101::13 "
+	log_test $? 1 "Prefsrc removed in default VRF"
+
+	echo "    Same FIB info with different table ID"
+
+	$IP addr del dev dummy4 2001:db8:101::14/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::14 "
+	log_test $? 1 "Prefsrc removed from VRF when source address deleted"
+	$IP -6 route show | grep -q " src 2001:db8:101::14 "
+	log_test $? 0 "Prefsrc in default VRF not removed"
+
+	$IP addr add dev dummy4 2001:db8:101::14/64
+	$IP route replace vrf red 2001:db8:114::/64 via 2001:db8:101::2 src 2001:db8:101::14
+	$IP addr del dev dummy1 2001:db8:101::14/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::14 "
+	log_test $? 0 "Prefsrc not removed from VRF when source address exist"
+	$IP -6 route show | grep -q " src 2001:db8:101::14 "
+	log_test $? 1 "Prefsrc in default VRF removed"
+
+	echo "    Table ID 0"
+
+	$IP addr del dev dummy1 2001:db8:101::15/64
+	$IP -6 route show | grep -q "src 2001:db8:101::15"
+	log_test $? 1 "Prefsrc removed from default VRF when source address deleted"
+
+	echo "    Link local source route"
+	$IP addr del dev dummy1 fe80::1/128
+	$IP -6 route show | grep -q "2001:db8:116::/64 dev dummy2 src fe80::1"
+	log_test $? 0 "Prefsrc not removed when delete ll addr from other dev"
+	$IP addr del dev dummy2 fe80::1/128
+	$IP -6 route show | grep -q "2001:db8:116::/64 dev dummy2 src fe80::1"
+	log_test $? 1 "Prefsrc removed when delete ll addr"
+	$IP -6 route show | grep -q "2001:db8:117::/64 dev dummy3 src fe80::1"
+	log_test $? 0 "Prefsrc not removed when delete ll addr from other dev"
+	$IP addr add dev dummy1 fe80::1/128
+	$IP addr del dev dummy3 fe80::1/128
+	$IP -6 route show | grep -q "2001:db8:117::/64 dev dummy3 src fe80::1"
+	log_test $? 1 "Prefsrc removed even ll addr still exist on other dev"
+
+	for i in $(seq 6); do
+		$IP li del dummy${i}
+	done
+	cleanup
+}
 
 ipv4_route_v6_gw_test()
 {
@@ -2211,6 +2371,7 @@ do
 	ipv6_addr_metric)		ipv6_addr_metric_test;;
 	ipv4_addr_metric)		ipv4_addr_metric_test;;
 	ipv4_del_addr)			ipv4_del_addr_test;;
+	ipv6_del_addr)			ipv6_del_addr_test;;
 	ipv6_route_metrics)		ipv6_route_metrics_test;;
 	ipv4_route_metrics)		ipv4_route_metrics_test;;
 	ipv4_route_v6_gw)		ipv4_route_v6_gw_test;;
-- 
2.38.1


