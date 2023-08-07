Return-Path: <netdev+bounces-24979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BCD77268C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C5D280EB3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138B10961;
	Mon,  7 Aug 2023 13:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACD1118A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:49:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767741986
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkyaDDsQmCc5CmbIeMLzuUgnmBplmRxrt8qr0uB0ZAwQmGCb8MdByt7AQfI84JL98h+u2GmfVYxkny+/GmrYxYhGuWLQu/KynhK80SLPMvEmt2Qx/o1aL7d+NuZOgLk54y71gN4XwDzYFjMQPUR9uMDR2z4TILiZgHP+5z7jkFYzRzdFbcwkGRClLtDGoudc+2aKxWoRb3uPRqOGpIyRwadPgfWPmIK18UgURssNWJtD7bIZO7/MVrxa+xz8cEZwzGnd2VlvoRkUSgSsy97mgXrqpJIDF6rhuZ7JKymtlMiar754W45uDC2G1aUZ2KJDPDGBZvuSE1I26S8L/X0Fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu8G0d8tSwX/rsnk3H8nmzZYXRBFvNyVJrHl9sgi1/0=;
 b=fA/XNn70gaWp7VshyK2ew8lflm8GM3ha+M+9icOnifTgJth+BihlU/UsEQI789hyfQZFVPs+7sJx9XqeRl5Nch5HYgUI96iliWF/irokah5z3aAAMGtCGS+YdgHpX86NCOu5z2L3Ne1UHaM/9Y5mqmNLn17WQcm4PEFmZzFUeSKL78Baj9ib1nfbLUX231I83cKWfZNM5cPVM4yH3yefaR9UNwF2BP5VKeGqBKAber8mgXoSOWqTolXP0kMdDwppqulyBjOtWQ39jjysEfWK/E+WI9ZIyf8zeFbhGTFSICA0PVohP4ouHNC042A8U9LafTUIstaiKljhIzlzuzHCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu8G0d8tSwX/rsnk3H8nmzZYXRBFvNyVJrHl9sgi1/0=;
 b=uRO+AsCiAci5dZbGwds0uK7xFBP25GiFRTnV0GApIlJb7z8WowlyMCQ0E1Hv8Bow1df9Jc1Fr9g4DuwY4S7dudYN++LTIzggLUFih/YIhp2pcBdkDslqzlRXymxh065hxzOVD1a5RG7ej10AcgBaFHUsaMq4p/A2oaFZf4WJfQg=
Received: from CYZPR19CA0021.namprd19.prod.outlook.com (2603:10b6:930:8e::22)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 13:49:17 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:8e:cafe::35) by CYZPR19CA0021.outlook.office365.com
 (2603:10b6:930:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 13:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 13:49:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:49:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:49:18 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 08:49:16 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 4/7] sfc: offload conntrack flow entries (match only) from CT zones
