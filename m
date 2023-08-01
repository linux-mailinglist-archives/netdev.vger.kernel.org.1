Return-Path: <netdev+bounces-23315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DA76B886
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACD31C20F73
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3F4DC98;
	Tue,  1 Aug 2023 15:22:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E824DC64
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:22:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E32107
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7anYLVsV0FGD5glVjjkgp1DZEp2mbTodpmVQemF92G6Km5p9ldep9y4JZPd5urFzBlSPtEXXF0ieo1Pv7+Fcjt/m94XyyoCC0N4fda7V0+eBpUClz1ImUj7gcyZ8j/lcwoP8m+tdGHfIVREt7BiPHATTSVVQd5011K8IiDMIJXfsuDdnjN6aU9qKAQc0coFTQ1i/S6z9vQmGuBsv0sXPrHEQWe7YnXLj1Q+KfjC8dsYk9Z/zFmQ1fpOH+e0aGEEN7wTjwC5QN12Vy58ppAWUMHYaO6gJSZflkD4BTh3wGRtbz8w+hRv3Pcph8GusjOyz6CZUpXEBKbLD3HbbpQ0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++SYJPOcVbp6YRpKksiCNzANE9gc4+zmM5wr3aRsA90=;
 b=BwB+JH3KRku4ss5+yZ7NqpV4xrqkHw1fnOj/mVbUQ2o6aSnt1d3KfhP4MjW6Sm1+svY8PLFMTbiUk3lZLbMXO503mQeNqhqBdx+dpxbDgPWrqtXm86q8rMdwz0su71ZTZleIehrfMwInrFr+t3IJtpnaPn7HUAm08MoHuv4CYNglz4bFEIQ58R5pIXmKQDsuMAZ669tWRrvvg+AOB9rVr+7BHOuGBM/I3JTr9+KGrNMSH2SCb8r7Ml+kJKCtrhiGJQbOXVdMl2/SEmIro8pGTStqRb9OU0ELWTFCLyU3mLJBT686DYBVPvx1tWVW2+PHmvQT++tpwjwCoBSnxfYHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++SYJPOcVbp6YRpKksiCNzANE9gc4+zmM5wr3aRsA90=;
 b=EYzr1i1uxDYJYNDPnbOhPKVZL6xAelA9o8CU2NBQpnbfna2WbjgBLRfcj54Uf3XdJNfuAJ+9EMvD84Q0M1n2oRqDkSZsdVljMhp2LPls5g2aMKveQUlBSxulUaE0Y61Q+dpuC76AXi7QKXB7pC3QvBES67W6Dqjddo1/xoBFO2AYEe/S3RFd/jjJhtvvOoK3J5RdJJ2bF+xGyx+f/QSunydKfZHce9fpWf1KyPGC1qNNPN2cX3WCEMyVE839/2E3o5bkoF3h7tsOxdfX167azkwc0lVfJGz8qWq5+FJkVXzHLSjPf80oZOlkg82csmJm73oKcatOYt4Ljtfrshc4fw==
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 15:22:23 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::52) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 15:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45 via Frontend Transport; Tue, 1 Aug 2023 15:22:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 08:22:10 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 1 Aug 2023 08:22:08 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next] bridge: Add backup nexthop ID support
Date: Tue, 1 Aug 2023 18:21:38 +0300
Message-ID: <20230801152138.132719-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|PH0PR12MB5466:EE_
X-MS-Office365-Filtering-Correlation-Id: 116deff3-068c-4d70-0e1a-08db92a31aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FozfG9XALWmoytEn4GaZgFDNXL6mjauw/rY1gW+chnTGJkX+VdhWP4Su+WlIjuA0ukli9uJ/hgA4ujPt8PryrmOeJF3Moacl6WNcjYNTFxCdHodbnmUfzH2Dip/kKW3hxZMIuH/f0cfUDcr6st8yjrdC9Pf2n8/7qM9bgvEIw1tLX0sqFMfSNpjsPrXQ/hfxW6f6w03qtv3ay4GXERdND2RGgnP8A2sjEy/oxJNxv+55u6K0UCTXixQe6+Hnbp5bPGUpDtjQdd7TgdqQjPnYPfT9GlYA3dAv8u2UGr6v5k3yrZ474h/wwFve/+JAVo4lQ6IwHdZwuPt6M2WPFJf6nx+IoVpzUwW9mSuq1cAzmhSOv5yzze0XdEC03hao1zDUlxyij452zaUCCC1ZzvpkRnOPhfEJR8d23MmSYbZY37zYWgZQk8+I49TH1Ojwdm9u9f2hPvbOkiE34TjVuaBM0eaaKz9RvMHimclY8CLOklMcm0Mar/hZblnNqGSQ+uo3Z3Fa8ZC/dd1dqe65Dp1+s9StvvIcviyurV8jJDYFqaOM6R4KrooFAraVN3GVS6r9w1hbvHizw1gFJ2YRJARt3pcR+2huQkQfHMQLkxTmrqyEEkkAxuXrMeLw8JCf6+MugdFXesUh6Hl7v5k3Zd2LaMB2Jm4RPQA/YPiuDa8DFHb8L1E0euBD2NQOzZ3RoRgN3KURJ3wLD5HB9y/o1EzXfhRdqi0g2i3BclY0zO5nLfLXb1r4yvq+/2coKjkMQSBV
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(356005)(7636003)(40460700003)(36756003)(36860700001)(83380400001)(40480700001)(70206006)(70586007)(316002)(4326008)(6916009)(8936002)(8676002)(107886003)(41300700001)(16526019)(186003)(1076003)(26005)(336012)(5660300002)(54906003)(478600001)(6666004)(82740400003)(2906002)(426003)(47076005)(2616005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:22:22.6796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 116deff3-068c-4d70-0e1a-08db92a31aaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend the bridge and ip utilities to set and show the backup nexthop ID
bridge port attribute. A value of 0 (default) disables the feature, in
which case the attribute is not printed since it is not emitted by the
kernel.

Example:

 # bridge -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
 # bridge -d -j -p link show dev swp1 | jq '.[]["backup_nhid"]'
 null

 # bridge link set dev swp1 backup_nhid 10
 # bridge -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
 backup_nhid 10
 # bridge -d -j -p link show dev swp1 | jq '.[]["backup_nhid"]'
 10

 # bridge link set dev swp1 backup_nhid 0
 # bridge -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
 # bridge -d -j -p link show dev swp1 | jq '.[]["backup_nhid"]'
 null

 # ip -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
 # ip -d -j -p lin show dev swp1 | jq '.[]["linkinfo"]["info_slave_data"]["backup_nhid"]'
 null

 # ip link set dev swp1 type bridge_slave backup_nhid 10
 # ip -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
 backup_nhid 10
 # ip -d -j -p lin show dev swp1 | jq '.[]["linkinfo"]["info_slave_data"]["backup_nhid"]'
 10

 # ip link set dev swp1 type bridge_slave backup_nhid 0
 # ip -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
 # ip -d -j -p lin show dev swp1 | jq '.[]["linkinfo"]["info_slave_data"]["backup_nhid"]'
 null

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 bridge/link.c            | 14 ++++++++++++++
 ip/iplink_bridge_slave.c | 13 +++++++++++++
 man/man8/bridge.8        |  9 +++++++++
 man/man8/ip-link.8.in    | 11 ++++++++++-
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/bridge/link.c b/bridge/link.c
index b35429866f52..c7ee5e760c08 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -186,6 +186,10 @@ static void print_protinfo(FILE *fp, struct rtattr *attr)
 				     ll_index_to_name(ifidx));
 		}
 
