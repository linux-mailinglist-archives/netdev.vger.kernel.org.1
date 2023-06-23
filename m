Return-Path: <netdev+bounces-13510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E673BE8D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33A11C212EB
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B147BAD5E;
	Fri, 23 Jun 2023 18:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448EAD30
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 18:39:36 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8349BC6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 11:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1fHZx5W42p9E3cvCXAIRQqgWVhSG3WyN2oYsf2LaEnhhgs+pKulusP3LWSQVNIhzsXhSPX90GO1L4mM2A4hGA1LD+7I9bEYIxMAg0Zmkt8XhtlbymraNYxKOqK5vRyIRE7QGgFD+vap5d+Nahl6DfHWBIVs0P939C/DYrvJ1yxRdHF9K+LwqtFfBAiJr4dsIcn5JIsU4TheGFDSOgi5oJ8BRRU2mKNMZt8ygVbKA82CpnUKls/afDNfOGkqrhARMB0hSlvIgVZ+d8leleEcaIwe4XTRp8/34QoQReH/ru5zhMsqY0SmcZwZGNAB6tB9QNZjSlsRxz7ksl2diPBXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2oDJM8a69Dyi46bVVuV/uj9zRgEBuvJBhUPmEmHPGw=;
 b=T64tJz9DmedkWOm62w7x+VHY5zB/ocV0QMKjiXVUFBip+nqakowDVW1+8WoDTqJ5tT8eUo75ywpDRhvWvzRTFJBzx0QRSKmsIJfYnR6KCk5Hkknfz9RHeaWMroj2h4g6/DDM5OqVud5rH9598SmSoI1aKHFcu2mM08hgpX8o7+G6muWMMvvOmAlsWJ0CScCSmpj2voCFRuZ+UVTL9+gS0/rWj/o7t74nCk2O3/RgdoJCGWaM2RKc6DW7FmvvA99aG243lg51SZxuk6IJiyZYtH7peWvubzjdcyjTrIdJKKC8gO8IAGJ6yujLDpRagxTHjXrcSrXO9K0dS/qbNzeY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2oDJM8a69Dyi46bVVuV/uj9zRgEBuvJBhUPmEmHPGw=;
 b=5bMbHheBpyVnE1pK7kLw+xE1pYIcYaJeMaMjexu7CAhrVfGpDio95o07jedcy0v4vHwOFbh/SSMqs2j7Kin+eA1fEIJOlDlaEsFjYK6eSqllNHtnROdIfbJYUatNTns8IGHKd3kgf2z/UHXa1SEBqTG0o5bSBqA9dDbgKL5xvzo=
Received: from BN0PR04CA0132.namprd04.prod.outlook.com (2603:10b6:408:ed::17)
 by DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 18:39:30 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::2e) by BN0PR04CA0132.outlook.office365.com
 (2603:10b6:408:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Fri, 23 Jun 2023 18:39:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:39:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:39:29 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Fri, 23 Jun 2023 13:39:28 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <arnd@arndb.de>
Subject: [PATCH v2 net-next 1/3] sfc: use padding to fix alignment in loopback test
Date: Fri, 23 Jun 2023 19:38:04 +0100
Message-ID: <dfe2eb3d6ad3204079df63ae123b82d49b0c90e2.1687545312.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|DM4PR12MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: c4654183-489a-445f-2540-08db74192e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ehS1Gpvrx/mNxE9oyHH8UIJ5cC8+B6BbTOWapmA4cDp5u0pKEeqk7m9atfCgjcPtpuejPamn0jSnPehhSOM0/PJwLGBfOjzP9R6HB4kMJRaWqmrLpl0U2Hd6cltvXc5GOeOIPLSRfy2SvOatE72j42DM1qthT8YjVNyRy7RlcSDUZz62Klo2ERlwPgRwu9Grhb9qeSWGMuoScr4kSFFpgw4RbMEXFh+aT5UJrroDcMIZRupEfM9StsamKh4IYfZz2+zcboFecuF7+pp8dXJVwXTi6FvFMtv0NTD1R0Kj21u77bA27ZH0x6M5Yb9sNDr2bqVnWs9FDdikEOPg1vwzZ/WfNwxzUKg6li3JXSY+ukgDtVIIvWPCSuMvgPi5QWohfKuNns/JUK1/tEdm+I64kmfh+FH9Dsepgkx5DP22Hlh77rX6QEGzaVp19noNbP/t4ySto61Ri5hlEXqTIJzXAKC9nIp26IVpYOOFubft7FefJ934z2eKIOeP+7GD5mAvCbEEs09gqNCmfy109ASlRzbZddXb5tQFybOIiowd7RnyDQSgTyXMYg+QeMNCF+ijRU9a94Db46SFwll4P67Oygwv3e9K0R103M/A2hbiTl3TRX9B2fiEo0D5Pc3HKfZiOjbcK5M09LaDH0XNBNbjpdr5N97VckEK/3eqop0UvQ/oubW+QuANQoW0EkJrtklow83ADvjliYKw9s1250anOATSBOTLmlgyPfhwlEphEUdgia4FqLadq9dwhVCAQAoNFKf6MtuRaFWr1fIwn5iCgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(70586007)(70206006)(81166007)(356005)(55446002)(86362001)(82310400005)(9686003)(82740400003)(54906003)(36860700001)(26005)(110136005)(47076005)(83380400001)(186003)(4326008)(426003)(478600001)(36756003)(336012)(6666004)(40480700001)(2906002)(8676002)(8936002)(5660300002)(316002)(2876002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:39:30.3711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4654183-489a-445f-2540-08db74192e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5152
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
net/ethernet/sfc/selftest.c:46:15: error: field ip within 'struct efx_loopback_payload' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        struct iphdr ip;

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/selftest.c | 47 +++++++++++++++++------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/sfc/selftest.c b/drivers/net/ethernet/sfc/selftest.c
index 3c5227afd497..96d856b9043c 100644
--- a/drivers/net/ethernet/sfc/selftest.c
+++ b/drivers/net/ethernet/sfc/selftest.c
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
@@ -282,7 +286,7 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 			    const char *buf_ptr, int pkt_len)
 {
 	struct efx_loopback_state *state = efx->loopback_selftest;
-	struct efx_loopback_payload *received;
+	struct efx_loopback_payload received;
 	struct efx_loopback_payload *payload;
 
 	BUG_ON(!buf_ptr);
@@ -293,13 +297,14 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 
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
@@ -307,7 +312,7 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check that the ethernet header exists */
-	if (memcmp(&received->header, &payload->header, ETH_HLEN) != 0) {
+	if (memcmp(&received.header, &payload->header, ETH_HLEN) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw non-loopback RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -315,16 +320,16 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
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
@@ -332,7 +337,7 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check that msg and padding matches */
-	if (memcmp(&received->msg, &payload->msg, sizeof(received->msg)) != 0) {
+	if (memcmp(&received.msg, &payload->msg, sizeof(received.msg)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -340,10 +345,10 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
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
@@ -363,7 +368,8 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
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

