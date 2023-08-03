Return-Path: <netdev+bounces-24022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEDE76E78F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A4328138B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F31A1F175;
	Thu,  3 Aug 2023 11:57:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF471E511
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:57:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCC63595
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T01mTnROyn9a2QfLzF0MTsUtbXCU69TN2nnql6dV5tk/rBvY0Adou+13yDFOyrZQpNHwKmxCU1unbGdUCaj/IRf3lA4H9oiFHV14RhGOmQC7Q8RbILGkAsWJqhK3c9tdGGmtRhfu9v1/d8Im0NpeiOrUih/2+VQlETBYWmBJHwZXir7jGsSGLmuGEzHbc1uvhlhQ+WlLHgWgBybVseHWlLA89gwCi4STfL3bssBS3oi+VlfC73rkxCbsywHijGIFWHLYXkI/E8y2as2XKc87gWWUXVv7JhwZcTebqZiVyTirNsYGXCA+63THXSXZsLj0k36eE94dqc27MRd54aniZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qsa0eBHgZ7K31udQtaNAbKcwh2GfrPI4jqjzyXVw+F4=;
 b=FeYBdDfeKdh78G4++AjhfD2UfvkzOQEd/OQ/KpOybBKT5oY51V1UES4vNqYg6SFVNI+glD3WTeHaMmrqPT0P5JgaRMXjqVSvGWQ7HWIButrO4pU3aKc3iIuwLu1XAQ8sir3xc+oA4eE2IjYwxuL2tTjpwbhArKrHmI5hdYNdwMf4bMElWO1LYLZOaU74TEucBxg2l/uYmHaYHcALDM4t3xYhUA2ey6qEx82bTUPb+jUAiINOqtyf9ksUlTJlMQaYytJCZvj4J9j3jVDxaNmqmYex/lr3qZsUDfrsBA/TZ1u2HekZp15rVgRwpCJTq7rpZGBQQgUJWcYnAzidSAREqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qsa0eBHgZ7K31udQtaNAbKcwh2GfrPI4jqjzyXVw+F4=;
 b=K5zxdMlNfi1uRxpTSzyTJSZot8+22Hql+dzJuMlkZ+/crWK8rLs59yA4jsinxjGiIyrChA4wMRds24ujACkWWnvzaDUl9X6HbPBuPR/GyXZgt7AlP+laWjD452fBUld2qanmbsB/D9eipbCQtKcoTR+dZGgUAdVGi8yqNQyoXq8=
Received: from DM6PR11CA0058.namprd11.prod.outlook.com (2603:10b6:5:14c::35)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:57:39 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::18) by DM6PR11CA0058.outlook.office365.com
 (2603:10b6:5:14c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 11:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 11:57:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 06:57:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 04:57:37 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 06:57:36 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 7/7] sfc: offload left-hand side rules for conntrack
Date: Thu, 3 Aug 2023 12:56:23 +0100
Message-ID: <9794c4fd9a32138fb5b30c7b4944f4b09e026ac2.1691063676.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1691063675.git.ecree.xilinx@gmail.com>
References: <cover.1691063675.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d488c0-68dd-492e-99e0-08db9418d5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KXs07DBYSC3dSfg6VgTEFRb2jWG/yI+K9MgoZuwgMrmryAGj9/ILUTStEgWUpkUCf4VmX3iNBoE3Po8KxIfSId5TvNEB45UMaVprJitf3C0dZecTRk732o0q3yvgy66b8keYsU62q5aRz9CFWy8UEQRzv2Y2OPE9y82wvCQFLw2Jy8C0AlGBh1rIWSDCpo+M5DkqKmoOOjKHchUokE6L+xFKXJHfVjeWDiGJaGxAZq+9G+94jvS9VCODin/RGJKx4clrfda26eXRymvx4JsehfsyI5AAT42h0rEBB5/V7sccxe5Yn3X9810GZ/pwpArHBQMZ8+eWccFngyQAnQ6PZFrwGg+tiFW7osir64gQHIYxo6aWAfNF+nLQuMY0Yh7XigaFl2K7BDCySqwgZ15oel/hVm+NDgTl9YjdgtkMPnJPEw/b7ikCkwmLpQQwzkJ1QXVTdnf/NE2TYcPnqFA02D2ssSwQz2xp3Y74IyxuVvMIe6sn4obmlSsEjuPBTQdd3Iv8KIQHYXy9sqn+d9KdX7KfOq7jr/AnpmKt+9/nQ7vznuoEU4msex8T12AJtvQp/2VMTxFCvu8m+91CLq/SsD+Qpp88nhlkdwHEd9fUraErSiGs4liztzE5ZH3B5hH5Lp7HlBt2pa5EnGAPT513xgRLSo1z+sPSwX4QH34QYwIBgQubv1xkijbtUumkgns8tEWJhdwDUAzwFGV3MkJqVbUFk4H/AVbIzeGykzVFeQBg7/h2jyh1Re439qSoN0YJLaXvbiipmFtrrmQxSjUtcSf4QWsle17sSe+fgFwxH3E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36756003)(55446002)(86362001)(82740400003)(40460700003)(40480700001)(54906003)(478600001)(110136005)(356005)(81166007)(47076005)(426003)(336012)(186003)(26005)(83380400001)(8676002)(8936002)(6666004)(41300700001)(9686003)(30864003)(316002)(36860700001)(5660300002)(4326008)(70586007)(2876002)(2906002)(70206006)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:57:38.7275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d488c0-68dd-492e-99e0-08db9418d5b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Handle the (comparatively) simple case of a -trk rule on an efx netdev
 (i.e. not a tunnel decap rule) with ct and goto chain actions.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/bitfield.h |   2 +
 drivers/net/ethernet/sfc/mae.c      | 287 ++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/mae.h      |   6 +
 drivers/net/ethernet/sfc/mcdi.h     |   6 +
 drivers/net/ethernet/sfc/tc.c       | 281 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc.h       |  16 ++
 6 files changed, 598 insertions(+)