+		if (prtb[IFLA_BRPORT_BACKUP_NHID])
+			print_uint(PRINT_ANY, "backup_nhid", "backup_nhid %u ",
+				   rta_getattr_u32(prtb[IFLA_BRPORT_BACKUP_NHID]));
+
 		if (prtb[IFLA_BRPORT_ISOLATED])
 			print_on_off(PRINT_ANY, "isolated", "isolated %s ",
 				     rta_getattr_u8(prtb[IFLA_BRPORT_ISOLATED]));
@@ -311,6 +315,7 @@ static void usage(void)
 		"                               [ mab {on | off} ]\n"
 		"                               [ hwmode {vepa | veb} ]\n"
 		"                               [ backup_port DEVICE ] [ nobackup_port ]\n"
+		"                               [ backup_nhid NHID ]\n"
 		"                               [ self ] [ master ]\n"
 		"       bridge link show [dev DEV]\n");
 	exit(-1);
@@ -330,6 +335,7 @@ static int brlink_modify(int argc, char **argv)
 	};
 	char *d = NULL;
 	int backup_port_idx = -1;
+	__s32 backup_nhid = -1;
 	__s8 neigh_suppress = -1;
 	__s8 neigh_vlan_suppress = -1;
 	__s8 learning = -1;
@@ -493,6 +499,10 @@ static int brlink_modify(int argc, char **argv)
 			}
 		} else if (strcmp(*argv, "nobackup_port") == 0) {
 			backup_port_idx = 0;
+		} else if (strcmp(*argv, "backup_nhid") == 0) {
+			NEXT_ARG();
+			if (get_s32(&backup_nhid, *argv, 0))
+				invarg("invalid backup_nhid", *argv);
 		} else {
 			usage();
 		}
