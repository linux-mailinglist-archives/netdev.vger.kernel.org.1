Return-Path: <netdev+bounces-17653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F1F752832
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3251C213E4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E2200C7;
	Thu, 13 Jul 2023 16:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED4200BB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999152710
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh+j2kUNh6nO7U0C0siPwQUpHPhwRLzm24c7OInJA6016MoGJTaP3mwHL5NgzDVL4mO29IZ8gikzfCRS08COnhqbnYmgOA78uohJhcIa/zszFKtind4PPuv3/xBT354kGd5RxD/FFQalovzseaklOjg1g8D2ER9CHiVfbD2b7orKDglNsGfz1FANBrSPGrMVnhiritbtL2UIKjPA6hLF5JbKPvBQMoXP99nS5j7HY2e6wbqnFF8ka49BoABfP/dwmbmmVSQNmVYNkY5Qw+pVzDj8X8A+FoMAPZSyPBlD4l9QAWr9zYWM73LYO+EV19WEDY8wkPEb0SDk0cc8Uum/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAtDKoEqaWwqMbk0FWvxGw9WpyKGlhQUwRlaEgKbA8U=;
 b=R/MroTafF+Zf1bt+OO7aG231Mhf7Lr5+VVuCUpABD5KOq+9gx63Vf9gUDL86CSSeiSB/F7CZ4Rw9hgkovWF3551MRZYQhwFAuYEuSW4xiKL/zUwYbKiClKU+ZoWZIcEYFavHBQLcWX0dIcq+vS01/D19+8DV6+C9Y1s1Q/B+okD4YqLMo8l9AfgCjpJqOypDtxqVEoh5ZO15I/97ZpQD2xNVc3+ESEQiIMO5m5DLk1oHRj73Bx3fCENL0a3ynb1DwiJYt1EEWN3imobiH+LsLeQ47Qogebp9a4tKEkeSEm9n1k/iGr8qsg6VdRo6jVDXxbMtnHS687fgjLreX+Y6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAtDKoEqaWwqMbk0FWvxGw9WpyKGlhQUwRlaEgKbA8U=;
 b=s+kjsheps5cRUMosa1dP63COqJ1vFTPd7inPcqp7UDHFzULZrZWG07oaBQIdNzelwNgN0bRV1DgN0YUYrubGc/5Tr8WcDVY6k+7QrS1J1sTW2u9GBv0rMLlHk1+3QgH9FYytl/7oW2L56P5iOV+UDHOkmYG7tH/qtxB9uXL7P3vKY5jTpKTApSIu4H+0aiKsPO8pM4bFV/x9dm+iyirBccPXU7abnXNjrllxXWNmMz6IqaCUTW00wwXMQzmtDdylABgkk6iiK3lRxuRhkhZZVMLPvscmpdr1XrZIki2DtgyOa34KVpIqOgD6JQ5hnRqdDEb/cCCxPAzUbPzYDqMLAw==
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 16:16:41 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::66) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:25 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:22 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/11] selftests: router_bridge_vlan: Add PVID change test
Date: Thu, 13 Jul 2023 18:15:32 +0200
Message-ID: <6c8b0be5510e7d8ed4b9058745923851da1b94c7.1689262695.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689262695.git.petrm@nvidia.com>
References: <cover.1689262695.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 1329ac7e-1873-4270-d03e-08db83bc8ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CCQPRAotObt81IFbGBA0bCAFTgnoscph2Ik8Zhx/meMTjlnR3LG2upnu1YjXDwEPLhw6p24R0wGIqyzikmR9G0QEYK7Pgpbos75d2HQjqZRz57kweOyyuw6L9dbv696kDJe6hQNKd8FTygEiXrjUSX/5A4HFq9+wKaQM/MpVjtBkbSX/iQglCBuA8rubIEy5XUiOjZ8b8NqUnN8uVhd/oSKrk4a8vR55qDOngX8ao/eRBIqodGiBcNlWHAO9E8iB42lYv/+Gtmou/8uj6DLS78DXQvStwLXX+AEOb14eRiBUIP4pnsnZdPF54OlQ5+GusQtODf9U6tJ2Sbs0Yg6T2Yffe7T/KuVaYGBInVs6nrI4AVDJo7WJWSQaBtxjRhbVYUkKirqrJaYz461ayXJrP53srrbG6WXqzM7sWJxvJ0AQt/9rbJEi0ZWBw8S0SNPG19/DGLMJwIYjKAusHj6oGRDdxAz6jI5Nyud3/aye9gvPItKXWttn70vapieXw8DeG/JqUUlZG5NG8R7digwncHhrVOrhxuoxc3GsGRNdprMJ4yhOD1ghEM8ZIZk9PTlot540kRGqF79i4lwai1FoYJdejfGfpurARzdsUUqBm3IwB05U31D8J6Y+b95tffdvzLwFFQFKZs0kxGWOVb3SjiWt6s7++e5tW3rmA2Xmt9LAqv0KBVCzJ8FtMPkAPZsuaAcSE+PnKMQBBFRS2TN8UGyC3Rnk1WNYiLfXNs7hhh2jTomF5Sgp2K6L5qNMNR6b
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(110136005)(54906003)(186003)(26005)(107886003)(16526019)(70586007)(2906002)(82310400005)(41300700001)(316002)(4326008)(8936002)(8676002)(5660300002)(70206006)(82740400003)(7636003)(356005)(86362001)(40460700003)(36756003)(36860700001)(47076005)(426003)(336012)(66574015)(2616005)(83380400001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:40.6295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1329ac7e-1873-4270-d03e-08db83bc8ac2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add an alternative path involving VLAN 777 instead of the current 555. Then
add tests that verify that marking 777 as PVID makes the 555 path not work,
and the 777 path work.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/forwarding/router_bridge_vlan.sh      | 100 +++++++++++++++---
 1 file changed, 85 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/router_bridge_vlan.sh b/tools/testing/selftests/net/forwarding/router_bridge_vlan.sh
index de2b2d5480dd..b76a4a707a5b 100755
--- a/tools/testing/selftests/net/forwarding/router_bridge_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/router_bridge_vlan.sh
@@ -1,25 +1,28 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# +------------------------+                           +----------------------+
-# | H1 (vrf)               |                           |             H2 (vrf) |
-# |    + $h1.555           |                           |  + $h2               |
-# |    | 192.0.2.1/28      |                           |  | 192.0.2.130/28    |
-# |    | 2001:db8:1::1/64  |                           |  | 2001:db8:2::2/64  |
-# |    |                   |                           |  |                   |
-# |    + $h1               |                           |  |                   |
-# +----|-------------------+                           +--|-------------------+
+# +------------------------------------------------+   +----------------------+
+# | H1 (vrf)                                       |   |             H2 (vrf) |
+# |    + $h1.555           + $h1.777               |   |  + $h2               |
+# |    | 192.0.2.1/28      | 192.0.2.17/28         |   |  | 192.0.2.130/28    |
+# |    | 2001:db8:1::1/64  | 2001:db8:3::1/64      |   |  | 192.0.2.146/28    |
+# |    | .-----------------'                       |   |  | 2001:db8:2::2/64  |
+# |    |/                                          |   |  | 2001:db8:4::2/64  |
+# |    + $h1                                       |   |  |                   |
+# +----|-------------------------------------------+   +--|-------------------+
 #      |                                                  |
 # +----|--------------------------------------------------|-------------------+
 # | SW |                                                  |                   |
 # | +--|-------------------------------+                  + $swp2             |
 # | |  + $swp1                         |                    192.0.2.129/28    |
-# | |    vid 555                       |                    2001:db8:2::1/64  |
-# | |                                  |                                      |
-# | |  + BR1 (802.1q)                  |                                      |
+# | |    vid 555 777                   |                    192.0.2.145/28    |
+# | |                                  |                    2001:db8:2::1/64  |
+# | |  + BR1 (802.1q)                  |                    2001:db8:4::1/64  |
 # | |    vid 555 pvid untagged         |                                      |
 # | |    192.0.2.2/28                  |                                      |
+# | |    192.0.2.18/28                 |                                      |
 # | |    2001:db8:1::2/64              |                                      |
+# | |    2001:db8:3::2/64              |                                      |
 # | +----------------------------------+                                      |
 # +---------------------------------------------------------------------------+
 
@@ -27,6 +30,14 @@ ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
 	vlan
+	config_777
+	ping_ipv4_fails
+	ping_ipv6_fails
+	ping_ipv4_777
+	ping_ipv6_777
+	config_555
+	ping_ipv4
+	ping_ipv6
 "
 NUM_NETIFS=4
 source lib.sh
@@ -34,31 +45,47 @@ source lib.sh
 h1_create()
 {
 	simple_if_init $h1
+
 	vlan_create $h1 555 v$h1 192.0.2.1/28 2001:db8:1::1/64
 	ip -4 route add 192.0.2.128/28 vrf v$h1 nexthop via 192.0.2.2
 	ip -6 route add 2001:db8:2::/64 vrf v$h1 nexthop via 2001:db8:1::2
+
+	vlan_create $h1 777 v$h1 192.0.2.17/28 2001:db8:3::1/64
+	ip -4 route add 192.0.2.144/28 vrf v$h1 nexthop via 192.0.2.18
+	ip -6 route add 2001:db8:4::/64 vrf v$h1 nexthop via 2001:db8:3::2
 }
 
 h1_destroy()
 {
+	ip -6 route del 2001:db8:4::/64 vrf v$h1
+	ip -4 route del 192.0.2.144/28 vrf v$h1
+	vlan_destroy $h1 777
+
 	ip -6 route del 2001:db8:2::/64 vrf v$h1
 	ip -4 route del 192.0.2.128/28 vrf v$h1
 	vlan_destroy $h1 555
+
 	simple_if_fini $h1
 }
 
 h2_create()
 {
-	simple_if_init $h2 192.0.2.130/28 2001:db8:2::2/64
+	simple_if_init $h2 192.0.2.130/28 2001:db8:2::2/64 \
+			   192.0.2.146/28 2001:db8:4::2/64
 	ip -4 route add 192.0.2.0/28 vrf v$h2 nexthop via 192.0.2.129
+	ip -4 route add 192.0.2.16/28 vrf v$h2 nexthop via 192.0.2.145
 	ip -6 route add 2001:db8:1::/64 vrf v$h2 nexthop via 2001:db8:2::1
+	ip -6 route add 2001:db8:3::/64 vrf v$h2 nexthop via 2001:db8:4::1
 }
 
 h2_destroy()
 {
+	ip -6 route del 2001:db8:3::/64 vrf v$h2
 	ip -6 route del 2001:db8:1::/64 vrf v$h2
+	ip -4 route del 192.0.2.16/28 vrf v$h2
 	ip -4 route del 192.0.2.0/28 vrf v$h2
-	simple_if_fini $h2 192.0.2.130/28 2001:db8:2::2/64
+	simple_if_fini $h2 192.0.2.146/28 2001:db8:4::2/64 \
+			   192.0.2.130/28 2001:db8:2::2/64
 }
 
 router_create()
@@ -71,18 +98,23 @@ router_create()
 
 	bridge vlan add dev br1 vid 555 self pvid untagged
 	bridge vlan add dev $swp1 vid 555
+	bridge vlan add dev $swp1 vid 777
 
 	__addr_add_del br1 add 192.0.2.2/28 2001:db8:1::2/64
+	__addr_add_del br1 add 192.0.2.18/28 2001:db8:3::2/64
 
 	ip link set dev $swp2 up
 	__addr_add_del $swp2 add 192.0.2.129/28 2001:db8:2::1/64
+	__addr_add_del $swp2 add 192.0.2.145/28 2001:db8:4::1/64
 }
 
 router_destroy()
 {
+	__addr_add_del $swp2 del 192.0.2.145/28 2001:db8:4::1/64
 	__addr_add_del $swp2 del 192.0.2.129/28 2001:db8:2::1/64
 	ip link set dev $swp2 down
 
+	__addr_add_del br1 del 192.0.2.18/28 2001:db8:3::2/64
 	__addr_add_del br1 del 192.0.2.2/28 2001:db8:1::2/64
 	ip link set dev $swp1 down
 	ip link set dev $swp1 nomaster
@@ -108,6 +140,24 @@ setup_prepare()
 	forwarding_enable
 }
 
