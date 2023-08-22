Return-Path: <netdev+bounces-29502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A0783855
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B53280F94
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347741365;
	Tue, 22 Aug 2023 03:12:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293C7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:12:41 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B6B186
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:12:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-56963f2e48eso1314353a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692673958; x=1693278758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa3TXt2oYcAuDypqMV02R8jIoPD2kCAtGDRSrgNovqc=;
        b=csU4T02j+0wyLNhL45UyYz0opVEObja2Qq/YSZNDrJ0b1TKmBNPAKRpEiroY2AmuVt
         J1VDLFKnB3/VJg/3dpNExymfbnPfzQr0YbdXK/GE+cmXmrT+4qr85eU6mZaKUYbTusKo
         VzZG34h/LZw7i5PeFCBOFTnkseT2YRrwruMzLdXnRIkS9wZpOMvLpRh9hMrMIcTdjkP/
         LqUuSs6PDLB26NCAEAS/W2ADr9RbwQuOZt2HRB8t0SiIUM8P1Uz/uDR0BtqUMQQL0PME
         LOB6Xh+nkXWYHbngoaYhNhnXp6P8+8vvsh5r+lr7rreVkprtXOaMl4AUn6OAzX3ocVVU
         SBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692673958; x=1693278758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa3TXt2oYcAuDypqMV02R8jIoPD2kCAtGDRSrgNovqc=;
        b=E0yc2hUxYJrCfFPLoiFqXPA6NT2FjQvMwn7v/sZb0miLf4e/p1/muXj3X351fe20kM
         weXFVrrfdk4wOQLF4C2hWvcoLejdeDQ/8Yuxy5XV9k/cFuYDYSMk0eOT6IMCiEEPQXy7
         M+pyd5K/bjHLxjFeOixOhd0zMDM8qtsxyFgwuvFqH7/PnnJy/zsn+FpJN1EBoWBP5AK+
         K10l7LIls2vq/AFjH9U1iaINOW0uUZ2Sov+RFMcESUlnSPQJJDFytW209CJBLSK4mCxk
         Sn+TdknfUxGbfgqtiZIaZmkVGQNl6RYzQghJjy05C6VG6vd+DSPCZZCuGp4hi1srjidC
         qdWg==
X-Gm-Message-State: AOJu0YwBjQESQw2K5z53lKDYiQfxQie6kfERUDVDA1oT6/01D88VdSqY
	awXJNnMFnO12M3wFIUs5PgZj/YOyWLLenA==
X-Google-Smtp-Source: AGHT+IETIdYsd10B7Ihxi2vTRkXjqUhqAgS5Pkt4Qh0ru1O/wfCR9k9K5Mc2wRHHrKIFOBPUI+jNHw==
X-Received: by 2002:a17:902:b709:b0:1bd:a0cd:1860 with SMTP id d9-20020a170902b70900b001bda0cd1860mr5026107pls.64.1692673958385;
        Mon, 21 Aug 2023 20:12:38 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b001bde6fa0a39sm7803601plb.167.2023.08.21.20.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:12:37 -0700 (PDT)
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
Subject: [PATCHv2 net 2/3] selftest: bond: add new topo bond_topo_2d1c.sh
Date: Tue, 22 Aug 2023 11:12:24 +0800
Message-ID: <20230822031225.1691679-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822031225.1691679-1-liuhangbin@gmail.com>
References: <20230822031225.1691679-1-liuhangbin@gmail.com>
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
 .../drivers/net/bonding/bond_options.sh       |   3 -
 .../drivers/net/bonding/bond_topo_2d1c.sh     | 158 ++++++++++++++++++
 .../drivers/net/bonding/bond_topo_3d1c.sh     | 118 +------------
 3 files changed, 166 insertions(+), 113 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh

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


