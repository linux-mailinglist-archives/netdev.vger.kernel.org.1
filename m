Return-Path: <netdev+bounces-37455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29A7B56DB
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 629C32816E5
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF81D52C;
	Mon,  2 Oct 2023 15:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8E1CFB0
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:45:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C36FB3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyGU7fVcALIVFNjF8jQYC1RScUJaayxsRWvtD3bdnzXq43qPZ3VC8T87wy2HvAd0ZeKWKLvBnYdVLKnDcudD9FnyZuBq/r1zLHHEQn+qS5ZuVOU0kYWuNoLKl6hRlju8TvUO3MtRM16U0xdarckubktEUnsr9UWHoAbcoCM/onNi4LvYJ+JaTFpBzllsZPKWc6ATmKYe329tLwY1P2n8LxvNdNyGZinD5tH6oa0uTlE1reh2id+tIGrR2t9/DCmSzPk2FTtHbTEpJymaraDOhQSod4/SNWNHMQ6/xuiq/0ojf78MHRU9nQvbjlXB8nB1ypg5VsLVnriBHqM8x7ARMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1geHowjXj6Lv22Qa2lehK62n7AKj++XdpsW9aNWzcBQ=;
 b=gi/CAn9nSR51c70XK9U2CBszpWdyyuogHAySw//XV0glrkH/caJxLcVlBaRUyI1xanpz4jQPMYjHzJnXI8/zvn2MHkN+d5qNOc7wtBZLDTQwoQmvqNVXs+AcGdCorWnkrIlDn91OykI9K4eJUQKtbmP5kRpJFKfcUNH2RIyZA5j97KYVrlDl7/Wkz8VrjpVhfbEJyWCbGMj33Vg4TXtSmUmaN7RniFm5DYiq7tBgilFR49G/o7XzPpsrxnxUfM3FNgP8hVg4sMRh/f1iU3l6MhF20tmDq0mWXSia8SBRs1npO3Di3xi9c9MrS3kXIoiQtnbHQBQvBmDnUz8hUXC8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1geHowjXj6Lv22Qa2lehK62n7AKj++XdpsW9aNWzcBQ=;
 b=nCeK70wWoVJfsKEdq44yxtIeWDhmex0UTfBzjJY8CGGegVbNdvADWeC90OJzy2Z16XK2qFI1xskZd1Tx0IBN/9m5AOSX+ObQR2pMYVSKIZqVjoLG4RvfKoefn1xANsLHGEr52vHT7LC72BHJ/apILem1CiF25aR3KA5qoYu4MT8=
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 15:45:47 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::c8) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29 via Frontend
 Transport; Mon, 2 Oct 2023 15:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 15:45:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:44 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 10:45:24 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 1/4] sfc: support TC left-hand-side rules on foreign netdevs
Date: Mon, 2 Oct 2023 16:44:41 +0100
Message-ID: <890f07cf815ae31e7cd5b37cafb72801791f1c75.1696261222.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: a241344f-3063-446b-0083-08dbc35ea4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yhXSCCCiH8DthMMA619UaxTUVb/Ij5X/SK6ietYZ0AwbNLbtEYHrbUx/SSFfgyWO4Zxu45lztf0w/ESSzLrGoNrB2ZQ81IAMhztmqh97p3u0ly479mPctQHDyBX+x3wqxFvxcDi7IeGEDvsIJ3xnU/7laCWbbjpfweYvdDRZsU3RUgW32ZsqCpxOGgS9hMzHfg7k5IE2mjYtLUye9+W3IFoX+WABSzgI/d0bqoK+1jHHE+29wNjsgHeLt9RoV3c9YMLpmIOnpKLBx1VpRZlwzhAq4IfqXjvNXleeuMUJaPLlI1yodWD7Dbg+Ow3/QAh5UB0adbWWIsmyUx5tfOzE8lP6P/uIoNXq7B2/ef5S6Eh99vj6kjpMa04nm7XrdnwC3iaGRCAejiReDKu8TuZ3IccWISfC7Qecen7AMX1ucMfTRxerVYMGRCFWu70IJBCRBTjwCjCshUxiTHmP4OnqXeLfJ97tITrs+OsgDQxewtP0DQyt0Ku6xZvBmWRXPgf2HzYGmVHyzpbEq4suuC1i0fKhl04KoGAzt44yncNwlzo16QECizd8gw4ZRLSaMyEtLYR9ttr2mCrDzHtfhZdC0Uv/to1jtUMvIbpileXoLDi6N0y32R5uxhUYk29Mmwl4FGlxIwMHWpHxdVUdFrEDyp752b1F9uGJuHmvdBNs3+kBtz1YLid3Dm265vEclY3xXJHZ/2xS178ZUsyMM5vuc4ZnUIl0dfWDp/CRD4wMQgwJOV3nt/kA6ys0FMnf8TFDZE8OPDZBCl+yciKRo12Nug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(26005)(70206006)(70586007)(110136005)(30864003)(2906002)(2876002)(8676002)(4326008)(5660300002)(316002)(54906003)(8936002)(41300700001)(9686003)(478600001)(6666004)(36860700001)(336012)(426003)(83380400001)(47076005)(82740400003)(81166007)(356005)(40460700003)(40480700001)(55446002)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:45:46.3366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a241344f-3063-446b-0083-08dbc35ea4ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Allow a tunnel netdevice (such as a vxlan) to offload conntrack lookups,
 in much the same way as efx netdevs.
