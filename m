Return-Path: <netdev+bounces-298117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O96bF7OsKmoquwMAu9opvQ
	(envelope-from <netdev+bounces-298117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:40:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D73F1671EE4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:40:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=couthit.com header.s=default header.b="Yc+r/EUk";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298117-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298117-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=couthit.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C30130C59BB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF03F7ABB;
	Thu, 11 Jun 2026 12:37:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF23F7A9E;
	Thu, 11 Jun 2026 12:37:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181477; cv=none; b=DB/9p+axy29D63DBBOypgrFObHuoe+gKNMRMWj9865Gc2reixnEDEzEo84MTaDnkMTaaosgtTqsAu1C+F+AKTAI5KTmm/B1C2PV5/vpIGnF0Qh737cuNzZ3h+LlwdPMo68yHANdxm6OG3udw54W3QHtt1gATSNQs7C+fdsjyGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181477; c=relaxed/simple;
	bh=PnWgRs5XX4tztsJBfIcDz1xMdghEv3oWOO+CrbV5qHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8kj3itko6qTdE+60i+p56p4LylD7Wp0xnAbyQ5Gai321lTnNd6FxvtTpAdEHFKetURyWyv0q49EYlDD0N2slQ4aaFG3XE6rkjPkM3WcOtkKRnnX3Xz4ajqzSKnxE3tqM6guiF2pyFKpgLSrEYZr85ln64phw+eFRMrQvuqlc84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=Yc+r/EUk; arc=none smtp.client-ip=162.240.164.96
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BSKnMLL05XPfaGuUTr9xoqwIONsgvYHq9TftenSDfi4=; b=Yc+r/EUk5Ba+q2gD5Imgd36tGQ
	H0lTzdeik+IvoQbO6V7R/qFur3kgM40SIyjf4OHNtFMnzUjIo3ztfg0yhbiB7DyUMQYCxM2kX7y27
	/fTLB0Q+pwPWPK8q3F3Eb1xZMzhTC2rezWmvYtRgM9PU3XDuWqEFUfKLABNE5oVnuIMdSgDeNEeE5
	NhxbTobtgr96yyJOdXL970q5Cw6An4cRvE5wBDpyCOXkwT6TeYh5RUGBGwrn+AktQgabd756eFngl
	nCZxUCK4L3VrhG6KFGnGvovjdNsI6ACa1FJ4IOQT1wX2oGogvwo5AJlqs24cB3/Dqv8jQqVrBCeDl
	X9yRzhgA==;
Received: from [115.246.246.98] (port=61440 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wXefQ-0000000611E-3NTf;
	Thu, 11 Jun 2026 08:37:53 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	basharath@couthit.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next 3/3] net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
Date: Thu, 11 Jun 2026 18:03:28 +0530
Message-ID: <20260611123636.376577-4-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611123636.376577-1-parvathi@couthit.com>
References: <20260611123636.376577-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[couthit.com:s=default];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298117-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	HAS_X_GMSV(0.00)[parvathi@couthit.com];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_X_AS(0.00)[parvathi@couthit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:parvathi@couthit.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	HAS_X_SOURCE(0.00)[];
	DKIM_TRACE(0.00)[couthit.com:-];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_X_ANTIABUSE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D73F1671EE4

From: Roger Quadros <rogerq@ti.com>

In HSR and PRP modes each outgoing frame must be sent on both PRU slave
ports.

Previously the driver was writing the frame into each port's transmit queue
independently after updating the tags resulting in performing two OCMC
buffer copy operations.

Frame duplicate offloading is implemented with a common shared queue
between the two ports. The driver writes the frame once into OCMC RAM,
each port reads from the shared queue and replicates the transmission to
both PRU ports, synchronising between PRU ports are maintained within
firmware with appropriate handling.

For HSR the driver inspects the encapsulated ethertype in the HSR tag.
PTP frames (ETH_P_1588) are sent on the directed port only to avoid double
duplication and all other HSR frames are duplicated to both ports.
VLAN-tagged HSR frames are handled by advancing past the 4-byte VLAN header
before reading the HSR tag.

For PRP the driver checks the 6-byte RCT trailer for the ETH_P_PRP suffix
to identify redundancy-tagged frames. Frames without an RCT are sent on the
originating port only.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 218 +++++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   9 +-
 .../ethernet/ti/icssm/icssm_prueth_common.c   |   7 +-
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 310 +++++++++++++++++-
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   1 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  35 +-
 6 files changed, 549 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 58a6935dd809..e2d66239380b 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -36,6 +36,7 @@
 #include "../icssg/icss_iep.h"
 
 #define OCMC_RAM_SIZE		(SZ_64K)
+#define PRUETH_ETHER_TYPE_OFFSET	12
 
 #define TX_START_DELAY		0x40
 #define TX_CLK_DELAY_100M	0x6
@@ -76,6 +77,32 @@ static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
 	}
 }
 
