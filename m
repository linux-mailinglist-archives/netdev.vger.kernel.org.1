Return-Path: <netdev+bounces-16904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4620474F604
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CBF281680
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10C1DDD3;
	Tue, 11 Jul 2023 16:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B51E506
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:46:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0F270E
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azgG3uPFOPonDX5rCRhoNZg+YHRpgt0GfPAcaKsBgcIIHdVzcTTeI+aGFTcP0s07UMGo4FywRy/xVqNSTmVLDH7qOZFaKNvsuSuQxjURnuOorHCwLJJ2/x8Xm3zyeQlSq3Qd/q/f1h7YQ9Y/A9JMNu5QYBjvsYnyAuJCIGz07W4y+qlH5e7VP4wAXcdUF7MBndrGtdcMzrQARyiwoXIpPnfKW6jjInLCVu2YGYmyL+ciajQ8hSgMVELPrwHkqPY7G98hQBslkxmip/Gi4wNg4Q77tvs6P0wmjyddz5g478/9KOEKojoHq95WpaRKZCL722vHTTx9FhF74scpnAy67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGPWa/ZsEHQ3FVMpiCoE/U7Ok1R3ZbRiEoExdfiD2wY=;
 b=XnCZzyhc7Et9qTgMclR5P5F4/AwkZYmontN1rrdmJiGdxw8Q5dQ3w6qWXcy4/I5h0hzxF1LVENWuEI2jkJbc4OZMKB/cQRDONScnmKivGWk6Lu2JaSo2pzmV++fOTWRL5u8+ki8fgIy6iLFAqDEm6cI9IXyTANG3FcSZD105Y78XrvYGA1RJhgJn85XjrWIFsyjbyIyd+Sy5owSVyiSP0BCo+RY5faMvfcRE7ecJsXlDMOKWC0iZivbYavMZKOJQUpqvpZJ7WBZHtziLJ8pwwoHIpvQ08NagiRs5AwunUxHSlk7uu2L0UuDeWvFMjeXsJEuE8Q9A5+Z68JXCFo6AEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGPWa/ZsEHQ3FVMpiCoE/U7Ok1R3ZbRiEoExdfiD2wY=;
 b=mxtjMUkJrNsR1P/2VkOzsxIGos1l5qcrhuFHzaaZ+SCDQ3mrnbsH2v+QYoKlEh0XzcEYXqOlwZKPH9bFgT0MIgqghYvFHk0odpCpKat3ZwHCYr5D0QETLeYsHg3UlEB9GfMOgKiJeEHf9rcC7IXu91rCa6aEAW062bbQnOQxWwxYfvGNU72aGFmfwvt+FSLz9fXLC3Y2S8RHXYQEhQ8saGVzI3W9DFn4Jc+Jf+syfZ2iCphI4cD54wB+LIA0+8aXbQzHUnNs3imYHvo+BLbUyIUTpLMcRjpMUJxcjo4nN8ApCjDMTCLVQ3102DZ4lLk+aEiIW53narkhZpH7eNK70w==
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Tue, 11 Jul 2023 16:44:59 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::53) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:47 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 09/10] selftests: mlxsw: Test port range registers' occupancy
Date: Tue, 11 Jul 2023 18:44:02 +0200
Message-ID: <0a2eb63b234fb062ff011e80231868cc80000c81.1689092769.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689092769.git.petrm@nvidia.com>
References: <cover.1689092769.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9d8abd-38b0-4844-e3b4-08db822e2a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QlWlu5PHZssYlCSRVjmBXoBQQ6d1VzPI4/ZnHMoHbjgpg0ldEkUW8FIQj3amKZmdi1xfOJbhpXGzY8Ctr54YuFv20vQCQj1Xd4SfFhWNH2B9PzQuUECmm3UJ02QN8+tA+Q72eYmRS4eh2htek6Mw1YrpHc6gZqh/t2wLkezvguJgIpry9V1vo/7G3NlMz/D5DtONFUv41qNAIlpJHXGcol/TATqkYzWXXKbyHxW5pGLNJSclOGCTlcAL5u1HkJtE2Ny6i5r+AK1U9OFwUqhBe70+MlDBciUUqmRp8ja/sK2Qw2VpMNvV0Tcmv5GfBczcciI9qRdEMnDleNKrXZshaFLCM+1lqOUFTXTRwRK6JeIwN34ymsuwvykeqz7s9e8I5GDrjsBDrwoiz7bxtvy/XYptHDSZOL/G/jyYMm57DLEGFW69t0N6spv4DDdyfIRqd25j7y/zxnh7zZveeSkpfy6aWFQ6A3pkK8Z6mD2E6u6P9KpWByNW2gDG8SZ9WbIhCfXQ3x9ZnUAyB9mQrga36xvQQI4fLkIK0cJAsQXZbm4VxRZRUiHXI1s4lti97pWIihvWd92GB7XpCRTRvVwhCgBCi4usqnj6tQwyPUEgrA9MKm7KGSsJ9tdezU0ynZc0503sX4YWtAMMNU4ZdRk4Z6GTRlzxLdiBVB8v7dS/UR+DEf3UNqyHFsMi9lqD826XUDSWE54TvYi9EmznpHR+J+Ug+Is72S4pLRnBuH11zlzkkGD6IApnkdOQB31NcHfq
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(40460700003)(478600001)(110136005)(54906003)(7636003)(82740400003)(356005)(5660300002)(8936002)(8676002)(2906002)(36756003)(86362001)(82310400005)(4326008)(316002)(40480700001)(70206006)(70586007)(41300700001)(107886003)(26005)(36860700001)(336012)(426003)(47076005)(16526019)(2616005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:59.1217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9d8abd-38b0-4844-e3b4-08db822e2a4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Test that filters that match on the same port range, but with different
combination of IPv4/IPv6 and TCP/UDP all use the same port range
register by observing port range registers' occupancy via
devlink-resource.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/port_range_occ.sh       | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh

diff --git a/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh b/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
new file mode 100755
index 000000000000..b1f0781f6b25
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that filters that match on the same port range, but with different
+# combination of IPv4/IPv6 and TCP/UDP all use the same port range register by
+# observing port range registers' occupancy via devlink-resource.
+
+lib_dir=$(dirname $0)/../../../net/forwarding
+
+ALL_TESTS="
+	port_range_occ_test
+"
+NUM_NETIFS=2
+source $lib_dir/lib.sh
+source $lib_dir/devlink_lib.sh
+
+h1_create()
+{
+	simple_if_init $h1
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1
+}
+
+switch_create()
+{
+	simple_if_init $swp1
+	tc qdisc add dev $swp1 clsact
+}
+
+switch_destroy()
+{
+	tc qdisc del dev $swp1 clsact
+	simple_if_fini $swp1
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	vrf_prepare
+
+	h1_create
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	switch_destroy
+	h1_destroy
+
+	vrf_cleanup
+}
+
+port_range_occ_get()
+{
+	devlink_resource_occ_get port_range_registers
+}
+
+port_range_occ_test()
+{
+	RET=0
+
+	local occ=$(port_range_occ_get)
+
+	# Two port range registers are used, for source and destination port
+	# ranges.
+	tc filter add dev $swp1 ingress pref 1 handle 101 proto ip \
+		flower skip_sw ip_proto udp src_port 1-100 dst_port 1-100 \
+		action pass
+	(( occ + 2 == $(port_range_occ_get) ))
+	check_err $? "Got occupancy $(port_range_occ_get), expected $((occ + 2))"
+
+	tc filter add dev $swp1 ingress pref 1 handle 102 proto ip \
+		flower skip_sw ip_proto tcp src_port 1-100 dst_port 1-100 \
+		action pass
+	tc filter add dev $swp1 ingress pref 2 handle 103 proto ipv6 \
+		flower skip_sw ip_proto udp src_port 1-100 dst_port 1-100 \
+		action pass
+	tc filter add dev $swp1 ingress pref 2 handle 104 proto ipv6 \
+		flower skip_sw ip_proto tcp src_port 1-100 dst_port 1-100 \
+		action pass
+	(( occ + 2 == $(port_range_occ_get) ))
+	check_err $? "Got occupancy $(port_range_occ_get), expected $((occ + 2))"
+
+	tc filter del dev $swp1 ingress pref 2 handle 104 flower
+	tc filter del dev $swp1 ingress pref 2 handle 103 flower
+	tc filter del dev $swp1 ingress pref 1 handle 102 flower
+	(( occ + 2 == $(port_range_occ_get) ))
+	check_err $? "Got occupancy $(port_range_occ_get), expected $((occ + 2))"
+
+	tc filter del dev $swp1 ingress pref 1 handle 101 flower
+	(( occ == $(port_range_occ_get) ))
+	check_err $? "Got occupancy $(port_range_occ_get), expected $occ"
+
+	log_test "port range occupancy"
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