diff --git a/drivers/net/ethernet/sfc/bitfield.h b/drivers/net/ethernet/sfc/bitfield.h
index 1f981dfe4bdc..89665fc9b8d0 100644
--- a/drivers/net/ethernet/sfc/bitfield.h
+++ b/drivers/net/ethernet/sfc/bitfield.h
@@ -26,6 +26,8 @@
 /* Lowest bit numbers and widths */
 #define EFX_DUMMY_FIELD_LBN 0
 #define EFX_DUMMY_FIELD_WIDTH 0
+#define EFX_BYTE_0_LBN 0
+#define EFX_BYTE_0_WIDTH 8
 #define EFX_WORD_0_LBN 0
 #define EFX_WORD_0_WIDTH 16
 #define EFX_WORD_1_LBN 16
diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 1fa0958d5262..3b8780c76b6e 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -727,6 +727,90 @@ int efx_mae_match_check_caps(struct efx_nic *efx,
 	}
 	return 0;
 }
+
+/* Checks for match fields not supported in LHS Outer Rules */
+#define UNSUPPORTED(_field)	({					       \
+	enum mask_type typ = classify_mask((const u8 *)&mask->_field,	       \
+					   sizeof(mask->_field));	       \
+									       \
+	if (typ != MASK_ZEROES) {					       \
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported match field " #_field);\
+		rc = -EOPNOTSUPP;					       \
+	}								       \
+	rc;								       \
+})
+#define UNSUPPORTED_BIT(_field)	({					       \
+	if (mask->_field) {						       \
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported match field " #_field);\
+		rc = -EOPNOTSUPP;					       \
+	}								       \
+	rc;								       \
+})
+
+/* LHS rules are (normally) inserted in the Outer Rule table, which means
+ * they use ENC_ fields in hardware to match regular (not enc_) fields from
+ * &struct efx_tc_match_fields.
+ */
+int efx_mae_match_check_caps_lhs(struct efx_nic *efx,
+				 const struct efx_tc_match_fields *mask,
+				 struct netlink_ext_ack *extack)
+{
+	const u8 *supported_fields = efx->tc->caps->outer_rule_fields;
+	__be32 ingress_port = cpu_to_be32(mask->ingress_port);
+	enum mask_type ingress_port_mask_type;
+	int rc;
+
+	/* Check for _PREFIX assumes big-endian, so we need to convert */
+	ingress_port_mask_type = classify_mask((const u8 *)&ingress_port,
+					       sizeof(ingress_port));
+	rc = efx_mae_match_check_cap_typ(supported_fields[MAE_FIELD_INGRESS_PORT],
+					 ingress_port_mask_type);
+	if (rc) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "No support for %s mask in field %s\n",
+				       mask_type_name(ingress_port_mask_type),
+				       "ingress_port");
+		return rc;
+	}
+	if (CHECK(ENC_ETHER_TYPE, eth_proto) ||
+	    CHECK(ENC_VLAN0_TCI, vlan_tci[0]) ||
+	    CHECK(ENC_VLAN0_PROTO, vlan_proto[0]) ||
+	    CHECK(ENC_VLAN1_TCI, vlan_tci[1]) ||
+	    CHECK(ENC_VLAN1_PROTO, vlan_proto[1]) ||
+	    CHECK(ENC_ETH_SADDR, eth_saddr) ||
+	    CHECK(ENC_ETH_DADDR, eth_daddr) ||
+	    CHECK(ENC_IP_PROTO, ip_proto) ||
+	    CHECK(ENC_IP_TOS, ip_tos) ||
+	    CHECK(ENC_IP_TTL, ip_ttl) ||
+	    CHECK_BIT(ENC_IP_FRAG, ip_frag) ||
+	    UNSUPPORTED_BIT(ip_firstfrag) ||
+	    CHECK(ENC_SRC_IP4, src_ip) ||
+	    CHECK(ENC_DST_IP4, dst_ip) ||
+#ifdef CONFIG_IPV6
+	    CHECK(ENC_SRC_IP6, src_ip6) ||
+	    CHECK(ENC_DST_IP6, dst_ip6) ||
+#endif
+	    CHECK(ENC_L4_SPORT, l4_sport) ||
+	    CHECK(ENC_L4_DPORT, l4_dport) ||
+	    UNSUPPORTED(tcp_flags) ||
+	    CHECK_BIT(TCP_SYN_FIN_RST, tcp_syn_fin_rst))
+		return rc;
+	if (efx_tc_match_is_encap(mask)) {
+		/* can't happen; disallowed for local rules, translated
+		 * for foreign rules.
+		 */
+		NL_SET_ERR_MSG_MOD(extack, "Unexpected encap match in LHS rule");
+		return -EOPNOTSUPP;
+	}
+	if (UNSUPPORTED(enc_keyid) ||
+	    /* Can't filter on conntrack in LHS rules */
+	    UNSUPPORTED_BIT(ct_state_trk) ||
+	    UNSUPPORTED_BIT(ct_state_est) ||
+	    UNSUPPORTED(ct_mark) ||
+	    UNSUPPORTED(recirc_id))
+		return rc;
+	return 0;
+}
+#undef UNSUPPORTED
 #undef CHECK_BIT
 #undef CHECK
 
