Return-Path: <netdev+bounces-13512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7049C73BE8F
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926151C212CC
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A110782;
	Fri, 23 Jun 2023 18:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734110780
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 18:39:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C2C6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 11:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7C854P6dROIbOepwRjxl5JMOt4YP6ClxBfKIGS3DV1J4glWiRSyz1IKWh2Qic1MWw2MjVFndp+KxacivCq9rcVYlHFUysDIT0aPUmnY7fkYqBUKLBFnO8JqEkKM7t9/YAYHELYmO8Z+Yd/sD1EzYL5iEgW0t3wkK3HyUe3seVEC3UZB874DfkuF0BOzc1s3g10DRtKNnM8TnFi800tlbmBXFrRnokpJntdItADqxXkyN03VClgCzzNfBXUl1ycEWlcqt1G5Lq8ccVOHEPfIUaBCgOh2AswtJwuV5/DOQeLT7spFQ798QFi7q6TZvgreHPlmtKj8nF55eXSQ5owxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5rlO4qElz5Tox1VEqCLcQ0AeRncKEtEEA5uwbPAwlU=;
 b=HzS1EN8B8tp2HDG2uOI+JpFKfXTHojiz8FEamigPxwaseb5D/eE5MsBetW4PDCfhOPCTsGj+D68WaflPS860dxBg8CPglv21gm0RL5VtDd5xj4ltC0qz7+mne/ig5VZ9JNo/LaH531KbiC0SaCQ2q3w6nKbJW5e0Ik442xsWPOp4tg4kqvijdSf1fFbKB1FjgpOM+RcaZQbGgFwjYeHDboFTX+GOma2CCZFFxU5MO46AAr9IBzqth7RlIcJ7Uu7ZCfpLmF5+7dfDmbWwGCa4nD7onLtChiyKxHAxChNBHkDRW8H4jjpx5DoT+Mxeo0uGJ9GN4tuSg/+LTY6I7ph9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5rlO4qElz5Tox1VEqCLcQ0AeRncKEtEEA5uwbPAwlU=;
 b=dUc2tTPSZzZfnIDksWlT+rfM45wKXYgkhdYbbwdN8ZfZe/U+Xx2mjSluN9jKdgKCq8YSgzXXx5m7SqV0VGeK32cG4NL+dQfy2ktYiHDHezHIExS8QN96cOCvjyPK3T7ap6wbJ7TlHoTtNpGv4anF8LnC8lp+jvkvAiNqu4pgXvs=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 18:39:32 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::eb) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 18:39:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:39:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:39:31 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Fri, 23 Jun 2023 13:39:29 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <arnd@arndb.de>
