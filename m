Return-Path: <netdev+bounces-22876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBEE769B2F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33951C208CC
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B819BA3;
	Mon, 31 Jul 2023 15:48:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE78182DA
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:48:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F231723
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax7kLINWajPqDu14PxR19nDdwymDBI7wr4bXBP/94918CYiqU/QUgRrkWauXBkqx4xHiBJMWzp86SzeHoR22lfGJXlCW2J0V2/DtrQhU6I1algI041HfzgPrT22DUtFaUcayvxZGn77ndi+Pqy4/o+wRo/Pygif+0B4KUgfA77m5v7zLnBqUSWAeoLe/IA7USg6A/1fLuzL1vXIGdxU96+re28Xx7+1A3eLkGTVj2yXiXgYSCPIXmeYH6lhGDAoK1feM5qXKNxxRl1sCb2mOmS65rl2d+bUWLE0206TI1AayvFTEWgekkYwqVJS7L7DudO5W8PrK+5bjgzi2H3D9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if2Ak1fofNhYUoHUZKdKyZyUpDHp5aA39YzSE2eTLQw=;
 b=Zu1fOXexppm9zbtn+WUH4qfmc5fJcCciEdQce3ijRXcxiZp7tYsnRcnZ5pYmrS2EDnRV3B6Sjb8Kc5phG9AWXg+SX1kN7gTvR/2uwGV0ngNCzh+VA3mNOgyeROz4upu1vw74eftPglQ8NRCWId4xi6MKcNBDul1Bj/sNHXHVPp7nthQj/A+7Wk9HT7BGzO0PWbUZacJRXJnOajMotuoboz1ZgmPor5+/BMEsU1lb3DsUpdmsB2qLcrqvkr/7g3E0Nlcj4JEto0T2hK//1nt9JCS4ULR0E3XlPbar4Kff7c7sTcJnartBIfTI8Oy2TRXlKGkOYNMgI2ZtVw4mgE8AZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if2Ak1fofNhYUoHUZKdKyZyUpDHp5aA39YzSE2eTLQw=;
 b=NYZkfULqXYcUtgRP+TV9N2R1NrULuiJgI0qxiLLaUI2H7BodL9Y0qPgfYhwpVAoqwwULeB8jyuoXWiiUoEgM0JasGzEf12qymIYZ6to2gz0e6Y542H/lu2yYrv7YjwZB7zPCfRwGJQDxaZrNKWblJjiSIUJalI3c7PYkstEn3l1JXGIkLle8wsFrFYWQUWAYkZ2zM4mZQovUkpLuKBVo7sm4JYyr3wUli+kR3VdWsj3Itb4IA2o2Kr1L+Sbzk2Lem+AfgYchFs2+s/xhjo0KvgpyzEogYHJKzRo1aoa49R4J2InZ6NkqJgAkIBuY1iU45CX+MKXhgkxPMQ/NB7MsiQ==
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:48:16 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::cc) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Mon, 31 Jul 2023 15:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 15:48:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:48:01 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:47:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/8] selftests: router_bridge_1d_lag: Add a new selftest
Date: Mon, 31 Jul 2023 17:47:19 +0200
Message-ID: <bb9567b154b5fd966d8f6f0e18d2211194520ab7.1690815746.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: eaaa5a17-952b-4947-144f-08db91dd8d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xuPtqJ8Mn1MYRH9cAtvbho2QRr9UdjcQNdGidTFtQf5yiG6hJ1loV8qFWX4HJlsZGZVor0R6z2nhTvSRBqoMPh+7wPQFHM7sv04Vpd1Fc3g64QhxzIIRVaQqfpwG6b4zoXOmioWWdMWUyaoK6zI/u0dEWAdK6xaAqCf2Hn7v/hrrkSWLxEudy5QAciDbw+QdaXktVa+w+RCH+fSP/Dbz78e/ykNoFUVlzWiAYGszk7lAuo20doUI/HNnzHZ/JNCPzp0kPk+b6voru+snQuo5PjKBm/ARYRU68Ojbsrv4R3w6Dhpo4sH8xp/5hOyNnJVvSTxTNSH09KDwW+TYkEknvL44feCxInqkcduIKeB7eP+cePYB7nnD2erJFa/f8PLyeL4L4DyC/XguNNOnUmJBUVv55TGoiNGM1MDOT3TGoWMBZslk/Iq4Rkj0rueMCEFTtl28vJVnzEaeJnHG7zQz7opNipEXVgBqIcjIrTo1KWli3KcCSLYsJZGUYDN6ThdAektyONF1sEN9Nj+FeZcVCN59/XEw2pE0lRx3CDNiNmUFZqmqGEMppUMD7DXW9IEaxWp6GLgafiKtHOJBpCPXs7HZwvZeR+IozeBqGX2pnCHmOypTOyg7diV6E7DiOZabXbndT4m0iUCogG0XOv4mWkjvqHujRIcVodfnTiNwuqcgm/hm/QozaaPnfaldn+nl5kczu6HLy4G1TvE5fa0bXzX+/ZgNNv9ooNUL2XQ2h/A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(5660300002)(70586007)(70206006)(2906002)(4326008)(316002)(54906003)(110136005)(41300700001)(2616005)(478600001)(6666004)(7696005)(8676002)(8936002)(26005)(107886003)(16526019)(336012)(186003)(66574015)(426003)(36860700001)(47076005)(83380400001)(7636003)(356005)(82740400003)(36756003)(40480700001)(40460700003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:48:14.7113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaa5a17-952b-4947-144f-08db91dd8d5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest to verify that routing through several bridges works when
LAG VLANs are used instead of physical ports, and that routing through LAG
VLANs themselves works as physical ports are de/enslaved.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/router_bridge_1d_lag.sh    | 408 ++++++++++++++++++
 2 files changed, 409 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 2fd0f4f87210..74e754e266c3 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -65,6 +65,7 @@ TEST_PROGS = bridge_igmp.sh \
 	q_in_vni.sh \
 	router_bridge.sh \
 	router_bridge_1d.sh \
+	router_bridge_1d_lag.sh \
 	router_bridge_lag.sh \
 	router_bridge_vlan.sh \
 	router_bridge_vlan_upper.sh \
diff --git a/tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh b/tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh
new file mode 100755
index 000000000000..e064b946e821
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh
@@ -0,0 +1,408 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +--------------------------------------------+
+# | H1 (vrf)                                   |
+# |                                            |
+# |    + LAG1.100          + LAG1.200          |
+# |    | 192.0.2.1/28      | 192.0.2.17/28     |
+# |    | 2001:db8:1::1/64  | 2001:db8:3:1/64   |
+# |    \___________ _______/                   |
+# |                v                           |
+# |                + LAG1 (team)               |
+# |                |                           |
+# |            ____^____                       |
+# |           /         \                      |
+# |          + $h1       + $h4                 |
+# |          |           |                     |
+# +----------|-----------|---------------------+
+#            |           |
+# +----------|-----------|---------------------+
+# | SW       |           |                     |
+# |          + $swp1     + $swp4               |
+# |           \____ ____/                      |
+# |                v                           |
+# |    LAG2 (team) +                           |
+# |                |                           |
+# |         _______^______________             |
+# |        /                      \            |
+# | +------|------------+ +-------|----------+ |
+# | |      + LAG2.100   | |       + LAG2.200 | |
+# | |                   | |                  | |
+# | |  BR1 (802.1d)     | | BR2 (802.1d)     | |
+# | |  192.0.2.2/28     | | 192.0.2.18/28    | |
+# | |  2001:db8:1::2/64 | | 2001:db8:3:2/64  | |
+# | |                   | |                  | |
+# | +-------------------+ +------------------+ |
+# |                                            |
+# |  + LAG3.100             + LAG3.200         |
+# |  | 192.0.2.129/28       | 192.0.2.145/28   |
+# |  | 2001:db8:2::1/64     | 2001:db8:4::1/64 |
+# |  |                      |                  |
+# |  \_________ ___________/                   |
+# |            v                               |
+# |            + LAG3 (team)                   |
+# |        ____|____                           |
+# |       /         \                          |
+# |       + $swp2   + $swp3                    |
+# |       |         |                          |
+# +-------|---------|--------------------------+
+#         |         |
+# +-------|---------|--------------------------+
+# |       |         |                          |
+# |       + $h2     + $h3                      |
+# |       \____ ___/                           |
+# |            |                               |
+# |            + LAG4 (team)                   |
+# |            |                               |
+# |  __________^__________                     |
+# | /                     \                    |
+# | |                     |                    |
+# | + LAG4.100            + LAG4.200           |
+# |   192.0.2.130/28        192.0.2.146/28     |
+# |   2001:db8:2::2/64      2001:db8:4::2/64   |
+# |                                            |
+# | H2 (vrf)                                   |
+# +--------------------------------------------+
+
+ALL_TESTS="
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
+"
+NUM_NETIFS=8
+source lib.sh
+
+h1_create()
+{
+	team_create lag1 lacp
+	ip link set dev lag1 addrgenmode none
+	ip link set dev lag1 address $(mac_get $h1)
+	ip link set dev $h1 master lag1
+	ip link set dev $h4 master lag1
+	simple_if_init lag1
+	ip link set dev $h1 up
+	ip link set dev $h4 up
+
+	vlan_create lag1 100 vlag1 192.0.2.1/28 2001:db8:1::1/64
+	vlan_create lag1 200 vlag1 192.0.2.17/28 2001:db8:3::1/64
+
+	ip -4 route add 192.0.2.128/28 vrf vlag1 nexthop via 192.0.2.2
+	ip -6 route add 2001:db8:2::/64 vrf vlag1 nexthop via 2001:db8:1::2
+
+	ip -4 route add 192.0.2.144/28 vrf vlag1 nexthop via 192.0.2.18
+	ip -6 route add 2001:db8:4::/64 vrf vlag1 nexthop via 2001:db8:3::2
+}
+
+h1_destroy()
+{
+	ip -6 route del 2001:db8:4::/64 vrf vlag1
+	ip -4 route del 192.0.2.144/28 vrf vlag1
+
+	ip -6 route del 2001:db8:2::/64 vrf vlag1
+	ip -4 route del 192.0.2.128/28 vrf vlag1
+
+	vlan_destroy lag1 200
+	vlan_destroy lag1 100
+
+	ip link set dev $h4 down
+	ip link set dev $h1 down
+	simple_if_fini lag1
+	ip link set dev $h4 nomaster
+	ip link set dev $h1 nomaster
+	team_destroy lag1
+}
+
+h2_create()
+{
+	team_create lag4 lacp
+	ip link set dev lag4 addrgenmode none
+	ip link set dev lag4 address $(mac_get $h2)
+	ip link set dev $h2 master lag4
+	ip link set dev $h3 master lag4
+	simple_if_init lag4
+	ip link set dev $h2 up
+	ip link set dev $h3 up
+
+	vlan_create lag4 100 vlag4 192.0.2.130/28 2001:db8:2::2/64
+	vlan_create lag4 200 vlag4 192.0.2.146/28 2001:db8:4::2/64
+
+	ip -4 route add 192.0.2.0/28 vrf vlag4 nexthop via 192.0.2.129
+	ip -6 route add 2001:db8:1::/64 vrf vlag4 nexthop via 2001:db8:2::1
+
+	ip -4 route add 192.0.2.16/28 vrf vlag4 nexthop via 192.0.2.145
+	ip -6 route add 2001:db8:3::/64 vrf vlag4 nexthop via 2001:db8:4::1
+}
+
+h2_destroy()
+{
+	ip -6 route del 2001:db8:3::/64 vrf vlag4
+	ip -4 route del 192.0.2.16/28 vrf vlag4
+
+	ip -6 route del 2001:db8:1::/64 vrf vlag4
+	ip -4 route del 192.0.2.0/28 vrf vlag4
+
+	vlan_destroy lag4 200
+	vlan_destroy lag4 100
+
+	ip link set dev $h3 down
+	ip link set dev $h2 down
+	simple_if_fini lag4
+	ip link set dev $h3 nomaster
+	ip link set dev $h2 nomaster
+	team_destroy lag4
+}
+
+router_create()
+{
+	team_create lag2 lacp
+	ip link set dev lag2 addrgenmode none
+	ip link set dev lag2 address $(mac_get $swp1)
+	ip link set dev $swp1 master lag2
+	ip link set dev $swp4 master lag2
+
+	vlan_create lag2 100
+	vlan_create lag2 200
+
+	ip link add name br1 type bridge vlan_filtering 0
+	ip link set dev br1 address $(mac_get lag2.100)
+	ip link set dev lag2.100 master br1
+
+	ip link add name br2 type bridge vlan_filtering 0
+	ip link set dev br2 address $(mac_get lag2.200)
+	ip link set dev lag2.200 master br2
+
+	ip link set dev $swp1 up
+	ip link set dev $swp4 up
+	ip link set dev br1 up
+	ip link set dev br2 up
+
+	__addr_add_del br1 add 192.0.2.2/28 2001:db8:1::2/64
+	__addr_add_del br2 add 192.0.2.18/28 2001:db8:3::2/64
+
+	team_create lag3 lacp
+	ip link set dev lag3 addrgenmode none
+	ip link set dev lag3 address $(mac_get $swp2)
+	ip link set dev $swp2 master lag3
+	ip link set dev $swp3 master lag3
+	ip link set dev $swp2 up
+	ip link set dev $swp3 up
+
+	vlan_create lag3 100
+	vlan_create lag3 200
+
+	__addr_add_del lag3.100 add 192.0.2.129/28 2001:db8:2::1/64
+	__addr_add_del lag3.200 add 192.0.2.145/28 2001:db8:4::1/64
+}
+
+router_destroy()
+{
+	__addr_add_del lag3.200 del 192.0.2.145/28 2001:db8:4::1/64
+	__addr_add_del lag3.100 del 192.0.2.129/28 2001:db8:2::1/64
+
+	vlan_destroy lag3 200
+	vlan_destroy lag3 100
+
+	ip link set dev $swp3 down
+	ip link set dev $swp2 down
+	ip link set dev $swp3 nomaster
+	ip link set dev $swp2 nomaster
+	team_destroy lag3
+
+	__addr_add_del br2 del 192.0.2.18/28 2001:db8:3::2/64
+	__addr_add_del br1 del 192.0.2.2/28 2001:db8:1::2/64
+
+	ip link set dev br2 down
+	ip link set dev br1 down
+	ip link set dev $swp4 down
+	ip link set dev $swp1 down
+
+	ip link set dev lag2.200 nomaster
+	ip link del dev br2
+
+	ip link set dev lag2.100 nomaster
+	ip link del dev br1
+
+	vlan_destroy lag2 200
+	vlan_destroy lag2 100
+
+	ip link set dev $swp4 nomaster
+	ip link set dev $swp1 nomaster
+	team_destroy lag2
+}
+
+config_remaster_lag2()
+{
+	log_info "Remaster bridge slaves"
+
+	ip link set dev lag2.200 nomaster
+	ip link set dev lag2.100 nomaster
+	sleep 2
+	ip link set dev lag2.100 master br1
+	ip link set dev lag2.200 master br2
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
+	ping_test lag1.100 192.0.2.130 ": via 100"
+	ping_test lag1.200 192.0.2.146 ": via 200"
+}
+
+ping_ipv6()
+{
+	ping6_test lag1.100 2001:db8:2::2 ": via 100"
+	ping6_test lag1.200 2001:db8:4::2 ": via 200"
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