@@ -1409,6 +1493,209 @@ int efx_mae_unregister_encap_match(struct efx_nic *efx,
 	return 0;
 }
 
+static int efx_mae_populate_lhs_match_criteria(MCDI_DECLARE_STRUCT_PTR(match_crit),
+					       const struct efx_tc_match *match)
+{
+	if (match->mask.ingress_port) {
+		if (~match->mask.ingress_port)
+			return -EOPNOTSUPP;
+		MCDI_STRUCT_SET_DWORD(match_crit,
+				      MAE_ENC_FIELD_PAIRS_INGRESS_MPORT_SELECTOR,
+				      match->value.ingress_port);
+	}
+	MCDI_STRUCT_SET_DWORD(match_crit, MAE_ENC_FIELD_PAIRS_INGRESS_MPORT_SELECTOR_MASK,
+			      match->mask.ingress_port);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_ETHER_TYPE_BE,
+				match->value.eth_proto);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_ETHER_TYPE_BE_MASK,
+				match->mask.eth_proto);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_VLAN0_TCI_BE,
+				match->value.vlan_tci[0]);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_VLAN0_TCI_BE_MASK,
+				match->mask.vlan_tci[0]);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_VLAN0_PROTO_BE,
+				match->value.vlan_proto[0]);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_VLAN0_PROTO_BE_MASK,
+				match->mask.vlan_proto[0]);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_VLAN1_TCI_BE,
+				match->value.vlan_tci[1]);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_VLAN1_TCI_BE_MASK,
+				match->mask.vlan_tci[1]);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_VLAN1_PROTO_BE,
+				match->value.vlan_proto[1]);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_VLAN1_PROTO_BE_MASK,
+				match->mask.vlan_proto[1]);
+	memcpy(MCDI_STRUCT_PTR(match_crit, MAE_ENC_FIELD_PAIRS_ENC_ETH_SADDR_BE),
+	       match->value.eth_saddr, ETH_ALEN);
+	memcpy(MCDI_STRUCT_PTR(match_crit, MAE_ENC_FIELD_PAIRS_ENC_ETH_SADDR_BE_MASK),
+	       match->mask.eth_saddr, ETH_ALEN);
+	memcpy(MCDI_STRUCT_PTR(match_crit, MAE_ENC_FIELD_PAIRS_ENC_ETH_DADDR_BE),
+	       match->value.eth_daddr, ETH_ALEN);
+	memcpy(MCDI_STRUCT_PTR(match_crit, MAE_ENC_FIELD_PAIRS_ENC_ETH_DADDR_BE_MASK),
+	       match->mask.eth_daddr, ETH_ALEN);
+	MCDI_STRUCT_SET_BYTE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_IP_PROTO,
+			     match->value.ip_proto);
+	MCDI_STRUCT_SET_BYTE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_IP_PROTO_MASK,
+			     match->mask.ip_proto);
+	MCDI_STRUCT_SET_BYTE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_IP_TOS,
+			     match->value.ip_tos);
+	MCDI_STRUCT_SET_BYTE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_IP_TOS_MASK,
+			     match->mask.ip_tos);
+	MCDI_STRUCT_SET_BYTE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_IP_TTL,
+			     match->value.ip_ttl);
+	MCDI_STRUCT_SET_BYTE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_IP_TTL_MASK,
+			     match->mask.ip_ttl);
+	MCDI_STRUCT_POPULATE_BYTE_1(match_crit,
+				    MAE_ENC_FIELD_PAIRS_ENC_VLAN_FLAGS,
+				    MAE_ENC_FIELD_PAIRS_ENC_IP_FRAG,
+				    match->value.ip_frag);
+	MCDI_STRUCT_POPULATE_BYTE_1(match_crit,
+				    MAE_ENC_FIELD_PAIRS_ENC_VLAN_FLAGS_MASK,
+				    MAE_ENC_FIELD_PAIRS_ENC_IP_FRAG_MASK,
+				    match->mask.ip_frag);
+	MCDI_STRUCT_SET_DWORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_SRC_IP4_BE,
+				 match->value.src_ip);
+	MCDI_STRUCT_SET_DWORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_SRC_IP4_BE_MASK,
+				 match->mask.src_ip);
+	MCDI_STRUCT_SET_DWORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_DST_IP4_BE,
+				 match->value.dst_ip);
+	MCDI_STRUCT_SET_DWORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_DST_IP4_BE_MASK,
+				 match->mask.dst_ip);
+#ifdef CONFIG_IPV6
+	memcpy(MCDI_STRUCT_PTR(match_crit, MAE_ENC_FIELD_PAIRS_ENC_SRC_IP6_BE),
+	       &match->value.src_ip6, sizeof(struct in6_addr));
+	memcpy(MCDI_STRUCT_PTR(match_crit, MAE_ENC_FIELD_PAIRS_ENC_SRC_IP6_BE_MASK),
+	       &match->mask.src_ip6, sizeof(struct in6_addr));
+	memcpy(MCDI_STRUCT_PTR(match_crit, MAE_ENC_FIELD_PAIRS_ENC_DST_IP6_BE),
+	       &match->value.dst_ip6, sizeof(struct in6_addr));
+	memcpy(MCDI_STRUCT_PTR(match_crit, MAE_ENC_FIELD_PAIRS_ENC_DST_IP6_BE_MASK),
+	       &match->mask.dst_ip6, sizeof(struct in6_addr));
+#endif
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_L4_SPORT_BE,
+				match->value.l4_sport);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_L4_SPORT_BE_MASK,
+				match->mask.l4_sport);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_L4_DPORT_BE,
+				match->value.l4_dport);
+	MCDI_STRUCT_SET_WORD_BE(match_crit, MAE_ENC_FIELD_PAIRS_ENC_L4_DPORT_BE_MASK,
+				match->mask.l4_dport);
+	/* No enc-keys in LHS rules.  Caps check should have caught this; any
+	 * enc-keys from an fLHS should have been translated to regular keys
+	 * and any EM should be a pseudo (we're an OR so can't have a direct
+	 * EM with another OR).
+	 */
+	if (WARN_ON_ONCE(match->encap && !match->encap->type))
+		return -EOPNOTSUPP;
+	if (WARN_ON_ONCE(match->mask.enc_src_ip))
+		return -EOPNOTSUPP;
+	if (WARN_ON_ONCE(match->mask.enc_dst_ip))
+		return -EOPNOTSUPP;
+#ifdef CONFIG_IPV6
+	if (WARN_ON_ONCE(!ipv6_addr_any(&match->mask.enc_src_ip6)))
+		return -EOPNOTSUPP;
+	if (WARN_ON_ONCE(!ipv6_addr_any(&match->mask.enc_dst_ip6)))
+		return -EOPNOTSUPP;
+#endif
+	if (WARN_ON_ONCE(match->mask.enc_ip_tos))
+		return -EOPNOTSUPP;
+	if (WARN_ON_ONCE(match->mask.enc_ip_ttl))
+		return -EOPNOTSUPP;
+	if (WARN_ON_ONCE(match->mask.enc_sport))
+		return -EOPNOTSUPP;
+	if (WARN_ON_ONCE(match->mask.enc_dport))
+		return -EOPNOTSUPP;
+	if (WARN_ON_ONCE(match->mask.enc_keyid))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static int efx_mae_insert_lhs_outer_rule(struct efx_nic *efx,
+					 struct efx_tc_lhs_rule *rule, u32 prio)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_MAE_OUTER_RULE_INSERT_IN_LEN(MAE_ENC_FIELD_PAIRS_LEN));
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_OUTER_RULE_INSERT_OUT_LEN);
+	MCDI_DECLARE_STRUCT_PTR(match_crit);
+	const struct efx_tc_lhs_action *act;
+	size_t outlen;
+	int rc;
+
+	MCDI_SET_DWORD(inbuf, MAE_OUTER_RULE_INSERT_IN_PRIO, prio);
+	/* match */
+	match_crit = _MCDI_DWORD(inbuf, MAE_OUTER_RULE_INSERT_IN_FIELD_MATCH_CRITERIA);
+	rc = efx_mae_populate_lhs_match_criteria(match_crit, &rule->match);
+	if (rc)
+		return rc;
+
+	/* action */
+	act = &rule->lhs_act;
+	MCDI_SET_DWORD(inbuf, MAE_OUTER_RULE_INSERT_IN_ENCAP_TYPE,
+		       MAE_MCDI_ENCAP_TYPE_NONE);
+	/* We always inhibit CT lookup on TCP_INTERESTING_FLAGS, since the
+	 * SW path needs to process the packet to update the conntrack tables
+	 * on connection establishment (SYN) or termination (FIN, RST).
+	 */
+	MCDI_POPULATE_DWORD_6(inbuf, MAE_OUTER_RULE_INSERT_IN_LOOKUP_CONTROL,
+			      MAE_OUTER_RULE_INSERT_IN_DO_CT, !!act->zone,
+			      MAE_OUTER_RULE_INSERT_IN_CT_TCP_FLAGS_INHIBIT, 1,
+			      MAE_OUTER_RULE_INSERT_IN_CT_DOMAIN,
+			      act->zone ? act->zone->zone : 0,
+			      MAE_OUTER_RULE_INSERT_IN_CT_VNI_MODE,
+			      MAE_CT_VNI_MODE_ZERO,
+			      MAE_OUTER_RULE_INSERT_IN_DO_COUNT, !!act->count,
+			      MAE_OUTER_RULE_INSERT_IN_RECIRC_ID,
+			      act->rid ? act->rid->fw_id : 0);
+	if (act->count)
+		MCDI_SET_DWORD(inbuf, MAE_OUTER_RULE_INSERT_IN_COUNTER_ID,
+			       act->count->cnt->fw_id);
+	rc = efx_mcdi_rpc(efx, MC_CMD_MAE_OUTER_RULE_INSERT, inbuf,
+			  sizeof(inbuf), outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		return rc;
+	if (outlen < sizeof(outbuf))
+		return -EIO;
+	rule->fw_id = MCDI_DWORD(outbuf, MAE_OUTER_RULE_INSERT_OUT_OR_ID);
+	return 0;
+}
+
+int efx_mae_insert_lhs_rule(struct efx_nic *efx, struct efx_tc_lhs_rule *rule,
+			    u32 prio)
+{
+	return efx_mae_insert_lhs_outer_rule(efx, rule, prio);
+}
+
+static int efx_mae_remove_lhs_outer_rule(struct efx_nic *efx,
+					 struct efx_tc_lhs_rule *rule)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_MAE_OUTER_RULE_REMOVE_OUT_LEN(1));
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_MAE_OUTER_RULE_REMOVE_IN_LEN(1));
+	size_t outlen;
+	int rc;
+
+	MCDI_SET_DWORD(inbuf, MAE_OUTER_RULE_REMOVE_IN_OR_ID, rule->fw_id);
+	rc = efx_mcdi_rpc(efx, MC_CMD_MAE_OUTER_RULE_REMOVE, inbuf,
+			  sizeof(inbuf), outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		return rc;
+	if (outlen < sizeof(outbuf))
+		return -EIO;
+	/* FW freed a different ID than we asked for, should also never happen.
+	 * Warn because it means we've now got a different idea to the FW of
+	 * what encap_mds exist, which could cause mayhem later.
+	 */
+	if (WARN_ON(MCDI_DWORD(outbuf, MAE_OUTER_RULE_REMOVE_OUT_REMOVED_OR_ID) != rule->fw_id))
+		return -EIO;
+	/* We're probably about to free @rule, but let's just make sure its
+	 * fw_id is blatted so that it won't look valid if it leaks out.
+	 */
+	rule->fw_id = MC_CMD_MAE_OUTER_RULE_INSERT_OUT_OUTER_RULE_ID_NULL;
+	return 0;
+}
+
+int efx_mae_remove_lhs_rule(struct efx_nic *efx, struct efx_tc_lhs_rule *rule)
+{
+	return efx_mae_remove_lhs_outer_rule(efx, rule);
+}
+
 /* Populating is done by taking each byte of @value in turn and storing
  * it in the appropriate bits of @row.  @value must be big-endian; we
  * convert it to little-endianness as we go.
diff --git a/drivers/net/ethernet/sfc/mae.h b/drivers/net/ethernet/sfc/mae.h
index 24f29a4fc0e1..e88e80574f15 100644
--- a/drivers/net/ethernet/sfc/mae.h
+++ b/drivers/net/ethernet/sfc/mae.h
@@ -84,6 +84,9 @@ int efx_mae_get_caps(struct efx_nic *efx, struct mae_caps *caps);
 int efx_mae_match_check_caps(struct efx_nic *efx,
 			     const struct efx_tc_match_fields *mask,
 			     struct netlink_ext_ack *extack);
+int efx_mae_match_check_caps_lhs(struct efx_nic *efx,
+				 const struct efx_tc_match_fields *mask,
+				 struct netlink_ext_ack *extack);
 int efx_mae_check_encap_match_caps(struct efx_nic *efx, bool ipv6,
 				   u8 ip_tos_mask, __be16 udp_sport_mask,
 				   struct netlink_ext_ack *extack);
@@ -112,6 +115,9 @@ int efx_mae_register_encap_match(struct efx_nic *efx,
 				 struct efx_tc_encap_match *encap);
 int efx_mae_unregister_encap_match(struct efx_nic *efx,
 				   struct efx_tc_encap_match *encap);
+int efx_mae_insert_lhs_rule(struct efx_nic *efx, struct efx_tc_lhs_rule *rule,
+			    u32 prio);
+int efx_mae_remove_lhs_rule(struct efx_nic *efx, struct efx_tc_lhs_rule *rule);
 struct efx_tc_ct_entry; /* see tc_conntrack.h */
 int efx_mae_insert_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn);
 int efx_mae_remove_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn);