+config_555()
+{
+	log_info "Configure VLAN 555 as PVID"
+
+	bridge vlan add dev br1 vid 555 self pvid untagged
+	bridge vlan del dev br1 vid 777 self
+	sleep 2
+}
+
+config_777()
+{
+	log_info "Configure VLAN 777 as PVID"
+
+	bridge vlan add dev br1 vid 777 self pvid untagged
+	bridge vlan del dev br1 vid 555 self
+	sleep 2
+}
+
 cleanup()
 {
 	pre_cleanup
@@ -136,12 +186,32 @@ vlan()
 
 ping_ipv4()
 {
-	ping_test $h1 192.0.2.130
+	ping_test $h1.555 192.0.2.130
 }
 
 ping_ipv6()
 {
-	ping6_test $h1 2001:db8:2::2
+	ping6_test $h1.555 2001:db8:2::2
+}
+
+ping_ipv4_fails()
+{
+	ping_test_fails $h1.555 192.0.2.130 ": via 555"
+}
+
+ping_ipv6_fails()
+{
+	ping6_test_fails $h1.555 2001:db8:2::2 ": via 555"
+}
+
+ping_ipv4_777()
+{
+	ping_test $h1.777 192.0.2.146 ": via 777"
+}
+
+ping_ipv6_777()
+{
+	ping6_test $h1.777 2001:db8:4::2 ": via 777"
 }
 
 trap cleanup EXIT
-- 
2.40.1


