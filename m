Return-Path: <netdev+bounces-24982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6C772694
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C821C20BC6
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7011196;
	Mon,  7 Aug 2023 13:49:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92411C8D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:49:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C52819BA
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzr2Pp5MxyEFjzQqeRMtfaZQ1dQ2Xat68cOfN6/zuMOG55uQaHW2jnZKwghCzwpvrJPTEGaCzauolns7AptxDd2OeIf1lfqVDXvv7VaZZmdiHF8z7/9xEahQ0le8kNpDJGbsiNlLLIejft7A0u/sJcXVJAVrSGKcLcmHZ2+iFRw3EG5PZT8vUBwTbRlIcPPvEaEiJ+qEI6B93UOUOsWW1pHcW6iaUnWYbDeMFWP9XDawYUMY0kvpT6gQ6JryxKvzU/rnKuf53tfz82Q8SXAAQWe3nFFIz9+LpO+eMfTqo88XDolqbWxVwu60wBCyFbUj3XpGzd12K66DfexprT7rsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia02nXZp1sk/NbeDBe5ihV9VyGPXi/wfMPJ7ZM1DvwI=;
 b=lq8eqDJKyrdKHBzKyfy/x0D0TS597+7TbEVeU+bMO5Bnhx4bfvnVD2RuzsoZfv9aYkObIj5SPJjQdWdMAJeujV+dRwS+sMJZ5LMxdXmau96NyqAmldJgghoikymJNiJ4GHsWuwF9n+xAfyD1Igh/Kles3jnO04qjtvISekux0ERo6fzqLIcGuVtZh1y05k/Keu7W4eZP6SCrRSGkiSOiiwutI13TFNpr3ts5SkjEf+1laKAGiKEYpamVf9sQU+g0cTSmlVTGN3KQMQs+Nzkb9Nk5ZjrTLlmqAiDVEdkbA7/ATglJ1n1z6IuSjyDfF/DTshfirHHUHeub0Xl0+0liyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia02nXZp1sk/NbeDBe5ihV9VyGPXi/wfMPJ7ZM1DvwI=;
 b=v0a7VWKXIoDD7H8I0GAr2WRL/JYMYFbtCacH61LSlXysgXVVwtJ95j/0bp6YzgYKLaA6YDcarpahRqAGDPZD8sthj5/x62bBL6cQh72/iwiodNS7+BpMxikSq5FVCmvowHPug63NWuFRKWxAGnn984VS2pcZTY4GyqLkMs3Wyrs=
Received: from SJ0PR05CA0121.namprd05.prod.outlook.com (2603:10b6:a03:33d::6)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Mon, 7 Aug
 2023 13:49:25 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c8) by SJ0PR05CA0121.outlook.office365.com
 (2603:10b6:a03:33d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Mon, 7 Aug 2023 13:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 13:49:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:49:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:49:19 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 08:49:18 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 5/7] sfc: handle non-zero chain_index on TC rules
