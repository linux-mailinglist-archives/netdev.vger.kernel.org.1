Return-Path: <netdev+bounces-29895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF578515B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80051C20C0C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1B8834;
	Wed, 23 Aug 2023 07:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C529475
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:19:22 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5350DB
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc3d94d40fso41601655ad.3
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692775159; x=1693379959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5X9YFQ0dzaw6XiMElCZVo8zrsu+ifozkisiouXeObVc=;
        b=Y70myY78nTVSWmy52IpSrPh4hwjd++6yG6EvFX0Fhn++UNCCPSf98EyXMmoMKOMgzv
         fr2CnVaM1NKex+5+b47B9kADJnBWb8tHiYO5emb3YeACzuk9RT8yH0F558y/uTGTl10y
         F4cFj5h6/5nieuyftoVqM6o0IS0m1O351Rj0FkQ3eITUtSs7haA7BHVq77APeSE++/8H
         4TEO96jwV5DJww5lW9V+oy/15ORUwp/rjIRiJWnXNS2xbC40zZFAq7GbgoFRyT2jl8BQ
         b3UzXvnr5SqoemWcrPIbHdW2QiKIixqqg568RLKXQRh4R9eh8kUi9NHju1NlRicw0hwy
         jXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775159; x=1693379959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5X9YFQ0dzaw6XiMElCZVo8zrsu+ifozkisiouXeObVc=;
        b=covLIbWha9kmohC5DFotmEDE0Tf1lAhJ5D6sSLw8Lc1+OXiYehz0jjXFc0VDc8yYcq
         j3UaZaC7Zi1p3rkLY+3PhvbA83doMCGhAWdMc1ud0rTUFLkKweTPq8c3pxdQblqEJe7w
         DnrlNVxlwn62GNSlsPCi8xkITDUn47033vLJkhez7fyifCbIeTK3IVKWBXqWk+F8s4Dc
         iJdtJkAr+1MfZ5OAT4t/8axBkTuXnadQntfKXHsQ11VazhA1j7TX7JPrCZh9DPGiEtKG
         /U8pBDVNEbMJ3BhP2plOPbri/S4vLJjtmVUZ8W5KQpckFzzUqj2pas/yMLW+J4ltpQNg
         zUqA==
X-Gm-Message-State: AOJu0YwR5KkUMyEqvNE0zuIWKuROga6HUUUFwvNr/YqsukDkHHcaSTna
	gArhzDXQBj6hTTWTWIP0BoKZdau7VqjJHw==
X-Google-Smtp-Source: AGHT+IE/s8i4S9idWjCqh/IkspZWPpFQd+tFnSAxLQTj02WwdpIJD6HfrpMVjNv9RPFpbYmyIEYrvA==
X-Received: by 2002:a17:902:a409:b0:1bd:c783:dac3 with SMTP id p9-20020a170902a40900b001bdc783dac3mr10244542plq.63.1692775159487;
        Wed, 23 Aug 2023 00:19:19 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001bdea189261sm10221212plb.229.2023.08.23.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:19:18 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/3] selftest: bond: add new topo bond_topo_2d1c.sh
Date: Wed, 23 Aug 2023 15:19:05 +0800
Message-ID: <20230823071907.3027782-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823071907.3027782-1-liuhangbin@gmail.com>
References: <20230823071907.3027782-1-liuhangbin@gmail.com>
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

Add a new testing topo bond_topo_2d1c.sh which is used more commonly.
Make bond_topo_3d1c.sh just source bond_topo_2d1c.sh and add the
extra link.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: add bond_topo_2d1c.sh to Makefile
v2: no update
---
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_options.sh       |   3 -
 .../drivers/net/bonding/bond_topo_2d1c.sh     | 158 ++++++++++++++++++
 .../drivers/net/bonding/bond_topo_3d1c.sh     | 118 +------------
 4 files changed, 167 insertions(+), 113 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 03f92d7aeb19..0a3eb0a10772 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS := \
 
 TEST_FILES := \
 	lag_lib.sh \
+	bond_topo_2d1c.sh \
 	bond_topo_3d1c.sh \
 	net_forwarding_lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index 607ba5c38977..c54d1697f439 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -9,10 +9,7 @@ ALL_TESTS="
 	num_grat_arp
 "
 
