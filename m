Return-Path: <netdev+bounces-24980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5249977268D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0697C280624
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51E411199;
	Mon,  7 Aug 2023 13:49:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8631118A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:49:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D1F1998
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CztAevHcN2uv1WI85wRtblhZhEJc8pQdI3X+qKFKIYMMOtspRiK/BCF3qCttfpHFpf1yitU/wbZ3PXNVFGnPWmdPZFihLSp5RBhD8fsJeiE9XK/Ln6PAnuJQTIsjSYb+90KTtXKKa8feMrhroHTatkTEq1cTWQaAK3z7BIlyjOY0DR3MYEoZ7ADlPjS39ae3UYS0yt2EK50Y8scCcbP8kBMx778KzPLbNp+kaFQZMnMWbyRyAMimABcdeBrrGGLxeok1aqYjwlkK/haoodoy0762fAOUiGDihUGe0lsbE5L5oKKcFa2663jc9AJ0OjHUblxoB2dJshrB+KutRp2Wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSic2QC/y1iRZ7xYGiB7kqzZdwh2hDF66VduSmgwJKY=;
 b=LqMjtVaalOxbAf7k5xauOZ4t9Mj/ztlJs4loleOrBB6NzPQSo1yCtU9sl5okahytbdl0JSbCMuAazHnbUwGfQTuK/hnEL8j3GY2gZV/o0JJnKX/xf5EsWaK9mzElWKSHXeCaKWlmU20O2hzOqVP7p866AihfBCcDmvyLaZP/PegbxZ0wk3n6S8zZJ4+ln7LglMzQzPZPqnNoLcgiGZ4bFXbKgV+s9BlPI5ksV4mFfY4e+iLQaALyQ7u720J4p1aHpxhQBFRulQJZWO5/5K3do7g6J6Ezxisl0vKnTF5P1fO4VRm2weNM+E/MzCIAOMZQYbSXb4SYA2jzM+en38uEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSic2QC/y1iRZ7xYGiB7kqzZdwh2hDF66VduSmgwJKY=;
 b=m1O2i40bL7lui3iWYPrbiZPjjPyKZh748TQoviUqTAG0uVPeBbEdqrnwxei8eGQMcfGPu8rZx09GXB/b103/dlPLVfWFkc4y2JDOwrx6oJ5sNPdJe72qJysaSFC6xi0lZ9rb0EcOzCzA0e9MT7G3B9123s/e1jq1+dQ3ObCbP2g=
Received: from CYXPR03CA0075.namprd03.prod.outlook.com (2603:10b6:930:d3::21)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 13:49:22 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::1f) by CYXPR03CA0075.outlook.office365.com
 (2603:10b6:930:d3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 13:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 13:49:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:49:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:49:21 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 08:49:20 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 6/7] sfc: conntrack state matches in TC rules
