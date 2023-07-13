Return-Path: <netdev+bounces-17654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E4752833
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A5F1C20A2B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628E200C6;
	Thu, 13 Jul 2023 16:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F1C200CA
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3064271C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF2+9Ad03p/hOlY9Eu5oKDp2I7hzd+ETKAbvd4BN/lhskYpnhb5eYCI+xyIMyD9SwsEdFQlTijuzeAE0v+AK/YAv3fRq5nSRw6R7wPDPrQdZV00V6pU6ntQAdkWusbui4gQdcy4aeKkg91/AEyiGSo+mh2f90btXjWyD9SyBNBZyYqD9pY4EB5u6Mq4j3iGsVirv8GAZr9ecri007aRQHeWr0IxTRErZ4lYeinC7nxXMnchmmGBLv1kZ30zVpm61Up73sBG3XbxYXrtOcpZi3BDj5qrlBhDJwxGoQFQUE+EGzN49Z9TMTRG2kCP2DxabKuPlvm49QNWRmbvK2+jMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnFWNq9TIfilyWZbh7JB/CX5sHDksIp7dKDktDN+UUY=;
 b=CDg8iAOa7iSOCzV5+npB02twm/NDXiFAmCiPIIDXyVjmewCzUQOGvGU/Q2Zgp0eqwkLRWRLPycDyQmqNuBN7VX4+2yTth2PTc4FFJSIWpw7E1hHhKIzXvgR8SWwOq5XGX4L/qBNFn1Q7W32JIWflHIbFl8z1bCV6u9vz/QmElOEFAm9S2MLOcXDcIvr7hpL393Frm+FzjeGO+cR98dBhs36xLdN0N4npefqlqI++xumo/7xuNsJ0FSjnWu9hDoq7icZ5xKxqps01CdFOAL8QmcrDoJOJScONt5XqnDAh4XrAVe9AmcrpUAptFszSgabGezUV1kravDUo+madd7ZfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnFWNq9TIfilyWZbh7JB/CX5sHDksIp7dKDktDN+UUY=;
 b=OXMKvhUWZuz6irfBWtUEBtQXe6S3B1jNz2iQ7KE64qnbKiyvuSVSauqWkncND5FOHbZgd5ONku86CMIx7Ov6Kr13SJO70SaLAGF9zAEuyKk9vGK0K5euo+/Hn9iPrLIo2Kb7RHtxTclc5vxW/t4nsEY7Ol+KwdBV/6oYJKq+JQHu+Jb/UNMnFjI4RbVw0I8B1UpM+E1DYIN6Zx9vBfTQu0s3TYdDH6NtXrkDvrsWFkEhuYUil0ZgRLY18joJ0TVfeUNTmQ+WEv67IoPVoW9Mf0vBtsCKO+Ei/2mnYlwqRjBq0yeYOyawZlADG1ygsRu4aDV1ZKybtieP67m+0E/fMA==
Received: from BN9PR03CA0380.namprd03.prod.outlook.com (2603:10b6:408:f7::25)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 16:16:44 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::a6) by BN9PR03CA0380.outlook.office365.com
 (2603:10b6:408:f7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:28 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/11] selftests: router_bridge_vlan_upper_pvid: Add a new selftest
Date: Thu, 13 Jul 2023 18:15:33 +0200
Message-ID: <9112d2c8d435d2e6087e6fcc3fddff5e8ce314f0.1689262695.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e09d3d7-cfd1-478d-3a5b-08db83bc8cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tGBhnj1TO5AwMTOSpgSeUhAlaSIVNdDz4inlZpPkrU2/D9dezHqVNPzDv2jBHPXIk6SFQiEmR0Vi7yV6fzmusHQ4rWlr3mYla+m2Y1hyBZWyVtRnZJV8dDXxw+G78I4hdjLdzx3Sj1dkM87TmVV5Dkm6Cz/p+UqU5lPldD8mnGPTjxCpw0PdtmYelGANlxBYdb+SqqDJJ6fCqutKAwTs4X0+DUkM89+R035fNjpYD5HI3vypZ+DJc51QDAd1198GZcWoRyAcQjejr+g3xPnlLBTxn6ZhXR+3kqRaqfsDZVbQ4uU8Pn37NXGRxwY3MzYn0+ZtIhDmu2uinXu/tKkFyxpnUK74ywevmPM6xwBycRSaF6c5XwT43ulbU8YWdVtovXHNWrWbWzBBgep8F0g7eudjdtORIscurSc+RSiBJFQdr0qpTyd+tQ8ohUQ+2+oDypOnx6tPnkZPp9Y6SHGxLbq9UkyZAmM50LOrRTTH7EHtuDY6iwRup7ci4s4WgP7cff2SMNugwmnIyesDTIMW6mgAXJUhWEYFCipKorfA/+iLYissD+TSrfuV3uP38cOihMbDzp/MKudxzfz0BRM99uWnwITJBOP3PiDoI5wKGugyzEkiiRnaQQWfMJkMgchLVUOyxCE9l0k5wnW8d2efLc9E+yg6fbXvONfb6SLVnQUSVL0GyFdNmLEPlF7yPxtopTDUkbbxNfLioqniN+It/8z6ktLdSvfAgjhmRJLvTEI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(7636003)(356005)(82740400003)(110136005)(54906003)(86362001)(82310400005)(6666004)(4326008)(36860700001)(70206006)(47076005)(70586007)(316002)(83380400001)(66574015)(426003)(41300700001)(2616005)(36756003)(2906002)(40480700001)(8676002)(8936002)(107886003)(16526019)(40460700003)(186003)(26005)(336012)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:44.2826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e09d3d7-cfd1-478d-3a5b-08db83bc8cf0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This tests whether changes to PVID that coincide with an existing VLAN
upper throw off forwarding. This selftests is specifically geared towards
offloading drivers, but since there's nothing HW-specific in the test
itself (it absolutely is supposed to pass on SW datapath), it is put into
the generic forwarding directory.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../router_bridge_vlan_upper_pvid.sh          | 171 ++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_vlan_upper_pvid.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index f49c6c3f6520..1a21990d0864 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -65,6 +65,7 @@ TEST_PROGS = bridge_igmp.sh \
 	q_in_vni.sh \
 	router_bridge.sh \
 	router_bridge_vlan.sh \
