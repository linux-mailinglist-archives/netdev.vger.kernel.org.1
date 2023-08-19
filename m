Return-Path: <netdev+bounces-29062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3287818C8
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531961C209C7
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B8C4A08;
	Sat, 19 Aug 2023 10:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947C4A04
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:31:45 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32D81A2A8
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:03:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a3582c04fso10612b3a.1
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692435793; x=1693040593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa3TXt2oYcAuDypqMV02R8jIoPD2kCAtGDRSrgNovqc=;
        b=oikzd+wgR2xCRnHkAIMuzEW0qfhtJLfBKERg3/fhCRFWx0r5DkZYnucvM/sHZdnSPT
         jrmZ/UYJzEcsgOyFvjpbxx6sSfI9Cfntrzm9q/xTPC6Iggys9Aq3gNRS1EItbSCdrM7N
         NdWxy+dWtGZmN4BqN16h7/lkP+iQ7+WNdiBIp4gtm3RvFPw420xdaooADZnXbgmvr1cz
         PY+LOYK3JEPXIXtYSOdtchYbB9lOYl2SLwnky02Jrhazu339I5DS151Rbl0XNB63AvRV
         45U6xkvUHSTt0NZnOk5n9hyHDWWBCyQKRZsWorXQLiiQ6NzFrJucHfysGiX/M//0noyJ
         OC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692435793; x=1693040593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa3TXt2oYcAuDypqMV02R8jIoPD2kCAtGDRSrgNovqc=;
        b=Mjfl8wttFnWGYTwV+Q8HRO7njSBY2QWaBHWQjY+PpJ/YdmxEH2z15JHo5EJ9aIrHpr
         46VkbvxZ/N52t90CfrO8AMKNSFdTqgTCDBN6v4HtSkUjtnUuUQLwKanvrG+M9cYx3wOh
         l8vD05Zz7bKSNVvhiVcCEkz9C43bkuAPBtzOz+x5JREHXJ6NtxRaDxDrl/A5aa8A8m69
         ctmaQ+VKjMqcxSp9j5HRq7TCINkFTiwUlw/xwVxd5R7ygDBKHjZ54RnAjjz+a2Gns2Jb
         SPhD5pPPLNHoYsdqRaiiE6xjhj3XtCtoOgMIyuUUPaS7qEGviMgaWCQaZ1NDde2t87pM
         612g==
X-Gm-Message-State: AOJu0YybRLJpSpfmlguo7m+LIahQAS9NH7ySya4y3HciZjqfW/hXh3yt
	MFNihvajve60RAVHS4bdE2SXWc+Q1o0yBiv6
X-Google-Smtp-Source: AGHT+IE4GedL1UsAhCzLohg0pEtM5kz+EJYh+s+YbSMz+o+tzYOMrjJ9vbSU/p3v6wQnkkdUZodjcQ==
X-Received: by 2002:aa7:88ca:0:b0:64d:5b4b:8429 with SMTP id k10-20020aa788ca000000b0064d5b4b8429mr1513167pff.18.1692435792577;
        Sat, 19 Aug 2023 02:03:12 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00688435a9915sm2758895pfn.189.2023.08.19.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 02:02:46 -0700 (PDT)
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
Subject: [PATCH net 2/3] selftest: bond: add new topo bond_topo_2d1c.sh
Date: Sat, 19 Aug 2023 17:01:08 +0800
Message-ID: <20230819090109.14467-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230819090109.14467-1-liuhangbin@gmail.com>
References: <20230819090109.14467-1-liuhangbin@gmail.com>
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