Date: Mon, 7 Aug 2023 14:48:08 +0100
Message-ID: <a7fbb8663b3e546d2d9b375f13581dcccdaa02d5.1691415479.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 8120f9cd-cb4c-4227-ab82-08db974d19e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iQrlJ8ABSFlMQAypfpJoq0yLVY+KomnDNB49Kqmvy0NsCbEdf/u/2x7rhXMFG46pxZ55KDT9r9K9lyUFjmoskpsTwMaUIBi1AdEozDr3WNnY4D7YXhAQeeqqJaT22brJUszgCHkTIhhM8mDOyB0iTPIiYIiByQBWqEu2G5gQGS5zRmAQ77kUiN1MeXOfNkOwd0ZQ3tVGpsIm5Q9j9scmz42N91DJJxXVSPemVc+Q+Di3O1J4viSOoriAef8uZHuCt10o3aycHWgwPr7YYFU5u3u2fvNr8RKQCbobCaHV5ImEDoG1eAQR4YpJxJ6i3BdIIWiVGFUWCewyVgWUIusO8mUoI63+t/YSGRmwrTLv3Y0u++YQOyHx1JP5ey4dCGfyYsgazjZI6Dc6WAGcUSJlhCM0J5TU+TIS8VtlJWo6Wm9fMxsOdpJbNdSv8pKq3NXwaqvcAZVKxg1LAY4jSWVW3O/9uQoS5GTYGO7GbJ406g5/pwBbot2+xof5D5LV7CDcD1hGyHzDjRRHmg/6qsqq5VxzbKL/IB4p9fJgKc/1HphNd2SQU5NcndxC4p/bc/TJkKYRlvuYMa5VxUcsYale5FmMzhs3MnQJCY+aqAuIXnq1S9XryWdkPDH2cJqvyJxcP+pZQFd158XPRH8qRwHYsuSTMWjZmNGldfPqm3EtG9o3LV4UcN9u1fpPqWfJ9B2BGxiNWuuTSxI2QDEIQLLhwtlvoAxUiWVcA1lsfblDCg31qPbnoQUlbDlUgWMHNjK+V3BKVGra5wvcFqqhGOCpwQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(82310400008)(186006)(1800799003)(40470700004)(46966006)(36840700001)(40480700001)(336012)(40460700003)(36756003)(4326008)(9686003)(316002)(86362001)(81166007)(478600001)(55446002)(110136005)(54906003)(356005)(70206006)(6666004)(70586007)(82740400003)(41300700001)(26005)(426003)(8676002)(8936002)(47076005)(36860700001)(2876002)(2906002)(30864003)(83380400001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 13:49:20.4393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8120f9cd-cb4c-4227-ab82-08db974d19e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

No handling yet for FLOW_ACTION_MANGLE (NAT or NAPT) actions.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc.h           |   4 +-
 drivers/net/ethernet/sfc/tc_conntrack.c | 417 +++++++++++++++++++++++-
 drivers/net/ethernet/sfc/tc_conntrack.h |   3 +
 drivers/net/ethernet/sfc/tc_counters.c  |   8 +-
 drivers/net/ethernet/sfc/tc_counters.h  |   4 +
 5 files changed, 429 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.h b/drivers/net/ethernet/sfc/tc.h
index fc196eb897af..2aba9ca00618 100644
--- a/drivers/net/ethernet/sfc/tc.h
+++ b/drivers/net/ethernet/sfc/tc.h
@@ -18,12 +18,10 @@
 
 #define IS_ALL_ONES(v)	(!(typeof (v))~(v))
 
-#ifdef CONFIG_IPV6
 static inline bool efx_ipv6_addr_all_ones(struct in6_addr *addr)
 {
 	return !memchr_inv(addr, 0xff, sizeof(*addr));
 }
-#endif
 
 struct efx_tc_encap_action; /* see tc_encap_actions.h */
 
@@ -197,6 +195,7 @@ struct efx_tc_table_ct { /* TABLE_ID_CONNTRACK_TABLE */
  * @encap_match_ht: Hashtable of TC encap matches
  * @match_action_ht: Hashtable of TC match-action rules
  * @ct_zone_ht: Hashtable of TC conntrack flowtable bindings
+ * @ct_ht: Hashtable of TC conntrack flow entries
  * @neigh_ht: Hashtable of neighbour watches (&struct efx_neigh_binder)
  * @meta_ct: MAE table layout for conntrack table
  * @reps_mport_id: MAE port allocated for representor RX
@@ -230,6 +229,7 @@ struct efx_tc_state {
 	struct rhashtable encap_match_ht;
 	struct rhashtable match_action_ht;
 	struct rhashtable ct_zone_ht;
+	struct rhashtable ct_ht;
 	struct rhashtable neigh_ht;
 	struct efx_tc_table_ct meta_ct;
 	u32 reps_mport_id, reps_mport_vport_id;
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
index d67302715ec3..6729b3796a8b 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.c
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -21,6 +21,12 @@ static const struct rhashtable_params efx_tc_ct_zone_ht_params = {
 	.head_offset	= offsetof(struct efx_tc_ct_zone, linkage),
 };
 
+static const struct rhashtable_params efx_tc_ct_ht_params = {
+	.key_len	= offsetof(struct efx_tc_ct_entry, linkage),
+	.key_offset	= 0,
+	.head_offset	= offsetof(struct efx_tc_ct_entry, linkage),
+};
+
 static void efx_tc_ct_zone_free(void *ptr, void *arg)
 {
 	struct efx_tc_ct_zone *zone = ptr;
@@ -34,24 +40,420 @@ static void efx_tc_ct_zone_free(void *ptr, void *arg)
 	kfree(zone);
 }
 
+static void efx_tc_ct_free(void *ptr, void *arg)
+{
+	struct efx_tc_ct_entry *conn = ptr;
+	struct efx_nic *efx = arg;
+
+	netif_err(efx, drv, efx->net_dev,
+		  "tc ct_entry %lx still present at teardown\n",
+		  conn->cookie);
+
+	/* We can release the counter, but we can't remove the CT itself
+	 * from hardware because the table meta is already gone.
+	 */
+	efx_tc_flower_release_counter(efx, conn->cnt);
+	kfree(conn);
+}
+
 int efx_tc_init_conntrack(struct efx_nic *efx)
 {
 	int rc;
 
 	rc = rhashtable_init(&efx->tc->ct_zone_ht, &efx_tc_ct_zone_ht_params);
 	if (rc < 0)
-		return rc;
+		goto fail_ct_zone_ht;
+	rc = rhashtable_init(&efx->tc->ct_ht, &efx_tc_ct_ht_params);
+	if (rc < 0)
+		goto fail_ct_ht;
 	return 0;
+fail_ct_ht:
+	rhashtable_destroy(&efx->tc->ct_zone_ht);
+fail_ct_zone_ht:
+	return rc;
 }
 
 void efx_tc_fini_conntrack(struct efx_nic *efx)
 {
 	rhashtable_free_and_destroy(&efx->tc->ct_zone_ht, efx_tc_ct_zone_free, NULL);
+	rhashtable_free_and_destroy(&efx->tc->ct_ht, efx_tc_ct_free, efx);
+}
+
+#define EFX_NF_TCP_FLAG(flg)	cpu_to_be16(be32_to_cpu(TCP_FLAG_##flg) >> 16)
+
+static int efx_tc_ct_parse_match(struct efx_nic *efx, struct flow_rule *fr,
+				 struct efx_tc_ct_entry *conn)
+{
+	struct flow_dissector *dissector = fr->match.dissector;
+	unsigned char ipv = 0;
+	bool tcp = false;
+
+	if (flow_rule_match_key(fr, FLOW_DISSECTOR_KEY_CONTROL)) {
+		struct flow_match_control fm;
+
+		flow_rule_match_control(fr, &fm);
+		if (IS_ALL_ONES(fm.mask->addr_type))
+			switch (fm.key->addr_type) {
+			case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
+				ipv = 4;
+				break;
+			case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
+				ipv = 6;
+				break;
+			default:
+				break;
+			}
+	}
+
+	if (!ipv) {
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Conntrack missing ipv specification\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (dissector->used_keys &
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_META))) {
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Unsupported conntrack keys %#llx\n",
+			  dissector->used_keys);
+		return -EOPNOTSUPP;
+	}
+
+	if (flow_rule_match_key(fr, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic fm;
+
+		flow_rule_match_basic(fr, &fm);
+		if (!IS_ALL_ONES(fm.mask->n_proto)) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack eth_proto is not exact-match; mask %04x\n",
+				   ntohs(fm.mask->n_proto));
+			return -EOPNOTSUPP;
+		}
+		conn->eth_proto = fm.key->n_proto;
+		if (conn->eth_proto != (ipv == 4 ? htons(ETH_P_IP)
+						 : htons(ETH_P_IPV6))) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack eth_proto is not IPv%u, is %04x\n",
+				   ipv, ntohs(conn->eth_proto));
+			return -EOPNOTSUPP;
+		}
+		if (!IS_ALL_ONES(fm.mask->ip_proto)) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack ip_proto is not exact-match; mask %02x\n",
+				   fm.mask->ip_proto);
+			return -EOPNOTSUPP;
+		}
+		conn->ip_proto = fm.key->ip_proto;
+		switch (conn->ip_proto) {
+		case IPPROTO_TCP:
+			tcp = true;
+			break;
+		case IPPROTO_UDP:
+			break;
+		default:
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack ip_proto not TCP or UDP, is %02x\n",
+				   conn->ip_proto);
+			return -EOPNOTSUPP;
+		}
+	} else {
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Conntrack missing eth_proto, ip_proto\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (ipv == 4 && flow_rule_match_key(fr, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+		struct flow_match_ipv4_addrs fm;
+
+		flow_rule_match_ipv4_addrs(fr, &fm);
+		if (!IS_ALL_ONES(fm.mask->src)) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack ipv4.src is not exact-match; mask %08x\n",
+				   ntohl(fm.mask->src));
+			return -EOPNOTSUPP;
+		}
+		conn->src_ip = fm.key->src;
+		if (!IS_ALL_ONES(fm.mask->dst)) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack ipv4.dst is not exact-match; mask %08x\n",
+				   ntohl(fm.mask->dst));
+			return -EOPNOTSUPP;
+		}
+		conn->dst_ip = fm.key->dst;
+	} else if (ipv == 6 && flow_rule_match_key(fr, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
+		struct flow_match_ipv6_addrs fm;
+
+		flow_rule_match_ipv6_addrs(fr, &fm);
+		if (!efx_ipv6_addr_all_ones(&fm.mask->src)) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack ipv6.src is not exact-match; mask %pI6\n",
+				   &fm.mask->src);
+			return -EOPNOTSUPP;
+		}
+		conn->src_ip6 = fm.key->src;
+		if (!efx_ipv6_addr_all_ones(&fm.mask->dst)) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack ipv6.dst is not exact-match; mask %pI6\n",
+				   &fm.mask->dst);
+			return -EOPNOTSUPP;
+		}
+		conn->dst_ip6 = fm.key->dst;
+	} else {
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Conntrack missing IPv%u addrs\n", ipv);
+		return -EOPNOTSUPP;
+	}
+
+	if (flow_rule_match_key(fr, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports fm;
+
+		flow_rule_match_ports(fr, &fm);
+		if (!IS_ALL_ONES(fm.mask->src)) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack ports.src is not exact-match; mask %04x\n",
+				   ntohs(fm.mask->src));
+			return -EOPNOTSUPP;
+		}
+		conn->l4_sport = fm.key->src;
+		if (!IS_ALL_ONES(fm.mask->dst)) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack ports.dst is not exact-match; mask %04x\n",
+				   ntohs(fm.mask->dst));
+			return -EOPNOTSUPP;
+		}
+		conn->l4_dport = fm.key->dst;
+	} else {
+		netif_dbg(efx, drv, efx->net_dev, "Conntrack missing L4 ports\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (flow_rule_match_key(fr, FLOW_DISSECTOR_KEY_TCP)) {
+		__be16 tcp_interesting_flags;
+		struct flow_match_tcp fm;
+
+		if (!tcp) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Conntrack matching on TCP keys but ipproto is not tcp\n");
+			return -EOPNOTSUPP;
+		}
+		flow_rule_match_tcp(fr, &fm);
+		tcp_interesting_flags = EFX_NF_TCP_FLAG(SYN) |
+					EFX_NF_TCP_FLAG(RST) |
+					EFX_NF_TCP_FLAG(FIN);
+		/* If any of the tcp_interesting_flags is set, we always
+		 * inhibit CT lookup in LHS (so SW can update CT table).
+		 */
+		if (fm.key->flags & tcp_interesting_flags) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Unsupported conntrack tcp.flags %04x/%04x\n",
+				   ntohs(fm.key->flags), ntohs(fm.mask->flags));
+			return -EOPNOTSUPP;
+		}
+		/* Other TCP flags cannot be filtered at CT */
+		if (fm.mask->flags & ~tcp_interesting_flags) {
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Unsupported conntrack tcp.flags %04x/%04x\n",
+				   ntohs(fm.key->flags), ntohs(fm.mask->flags));
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int efx_tc_ct_replace(struct efx_tc_ct_zone *ct_zone,
+			     struct flow_cls_offload *tc)
+{
+	struct flow_rule *fr = flow_cls_offload_flow_rule(tc);
+	struct efx_tc_ct_entry *conn, *old;
+	struct efx_nic *efx = ct_zone->efx;
+	const struct flow_action_entry *fa;
+	struct efx_tc_counter *cnt;
+	int rc, i;
+
+	if (WARN_ON(!efx->tc))
+		return -ENETDOWN;
+	if (WARN_ON(!efx->tc->up))
+		return -ENETDOWN;
+
+	conn = kzalloc(sizeof(*conn), GFP_USER);
+	if (!conn)
+		return -ENOMEM;
+	conn->cookie = tc->cookie;
+	old = rhashtable_lookup_get_insert_fast(&efx->tc->ct_ht,
+						&conn->linkage,
+						efx_tc_ct_ht_params);
+	if (old) {
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Already offloaded conntrack (cookie %lx)\n", tc->cookie);
+		rc = -EEXIST;
+		goto release;
+	}
+
+	/* Parse match */
+	conn->zone = ct_zone;
+	rc = efx_tc_ct_parse_match(efx, fr, conn);
+	if (rc)
+		goto release;
+
+	/* Parse actions */
+	flow_action_for_each(i, fa, &fr->action) {
+		switch (fa->id) {
+		case FLOW_ACTION_CT_METADATA:
+			conn->mark = fa->ct_metadata.mark;
+			if (memchr_inv(fa->ct_metadata.labels, 0, sizeof(fa->ct_metadata.labels))) {
+				netif_dbg(efx, drv, efx->net_dev,
+					  "Setting CT label not supported\n");
+				rc = -EOPNOTSUPP;
+				goto release;
+			}
+			break;
+		default:
+			netif_dbg(efx, drv, efx->net_dev,
+				  "Unhandled action %u for conntrack\n", fa->id);
+			rc = -EOPNOTSUPP;
+			goto release;
+		}
+	}
+
+	/* fill in defaults for unmangled values */
+	conn->nat_ip = conn->dnat ? conn->dst_ip : conn->src_ip;
+	conn->l4_natport = conn->dnat ? conn->l4_dport : conn->l4_sport;
+
+	cnt = efx_tc_flower_allocate_counter(efx, EFX_TC_COUNTER_TYPE_CT);
+	if (IS_ERR(cnt)) {
+		rc = PTR_ERR(cnt);
+		goto release;
+	}
+	conn->cnt = cnt;
+
+	rc = efx_mae_insert_ct(efx, conn);
+	if (rc) {
+		netif_dbg(efx, drv, efx->net_dev,
+			  "Failed to insert conntrack, %d\n", rc);
+		goto release;
+	}
+	mutex_lock(&ct_zone->mutex);
+	list_add_tail(&conn->list, &ct_zone->cts);
+	mutex_unlock(&ct_zone->mutex);
+	return 0;
+release:
+	if (conn->cnt)
+		efx_tc_flower_release_counter(efx, conn->cnt);
+	if (!old)
+		rhashtable_remove_fast(&efx->tc->ct_ht, &conn->linkage,
+				       efx_tc_ct_ht_params);
+	kfree(conn);
+	return rc;
+}
+
+/* Caller must follow with efx_tc_ct_remove_finish() after RCU grace period! */
+static void efx_tc_ct_remove(struct efx_nic *efx, struct efx_tc_ct_entry *conn)
+{
+	int rc;
+
+	/* Remove it from HW */
+	rc = efx_mae_remove_ct(efx, conn);
+	/* Delete it from SW */
+	rhashtable_remove_fast(&efx->tc->ct_ht, &conn->linkage,
+			       efx_tc_ct_ht_params);
+	if (rc) {
+		netif_err(efx, drv, efx->net_dev,
+			  "Failed to remove conntrack %lx from hw, rc %d\n",
+			  conn->cookie, rc);
+	} else {
+		netif_dbg(efx, drv, efx->net_dev, "Removed conntrack %lx\n",
+			  conn->cookie);
+	}
+}
+
+static void efx_tc_ct_remove_finish(struct efx_nic *efx, struct efx_tc_ct_entry *conn)
+{
+	/* Remove related CT counter.  This is delayed after the conn object we
+	 * are working with has been successfully removed.  This protects the
+	 * counter from being used-after-free inside efx_tc_ct_stats.
+	 */
+	efx_tc_flower_release_counter(efx, conn->cnt);
+	kfree(conn);
+}
+
+static int efx_tc_ct_destroy(struct efx_tc_ct_zone *ct_zone,
+			     struct flow_cls_offload *tc)
+{
+	struct efx_nic *efx = ct_zone->efx;
+	struct efx_tc_ct_entry *conn;
+
+	conn = rhashtable_lookup_fast(&efx->tc->ct_ht, &tc->cookie,
+				      efx_tc_ct_ht_params);
+	if (!conn) {
+		netif_warn(efx, drv, efx->net_dev,
+			   "Conntrack %lx not found to remove\n", tc->cookie);
+		return -ENOENT;
+	}
+
+	mutex_lock(&ct_zone->mutex);
+	list_del(&conn->list);
+	efx_tc_ct_remove(efx, conn);
+	mutex_unlock(&ct_zone->mutex);
+	synchronize_rcu();
+	efx_tc_ct_remove_finish(efx, conn);
+	return 0;
+}
+
+static int efx_tc_ct_stats(struct efx_tc_ct_zone *ct_zone,
+			   struct flow_cls_offload *tc)
+{
+	struct efx_nic *efx = ct_zone->efx;
+	struct efx_tc_ct_entry *conn;
+	struct efx_tc_counter *cnt;
+
+	rcu_read_lock();
+	conn = rhashtable_lookup_fast(&efx->tc->ct_ht, &tc->cookie,
+				      efx_tc_ct_ht_params);
+	if (!conn) {
+		netif_warn(efx, drv, efx->net_dev,
+			   "Conntrack %lx not found for stats\n", tc->cookie);
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	cnt = conn->cnt;
+	spin_lock_bh(&cnt->lock);
+	/* Report only last use */
+	flow_stats_update(&tc->stats, 0, 0, 0, cnt->touched,
+			  FLOW_ACTION_HW_STATS_DELAYED);
+	spin_unlock_bh(&cnt->lock);
+	rcu_read_unlock();
+
+	return 0;
 }
 
 static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
 			     void *cb_priv)
 {
+	struct flow_cls_offload *tcb = type_data;
+	struct efx_tc_ct_zone *ct_zone = cb_priv;
+
+	if (type != TC_SETUP_CLSFLOWER)
+		return -EOPNOTSUPP;
+
+	switch (tcb->command) {
+	case FLOW_CLS_REPLACE:
+		return efx_tc_ct_replace(ct_zone, tcb);
+	case FLOW_CLS_DESTROY:
+		return efx_tc_ct_destroy(ct_zone, tcb);
+	case FLOW_CLS_STATS:
+		return efx_tc_ct_stats(ct_zone, tcb);
+	default:
+		break;
+	};
+
 	return -EOPNOTSUPP;
 }
 
