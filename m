Return-Path: <netdev+bounces-16903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661574F602
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984571C2102E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B531DDD0;
	Tue, 11 Jul 2023 16:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863F1E506
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DE91BC7
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkQwGEfP1pONsUNkm/nHQgXxCtYFRWTV3fhkoZq+k8BlccePx7gHBqokEDUSEsWCxZWe6AIWu6lXePeCDKvnGl97uIfStdgL8Zo+UqVymZN0Caigt++O5Immbxy5UTcBGqRVNv6cfRz7VbftITnAKrRcUoz6AU5I6FNBB5C6kkMLFqmKNI2ctRmBpfacueMKmDGw8CuWOr/hOC2dykqwBjsGXJiMrhYdzkvAekTbyaKMYugxt4VDmuVdle+QRdZ+3hsQpU+MIbceB2mq5OLO5LTVDvVAkXk8s0QsQnODeN5OsBooLxxrRI946bUo7zbhC/k5q5BkouejwdFPqenHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g9e+jdzJEbtWWt8kfPt4b9B+BmvnPaTIq89ShRGOT8=;
 b=koQD75WrFKBjWhPiCSguXqFLaKnRfnD1qpKD4C0Gf4HK11rzLzn/p30APdc+4C3LycDOWy+RZeJTgD7IWOtkstE+CZfSuP+4K6rTnvUMOcsn9JRA5hdDwiaIlb+btiPXKTF7xjryZDdO3mKj3g0dkDnoiIwUpe3MNkxQPoQP9FWJzl/zM+i2oug4r8Y2WSp1DAG6Ru6f6MecoXehjZ1z4lpBzFrlBo6FKWecOpbj5Ff0PLNqY4hkTorHm99pEHrEL2lKezvwyV8nIDX0bh4NOQN4ksKGvlyrFcrS6iNNEKSQfxlObL3d0y/MgGsBspkqRA8CQc/C3zFhrBsEbNz3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g9e+jdzJEbtWWt8kfPt4b9B+BmvnPaTIq89ShRGOT8=;
 b=D/zDZCVesw3OTnTSOBNc+T9TX8ab7PeasQPeLBRilAhNnkFzY+D1yEfyPohfiWWILeDqz9aYbvkqGnFtiUIwguOTOm1OQQAwmCa6MlqwLRVL5eshqy5aRbNe6AZkjlaz+kfzB0tLl7439tLJ1hkvh9Dkls51qp+y0nQV5tiT9A/5U1iA7N/1WQdaNNol6sQaHSIbJtO1qIsh+iJP5ZGBDJhX+yr4NcHlxyHNpZ7AbVPm3nzVLYX+Q5t6lpiSzjnDlnyd2TTBOgzT3OGNZZwkQU4fCwuEoXsmjZsSwRAUSYttygKqYPvQQBOVQ3xOV6B9/ow+Dq3e0KRFTPmj3+TS6w==
Received: from DS7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:8:54::10) by
 PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 16:44:56 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::2d) by DS7PR06CA0041.outlook.office365.com
 (2603:10b6:8:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:45 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 08/10] selftests: mlxsw: Add scale test for port ranges
