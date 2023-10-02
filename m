Return-Path: <netdev+bounces-37457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EAB7B56DE
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2FAD41C208B5
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358341D682;
	Mon,  2 Oct 2023 15:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B11CFBD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:45:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869FCA4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMINuaTRs3gQOdGvGQRZYdvylGGkPyIGsc89rbx9KOHBlkP+bqB+iWNMdedO3RL3LHVU99ZWkchM3FUrueYRxXGmJ0QUe68evqmxB1+H76HELujxfcm3oBBSWJamY5B5qegnhsvo169/J2XpAAUz6ivpWj91fQyPi8Gg2NzrICsfp9Q9zx3C8reukXEvbLvhjJeTbWg3VEBdSasGkbNkIjejqfSdETB9/2N4YWWAl1y+qiv3tdky5hETToad9zIehoRpGYbDLC465xId8ZXnitfSSiP1L3ZehDRKWTkZR0dupds6GwloTXH78ZjMJ6spQ+g4wEAZ+hJ3gdRKLAftZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7x30oJI0NJiYFR+W4yJGDCsh2jpNDnb8disCj7RED4=;
 b=Wq2WKWLG4BfKL5ZnpqT2c4ZA6i3R49P89uR6EcCLYsaM/R693qsQmzili2dUQHrn9e8M6dwbMStxuibq07DsNzJeG6PECZtgXZ5UPfxDdXjGkiz2UNQLp4kr+60wbygHHBO6pBGt+HD0Vxn7qWnxfalI0ExEEf+3UrHrb9FqOZIoqmTyzhtRgUITull8eYTf1hsVdLhcF80vMEeXPK/twUDcJbebXElmz2FhsjPSGb6BcNGW10VbmDlJ3R0tULe3lwtdMkN569lR+EZLEAsy78xZeHVZar4uqlwkNPgD7bgZ4CykeyZ0QhxIzH3oNnoj8vL4J0szRslpVVFkgL4jFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7x30oJI0NJiYFR+W4yJGDCsh2jpNDnb8disCj7RED4=;
 b=15TLsxdkVYBL4F3aL37YO7ekDHrJymK9WgSGPBji2+eFvIrceW9wR+WDYDvgClqtOOTh/LmZ5B00mfMudUj6EYPbfj0o7x2jBlYelpUL3JWsYRdeI4KuevYhAIk0qMRHAZEobSoI7R+mApFcTsG2ySwJ5e0n56M8WBmBJvht4vQ=
Received: from CYZPR05CA0013.namprd05.prod.outlook.com (2603:10b6:930:89::11)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 15:45:49 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::6b) by CYZPR05CA0013.outlook.office365.com
 (2603:10b6:930:89::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.23 via Frontend
 Transport; Mon, 2 Oct 2023 15:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 15:45:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:48 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 10:45:47 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 4/4] sfc: support TC rules which require OR-AR-CT-AR flow