To ensure this rule does not overlap with other tunnel rules on the same
 sip,dip,dport tuple, register a pseudo encap match of a new type
 (EFX_TC_EM_PSEUDO_OR), which unlike PSEUDO_MASK may only be referenced
 once (because an actual Outer Rule in hardware exists, although its
 fw_id is not recorded in the encap match entry).

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mae.c |   6 +-
 drivers/net/ethernet/sfc/tc.c  | 213 +++++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc.h  |   5 +
 3 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index c3e2b4a21d10..d1c8872efac9 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1705,8 +1705,10 @@ static int efx_mae_insert_lhs_outer_rule(struct efx_nic *efx,
 
 	/* action */
 	act = &rule->lhs_act;
-	MCDI_SET_DWORD(inbuf, MAE_OUTER_RULE_INSERT_IN_ENCAP_TYPE,
-		       MAE_MCDI_ENCAP_TYPE_NONE);
+	rc = efx_mae_encap_type_to_mae_type(act->tun_type);
+	if (rc < 0)
+		return rc;
+	MCDI_SET_DWORD(inbuf, MAE_OUTER_RULE_INSERT_IN_ENCAP_TYPE, rc);
 	/* We always inhibit CT lookup on TCP_INTERESTING_FLAGS, since the
 	 * SW path needs to process the packet to update the conntrack tables
 	 * on connection establishment (SYN) or termination (FIN, RST).
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 834f000ba1c4..257bec75e952 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -642,6 +642,15 @@ static int efx_tc_flower_record_encap_match(struct efx_nic *efx,
 				return -EEXIST;
 			}
 			break;
+		case EFX_TC_EM_PSEUDO_OR:
+			/* old EM corresponds to an OR that has to be unique
+			 * (it must not overlap with any other OR, whether
+			 * direct-EM or pseudo).
+			 */
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "%s encap match conflicts with existing pseudo(OR) entry",
+					       em_type ? "Pseudo" : "Direct");
+			return -EEXIST;
 		default: /* Unrecognised pseudo-type.  Just say no */
 			NL_SET_ERR_MSG_FMT_MOD(extack,
 					       "%s encap match conflicts with existing pseudo(%d) entry",
@@ -872,6 +881,93 @@ static bool efx_tc_rule_is_lhs_rule(struct flow_rule *fr,
 	return false;
 }
 
+/* A foreign LHS rule has matches on enc_ keys at the TC layer (including an
+ * implied match on enc_ip_proto UDP).  Translate these into non-enc_ keys,
+ * so that we can use the same MAE machinery as local LHS rules (and so that
+ * the lhs_rules entries have uniform semantics).  It may seem odd to do it
+ * this way round, given that the corresponding fields in the MAE MCDIs are
+ * all ENC_, but (a) we don't have enc_L2 or enc_ip_proto in struct
+ * efx_tc_match_fields and (b) semantically an LHS rule doesn't have inner
+ * fields so it's just matching on *the* header rather than the outer header.
+ * Make sure that the non-enc_ keys were not already being matched on, as that
+ * would imply a rule that needed a triple lookup.  (Hardware can do that,
+ * with OR-AR-CT-AR, but it halves packet rate so we avoid it where possible;
+ * see efx_tc_flower_flhs_needs_ar().)
+ */
+static int efx_tc_flower_translate_flhs_match(struct efx_tc_match *match)
+{
+	int rc = 0;
+
+#define COPY_MASK_AND_VALUE(_key, _ekey)	({	\
+	if (match->mask._key) {				\
+		rc = -EOPNOTSUPP;			\
+	} else {					\
+		match->mask._key = match->mask._ekey;	\
+		match->mask._ekey = 0;			\
+		match->value._key = match->value._ekey;	\
+		match->value._ekey = 0;			\
+	}						\
+	rc;						\
+})
+#define COPY_FROM_ENC(_key)	COPY_MASK_AND_VALUE(_key, enc_##_key)
+	if (match->mask.ip_proto)
+		return -EOPNOTSUPP;
+	match->mask.ip_proto = ~0;
+	match->value.ip_proto = IPPROTO_UDP;
+	if (COPY_FROM_ENC(src_ip) || COPY_FROM_ENC(dst_ip))
+		return rc;
+#ifdef CONFIG_IPV6
+	if (!ipv6_addr_any(&match->mask.src_ip6))
+		return -EOPNOTSUPP;
+	match->mask.src_ip6 = match->mask.enc_src_ip6;
+	memset(&match->mask.enc_src_ip6, 0, sizeof(struct in6_addr));
+	if (!ipv6_addr_any(&match->mask.dst_ip6))
+		return -EOPNOTSUPP;
+	match->mask.dst_ip6 = match->mask.enc_dst_ip6;
+	memset(&match->mask.enc_dst_ip6, 0, sizeof(struct in6_addr));
+#endif
+	if (COPY_FROM_ENC(ip_tos) || COPY_FROM_ENC(ip_ttl))
+		return rc;
+	/* should really copy enc_ip_frag but we don't have that in
+	 * parse_match yet
+	 */
+	if (COPY_MASK_AND_VALUE(l4_sport, enc_sport) ||
+	    COPY_MASK_AND_VALUE(l4_dport, enc_dport))
+		return rc;
+	return 0;
+#undef COPY_FROM_ENC
+#undef COPY_MASK_AND_VALUE
+}
+
+/* If a foreign LHS rule wants to match on keys that are only available after
+ * encap header identification and parsing, then it can't be done in the Outer
+ * Rule lookup, because that lookup determines the encap type used to parse
+ * beyond the outer headers.  Thus, such rules must use the OR-AR-CT-AR lookup
+ * sequence, with an EM (struct efx_tc_encap_match) in the OR step.
+ * Return true iff the passed match requires this.
+ */
+static bool efx_tc_flower_flhs_needs_ar(struct efx_tc_match *match)
+{
+	/* matches on inner-header keys can't be done in OR */
+	return match->mask.eth_proto ||
+	       match->mask.vlan_tci[0] || match->mask.vlan_tci[1] ||
+	       match->mask.vlan_proto[0] || match->mask.vlan_proto[1] ||
+	       memchr_inv(match->mask.eth_saddr, 0, ETH_ALEN) ||
+	       memchr_inv(match->mask.eth_daddr, 0, ETH_ALEN) ||
+	       match->mask.ip_proto ||
+	       match->mask.ip_tos || match->mask.ip_ttl ||
+	       match->mask.src_ip || match->mask.dst_ip ||
+#ifdef CONFIG_IPV6
+	       !ipv6_addr_any(&match->mask.src_ip6) ||
+	       !ipv6_addr_any(&match->mask.dst_ip6) ||
+#endif
+	       match->mask.ip_frag || match->mask.ip_firstfrag ||
+	       match->mask.l4_sport || match->mask.l4_dport ||
+	       match->mask.tcp_flags ||
+	/* nor can VNI */
+	       match->mask.enc_keyid;
+}
+
 static int efx_tc_flower_handle_lhs_actions(struct efx_nic *efx,
 					    struct flow_cls_offload *tc,
 					    struct flow_rule *fr,
@@ -1354,6 +1450,119 @@ static int efx_tc_incomplete_mangle(struct efx_tc_mangler_state *mung,
 	return 0;
 }
 
+static int efx_tc_flower_replace_foreign_lhs(struct efx_nic *efx,
+					     struct flow_cls_offload *tc,
+					     struct flow_rule *fr,
+					     struct efx_tc_match *match,
+					     struct net_device *net_dev)
+{
+	struct netlink_ext_ack *extack = tc->common.extack;
+	struct efx_tc_lhs_rule *rule, *old;
+	enum efx_encap_type type;
+	int rc;
+
+	if (tc->common.chain_index) {
+		NL_SET_ERR_MSG_MOD(extack, "LHS rule only allowed in chain 0");
+		return -EOPNOTSUPP;
+	}
+
+	if (!efx_tc_match_is_encap(&match->mask)) {
+		/* This is not a tunnel decap rule, ignore it */
+		netif_dbg(efx, drv, efx->net_dev, "Ignoring foreign LHS filter without encap match\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (efx_tc_flower_flhs_needs_ar(match)) {
+		NL_SET_ERR_MSG_MOD(extack, "Match keys not available in Outer Rule");
+		return -EOPNOTSUPP;
+	}
+
+	type = efx_tc_indr_netdev_type(net_dev);
+	if (type == EFX_ENCAP_TYPE_NONE) {
+		NL_SET_ERR_MSG_MOD(extack, "Egress encap match on unsupported tunnel device\n");
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
+	/* Reserve the outer tuple with a pseudo Encap Match */
+	rc = efx_tc_flower_record_encap_match(efx, match, type,
+					      EFX_TC_EM_PSEUDO_OR, 0, 0,
+					      extack);
+	if (rc)
+		return rc;
+
+	if (match->mask.ct_state_trk && match->value.ct_state_trk) {
+		NL_SET_ERR_MSG_MOD(extack, "LHS rule can never match +trk");
+		rc = -EOPNOTSUPP;
+		goto release_encap_match;
+	}
+	/* LHS rules are always -trk, so we don't need to match on that */
+	match->mask.ct_state_trk = 0;
+	match->value.ct_state_trk = 0;
+
+	rc = efx_tc_flower_translate_flhs_match(match);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "LHS rule cannot match on inner fields");
+		goto release_encap_match;
+	}
+
+	rc = efx_mae_match_check_caps_lhs(efx, &match->mask, extack);
+	if (rc)
+		goto release_encap_match;
+
+	rule = kzalloc(sizeof(*rule), GFP_USER);
+	if (!rule) {
+		rc = -ENOMEM;
+		goto release_encap_match;
+	}
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
 static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 					 struct net_device *net_dev,
 					 struct flow_cls_offload *tc)
@@ -1387,6 +1596,10 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	match.value.ingress_port = rc;
 	match.mask.ingress_port = ~0;
 
+	if (efx_tc_rule_is_lhs_rule(fr, &match))
+		return efx_tc_flower_replace_foreign_lhs(efx, tc, fr, &match,
+							 net_dev);
+
 	if (tc->common.chain_index) {
 		struct efx_tc_recirc_id *rid;
 
diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index 4dd2c378fd9f..c4cb52dda057 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -140,10 +140,14 @@ static inline bool efx_tc_match_is_encap(const struct efx_tc_match_fields *mask)
  *	The pseudo encap match may be referenced again by an encap match
  *	with different values for these fields, but all masks must match the
  *	first (stored in our child_* fields).
+ * @EFX_TC_EM_PSEUDO_OR: registered by an fLHS rule that fits in the OR
+ *	table.  The &struct efx_tc_lhs_rule already holds the HW OR entry.
+ *	Only one reference to this encap match may exist.
  */
 enum efx_tc_em_pseudo_type {
 	EFX_TC_EM_DIRECT,
 	EFX_TC_EM_PSEUDO_MASK,
+	EFX_TC_EM_PSEUDO_OR,
 };
 
 struct efx_tc_encap_match {
@@ -183,6 +187,7 @@ struct efx_tc_action_set_list {
 };
 
 struct efx_tc_lhs_action {
+	enum efx_encap_type tun_type;
 	struct efx_tc_recirc_id *rid;
 	struct efx_tc_ct_zone *zone;
 	struct efx_tc_counter_index *count;

