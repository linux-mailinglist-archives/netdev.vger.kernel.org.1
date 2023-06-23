Return-Path: <netdev+bounces-13513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342A73BE90
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA2D281CAF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C84107B2;
	Fri, 23 Jun 2023 18:39:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC010780
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 18:39:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68283AC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 11:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPiD3KHW5am8XxHtUbiG6stvs9bEZNe0I1LWzHS/Vcy9kt07mgbCCSnWxJwuVNY6wZdtEx1l0TYyIbUEZJa9K/yJ/z8LwgOzPpwb/AnjFzOU/vzP9hvNsI4fZX8+bhAVmHGe1up22sEjhs4d+xD+U0v7xRQQEIWx1QUJWZAnAh+RsARlANmz0NEWQUkch6bMorcdBy7xSs0YIK8pUi6xTEsfvyduRuyATJQ7enZ9Hz7SW3+IukP3o2EE4e7DJ1qn65B79Ceim70V9dkEiR+PMkau3xR99znIrDF/3B24BRWbwsGLvP5F3/i1HVmLT+TsMzMrGFsoTCD0jNR+Mv29nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT9/k6PlOWMJAJI5307WJU9ElYZg9xcjV+KjYFYDDJk=;
 b=a82z0YBRWbYyYjqMlUmzBibopyzLnBgJZnQk9C4hdUxdRdKL5sbRHZ2kNb+i14baqt3h2RNqc+vQADxtm1uXkKFDhsEjpeBOyAqP0H95WlgjT3YCvOvNDtSn+KqQPMfmaNncyOR+RmseB+HQO3XfRQ65AcHTmTelYE59E58fHxBPIkjOZA6xkEo3KcaXtOB1t24MkSe9yv46HBUGOEUIQ69g3lOmgWPo5xvNNpK6gffkzkMyzLdJ47v1gnIM4W0hZrGBnQaHkx4HUmloBdOEMJ6fQYDEljPeu9bmW7DcGnSpSN39NhARIj3HNcn1XM8jZGA8t/RoeeQ/Hx2TrMHvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT9/k6PlOWMJAJI5307WJU9ElYZg9xcjV+KjYFYDDJk=;
 b=FUodrS4ABEf3YXcgLXtXtv3x+ssPZTzr1uVvBF0Zmz2uPIh8s7iy9E02pqDYdAm4ERwYDQ27MsbMcEvJVGKQXbLad89WBFxzuPJzOY6FIzAz0BhYo/QjCVp3M6D25dpGwOwVJcb5T2Dtvl/94bFjSZ5IggNbJqp9ABEWEmvJgwI=
