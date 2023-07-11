Return-Path: <netdev+bounces-16899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39474F5FE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92941C20FDF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2481DDCA;
	Tue, 11 Jul 2023 16:45:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701B1DDC2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89EB10F9
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzI5Jc3G1rq98/OouFvPnrEgH7iIcKGc9Z4IGmK36V7MqzziD7CogDQ5BmRZ/sODYL5uNprv18ZwOIRCdpTgTf32Ooy03isvOEfnyaPle6+AAU29JreNzPdE9SrxmEtmN++QR7+OzVCYidb7/WuN5Pd6KAJyMz/c7gTpJMy05c1GBFBwRwYUeDCjUjReLHaE9DEXgp6MqKj4phxpglrVGiOVdGp6/kxssTDs+iFlJ3yAUqM7lBIcGLTLTUyCNRsTvN1+TstM7pJH3h301NnIPgHT6BUdZ563mXOQyyCx30W71Eo5othREgzF8aoM5qz1ANGJgOYgsD1btyULQ/dKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVhNYDqdv+n1eoNBnowyHW+DjpaOiiR6Y9i+jGVrU+Q=;
 b=XNA1chaS86t806eJ7bKFYYSroIkBNzC7AJnoKVgkf+yyGLGSkVzYxZ2QpcOSRtylk08O7NWOUqGTkOAPzYZX79GwLRvsAhdazi8SGwtlQ4NaZ0iIFF0gtsSLwHhrVXoI9KeKKRTtSssIr1UgQc0Kmy57qpqP++H9TCENOBs+es5kGjg3J2O56BK9AfUcnutVLkbgiq/iSpvbuG8YYrmWIl7PbRhYN9w6EJJG6bGXnFa1ObZxOy6zhHMd2GU5+pQ5eQqSN1EKQhoLmXwUI53soL1zbKIDJJtX8bDkCy/8hbYfLCFmuEvnKTvczw/9+KilDfik/T5mOkyzJ+oiU2UQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVhNYDqdv+n1eoNBnowyHW+DjpaOiiR6Y9i+jGVrU+Q=;
 b=hhNoOPfebygyKLFVW43XiCef2HaBuof8RZgn6b243Vwn4dd/AeBy9qMDf+n53+fwUnQm9uNOFMjvEdPQNQNHGy7Vloju+QxNNjFEhgcn49A6cr+8Aj1UGtOIwBGafJSfu/mLOsOzZlncBlf8rbPgUGGnireTvn70GNb16N3h7y2KjRxt4skPxr6sKj52OeCwJ6WNWzAkm47aIaoVcvdW9l7/ptpyGlN9r4RcN1ms7zglZjlav4SgKuZki5S0y+L8IXCxQGkFsAk5tuPk4XRR+3jf0Nv3ps9is2ZjPS5bDtNW5BTZdLx4EKeEMyU/KluK0CRVU89BDGkhGMh7KXmnGw==
Received: from MW4PR04CA0045.namprd04.prod.outlook.com (2603:10b6:303:6a::20)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 16:44:49 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::ab) by MW4PR04CA0045.outlook.office365.com
 (2603:10b6:303:6a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:42 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 07/10] mlxsw: spectrum_flower: Add ability to match on port ranges