Date: Mon, 7 Aug 2023 14:48:10 +0100
Message-ID: <9c8e85dfdf0a339f55285ab586e83485e0acb005.1691415479.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: de9de8b2-85c9-436b-bd7b-08db974d1af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PW8PBocpG/xtT75eXkEsBsBGRXsC/X5VHGm2gr4E6/wSW+xEopatjQ5jD+ibIt1C/PDPQM/ue+fzfp0UxvIOUFyspOhEa2Ncfcm/yRc674Zo60QcNuPeyeFY4ryc3yZuROj3za7i8CUQ3XmVRnkh+/t2V4fvSin9BA5J9rIt89gjJP1DdTgZ1UQVwHX2yhX6HLOgfkEY3fl5kQzIl5VBFfgb3EWd1Ci+QNTl2wVNeaqBaQ2p/PDR0JIh/F5zVhLwQVA/XlCzQinUEYo8xr1bhV3GSq1SwHY93xIzQL6JtTXfokrczBzoypV13Ik/3d5dy5ZhC2XZMHJu/lXzHUpoKjUnGADEFcZZDEfX+PeOPswQ/ARvcac3nxUSmdbHLfVIKfelBcvk1nF9L5JuIXlh5chiwgsdv6nbYMRZug9vc+oBPewLtEGvBD0DpYJdmgcDDLttah0xWtxchwTXMgDxeBEE6xlgX6m0Zw8NYWCvc2RC9bhGdbSSGWcSMF0fjWgfJQtBd+q5NW+hv42SPCPgT+xox32J3G9LHgnu18lcjEqSsX5OoW2pJT0VfFZEWQ/jnd/4iG8VGW4mVY8anhQH1XE5k2d+2IBvFtWiyqlCQAXFbLEBPDF55+wpc60e6gOT6GpKJbs9vYhluI3zPldYmCGCffBP+wh0FFHg9NSDKM3DdJKIB1EnJZYkkYePip21owJcS2gvHAcjkcu4CsNN7whgRYs6r2stHRxPmb1/AQL+sZrSzEIhRIa4l9EvAsf3FYx6I5I17aCHw0BKfujTiQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400008)(451199021)(1800799003)(186006)(46966006)(36840700001)(40470700004)(36860700001)(36756003)(86362001)(55446002)(83380400001)(81166007)(356005)(82740400003)(40460700003)(40480700001)(9686003)(6666004)(336012)(26005)(316002)(41300700001)(70206006)(4326008)(478600001)(54906003)(110136005)(2876002)(2906002)(5660300002)(426003)(47076005)(8936002)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 13:49:22.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9de8b2-85c9-436b-bd7b-08db974d1af7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Parse ct_state trk/est, mark and zone out of flower keys, and plumb
 them through to the hardware, performing some minor translations.