@@ -81,6 +483,8 @@ struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
 	}
 	ct_zone->nf_ft = ct_ft;
 	ct_zone->efx = efx;
+	INIT_LIST_HEAD(&ct_zone->cts);
+	mutex_init(&ct_zone->mutex);
 	rc = nf_flow_table_offload_add_cb(ct_ft, efx_tc_flow_block, ct_zone);
 	netif_dbg(efx, drv, efx->net_dev, "Adding new ct_zone for %u, rc %d\n",
 		  zone, rc);
@@ -98,11 +502,22 @@ struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
 void efx_tc_ct_unregister_zone(struct efx_nic *efx,
 			       struct efx_tc_ct_zone *ct_zone)
 {
+	struct efx_tc_ct_entry *conn, *next;
+
 	if (!refcount_dec_and_test(&ct_zone->ref))
 		return; /* still in use */
 	nf_flow_table_offload_del_cb(ct_zone->nf_ft, efx_tc_flow_block, ct_zone);
 	rhashtable_remove_fast(&efx->tc->ct_zone_ht, &ct_zone->linkage,
 			       efx_tc_ct_zone_ht_params);
+	mutex_lock(&ct_zone->mutex);
+	list_for_each_entry(conn, &ct_zone->cts, list)
+		efx_tc_ct_remove(efx, conn);
+	synchronize_rcu();
+	/* need to use _safe because efx_tc_ct_remove_finish() frees conn */
+	list_for_each_entry_safe(conn, next, &ct_zone->cts, list)
+		efx_tc_ct_remove_finish(efx, conn);
+	mutex_unlock(&ct_zone->mutex);
+	mutex_destroy(&ct_zone->mutex);
 	netif_dbg(efx, drv, efx->net_dev, "Removed ct_zone for %u\n",
 		  ct_zone->zone);
 	kfree(ct_zone);
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.h b/drivers/net/ethernet/sfc/tc_conntrack.h
index a3e518344cbc..ef5cf96c0649 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.h
+++ b/drivers/net/ethernet/sfc/tc_conntrack.h
@@ -22,6 +22,8 @@ struct efx_tc_ct_zone {
 	refcount_t ref;
 	struct nf_flowtable *nf_ft;
 	struct efx_nic *efx;
+	struct mutex mutex; /* protects cts list */
+	struct list_head cts; /* list of efx_tc_ct_entry in this zone */
 };
 
 /* create/teardown hashtables */
@@ -45,6 +47,7 @@ struct efx_tc_ct_entry {
 	struct efx_tc_ct_zone *zone;
 	u32 mark;
 	struct efx_tc_counter *cnt;
+	struct list_head list; /* entry on zone->cts */
 };
 
 #endif /* CONFIG_SFC_SRIOV */
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index 979f49058a0c..0fafb47ea082 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -129,8 +129,8 @@ static void efx_tc_counter_work(struct work_struct *work)
 
 /* Counter allocation */
 
-static struct efx_tc_counter *efx_tc_flower_allocate_counter(struct efx_nic *efx,
-							     int type)
+struct efx_tc_counter *efx_tc_flower_allocate_counter(struct efx_nic *efx,
+						      int type)
 {
 	struct efx_tc_counter *cnt;
 	int rc, rc2;
@@ -169,8 +169,8 @@ static struct efx_tc_counter *efx_tc_flower_allocate_counter(struct efx_nic *efx
 	return ERR_PTR(rc > 0 ? -EIO : rc);
 }
 
-static void efx_tc_flower_release_counter(struct efx_nic *efx,
-					  struct efx_tc_counter *cnt)
+void efx_tc_flower_release_counter(struct efx_nic *efx,
+				   struct efx_tc_counter *cnt)
 {
 	int rc;
 
diff --git a/drivers/net/ethernet/sfc/tc_counters.h b/drivers/net/ethernet/sfc/tc_counters.h
index 41e57f34b763..f18d71c13600 100644
--- a/drivers/net/ethernet/sfc/tc_counters.h
+++ b/drivers/net/ethernet/sfc/tc_counters.h
@@ -49,6 +49,10 @@ int efx_tc_init_counters(struct efx_nic *efx);
 void efx_tc_destroy_counters(struct efx_nic *efx);
 void efx_tc_fini_counters(struct efx_nic *efx);
 
+struct efx_tc_counter *efx_tc_flower_allocate_counter(struct efx_nic *efx,
+						      int type);
+void efx_tc_flower_release_counter(struct efx_nic *efx,
+				   struct efx_tc_counter *cnt);
 struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
 				struct efx_nic *efx, unsigned long cookie,
 				enum efx_tc_counter_type type);