diff --git a/drivers/net/ethernet/sfc/mcdi.h b/drivers/net/ethernet/sfc/mcdi.h
index 700d0252aebd..ea612c619874 100644
--- a/drivers/net/ethernet/sfc/mcdi.h
+++ b/drivers/net/ethernet/sfc/mcdi.h
@@ -218,6 +218,12 @@ void efx_mcdi_sensor_event(struct efx_nic *efx, efx_qword_t *ev);
 	BUILD_BUG_ON(_field ## _LEN != 1);				\
 	*(u8 *)MCDI_STRUCT_PTR(_buf, _field) = _value;			\
 	} while (0)
+#define MCDI_STRUCT_POPULATE_BYTE_1(_buf, _field, _name, _value) do {	\
+	efx_dword_t _temp;						\
+	EFX_POPULATE_DWORD_1(_temp, _name, _value);			\
+	MCDI_STRUCT_SET_BYTE(_buf, _field,				\
+			     EFX_DWORD_FIELD(_temp, EFX_BYTE_0));	\
+	} while (0)
 #define MCDI_BYTE(_buf, _field)						\
 	((void)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 1),	\
 	 *MCDI_PTR(_buf, _field))
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index a9f4bfaacac3..7df6d8066882 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -12,6 +12,7 @@
 #include <net/pkt_cls.h>
 #include <net/vxlan.h>
 #include <net/geneve.h>