Date: Mon, 7 Aug 2023 14:48:09 +0100
Message-ID: <67666793a7db914023421e309553e0161821f7c7.1691415479.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1691415479.git.ecree.xilinx@gmail.com>
References: <cover.1691415479.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: e2051dd7-1de0-458f-07d4-08db974d1c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fobuF+fyNgCdoofz2ZeNGTiZCGKLp6QNdUEW1wdLw++/Kad3RGViMYA1ri9rv50j3rUuV/Hcr3eoFQmJLMnBgzdcUsvelbGgpQscu1EbBNu95gxGucmbF5ZUte81Zh4v+sl6lbn6O7r5dGv5BFccX/V6BrXSZeP2o5QCcfLIQ2efpXX3uSlSVTC3g40U9tpJ8w+55V2ZZC567mleOuBqnXo7g7wP061s5e79tVUHXVyef/4zkZ5gCW3ZNgrCyf2EQgLGI6d7H3v+0eev8WSCmDh7388sHqH3Qfhq/6vN070ZpZ5J80Ibsuz30eVNbwBcbvbByINGetUePz/u8Y+1Ap2UnpiuG0S7AKKHv3MmO5EL+zF2w2vcU/+c7Ug3os7HuQGQwto7tGVq8jlcZm3hqI/Ui+iPclIOu7HtpgjDeFQCjNgjm1RjHBuTfGE1kr5JgQ6KAdwoHdonOTvu53FOFFhQtIIYi3gMplmpdyXqXTld5f8yKNG5Ce8A0Iyeoo95DpRF1wMAWiaw01RcrjL48/uKzb+250kr6H/F5+RanEa4jdCWzaWgXM9bte3kINc1SeQpiP+F8MKEh47dds9la3849LDFQYANRGp5QyNUZYVD28sszptR+usAiMhiuCmvFpToWTQ08+inaoXeFNx68fM7/ztsqqjFjpBW4sqVvNG8FQJwOYZfoA8EP38h8f9rWimRB27m3JOhxbW006WZdPIw47A+f1n+ATILI1X8mLpgPgFjb0zsDop5KjEhuf3qjdwo9Gfex6MQ8X0nHut8BA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(186006)(1800799003)(82310400008)(40470700004)(46966006)(36840700001)(40480700001)(336012)(40460700003)(36756003)(4326008)(9686003)(316002)(86362001)(55446002)(82740400003)(110136005)(356005)(54906003)(70586007)(6666004)(70206006)(478600001)(81166007)(41300700001)(26005)(426003)(8676002)(8936002)(47076005)(36860700001)(2876002)(2906002)(30864003)(83380400001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 13:49:24.9037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2051dd7-1de0-458f-07d4-08db974d1c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Map it to an 8-bit recirc_id for use by the hardware.
Currently nothing in the driver is offloading 'goto chain' actions,
 so these rules cannot yet be hit.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc.c           | 169 ++++++++++++++++++++----
 drivers/net/ethernet/sfc/tc.h           |  15 ++-
 drivers/net/ethernet/sfc/tc_conntrack.c |   9 ++
 drivers/net/ethernet/sfc/tc_conntrack.h |   3 +-
 4 files changed, 170 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 44a6fc30b722..181636d07024 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -97,6 +97,12 @@ static const struct rhashtable_params efx_tc_match_action_ht_params = {
 	.head_offset	= offsetof(struct efx_tc_flow_rule, linkage),
 };
 
+static const struct rhashtable_params efx_tc_recirc_ht_params = {
+	.key_len	= offsetof(struct efx_tc_recirc_id, linkage),
+	.key_offset	= 0,
+	.head_offset	= offsetof(struct efx_tc_recirc_id, linkage),
+};
+
 static void efx_tc_free_action_set(struct efx_nic *efx,
 				   struct efx_tc_action_set *act, bool in_hw)
 {
@@ -576,12 +582,65 @@ static int efx_tc_flower_record_encap_match(struct efx_nic *efx,
 	return rc;
 }
 
+static struct efx_tc_recirc_id *efx_tc_get_recirc_id(struct efx_nic *efx,
+						     u32 chain_index,
+						     struct net_device *net_dev)
+{
+	struct efx_tc_recirc_id *rid, *old;
+	int rc;
+
+	rid = kzalloc(sizeof(*rid), GFP_USER);
+	if (!rid)
+		return ERR_PTR(-ENOMEM);
+	rid->chain_index = chain_index;
+	/* We don't take a reference here, because it's implied - if there's
+	 * a rule on the net_dev that's been offloaded to us, then the net_dev
+	 * can't go away until the rule has been deoffloaded.
+	 */
+	rid->net_dev = net_dev;
+	old = rhashtable_lookup_get_insert_fast(&efx->tc->recirc_ht,
+						&rid->linkage,
+						efx_tc_recirc_ht_params);
+	if (old) {
+		/* don't need our new entry */
+		kfree(rid);
+		if (!refcount_inc_not_zero(&old->ref))
+			return ERR_PTR(-EAGAIN);
+		/* existing entry found */
+		rid = old;
+	} else {
+		rc = ida_alloc_range(&efx->tc->recirc_ida, 1, U8_MAX, GFP_USER);
+		if (rc < 0) {
+			rhashtable_remove_fast(&efx->tc->recirc_ht,
+					       &rid->linkage,
+					       efx_tc_recirc_ht_params);
+			kfree(rid);
+			return ERR_PTR(rc);
+		}
+		rid->fw_id = rc;
+		refcount_set(&rid->ref, 1);
+	}
+	return rid;
+}
+
+static void efx_tc_put_recirc_id(struct efx_nic *efx, struct efx_tc_recirc_id *rid)
+{
+	if (!refcount_dec_and_test(&rid->ref))
+		return; /* still in use */
+	rhashtable_remove_fast(&efx->tc->recirc_ht, &rid->linkage,
+			       efx_tc_recirc_ht_params);
+	ida_free(&efx->tc->recirc_ida, rid->fw_id);
+	kfree(rid);
+}
+
 static void efx_tc_delete_rule(struct efx_nic *efx, struct efx_tc_flow_rule *rule)
 {
 	efx_mae_delete_rule(efx, rule->fw_id);
 
 	/* Release entries in subsidiary tables */
 	efx_tc_free_action_set_list(efx, &rule->acts, true);
+	if (rule->match.rid)
+		efx_tc_put_recirc_id(efx, rule->match.rid);
 	if (rule->match.encap)
 		efx_tc_flower_release_encap_match(efx, rule->match.encap);
 	rule->fw_id = MC_CMD_MAE_ACTION_RULE_INSERT_OUT_ACTION_RULE_ID_NULL;
@@ -685,8 +744,17 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	match.mask.ingress_port = ~0;
 
 	if (tc->common.chain_index) {
-		NL_SET_ERR_MSG_MOD(extack, "No support for nonzero chain_index");
-		return -EOPNOTSUPP;
+		struct efx_tc_recirc_id *rid;
+
+		rid = efx_tc_get_recirc_id(efx, tc->common.chain_index, net_dev);
+		if (IS_ERR(rid)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Failed to allocate a hardware recirculation ID for chain_index %u",
+					       tc->common.chain_index);
+			return PTR_ERR(rid);
+		}
+		match.rid = rid;
+		match.value.recirc_id = rid->fw_id;
 	}
 	match.mask.recirc_id = 0xff;
 
@@ -706,12 +774,13 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	if (!found) { /* We don't care. */
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Ignoring foreign filter that doesn't egdev us\n");
-		return -EOPNOTSUPP;
+		rc = -EOPNOTSUPP;
+		goto release;
 	}
 
 	rc = efx_mae_match_check_caps(efx, &match.mask, NULL);
 	if (rc)
-		return rc;
+		goto release;
 
 	if (efx_tc_match_is_encap(&match.mask)) {
 		enum efx_encap_type type;
@@ -720,7 +789,8 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 		if (type == EFX_ENCAP_TYPE_NONE) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Egress encap match on unsupported tunnel device");
-			return -EOPNOTSUPP;
+			rc = -EOPNOTSUPP;
+			goto release;
 		}
 
 		rc = efx_mae_check_encap_type_supported(efx, type);
@@ -728,25 +798,26 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 			NL_SET_ERR_MSG_FMT_MOD(extack,
 					       "Firmware reports no support for %s encap match",
 					       efx_tc_encap_type_name(type));
-			return rc;
+			goto release;
 		}
 
 		rc = efx_tc_flower_record_encap_match(efx, &match, type,
 						      EFX_TC_EM_DIRECT, 0, 0,
 						      extack);
 		if (rc)
-			return rc;
+			goto release;
 	} else {
 		/* This is not a tunnel decap rule, ignore it */
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Ignoring foreign filter without encap match\n");
-		return -EOPNOTSUPP;
+		rc = -EOPNOTSUPP;
+		goto release;
 	}
 
 	rule = kzalloc(sizeof(*rule), GFP_USER);
 	if (!rule) {
 		rc = -ENOMEM;
-		goto out_free;
+		goto release;
 	}
 	INIT_LIST_HEAD(&rule->acts.list);
 	rule->cookie = tc->cookie;
