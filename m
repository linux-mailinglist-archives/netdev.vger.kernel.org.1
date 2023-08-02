Return-Path: <netdev+bounces-23709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981C76D3E4
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900A9281E3F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F117D30B;
	Wed,  2 Aug 2023 16:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348879FF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 16:42:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8EA213D
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2I8DpHcs1EHelgLG+CPzDSmcWOyeL1Fw/uKhjfodxWDHDS4QK6Bl25wqnzmWcubCz1o3jk+I1cM9hhec7Fxbmyn04uT9x/BHd16qhL63LN2aMRw8SLnS7M0K/f+iv92bV3uytfREu7uF/d8YwdhulEjFoCDSIqbwJCbJy7yXmtxDjI3b6FFHRhsP5XkhYU0WDBwiM9vVjF4XjtWR4s4RIzmcxcNhmxFWvW25qCrmQBPjNlHeUstxPvTIfy3wyERhoBYt6NNROdvmxERM+NEsvXWPGRdWICwZqNahvfJN4Xg1DLWKlR0WeZ0xQ5I3luU6N4b9okd0PjklLH5+Xt1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1Xq2xQl5yx4XWpLX201RC3CdEnNGd5ku5lnDpzDjBg=;
 b=BQLa2yiHV7qyGe0TSRAGOh9sOfTVdBlcGRDbDV8O7k11Wd59cw9S42m42VNCHzJdphZHSJWXnua6rqa56Lwkvl4OA41BjnhBCLceGwQJvm3YWF1TRtcdjvXmkt555K2iObC/CGel7kcZ9UkQ96V7VF5xrzo5vv4p1UfOIwKGTCg0Q1aTKD07G6xOixPWQEqbYYJ8SqilhgpbpGDmvBNSCAMtksdvXkpKDZ/UP62jU+k6xFCN+pS6YwtlCO3a3Iodxs7XM6tUD7mIlbmD5lTTqL50OkYM0vMQlEs4u+BUmvtGA25RfxRkXvIwIx+0YPwfTky41g55WgviocSHzQ6kQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1Xq2xQl5yx4XWpLX201RC3CdEnNGd5ku5lnDpzDjBg=;
 b=uR6ZM/Ssf8zKxMTNCH8FYhhpRmaZOEQHgRsNL2EthDE1Ib91eMOetHnZx/ddOXCxYUl6GJPgRSbA7Ka+tvJOkQLfkY7HQ2xrv2b1bKYf8sdVwvXl71shYIfMf0yd7Cwv8Rt3XAYkq9u2AebpGMIqOUJ9kyjeTbZfTeJe88+B9Cu9+wCfTncNalZu0sbTkktwdQ93oj5Z1fXSCVtb1DxZcyE1dfozwyjNs/0gztpXocW/IwpkNHg1g7/YXCzk1vDMOwk6jL1KVrf3fmWLhY52jl6WMj+cI6Q77T6sw7VesicpUBbgOhaQq9eTNvveLCzXmUq32KaNawFaLEdi3V1EzQ==
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 16:42:10 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::e5) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 16:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45 via Frontend Transport; Wed, 2 Aug 2023 16:42:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 09:41:55 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 09:41:53 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <petrm@nvidia.com>,
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2] bridge: Add backup nexthop ID support
Date: Wed, 2 Aug 2023 19:41:15 +0300
Message-ID: <20230802164115.866222-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 181ca48e-9792-4c65-9961-08db937769ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Fl7AWm5AtJQdEs6Y0uxyJlMXgvHjTK7KhCrW60ov51+ri7w+Q2HqdEyl3CWfBpfQlUZ84yS4m+qpPGjy/J8Y/oEeMgoeKrqGPhBk754jARMiT2wYPOZhq4VnTTr7G+i39JTai7qO/scHSE4q97VjPi4aqv79QQVTpn3WdNIc/WfD289VC1YTY3wwyCmIYVW3NNLImDh6h+G75MEsEJPSsTqEuaTUyN4jhlWSCrb9+9Qoa11cM5N+WiV3sDXW2w+f0ExMwsm/G3w436NMFzvsg0cmT9SO+2Uw2ulBP1QS9OPtwNjzwGqqrEYSHYBzbBB9z1LqDZf2SE6kIE8k3LSSW6ZzgckEyRfpLAmFxM1BCTKzabNfGZ5dHtFR4fXMjqoaTCHLoqT8zjUtQbbgOSF2rALBnDTbV2NrhHaO3i9TtAIakWpPaJsucSLi3TpIlYrL+VrfbgJbC1g3UyCqHMc2bMPY6SuY0UWF71zGEwVfFDT20uXL5c32Sjrs0IHUJOD1v+ZY6DqU+HJQGLNHk9ll+X4ltApWgJyc2q7qkDYvk31EP/WImoeTuTR7u2mtagbSLJQLC4ESo7xOD8sGV/isXjascl/dkaD4rIQSKX/VO+YeyUFT8FKizTBY3dchaBwFKVZDCBRNZiah+qEQJqueEr4WDOfM9dw584trPM8xq9keHrr/t/zacNp03LwGmKv2CX5nYlVl7VElVe7UE+T0X/HuAfAhlzlCCUpECQJ9SSV4bdBBl2fWeAEPlGya4Un
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(6916009)(4326008)(40460700003)(70206006)(70586007)(2906002)(426003)(7636003)(336012)(186003)(82740400003)(356005)(16526019)(2616005)(26005)(1076003)(83380400001)(47076005)(36860700001)(54906003)(86362001)(40480700001)(107886003)(478600001)(36756003)(6666004)(41300700001)(8676002)(8936002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 16:42:08.9624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181ca48e-9792-4c65-9961-08db937769ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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
v2:
* Use __u32 instead of __s32 for backup nexthop ID
---
 bridge/link.c            | 16 ++++++++++++++++
 ip/iplink_bridge_slave.c | 13 +++++++++++++
 man/man8/bridge.8        |  9 +++++++++
 man/man8/ip-link.8.in    | 11 ++++++++++-
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/bridge/link.c b/bridge/link.c
index af0457b6e04d..1c8faa85e7a5 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -187,6 +187,10 @@ static void print_protinfo(FILE *fp, struct rtattr *attr)
 				     ll_index_to_name(ifidx));
 		}
 