Date: Mon, 2 Oct 2023 16:44:44 +0100
Message-ID: <bced5f5537636f5da4c48da446d0607de0f6aebb.1696261222.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1696261222.git.ecree.xilinx@gmail.com>
References: <cover.1696261222.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2c937b-ed3e-4971-4e16-08dbc35ea692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1vTPHTCu5XMmU5wUoEm63FuwPwgt2eyV1gT8snF6P6XzS4FqGz/hldK4qd3XcBFxfhykCRz+Un01b7FlViQTLkPMTWfR7UHWT16/Tj0zC2S2DfV/k4Z7va/aKOjN48HTAjuogGgfeEQWEpX0LBRmf2ur7tc5CfNgPl6AGr3in85he79kv1MwLOFvYsYywgDhbp+705O5IX47vy8zRnA+mOLiSkkOU9riF54jOaXuSkXmYr+OOYAatSO25/e5GbftC+wNk0TLP5OKmU4CKk+X4VCCL3U9ZK6rtG+It+esud0MbAV0Z1x0meegABhlZMmPiShvUhCbxWZ7FPeUc6wdlmgX7T76hzRLamzTMHWGIJGCE+ZUWOyWdwHKaGkouGgz/kwDO3s0EyqV/baPMEeVIpOt5fsqlIVzYj2TBIcqbHhcNshzmKKOFnIRs3gYnSNE0jDOy+wsXwaFqRHvJ2sd1uLHFaAKGl6BpEGGeewWoI5ahleXQtog/a4p+NtEakzEZ1UDMNda90pIpZ5BkfaoOF4JCPoe5twzOf816+Fuqba0UqLZhYJA5XWUTW1gBRAritCQ33gN38ySwIusIQySwngQxS4LRhHEMYP7TQINAhi3bWK9YdXMcQTnA0qq3QvIkHld3NOTBz9NZOL2/aZCw97MPF5SabdME11xVy8aKzzm39WIgzJ2Prdg7RlSE3Z83gmZR3bBgTtyzd9x4mcxcmZ+GSZzBEOGrlKSwm0MaR/rSn7v6pDte1rGv7Zqq79FMLsNsnNX0aeiNXCeefk7HXUM2baB6n7MR7sWvAhA4zg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40460700003)(336012)(426003)(5660300002)(2876002)(2906002)(6666004)(86362001)(356005)(55446002)(9686003)(478600001)(81166007)(36756003)(40480700001)(82740400003)(8676002)(26005)(4326008)(36860700001)(316002)(47076005)(110136005)(70586007)(8936002)(70206006)(54906003)(83380400001)(41300700001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:45:49.0911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2c937b-ed3e-4971-4e16-08dbc35ea692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

When a foreign LHS rule (TC rule from a tunnel netdev which requests
 conntrack lookup) matches on inner headers or enc_key_id, these matches
 cannot be performed by the Outer Rule table, as the keys are only
 available after the tunnel type has been identified (by the OR lookup)
 and the rest of the headers parsed accordingly.
Offload such rules with an Action Rule, using the LOOKUP_CONTROL section
 of the AR response to specify the conntrack and/or recirculation actions,
 combined with an Outer Rule which performs only the usual Encap Match
 duties.
This processing flow, as it requires two AR lookups per packet, is less
 performant than OR-CT-AR, so only use it where necessary.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mae.c |  53 +++++++++++++++
 drivers/net/ethernet/sfc/tc.c  | 116 +++++++++++++++++++++++++++++++--
 drivers/net/ethernet/sfc/tc.h  |   1 +
 3 files changed, 165 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index d1c8872efac9..021980a958b7 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1736,9 +1736,60 @@ static int efx_mae_insert_lhs_outer_rule(struct efx_nic *efx,
 	return 0;
 }
 
+static int efx_mae_populate_match_criteria(MCDI_DECLARE_STRUCT_PTR(match_crit),
+					   const struct efx_tc_match *match);
+
+static int efx_mae_insert_lhs_action_rule(struct efx_nic *efx,
+					  struct efx_tc_lhs_rule *rule,
+					  u32 prio)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_MAE_ACTION_RULE_INSERT_IN_LEN(MAE_FIELD_MASK_VALUE_PAIRS_V2_LEN));
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_ACTION_RULE_INSERT_OUT_LEN);
+	struct efx_tc_lhs_action *act = &rule->lhs_act;
+	MCDI_DECLARE_STRUCT_PTR(match_crit);
+	MCDI_DECLARE_STRUCT_PTR(response);
+	size_t outlen;
+	int rc;
+
+	match_crit = _MCDI_DWORD(inbuf, MAE_ACTION_RULE_INSERT_IN_MATCH_CRITERIA);
+	response = _MCDI_DWORD(inbuf, MAE_ACTION_RULE_INSERT_IN_RESPONSE);
+	MCDI_STRUCT_SET_DWORD(response, MAE_ACTION_RULE_RESPONSE_ASL_ID,
+			      MC_CMD_MAE_ACTION_SET_LIST_ALLOC_OUT_ACTION_SET_LIST_ID_NULL);
+	MCDI_STRUCT_SET_DWORD(response, MAE_ACTION_RULE_RESPONSE_AS_ID,
+			      MC_CMD_MAE_ACTION_SET_ALLOC_OUT_ACTION_SET_ID_NULL);
+	EFX_POPULATE_DWORD_5(*_MCDI_STRUCT_DWORD(response, MAE_ACTION_RULE_RESPONSE_LOOKUP_CONTROL),
+			     MAE_ACTION_RULE_RESPONSE_DO_CT, !!act->zone,
+			     MAE_ACTION_RULE_RESPONSE_DO_RECIRC,
+			     act->rid && !act->zone,
+			     MAE_ACTION_RULE_RESPONSE_CT_VNI_MODE,
+			     MAE_CT_VNI_MODE_ZERO,
+			     MAE_ACTION_RULE_RESPONSE_RECIRC_ID,
+			     act->rid ? act->rid->fw_id : 0,
+			     MAE_ACTION_RULE_RESPONSE_CT_DOMAIN,
+			     act->zone ? act->zone->zone : 0);
+	MCDI_STRUCT_SET_DWORD(response, MAE_ACTION_RULE_RESPONSE_COUNTER_ID,
+			      act->count ? act->count->cnt->fw_id :
+			      MC_CMD_MAE_COUNTER_ALLOC_OUT_COUNTER_ID_NULL);
+	MCDI_SET_DWORD(inbuf, MAE_ACTION_RULE_INSERT_IN_PRIO, prio);
+	rc = efx_mae_populate_match_criteria(match_crit, &rule->match);
+	if (rc)
+		return rc;
+
+	rc = efx_mcdi_rpc(efx, MC_CMD_MAE_ACTION_RULE_INSERT, inbuf, sizeof(inbuf),
+			  outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		return rc;
+	if (outlen < sizeof(outbuf))
+		return -EIO;
+	rule->fw_id = MCDI_DWORD(outbuf, MAE_ACTION_RULE_INSERT_OUT_AR_ID);
+	return 0;
+}
+
 int efx_mae_insert_lhs_rule(struct efx_nic *efx, struct efx_tc_lhs_rule *rule,
 			    u32 prio)
 {
+	if (rule->is_ar)
+		return efx_mae_insert_lhs_action_rule(efx, rule, prio);
 	return efx_mae_insert_lhs_outer_rule(efx, rule, prio);
 }
 