Date: Tue, 11 Jul 2023 18:44:01 +0200
Message-ID: <48eee181270d9f291e09d1858c7b26a3f7fcc164.1689092769.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f29906-d4c6-49c8-600f-08db822e28bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NRQ01FmPmZDyEirq02gKsP9iLu9pztVKxyYliC6q3ZSmmtXb4bAYB8szE/brJ+7Wzfet6rbK4ZJjEh0tzrC1RDOQ08DL1J+CDyvcpZtV2ujP9E+nuDxBUsoEUz9rvFGJgIz0m2rT93GxZiaif6mXJR2jmXk2V5cLPKNTZPhpEXbpDyBMFBlfqo+BMfdPD9Mva5QUnmk9j6VlNCBazzIfwUZbgIsnPjpd2nq4UWui0d7oUFfnsqa45dinWOE79+zp2plIUUEfgTb3Z0oH0FyQW2JFrrRTFmNlsUrsocL3/ugLDmgR9yXrnC21EmjJQnPvOqQ/fMSU2vnm4/jmIH/zpW2poyqgOOwdMZJ7sfrK91pJP1qoUxyC7QlosuiFfP2eboFtuVD0WRxE7Od1HmmC8I+e6EpELSJ+D9VYGYhMlOwezerZLvyTWbM/PwQeM+RlIWS/Z2SuUG1/FkHbKxPi83ZOw+oc89jd1v22qoHDjlmZ1Fhpy1O/bjlixgaZ9GaT2o53B3f6d5gok6U8dtKVKXoYBPE0+rrSmAeiVW/EiyxnDTDFdaRy8XL7rV3Ww5CyAXw1hvaPB5S4beN948z+usmqqDYSoTcT2z13ZF6tLO69aqU1Z51gs0s49uVnLD3e4NlCORdLkJtEC8NAnrPuEdtoWMusJ438yiagzXuJVFSRdrRmLRLZEHBiHMHrPwZU7FMd9rTKW8GWdvpe13HkOepf59aQf3n7A5bnrxBzmwifnL9CXbDhcISIoYgLaji3
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(54906003)(6666004)(70206006)(110136005)(70586007)(7636003)(356005)(107886003)(26005)(186003)(2616005)(336012)(5660300002)(2906002)(316002)(8936002)(16526019)(8676002)(426003)(83380400001)(4326008)(478600001)(36860700001)(41300700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:56.4969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f29906-d4c6-49c8-600f-08db822e28bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Query the maximum number of supported port range registers using
devlink-resource and test that this number can be reached by configuring
tc filters with different port ranges. Test that an error is returned in
case the maximum number is exceeded.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/port_range_scale.sh     | 95 +++++++++++++++++++
 .../net/mlxsw/spectrum-2/port_range_scale.sh  |  1 +
 .../net/mlxsw/spectrum-2/resource_scale.sh    |  1 +
 .../net/mlxsw/spectrum/port_range_scale.sh    | 16 ++++
 .../net/mlxsw/spectrum/resource_scale.sh      |  1 +
 5 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/mlxsw/port_range_scale.sh
 create mode 120000 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/port_range_scale.sh
 create mode 100644 tools/testing/selftests/drivers/net/mlxsw/spectrum/port_range_scale.sh

diff --git a/tools/testing/selftests/drivers/net/mlxsw/port_range_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/port_range_scale.sh
new file mode 100644
index 000000000000..2a70840ff14b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/port_range_scale.sh
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0
+
+PORT_RANGE_NUM_NETIFS=2
+
+port_range_h1_create()
+{
+	simple_if_init $h1
+}
+
+port_range_h1_destroy()
+{
+	simple_if_fini $h1
+}
+
+port_range_switch_create()
+{
+	simple_if_init $swp1
+	tc qdisc add dev $swp1 clsact
+}
+
+port_range_switch_destroy()
+{
+	tc qdisc del dev $swp1 clsact
+	simple_if_fini $swp1
+}
+
+port_range_rules_create()
+{
+	local count=$1; shift
+	local should_fail=$1; shift
+	local batch_file="$(mktemp)"
+
+	for ((i = 0; i < count; ++i)); do
+		cat >> $batch_file <<-EOF
+			filter add dev $swp1 ingress \
+				prot ipv4 \
+				pref 1000 \
+				flower skip_sw \
+				ip_proto udp dst_port 1-$((100 + i)) \
+				action pass
+		EOF
+	done
+
+	tc -b $batch_file
+	check_err_fail $should_fail $? "Rule insertion"
+
+	rm -f $batch_file
+}
+
+__port_range_test()
+{
+	local count=$1; shift
+	local should_fail=$1; shift
+
+	port_range_rules_create $count $should_fail
+
+	offload_count=$(tc -j filter show dev $swp1 ingress |
+			jq "[.[] | select(.options.in_hw == true)] | length")
+	((offload_count == count))
+	check_err_fail $should_fail $? "port range offload count"
+}
+
+port_range_test()
+{
+	local count=$1; shift
+	local should_fail=$1; shift
+
+	if ! tc_offload_check $PORT_RANGE_NUM_NETIFS; then
+		check_err 1 "Could not test offloaded functionality"
+		return
+	fi
+
+	__port_range_test $count $should_fail
+}
+
+port_range_setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	vrf_prepare
+
+	port_range_h1_create
+	port_range_switch_create
+}
+
+port_range_cleanup()
+{
+	pre_cleanup
+
+	port_range_switch_destroy
+	port_range_h1_destroy
+
+	vrf_cleanup
+}
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/port_range_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/port_range_scale.sh
new file mode 120000
index 000000000000..bd670d9dc4e5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/port_range_scale.sh
@@ -0,0 +1 @@
+../spectrum/port_range_scale.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
index 688338bbeb97..a88d8a8c85f2 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
@@ -33,6 +33,7 @@ ALL_TESTS="
 	port
 	rif_mac_profile
 	rif_counter
+	port_range
 "
 
 for current_test in ${TESTS:-$ALL_TESTS}; do
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum/port_range_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum/port_range_scale.sh
new file mode 100644
index 000000000000..d0847e8ea270
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum/port_range_scale.sh
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+source ../port_range_scale.sh
+
+port_range_get_target()
+{
+	local should_fail=$1; shift
+	local target
+
+	target=$(devlink_resource_size_get port_range_registers)
+
+	if ((! should_fail)); then
+		echo $target
+	else
+		echo $((target + 1))
+	fi
+}
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
index 95d9f710a630..f981c957f097 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
@@ -30,6 +30,7 @@ ALL_TESTS="
 	port
 	rif_mac_profile
 	rif_counter
+	port_range
 "
 
 for current_test in ${TESTS:-$ALL_TESTS}; do
-- 
2.40.1


