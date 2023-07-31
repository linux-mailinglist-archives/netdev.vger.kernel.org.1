Return-Path: <netdev+bounces-22873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E66769B22
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26850281492
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A319BAE;
	Mon, 31 Jul 2023 15:48:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4C19BA5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:48:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B13A0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxFAC/Z/+rpv12UqfyvWANI2E8//OFua0ezqmENE2G2Qx0r43KcRz0nfxN+HtFOnSaPIdlC4odwyo5XJrLAzF6iG351JdMnyECiDUPTHV6mieONo9hP+7PB51zTm5OZql9Zbqb8K/wxN454B38wuCMs5OnnVWq9+PWTuvvBXf1c5Ai/tdr7vVeMzWFiaVPN0FoTlpV5jj/vI5acMlWcxwdt+jFcUgXt6f1HxOAnC9sqNKKWYXmytoLidmA3Mt358M70pwOx/PU8dTBZR8nI5qGlLjp3CAiyMppK0TlXQubfR06NuYoG4V0peCpLoGt8L8q/2UhAOHMHKMG10LrJdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4GESxfDQbYI3hEA9LYPpt76/JbkguZBhfQVLYRHU3k=;
 b=MDVQm5HBf/nvu6B6i3Vc4WtpVi0ZrsaJsgMYmDLqIEH47ZsRrPjUI8IebbGzSVpbLAtu7bfD1dd8ZMZ92F7mINwQAKIkzdQbRwKCulAP/9Fvxuugleug23FD/S2/zS6hkrW4EzNCy2oOy8I6GBEFAxVI9S4DClmnRn9zooVklPNOYUvU3XfmgUxxlavStPx+AoKiDMEe2kvdReYAFTCfj6bAvNCd0IdWtPcOvF/6Un9aCPmzeGeKQzGjdspjiGyWYxsvz/SQ/cLvrBRJloJSeKzaAGgw8vxYH6ZTIHHkugbnIQMefEwkXum+eaD6WaHp7xT3stEgLC8/dnarkFo5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4GESxfDQbYI3hEA9LYPpt76/JbkguZBhfQVLYRHU3k=;
 b=A3eX7ysWtbwY3zHPQja01KUZglWqdFoqS8RHz+WOQnntsJLZTxCpPJk/nNysll0NYfe2U85FlR0+dUsLVcDQpKqoM7JSwmhlFtiUF2pVWALvuCwIym0fbqmibb2rRKpDR+kkes97pOgGLjPyzlmrKKZWXMCkdlk1mf/uGwL4zjGoog9ifiu/NMKm7x+3OgsnlDTSJnO1Z0nAwUbGdWYDfgVA0REgxiRpe+d8fhLLpeA2+cKyliIUKFBylIpxP7lZeU6dmSNqh+UNirjvsmHT37teKHr37Y5WIKox5bnSR09p7q1dTo//zwCtUObh2a9+6Cki8VOQIIxTZgcGwGW2Qg==
Received: from DM6PR11CA0060.namprd11.prod.outlook.com (2603:10b6:5:14c::37)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:47:58 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::9b) by DM6PR11CA0060.outlook.office365.com
 (2603:10b6:5:14c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Mon, 31 Jul 2023 15:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43 via Frontend Transport; Mon, 31 Jul 2023 15:47:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:47:50 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:47:47 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/8] selftests: router_bridge_1d: Add a new selftest