@@ -1772,6 +1823,8 @@ static int efx_mae_remove_lhs_outer_rule(struct efx_nic *efx,
 
 int efx_mae_remove_lhs_rule(struct efx_nic *efx, struct efx_tc_lhs_rule *rule)
 {
+	if (rule->is_ar)
+		return efx_mae_delete_rule(efx, rule->fw_id);
 	return efx_mae_remove_lhs_outer_rule(efx, rule);
 }
 
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 6acd30f2db1e..3d76b7598631 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -978,9 +978,12 @@ static int efx_tc_flower_handle_lhs_actions(struct efx_nic *efx,
 	struct netlink_ext_ack *extack = tc->common.extack;
 	struct efx_tc_lhs_action *act = &rule->lhs_act;
 	const struct flow_action_entry *fa;
+	enum efx_tc_counter_type ctype;
 	bool pipe = true;
 	int i;
 
+	ctype = rule->is_ar ? EFX_TC_COUNTER_TYPE_AR : EFX_TC_COUNTER_TYPE_OR;
+
 	flow_action_for_each(i, fa, &fr->action) {
 		struct efx_tc_ct_zone *ct_zone;
 		struct efx_tc_recirc_id *rid;
@@ -1013,7 +1016,7 @@ static int efx_tc_flower_handle_lhs_actions(struct efx_nic *efx,
 					return -EOPNOTSUPP;
 				}
 				cnt = efx_tc_flower_get_counter_index(efx, tc->cookie,
-								      EFX_TC_COUNTER_TYPE_OR);
+								      ctype);
 				if (IS_ERR(cnt)) {
 					NL_SET_ERR_MSG_MOD(extack, "Failed to obtain a counter");
 					return PTR_ERR(cnt);
@@ -1450,6 +1453,110 @@ static int efx_tc_incomplete_mangle(struct efx_tc_mangler_state *mung,
 	return 0;
 }
 
+static int efx_tc_flower_replace_foreign_lhs_ar(struct efx_nic *efx,
+						struct flow_cls_offload *tc,
+						struct flow_rule *fr,
+						struct efx_tc_match *match,
+						struct net_device *net_dev)
+{
+	struct netlink_ext_ack *extack = tc->common.extack;
+	struct efx_tc_lhs_rule *rule, *old;
+	enum efx_encap_type type;
+	int rc;
+
+	type = efx_tc_indr_netdev_type(net_dev);
+	if (type == EFX_ENCAP_TYPE_NONE) {
+		NL_SET_ERR_MSG_MOD(extack, "Egress encap match on unsupported tunnel device");
+		return -EOPNOTSUPP;
+	}
+
+	rc = efx_mae_check_encap_type_supported(efx, type);
+	if (rc) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Firmware reports no support for %s encap match",
+				       efx_tc_encap_type_name(type));
+		return rc;
+	}
+	/* This is an Action Rule, so it needs a separate Encap Match in the
+	 * Outer Rule table.  Insert that now.
+	 */
+	rc = efx_tc_flower_record_encap_match(efx, match, type,
+					      EFX_TC_EM_DIRECT, 0, 0, extack);
+	if (rc)
+		return rc;
+
+	match->mask.recirc_id = 0xff;
+	if (match->mask.ct_state_trk && match->value.ct_state_trk) {
+		NL_SET_ERR_MSG_MOD(extack, "LHS rule can never match +trk");
+		rc = -EOPNOTSUPP;
+		goto release_encap_match;
+	}
+	/* LHS rules are always -trk, so we don't need to match on that */
+	match->mask.ct_state_trk = 0;
+	match->value.ct_state_trk = 0;
+	/* We must inhibit match on TCP SYN/FIN/RST, so that SW can see
+	 * the packet and update the conntrack table.
+	 * Outer Rules will do that with CT_TCP_FLAGS_INHIBIT, but Action
+	 * Rules don't have that; instead they support matching on
+	 * TCP_SYN_FIN_RST (aka TCP_INTERESTING_FLAGS), so use that.
+	 * This is only strictly needed if there will be a DO_CT action,
+	 * which we don't know yet, but typically there will be and it's
+	 * simpler not to bother checking here.
+	 */
+	match->mask.tcp_syn_fin_rst = true;
+
+	rc = efx_mae_match_check_caps(efx, &match->mask, extack);
+	if (rc)
+		goto release_encap_match;
+
+	rule = kzalloc(sizeof(*rule), GFP_USER);
+	if (!rule) {
+		rc = -ENOMEM;
+		goto release_encap_match;
+	}
+	rule->cookie = tc->cookie;
+	rule->is_ar = true;
+	old = rhashtable_lookup_get_insert_fast(&efx->tc->lhs_rule_ht,
+						&rule->linkage,
+						efx_tc_lhs_rule_ht_params);
+	if (old) {
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Already offloaded rule (cookie %lx)\n", tc->cookie);
+		rc = -EEXIST;
+		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
+		goto release;
+	}
+
+	/* Parse actions */
+	rc = efx_tc_flower_handle_lhs_actions(efx, tc, fr, net_dev, rule);
+	if (rc)
+		goto release;
+
+	rule->match = *match;
+	rule->lhs_act.tun_type = type;
+
+	rc = efx_mae_insert_lhs_rule(efx, rule, EFX_TC_PRIO_TC);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to insert rule in hw");
+		goto release;
+	}
+	netif_dbg(efx, drv, efx->net_dev,
+		  "Successfully parsed lhs rule (cookie %lx)\n",
+		  tc->cookie);
+	return 0;
+
+release:
+	efx_tc_flower_release_lhs_actions(efx, &rule->lhs_act);
+	if (!old)
+		rhashtable_remove_fast(&efx->tc->lhs_rule_ht, &rule->linkage,
+				       efx_tc_lhs_rule_ht_params);
+	kfree(rule);
+release_encap_match:
+	if (match->encap)
+		efx_tc_flower_release_encap_match(efx, match->encap);
+	return rc;
+}
+
 static int efx_tc_flower_replace_foreign_lhs(struct efx_nic *efx,
 					     struct flow_cls_offload *tc,
 					     struct flow_rule *fr,
@@ -1472,10 +1579,9 @@ static int efx_tc_flower_replace_foreign_lhs(struct efx_nic *efx,
 		return -EOPNOTSUPP;
 	}
 
-	if (efx_tc_flower_flhs_needs_ar(match)) {
-		NL_SET_ERR_MSG_MOD(extack, "Match keys not available in Outer Rule");
-		return -EOPNOTSUPP;
-	}
+	if (efx_tc_flower_flhs_needs_ar(match))
+		return efx_tc_flower_replace_foreign_lhs_ar(efx, tc, fr, match,
+							    net_dev);
 
 	type = efx_tc_indr_netdev_type(net_dev);
 	if (type == EFX_ENCAP_TYPE_NONE) {
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index c4cb52dda057..86e38ea7988c 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -208,6 +208,7 @@ struct efx_tc_lhs_rule {
 	struct efx_tc_lhs_action lhs_act;
 	struct rhash_head linkage;
 	u32 fw_id;
+	bool is_ar; /* Action Rule (for OR-AR-CT-AR sequence) */
 };
 
 enum efx_tc_rule_prios {