+#include <net/tc_act/tc_ct.h>
 #include "tc.h"
 #include "tc_bindings.h"
 #include "tc_encap_actions.h"
@@ -97,6 +98,12 @@ static const struct rhashtable_params efx_tc_match_action_ht_params = {
 	.head_offset	= offsetof(struct efx_tc_flow_rule, linkage),
 };
 
+static const struct rhashtable_params efx_tc_lhs_rule_ht_params = {
+	.key_len	= sizeof(unsigned long),
+	.key_offset	= offsetof(struct efx_tc_lhs_rule, cookie),
+	.head_offset	= offsetof(struct efx_tc_lhs_rule, linkage),
+};
+
 static const struct rhashtable_params efx_tc_recirc_ht_params = {
 	.key_len	= offsetof(struct efx_tc_recirc_id, linkage),
 	.key_offset	= 0,
@@ -736,6 +743,162 @@ static bool efx_tc_flower_action_order_ok(const struct efx_tc_action_set *act,
 	}
 }
 
+/**
+ * DOC: TC conntrack sequences
+ *
+ * The MAE hardware can handle at most two rounds of action rule matching,
+ * consequently we support conntrack through the notion of a "left-hand side
+ * rule".  This is a rule which typically contains only the actions "ct" and
+ * "goto chain N", and corresponds to one or more "right-hand side rules" in
+ * chain N, which typically match on +trk+est, and may perform ct(nat) actions.
+ * RHS rules go in the Action Rule table as normal but with a nonzero recirc_id
+ * (the hardware equivalent of chain_index), while LHS rules may go in either
+ * the Action Rule or the Outer Rule table, the latter being preferred for
+ * performance reasons, and set both DO_CT and a recirc_id in their response.
+ *
+ * Besides the RHS rules, there are often also similar rules matching on
+ * +trk+new which perform the ct(commit) action.  These are not offloaded.
+ */
+
+static bool efx_tc_rule_is_lhs_rule(struct flow_rule *fr,
+				    struct efx_tc_match *match)
+{
+	const struct flow_action_entry *fa;
+	int i;
+
+	flow_action_for_each(i, fa, &fr->action) {
+		switch (fa->id) {
+		case FLOW_ACTION_GOTO:
+			return true;
+		case FLOW_ACTION_CT:
+			/* If rule is -trk, or doesn't mention trk at all, then
+			 * a CT action implies a conntrack lookup (hence it's an
+			 * LHS rule).  If rule is +trk, then a CT action could
+			 * just be ct(nat) or even ct(commit) (though the latter
+			 * can't be offloaded).
+			 */
+			if (!match->mask.ct_state_trk || !match->value.ct_state_trk)
+				return true;
+		default:
+			break;
+		}
+	}
+	return false;
+}
+
+static int efx_tc_flower_handle_lhs_actions(struct efx_nic *efx,
+					    struct flow_cls_offload *tc,
+					    struct flow_rule *fr,
+					    struct net_device *net_dev,
+					    struct efx_tc_lhs_rule *rule)
+
+{
+	struct netlink_ext_ack *extack = tc->common.extack;
+	struct efx_tc_lhs_action *act = &rule->lhs_act;
+	const struct flow_action_entry *fa;
+	bool pipe = true;
+	int i;
+
+	flow_action_for_each(i, fa, &fr->action) {
+		struct efx_tc_ct_zone *ct_zone;
+		struct efx_tc_recirc_id *rid;
+
+		if (!pipe) {
+			/* more actions after a non-pipe action */
+			NL_SET_ERR_MSG_MOD(extack, "Action follows non-pipe action");
+			return -EINVAL;
+		}
+		switch (fa->id) {
+		case FLOW_ACTION_GOTO:
+			if (!fa->chain_index) {
+				NL_SET_ERR_MSG_MOD(extack, "Can't goto chain 0, no looping in hw");
+				return -EOPNOTSUPP;
+			}
+			rid = efx_tc_get_recirc_id(efx, fa->chain_index,
+						   net_dev);
+			if (IS_ERR(rid)) {
+				NL_SET_ERR_MSG_MOD(extack, "Failed to allocate a hardware recirculation ID for this chain_index");
+				return PTR_ERR(rid);
+			}
+			act->rid = rid;
+			if (fa->hw_stats) {
+				struct efx_tc_counter_index *cnt;
+
+				if (!(fa->hw_stats & FLOW_ACTION_HW_STATS_DELAYED)) {
+					NL_SET_ERR_MSG_FMT_MOD(extack,
+							       "hw_stats_type %u not supported (only 'delayed')",
+							       fa->hw_stats);
+					return -EOPNOTSUPP;
+				}
+				cnt = efx_tc_flower_get_counter_index(efx, tc->cookie,
+								      EFX_TC_COUNTER_TYPE_OR);
+				if (IS_ERR(cnt)) {
+					NL_SET_ERR_MSG_MOD(extack, "Failed to obtain a counter");
+					return PTR_ERR(cnt);
+				}
+				WARN_ON(act->count); /* can't happen */
+				act->count = cnt;
+			}
+			pipe = false;
+			break;
+		case FLOW_ACTION_CT:
+			if (act->zone) {
+				NL_SET_ERR_MSG_MOD(extack, "Can't offload multiple ct actions");
+				return -EOPNOTSUPP;
+			}
+			if (fa->ct.action & (TCA_CT_ACT_COMMIT |
+					     TCA_CT_ACT_FORCE)) {
+				NL_SET_ERR_MSG_MOD(extack, "Can't offload ct commit/force");
+				return -EOPNOTSUPP;
+			}
+			if (fa->ct.action & TCA_CT_ACT_CLEAR) {
+				NL_SET_ERR_MSG_MOD(extack, "Can't clear ct in LHS rule");
+				return -EOPNOTSUPP;
+			}
+			if (fa->ct.action & (TCA_CT_ACT_NAT |
+					     TCA_CT_ACT_NAT_SRC |
+					     TCA_CT_ACT_NAT_DST)) {
+				NL_SET_ERR_MSG_MOD(extack, "Can't perform NAT in LHS rule - packet isn't conntracked yet");
+				return -EOPNOTSUPP;
+			}
+			if (fa->ct.action) {
+				NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled ct.action %u for LHS rule\n",
+						       fa->ct.action);
+				return -EOPNOTSUPP;
+			}
+			ct_zone = efx_tc_ct_register_zone(efx, fa->ct.zone,
+							  fa->ct.flow_table);
+			if (IS_ERR(ct_zone)) {
+				NL_SET_ERR_MSG_MOD(extack, "Failed to register for CT updates");
+				return PTR_ERR(ct_zone);
+			}
+			act->zone = ct_zone;
+			break;
+		default:
+			NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled action %u for LHS rule\n",
+					       fa->id);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (pipe) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing goto chain in LHS rule");
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static void efx_tc_flower_release_lhs_actions(struct efx_nic *efx,
+					      struct efx_tc_lhs_action *act)
+{
+	if (act->rid)
+		efx_tc_put_recirc_id(efx, act->rid);
+	if (act->zone)
+		efx_tc_ct_unregister_zone(efx, act->zone);
+	if (act->count)
+		efx_tc_flower_put_counter_index(efx, act->count);
+}
+
 static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 					 struct net_device *net_dev,
 					 struct flow_cls_offload *tc)
