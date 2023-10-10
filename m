Return-Path: <netdev+bounces-39722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499D7C4300
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B25281DC0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFAF32C6A;
	Tue, 10 Oct 2023 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VZGcq4iI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58232C64
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 21:52:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B9398
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyY9rnflpf23qe7CebWSxdDdE0Rip1tEmrqa9JTbtpRM18zWJazSThln5vP5TFcBgF6bPF/IFcsw5SnNdZrBZShkGMUboIbh/Pw/xyLfGzZLBF5RFGzLXkmg/XdrPsQ0mD02/+pdpHFOmif9jQb0URKV29QY06WGn39Wse+ry/JNNEauYMDGuLB7cQIzZFAHFbLtlT1awWyAKlVS9m8F7g71jNG47GDxWjynjJH9xYhsjaO+nRzQDktfhRFlAaZ+1AMHnukMs3QfVHvOGTtkZjfRjX7J2CAWPJ9HQ3H7VjqqyhNjQ8jww2vkCVkGFRsTxK88siYpnhCxO11oQnIpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxW9x74aoHeA9pC9dymMMR4zD6Vvox58kRx0aqSJHb0=;
 b=KQff7oXXFklua1BQfR4O7ThLrgG54K1+z1kydY68pIBbUUKE8vgY5esKDZhv0iT9EUhznEJGFlvcFNWJfj85ARCWYVztdyIxN6kahJULtnUXahkXJcn8IvP44qCn9FTUIpGfxNny3RjjhYVqKOZWDh+7UHVYizBBmqQ/txMJaNQcDClmBXvgmziQEPtnsgIQLjdOlenvN00Ms0T0xtkgCFHkYWhGk7zAY/VSBuD1LCzfFW+LgEwnQcTjg1NOpIRnBle9sWd4hUEH0GZlT/CzrvPMXEnring4wy8pF2CegnPd8GuaGKcN/1cyZ6nDEa9GZhMOemPlWJn4HB2a1IhvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxW9x74aoHeA9pC9dymMMR4zD6Vvox58kRx0aqSJHb0=;
 b=VZGcq4iIYHWy9QIyvIOfa8tavM0vNph803AeVU3Pgv5HJZfbJ/gRf9nLFxRZDzADopGbkN9ByvQlLzAMrcEPNZrv/tzS9L72n3SdKWpS6H9Ht8r3F9jYB7AttPNsnOfCJNp9HF95ELlHIs/GqAUf4GRB0LgW7twAl2CbE3S7t5Q=
Received: from DS7PR03CA0156.namprd03.prod.outlook.com (2603:10b6:5:3b2::11)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 21:52:45 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::f5) by DS7PR03CA0156.outlook.office365.com
 (2603:10b6:5:3b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 21:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 21:52:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 16:52:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 16:52:43 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 10 Oct 2023 16:52:42 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 1/2] sfc: parse mangle actions (NAT) in conntrack entries
Date: Tue, 10 Oct 2023 22:51:59 +0100
Message-ID: <5257b720c22a33f086cef140571918922967ffff.1696974554.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1696974554.git.ecree.xilinx@gmail.com>
References: <cover.1696974554.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abbec50-2aa0-49b0-ffef-08dbc9db3c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NZeg54l5p9IUcsE6alpeWz0KAxklf/VLoFE/gty09kxISZgZuzxRPWUJt4On1WdZaITc5Paqb1RbicGVLloldAaCQxqfmN7xA9aw8Fvz229Bjaha7esxvWZvStwonqidRSgKO6sdbYkPYykedMWUykAOqRKsOZ+elqBSBlMQ32+AOwLYqiC9h9PI+Bdk8rGGbk6EjMhO/zqK4G1tJEbI8WOAysJJ8rOyNZpCCJOoM5rIPa5bM3/iApVwtWM6szUeO56jKIEqiF8ljBfwPNsC70Dl6I0CDpk8Lj3hT/F9B/HUB5oH//R+TJgBdEh03Py9KLScjZhGqJ8rYEm61LyIUeSvohpyYGzTRBM3j2z6kM1EaiE5XWgXPeqITCw7/kpLJv3T/o9DYWTKggBshubAUsR/v2+xl1cwe3FteGxUVVNMuNd8lkITpNVEfYoADajnvS96Z4JeN2vvV7gbGCTFZV0MeFF4rzDR1yOW7M35pUFbOh3diReObhb8oTe9k/Mp+bxwcZ0rIXYP2s/bTCoKD4nyVK072sARvy7VyVxkTxhYD06+vB52o6BvwBolBicvFV7m5lkuMIA9mHmRccsCTy+UTyBU3vF1n7ThBcOwfqGuzFN9wUYB3+rCHqoOuFjewXeYNt9Zuw6tvPTXsdiQ7Sc9ZCaDFpsu+nnrGntKbPe8gWepa/lVlYT8pZaeZPgsIisn+W4VuvNOHKgDhPibpZ7Lm/aq4ncpN+tXwic2l3jbW5QECMgkM6//96mg9C5G2cUI7okW2jXptRo4vhP7sg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(82740400003)(9686003)(478600001)(41300700001)(426003)(336012)(83380400001)(2876002)(47076005)(2906002)(110136005)(5660300002)(54906003)(70586007)(8676002)(4326008)(70206006)(8936002)(26005)(40460700003)(55446002)(36860700001)(356005)(86362001)(36756003)(40480700001)(316002)(81166007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:52:44.6092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abbec50-2aa0-49b0-ffef-08dbc9db3c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