@@ -758,7 +829,7 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 			  "Ignoring already-offloaded rule (cookie %lx)\n",
 			  tc->cookie);
 		rc = -EEXIST;
-		goto out_free;
+		goto release;
 	}
 
 	act = kzalloc(sizeof(*act), GFP_USER);
@@ -916,15 +987,17 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	/* We failed to insert the rule, so free up any entries we created in
 	 * subsidiary tables.
 	 */
+	if (match.rid)
+		efx_tc_put_recirc_id(efx, match.rid);
 	if (act)
 		efx_tc_free_action_set(efx, act, false);
 	if (rule) {
-		rhashtable_remove_fast(&efx->tc->match_action_ht,
-				       &rule->linkage,
-				       efx_tc_match_action_ht_params);
+		if (!old)
+			rhashtable_remove_fast(&efx->tc->match_action_ht,
+					       &rule->linkage,
+					       efx_tc_match_action_ht_params);
 		efx_tc_free_action_set_list(efx, &rule->acts, false);
 	}
-out_free:
 	kfree(rule);
 	if (match.encap)
 		efx_tc_flower_release_encap_match(efx, match.encap);
@@ -986,19 +1059,45 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 		return -EOPNOTSUPP;
 	}
 
+	/* chain_index 0 is always recirc_id 0 (and does not appear in recirc_ht).
+	 * Conveniently, match.rid == NULL and match.value.recirc_id == 0 owing
+	 * to the initial memset(), so we don't need to do anything in that case.
+	 */
 	if (tc->common.chain_index) {
-		NL_SET_ERR_MSG_MOD(extack, "No support for nonzero chain_index");
-		return -EOPNOTSUPP;
+		struct efx_tc_recirc_id *rid;
+
+		/* Note regarding passed net_dev:
+		 * VFreps and PF can share chain namespace, as they have
+		 * distinct ingress_mports.  So we don't need to burn an
+		 * extra recirc_id if both use the same chain_index.
+		 * (Strictly speaking, we could give each VFrep its own
+		 * recirc_id namespace that doesn't take IDs away from the
+		 * PF, but that would require a bunch of additional IDAs -
+		 * one for each representor - and that's not likely to be
+		 * the main cause of recirc_id exhaustion anyway.)
+		 */
+		rid = efx_tc_get_recirc_id(efx, tc->common.chain_index,
+					   efx->net_dev);
+		if (IS_ERR(rid)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Failed to allocate a hardware recirculation ID for chain_index %u",
+					       tc->common.chain_index);
+			return PTR_ERR(rid);
+		}
+		match.rid = rid;
+		match.value.recirc_id = rid->fw_id;
 	}
 	match.mask.recirc_id = 0xff;
 
 	rc = efx_mae_match_check_caps(efx, &match.mask, extack);
 	if (rc)
