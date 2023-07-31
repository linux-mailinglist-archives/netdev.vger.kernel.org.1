Return-Path: <netdev+bounces-22875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23997769B28
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F385E1C2033E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABFA19BA5;
	Mon, 31 Jul 2023 15:48:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682A19BA0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:48:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761810D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST32HD2isuvE1ycdjmzYMpsuTwpTF3okHn9Ws7tjI89Ez7ZUMZrAVwwtBsqX72WZurbhSgNRyW697+VmxeMhxY/XtQiqIUsLJn3UOD5fTe1D8TVTUQAHmbv60UngIg0RK/+QWUPNGM+6XJW8W7t067t2QYUQy6SW+bvK7A+yXm6BgmQ1/bWS+7dbm6bMknGi3816V8JaDVfp+bQCUp/0GjPmDVHITlobZ8KKDXpP+tIpJlOeOx0HVjR44tMFfmgkWQypvNPd9YBmM+15ovco6odSsLPHvAOTyhf3okk0NlHqPXSv6zLHgTQK5rrgn7tkbiiYLkilb2lhlkScF8RBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/sZrdeyn7vqHX0R+19h2yRYw4nY1o/PgfW7F7eGkCs=;
 b=fJ4LmLu85i2UI2OQEmgCUQEnMqpV6Ly/TnWODAR+ibjHeAFO8uCxjYBw3GNX+S4aS81vTIyK57bJTtyVTCJLpKKSRseXCP1yevXjnpy+nBtbqZxnt9cwEuP/mKSm9asqW3k0aUeXRcNTiFd9ylDHY4TES5JwaPBTTWIfWCNFs8KrDftsPB0CgZTNPN19rGMVEBQZe9pZpy3HeS6mW10dt2gLjUJvddIYBpSLE95OlFXGv93bBZDShWyjrLmW4x244jsgrKEe0wu6UDGpX88nGDg4u4F5L5z0VnikzXY+A+AWZ5pZgwnW7EXfZTwsvuRWLbCPh58bXPjYXAop6L8zTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/sZrdeyn7vqHX0R+19h2yRYw4nY1o/PgfW7F7eGkCs=;
 b=ZDehBmCQWyDHWuVCMnjU+bfB9/3Jx1EJ1iNLhvMLtql3j7p78Iz4FejLpmvOdscpygVOH7LS3JPuVS03mAkab9jK7WinU1sA0Hn1iJPaUktMWrFLHUKasV0Iu+JwOOx4nQPTrE6kta4aUd95fCEBmS1w/qtPSvCbD+c33+GTmRli1vFdEg0s9BN3LOdwXLGWQEM5vwnDVyjWffEML8dUiecVqkapIR4l1TpiVXU0QZfRrSZwX8vHG5g7gaEwdSr2gxzjcRvUV+vKExV3lL4Wgy3gwu+Pi/QPaCbgYf2pyYuTFiSkLwfzt59RQky0Gwu7JUr4BUwyPVn/wlE4cPuA2g==
Received: from SJ0PR13CA0063.namprd13.prod.outlook.com (2603:10b6:a03:2c4::8)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 15:48:07 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::96) by SJ0PR13CA0063.outlook.office365.com
 (2603:10b6:a03:2c4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.10 via Frontend
 Transport; Mon, 31 Jul 2023 15:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 15:48:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:47:57 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:47:54 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/8] selftests: router_bridge_lag: Add a new selftest