+/* Queue Descriptors initialization for HSR PRP */
+const struct prueth_queue_desc hsr_prp_txopt_queue_descs[][NUM_QUEUES] = {
+	[PRUETH_PORT_QUEUE_HOST] = {
+		{ .rd_ptr = P0_Q1_BD_OFFSET, .wr_ptr = P0_Q1_BD_OFFSET, },
+		{ .rd_ptr = P0_Q2_BD_OFFSET, .wr_ptr = P0_Q2_BD_OFFSET, },
+		{ .rd_ptr = P0_Q3_BD_OFFSET, .wr_ptr = P0_Q3_BD_OFFSET, },
+		{ .rd_ptr = P0_Q4_BD_OFFSET, .wr_ptr = P0_Q4_BD_OFFSET, },
+	},
+	[PRUETH_PORT_QUEUE_MII0] = {
+		{ .rd_ptr = P0_Q3_BD_OFFSET, .wr_ptr = P0_Q3_BD_OFFSET, },
+		{ .rd_ptr = P0_Q4_BD_OFFSET, .wr_ptr = P0_Q4_BD_OFFSET, },
+		{ .rd_ptr = P1_Q3_TXOPT_BD_OFFSET,
+			.wr_ptr = P1_Q3_TXOPT_BD_OFFSET, },
+		{ .rd_ptr = P2_Q1_TXOPT_BD_OFFSET,
+			.wr_ptr = P2_Q1_TXOPT_BD_OFFSET, },
+	},
+	[PRUETH_PORT_QUEUE_MII1] = {
+		{ .rd_ptr = P0_Q1_BD_OFFSET, .wr_ptr = P0_Q1_BD_OFFSET, },
+		{ .rd_ptr = P0_Q2_BD_OFFSET, .wr_ptr = P0_Q2_BD_OFFSET, },
+		{ .rd_ptr = P1_Q3_TXOPT_BD_OFFSET,
+			.wr_ptr = P1_Q3_TXOPT_BD_OFFSET, },
+		{ .rd_ptr = P2_Q1_TXOPT_BD_OFFSET,
+			.wr_ptr = P2_Q1_TXOPT_BD_OFFSET, },
+	}
+};
+
 static void icssm_prueth_write_reg(struct prueth *prueth,
 				   enum prueth_mem region,
 				   unsigned int reg, u32 val)
