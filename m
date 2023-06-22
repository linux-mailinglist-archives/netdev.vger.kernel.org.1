Return-Path: <netdev+bounces-13023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36936739E5F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C22281918
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985121D2DD;
	Thu, 22 Jun 2023 10:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7671C75E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:20:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01FAFE
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afVx8yWJRs9LZU1Jf0S9E12i/WHlH+7IUMalx8mZvROg5/gsIpIsTpZJWXzKAi3PNfJHPMtljFAERZLRG+38y+rNmetW9SRtbhG0P8+zFYXNh1ivQoK+/rIOglrZvaOSldtk0JbXjk3TubVz2j7Xhf2PZ21MnSQI35ZJCr8jfkTSLNrvpXlsb4QO/uCotzFZzhCq0KnFgMKG22vQjfTGuo9eRA+0e8mtK3MTEr3lO4q6RS1qELEeQok6FAMW4ca4ZknPzkgKqUi3ksIpMZ+PuzYJwjhzIYJSzptZbiPjRKaPin4wUv4RiexmGuU0N1KqGcFrEnPn3Ov0noQUcyizcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiQDE1/k54rvXi0vDCZ8QsmIkKSGgzLVMbAn3ydjPZo=;
 b=ajHB6mw7up4nfCr/VAn9jxGz3AqHPUE95AiV5SE+NUiyUnVM+P0Pr4vgiwsznBH6zgnRdI6Ska8CNKwaAfuiJxMN3BI0nNTHmps/JR94WEsagsKF/LaPB/0JmONYUEPoZHBxCCCOQg5eGVbenDbeAvn3EdQkFz7GqN0jry3fVVC82HQFpPzXxEvHWdOR+TIhkne1pM9Znq7qkQMo/VOL75P0Geg5+2LwRjK4UCuIcvjjShMSd/l+9leMle7k28VsLQjdjh2hkBU3iIcofV5Vc6I5/Frb9vF9i9LcjcDQlE4Z/Y1SOd54otW3Z7cJBjcV6sWS/J4j89v/mxPg8EVN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiQDE1/k54rvXi0vDCZ8QsmIkKSGgzLVMbAn3ydjPZo=;
 b=IXmmHWxM4DYUU5PjtGn8Zoclf2Pq6B2Kzkv7sTlmwQ/7liIDl+BP+gVEZVT0QsRNz6nClk/96JY7rtnOffW3p64FIbinqJdM5wPDa2/t9HqTPGAA81QKRwWf6KNdTFUCTyGXLeSzj/eLl690e+wkbvqhrRFnRAdG0x1VrvjoRQQ=
Received: from BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32) by
 MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 10:19:55 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:94:cafe::ff) by BYAPR01CA0055.outlook.office365.com
 (2603:10b6:a03:94::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 10:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 10:19:54 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 05:19:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 22 Jun
 2023 03:19:53 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 05:19:51 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <arnd@arndb.de>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>
Subject: [PATCH net-next 2/3] sfc: siena: use padding to fix alignment in loopback test
Date: Thu, 22 Jun 2023 11:18:57 +0100
Message-ID: <efd92c97cb93bc5dd23626bd751ce122296fe38d.1687427930.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1687427930.git.ecree.xilinx@gmail.com>
References: <cover.1687427930.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3d0ea8-b622-4b2d-351d-08db730a38e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VuJV4cujgQsFhVXtTt4mnuO/4E4LubAoOVdFHutmuQYXacWxqc6C+ce2gvLY/BbaOcuQXcXH2ipckj+2zLrB29XxLqOdEJciMBcr7Jb3SRKMgXlvUlKqh46HJ54Z04F7LebppZusriq3iz3HXH54cydYAyKJHH0YJM34NmQVck2auC5AU0LlyVv52L6u2KEvBTZi036+PssXhFjHrwWFsYb5rIGP8OtlV5dtb4WfS+/lQ6nZav+WovA+QfvG/olzancBDT5U0g7B0HlZgaLgeBDbha2qdG6RXRiPCkJRmEtRWfGO0kJ0TQIBM8hMww3TC9pQKp1lsi0dcGCmUY1QOhEU7ABnQJLVrqr9PFXfwtW77Eh/DttRIjE0MKyGlSWIJxeoFu+IhWWTck321eRtHgEaokDHCT9UlHMJAOZ3j4Jjci3aY4AU+KfpMz4tfeV5APFmAwscseOiDy+dO7d0TDn5m/pgnfPLes3Xpy1Lecc7sCvEMQ88/fOas+Y+Vh1bN8RAHIAPofxmgVvFBpeSQMpOiqHiJiW8Re4hLoK/3mCcaY2GFVEwUJBg38ZXAqxmanwfV9PsXZstcWmsCyPqxp0n9ZG6D0tq+Z2vKQIvflSIKKBYJx+qDrduMEigQlisAxbJyGPCbRJfPmRMyEFWu2xWuQT/MUS+WBCCIhF5T5y9JViG3Zx6hT1Gaa+8V2xMcFHavXYvblREg8It0HuLVzAutAhE+khLGMneLE8Lme5eJN3pZvaxwEug5dMRaojrgYB2r4utMKkvJGNlAT+nsg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(110136005)(356005)(478600001)(40460700003)(186003)(26005)(8676002)(9686003)(336012)(41300700001)(82310400005)(8936002)(316002)(81166007)(54906003)(70586007)(70206006)(82740400003)(4326008)(36756003)(2876002)(55446002)(5660300002)(2906002)(86362001)(426003)(83380400001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 10:19:54.2725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3d0ea8-b622-4b2d-351d-08db730a38e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/sfc/siena/selftest.c | 45 ++++++++++++++---------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/selftest.c b/drivers/net/ethernet/sfc/siena/selftest.c
index 07715a3d6bea..c65c62dc642e 100644
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
 } __packed;
+#define EFX_LOOPBACK_PAYLOAD_LEN	(sizeof(struct efx_loopback_payload) - \
+					 offsetof(struct efx_loopback_payload, \
+					 	  header))
 
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