The MAE can edit either address, L4 port, or both, for either source
 or destination.  These can't be mixed; i.e. it can edit source addr
 and source port, but not (say) source addr and dest port.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc_conntrack.c | 91 ++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
index 44bb57670340..d90206f27161 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.c
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -276,10 +276,84 @@ static int efx_tc_ct_parse_match(struct efx_nic *efx, struct flow_rule *fr,
 	return 0;
 }
 
+/**
+ * struct efx_tc_ct_mangler_state - tracks which fields have been pedited
+ *
+ * @ipv4: IP source or destination addr has been set
+ * @tcpudp: TCP/UDP source or destination port has been set
+ */
+struct efx_tc_ct_mangler_state {
+	u8 ipv4:1;
+	u8 tcpudp:1;
+};
+
+static int efx_tc_ct_mangle(struct efx_nic *efx, struct efx_tc_ct_entry *conn,
+			    const struct flow_action_entry *fa,
+			    struct efx_tc_ct_mangler_state *mung)
+{
+	/* Is this the first mangle we've processed for this rule? */
+	bool first = !(mung->ipv4 || mung->tcpudp);
+	bool dnat = false;
+
+	switch (fa->mangle.htype) {
+	case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
+		switch (fa->mangle.offset) {
+		case offsetof(struct iphdr, daddr):
+			dnat = true;
+			fallthrough;
+		case offsetof(struct iphdr, saddr):
+			if (fa->mangle.mask)
+				return -EOPNOTSUPP;
+			conn->nat_ip = htonl(fa->mangle.val);
+			mung->ipv4 = 1;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case FLOW_ACT_MANGLE_HDR_TYPE_TCP:
+	case FLOW_ACT_MANGLE_HDR_TYPE_UDP:
+		/* Both struct tcphdr and struct udphdr start with
+		 *	__be16 source;
+		 *	__be16 dest;
+		 * so we can use the same code for both.
+		 */
+		switch (fa->mangle.offset) {
+		case offsetof(struct tcphdr, dest):
+			BUILD_BUG_ON(offsetof(struct tcphdr, dest) !=
+				     offsetof(struct udphdr, dest));
+			dnat = true;
+			fallthrough;
+		case offsetof(struct tcphdr, source):
+			BUILD_BUG_ON(offsetof(struct tcphdr, source) !=
+				     offsetof(struct udphdr, source));
+			if (~fa->mangle.mask != 0xffff)
+				return -EOPNOTSUPP;
+			conn->l4_natport = htons(fa->mangle.val);
+			mung->tcpudp = 1;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	/* first mangle tells us whether this is SNAT or DNAT;
+	 * subsequent mangles must match that
+	 */
+	if (first)
+		conn->dnat = dnat;
+	else if (conn->dnat != dnat)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 static int efx_tc_ct_replace(struct efx_tc_ct_zone *ct_zone,
 			     struct flow_cls_offload *tc)
 {
 	struct flow_rule *fr = flow_cls_offload_flow_rule(tc);
+	struct efx_tc_ct_mangler_state mung = {};
 	struct efx_tc_ct_entry *conn, *old;
 	struct efx_nic *efx = ct_zone->efx;
 	const struct flow_action_entry *fa;
@@ -326,6 +400,17 @@ static int efx_tc_ct_replace(struct efx_tc_ct_zone *ct_zone,
 				goto release;
 			}
 			break;
+		case FLOW_ACTION_MANGLE:
+			if (conn->eth_proto != htons(ETH_P_IP)) {
+				netif_dbg(efx, drv, efx->net_dev,
+					  "NAT only supported for IPv4\n");
+				rc = -EOPNOTSUPP;
+				goto release;
+			}
+			rc = efx_tc_ct_mangle(efx, conn, fa, &mung);
+			if (rc)
+				goto release;
+			break;
 		default:
 			netif_dbg(efx, drv, efx->net_dev,
 				  "Unhandled action %u for conntrack\n", fa->id);
@@ -335,8 +420,10 @@ static int efx_tc_ct_replace(struct efx_tc_ct_zone *ct_zone,
 	}
 
 	/* fill in defaults for unmangled values */
-	conn->nat_ip = conn->dnat ? conn->dst_ip : conn->src_ip;
-	conn->l4_natport = conn->dnat ? conn->l4_dport : conn->l4_sport;
+	if (!mung.ipv4)
+		conn->nat_ip = conn->dnat ? conn->dst_ip : conn->src_ip;
+	if (!mung.tcpudp)
+		conn->l4_natport = conn->dnat ? conn->l4_dport : conn->l4_sport;
 
 	cnt = efx_tc_flower_allocate_counter(efx, EFX_TC_COUNTER_TYPE_CT);
 	if (IS_ERR(cnt)) {