Date: Tue, 11 Jul 2023 18:44:00 +0200
Message-ID: <df4385a9592917e9a22ebff339e0463e4a8dfa82.1689092769.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 098c371a-b054-4835-bfb7-08db822e247b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ccyWLSzc1Ew/tgHcKd8UU/TaOx4EO6tHiEdkP+roAv2ezod2NppnM2Wn59VXV10+gUGU7O3tIYRR3tK/TuQA8HIPHCJEVWO9xYbMVAf3guISTdv+jb0ibzfLI/0h2ucK+tlrJYYod0ZqBE4KuSN6+WDnVU+ZpSHj0Rw2TpmQ13XrS3sl8Jb2TVAf9VubDMWOWodFem3ni3LsIJaoOTc4V20/+cjh1F6Ux31hzlz8TOEpgRmE6iHAEOMnTToGnM7D40N1WEgu32oItvJZD5CGGcN6NBpbI/W8eCKFz9RbDQvFIAaW6FAwwFYhyUqKJQRPQReDNGTlpMpGemVkbasOdFiiHpNWcYXah3Ntax5MPjeECJOWPXDWG5vnUSA8ohvgteOwEYa/86Z2sMzGnrSR2OTte6iI5zp5bmbL+lOl1tMdJjK0bSpz/1IgoxS8IgWHHGOxNyaO9BSgsfCNvPc9D054EiunsRjDWfm5203DFp/vNsuyMTLyOiROwFJljhLkkJJotwyrGekWpmy1I+3hCzeoh0pucRFijskTYUBZJZeooCvrik2FjftOPahKOSJgybZcGDGnOXphptNcbu9eO/izM6LfP+Rh6ZB3hFjw5T5u1MOQrOKLkSlKwLI+Ese69FgQejfvQKMhIAUuptbPBMQebaUM28AO+YFrQUSLMHm4VY+UBvYNPKb47sEBArLmyNRCyqfC+2/Ee3pAnP1qBlSmmJKKLbIOZqa6H98qm+7Kl+H6LSuugrXqr9EpJ9pZcf/nNKKGXAMvP58nP5kVLw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(316002)(70586007)(70206006)(41300700001)(8936002)(2906002)(4326008)(6666004)(8676002)(54906003)(47076005)(26005)(107886003)(83380400001)(16526019)(186003)(2616005)(426003)(336012)(36860700001)(110136005)(40460700003)(478600001)(82740400003)(7636003)(356005)(36756003)(82310400005)(86362001)(40480700001)(461764006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:49.4315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098c371a-b054-4835-bfb7-08db822e247b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Add the ability to match on port ranges by utilizing the previously
added port range registers and the port range key element. Up to two
port range registers can be used for each filter, one for source port
and another for destination port.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  6 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl.c    |  6 ++
 .../ethernet/mellanox/mlxsw/spectrum_flower.c | 68 +++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 4a1bf2d39fa0..c6231e62a371 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -867,9 +867,13 @@ struct mlxsw_sp_acl_rule_info {
 	   egress_bind_blocker:1,
 	   counter_valid:1,
 	   policer_index_valid:1,
-	   ipv6_valid:1;
+	   ipv6_valid:1,
+	   src_port_range_reg_valid:1,
+	   dst_port_range_reg_valid:1;
 	unsigned int counter_index;
 	u16 policer_index;
+	u8 src_port_range_reg_index;
+	u8 dst_port_range_reg_index;
 	struct {
 		u32 prev_val;
 		enum mlxsw_sp_acl_mangle_field prev_field;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index 7240b74b4883..186161a3459d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -344,6 +344,12 @@ void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
 {
 	if (rulei->action_created)
 		mlxsw_afa_block_destroy(rulei->act_block);
+	if (rulei->src_port_range_reg_valid)
+		mlxsw_sp_port_range_reg_put(mlxsw_sp,
+					    rulei->src_port_range_reg_index);
+	if (rulei->dst_port_range_reg_valid)
+		mlxsw_sp_port_range_reg_put(mlxsw_sp,
+					    rulei->dst_port_range_reg_index);
 	kfree(rulei);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 72917f09e806..8329100479b3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -418,6 +418,68 @@ static int mlxsw_sp_flower_parse_ports(struct mlxsw_sp *mlxsw_sp,
 	return 0;
 }
 
+static int
+mlxsw_sp_flower_parse_ports_range(struct mlxsw_sp *mlxsw_sp,
+				  struct mlxsw_sp_acl_rule_info *rulei,
+				  struct flow_cls_offload *f, u8 ip_proto)
+{
+	const struct flow_rule *rule = flow_cls_offload_flow_rule(f);
+	struct flow_match_ports_range match;
+	u32 key_mask_value = 0;
+
+	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE))
+		return 0;
+
+	if (ip_proto != IPPROTO_TCP && ip_proto != IPPROTO_UDP) {
+		NL_SET_ERR_MSG_MOD(f->common.extack, "Only UDP and TCP keys are supported");
+		return -EINVAL;
+	}
+
+	flow_rule_match_ports_range(rule, &match);
+
+	if (match.mask->tp_min.src) {
+		struct mlxsw_sp_port_range range = {
+			.min = ntohs(match.key->tp_min.src),
+			.max = ntohs(match.key->tp_max.src),
+			.source = true,
+		};
+		u8 prr_index;
+		int err;
+
+		err = mlxsw_sp_port_range_reg_get(mlxsw_sp, &range,
+						  f->common.extack, &prr_index);
+		if (err)
+			return err;
+
+		rulei->src_port_range_reg_index = prr_index;
+		rulei->src_port_range_reg_valid = true;
+		key_mask_value |= BIT(prr_index);
+	}
+
+	if (match.mask->tp_min.dst) {
+		struct mlxsw_sp_port_range range = {
+			.min = ntohs(match.key->tp_min.dst),
+			.max = ntohs(match.key->tp_max.dst),
+		};
+		u8 prr_index;
+		int err;
+
+		err = mlxsw_sp_port_range_reg_get(mlxsw_sp, &range,
+						  f->common.extack, &prr_index);
+		if (err)
+			return err;
+
+		rulei->dst_port_range_reg_index = prr_index;
+		rulei->dst_port_range_reg_valid = true;
+		key_mask_value |= BIT(prr_index);
+	}
+
+	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_L4_PORT_RANGE,
+				       key_mask_value, key_mask_value);
+
+	return 0;
+}
+
 static int mlxsw_sp_flower_parse_tcp(struct mlxsw_sp *mlxsw_sp,
 				     struct mlxsw_sp_acl_rule_info *rulei,
 				     struct flow_cls_offload *f,
@@ -503,6 +565,7 @@ static int mlxsw_sp_flower_parse(struct mlxsw_sp *mlxsw_sp,
 	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
 	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
 	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
 	      BIT(FLOW_DISSECTOR_KEY_TCP) |
 	      BIT(FLOW_DISSECTOR_KEY_IP) |
 	      BIT(FLOW_DISSECTOR_KEY_VLAN))) {
@@ -604,6 +667,11 @@ static int mlxsw_sp_flower_parse(struct mlxsw_sp *mlxsw_sp,
 	err = mlxsw_sp_flower_parse_ports(mlxsw_sp, rulei, f, ip_proto);
 	if (err)
 		return err;
+
+	err = mlxsw_sp_flower_parse_ports_range(mlxsw_sp, rulei, f, ip_proto);
+	if (err)
+		return err;
+
 	err = mlxsw_sp_flower_parse_tcp(mlxsw_sp, rulei, f, ip_proto);
 	if (err)
 		return err;
-- 
2.40.1