+		if (prtb[IFLA_BRPORT_BACKUP_NHID])
+			print_uint(PRINT_ANY, "backup_nhid", "backup_nhid %u ",
+				   rta_getattr_u32(prtb[IFLA_BRPORT_BACKUP_NHID]));
+
 		if (prtb[IFLA_BRPORT_ISOLATED])
 			print_on_off(PRINT_ANY, "isolated", "isolated %s ",
 				     rta_getattr_u8(prtb[IFLA_BRPORT_ISOLATED]));
@@ -316,6 +320,7 @@ static void usage(void)
 		"                               [ mab {on | off} ]\n"
 		"                               [ hwmode {vepa | veb} ]\n"
 		"                               [ backup_port DEVICE ] [ nobackup_port ]\n"
+		"                               [ backup_nhid NHID ]\n"
 		"                               [ self ] [ master ]\n"
 		"       bridge link show [dev DEV] [master DEVICE]\n");
 	exit(-1);
@@ -334,6 +339,8 @@ static int brlink_modify(int argc, char **argv)
 		.ifm.ifi_family = PF_BRIDGE,
 	};
 	char *d = NULL;
+	bool backup_nhid_set = false;
+	__u32 backup_nhid;
 	int backup_port_idx = -1;
 	__s8 neigh_suppress = -1;
 	__s8 neigh_vlan_suppress = -1;
@@ -498,6 +505,11 @@ static int brlink_modify(int argc, char **argv)
 			}
 		} else if (strcmp(*argv, "nobackup_port") == 0) {
 			backup_port_idx = 0;
+		} else if (strcmp(*argv, "backup_nhid") == 0) {
+			NEXT_ARG();
+			if (get_u32(&backup_nhid, *argv, 0))
+				invarg("invalid backup_nhid", *argv);
+			backup_nhid_set = true;
 		} else {
 			usage();
 		}
@@ -584,6 +596,10 @@ static int brlink_modify(int argc, char **argv)
 		addattr32(&req.n, sizeof(req), IFLA_BRPORT_BACKUP_PORT,
 			  backup_port_idx);
 
+	if (backup_nhid_set)
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
index 8f07de9a8a25..7365d0c6b14f 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2540,7 +2540,10 @@ the following additional arguments are supported:
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
@@ -2679,6 +2682,12 @@ configured backup port
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


