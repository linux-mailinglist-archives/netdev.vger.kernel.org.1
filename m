Return-Path: <netdev+bounces-28740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B7780726
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878101C20349
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975FE1774C;
	Fri, 18 Aug 2023 08:29:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD317AB5
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:29:23 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9398E3A96
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:29:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so10832155ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347360; x=1692952160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B600eTrZjSEa9270hm9rko1G8imgFF1E+l6Bb0Zxpvk=;
        b=HYGLT1LEBqTUwYFvo/tyo5setWpzTyJKkmJzXKN5Y8695zRW7ongyEWo8t3PAPBD8d
         UIyDY8sDuAUraf7Q9kIkUeBb+BtBdnH6TvYxZVG+IoenfUREMYTykLKSUQWiMTpTE1p7
         wODHESosdJZe8b50OUESqkW2Sf1icuZnb7VqiPsP9OPCgt6j4l9jR7KBoT31oy+h/7at
         0mIFbUZt3N1X1uBfvIcMcgS3dTsxtelNly1GH33S1BSstpOcBw8MKMbwWsPJIKnFI2Wa
         tojNe3ktIiNtlm5ocv93+KMYbsHSuUvtpx7gdQji+XE9tLMKJY99Oj7RIpTw7MZcGBKF
         inew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347360; x=1692952160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B600eTrZjSEa9270hm9rko1G8imgFF1E+l6Bb0Zxpvk=;
        b=Lk7EvWN4UsKApL/G+DVnHj56guHLvemv+RDX/sogai8Bs6PsVYNfNYJGjB7LUAx6Ut
         mzpTpUlebh3tfe39X4fE5r6tyQ4K0eh78tw3JPbYBQX7gc0ZxxgcTgiF3uKkh0/Kidat
         kwcloweZItvPG7heoJyw7c+nS2Pn6Kgpi8P+UTnahmmQChTXq6jQlDTPzogqFFivchoc
         aaeIeRidDQ3DOhN2i3j8D03OIiWhZDMuqP/bJwiVMDfELrpi28B8FDuN/0SJoeNJskdL
         OE3dqoOOccyvRGj2dnIvfowi+S97QUX/LM52f0KjgmeDJykjRe+MLPZ6RvS38HGzzpoh
         6VxQ==
X-Gm-Message-State: AOJu0YxaL7rRn6iQyqViqraFMSrXRoffkZs5ivBfCYjX7AnpLkil8RWR
	oM5DI6e1bS989+uS6hPK0mPO/QlHtC42qMMx
X-Google-Smtp-Source: AGHT+IH8NctPXrteIrJ2Sot8d+T51qnjQZ31eEyNmFO6+Qlg0nye+8vspgtsOnvljd0l5/3SrVSosg==
X-Received: by 2002:a17:903:181:b0:1bb:c7bc:ceb8 with SMTP id z1-20020a170903018100b001bbc7bcceb8mr6636037plg.22.1692347360526;
        Fri, 18 Aug 2023 01:29:20 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001b8a3e2c241sm1148781plo.14.2023.08.18.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:29:19 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv7 net-next 2/2] selftests: fib_test: add a test case for IPv6 source address delete
Date: Fri, 18 Aug 2023 16:29:02 +0800
Message-Id: <20230818082902.1972738-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230818082902.1972738-1-liuhangbin@gmail.com>
References: <20230818082902.1972738-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a test case for IPv6 source address delete.

As David suggested, add tests:
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
It should only affect the associate device it bonds to. So add tests cases
for link local address testing.

Here is the test result:

IPv6 delete address route tests
    Single device using src address
    TEST: Prefsrc removed when src address removed on other device      [ OK ]
    Two devices with the same source address
    TEST: Prefsrc not removed when src address exist on other device    [ OK ]
    TEST: Prefsrc removed when src address removed on all devices       [ OK ]
    VRF with single device using src address
    TEST: Prefsrc removed when src address removed on other device      [ OK ]
    VRF with two devices using src address
    TEST: Prefsrc not removed when src address exist on other device    [ OK ]
    TEST: Prefsrc removed when src address removed on all devices       [ OK ]
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
    Table ID 0
    TEST: Prefsrc removed from default VRF when source address deleted  [ OK ]
    Link local source route
    TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
    TEST: Prefsrc removed when delete ll addr                           [ OK ]
    TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
    TEST: Prefsrc removed even ll addr still exist on other dev         [ OK ]

Tests passed:  19
Tests failed:   0

Suggested-by: Ido Schimmel <idosch@idosch.org>
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v8:
  - remove test "Same FIB info with different table ID"
  - test deleting src address from all devices.
  - consistent the space before "src". Remove all.
v7: add more tests as Ido and David suggested. Remove the IPv4 part as I want
    to focus on the IPv6 fixes.
---
 tools/testing/selftests/net/fib_tests.sh | 152 ++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index c14ad6e75c1e..d328af4a149c 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -12,7 +12,7 @@ ksft_skip=4
 TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
-       ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
+       ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1934,6 +1934,155 @@ ipv4_del_addr_test()
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
+	$IP addr del dev dummy2 2001:db8:101::11/64
+	$IP -6 route show | grep -q "src 2001:db8:101::11 "
+	log_test $? 1 "Prefsrc removed when src address removed on all devices"
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
+	$IP addr del dev dummy5 2001:db8:101::11/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::11 "
+	log_test $? 1 "Prefsrc removed when src address removed on all devices"
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
+	$IP -6 route show | grep -q "src 2001:db8:101::13 "
+	log_test $? 0 "Prefsrc not removed in default VRF"
+
+	$IP addr add dev dummy4 2001:db8:101::13/64
+	$IP addr del dev dummy1 2001:db8:101::13/64
+	$IP -6 route show vrf red | grep -q "src 2001:db8:101::13 "
+	log_test $? 1 "Prefsrc removed from VRF when nexthop dev in diff VRF"
+	$IP -6 route show | grep -q "src 2001:db8:101::13 "
+	log_test $? 1 "Prefsrc removed in default VRF"
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
@@ -2276,6 +2425,7 @@ do
 	ipv6_addr_metric)		ipv6_addr_metric_test;;
 	ipv4_addr_metric)		ipv4_addr_metric_test;;
 	ipv4_del_addr)			ipv4_del_addr_test;;
+	ipv6_del_addr)			ipv6_del_addr_test;;
 	ipv6_route_metrics)		ipv6_route_metrics_test;;
 	ipv4_route_metrics)		ipv4_route_metrics_test;;
 	ipv4_route_v6_gw)		ipv4_route_v6_gw_test;;
-- 
2.38.1


