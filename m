Return-Path: <netdev+bounces-22878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90059769B34
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A751C203A5
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353619BAA;
	Mon, 31 Jul 2023 15:48:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDA19BA9
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:48:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6671A19A4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AESg741KLHLjQpVYCrxiceRV14qDcdO5FAC291WwrdlENKGceSXLDem1SKQDQiyikTKDeTl2jOYYqCkNZtTil2SecbyQIaDWnYNp6ex2SEthxxARaejbr5FV8OkyY8FWt65DokErHsz5ozIKd1rXDkpOyOViDEZvejMqSIP6bsDYjVWm+xqvOu3Elw5GUt1FqV3PRqjBuAhN65IMrwOCXKYS7qAueuzddm3bKqjQCyRix2Avj/B0i47H1qa5cQv4kwoxoCQZ//rhz+1aE3oje+uzIAj/FhPsQxaSwjs96Hn/YivCsIiuieyNMekCwhMu3vQinUyQHqEorE7vosIT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89mCWuMnASCYpKHnVhoMQUjzPgIc9Zl8sisqIeALkmQ=;
 b=ipFpThf6Cc2RLx9pfxXodKjopzMYuffdNJY5hs82h4FQdrrjGgvE2T/qyJKcSdTGzT90SgkJib/4tmSq02Y/oZTwWvgZbdIF48gC7KP7ozxuJEItKnBi9DjRJmS4fuo2ekjUxi5NFf6ij89E0X0BlFKtH0DZBshK3nvU34+F/ppdCBSydMKPFsD3OlKxezCCmwJcQCM3VpcBdLADoy6FunSu/Tt1VmUoQp+OUo/ulZ1q9hfKVMjtJ+n9XpUtdC2SgNMje4uffKcz0kp4cD80SozsXH1und0JjW1bMHhFKjrvglDLtVBoPcthY5FUwxPWEmx0t16ETKNVrxi7PPoiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89mCWuMnASCYpKHnVhoMQUjzPgIc9Zl8sisqIeALkmQ=;
 b=J3sbEOvDKuuFug5dm9UlZLY4fkcyNoA4im1ugdkWORWHBPF/BbQrBuuVSi1wltL6I6RE4BIsVWQs/JIDrnJM8rIaq2qo92usiStuke1Zqu+8S9+nehMumqPNOlGZI8qrLRV14zSbfCxR73RhTfzf0mtdEBBLNj0A1y0wXGKE8bhxbjuJfokC9LSIEqcOqR4zJJBBVMGIdLwYVOx1SKv5IsiI68ZcIfqyBqUs2BVCFlCupYpNUP04ribtX5GwsHi2uYHV5epk0dufeCv5TlyRG0Zx1OzeCfpSeU+QutdHxJSNmKbhvOcHKWLWswe+mO1fU3UYOp0fIc37YZRtYT6aMg==
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:48:22 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::a2) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 15:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 15:48:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:48:08 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:48:05 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 7/8] selftests: mlxsw: rif_lag_vlan: Add a new selftest
Date: Mon, 31 Jul 2023 17:47:21 +0200
Message-ID: <62f288aa765dbf6e66e32cf4c3c90b381e04c097.1690815746.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT083:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 2487dd9d-1d1b-4037-167e-08db91dd914b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FTtqtesYUkuhZMkXrHanTLwr9Z/Cx/tJ3SKNytuFcnjen1465qz08Jdx3yVf6uUvQ71ur2jJ4jxkj3zeJxBp4AVCZpywM0ToR6tZqXhYfdY/3r0Jii4Bcj3b9GK9Hc26fJG3IBs9Nq9lOD4RCTgdcVJSfEPnavHjbBN9ie0tAZ7PljXtNcqTp/4kSqxHAR9KcoOit10iZ2mR+fO1RKbi+qI8wI59UxOCAeg4dDMSG3YlOH7/U3qN5pLwzMhF7ZWti0pj5XZ8ECwUPNxBHNFdcfXS9RAckszqYoImhjac+2FCTgemWPLrO7bW4ZwGnNWVdGM0+xTx7bOOGPgxlhYwPv19nisMKnjQIusRls4wrE0gouij8OaE/CYRJVvMByD67bxAu6TKtYtZ3fkhGHsXVl60QMt4NeIuXp7RETlzm502BDM2eu7Z3buOB/ISbKg4nRZmXYq4Wl8eHcqAZeHi2LyjxFDtDlHayYjfxd1iIB/lQvbXybzDGbF5HXe+f4hLk4axE+xcq3WaU1bqs85yi2VV3g3u9CHBQMqKgpmhghWzhfjSJoU8pKUDEh8AkvKbKnHPG1Z3p0oNXuBXz1JMohJ/wB//ISheBkomDXfhHfu/REnhpnMyrKc0A+mXZEi/YlYTuwEmnxdKHOxIEGNtwbjFT4PBWgGsMqFAtLWChcw/AeE/m1/+c4y4+l0h/zC3wy6m3bfzQtxenTKcmEQ7jgpNY+pB1lcPgwtT24bppAD7b7ocEEITobRGKaGezH+9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(86362001)(8676002)(8936002)(316002)(4326008)(5660300002)(41300700001)(356005)(54906003)(7636003)(70206006)(70586007)(82740400003)(110136005)(478600001)(2906002)(6666004)(36756003)(47076005)(36860700001)(7696005)(107886003)(26005)(426003)(186003)(336012)(16526019)(40460700003)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:48:21.3536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2487dd9d-1d1b-4037-167e-08db91dd914b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This test verifies driver behavior with regards to creation of RIFs for LAG
VLAN uppers as ports are added or removed to/from the LAG.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../drivers/net/mlxsw/rif_lag_vlan.sh         | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh

diff --git a/tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh b/tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh
new file mode 100755
index 000000000000..6318cfa6434c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh
@@ -0,0 +1,146 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+lib_dir=$(dirname $0)/../../../net/forwarding
+
+ALL_TESTS="
+	lag_rif_add
+	lag_rif_nomaster
+	lag_rif_remaster
+	lag_rif_nomaster_addr
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
+	ip link set dev $swp1 master lag1
+	ip link set dev $swp1 up
+
+	ip link set dev $swp2 master lag2
+	ip link set dev $swp2 up
+
+	vlan_create lag1 100
+	ip link set dev lag1.100 addrgenmode none
+
+	vlan_create lag1 200
+	ip link set dev lag1.200 addrgenmode none
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	ip link del dev lag1.200
+	ip link del dev lag1.100
+
+	ip link set dev $swp2 nomaster
+	ip link set dev $swp2 down
+
+	ip link set dev $swp1 nomaster
+	ip link set dev $swp1 down
+
+	ip link del dev lag2
+	ip link del dev lag1
+}
+
+lag_rif_add()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	__addr_add_del lag1.100 add 192.0.2.2/28
+	__addr_add_del lag1.200 add 192.0.2.18/28
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 + 2))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Add RIFs for LAG VLANs on address addition"
+}
+
+lag_rif_nomaster()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	ip link set dev $swp1 nomaster
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 - 2))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Drop RIFs for LAG VLANs on port deslavement"
+}
+
+lag_rif_remaster()
+{
+	RET=0
+
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+	ip link set dev $swp1 down
+	ip link set dev $swp1 master lag1
+	ip link set dev $swp1 up
+	setup_wait_dev $swp1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 + 2))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	log_test "Add RIFs for LAG VLANs on port reenslavement"
+}
+
+lag_rif_nomaster_addr()
+{
+	local rifs_occ_t0=$(devlink_resource_occ_get rifs)
+
+	# Adding an address while the port is LAG'd shouldn't generate a RIF.
+	__addr_add_del $swp1 add 192.0.2.65/28
+	sleep 1
+	local rifs_occ_t1=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0))
+
+	((expected_rifs == rifs_occ_t1))
+	check_err $? "After adding IP: Expected $expected_rifs RIFs, $rifs_occ_t1 are used"
+
+	# Removing the port from LAG should drop two RIFs for the LAG VLANs (as
+	# tested in lag_rif_nomaster), but since the port now has an address, it
+	# should gain a RIF.
+	ip link set dev $swp1 nomaster
+	sleep 1
+	local rifs_occ_t2=$(devlink_resource_occ_get rifs)
+	local expected_rifs=$((rifs_occ_t0 - 1))
+
+	((expected_rifs == rifs_occ_t2))
+	check_err $? "After deslaving: Expected $expected_rifs RIFs, $rifs_occ_t2 are used"
+
+	__addr_add_del $swp1 del 192.0.2.65/28
+	log_test "Add RIF for port on deslavement from LAG"
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