@@ -1050,6 +1213,78 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	return rc;
 }
 
+static int efx_tc_flower_replace_lhs(struct efx_nic *efx,
+				     struct flow_cls_offload *tc,
+				     struct flow_rule *fr,
+				     struct efx_tc_match *match,
+				     struct efx_rep *efv,
+				     struct net_device *net_dev)
+{
+	struct netlink_ext_ack *extack = tc->common.extack;
+	struct efx_tc_lhs_rule *rule, *old;
+	int rc;
+
+	if (tc->common.chain_index) {
+		NL_SET_ERR_MSG_MOD(extack, "LHS rule only allowed in chain 0");
+		return -EOPNOTSUPP;
+	}
+
+	if (match->mask.ct_state_trk && match->value.ct_state_trk) {
+		NL_SET_ERR_MSG_MOD(extack, "LHS rule can never match +trk");
+		return -EOPNOTSUPP;
+	}
+	/* LHS rules are always -trk, so we don't need to match on that */
+	match->mask.ct_state_trk = 0;
+	match->value.ct_state_trk = 0;
+
+	rc = efx_mae_match_check_caps_lhs(efx, &match->mask, extack);
+	if (rc)
+		return rc;
+
+	rule = kzalloc(sizeof(*rule), GFP_USER);
+	if (!rule)
+		return -ENOMEM;
+	rule->cookie = tc->cookie;
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
+	/* See note in efx_tc_flower_replace() regarding passed net_dev
+	 * (used for efx_tc_get_recirc_id()).
+	 */
+	rc = efx_tc_flower_handle_lhs_actions(efx, tc, fr, efx->net_dev, rule);
+	if (rc)
+		goto release;
+
+	rule->match = *match;
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
+	return rc;
+}
+
 static int efx_tc_flower_replace(struct efx_nic *efx,
 				 struct net_device *net_dev,
 				 struct flow_cls_offload *tc,
@@ -1105,6 +1340,10 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 		return -EOPNOTSUPP;
 	}
 