Nothing can actually hit them yet as we're not offloading any DO_CT
 actions.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mae.c  | 33 +++++++++++++++--
 drivers/net/ethernet/sfc/mcdi.h |  5 +++
 drivers/net/ethernet/sfc/tc.c   | 66 +++++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc.h   |  5 +++
 4 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 8ebf71a54bf9..1fa0958d5262 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -695,8 +695,13 @@ int efx_mae_match_check_caps(struct efx_nic *efx,
 	    CHECK(L4_SPORT, l4_sport) ||
 	    CHECK(L4_DPORT, l4_dport) ||
 	    CHECK(TCP_FLAGS, tcp_flags) ||
+	    CHECK_BIT(TCP_SYN_FIN_RST, tcp_syn_fin_rst) ||
 	    CHECK_BIT(IS_IP_FRAG, ip_frag) ||
 	    CHECK_BIT(IP_FIRST_FRAG, ip_firstfrag) ||
+	    CHECK_BIT(DO_CT, ct_state_trk) ||
+	    CHECK_BIT(CT_HIT, ct_state_est) ||
+	    CHECK(CT_MARK, ct_mark) ||
+	    CHECK(CT_DOMAIN, ct_zone) ||
 	    CHECK(RECIRC_ID, recirc_id))
 		return rc;
 	/* Matches on outer fields are done in a separate hardware table,
@@ -1672,20 +1677,40 @@ static int efx_mae_populate_match_criteria(MCDI_DECLARE_STRUCT_PTR(match_crit),
 	}
 	MCDI_STRUCT_SET_DWORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_INGRESS_MPORT_SELECTOR_MASK,
 			      match->mask.ingress_port);
-	EFX_POPULATE_DWORD_2(*_MCDI_STRUCT_DWORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_FLAGS),
+	EFX_POPULATE_DWORD_5(*_MCDI_STRUCT_DWORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_FLAGS),
+			     MAE_FIELD_MASK_VALUE_PAIRS_V2_DO_CT,
+			     match->value.ct_state_trk,
+			     MAE_FIELD_MASK_VALUE_PAIRS_V2_CT_HIT,
+			     match->value.ct_state_est,
 			     MAE_FIELD_MASK_VALUE_PAIRS_V2_IS_IP_FRAG,
 			     match->value.ip_frag,
 			     MAE_FIELD_MASK_VALUE_PAIRS_V2_IP_FIRST_FRAG,
-			     match->value.ip_firstfrag);
-	EFX_POPULATE_DWORD_2(*_MCDI_STRUCT_DWORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_FLAGS_MASK),
+			     match->value.ip_firstfrag,
+			     MAE_FIELD_MASK_VALUE_PAIRS_V2_TCP_SYN_FIN_RST,
+			     match->value.tcp_syn_fin_rst);
+	EFX_POPULATE_DWORD_5(*_MCDI_STRUCT_DWORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_FLAGS_MASK),
+			     MAE_FIELD_MASK_VALUE_PAIRS_V2_DO_CT,
+			     match->mask.ct_state_trk,
+			     MAE_FIELD_MASK_VALUE_PAIRS_V2_CT_HIT,
+			     match->mask.ct_state_est,
 			     MAE_FIELD_MASK_VALUE_PAIRS_V2_IS_IP_FRAG,
 			     match->mask.ip_frag,
 			     MAE_FIELD_MASK_VALUE_PAIRS_V2_IP_FIRST_FRAG,
-			     match->mask.ip_firstfrag);
+			     match->mask.ip_firstfrag,
+			     MAE_FIELD_MASK_VALUE_PAIRS_V2_TCP_SYN_FIN_RST,
+			     match->mask.tcp_syn_fin_rst);
 	MCDI_STRUCT_SET_BYTE(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_RECIRC_ID,
 			     match->value.recirc_id);
 	MCDI_STRUCT_SET_BYTE(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_RECIRC_ID_MASK,
 			     match->mask.recirc_id);
+	MCDI_STRUCT_SET_DWORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_CT_MARK,
+			      match->value.ct_mark);
+	MCDI_STRUCT_SET_DWORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_CT_MARK_MASK,
+			      match->mask.ct_mark);
+	MCDI_STRUCT_SET_WORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_CT_DOMAIN,
+			     match->value.ct_zone);
+	MCDI_STRUCT_SET_WORD(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_CT_DOMAIN_MASK,
+			     match->mask.ct_zone);
 	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_ETHER_TYPE_BE,
 				match->value.eth_proto);
 	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_FIELD_MASK_VALUE_PAIRS_V2_ETHER_TYPE_BE_MASK,
diff --git a/drivers/net/ethernet/sfc/mcdi.h b/drivers/net/ethernet/sfc/mcdi.h
index 995a26686fd8..700d0252aebd 100644
--- a/drivers/net/ethernet/sfc/mcdi.h
+++ b/drivers/net/ethernet/sfc/mcdi.h
@@ -229,6 +229,11 @@ void efx_mcdi_sensor_event(struct efx_nic *efx, efx_qword_t *ev);
 	BUILD_BUG_ON(MC_CMD_ ## _field ## _OFST & 1);			\
 	*(__force __le16 *)MCDI_PTR(_buf, _field) = cpu_to_le16(_value);\
 	} while (0)
+#define MCDI_STRUCT_SET_WORD(_buf, _field, _value) do {			\
+	BUILD_BUG_ON(_field ## _LEN != 2);				\
+	BUILD_BUG_ON(_field ## _OFST & 1);				\
+	*(__force __le16 *)MCDI_STRUCT_PTR(_buf, _field) = cpu_to_le16(_value);\
+	} while (0)
 #define MCDI_WORD(_buf, _field)						\
 	((u16)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 2) +	\
 	 le16_to_cpu(*(__force const __le16 *)MCDI_PTR(_buf, _field)))
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 181636d07024..a9f4bfaacac3 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -222,6 +222,7 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_CT) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))) {
 		NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported flower keys %#llx",
@@ -363,6 +364,31 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 				       dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CT)) {
+		struct flow_match_ct fm;
+
+		flow_rule_match_ct(rule, &fm);
+		match->value.ct_state_trk = !!(fm.key->ct_state & TCA_FLOWER_KEY_CT_FLAGS_TRACKED);
+		match->mask.ct_state_trk = !!(fm.mask->ct_state & TCA_FLOWER_KEY_CT_FLAGS_TRACKED);
+		match->value.ct_state_est = !!(fm.key->ct_state & TCA_FLOWER_KEY_CT_FLAGS_ESTABLISHED);
+		match->mask.ct_state_est = !!(fm.mask->ct_state & TCA_FLOWER_KEY_CT_FLAGS_ESTABLISHED);
+		if (fm.mask->ct_state & ~(TCA_FLOWER_KEY_CT_FLAGS_TRACKED |
+					  TCA_FLOWER_KEY_CT_FLAGS_ESTABLISHED)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Unsupported ct_state match %#x",
+					       fm.mask->ct_state);
+			return -EOPNOTSUPP;
+		}
+		match->value.ct_mark = fm.key->ct_mark;
+		match->mask.ct_mark = fm.mask->ct_mark;
+		match->value.ct_zone = fm.key->ct_zone;
+		match->mask.ct_zone = fm.mask->ct_zone;
+
+		if (memchr_inv(fm.mask->ct_labels, 0, sizeof(fm.mask->ct_labels))) {
+			NL_SET_ERR_MSG_MOD(extack, "Matching on ct_label not supported");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	return 0;
 }
@@ -758,6 +784,26 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	}
 	match.mask.recirc_id = 0xff;
 
+	/* AR table can't match on DO_CT (+trk).  But a commonly used pattern is
+	 * +trk+est, which is strictly implied by +est, so rewrite it to that.
+	 */
+	if (match.mask.ct_state_trk && match.value.ct_state_trk &&
+	    match.mask.ct_state_est && match.value.ct_state_est)
+		match.mask.ct_state_trk = 0;
+	/* Thanks to CT_TCP_FLAGS_INHIBIT, packets with interesting flags could
+	 * match +trk-est (CT_HIT=0) despite being on an established connection.
+	 * So make -est imply -tcp_syn_fin_rst match to ensure these packets
+	 * still hit the software path.
+	 */
+	if (match.mask.ct_state_est && !match.value.ct_state_est) {
+		if (match.value.tcp_syn_fin_rst) {
+			/* Can't offload this combination */
+			rc = -EOPNOTSUPP;
+			goto release;
+		}
+		match.mask.tcp_syn_fin_rst = true;
+	}
+
 	flow_action_for_each(i, fa, &fr->action) {
 		switch (fa->id) {
 		case FLOW_ACTION_REDIRECT:
@@ -1089,6 +1135,26 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 	}
 	match.mask.recirc_id = 0xff;
 
+	/* AR table can't match on DO_CT (+trk).  But a commonly used pattern is
+	 * +trk+est, which is strictly implied by +est, so rewrite it to that.
+	 */
+	if (match.mask.ct_state_trk && match.value.ct_state_trk &&
+	    match.mask.ct_state_est && match.value.ct_state_est)
+		match.mask.ct_state_trk = 0;
+	/* Thanks to CT_TCP_FLAGS_INHIBIT, packets with interesting flags could
+	 * match +trk-est (CT_HIT=0) despite being on an established connection.
+	 * So make -est imply -tcp_syn_fin_rst match to ensure these packets
+	 * still hit the software path.
+	 */
+	if (match.mask.ct_state_est && !match.value.ct_state_est) {
+		if (match.value.tcp_syn_fin_rst) {
+			/* Can't offload this combination */
+			rc = -EOPNOTSUPP;
+			goto release;
+		}
+		match.mask.tcp_syn_fin_rst = true;
+	}
+
 	rc = efx_mae_match_check_caps(efx, &match.mask, extack);
 	if (rc)
 		goto release;
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index af15020c8da7..ce8e30743a3a 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -60,6 +60,7 @@ struct efx_tc_match_fields {
 	/* L4 */
 	__be16 l4_sport, l4_dport; /* Ports (UDP, TCP) */
 	__be16 tcp_flags;
+	bool tcp_syn_fin_rst; /* true if ANY of SYN/FIN/RST are set */
 	/* Encap.  The following are *outer* fields.  Note that there are no
 	 * outer eth (L2) fields; this is because TC doesn't have them.
 	 */
@@ -68,6 +69,10 @@ struct efx_tc_match_fields {
 	u8 enc_ip_tos, enc_ip_ttl;
 	__be16 enc_sport, enc_dport;
 	__be32 enc_keyid; /* e.g. VNI, VSID */
+	/* Conntrack. */
+	u16 ct_state_trk:1, ct_state_est:1;
+	u32 ct_mark;
+	u16 ct_zone;
 };
 
 static inline bool efx_tc_match_is_encap(const struct efx_tc_match_fields *mask)