@@ -94,6 +121,17 @@ static void icssm_prueth_write_reg(struct prueth *prueth,
 static enum pruss_mem pruss_mem_ids[] = { PRUSS_MEM_DRAM0, PRUSS_MEM_DRAM1,
 					  PRUSS_MEM_SHRD_RAM2 };
 
+struct prp_txopt_rct {
+	__be16 sequence_nr;
+	__be16 lan_id_and_lsdu_size;
+	__be16 prp_suffix;
+};
+
+struct hsr_txopt_ethhdr {
+	struct ethhdr ethhdr;
+	struct hsr_tag hsr_tag;
+};
+
 static const struct prueth_queue_info queue_infos[][NUM_QUEUES] = {
 	[PRUETH_PORT_QUEUE_HOST] = {
 		[PRUETH_QUEUE1] = {
@@ -546,15 +584,25 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 				   struct sk_buff *skb,
 				   enum prueth_queue_id queue_id)
 {
+	struct prueth_queue_desc __iomem *queue_desc_other_port = NULL;
 	struct prueth_queue_desc __iomem *queue_desc;
 	const struct prueth_queue_info *txqueue;
 	struct net_device *ndev = emac->ndev;
 	struct prueth *prueth = emac->prueth;
+	struct hsr_txopt_ethhdr *hsr_ethhdr;
 	unsigned int buffer_desc_count;
+	struct prueth_emac *other_emac;
 	int free_blocks, update_block;
+	struct vlan_ethhdr *vlan_hdr;
 	bool buffer_wrapped = false;
 	int write_block, read_block;
+	int free_blocks_other_port;
+	int read_block_other_port;
 	void *src_addr, *dst_addr;
+	u16 bd_rd_ptr_other_port;
+	struct ethhdr *ethhdr;
+	bool is_vlan = false;
+	bool link_up = false;
 	int pkt_block_size;
 	void __iomem *sram;
 	void __iomem *dram;
@@ -562,6 +610,14 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	u16 update_wr_ptr;
 	u32 wr_buf_desc;
 	void *ocmc_ram;
+	__be16 proto;
+	u8 *hdr;
+
+	other_emac = emac->prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
+				PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
+
+	if (prueth_is_lre(prueth) && (emac->link || other_emac->link))
+		link_up = true;
 
 	if (!PRUETH_IS_EMAC(prueth))
 		dram = prueth->mem[PRUETH_MEM_DRAM1].va;
@@ -579,7 +635,10 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	pktlen = skb->len;
 	/* Get the tx queue */
 	queue_desc = emac->tx_queue_descs + queue_id;
-	if (!PRUETH_IS_EMAC(prueth))
+	/* Tx queue context */
+	if (prueth_is_lre(prueth))
+		txqueue = &lre_queue_infos[txport][queue_id];
+	else if (PRUETH_IS_SWITCH(prueth))
 		txqueue = &sw_queue_infos[txport][queue_id];
 	else
 		txqueue = &queue_infos[txport][queue_id];
@@ -602,6 +661,29 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 		free_blocks = buffer_desc_count;
 	}
 
+	/* Fetch queue state for the second LRE port */
+	if (prueth_is_lre(prueth) && link_up) {
+		queue_desc_other_port = emac->tx_queue_descs_other_port +
+					queue_id;
+		bd_rd_ptr_other_port = readw(&queue_desc_other_port->rd_ptr);
+
+		read_block_other_port = (bd_rd_ptr_other_port -
+					 txqueue->buffer_desc_offset) / BD_SIZE;
+
+		if (write_block > read_block_other_port) {
+			free_blocks_other_port = buffer_desc_count -
+						 write_block;
+			free_blocks_other_port += read_block_other_port;
+		} else if (write_block < read_block_other_port) {
+			free_blocks_other_port = read_block_other_port -
+						 write_block;
+		} else {
+			free_blocks_other_port = buffer_desc_count;
+		}
+
+		if (free_blocks_other_port < free_blocks)
+			free_blocks = free_blocks_other_port;
+	}
 	pkt_block_size = DIV_ROUND_UP(pktlen, ICSS_BLOCK_SIZE);
 	if (pkt_block_size > free_blocks) /* out of queue space */
 		return -ENOBUFS;
@@ -651,6 +733,57 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	if (PRUETH_IS_HSR(prueth))
 		wr_buf_desc |= BIT(PRUETH_BD_HSR_FRAME_SHIFT);
 
+	if (prueth_is_lre(prueth)) {
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
+		proto = ethhdr->h_proto;
+
+		if (proto == htons(ETH_P_8021Q)) {
+			vlan_hdr = (struct vlan_ethhdr *)ethhdr;
+			proto = vlan_hdr->h_vlan_encapsulated_proto;
+			is_vlan = true;
+		}
+
+		/* Extract HSR sequence number and LAN ID
+		 * from the tag for the Buffer Descriptor
+		 */
+		if (proto == htons(ETH_P_HSR)) {
+			hdr = skb_mac_header(skb);
+
+			if (is_vlan) {
+				hsr_ethhdr =
+					(struct hsr_txopt_ethhdr *)(hdr +
+								    VLAN_HLEN);
+			} else {
+				hsr_ethhdr = (struct hsr_txopt_ethhdr *)hdr;
+			}
+
+			/* PTP frames (ETH_P_1588) carry no LAN ID
+			 * in the HSR tag
+			 */
+			if (hsr_ethhdr->hsr_tag.encap_proto !=
+			    htons(ETH_P_1588)) {
+				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
+			} else {
+				wr_buf_desc |= (txport <<
+						PRUETH_BD_LAN_A_SHIFT);
+			}
+			wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
+		} else {
+			/* Read PRP RCT to extract sequence number and LAN ID */
+			struct prp_txopt_rct *rct =
+				(struct prp_txopt_rct *)(skb_tail_pointer(skb) -
+							 ICSSM_LRE_TAG_SIZE);
+
+			if (rct->prp_suffix == htons(ETH_P_PRP)) {
+				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
+				wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
+			} else {
+				wr_buf_desc |= (txport <<
+						PRUETH_BD_LAN_A_SHIFT);
+			}
+		}
+	}
+
 	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
 	if (!PRUETH_IS_EMAC(prueth))
 		writel(wr_buf_desc, sram + readw(&queue_desc->wr_ptr));
@@ -663,6 +796,10 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	update_wr_ptr = txqueue->buffer_desc_offset + (update_block * BD_SIZE);
 	writew(update_wr_ptr, &queue_desc->wr_ptr);
 
+	/* update the write pointer in queue descriptor of other port */
+	if (prueth_is_lre(prueth) && link_up)
+		writew(update_wr_ptr, &queue_desc_other_port->wr_ptr);
+
 	return 0;
 }
 
@@ -675,8 +812,10 @@ void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
 	else
 		pkt_info->start_offset = false;
 
-	pkt_info->port = (buffer_descriptor & PRUETH_BD_PORT_MASK) >>
-			 PRUETH_BD_PORT_SHIFT;
+	/* Flag from BD to indicate packet is valid for HOST or not. */
+	pkt_info->host_recv_flag = !!(buffer_descriptor &
+				      PRUETH_BD_HOST_RECV_MASK);
+
 	pkt_info->length = (buffer_descriptor & PRUETH_BD_LENGTH_MASK) >>
 			   PRUETH_BD_LENGTH_SHIFT;
 	pkt_info->broadcast = !!(buffer_descriptor & PRUETH_BD_BROADCAST_MASK);
@@ -708,11 +847,13 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 	int read_block, update_block;
 	unsigned int actual_pkt_len;
 	bool buffer_wrapped = false;
+	int adjust_for_hsr_tag = 0;
 	void *src_addr, *dst_addr;
 	u16 start_offset = 0;
 	struct sk_buff *skb;
 	int pkt_block_size;
 	void *ocmc_ram;
+	u16 type;
 
 	if (PRUETH_IS_HSR(emac->prueth))
 		start_offset = (pkt_info->start_offset ?
@@ -739,9 +880,19 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 	/* calculate new pointer in ram */
 	*bd_rd_ptr = rxqueue->buffer_desc_offset + (update_block * BD_SIZE);
 
+	if (PRUETH_IS_HSR(emac->prueth)) {
+		if (!pkt_info->host_recv_flag)
+			return 0;
+	}
+
 	/* Exclude the HSR tag bytes already stripped by firmware, if any. */
 	actual_pkt_len = pkt_info->length - start_offset;
 
+	if (PRUETH_IS_HSR(emac->prueth)) {
+		if (!start_offset && !pkt_info->timestamp)
+			actual_pkt_len -= ICSSM_LRE_TAG_SIZE;
+	}
+
 	/* Allocate a socket buffer for this packet */
 	skb = netdev_alloc_skb_ip_align(ndev, actual_pkt_len);
 	if (!skb) {
@@ -762,6 +913,29 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 		   (read_block * ICSS_BLOCK_SIZE);
 	src_addr += start_offset;
 
+	/* Copy destination and source MAC address */
+	memcpy(dst_addr, src_addr, PRUETH_ETHER_TYPE_OFFSET);
+	src_addr += PRUETH_ETHER_TYPE_OFFSET;
+	dst_addr += PRUETH_ETHER_TYPE_OFFSET;
+
+	adjust_for_hsr_tag += PRUETH_ETHER_TYPE_OFFSET;
+
+	/* Check for VLAN tag */
+	type = get_unaligned_be16(src_addr);
+
+	if (type == ETH_P_8021Q) {
+		memcpy(dst_addr, src_addr, VLAN_HLEN);
+		src_addr += VLAN_HLEN;
+		dst_addr += VLAN_HLEN;
+		adjust_for_hsr_tag += VLAN_HLEN;
+	}
+
+	/* HSR tag removal handling */
+	if (PRUETH_IS_HSR(emac->prueth)) {
+		if (!start_offset && !pkt_info->timestamp)
+			src_addr += ICSSM_LRE_TAG_SIZE;
+	}
+
 	/* Copy the data from PRU buffers(OCMC) to socket buffer(DRAM) */
 	if (buffer_wrapped) { /* wrapped around buffer */
 		int bytes = (buffer_desc_count - read_block) * ICSS_BLOCK_SIZE;
@@ -777,19 +951,25 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 		/* If applicable, account for the HSR tag removed */
 		bytes -= start_offset;
 
+		if (PRUETH_IS_HSR(emac->prueth)) {
+			if (!start_offset && !pkt_info->timestamp)
+				bytes -= ICSSM_LRE_TAG_SIZE;
+		}
+
 		/* copy non-wrapped part */
-		memcpy(dst_addr, src_addr, bytes);
+		memcpy(dst_addr, src_addr, bytes - adjust_for_hsr_tag);
 
 		/* copy wrapped part */
-		dst_addr += bytes;
+		dst_addr += (bytes - adjust_for_hsr_tag);
 		remaining = actual_pkt_len - bytes;
 
 		src_addr = ocmc_ram + rxqueue->buffer_offset;
 		memcpy(dst_addr, src_addr, remaining);
 		src_addr += remaining;
 	} else {
-		memcpy(dst_addr, src_addr, actual_pkt_len);
-		src_addr += actual_pkt_len;
+		memcpy(dst_addr, src_addr, actual_pkt_len -
+		       adjust_for_hsr_tag);
+		src_addr += actual_pkt_len - adjust_for_hsr_tag;
 	}
 
 	if (PRUETH_IS_SWITCH(emac->prueth)) {
@@ -1313,11 +1493,20 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
 						struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
+	raw_spinlock_t *lock_queue;
 	int ret;
 	u16 qid;
 
 	qid = icssm_prueth_get_tx_queue_id(emac->prueth, skb);
+	/* Select the TX queue spin lock for this queue ID */
+	if (prueth_is_lre(emac->prueth))
+		lock_queue = &emac->prueth->lre_host_queue_lock[qid - 2];
+	else
+		lock_queue = &emac->host_queue_lock[qid - 2];
+
+	raw_spin_lock(lock_queue);
 	ret = icssm_prueth_tx_enqueue(emac, skb, qid);
+	raw_spin_unlock(lock_queue);
 	if (ret) {
 		if (ret != -ENOBUFS && netif_msg_tx_err(emac) &&
 		    net_ratelimit())
@@ -1682,6 +1871,9 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 	spin_lock_init(&emac->lock);
 	spin_lock_init(&emac->addr_lock);
 
+	raw_spin_lock_init(&emac->host_queue_lock[0]);
+	raw_spin_lock_init(&emac->host_queue_lock[1]);
+
 	/* get mac address from DT and set private and netdev addr */
 	ret = of_get_ethdev_address(eth_node, ndev);
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
@@ -1719,7 +1911,9 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 
 	if (prueth->support_lre)
 		ndev->hw_features |=
-			(NETIF_F_HW_HSR_FWD | NETIF_F_HW_HSR_TAG_RM);
+			(NETIF_F_HW_HSR_FWD |
+			 NETIF_F_HW_HSR_TAG_RM |
+			 NETIF_F_HW_HSR_DUP);
 
 	ndev->dev.of_node = eth_node;
 	ndev->netdev_ops = &emac_netdev_ops;
@@ -1947,9 +2141,11 @@ static int icssm_prueth_hsr_port_link(struct net_device *ndev,
 		if (prueth->hsr_members & BIT(PRUETH_PORT_MII0) &&
 		    prueth->hsr_members & BIT(PRUETH_PORT_MII1)) {
 			if (!(emac0->ndev->features &
-			    (NETIF_F_HW_HSR_TAG_RM | NETIF_F_HW_HSR_FWD)) &&
+			    (NETIF_F_HW_HSR_TAG_RM | NETIF_F_HW_HSR_FWD |
+			     NETIF_F_HW_HSR_DUP)) &&
 			    !(emac1->ndev->features &
-			    (NETIF_F_HW_HSR_TAG_RM | NETIF_F_HW_HSR_FWD)))
+			    (NETIF_F_HW_HSR_TAG_RM | NETIF_F_HW_HSR_FWD |
+			     NETIF_F_HW_HSR_DUP)))
 				return -EOPNOTSUPP;
 
 			ret = icssm_prueth_change_mode(prueth, mode);
@@ -2275,6 +2471,8 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	}
 
 	prueth->support_lre = has_lre;
+	raw_spin_lock_init(&prueth->lre_host_queue_lock[0]);
+	raw_spin_lock_init(&prueth->lre_host_queue_lock[1]);
 	/* setup netdev interfaces */
 	if (eth0_node) {
 		ret = icssm_prueth_netdev_init(prueth, eth0_node);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index 60dc451f79e5..b7f6919fbd45 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -104,7 +104,7 @@ struct prueth_queue_info {
 struct prueth_packet_info {
 	bool start_offset;
 	bool shadow;
-	unsigned int port;
+	bool host_recv_flag;
 	unsigned int length;
 	bool broadcast;
 	bool error;
@@ -239,6 +239,8 @@ struct prueth_emac {
 	struct phy_device *phydev;
 	struct prueth_queue_desc __iomem *rx_queue_descs;
 	struct prueth_queue_desc __iomem *tx_queue_descs;
+	/* LRE duplicates each TX frame to both ports */
+	struct prueth_queue_desc __iomem *tx_queue_descs_other_port;
 
 	int link;
 	int speed;
@@ -262,6 +264,7 @@ struct prueth_emac {
 	spinlock_t lock;
 	spinlock_t addr_lock;   /* serialize access to VLAN/MC filter table */
 
+	raw_spinlock_t host_queue_lock[NUM_QUEUES / 2];
 	struct hrtimer tx_hrtimer;
 	struct prueth_emac_stats stats;
 	int offload_fwd_mark;
@@ -311,9 +314,13 @@ struct prueth {
 	u8 emac_configured;
 	u8 hsr_members;
 	u8 br_members;
+
+	/* Per-queue TX lock - LRE uses only the two high-priority queues */
+	raw_spinlock_t lre_host_queue_lock[NUM_QUEUES / 2];
 };
 
 extern const struct prueth_queue_desc queue_descs[][NUM_QUEUES];
+extern const struct prueth_queue_desc hsr_prp_txopt_queue_descs[][NUM_QUEUES];
 
 void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
 			     struct prueth_packet_info *pkt_info);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
index 4820def5f9e1..27f94a0e0735 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
@@ -141,16 +141,13 @@ static int icssm_prueth_common_emac_rx_packets(struct prueth_emac *emac,
 			used++;
 		}
 
-		/* Zero the BD after consuming it, a misaligned rd_ptr
-		 * would otherwise mistake stale data for a valid incoming
-		 * frame.
+		/* Leave the BD intact after reading. Firmware reuses it to
+		 * forward the frame to the second LRE port.
 		 */
 		if (port == 0) {
-			writel(0, shared_ram + bd_rd_ptr);
 			writew(update_rd_ptr, &queue_desc->rd_ptr);
 			bd_rd_ptr = update_rd_ptr;
 		} else {
-			writel(0, shared_ram + bd_rd_ptr_o);
 			writew(update_rd_ptr, &queue_desc_o->rd_ptr);
 			bd_rd_ptr_o = update_rd_ptr;
 		}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
index 66866ea37913..1b2486170ab3 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
@@ -199,6 +199,189 @@ static const struct prueth_queue_info rx_queue_infos[][NUM_QUEUES] = {
 	},
 };
 
+/* Tx Queue context for HSR and PRP */
+const struct prueth_queue_info lre_queue_infos[][NUM_QUEUES] = {
+	[PRUETH_PORT_QUEUE_HOST] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET,
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 8,
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P0_Q3_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 16,
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P0_Q4_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 24,
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII0] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q3_BUFFER_OFFSET,
+			P0_Q3_BUFFER_OFFSET +
+				((HOST_QUEUE_3_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q4_BUFFER_OFFSET,
+			P0_Q4_BUFFER_OFFSET +
+				((HOST_QUEUE_4_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_TXOPT_BUFFER_OFFSET,
+			P1_Q3_TXOPT_BUFFER_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P1_Q3_TXOPT_BD_OFFSET,
+			P1_Q3_TXOPT_BD_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q1_TXOPT_BUFFER_OFFSET,
+			P2_Q1_TXOPT_BUFFER_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P2_Q1_TXOPT_BD_OFFSET,
+			P2_Q1_TXOPT_BD_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII1] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			P0_Q1_BUFFER_OFFSET +
+				((HOST_QUEUE_1_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET +
+				((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			P0_Q2_BUFFER_OFFSET +
+				((HOST_QUEUE_2_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET +
+				((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_TXOPT_BUFFER_OFFSET,
+			P1_Q3_TXOPT_BUFFER_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P1_Q3_TXOPT_BD_OFFSET,
+			P1_Q3_TXOPT_BD_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q1_TXOPT_BUFFER_OFFSET,
+			P2_Q1_TXOPT_BUFFER_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P2_Q1_TXOPT_BD_OFFSET,
+			P2_Q1_TXOPT_BD_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+
+	},
+};
+
+/* Rx Queue Context for HSR and PRP */
+static const struct prueth_queue_info lre_rx_queue_infos[][NUM_QUEUES] = {
+	[PRUETH_PORT_QUEUE_HOST] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET,
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 8,
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P0_Q3_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 16,
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P0_Q4_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 24,
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII0] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q3_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET,
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q4_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 8,
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_TXOPT_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 16,
+			P1_Q3_TXOPT_BD_OFFSET,
+			P1_Q3_TXOPT_BD_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q1_TXOPT_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 24,
+			P2_Q1_TXOPT_BD_OFFSET,
+			P2_Q1_TXOPT_BD_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII1] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET,
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 8,
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_TXOPT_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 16,
+			P1_Q3_TXOPT_BD_OFFSET,
+			P1_Q3_TXOPT_BD_OFFSET +
+				((QUEUE_3_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q1_TXOPT_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 24,
+			P2_Q1_TXOPT_BD_OFFSET,
+			P2_Q1_TXOPT_BD_OFFSET +
+				((QUEUE_4_TXOPT_SIZE - 1) * BD_SIZE),
+		},
+	},
+};
+
 void icssm_prueth_sw_free_fdb_table(struct prueth *prueth)
 {
 	if (prueth->emac_configured)
@@ -856,8 +1039,12 @@ void icssm_prueth_sw_hostconfig(struct prueth *prueth)
 
 	/* queue information table */
 	dram = dram1_base + P0_Q1_RX_CONTEXT_OFFSET;
-	memcpy_toio(dram, sw_queue_infos[PRUETH_PORT_QUEUE_HOST],
-		    sizeof(sw_queue_infos[PRUETH_PORT_QUEUE_HOST]));
+	if (prueth_is_lre(prueth))
+		memcpy_toio(dram, lre_queue_infos[PRUETH_PORT_QUEUE_HOST],
+			    sizeof(lre_queue_infos[PRUETH_PORT_QUEUE_HOST]));
+	else
+		memcpy_toio(dram, sw_queue_infos[PRUETH_PORT_QUEUE_HOST],
+			    sizeof(sw_queue_infos[PRUETH_PORT_QUEUE_HOST]));
 
 	/* buffer descriptor offset table*/
 	dram = dram1_base + QUEUE_DESCRIPTOR_OFFSET_ADDR;
@@ -882,8 +1069,15 @@ void icssm_prueth_sw_hostconfig(struct prueth *prueth)
 
 	/* queue table */
 	dram = dram1_base + P0_QUEUE_DESC_OFFSET;
-	memcpy_toio(dram, queue_descs[PRUETH_PORT_QUEUE_HOST],
-		    sizeof(queue_descs[PRUETH_PORT_QUEUE_HOST]));
+	if (prueth_is_lre(prueth))
+		memcpy_toio(dram,
+			    hsr_prp_txopt_queue_descs[PRUETH_PORT_QUEUE_HOST],
+			    sizeof(hsr_prp_txopt_queue_descs
+				    [PRUETH_PORT_QUEUE_HOST]));
+	else
+		memcpy_toio(dram, queue_descs[PRUETH_PORT_QUEUE_HOST],
+			    sizeof(queue_descs[PRUETH_PORT_QUEUE_HOST]));
+
 }
 
 static int icssm_prueth_sw_port_config(struct prueth *prueth,
@@ -975,6 +1169,109 @@ static int icssm_prueth_sw_port_config(struct prueth *prueth,
 	return 0;
 }
 
+/* Configure TX/RX queue contexts and buffer descriptor tables for LRE port */
+static int icssm_prueth_lre_port_config(struct prueth *prueth,
+					enum prueth_port port_id)
+{
+	unsigned int tx_context_ofs_addr, rx_context_ofs, queue_desc_ofs;
+	void __iomem *dram, *dram_base, *dram_mac;
+	struct prueth_emac *emac;
+
+	emac = prueth->emac[port_id - 1];
+	switch (port_id) {
+	case PRUETH_PORT_MII0:
+		tx_context_ofs_addr     = TX_CONTEXT_P1_Q1_OFFSET_ADDR;
+		rx_context_ofs          = P1_Q1_RX_CONTEXT_OFFSET;
+		queue_desc_ofs          = P1_QUEUE_DESC_OFFSET;
+		/* for switch PORT MII0 mac addr is in DRAM0. */
+		dram_mac = prueth->mem[PRUETH_MEM_DRAM0].va;
+		break;
+	case PRUETH_PORT_MII1:
+		tx_context_ofs_addr     = TX_CONTEXT_P2_Q1_OFFSET_ADDR;
+		rx_context_ofs          = P2_Q1_RX_CONTEXT_OFFSET;
+		queue_desc_ofs          = P2_QUEUE_DESC_OFFSET;
+
+		/* for switch PORT MII1 mac addr is in DRAM1. */
+		dram_mac = prueth->mem[PRUETH_MEM_DRAM1].va;
+		break;
+	default:
+		netdev_err(emac->ndev, "invalid port\n");
+		return -EINVAL;
+	}
+
+	/* setup mac address */
+	memcpy_toio(dram_mac + PORT_MAC_ADDR, emac->mac_addr, ETH_ALEN);
+
+	/* Remaining switch port configs are in DRAM1 */
+	dram_base = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	/* queue information table */
+	memcpy_toio(dram_base + tx_context_ofs_addr,
+		    lre_queue_infos[port_id],
+		    sizeof(lre_queue_infos[port_id]));
+
+	memcpy_toio(dram_base + rx_context_ofs,
+		    lre_rx_queue_infos[port_id],
+		    sizeof(lre_rx_queue_infos[port_id]));
+
+	/* buffer descriptor offset table*/
+	dram = dram_base + QUEUE_DESCRIPTOR_OFFSET_ADDR +
+		(port_id * NUM_QUEUES * sizeof(u16));
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE1].buffer_desc_offset,
+	       dram);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE2].buffer_desc_offset,
+	       dram + 2);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE3].buffer_desc_offset,
+	       dram + 4);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE4].buffer_desc_offset,
+	       dram + 6);
+
+	/* buffer offset table */
+	dram = dram_base + QUEUE_OFFSET_ADDR +
+		port_id * NUM_QUEUES * sizeof(u16);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE1].buffer_offset, dram);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE2].buffer_offset,
+	       dram + 2);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE3].buffer_offset,
+	       dram + 4);
+	writew(lre_queue_infos[port_id][PRUETH_QUEUE4].buffer_offset,
+	       dram + 6);
+
+	/* queue size lookup table */
+	dram = dram_base + QUEUE_SIZE_ADDR +
+		port_id * NUM_QUEUES * sizeof(u16);
+	writew(HOST_QUEUE_1_SIZE, dram);
+	writew(HOST_QUEUE_2_SIZE, dram + 2);
+	writew(QUEUE_3_TXOPT_SIZE, dram + 4);
+	writew(QUEUE_4_TXOPT_SIZE, dram + 6);
+
+	/* queue table */
+	memcpy_toio(dram_base + queue_desc_ofs,
+		    &hsr_prp_txopt_queue_descs[port_id][0],
+		    4 * sizeof(hsr_prp_txopt_queue_descs[port_id][0]));
+
+	/* In HSR/PRP mode both slave ports share the host receive queue
+	 * descriptor region (P0_QUEUE_DESC_OFFSET). The firmware arbitrates
+	 * ownership; the driver always reads from the same host-side descriptor
+	 * base regardless of which physical port the frame arrived on.
+	 */
+	emac->rx_queue_descs = dram_base + P0_QUEUE_DESC_OFFSET;
+	emac->tx_queue_descs = dram_base +
+		lre_rx_queue_infos[port_id][PRUETH_QUEUE1].queue_desc_offset;
+
+	if (port_id == PRUETH_PORT_MII0) {
+		emac->tx_queue_descs_other_port = dram_base +
+			lre_rx_queue_infos
+			[port_id + 1][PRUETH_QUEUE1].queue_desc_offset;
+	} else if (port_id == PRUETH_PORT_MII1) {
+		emac->tx_queue_descs_other_port = dram_base +
+			lre_rx_queue_infos
+			[port_id - 1][PRUETH_QUEUE1].queue_desc_offset;
+	}
+
+	return 0;
+}
+
 int icssm_prueth_sw_emac_config(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
@@ -989,7 +1286,10 @@ int icssm_prueth_sw_emac_config(struct prueth_emac *emac)
 	if (prueth->emac_configured & BIT(emac->port_id))
 		return 0;
 
-	ret = icssm_prueth_sw_port_config(prueth, emac->port_id);
+	if (prueth_is_lre(prueth))
+		ret = icssm_prueth_lre_port_config(prueth, emac->port_id);
+	else
+		ret = icssm_prueth_sw_port_config(prueth, emac->port_id);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
index e6111bba166e..0f4595c6075f 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
@@ -17,6 +17,7 @@ u8 icssm_prueth_sw_get_stp_state(struct prueth *prueth,
 				 enum prueth_port port);
 
 extern const struct prueth_queue_info sw_queue_infos[][4];
+extern const struct prueth_queue_info lre_queue_infos[][4];
 
 void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth);
 int icssm_prueth_sw_init_fdb_table(struct prueth *prueth);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
index 5ba9ce14da44..089e43cadc25 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h
@@ -24,6 +24,9 @@
 #define QUEUE_3_SIZE		97	/* Protocol specific */
 #define QUEUE_4_SIZE		97	/* NRT (IP,ARP, ICMP) */
 
+#define QUEUE_3_TXOPT_SIZE	194	/* Protocol specific - High Priority */
+#define QUEUE_4_TXOPT_SIZE	194	/* NRT(IP,ARP, ICMP) - Low Priority*/
+
 /* Host queue size (number of BDs). Each BD points to data buffer of 32 bytes.
  * HOST PORT QUEUES can buffer up to 4 full sized frames per queue
  */
@@ -49,20 +52,18 @@
  *				For RED, NodeTable lookup was successful.
  * 7		Flood		Packet should be flooded (destination MAC
  *				address found in FDB). For switch only.
- * 8..12	Block_length	number of valid bytes in this specific block.
- *				Will be <=32 bytes on last block of packet
+ * 8		RED_INFO	Set if the frame carries an HSR or PRP
+ *				redundancy tag
+ * 10		HostRecv	Set if the frame is destined for the host port
  * 13		More		"More" bit indicating that there are more blocks
  * 14		Shadow		indicates that "index" is pointing into shadow
  *				buffer
  * 15		TimeStamp	indicates that this packet has time stamp in
  *				separate buffer - only needed if PTP runs on
  *				host
- * 16..17	Port		different meaning for ingress and egress,
- *				Ingress: Port = 0 indicates phy port 1 and
- *				Port = 1 indicates phy port 2.
- *				Egress: 0 sends on phy port 1 and 1 sends on
- *				phy port 2. Port = 2 goes over MAC table
- *				look-up
+ * 16..17	LAN		Destination LAN for transmission:
+ *				bit 16 = LAN A, bit 17 = LAN B, set both to
+ *				duplicate to both LANs.
  * 18..28	Length		11 bit of total packet length which is put into
  *				first BD only so that host access only one BD
  * 29		VlanTag		indicates that packet has Length/Type field of
@@ -86,14 +87,21 @@
 #define PRUETH_BD_SW_FLOOD_MASK		BIT(7)
 #define PRUETH_BD_SW_FLOOD_SHIFT	7
 
+#define PRUETH_BD_RED_PKT_MASK		BIT(8)
+#define PRUETH_BD_RED_PKT		8
+
+#define PRUETH_BD_HOST_RECV_MASK	BIT(10)
+#define PRUETH_BD_HOST_RECV_SHIFT	10
+
 #define	PRUETH_BD_SHADOW_MASK		BIT(14)
 #define	PRUETH_BD_SHADOW_SHIFT		14
 
 #define PRUETH_BD_TIMESTAMP_MASK	BIT(15)
 #define PRUETH_BD_TIMESTAMP_SHIFT	15
 
-#define PRUETH_BD_PORT_MASK		GENMASK(17, 16)
-#define PRUETH_BD_PORT_SHIFT		16
+#define PRUETH_BD_LAN_INFO_MASK		GENMASK(17, 16)
+#define PRUETH_BD_LAN_A_SHIFT		16
+#define PRUETH_BD_LAN_B_SHIFT		17
 
 #define PRUETH_BD_LENGTH_MASK		GENMASK(28, 18)
 #define PRUETH_BD_LENGTH_SHIFT		18
@@ -298,6 +306,9 @@
 #define P0_Q4_BD_OFFSET		(P0_Q3_BD_OFFSET + HOST_QUEUE_3_SIZE * BD_SIZE)
 #define P0_Q3_BD_OFFSET		(P0_Q2_BD_OFFSET + HOST_QUEUE_2_SIZE * BD_SIZE)
 #define P0_Q2_BD_OFFSET		(P0_Q1_BD_OFFSET + HOST_QUEUE_1_SIZE * BD_SIZE)
+#define P1_Q3_TXOPT_BD_OFFSET	(P0_Q4_BD_OFFSET + HOST_QUEUE_4_SIZE * BD_SIZE)
+#define P2_Q1_TXOPT_BD_OFFSET	(P1_Q3_TXOPT_BD_OFFSET +	\
+				 QUEUE_3_TXOPT_SIZE * BD_SIZE)
 #define P0_Q1_BD_OFFSET		P0_BUFFER_DESC_OFFSET
 #define P0_BUFFER_DESC_OFFSET	SRAM_START_OFFSET
 
@@ -328,6 +339,10 @@
 				 ICSS_BLOCK_SIZE)
 #define P0_Q2_BUFFER_OFFSET	(P0_Q1_BUFFER_OFFSET + HOST_QUEUE_1_SIZE * \
 				 ICSS_BLOCK_SIZE)
+#define P1_Q3_TXOPT_BUFFER_OFFSET	(P0_Q4_BUFFER_OFFSET +	\
+					 HOST_QUEUE_4_SIZE * ICSS_BLOCK_SIZE)
+#define P2_Q1_TXOPT_BUFFER_OFFSET	(P1_Q3_TXOPT_BUFFER_OFFSET +	\
+					 QUEUE_3_TXOPT_SIZE * ICSS_BLOCK_SIZE)
 #define P0_COL_BUFFER_OFFSET	0xEE00
 #define P0_Q1_BUFFER_OFFSET	0x0000
 
-- 
2.43.0