+	if (efx_tc_rule_is_lhs_rule(fr, &match))
+		return efx_tc_flower_replace_lhs(efx, tc, fr, &match, efv,
+						 net_dev);
+
 	/* chain_index 0 is always recirc_id 0 (and does not appear in recirc_ht).
 	 * Conveniently, match.rid == NULL and match.value.recirc_id == 0 owing
 	 * to the initial memset(), so we don't need to do anything in that case.
@@ -1512,8 +1751,26 @@ static int efx_tc_flower_destroy(struct efx_nic *efx,
 				 struct flow_cls_offload *tc)
 {
 	struct netlink_ext_ack *extack = tc->common.extack;
+	struct efx_tc_lhs_rule *lhs_rule;
 	struct efx_tc_flow_rule *rule;
 
+	lhs_rule = rhashtable_lookup_fast(&efx->tc->lhs_rule_ht, &tc->cookie,
+					  efx_tc_lhs_rule_ht_params);
+	if (lhs_rule) {
+		/* Remove it from HW */
+		efx_mae_remove_lhs_rule(efx, lhs_rule);
+		/* Delete it from SW */
+		efx_tc_flower_release_lhs_actions(efx, &lhs_rule->lhs_act);
+		rhashtable_remove_fast(&efx->tc->lhs_rule_ht, &lhs_rule->linkage,
+				       efx_tc_lhs_rule_ht_params);
+		if (lhs_rule->match.encap)
+			efx_tc_flower_release_encap_match(efx, lhs_rule->match.encap);
+		netif_dbg(efx, drv, efx->net_dev, "Removed (lhs) filter %lx\n",
+			  lhs_rule->cookie);
+		kfree(lhs_rule);
+		return 0;
+	}
+
 	rule = rhashtable_lookup_fast(&efx->tc->match_action_ht, &tc->cookie,
 				      efx_tc_match_action_ht_params);
 	if (!rule) {
@@ -1880,6 +2137,24 @@ static void efx_tc_recirc_free(void *ptr, void *arg)
 	kfree(rid);
 }
 