-		return rc;
+		goto release;
 
 	rule = kzalloc(sizeof(*rule), GFP_USER);
-	if (!rule)
-		return -ENOMEM;
+	if (!rule) {
+		rc = -ENOMEM;
+		goto release;
+	}
 	INIT_LIST_HEAD(&rule->acts.list);
 	rule->cookie = tc->cookie;
 	old = rhashtable_lookup_get_insert_fast(&efx->tc->match_action_ht,
@@ -1008,8 +1107,8 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Already offloaded rule (cookie %lx)\n", tc->cookie);
 		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
-		kfree(rule);
-		return -EEXIST;
+		rc = -EEXIST;
+		goto release;
 	}
 
 	/* Parse actions */
@@ -1327,12 +1426,15 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 	/* We failed to insert the rule, so free up any entries we created in
 	 * subsidiary tables.
 	 */
+	if (match.rid)
+		efx_tc_put_recirc_id(efx, match.rid);
 	if (act)
 		efx_tc_free_action_set(efx, act, false);
 	if (rule) {
-		rhashtable_remove_fast(&efx->tc->match_action_ht,
-				       &rule->linkage,
-				       efx_tc_match_action_ht_params);
+		if (!old)
+			rhashtable_remove_fast(&efx->tc->match_action_ht,
+					       &rule->linkage,
+					       efx_tc_match_action_ht_params);
 		efx_tc_free_action_set_list(efx, &rule->acts, false);
 	}
 	kfree(rule);
@@ -1702,6 +1804,16 @@ static void efx_tc_encap_match_free(void *ptr, void *__unused)
 	kfree(encap);
 }
 