Received: from MN2PR13CA0030.namprd13.prod.outlook.com (2603:10b6:208:160::43)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 18:39:34 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::87) by MN2PR13CA0030.outlook.office365.com
 (2603:10b6:208:160::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.11 via Frontend
 Transport; Fri, 23 Jun 2023 18:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:39:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:39:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:39:32 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Fri, 23 Jun 2023 13:39:31 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <arnd@arndb.de>
Subject: [PATCH v2 net-next 3/3] sfc: falcon: use padding to fix alignment in loopback test
Date: Fri, 23 Jun 2023 19:38:06 +0100
Message-ID: <e155970d3c2be75e52c400e8841d7b3290d89344.1687545312.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: feea0376-673d-4ad0-2cb2-08db74193011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WVEQk3ESzaJaD3bSrSByLTa3WH29Azsh5N9m2i6MtQtqwhdTjpJs/AMe0r9yUMKUNQJCcL/w9p/9kVRk2vITn14Jp3GRJTczDauuRqJWxYQXfWUhJ0cfgm+v94STrnpo1inhuv/DZgYJ2m6vG1wQyf4zPIS0zSJnQmouVrqXLaj1gUxFqrNUQx45V5TtZ8nQmC4ao5d0ZY+VE5JhtqzpmlOIuELz+XrscGkdfWC4N2PKxwdKI2KZz/fgcdQIorjY8IDvSB7dUfV7g25hvQUgh2A17fdX1em3oghbYQaDEIzruCamxmnBeolng2RyFt0EhJs7uEUAD0vXbPDrv7VsLHQSV7AvrbM9tTl6RUann7WnAZBV9yxEQ6x48AZChQ7pmNekSLaz0HCvmUlCfTv5bFMrKP6E5fseAIuQ4q9AJJHXcJrWcxzIhABo6oPpWdcyCdkLraojwVbyBSIHm3uzjiBGbvA8ESzbnNt4unpIR8SL01XMJALZmo6/yNx7kTTlqHzLYEUhP4SK+siymoYa9qu9rRY/svVvmAqzTW0b4Pssu4j4szSQjQrAn937OLTB5fzl3mKbvKPIPn1fujWOB9UApOwgtj3waT0v6L3IuCCJib5/NMCnkC2mJlKQhVFgXmJHWRHJRSXEPi08QFUkj1EPxHSk5Xf7rWtP28kMgpia+0myK0LysHTkF5R0LyECIGFtKggdnHDprbh0uILL35p7d4q9RDQNSvQiJcJNOIqh1gz83+wXEAAAr0a08MnMi4y/DK9iCYCKNOoxKNO08A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(70206006)(70586007)(40460700003)(4326008)(478600001)(36756003)(6666004)(2876002)(54906003)(110136005)(86362001)(55446002)(316002)(336012)(186003)(26005)(47076005)(9686003)(426003)(356005)(82740400003)(83380400001)(81166007)(36860700001)(8936002)(41300700001)(8676002)(5660300002)(2906002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:39:33.2024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feea0376-673d-4ad0-2cb2-08db74193011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Add two bytes of padding to the start of struct ef4_loopback_payload,
 which are not sent on the wire.  This ensures the 'ip' member is
 4-byte aligned, preventing the following W=1 warning:
net/ethernet/sfc/falcon/selftest.c:43:15: error: field ip within 'struct ef4_loopback_payload' is less aligned than 'struct iphdr' and is usually due to 'struct ef4_loopback_payload' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        struct iphdr ip;

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/falcon/selftest.c | 47 +++++++++++++---------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/selftest.c b/drivers/net/ethernet/sfc/falcon/selftest.c
index 6a454ac6f876..9e5ce2a13787 100644
--- a/drivers/net/ethernet/sfc/falcon/selftest.c
+++ b/drivers/net/ethernet/sfc/falcon/selftest.c
@@ -39,12 +39,16 @@
  * Falcon only performs RSS on TCP/UDP packets.
  */
 struct ef4_loopback_payload {
+	char pad[2]; /* Ensures ip is 4-byte aligned */
 	struct ethhdr header;
 	struct iphdr ip;
 	struct udphdr udp;
 	__be16 iteration;
 	char msg[64];
-} __packed;
+} __packed __aligned(4);
+#define EF4_LOOPBACK_PAYLOAD_LEN	(sizeof(struct ef4_loopback_payload) - \
+					 offsetof(struct ef4_loopback_payload, \
+						  header))
 
 /* Loopback test source MAC address */
 static const u8 payload_source[ETH_ALEN] __aligned(2) = {
@@ -284,7 +288,7 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 			    const char *buf_ptr, int pkt_len)
 {
 	struct ef4_loopback_state *state = efx->loopback_selftest;
-	struct ef4_loopback_payload *received;
+	struct ef4_loopback_payload received;
 	struct ef4_loopback_payload *payload;
 
 	BUG_ON(!buf_ptr);
@@ -295,13 +299,14 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 
 	payload = &state->payload;
 
-	received = (struct ef4_loopback_payload *) buf_ptr;
-	received->ip.saddr = payload->ip.saddr;
+	memcpy(&received.header, buf_ptr,
+	       min_t(int, pkt_len, EF4_LOOPBACK_PAYLOAD_LEN));
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
@@ -309,7 +314,7 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 	}
 
 	/* Check that the ethernet header exists */