Subject: [PATCH v2 net-next 2/3] sfc: siena: use padding to fix alignment in loopback test
Date: Fri, 23 Jun 2023 19:38:05 +0100
Message-ID: <b95b30118af62b7041b140f67cab31fd7a3beff4.1687545312.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1687545312.git.ecree.xilinx@gmail.com>
References: <cover.1687545312.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: a20910f5-8d55-465c-6a2e-08db74192f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3NiANSSX1LwF16Xu9DDIaKIpaq6GH/N3v/F2S9h97bD7ty09xY1JBT80toTxDsIthTSv+tx6VLXIyyS4J36iFBhzNRNljHkQyP1YzSzynvkRunQ2rRvYN8Ji9b+ctHf3e/WXPnFKqO9WC4KGtBPig4i7vrV5aW4EcSsi0X+ibN5BVoOMTW66uCI+1c52B4ziDPJQS4sovRmLgA5aIOqCSrBfxZppX5ibk3FmGNvAG6BaAH1op4H5K10Xtq6Ahyh2wRX/uZ4z9f3ni9CYOyOV3Cbt3dmQCcQktGZfeexACi1TbC7NlpqRWsZWIjYPn9xpnngRKqqPkme+GV3zApNjVP+zFEQ96EOBwgkMaUQoIZpiyv2Uv7fP5uV/4TkD3zfAPPcdy8tPKBnU1EDJO/aJebAPqvseHqacNM8jGD7zN6CDbMXgbIgVcYzniM+Dskjtvu261oeviC696INzARdGgqtNVZBtCueS+iK5JByBn3DL5e8Pt58+/QvlESGHF7Gx+PXb8EosdGFBiMP6dYf/nGhZ8V3v9blkupVW25y/fjLPzNQ5f/EOn4MrtImdxiA6gcie6w7Y9niwzYShMSH3knEuK7Eb/rcP3xKi7B4rtSmFKWMhbhuV8S04QQVCKHTUyvea1vA+CgaBiqy+ZDAZH7AyTj/FdcsZecm1ekJYWpF2e/BbWwRr+MemdBQ+3ZM8hay1OtOHRM+WUB36LuTuTntoIvnvnzQ5CFRzL1CJa3+msU3E3StyoRNcQWCwJfv6Ums4s1fRuS1OrC45G8juTw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(54906003)(110136005)(478600001)(40480700001)(9686003)(26005)(6666004)(40460700003)(5660300002)(2876002)(2906002)(82310400005)(36756003)(55446002)(4326008)(70586007)(70206006)(86362001)(41300700001)(8936002)(8676002)(47076005)(336012)(83380400001)(316002)(426003)(82740400003)(356005)(81166007)(36860700001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:39:32.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20910f5-8d55-465c-6a2e-08db74192f83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Add two bytes of padding to the start of struct efx_loopback_payload,
 which are not sent on the wire.  This ensures the 'ip' member is
 4-byte aligned, preventing the following W=1 warning:
net/ethernet/sfc/siena/selftest.c:46:15: error: field ip within 'struct efx_loopback_payload' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        struct iphdr ip;

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/siena/selftest.c | 47 ++++++++++++++---------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/selftest.c b/drivers/net/ethernet/sfc/siena/selftest.c
index 07715a3d6bea..111ac17194a5 100644
--- a/drivers/net/ethernet/sfc/siena/selftest.c
+++ b/drivers/net/ethernet/sfc/siena/selftest.c
@@ -42,12 +42,16 @@
  * Falcon only performs RSS on TCP/UDP packets.
  */
 struct efx_loopback_payload {
+	char pad[2]; /* Ensures ip is 4-byte aligned */
 	struct ethhdr header;
 	struct iphdr ip;
 	struct udphdr udp;
 	__be16 iteration;
 	char msg[64];
-} __packed;
+} __packed __aligned(4);
+#define EFX_LOOPBACK_PAYLOAD_LEN	(sizeof(struct efx_loopback_payload) - \
+					 offsetof(struct efx_loopback_payload, \
+						  header))
 
 /* Loopback test source MAC address */
 static const u8 payload_source[ETH_ALEN] __aligned(2) = {
@@ -282,7 +286,7 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 				  const char *buf_ptr, int pkt_len)
 {
 	struct efx_loopback_state *state = efx->loopback_selftest;
-	struct efx_loopback_payload *received;
+	struct efx_loopback_payload received;
 	struct efx_loopback_payload *payload;
 
 	BUG_ON(!buf_ptr);
@@ -293,13 +297,14 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 
 	payload = &state->payload;
 
-	received = (struct efx_loopback_payload *) buf_ptr;
-	received->ip.saddr = payload->ip.saddr;
+	memcpy(&received.header, buf_ptr,
+	       min_t(int, pkt_len, EFX_LOOPBACK_PAYLOAD_LEN));
+	received.ip.saddr = payload->ip.saddr;
 	if (state->offload_csum)
-		received->ip.check = payload->ip.check;
+		received.ip.check = payload->ip.check;
 
 	/* Check that header exists */
-	if (pkt_len < sizeof(received->header)) {
+	if (pkt_len < sizeof(received.header)) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw runt RX packet (length %d) in %s loopback "
 			  "test\n", pkt_len, LOOPBACK_MODE(efx));
@@ -307,7 +312,7 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check that the ethernet header exists */
-	if (memcmp(&received->header, &payload->header, ETH_HLEN) != 0) {
+	if (memcmp(&received.header, &payload->header, ETH_HLEN) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw non-loopback RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -315,16 +320,16 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check packet length */
-	if (pkt_len != sizeof(*payload)) {
+	if (pkt_len != EFX_LOOPBACK_PAYLOAD_LEN) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw incorrect RX packet length %d (wanted %d) in "
-			  "%s loopback test\n", pkt_len, (int)sizeof(*payload),
-			  LOOPBACK_MODE(efx));
+			  "%s loopback test\n", pkt_len,
+			  (int)EFX_LOOPBACK_PAYLOAD_LEN, LOOPBACK_MODE(efx));
 		goto err;
 	}
 
 	/* Check that IP header matches */
-	if (memcmp(&received->ip, &payload->ip, sizeof(payload->ip)) != 0) {
+	if (memcmp(&received.ip, &payload->ip, sizeof(payload->ip)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted IP header in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -332,7 +337,7 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check that msg and padding matches */
-	if (memcmp(&received->msg, &payload->msg, sizeof(received->msg)) != 0) {
+	if (memcmp(&received.msg, &payload->msg, sizeof(received.msg)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -340,10 +345,10 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check that iteration matches */
-	if (received->iteration != payload->iteration) {
+	if (received.iteration != payload->iteration) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw RX packet from iteration %d (wanted %d) in "
-			  "%s loopback test\n", ntohs(received->iteration),
+			  "%s loopback test\n", ntohs(received.iteration),
 			  ntohs(payload->iteration), LOOPBACK_MODE(efx));
 		goto err;
 	}
@@ -363,7 +368,8 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 			       buf_ptr, pkt_len, 0);
 		netif_err(efx, drv, efx->net_dev, "expected packet:\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 0x10, 1,
-			       &state->payload, sizeof(state->payload), 0);
+			       &state->payload.header, EFX_LOOPBACK_PAYLOAD_LEN,
+			       0);
 	}
 #endif
 	atomic_inc(&state->rx_bad);
@@ -385,14 +391,15 @@ static void efx_iterate_state(struct efx_nic *efx)
 	payload->ip.daddr = htonl(INADDR_LOOPBACK);
 	payload->ip.ihl = 5;
 	payload->ip.check = (__force __sum16) htons(0xdead);
-	payload->ip.tot_len = htons(sizeof(*payload) - sizeof(struct ethhdr));
+	payload->ip.tot_len = htons(sizeof(*payload) -
+				    offsetof(struct efx_loopback_payload, ip));
 	payload->ip.version = IPVERSION;
 	payload->ip.protocol = IPPROTO_UDP;
 
 	/* Initialise udp header */
 	payload->udp.source = 0;
-	payload->udp.len = htons(sizeof(*payload) - sizeof(struct ethhdr) -
-				 sizeof(struct iphdr));
+	payload->udp.len = htons(sizeof(*payload) -
+				 offsetof(struct efx_loopback_payload, udp));
 	payload->udp.check = 0;	/* checksum ignored */
 
 	/* Fill out payload */
@@ -418,7 +425,7 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 	for (i = 0; i < state->packet_count; i++) {
 		/* Allocate an skb, holding an extra reference for
 		 * transmit completion counting */
-		skb = alloc_skb(sizeof(state->payload), GFP_KERNEL);
+		skb = alloc_skb(EFX_LOOPBACK_PAYLOAD_LEN, GFP_KERNEL);
 		if (!skb)
 			return -ENOMEM;
 		state->skbs[i] = skb;
@@ -429,6 +436,8 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 		payload = skb_put(skb, sizeof(state->payload));
 		memcpy(payload, &state->payload, sizeof(state->payload));
 		payload->ip.saddr = htonl(INADDR_LOOPBACK | (i << 2));
+		/* Strip off the leading padding */
+		skb_pull(skb, offsetof(struct efx_loopback_payload, header));
 
 		/* Ensure everything we've written is visible to the
 		 * interrupt handler. */