Date: Mon, 31 Jul 2023 17:47:16 +0200
Message-ID: <b81015db1af194b857632f476a04dd679b4f62e8.1690815746.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690815746.git.petrm@nvidia.com>
References: <cover.1690815746.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a1671e-e27d-4202-8d7e-08db91dd8387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iIhwhGPRxgNZ0lINVrSyrIdu/VU+LdEj+3sZa8SfjLd2KUiL9XZMJBw7biryVD6oP8HGSG+WmRmyHgfFz4SwGkhEBxExHIY+Gf+xlS3aozmai1B+/7isTCjm6OhipRaW1KnXF9U9okc5Te3cJsjOVaP4c8DqdJ2G5PisW/OzaQ0BkToRebyJI7dg+2pbs1xgRNyDADF9CBaY58AGhYGXLJJ22yxOK3ZSM7dHOlJGvVGuN+KawzPYVKAX8qeiEMlRBBKJeRsQm4+qjGmzftCnikGkOK3agTWfC97DBcNF4Thw7RqCD/eOgEcl+ToVQ27Y0juuCqdm7rVmrQ+haDo21NAlY3Hg6JO1FlXtjnu1AoRiqqJ1kyCJgPeaoBUqmlbVhSNQUOBLOpimTVEtw5d28tDoWU+bUDeVZDjXiBfz8AcDt4OfBClIurKriQTC695KupO9hnPArTjwjC6Ulj5t7vtL63zmeB9qHGtjG/cb0ceRJ3pdLVDpiIqb27usoY1IxZLtq9KfAHIWeJxedG9ZyQ7Zp41ayxknJUdWAqtozu2IvnxLmpOPwvddz/cjo0W+CQThKwsw6nbHLD3giuVNR2ViE98inDUovxU9Onmf4sl1T7cfJ9uPFtfzoquRwJufEUcUFqh3cRCochWgUb5iLOUe5akCx6gYBfm+gNq7lq2dtq1U1dhk1e1WYw3xV/BAqX9Vq5Ysy8QhjxivAkaFJnuoJQntCJAWHezwSlKU4iJSC+2lpNgpYn8K4IrkKMxe
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(2906002)(70206006)(70586007)(4326008)(5660300002)(110136005)(54906003)(41300700001)(316002)(16526019)(2616005)(6666004)(7696005)(8936002)(26005)(8676002)(336012)(186003)(107886003)(66574015)(426003)(36860700001)(47076005)(83380400001)(356005)(82740400003)(7636003)(478600001)(36756003)(40460700003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:47:58.2149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a1671e-e27d-4202-8d7e-08db91dd8387
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest to verify that routing through a 1d bridge works when VLAN
upper of a physical port is used instead of a physical port. Also verify
that when a port is attached to an already-configured bridge, the
configuration is applied.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/router_bridge_1d.sh        | 185 ++++++++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_1d.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 2d8bb72762a4..96b6dcefbc65 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -64,6 +64,7 @@ TEST_PROGS = bridge_igmp.sh \
 	q_in_vni_ipv6.sh \
 	q_in_vni.sh \
 	router_bridge.sh \
+	router_bridge_1d.sh \
 	router_bridge_vlan.sh \
 	router_bridge_pvid_vlan_upper.sh \
 	router_bridge_vlan_upper_pvid.sh \
diff --git a/tools/testing/selftests/net/forwarding/router_bridge_1d.sh b/tools/testing/selftests/net/forwarding/router_bridge_1d.sh
new file mode 100755
index 000000000000..6d51f2ca72a2
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_bridge_1d.sh
@@ -0,0 +1,185 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +---------------------------------------------+      +----------------------+
+# | H1 (vrf)                                    |      |             H2 (vrf) |
+# |    + $h1.100            + $h1.200           |      |  + $h2               |
+# |    | 192.0.2.1/28       | 192.0.2.17/28     |      |  | 192.0.2.130/28    |
+# |    | 2001:db8:1::1/64   | 2001:db8:3::1/64  |      |  | 192.0.2.146/28    |
+# |    \_________ __________/                   |      |  | 2001:db8:2::2/64  |
+# |              V                              |      |  | 2001:db8:4::2/64  |
+# |              + $h1                          |      |  |                   |
+# +--------------|------------------------------+      +--|-------------------+
+#                |                                        |
+# +--------------|----------------------------------------|-------------------+
+# | SW           + $swp1                                  + $swp2             |
+# |              |                                          192.0.2.129/28    |
+# |              |                                          192.0.2.145/28    |
+# |              |                                          2001:db8:2::1/64  |
+# |      ________^___________________________               2001:db8:4::1/64  |
+# |     /                                    \                                |
+# | +---|------------------------------+ +---|------------------------------+ |
+# | |   + $swp1.100   BR1 (802.1d)     | |   + $swp1.200   BR2 (802.1d)     | |
+# | |                 192.0.2.2/28     | |                 192.0.2.18/28    | |
+# | |                 2001:db8:1::2/64 | |                 2001:db8:3::2/64 | |
+# | |                                  | |                                  | |
+# | +----------------------------------+ +----------------------------------+ |
+# +---------------------------------------------------------------------------+
+
+ALL_TESTS="
+	ping_ipv4
+	ping_ipv6
+	config_remaster
+	ping_ipv4
+	ping_ipv6
+"
+NUM_NETIFS=4
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1
+	vlan_create $h1 100 v$h1 192.0.2.1/28 2001:db8:1::1/64
+	vlan_create $h1 200 v$h1 192.0.2.17/28 2001:db8:3::1/64
+	ip -4 route add 192.0.2.128/28 vrf v$h1 nexthop via 192.0.2.2
+	ip -4 route add 192.0.2.144/28 vrf v$h1 nexthop via 192.0.2.18
+	ip -6 route add 2001:db8:2::/64 vrf v$h1 nexthop via 2001:db8:1::2
+	ip -6 route add 2001:db8:4::/64 vrf v$h1 nexthop via 2001:db8:3::2
+}
+
+h1_destroy()
+{
+	ip -6 route del 2001:db8:4::/64 vrf v$h1
+	ip -6 route del 2001:db8:2::/64 vrf v$h1
+	ip -4 route del 192.0.2.144/28 vrf v$h1
+	ip -4 route del 192.0.2.128/28 vrf v$h1
+	vlan_destroy $h1 200
+	vlan_destroy $h1 100
+	simple_if_fini $h1
+}
+
+h2_create()
+{
+	simple_if_init $h2 192.0.2.130/28 2001:db8:2::2/64 \
+			   192.0.2.146/28 2001:db8:4::2/64
+	ip -4 route add 192.0.2.0/28 vrf v$h2 nexthop via 192.0.2.129
+	ip -4 route add 192.0.2.16/28 vrf v$h2 nexthop via 192.0.2.145
+	ip -6 route add 2001:db8:1::/64 vrf v$h2 nexthop via 2001:db8:2::1
+	ip -6 route add 2001:db8:3::/64 vrf v$h2 nexthop via 2001:db8:4::1
+}
+
+h2_destroy()
+{
+	ip -6 route del 2001:db8:3::/64 vrf v$h2
+	ip -6 route del 2001:db8:1::/64 vrf v$h2
+	ip -4 route del 192.0.2.16/28 vrf v$h2
+	ip -4 route del 192.0.2.0/28 vrf v$h2
+	simple_if_fini $h2 192.0.2.130/28 2001:db8:2::2/64 \
+			   192.0.2.146/28 2001:db8:4::2/64
+}
+
+router_create()
+{
+	ip link set dev $swp1 up
+
+	vlan_create $swp1 100
+	ip link add name br1 type bridge vlan_filtering 0
+	ip link set dev br1 address $(mac_get $swp1.100)
+	ip link set dev $swp1.100 master br1
+	__addr_add_del br1 add 192.0.2.2/28 2001:db8:1::2/64
+	ip link set dev br1 up
+
+	vlan_create $swp1 200
+	ip link add name br2 type bridge vlan_filtering 0
+	ip link set dev br2 address $(mac_get $swp1.200)
+	ip link set dev $swp1.200 master br2
+	__addr_add_del br2 add 192.0.2.18/28 2001:db8:3::2/64
+	ip link set dev br2 up
+
+	ip link set dev $swp2 up
+	__addr_add_del $swp2 add 192.0.2.129/28 2001:db8:2::1/64 \
+				 192.0.2.145/28 2001:db8:4::1/64
+}
+
+router_destroy()
+{
+	__addr_add_del $swp2 del 192.0.2.129/28 2001:db8:2::1/64 \
+				 192.0.2.145/28 2001:db8:4::1/64
+	ip link set dev $swp2 down
+
+	__addr_add_del br2 del 192.0.2.18/28 2001:db8:3::2/64
+	ip link set dev $swp1.200 nomaster
+	ip link del dev br2
+	vlan_destroy $swp1 200
+
+	__addr_add_del br1 del 192.0.2.2/28 2001:db8:1::2/64
+	ip link set dev $swp1.100 nomaster
+	ip link del dev br1
+	vlan_destroy $swp1 100
+
+	ip link set dev $swp1 down
+}
+
+config_remaster()
+{
+	log_info "Remaster bridge slaves"
+
+	ip link set dev $swp1.100 nomaster
+	ip link set dev $swp1.200 nomaster
+	sleep 2
+	ip link set dev $swp1.200 master br2
+	ip link set dev $swp1.100 master br1
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	vrf_prepare
+
+	h1_create
+	h2_create
+
+	router_create
+
+	forwarding_enable
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	forwarding_restore
+
+	router_destroy
+
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+}
+
+ping_ipv4()
+{
+	ping_test $h1 192.0.2.130 ": via 100"
+	ping_test $h1 192.0.2.146 ": via 200"
+}
+
+ping_ipv6()
+{
+	ping6_test $h1 2001:db8:2::2 ": via 100"
+	ping6_test $h1 2001:db8:4::2 ": via 200"
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.41.0