+static void efx_tc_recirc_free(void *ptr, void *arg)
+{
+	struct efx_tc_recirc_id *rid = ptr;
+	struct efx_nic *efx = arg;
+
+	WARN_ON(refcount_read(&rid->ref));
+	ida_free(&efx->tc->recirc_ida, rid->fw_id);
+	kfree(rid);
+}
+
 static void efx_tc_flow_free(void *ptr, void *arg)
 {
 	struct efx_tc_flow_rule *rule = ptr;
@@ -1751,6 +1863,10 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	rc = efx_tc_init_conntrack(efx);
 	if (rc < 0)
 		goto fail_conntrack;
+	rc = rhashtable_init(&efx->tc->recirc_ht, &efx_tc_recirc_ht_params);
+	if (rc < 0)
+		goto fail_recirc_ht;
+	ida_init(&efx->tc->recirc_ida);
 	efx->tc->reps_filter_uc = -1;
 	efx->tc->reps_filter_mc = -1;
 	INIT_LIST_HEAD(&efx->tc->dflt.pf.acts.list);
@@ -1763,6 +1879,8 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	efx->tc->facts.reps.fw_id = MC_CMD_MAE_ACTION_SET_ALLOC_OUT_ACTION_SET_ID_NULL;
 	efx->extra_channel_type[EFX_EXTRA_CHANNEL_TC] = &efx_tc_channel_type;
 	return 0;
+fail_recirc_ht:
+	efx_tc_destroy_conntrack(efx);
 fail_conntrack:
 	rhashtable_destroy(&efx->tc->match_action_ht);
 fail_match_action_ht:
@@ -1799,6 +1917,9 @@ void efx_fini_struct_tc(struct efx_nic *efx)
 	rhashtable_free_and_destroy(&efx->tc->encap_match_ht,
 				    efx_tc_encap_match_free, NULL);
 	efx_tc_fini_conntrack(efx);
+	rhashtable_free_and_destroy(&efx->tc->recirc_ht, efx_tc_recirc_free, efx);
+	WARN_ON(!ida_is_empty(&efx->tc->recirc_ida));
+	ida_destroy(&efx->tc->recirc_ida);
 	efx_tc_fini_counters(efx);
 	efx_tc_fini_encap_actions(efx);
 	mutex_unlock(&efx->tc->mutex);
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 2aba9ca00618..af15020c8da7 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -45,7 +45,7 @@ struct efx_tc_action_set {
 struct efx_tc_match_fields {
 	/* L1 */
 	u32 ingress_port;
-	u8 recirc_id;
+	u8 recirc_id; /* mapped from (u32) TC chain_index to smaller space */
 	/* L2 (inner when encap) */
 	__be16 eth_proto;
 	__be16 vlan_tci[2], vlan_proto[2];
@@ -115,10 +115,19 @@ struct efx_tc_encap_match {
 	struct efx_tc_encap_match *pseudo; /* Referenced pseudo EM if needed */
 };
 
+struct efx_tc_recirc_id {
+	u32 chain_index;
+	struct net_device *net_dev;
+	struct rhash_head linkage;
+	refcount_t ref;
+	u8 fw_id; /* index allocated for use in the MAE */
+};
+
 struct efx_tc_match {
 	struct efx_tc_match_fields value;
 	struct efx_tc_match_fields mask;
 	struct efx_tc_encap_match *encap;
+	struct efx_tc_recirc_id *rid;
 };
 
 struct efx_tc_action_set_list {
@@ -197,6 +206,8 @@ struct efx_tc_table_ct { /* TABLE_ID_CONNTRACK_TABLE */
  * @ct_zone_ht: Hashtable of TC conntrack flowtable bindings
  * @ct_ht: Hashtable of TC conntrack flow entries
  * @neigh_ht: Hashtable of neighbour watches (&struct efx_neigh_binder)
+ * @recirc_ht: Hashtable of recirculation ID mappings (&struct efx_tc_recirc_id)
+ * @recirc_ida: Recirculation ID allocator
  * @meta_ct: MAE table layout for conntrack table
  * @reps_mport_id: MAE port allocated for representor RX
  * @reps_filter_uc: VNIC filter for representor unicast RX (promisc)
@@ -231,6 +242,8 @@ struct efx_tc_state {
 	struct rhashtable ct_zone_ht;
 	struct rhashtable ct_ht;
 	struct rhashtable neigh_ht;
+	struct rhashtable recirc_ht;
+	struct ida recirc_ida;
 	struct efx_tc_table_ct meta_ct;
 	u32 reps_mport_id, reps_mport_vport_id;
 	s32 reps_filter_uc, reps_filter_mc;
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
index 6729b3796a8b..54ed288543d0 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.c
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -73,6 +73,15 @@ int efx_tc_init_conntrack(struct efx_nic *efx)
 	return rc;
 }
 
+/* Only call this in init failure teardown.
+ * Normal exit should fini instead as there may be entries in the table.
+ */
+void efx_tc_destroy_conntrack(struct efx_nic *efx)
+{
+	rhashtable_destroy(&efx->tc->ct_ht);
+	rhashtable_destroy(&efx->tc->ct_zone_ht);
+}
+
 void efx_tc_fini_conntrack(struct efx_nic *efx)
 {
 	rhashtable_free_and_destroy(&efx->tc->ct_zone_ht, efx_tc_ct_zone_free, NULL);
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.h b/drivers/net/ethernet/sfc/tc_conntrack.h
index ef5cf96c0649..e75c8eb1965d 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.h
+++ b/drivers/net/ethernet/sfc/tc_conntrack.h
@@ -26,8 +26,9 @@ struct efx_tc_ct_zone {
 	struct list_head cts; /* list of efx_tc_ct_entry in this zone */
 };
 
-/* create/teardown hashtables */
+/* create/uncreate/teardown hashtables */
 int efx_tc_init_conntrack(struct efx_nic *efx);
+void efx_tc_destroy_conntrack(struct efx_nic *efx);
 void efx_tc_fini_conntrack(struct efx_nic *efx);
 
 struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,