-REQUIRE_MZ=no
-NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source ${lib_dir}/net_forwarding_lib.sh
 source ${lib_dir}/bond_topo_3d1c.sh
 
 skip_prio()
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
new file mode 100644
index 000000000000..a509ef949dcf
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
@@ -0,0 +1,158 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Topology for Bond mode 1,5,6 testing
+#
+#  +-------------------------+
+#  |          bond0          |  Server
+#  |            +            |  192.0.2.1/24
+#  |      eth0  |  eth1      |  2001:db8::1/24
+#  |        +---+---+        |
+#  |        |       |        |
+#  +-------------------------+
+#           |       |
+#  +-------------------------+
+#  |        |       |        |
+#  |    +---+-------+---+    |  Gateway
+#  |    |      br0      |    |  192.0.2.254/24
+#  |    +-------+-------+    |  2001:db8::254/24
+#  |            |            |
+#  +-------------------------+
+#               |
+#  +-------------------------+
+#  |            |            |  Client
+#  |            +            |  192.0.2.10/24
+#  |          eth0           |  2001:db8::10/24
+#  +-------------------------+
+
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source ${lib_dir}/net_forwarding_lib.sh
+
+s_ns="s-$(mktemp -u XXXXXX)"
+c_ns="c-$(mktemp -u XXXXXX)"
+g_ns="g-$(mktemp -u XXXXXX)"
+s_ip4="192.0.2.1"
+c_ip4="192.0.2.10"
+g_ip4="192.0.2.254"
+s_ip6="2001:db8::1"
+c_ip6="2001:db8::10"
+g_ip6="2001:db8::254"
+
+gateway_create()
+{
+	ip netns add ${g_ns}
+	ip -n ${g_ns} link add br0 type bridge
+	ip -n ${g_ns} link set br0 up
+	ip -n ${g_ns} addr add ${g_ip4}/24 dev br0
+	ip -n ${g_ns} addr add ${g_ip6}/24 dev br0
+}
+
+gateway_destroy()
+{
+	ip -n ${g_ns} link del br0
+	ip netns del ${g_ns}
+}
+
+server_create()
+{
+	ip netns add ${s_ns}
+	ip -n ${s_ns} link add bond0 type bond mode active-backup miimon 100
+
+	for i in $(seq 0 1); do
+		ip -n ${s_ns} link add eth${i} type veth peer name s${i} netns ${g_ns}
+
+		ip -n ${g_ns} link set s${i} up
+		ip -n ${g_ns} link set s${i} master br0
+		ip -n ${s_ns} link set eth${i} master bond0
+
+		tc -n ${g_ns} qdisc add dev s${i} clsact
+	done
+
+	ip -n ${s_ns} link set bond0 up
+	ip -n ${s_ns} addr add ${s_ip4}/24 dev bond0
+	ip -n ${s_ns} addr add ${s_ip6}/24 dev bond0
+	sleep 2
+}
+
+# Reset bond with new mode and options
+bond_reset()
+{
+	# Count the eth link number in real-time as this function
+	# maybe called from other topologies.
+	local link_num=$(ip -n ${s_ns} -br link show | grep -c "^eth")
+	local param="$1"
+	link_num=$((link_num -1))
+
+	ip -n ${s_ns} link set bond0 down
+	ip -n ${s_ns} link del bond0
+
+	ip -n ${s_ns} link add bond0 type bond $param
+	for i in $(seq 0 ${link_num}); do
+		ip -n ${s_ns} link set eth$i master bond0
+	done
+
+	ip -n ${s_ns} link set bond0 up
+	ip -n ${s_ns} addr add ${s_ip4}/24 dev bond0
+	ip -n ${s_ns} addr add ${s_ip6}/24 dev bond0
+	sleep 2
+}
+
+server_destroy()
+{
+	# Count the eth link number in real-time as this function
+	# maybe called from other topologies.
+	local link_num=$(ip -n ${s_ns} -br link show | grep -c "^eth")
+	link_num=$((link_num -1))
+	for i in $(seq 0 ${link_num}); do
+		ip -n ${s_ns} link del eth${i}
+	done
+	ip netns del ${s_ns}
+}
+
+client_create()
+{
+	ip netns add ${c_ns}
+	ip -n ${c_ns} link add eth0 type veth peer name c0 netns ${g_ns}
+
+	ip -n ${g_ns} link set c0 up
+	ip -n ${g_ns} link set c0 master br0
+
+	ip -n ${c_ns} link set eth0 up
+	ip -n ${c_ns} addr add ${c_ip4}/24 dev eth0
+	ip -n ${c_ns} addr add ${c_ip6}/24 dev eth0
+}
+
+client_destroy()
+{
+	ip -n ${c_ns} link del eth0
+	ip netns del ${c_ns}
+}
+
+setup_prepare()
+{
+	gateway_create
+	server_create
+	client_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	client_destroy
+	server_destroy
+	gateway_destroy
+}
+
+bond_check_connection()
+{
+	local msg=${1:-"check connection"}
+
+	sleep 2
+	ip netns exec ${s_ns} ping ${c_ip4} -c5 -i 0.1 &>/dev/null
+	check_err $? "${msg}: ping failed"
+	ip netns exec ${s_ns} ping6 ${c_ip6} -c5 -i 0.1 &>/dev/null
+	check_err $? "${msg}: ping6 failed"
+}
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_3d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_3d1c.sh
index 69ab99a56043..3a1333d9a85b 100644
--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_3d1c.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_3d1c.sh
@@ -25,121 +25,19 @@
 #  |                eth0                 |  2001:db8::10/24
 #  +-------------------------------------+
 