@@ -579,6 +589,10 @@ static int brlink_modify(int argc, char **argv)
 		addattr32(&req.n, sizeof(req), IFLA_BRPORT_BACKUP_PORT,
 			  backup_port_idx);
 
+	if (backup_nhid != -1)
+		addattr32(&req.n, sizeof(req), IFLA_BRPORT_BACKUP_NHID,
+			  backup_nhid);
+
 	addattr_nest_end(&req.n, nest);
 
 	/* IFLA_AF_SPEC nested attribute. Contains IFLA_BRIDGE_FLAGS that
diff --git a/ip/iplink_bridge_slave.c b/ip/iplink_bridge_slave.c
index 11ab2113fe96..dc73c86574da 100644
--- a/ip/iplink_bridge_slave.c
+++ b/ip/iplink_bridge_slave.c
@@ -43,6 +43,7 @@ static void print_explain(FILE *f)
 		"			[ locked {on | off} ]\n"
 		"			[ mab {on | off} ]\n"
 		"			[ backup_port DEVICE ] [ nobackup_port ]\n"
+		"			[ backup_nhid NHID ]\n"
 	);
 }
 
@@ -301,6 +302,10 @@ static void bridge_slave_print_opt(struct link_util *lu, FILE *f,
 		print_string(PRINT_ANY, "backup_port", "backup_port %s ",
 			     ll_index_to_name(backup_p));
 	}
+
+	if (tb[IFLA_BRPORT_BACKUP_NHID])
+		print_uint(PRINT_ANY, "backup_nhid", "backup_nhid %u ",
+			   rta_getattr_u32(tb[IFLA_BRPORT_BACKUP_NHID]));
 }
 
 static void bridge_slave_parse_on_off(char *arg_name, char *arg_val,
@@ -436,6 +441,14 @@ static int bridge_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 			addattr32(n, 1024, IFLA_BRPORT_BACKUP_PORT, ifindex);
 		} else if (matches(*argv, "nobackup_port") == 0) {
 			addattr32(n, 1024, IFLA_BRPORT_BACKUP_PORT, 0);
+		} else if (strcmp(*argv, "backup_nhid") == 0) {
+			__u32 backup_nhid;
+
+			NEXT_ARG();
+			if (get_u32(&backup_nhid, *argv, 0))
+				invarg("backup_nhid is invalid", *argv);
+			addattr32(n, 1024, IFLA_BRPORT_BACKUP_NHID,
+				  backup_nhid);
 		} else if (matches(*argv, "help") == 0) {
 			explain();
 			return -1;
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index e05528199eab..dd0659d37df2 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -61,6 +61,8 @@ bridge \- show / manipulate bridge addresses and devices
 .B backup_port
 .IR  DEVICE " ] ["
 .BR nobackup_port " ] [ "
+.B backup_nhid
+.IR NHID " ] ["
 .BR self " ] [ " master " ]"
 
 .ti -8
@@ -647,6 +649,13 @@ configured backup port
 .B nobackup_port
 Removes the currently configured backup port
 
+.TP
+.BI backup_nhid " NHID"
+The FDB nexthop object ID (see \fBip-nexthop\fR(8)) to attach to packets being
+redirected to a backup port that has VLAN tunnel mapping enabled (via the
+\fBvlan_tunnel\fR option). Setting a value of 0 (default) has the effect of not
+attaching any ID.
+
 .TP
 .B self
 link setting is configured on specified physical device
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 6a82ddc45adf..128c855f82be 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2539,7 +2539,10 @@ the following additional arguments are supported:
 ] [
 .BR backup_port " DEVICE"
 ] [
-.BR nobackup_port " ]"
+.BR nobackup_port
+] [
+.BR backup_nhid " NHID"
+]
 
 .in +8
 .sp
@@ -2678,6 +2681,12 @@ configured backup port
 .BR nobackup_port
 - removes the currently configured backup port
 
+.BI backup_nhid " NHID"
+- the FDB nexthop object ID (see \fBip-nexthop\fR(8)) to attach to packets
+being redirected to a backup port that has VLAN tunnel mapping enabled (via the
+\fBvlan_tunnel\fR option). Setting a value of 0 (default) has the effect of not
+attaching any ID.
+
 .in -8
 
 .TP
-- 
2.40.1