+	router_bridge_vlan_upper_pvid.sh \
 	router_broadcast.sh \
 	router_mpath_nh_res.sh \
 	router_mpath_nh.sh \
diff --git a/tools/testing/selftests/net/forwarding/router_bridge_vlan_upper_pvid.sh b/tools/testing/selftests/net/forwarding/router_bridge_vlan_upper_pvid.sh
new file mode 100755
index 000000000000..138558452402
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_bridge_vlan_upper_pvid.sh
@@ -0,0 +1,171 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +----------------------------+
+# |                   H1 (vrf) |
+# |   + $h1.10                 |                      +----------------------+
+# |   | 192.0.2.1/28           |                      |             H2 (vrf) |
+# |   | 2001:db8:1::1/64       |                      |  + $h2               |
+# |   |                        |                      |  | 192.0.2.130/28    |
+# |   + $h1                    |                      |  | 2001:db8:2::2/64  |
+# +---|------------------------+                      +--|-------------------+
+#     |                                                  |
+# +---|--------------------------------------------------|-------------------+
+# |   |                            router (main VRF)     |                   |
+# | +-|--------------------------+                       + $swp2             |
+# | | + $swp1      BR1 (802.1q)  |                         192.0.2.129/28    |
+# | +-----+----------------------+                         2001:db8:2::1/64  |
+# |       |                                                                  |
+# |       + br1.10                                                           |
+# |         192.0.2.2/28                                                     |
+# |         2001:db8:1::2/64                                                 |
+# +--------------------------------------------------------------------------+
+
+ALL_TESTS="
+	ping_ipv4
+	ping_ipv6
+	pvid_set_unset
+	ping_ipv4
+	ping_ipv6
+	pvid_set_move
+	ping_ipv4
+	ping_ipv6
+"
+NUM_NETIFS=4
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1
+	vlan_create $h1 10 v$h1 192.0.2.1/28 2001:db8:1::1/64
+	ip -4 route add 192.0.2.128/28 vrf v$h1 nexthop via 192.0.2.2
+	ip -6 route add 2001:db8:2::/64 vrf v$h1 nexthop via 2001:db8:1::2
+}
+
+h1_destroy()
+{
+	ip -6 route del 2001:db8:2::/64 vrf v$h1
+	ip -4 route del 192.0.2.128/28 vrf v$h1
+	vlan_destroy $h1 10
+	simple_if_fini $h1
+}
+
+h2_create()
+{
+	simple_if_init $h2 192.0.2.130/28 2001:db8:2::2/64
+	ip -4 route add 192.0.2.0/28 vrf v$h2 nexthop via 192.0.2.129
+	ip -6 route add 2001:db8:1::/64 vrf v$h2 nexthop via 2001:db8:2::1
+}
+
+h2_destroy()
+{
+	ip -6 route del 2001:db8:1::/64 vrf v$h2
+	ip -4 route del 192.0.2.0/28 vrf v$h2
+	simple_if_fini $h2 192.0.2.130/28 2001:db8:2::2/64
+}
+
+router_create()
+{
+	ip link add name br1 address $(mac_get $swp1) \
+		type bridge vlan_filtering 1 vlan_default_pvid 0
+	ip link set dev br1 up
+
+	ip link set dev $swp1 master br1
+	ip link set dev $swp1 up
+
+	ip link set dev $swp2 up
+	__addr_add_del $swp2 add 192.0.2.129/28 2001:db8:2::1/64
+
+	bridge vlan add dev br1 vid 10 self
+	bridge vlan add dev $swp1 vid 10
+	vlan_create br1 10 "" 192.0.2.2/28 2001:db8:1::2/64
+}
+
+router_destroy()
+{
+	vlan_destroy br1 10
+	bridge vlan del dev $swp1 vid 10
+	bridge vlan del dev br1 vid 10 self
+
+	__addr_add_del $swp2 del 192.0.2.129/28 2001:db8:2::1/64
+	ip link set dev $swp2 down
+
+	ip link set dev $swp1 down
+	ip link set dev $swp1 nomaster
+
+	ip link del dev br1
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
+pvid_set_unset()
+{
+	log_info "Set and unset PVID on VLAN 10"
+
+	bridge vlan add dev br1 vid 10 pvid self
+	sleep 1
+	bridge vlan add dev br1 vid 10 self
+}
+
+pvid_set_move()
+{
+	log_info "Set PVID on VLAN 10, then move it to VLAN 20"
+
+	bridge vlan add dev br1 vid 10 pvid self
+	sleep 1
+	bridge vlan add dev br1 vid 20 pvid self
+}
+
+shuffle_vlan()
+{
+	log_info ""
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
+	ping_test $h1 192.0.2.130
+}
+
+ping_ipv6()
+{
+	ping6_test $h1 2001:db8:2::2
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
2.40.1