+static void efx_tc_lhs_free(void *ptr, void *arg)
+{
+	struct efx_tc_lhs_rule *rule = ptr;
+	struct efx_nic *efx = arg;
+
+	netif_err(efx, drv, efx->net_dev,
+		  "tc lhs_rule %lx still present at teardown, removing\n",
+		  rule->cookie);
+
+	if (rule->lhs_act.zone)
+		efx_tc_ct_unregister_zone(efx, rule->lhs_act.zone);
+	if (rule->lhs_act.count)
+		efx_tc_flower_put_counter_index(efx, rule->lhs_act.count);
+	efx_mae_remove_lhs_rule(efx, rule);
+
+	kfree(rule);
+}
+
 static void efx_tc_flow_free(void *ptr, void *arg)
 {
 	struct efx_tc_flow_rule *rule = ptr;
@@ -1926,6 +2201,9 @@ int efx_init_struct_tc(struct efx_nic *efx)
 	rc = rhashtable_init(&efx->tc->match_action_ht, &efx_tc_match_action_ht_params);
 	if (rc < 0)
 		goto fail_match_action_ht;
+	rc = rhashtable_init(&efx->tc->lhs_rule_ht, &efx_tc_lhs_rule_ht_params);
+	if (rc < 0)
+		goto fail_lhs_rule_ht;
 	rc = efx_tc_init_conntrack(efx);
 	if (rc < 0)
 		goto fail_conntrack;
@@ -1948,6 +2226,8 @@ int efx_init_struct_tc(struct efx_nic *efx)
 fail_recirc_ht:
 	efx_tc_destroy_conntrack(efx);
 fail_conntrack:
+	rhashtable_destroy(&efx->tc->lhs_rule_ht);
+fail_lhs_rule_ht:
 	rhashtable_destroy(&efx->tc->match_action_ht);
 fail_match_action_ht:
 	rhashtable_destroy(&efx->tc->encap_match_ht);
@@ -1978,6 +2258,7 @@ void efx_fini_struct_tc(struct efx_nic *efx)
 			     MC_CMD_MAE_ACTION_SET_LIST_ALLOC_OUT_ACTION_SET_LIST_ID_NULL);
 	EFX_WARN_ON_PARANOID(efx->tc->facts.reps.fw_id !=
 			     MC_CMD_MAE_ACTION_SET_LIST_ALLOC_OUT_ACTION_SET_LIST_ID_NULL);
+	rhashtable_free_and_destroy(&efx->tc->lhs_rule_ht, efx_tc_lhs_free, efx);
 	rhashtable_free_and_destroy(&efx->tc->match_action_ht, efx_tc_flow_free,
 				    efx);
 	rhashtable_free_and_destroy(&efx->tc->encap_match_ht,
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index ce8e30743a3a..40d2c803fca8 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -140,6 +140,12 @@ struct efx_tc_action_set_list {
 	u32 fw_id;
 };
 
+struct efx_tc_lhs_action {
+	struct efx_tc_recirc_id *rid;
+	struct efx_tc_ct_zone *zone;
+	struct efx_tc_counter_index *count;
+};
+
 struct efx_tc_flow_rule {
 	unsigned long cookie;
 	struct rhash_head linkage;
@@ -149,6 +155,14 @@ struct efx_tc_flow_rule {
 	u32 fw_id;
 };
 
+struct efx_tc_lhs_rule {
+	unsigned long cookie;
+	struct efx_tc_match match;
+	struct efx_tc_lhs_action lhs_act;
+	struct rhash_head linkage;
+	u32 fw_id;
+};
+
 enum efx_tc_rule_prios {
 	EFX_TC_PRIO_TC, /* Rule inserted by TC */
 	EFX_TC_PRIO_DFLT, /* Default switch rule; one of efx_tc_default_rules */
@@ -208,6 +222,7 @@ struct efx_tc_table_ct { /* TABLE_ID_CONNTRACK_TABLE */
  * @encap_ht: Hashtable of TC encap actions
  * @encap_match_ht: Hashtable of TC encap matches
  * @match_action_ht: Hashtable of TC match-action rules
+ * @lhs_rule_ht: Hashtable of TC left-hand (act ct & goto chain) rules
  * @ct_zone_ht: Hashtable of TC conntrack flowtable bindings
  * @ct_ht: Hashtable of TC conntrack flow entries
  * @neigh_ht: Hashtable of neighbour watches (&struct efx_neigh_binder)
@@ -244,6 +259,7 @@ struct efx_tc_state {
 	struct rhashtable encap_ht;
 	struct rhashtable encap_match_ht;
 	struct rhashtable match_action_ht;
+	struct rhashtable lhs_rule_ht;
 	struct rhashtable ct_zone_ht;
 	struct rhashtable ct_ht;
 	struct rhashtable neigh_ht;