-s_ns="s-$(mktemp -u XXXXXX)"
-c_ns="c-$(mktemp -u XXXXXX)"
-g_ns="g-$(mktemp -u XXXXXX)"
-s_ip4="192.0.2.1"
-c_ip4="192.0.2.10"
-g_ip4="192.0.2.254"
-s_ip6="2001:db8::1"
-c_ip6="2001:db8::10"
-g_ip6="2001:db8::254"
-
-gateway_create()
-{
-	ip netns add ${g_ns}
-	ip -n ${g_ns} link add br0 type bridge
-	ip -n ${g_ns} link set br0 up
-	ip -n ${g_ns} addr add ${g_ip4}/24 dev br0
-	ip -n ${g_ns} addr add ${g_ip6}/24 dev br0
-}
-
-gateway_destroy()
-{
-	ip -n ${g_ns} link del br0
-	ip netns del ${g_ns}
-}
-
-server_create()
-{
-	ip netns add ${s_ns}
-	ip -n ${s_ns} link add bond0 type bond mode active-backup miimon 100
-
-	for i in $(seq 0 2); do
-		ip -n ${s_ns} link add eth${i} type veth peer name s${i} netns ${g_ns}
-
-		ip -n ${g_ns} link set s${i} up
-		ip -n ${g_ns} link set s${i} master br0
-		ip -n ${s_ns} link set eth${i} master bond0
-
-		tc -n ${g_ns} qdisc add dev s${i} clsact
-	done
-
-	ip -n ${s_ns} link set bond0 up
-	ip -n ${s_ns} addr add ${s_ip4}/24 dev bond0
-	ip -n ${s_ns} addr add ${s_ip6}/24 dev bond0
-	sleep 2
-}
-
-# Reset bond with new mode and options
-bond_reset()
-{
-	local param="$1"
-
-	ip -n ${s_ns} link set bond0 down
-	ip -n ${s_ns} link del bond0
-
-	ip -n ${s_ns} link add bond0 type bond $param
-	for i in $(seq 0 2); do
-		ip -n ${s_ns} link set eth$i master bond0
-	done
-
-	ip -n ${s_ns} link set bond0 up
-	ip -n ${s_ns} addr add ${s_ip4}/24 dev bond0
-	ip -n ${s_ns} addr add ${s_ip6}/24 dev bond0
-	sleep 2
-}
-
-server_destroy()
-{
-	for i in $(seq 0 2); do
-		ip -n ${s_ns} link del eth${i}
-	done
-	ip netns del ${s_ns}
-}
-
-client_create()
-{
-	ip netns add ${c_ns}
-	ip -n ${c_ns} link add eth0 type veth peer name c0 netns ${g_ns}
-
-	ip -n ${g_ns} link set c0 up
-	ip -n ${g_ns} link set c0 master br0
-
-	ip -n ${c_ns} link set eth0 up
-	ip -n ${c_ns} addr add ${c_ip4}/24 dev eth0
-	ip -n ${c_ns} addr add ${c_ip6}/24 dev eth0
-}
-
-client_destroy()
-{
-	ip -n ${c_ns} link del eth0
-	ip netns del ${c_ns}
-}
+source bond_topo_2d1c.sh
 
 setup_prepare()
 {
 	gateway_create
 	server_create
 	client_create
-}
-
-cleanup()
-{
-	pre_cleanup
-
-	client_destroy
-	server_destroy
-	gateway_destroy
-}
-
-bond_check_connection()
-{
-	local msg=${1:-"check connection"}
 
-	sleep 2
-	ip netns exec ${s_ns} ping ${c_ip4} -c5 -i 0.1 &>/dev/null
-	check_err $? "${msg}: ping failed"
-	ip netns exec ${s_ns} ping6 ${c_ip6} -c5 -i 0.1 &>/dev/null
-	check_err $? "${msg}: ping6 failed"
+	# Add the extra device as we use 3 down links for bond0
+	local i=2
+	ip -n ${s_ns} link add eth${i} type veth peer name s${i} netns ${g_ns}
+	ip -n ${g_ns} link set s${i} up
+	ip -n ${g_ns} link set s${i} master br0
+	ip -n ${s_ns} link set eth${i} master bond0
+	tc -n ${g_ns} qdisc add dev s${i} clsact
 }
-- 
2.41.0


