Return-Path: <netdev+bounces-22879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2DB769B3A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68FF28140E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341519BAD;
	Mon, 31 Jul 2023 15:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B019BAB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:48:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E074198C
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzOn5Qkv1H1GjDj3H8OH357lL7yiYfXSntpiMpNIZxqf0Zl5IG56Wc4abLcUncquN9u2rTE4hp4ERdxNivfd6iwxC7Uy8JUKOIxbnv0fvPFsRlhMfiS72592f/oakWx7JgieKZaso+z0XPFRCHn6oRpXLt0oThzq7t6ki2UBi5cEUGMakal3QvLhb3+DtSd+yR7IK4wAmDfy4TdFQMMX3rLyYboH7d6Z5rZWXmzqhHmgyvoaqH4vNVaiaNop2c6Ltp1wwOAT98a96trhp8CgFFF6gv5ZQEUbuRFxHacixXcZd3+WwwJ6AZmZ2z5nQB+eVTtws5irfCOEmrqxk6Ofzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEKgquNj/B+bLTx1Q2rH295xoIgcaNBDwcjHlBvjZ4U=;
 b=N3U5FJy3Gk9eHDY6RtTAJNacbc8Oo5AIQhjkrsIs9scFmxRb6CTSBqI14ijI88bAKuor/NrfXjJkG52p1ozHuHJbsmhh+2Xya0bjxgQPvqR0evhvg5EUCxUtKUoYS8KFWTNMO5Dj5yWJ/vn4uepipx5Q8rYYF3/4VMiT3jXIOYPR+cc/Z4D50sJ8rK2CD8p626LHBFwMQmp059t+k+14pluA5K4DYrlHEEQrrkOeEogCpSFPieo4ngRMt83myn/9rBQhhEG7WqOeAgiWEoEg7McQ5EG5Njfas6tb34t7ZRSFd8S8gIAoIekrpGX8sh9kPBqzbMSMVCmcONsIP/j0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEKgquNj/B+bLTx1Q2rH295xoIgcaNBDwcjHlBvjZ4U=;
 b=EJi7NBL3/we0DcQo1vb3UjGF++rl2b937yBT+LfQ7KdUzSYNmXQAUSZ9zRkqkUcm7R4exbAFtyCdAOMgJaTNC/R2VuHxZLpJC/m7U6tHASCilY0uJpFAi0szbieOAaA2I+dUl3UoDSCwMwMuw35Ip7K+3Z5lh8lZ7+hh+xQk65HcUnay8BL4XYtoF4Y3mu4tEr3IoncpkEPgMwo4ZvKdCurxAQwu0k4q/5sFJOHwG6Cuz/i84zTGtQXKM7TxgTBy2U3jSIUVcn8TCZPACIcnPUIjM95SPqY+dtu44arJgVf2o3/0a5S1wNfr1qShyEOeW4HPAOoZVh7w9iQoJMQsDQ==
Received: from SJ0PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:33f::17)
 by BL0PR12MB4852.namprd12.prod.outlook.com (2603:10b6:208:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:48:27 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::65) by SJ0PR05CA0042.outlook.office365.com
 (2603:10b6:a03:33f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.12 via Frontend
 Transport; Mon, 31 Jul 2023 15:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 15:48:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:48:11 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:48:08 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 8/8] selftests: mlxsw: rif_bridge: Add a new selftest
Date: Mon, 31 Jul 2023 17:47:22 +0200
Message-ID: <607eaf8e33eb452af4ac007c0bb04113564c912d.1690815746.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|BL0PR12MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: e18631b7-393c-453a-2087-08db91dd941d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7C9Q/X/ZK1PVwq1vgkqs/O4XaoMs+5LQKRhJqDEjx+p4avhdLsqsRCBPubLtld+KmfzO8n/CO/CpPXD52x2SFra91koZfoCSSN/tQ6/54AVRPPfHCFCsyHR6MOQOAuR3bhSlaTOQDClVkAJ1CJIuoORq3knVq+rPVWok0YtowFDlpN8V8NLYbVYwJeZpA7RTXad9/eElEAyXxToKuKJGrLoLpZmEjXDSnlwdICiCF5xQYtPrrUHT7jIqvXHHisGBVIPcYueDPcmzQxIEatd6SGSj8ROX84xzQF6QhZNviJ6rJqgaVrUEj9sbn0gvNxYuoGKbXhNHv63ExAmLAT5k/3Lkg+q89twyTfN7bppjabmFhKVCO6pRw8bg0jlflETHk2fNjyKCUIDJYYPLJB5CV0eCusu+EpEngoLhzA7uXWewyq0/xr9C9wTHbftmqvpIXmZsTvSToJfxTkIrGgPappwT6g84vXsIsRVD70VQhHSMd6GA1AH685Xa7H9k9Y8AaaWDFZWQuU36SxCjXRNuGJROVL+DWMHi+ELsIVlWSAYtGJv7BZiHYsvn2zKUOX8Cp1gZakpvSIN1rxc7mw+f+wmXwEI3iFhmSrcGhDDWbiUVNtq0+8AjBUfu4It9fLHnIg66eabC891fZgrgUeTLTUTuwHsYJyvkbT+LI1CpXGmSLL4L7/Ty86Y9wL4zLxCk1U4o8jlDT4hD94wDM/hV8Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(82310400008)(46966006)(36840700001)(41300700001)(5660300002)(70206006)(70586007)(8936002)(8676002)(40480700001)(54906003)(110136005)(4326008)(478600001)(316002)(2906002)(107886003)(7696005)(6666004)(82740400003)(356005)(26005)(186003)(336012)(16526019)(36756003)(426003)(47076005)(2616005)(36860700001)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:48:26.0387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18631b7-393c-453a-2087-08db91dd941d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4852
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This test verifies driver behavior with regards to creation of RIFs for a
bridge as LAGs are added or removed to/from it, and ports added or removed
to/from the LAG.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/rif_bridge.sh | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh

diff --git a/tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh b/tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh
new file mode 100755
index 000000000000..b79542a4dcc7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh
@@ -0,0 +1,183 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+lib_dir=$(dirname $0)/../../../net/forwarding
+
+ALL_TESTS="
+	bridge_rif_add
+	bridge_rif_nomaster
+	bridge_rif_remaster
+	bridge_rif_nomaster_addr
+	bridge_rif_nomaster_port
+	bridge_rif_remaster_port
+"
+
+NUM_NETIFS=2
+source $lib_dir/lib.sh
+source $lib_dir/devlink_lib.sh
+
+setup_prepare()
+{
+	swp1=${NETIFS[p1]}
+	swp2=${NETIFS[p2]}
+
+	team_create lag1 lacp
+	ip link set dev lag1 addrgenmode none
+	ip link set dev lag1 address $(mac_get $swp1)
+
+	team_create lag2 lacp
+	ip link set dev lag2 addrgenmode none
+	ip link set dev lag2 address $(mac_get $swp2)
+
+	ip link add name br1 type bridge vlan_filtering 1
+	ip link set dev br1 addrgenmode none
+	ip link set dev br1 address $(mac_get lag1)
+	ip link set dev br1 up
+
+	ip link set dev lag1 master br1
+
+	ip link set dev $swp1 master lag1
+	ip link set dev $swp1 up
+
+	ip link set dev $swp2 master lag2
+	ip link set dev $swp2 up
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	ip link set dev $swp2 nomaster
+	ip link set dev $swp2 down
+
+	ip link set dev $swp1 nomaster
+	ip link set dev $swp1 down
+
+	ip link del dev lag2
+	ip link set dev lag1 nomaster
+	ip link del dev lag1
+
+	ip link del dev br1
+}
+
+bridge_rif_add()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	__addr_add_del br1 add 192.0.2.2/28
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 + 1))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Add RIF for bridge on address addition"
+}
+
+bridge_rif_nomaster()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	ip link set dev lag1 nomaster
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 - 1))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Drop RIF for bridge on LAG deslavement"
+}
+
+bridge_rif_remaster()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	ip link set dev lag1 master br1
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 + 1))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Add RIF for bridge on LAG reenslavement"
+}
+
+bridge_rif_nomaster_addr()
+{
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+
+	# Adding an address while the LAG is enslaved shouldn't generate a RIF.
+	__addr_add_del lag1 add 192.0.2.65/28
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "After adding IP: Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	# Removing the LAG from the bridge should drop RIF for the bridge (as
+	# tested in bridge_rif_lag_nomaster), but since the LAG now has an
+	# address, it should gain a RIF.
+	ip link set dev lag1 nomaster
+	sleep 1
+	local rifs_occ_t2=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0))
+
+	((expected_rifs == rifs_occ_t2))
+	check_err $? "After deslaving: Expected $expected_rifs RIFs, $rifs_occ_t2 are used"
+
+	log_test "Add RIF for LAG on deslavement from bridge"
+
+	__addr_add_del lag1 del 192.0.2.65/28
+	ip link set dev lag1 master br1
+	sleep 1
+}
+
+bridge_rif_nomaster_port()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	ip link set dev $swp1 nomaster
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 - 1))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Drop RIF for bridge on deslavement of port from LAG"
+}
+
+bridge_rif_remaster_port()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	ip link set dev $swp1 down
+	ip link set dev $swp1 master lag1
+	ip link set dev $swp1 up
+	setup_wait_dev $swp1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 + 1))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Add RIF for bridge on reenslavement of port to LAG"
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