-	if (memcmp(&received->header, &payload->header, ETH_HLEN) != 0) {
+	if (memcmp(&received.header, &payload->header, ETH_HLEN) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw non-loopback RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -317,16 +322,16 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 	}
 
 	/* Check packet length */
-	if (pkt_len != sizeof(*payload)) {
+	if (pkt_len != EF4_LOOPBACK_PAYLOAD_LEN) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw incorrect RX packet length %d (wanted %d) in "
-			  "%s loopback test\n", pkt_len, (int)sizeof(*payload),
-			  LOOPBACK_MODE(efx));
+			  "%s loopback test\n", pkt_len,
+			  (int)EF4_LOOPBACK_PAYLOAD_LEN, LOOPBACK_MODE(efx));
 		goto err;
 	}
 
 	/* Check that IP header matches */
-	if (memcmp(&received->ip, &payload->ip, sizeof(payload->ip)) != 0) {
+	if (memcmp(&received.ip, &payload->ip, sizeof(payload->ip)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted IP header in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -334,7 +339,7 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 	}
 
 	/* Check that msg and padding matches */
-	if (memcmp(&received->msg, &payload->msg, sizeof(received->msg)) != 0) {
+	if (memcmp(&received.msg, &payload->msg, sizeof(received.msg)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -342,10 +347,10 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
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
@@ -365,7 +370,8 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 			       buf_ptr, pkt_len, 0);
 		netif_err(efx, drv, efx->net_dev, "expected packet:\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 0x10, 1,
-			       &state->payload, sizeof(state->payload), 0);
+			       &state->payload.header, EF4_LOOPBACK_PAYLOAD_LEN,
+			       0);
 	}
 #endif
 	atomic_inc(&state->rx_bad);
@@ -387,14 +393,15 @@ static void ef4_iterate_state(struct ef4_nic *efx)
 	payload->ip.daddr = htonl(INADDR_LOOPBACK);
 	payload->ip.ihl = 5;
 	payload->ip.check = (__force __sum16) htons(0xdead);
-	payload->ip.tot_len = htons(sizeof(*payload) - sizeof(struct ethhdr));
+	payload->ip.tot_len = htons(sizeof(*payload) -
+				    offsetof(struct ef4_loopback_payload, ip));
 	payload->ip.version = IPVERSION;
 	payload->ip.protocol = IPPROTO_UDP;
 
 	/* Initialise udp header */
 	payload->udp.source = 0;
-	payload->udp.len = htons(sizeof(*payload) - sizeof(struct ethhdr) -
-				 sizeof(struct iphdr));
+	payload->udp.len = htons(sizeof(*payload) -
+				 offsetof(struct ef4_loopback_payload, udp));
 	payload->udp.check = 0;	/* checksum ignored */
 
 	/* Fill out payload */
@@ -420,7 +427,7 @@ static int ef4_begin_loopback(struct ef4_tx_queue *tx_queue)
 	for (i = 0; i < state->packet_count; i++) {
 		/* Allocate an skb, holding an extra reference for
 		 * transmit completion counting */
-		skb = alloc_skb(sizeof(state->payload), GFP_KERNEL);
+		skb = alloc_skb(EF4_LOOPBACK_PAYLOAD_LEN, GFP_KERNEL);
 		if (!skb)
 			return -ENOMEM;
 		state->skbs[i] = skb;
@@ -431,6 +438,8 @@ static int ef4_begin_loopback(struct ef4_tx_queue *tx_queue)
 		payload = skb_put(skb, sizeof(state->payload));
 		memcpy(payload, &state->payload, sizeof(state->payload));
 		payload->ip.saddr = htonl(INADDR_LOOPBACK | (i << 2));
+		/* Strip off the leading padding */
+		skb_pull(skb, offsetof(struct ef4_loopback_payload, header));
 
 		/* Ensure everything we've written is visible to the
 		 * interrupt handler. */