Date: Mon, 31 Jul 2023 17:47:18 +0200
Message-ID: <4f2d65bf06dff74a97649f8234c1f1f7d01d3ce7.1690815746.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3a6fe3-41ae-42c5-86dc-08db91dd886f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/zvEgBk2aLoBLReqP0xu0dbtN+AGesz2O6t8f2wb7DlWB/pksvEheeylShklABYap1tJnC2t9nLw8EuK6L+ERlioul3Ucm6MqCxME4+dKHw8O2+lC2VN//teclhNSdV4N4P1UhsjggZiVZihDE4pazhNifvhFxdultPQQ4J8hju+CyQiLcT9qYrPXG4OXFptH1g5ah7iLmoXtQwKXnLlNfHX8dLI1q4HeBrHl1ihfyV5PSojd4AeRrfpAAiuUOiNwxy39Tbu1RzNc6XjtaG9ngXYbr//R1huxKnfjGgrxWuVCKNrU4iH12GQu5kSVn3VDTzpsH7kHlW+Ywna4FJ1L3eDkX+T3MIkJRP16Alg6FCfcA9xsZ+2QgS9f/1Yttt9AaO16ufbqaPy+10lkuIHIKSlEx8Ko/fySD+m96Qw6hRgUXYLUi3XmRcX2YKJ8O8pN7cAzPnKNZko60VzGXi7JvWqnNhqZwnXdC1/2GW2tXs+4sWNArWeDMSErWYUUNxairL0SDXfwPvF9HaxU6XoiTAmjFbsbo0Da+x2rsB0qBin2PbAFSXHkeGHo3G8nOXNtrVSJ2KvwyHi/OBA7A6Lg9LqMwQBOHJ2umO/sE31KW4JE9gcaZA95/t0HtEH3miYvKYGjIytEZXEqLZGtUCnMqYH6Tro+G131Y/qd5FhBFmNBPSYB2Mjx5idZhCabrWr/7IczLpYwgfqKj4Qwm/4iUigMoysI38HnPGF5+mzf+6XkCP2B26HBGj/p88PCAlg
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(4326008)(41300700001)(5660300002)(8676002)(70586007)(70206006)(8936002)(356005)(82740400003)(7636003)(110136005)(54906003)(478600001)(316002)(2906002)(86362001)(6666004)(7696005)(40460700003)(83380400001)(426003)(66574015)(26005)(36860700001)(40480700001)(107886003)(2616005)(336012)(16526019)(36756003)(186003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:48:06.4304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3a6fe3-41ae-42c5-86dc-08db91dd886f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest to verify that routing through a bridge works when LAG is
used instead of physical ports.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/router_bridge_lag.sh       | 323 ++++++++++++++++++
 2 files changed, 324 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_lag.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 44a0308d8bc2..2fd0f4f87210 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -65,6 +65,7 @@ TEST_PROGS = bridge_igmp.sh \
 	q_in_vni.sh \
 	router_bridge.sh \
 	router_bridge_1d.sh \
+	router_bridge_lag.sh \
 	router_bridge_vlan.sh \
 	router_bridge_vlan_upper.sh \
 	router_bridge_pvid_vlan_upper.sh \
diff --git a/tools/testing/selftests/net/forwarding/router_bridge_lag.sh b/tools/testing/selftests/net/forwarding/router_bridge_lag.sh
new file mode 100755
index 000000000000..f05ffe213c46
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_bridge_lag.sh
@@ -0,0 +1,323 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +----------------------------+                   +--------------------------+
+# | H1 (vrf)                   |                   |                 H2 (vrf) |
+# |                            |                   |                          |
+# |        + LAG1 (team)       |                   |     + LAG4 (team)        |
+# |        | 192.0.2.1/28      |                   |     | 192.0.2.130/28     |
+# |        | 2001:db8:1::1/64  |                   |     | 2001:db8:2::2/64   |
+# |      __^___                |                   |   __^_____               |
+# |     /      \               |                   |  /        \              |
+# |    + $h1    + $h4          |                   | + $h2      + $h3         |
+# |    |        |              |                   | |          |             |
+# +----|--------|--------------+                   +-|----------|-------------+
+#      |        |                                    |          |
+# +----|--------|------------------------------------|----------|-------------+
+# | SW |        |                                    |          |             |
+# |    + $swp1  + $swp4                              + $swp2    + $swp3       |
+# |     \__ ___/                                      \__ _____/              |
+# |        v                                             v                    |
+# | +------|-------------------------------+             |                    |
+# | |      + LAG2       BR1 (802.1q)       |             + LAG3 (team)        |
+# | |        (team)       192.0.2.2/28     |               192.0.2.129/28     |
+# | |                     2001:db8:1::2/64 |               2001:db8:2::1/64   |
+# | |                                      |                                  |
+# | +--------------------------------------+                                  |
+# +---------------------------------------------------------------------------+
+
+: ${ALL_TESTS:="
+	ping_ipv4
+	ping_ipv6
+
+	$(: exercise remastering of LAG2 slaves )
+	config_deslave_swp4
+	config_wait
+	ping_ipv4
+	ping_ipv6
+	config_enslave_swp4
+	config_deslave_swp1
+	config_wait
+	ping_ipv4
+	ping_ipv6
+	config_deslave_swp4
+	config_enslave_swp1
+	config_enslave_swp4
+	config_wait
+	ping_ipv4
+	ping_ipv6
+
+	$(: exercise remastering of LAG2 itself )
+	config_remaster_lag2
+	config_wait
+	ping_ipv4
+	ping_ipv6
+
+	$(: exercise remastering of LAG3 slaves )
+	config_deslave_swp2
+	config_wait
+	ping_ipv4
+	ping_ipv6
+	config_enslave_swp2
+	config_deslave_swp3
+	config_wait
+	ping_ipv4
+	ping_ipv6
+	config_deslave_swp2
+	config_enslave_swp3
+	config_enslave_swp2
+	config_wait
+	ping_ipv4
+	ping_ipv6
+
+	$(: move LAG3 to a bridge and then out )
+	config_remaster_lag3
+	config_wait
+	ping_ipv4
+	ping_ipv6
+    "}
+NUM_NETIFS=8
+: ${lib_dir:=.}
+source $lib_dir/lib.sh
+$EXTRA_SOURCE
+
+h1_create()
+{
+	team_create lag1 lacp
+	ip link set dev lag1 address $(mac_get $h1)
+	ip link set dev $h1 master lag1
+	ip link set dev $h4 master lag1
+	simple_if_init lag1 192.0.2.1/28 2001:db8:1::1/64
+	ip link set dev $h1 up
+	ip link set dev $h4 up
+	ip -4 route add 192.0.2.128/28 vrf vlag1 nexthop via 192.0.2.2
+	ip -6 route add 2001:db8:2::/64 vrf vlag1 nexthop via 2001:db8:1::2
+}
+
+h1_destroy()
+{
+	ip -6 route del 2001:db8:2::/64 vrf vlag1
+	ip -4 route del 192.0.2.128/28 vrf vlag1
+	ip link set dev $h4 down
+	ip link set dev $h1 down
+	simple_if_fini lag1 192.0.2.1/28 2001:db8:1::1/64
+	ip link set dev $h4 nomaster
+	ip link set dev $h1 nomaster
+	team_destroy lag1
+}
+
+h2_create()
+{
+	team_create lag4 lacp
+	ip link set dev lag4 address $(mac_get $h2)
+	ip link set dev $h2 master lag4
+	ip link set dev $h3 master lag4
+	simple_if_init lag4 192.0.2.130/28 2001:db8:2::2/64
+	ip link set dev $h2 up
+	ip link set dev $h3 up
+	ip -4 route add 192.0.2.0/28 vrf vlag4 nexthop via 192.0.2.129
+	ip -6 route add 2001:db8:1::/64 vrf vlag4 nexthop via 2001:db8:2::1
+}
+
+h2_destroy()
+{
+	ip -6 route del 2001:db8:1::/64 vrf vlag4
+	ip -4 route del 192.0.2.0/28 vrf vlag4
+	ip link set dev $h3 down
+	ip link set dev $h2 down
+	simple_if_fini lag4 192.0.2.130/28 2001:db8:2::2/64
+	ip link set dev $h3 nomaster
+	ip link set dev $h2 nomaster
+	team_destroy lag4
+}
+
+router_create()
+{
+	team_create lag2 lacp
+	ip link set dev lag2 address $(mac_get $swp1)
+	ip link set dev $swp1 master lag2
+	ip link set dev $swp4 master lag2
+
+	ip link add name br1 address $(mac_get lag2) \
+		type bridge vlan_filtering 1
+	ip link set dev lag2 master br1
+
+	ip link set dev $swp1 up
+	ip link set dev $swp4 up
+	ip link set dev br1 up
+
+	__addr_add_del br1 add 192.0.2.2/28 2001:db8:1::2/64
+
+	team_create lag3 lacp
+	ip link set dev lag3 address $(mac_get $swp2)
+	ip link set dev $swp2 master lag3
+	ip link set dev $swp3 master lag3
+	ip link set dev $swp2 up
+	ip link set dev $swp3 up
+	__addr_add_del lag3 add 192.0.2.129/28 2001:db8:2::1/64
+}
+
+router_destroy()
+{
+	__addr_add_del lag3 del 192.0.2.129/28 2001:db8:2::1/64
+	ip link set dev $swp3 down
+	ip link set dev $swp2 down
+	ip link set dev $swp3 nomaster
+	ip link set dev $swp2 nomaster
+	team_destroy lag3
+
+	__addr_add_del br1 del 192.0.2.2/28 2001:db8:1::2/64
+
+	ip link set dev $swp4 down
+	ip link set dev $swp1 down
+	ip link set dev br1 down
+
+	ip link set dev lag2 nomaster
+	ip link del dev br1
+
+	ip link set dev $swp4 nomaster
+	ip link set dev $swp1 nomaster
+	team_destroy lag2
+}
+
+config_remaster_lag2()
+{
+	log_info "Remaster bridge slave"
+
+	ip link set dev lag2 nomaster
+	sleep 2
+	ip link set dev lag2 master br1
+}
+
+config_remaster_lag3()
+{
+	log_info "Move lag3 to the bridge, then out again"
+
+	ip link set dev lag3 master br1
+	sleep 2
+	ip link set dev lag3 nomaster
+}
+
+config_deslave()
+{
+	local netdev=$1; shift
+
+	log_info "Deslave $netdev"
+	ip link set dev $netdev down
+	ip link set dev $netdev nomaster
+	ip link set dev $netdev up
+}
+
+config_deslave_swp1()
+{
+	config_deslave $swp1
+}
+
+config_deslave_swp2()
+{
+	config_deslave $swp2
+}
+
+config_deslave_swp3()
+{
+	config_deslave $swp3
+}
+
+config_deslave_swp4()
+{
+	config_deslave $swp4
+}
+
+config_enslave()
+{
+	local netdev=$1; shift
+	local master=$1; shift
+
+	log_info "Enslave $netdev to $master"
+	ip link set dev $netdev down
+	ip link set dev $netdev master $master
+	ip link set dev $netdev up
+}
+
+config_enslave_swp1()
+{
+	config_enslave $swp1 lag2
+}
+
+config_enslave_swp2()
+{
+	config_enslave $swp2 lag3
+}
+
+config_enslave_swp3()
+{
+	config_enslave $swp3 lag3
+}
+
+config_enslave_swp4()
+{
+	config_enslave $swp4 lag2
+}
+
+config_wait()
+{
+	setup_wait_dev lag2
+	setup_wait_dev lag3
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
+	swp3=${NETIFS[p5]}
+	h3=${NETIFS[p6]}
+
+	h4=${NETIFS[p7]}
+	swp4=${NETIFS[p8]}
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
+	ping_test lag1 192.0.2.130
+}
+
+ping_ipv6()
+{
+	ping6_test lag1 2001:db8:2::2
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


