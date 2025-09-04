Return-Path: <netdev+bounces-219893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4744B43A1B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2F55A3AB0
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC913002CD;
	Thu,  4 Sep 2025 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="0kE6e+T7"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881C3002AC;
	Thu,  4 Sep 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985192; cv=none; b=PoCefXnOrqRviRo2OMHzDtj07UvAkk2aWvlnvBBMPdKJyLVe2ncJu1+GQso9IEOd/hVaX5PLaZUvgtFtCJwl0n/fl3eEEtPyScYBTTge5JMMYqKrWhMBq7+7Big4MYpaEyExnOc1yAvwOGRKh5PQnlfD/W2+338nArcZ0Olc3AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985192; c=relaxed/simple;
	bh=rUEOGxEK50rzGmPaNCQuDtk7Fj1D9PHIwWHQzi5QHhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQZLxglpjGEBUKRRuOtk8nT3B0qI9I76KZgPREHpKSgivyb7+TWDKBL0dPhWYmkGOalU/jkKdyIMxnwPjzxOI6w72dNNPnbGTzDmms1fzJFsL9KMme7UJvLwkTMDu8XwQwOnzE/sLYyrn1muj7r0IVIFvZcZtQQy5IQTF0lHxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=0kE6e+T7; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I5ECiLP4LvmIYKulEXtDNoUYV6mErX6Dg7HUXENMcLs=; b=0kE6e+T79wEfb/l8VYUz8BM3vq
	tkZu+MaHHdvifHzJ5xnHnEq5VnSUNp4MhZQANdVmT8Xna6f48z4Fr3/1FvzWD3g8YNzFBgQpwrx52
	tnFSpLTsKqk1JyTxH2ONYaUCTsQbbwB2Esj6tyqSjH5Y1LJaKFEoMdzaI6sWYcUbhmmu/krwNIw0Z
	PnMaifayL8mGOJt1jiTInltf10Z5ehpIQW45RMwNuX4QhuYJgB39pV6HydkROBqSRjQJBvd+xIqkm
	IBrKM/VeNTu7QUaP0YlQSSdHEpAY08/RHe/agmAV8l9pHJXLnev61qLlvuy9phS6808B0KJ5n4vIx
	yQynJoaA==;
Received: from [122.175.9.182] (port=19521 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uu86h-0000000CONA-2O7H;
	Thu, 04 Sep 2025 07:26:24 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ssantosh@kernel.org,
	richardcochran@gmail.com,
	m-malladi@ti.com,
	s.hauer@pengutronix.de,
	afd@ti.com,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	johan@kernel.org,
	alok.a.tiwari@oracle.com,
	m-karicheri2@ti.com,
	s-anna@ti.com,
	glaroque@baylibre.com,
	saikrishnag@marvell.com,
	kory.maincent@bootlin.com,
	diogo.ivo@siemens.com,
	javier.carrasco.cruz@gmail.com,
	basharath@couthit.com,
	parvathi@couthit.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	bastien.curutchet@bootlin.com,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	pmohan@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v15 4/5] net: ti: icssm-prueth: Adds link detection, RX and TX support.
Date: Thu,  4 Sep 2025 16:53:35 +0530
Message-ID: <20250904112523.694288-5-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904101729.693330-1-parvathi@couthit.com>
References: <20250904101729.693330-1-parvathi@couthit.com>
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

From: Roger Quadros <rogerq@ti.com>

Changes corresponding to link configuration such as speed and duplexity.
IRQ and handler initializations are performed for packet reception.Firmware
receives the packet from the wire and stores it into OCMC queue. Next, it
notifies the CPU via interrupt. Upon receiving the interrupt CPU will
service the IRQ and packet will be processed by pushing the newly allocated
SKB to upper layers.

When the user application want to transmit a packet, it will invoke
sys_send() which will in turn invoke the PRUETH driver, then it will write
the packet into OCMC queues. PRU firmware will pick up the packet and
transmit it on to the wire.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 657 ++++++++++++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h |  56 ++
 2 files changed, 711 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 0bc230d60367..3ffa5523663a 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -35,6 +35,14 @@
 
 #define TX_START_DELAY		0x40
 #define TX_CLK_DELAY_100M	0x6
+#define HR_TIMER_TX_DELAY_US	100
+
+static void icssm_prueth_write_reg(struct prueth *prueth,
+				   enum prueth_mem region,
+				   unsigned int reg, u32 val)
+{
+	writel_relaxed(val, prueth->mem[region].va + reg);
+}
 
 /* Below macro is for 1528 Byte Frame support, to Allow even with
  * Redundancy tag
@@ -289,7 +297,7 @@ static void icssm_prueth_hostinit(struct prueth *prueth)
 	icssm_prueth_mii_init(prueth);
 }
 
-/* This function initialize the driver in EMAC or HSR or PRP mode
+/* This function initialize the driver in EMAC mode
  * based on eth_type
  */
 static void icssm_prueth_init_ethernet_mode(struct prueth *prueth)
@@ -297,6 +305,17 @@ static void icssm_prueth_init_ethernet_mode(struct prueth *prueth)
 	icssm_prueth_hostinit(prueth);
 }
 
+static void icssm_prueth_port_enable(struct prueth_emac *emac, bool enable)
+{
+	struct prueth *prueth = emac->prueth;
+	void __iomem *port_ctrl;
+	void __iomem *ram;
+
+	ram = prueth->mem[emac->dram].va;
+	port_ctrl = ram + PORT_CONTROL_ADDR;
+	writeb(!!enable, port_ctrl);
+}
+
 static int icssm_prueth_emac_config(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
@@ -304,6 +323,13 @@ static int icssm_prueth_emac_config(struct prueth_emac *emac)
 	void __iomem *dram_base;
 	void __iomem *mac_addr;
 	void __iomem *dram;
+	void __iomem *sram;
+
+	/* PRU needs local shared RAM address for C28 */
+	sharedramaddr = ICSS_LOCAL_SHARED_RAM;
+	/* PRU needs real global OCMC address for C30*/
+	ocmcaddr = (u32)prueth->mem[PRUETH_MEM_OCMC].pa;
+	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
 
 	/* PRU needs local shared RAM address for C28 */
 	sharedramaddr = ICSS_LOCAL_SHARED_RAM;
@@ -329,6 +355,9 @@ static int icssm_prueth_emac_config(struct prueth_emac *emac)
 	memcpy_toio(dram, queue_descs[emac->port_id],
 		    sizeof(queue_descs[emac->port_id]));
 
+	emac->rx_queue_descs = sram + HOST_QUEUE_DESC_OFFSET;
+	emac->tx_queue_descs = dram;
+
 	/* Set in constant table C28 of PRU0 to ICSS Shared memory */
 	pru_rproc_set_ctable(emac->pru, PRU_C28, sharedramaddr);
 
@@ -343,8 +372,13 @@ static void icssm_emac_adjust_link(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct phy_device *phydev = emac->phydev;
+	struct prueth *prueth = emac->prueth;
 	bool new_state = false;
+	enum prueth_mem region;
 	unsigned long flags;
+	u32 port_status = 0;
+	u32 txcfg, mask;
+	u32 delay;
 
 	spin_lock_irqsave(&emac->lock, flags);
 
@@ -367,8 +401,32 @@ static void icssm_emac_adjust_link(struct net_device *ndev)
 		emac->link = 0;
 	}
 
-	if (new_state)
+	if (new_state) {
 		phy_print_status(phydev);
+		region = emac->dram;
+
+		/* update phy/port status information based on PHY values*/
+		if (emac->link) {
+			port_status |= PORT_LINK_MASK;
+
+			icssm_prueth_write_reg(prueth, region, PHY_SPEED_OFFSET,
+					       emac->speed);
+
+			delay = TX_CLK_DELAY_100M;
+			delay = delay << PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_SHIFT;
+			mask = PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_MASK;
+
+			if (emac->port_id)
+				txcfg = PRUSS_MII_RT_TXCFG1;
+			else
+				txcfg = PRUSS_MII_RT_TXCFG0;
+
+			regmap_update_bits(prueth->mii_rt, txcfg, mask, delay);
+		}
+
+		writeb(port_status, prueth->mem[region].va +
+		       PORT_STATUS_OFFSET);
+	}
 
 	if (emac->link) {
 	       /* reactivate the transmit queue if it is stopped */
@@ -382,6 +440,401 @@ static void icssm_emac_adjust_link(struct net_device *ndev)
 	spin_unlock_irqrestore(&emac->lock, flags);
 }
 
+static unsigned int
+icssm_get_buff_desc_count(const struct prueth_queue_info *queue)
+{
+	unsigned int buffer_desc_count;
+
+	buffer_desc_count = queue->buffer_desc_end -
+			    queue->buffer_desc_offset;
+	buffer_desc_count /= BD_SIZE;
+	buffer_desc_count++;
+
+	return buffer_desc_count;
+}
+
+static void icssm_get_block(struct prueth_queue_desc __iomem *queue_desc,
+			    const struct prueth_queue_info *queue,
+			    int *write_block, int *read_block)
+{
+	*write_block = (readw(&queue_desc->wr_ptr) -
+			queue->buffer_desc_offset) / BD_SIZE;
+	*read_block = (readw(&queue_desc->rd_ptr) -
+		       queue->buffer_desc_offset) / BD_SIZE;
+}
+
+/**
+ * icssm_emac_rx_irq - EMAC Rx interrupt handler
+ * @irq: interrupt number
+ * @dev_id: pointer to net_device
+ *
+ * EMAC Interrupt handler - we only schedule NAPI and not process any packets
+ * here.
+ *
+ * Return: IRQ_HANDLED if the interrupt handled
+ */
+static irqreturn_t icssm_emac_rx_irq(int irq, void *dev_id)
+{
+	struct net_device *ndev = (struct net_device *)dev_id;
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	if (likely(netif_running(ndev))) {
+		/* disable Rx system event */
+		disable_irq_nosync(emac->rx_irq);
+		napi_schedule(&emac->napi);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * icssm_prueth_tx_enqueue - queue a packet to firmware for transmission
+ *
+ * @emac: EMAC data structure
+ * @skb: packet data buffer
+ * @queue_id: priority queue id
+ *
+ * Return: 0 (Success)
+ */
+static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
+				   struct sk_buff *skb,
+				   enum prueth_queue_id queue_id)
+{
+	struct prueth_queue_desc __iomem *queue_desc;
+	const struct prueth_queue_info *txqueue;
+	struct net_device *ndev = emac->ndev;
+	unsigned int buffer_desc_count;
+	int free_blocks, update_block;
+	bool buffer_wrapped = false;
+	int write_block, read_block;
+	void *src_addr, *dst_addr;
+	int pkt_block_size;
+	void __iomem *dram;
+	int txport, pktlen;
+	u16 update_wr_ptr;
+	u32 wr_buf_desc;
+	void *ocmc_ram;
+
+	dram = emac->prueth->mem[emac->dram].va;
+	if (eth_skb_pad(skb)) {
+		if (netif_msg_tx_err(emac) && net_ratelimit())
+			netdev_err(ndev, "packet pad failed\n");
+		return -ENOMEM;
+	}
+
+	/* which port to tx: MII0 or MII1 */
+	txport = emac->tx_port_queue;
+	src_addr = skb->data;
+	pktlen = skb->len;
+	/* Get the tx queue */
+	queue_desc = emac->tx_queue_descs + queue_id;
+	txqueue = &queue_infos[txport][queue_id];
+
+	buffer_desc_count = icssm_get_buff_desc_count(txqueue);
+
+	/* the PRU firmware deals mostly in pointers already
+	 * offset into ram, we would like to deal in indexes
+	 * within the queue we are working with for code
+	 * simplicity, calculate this here
+	 */
+	icssm_get_block(queue_desc, txqueue, &write_block, &read_block);
+
+	if (write_block > read_block) {
+		free_blocks = buffer_desc_count - write_block;
+		free_blocks += read_block;
+	} else if (write_block < read_block) {
+		free_blocks = read_block - write_block;
+	} else { /* they are all free */
+		free_blocks = buffer_desc_count;
+	}
+
+	pkt_block_size = DIV_ROUND_UP(pktlen, ICSS_BLOCK_SIZE);
+	if (pkt_block_size > free_blocks) /* out of queue space */
+		return -ENOBUFS;
+
+	/* calculate end BD address post write */
+	update_block = write_block + pkt_block_size;
+
+	/* Check for wrap around */
+	if (update_block >= buffer_desc_count) {
+		update_block %= buffer_desc_count;
+		buffer_wrapped = true;
+	}
+
+	/* OCMC RAM is not cached and write order is not important */
+	ocmc_ram = (__force void *)emac->prueth->mem[PRUETH_MEM_OCMC].va;
+	dst_addr = ocmc_ram + txqueue->buffer_offset +
+		   (write_block * ICSS_BLOCK_SIZE);
+
+	/* Copy the data from socket buffer(DRAM) to PRU buffers(OCMC) */
+	if (buffer_wrapped) { /* wrapped around buffer */
+		int bytes = (buffer_desc_count - write_block) * ICSS_BLOCK_SIZE;
+		int remaining;
+
+		/* bytes is integral multiple of ICSS_BLOCK_SIZE but
+		 * entire packet may have fit within the last BD
+		 * if pkt_info.length is not integral multiple of
+		 * ICSS_BLOCK_SIZE
+		 */
+		if (pktlen < bytes)
+			bytes = pktlen;
+
+		/* copy non-wrapped part */
+		memcpy(dst_addr, src_addr, bytes);
+
+		/* copy wrapped part */
+		src_addr += bytes;
+		remaining = pktlen - bytes;
+		dst_addr = ocmc_ram + txqueue->buffer_offset;
+		memcpy(dst_addr, src_addr, remaining);
+	} else {
+		memcpy(dst_addr, src_addr, pktlen);
+	}
+
+       /* update first buffer descriptor */
+	wr_buf_desc = (pktlen << PRUETH_BD_LENGTH_SHIFT) &
+		       PRUETH_BD_LENGTH_MASK;
+	writel(wr_buf_desc, dram + readw(&queue_desc->wr_ptr));
+
+	/* update the write pointer in this queue descriptor, the firmware
+	 * polls for this change so this will signal the start of transmission
+	 */
+	update_wr_ptr = txqueue->buffer_desc_offset + (update_block * BD_SIZE);
+	writew(update_wr_ptr, &queue_desc->wr_ptr);
+
+	return 0;
+}
+
+void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
+			     struct prueth_packet_info *pkt_info)
+{
+	pkt_info->shadow = !!(buffer_descriptor & PRUETH_BD_SHADOW_MASK);
+	pkt_info->port = (buffer_descriptor & PRUETH_BD_PORT_MASK) >>
+			 PRUETH_BD_PORT_SHIFT;
+	pkt_info->length = (buffer_descriptor & PRUETH_BD_LENGTH_MASK) >>
+			   PRUETH_BD_LENGTH_SHIFT;
+	pkt_info->broadcast = !!(buffer_descriptor & PRUETH_BD_BROADCAST_MASK);
+	pkt_info->error = !!(buffer_descriptor & PRUETH_BD_ERROR_MASK);
+	pkt_info->lookup_success = !!(buffer_descriptor &
+				      PRUETH_BD_LOOKUP_SUCCESS_MASK);
+	pkt_info->flood = !!(buffer_descriptor & PRUETH_BD_SW_FLOOD_MASK);
+	pkt_info->timestamp = !!(buffer_descriptor & PRUETH_BD_TIMESTAMP_MASK);
+}
+
+/**
+ * icssm_emac_rx_packet - EMAC Receive function
+ *
+ * @emac: EMAC data structure
+ * @bd_rd_ptr: Buffer descriptor read pointer
+ * @pkt_info: packet information structure
+ * @rxqueue: Receive queue information structure
+ *
+ * Get a packet from receive queue
+ *
+ * Return: 0 (Success)
+ */
+int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
+			 struct prueth_packet_info *pkt_info,
+			 const struct prueth_queue_info *rxqueue)
+{
+	struct net_device *ndev = emac->ndev;
+	unsigned int buffer_desc_count;
+	int read_block, update_block;
+	unsigned int actual_pkt_len;
+	bool buffer_wrapped = false;
+	void *src_addr, *dst_addr;
+	struct sk_buff *skb;
+	int pkt_block_size;
+	void *ocmc_ram;
+
+	/* the PRU firmware deals mostly in pointers already
+	 * offset into ram, we would like to deal in indexes
+	 * within the queue we are working with for code
+	 * simplicity, calculate this here
+	 */
+	buffer_desc_count = icssm_get_buff_desc_count(rxqueue);
+	read_block = (*bd_rd_ptr - rxqueue->buffer_desc_offset) / BD_SIZE;
+	pkt_block_size = DIV_ROUND_UP(pkt_info->length, ICSS_BLOCK_SIZE);
+
+	/* calculate end BD address post read */
+	update_block = read_block + pkt_block_size;
+
+	/* Check for wrap around */
+	if (update_block >= buffer_desc_count) {
+		update_block %= buffer_desc_count;
+		if (update_block)
+			buffer_wrapped = true;
+	}
+
+	/* calculate new pointer in ram */
+	*bd_rd_ptr = rxqueue->buffer_desc_offset + (update_block * BD_SIZE);
+
+	actual_pkt_len = pkt_info->length;
+
+	/* Allocate a socket buffer for this packet */
+	skb = netdev_alloc_skb_ip_align(ndev, actual_pkt_len);
+	if (!skb) {
+		if (netif_msg_rx_err(emac) && net_ratelimit())
+			netdev_err(ndev, "failed rx buffer alloc\n");
+		return -ENOMEM;
+	}
+
+	dst_addr = skb->data;
+
+	/* OCMC RAM is not cached and read order is not important */
+	ocmc_ram = (__force void *)emac->prueth->mem[PRUETH_MEM_OCMC].va;
+
+	/* Get the start address of the first buffer from
+	 * the read buffer description
+	 */
+	src_addr = ocmc_ram + rxqueue->buffer_offset +
+		   (read_block * ICSS_BLOCK_SIZE);
+
+	/* Copy the data from PRU buffers(OCMC) to socket buffer(DRAM) */
+	if (buffer_wrapped) { /* wrapped around buffer */
+		int bytes = (buffer_desc_count - read_block) * ICSS_BLOCK_SIZE;
+		int remaining;
+		/* bytes is integral multiple of ICSS_BLOCK_SIZE but
+		 * entire packet may have fit within the last BD
+		 * if pkt_info.length is not integral multiple of
+		 * ICSS_BLOCK_SIZE
+		 */
+		if (pkt_info->length < bytes)
+			bytes = pkt_info->length;
+
+		/* copy non-wrapped part */
+		memcpy(dst_addr, src_addr, bytes);
+
+		/* copy wrapped part */
+		dst_addr += bytes;
+		remaining = actual_pkt_len - bytes;
+
+		src_addr = ocmc_ram + rxqueue->buffer_offset;
+		memcpy(dst_addr, src_addr, remaining);
+		src_addr += remaining;
+	} else {
+		memcpy(dst_addr, src_addr, actual_pkt_len);
+		src_addr += actual_pkt_len;
+	}
+
+	skb_put(skb, actual_pkt_len);
+
+	/* send packet up the stack */
+	skb->protocol = eth_type_trans(skb, ndev);
+	netif_receive_skb(skb);
+
+	/* update stats */
+	emac->stats.rx_bytes += actual_pkt_len;
+	emac->stats.rx_packets++;
+
+	return 0;
+}
+
+static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
+{
+	struct prueth_queue_desc __iomem *queue_desc;
+	const struct prueth_queue_info *rxqueue;
+	struct prueth *prueth = emac->prueth;
+	struct prueth_packet_info pkt_info;
+	int start_queue, end_queue;
+	void __iomem *shared_ram;
+	u16 bd_rd_ptr, bd_wr_ptr;
+	u16 update_rd_ptr;
+	u8 overflow_cnt;
+	u32 rd_buf_desc;
+	int used = 0;
+	int i, ret;
+
+	shared_ram = emac->prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+
+	start_queue = emac->rx_queue_start;
+	end_queue = emac->rx_queue_end;
+
+	/* skip Rx if budget is 0 */
+	if (!budget)
+		return 0;
+
+	/* search host queues for packets */
+	for (i = start_queue; i <= end_queue; i++) {
+		queue_desc = emac->rx_queue_descs + i;
+		rxqueue = &queue_infos[PRUETH_PORT_HOST][i];
+
+		overflow_cnt = readb(&queue_desc->overflow_cnt);
+		if (overflow_cnt > 0) {
+			emac->stats.rx_over_errors += overflow_cnt;
+			/* reset to zero */
+			writeb(0, &queue_desc->overflow_cnt);
+		}
+
+		bd_rd_ptr = readw(&queue_desc->rd_ptr);
+		bd_wr_ptr = readw(&queue_desc->wr_ptr);
+
+		/* while packets are available in this queue */
+		while (bd_rd_ptr != bd_wr_ptr) {
+			/* get packet info from the read buffer descriptor */
+			rd_buf_desc = readl(shared_ram + bd_rd_ptr);
+			icssm_parse_packet_info(prueth, rd_buf_desc, &pkt_info);
+
+			if (pkt_info.length <= 0) {
+				/* a packet length of zero will cause us to
+				 * never move the read pointer ahead, locking
+				 * the driver, so we manually have to move it
+				 * to the write pointer, discarding all
+				 * remaining packets in this queue. This should
+				 * never happen.
+				 */
+				update_rd_ptr = bd_wr_ptr;
+				emac->stats.rx_length_errors++;
+			} else if (pkt_info.length > EMAC_MAX_FRM_SUPPORT) {
+				/* if the packet is too large we skip it but we
+				 * still need to move the read pointer ahead
+				 * and assume something is wrong with the read
+				 * pointer as the firmware should be filtering
+				 * these packets
+				 */
+				update_rd_ptr = bd_wr_ptr;
+				emac->stats.rx_length_errors++;
+			} else {
+				update_rd_ptr = bd_rd_ptr;
+				ret = icssm_emac_rx_packet(emac, &update_rd_ptr,
+							   &pkt_info, rxqueue);
+				if (ret)
+					return used;
+				used++;
+			}
+
+			/* after reading the buffer descriptor we clear it
+			 * to prevent improperly moved read pointer errors
+			 * from simply looking like old packets.
+			 */
+			writel(0, shared_ram + bd_rd_ptr);
+
+			/* update read pointer in queue descriptor */
+			writew(update_rd_ptr, &queue_desc->rd_ptr);
+			bd_rd_ptr = update_rd_ptr;
+
+			/* all we have room for? */
+			if (used >= budget)
+				return used;
+		}
+	}
+
+	return used;
+}
+
+static int icssm_emac_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct prueth_emac *emac = container_of(napi, struct prueth_emac, napi);
+	int num_rx;
+
+	num_rx = icssm_emac_rx_packets(emac, budget);
+
+	if (num_rx < budget && napi_complete_done(napi, num_rx))
+		enable_irq(emac->rx_irq);
+
+	return num_rx;
+}
+
 static int icssm_emac_set_boot_pru(struct prueth_emac *emac,
 				   struct net_device *ndev)
 {
@@ -411,6 +864,21 @@ static int icssm_emac_set_boot_pru(struct prueth_emac *emac,
 			   fw_name, ret);
 		return ret;
 	}
+	return ret;
+}
+
+static int icssm_emac_request_irqs(struct prueth_emac *emac)
+{
+	struct net_device *ndev = emac->ndev;
+	int ret;
+
+	ret = request_irq(emac->rx_irq, icssm_emac_rx_irq,
+			  IRQF_TRIGGER_HIGH,
+			  ndev->name, ndev);
+	if (ret) {
+		netdev_err(ndev, "unable to request RX IRQ\n");
+		return ret;
+	}
 
 	return ret;
 }
@@ -441,10 +909,29 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 	if (ret)
 		return ret;
 
+	ret = icssm_emac_request_irqs(emac);
+	if (ret)
+		goto rproc_shutdown;
+
+	napi_enable(&emac->napi);
+
 	/* start PHY */
 	phy_start(emac->phydev);
+
+	/* enable the port and vlan */
+	icssm_prueth_port_enable(emac, true);
+
 	prueth->emac_configured |= BIT(emac->port_id);
+
+	if (netif_msg_drv(emac))
+		dev_notice(&ndev->dev, "started\n");
+
 	return 0;
+
+rproc_shutdown:
+	rproc_shutdown(emac->pru);
+
+	return ret;
 }
 
 /**
@@ -458,18 +945,146 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 static int icssm_emac_ndo_stop(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+
+	prueth->emac_configured &= ~BIT(emac->port_id);
+
+	/* disable the mac port */
+	icssm_prueth_port_enable(emac, false);
 
 	/* stop PHY */
 	phy_stop(emac->phydev);
 
+	napi_disable(&emac->napi);
+	hrtimer_cancel(&emac->tx_hrtimer);
+
+	/* stop the PRU */
 	rproc_shutdown(emac->pru);
 
+	/* free rx interrupts */
+	free_irq(emac->rx_irq, ndev);
+
+	if (netif_msg_drv(emac))
+		dev_notice(&ndev->dev, "stopped\n");
+
 	return 0;
 }
 
+/* VLAN-tag PCP to priority queue map for EMAC/Switch/HSR/PRP used by driver
+ * Index is PCP val / 2.
+ *   low  - pcp 0..3 maps to Q4 for Host
+ *   high - pcp 4..7 maps to Q3 for Host
+ *   low  - pcp 0..3 maps to Q2 (FWD Queue) for PRU-x
+ *   where x = 1 for PRUETH_PORT_MII0
+ *             0 for PRUETH_PORT_MII1
+ *   high - pcp 4..7 maps to Q1 (FWD Queue) for PRU-x
+ */
+static const unsigned short emac_pcp_tx_priority_queue_map[] = {
+	PRUETH_QUEUE4, PRUETH_QUEUE4,
+	PRUETH_QUEUE3, PRUETH_QUEUE3,
+	PRUETH_QUEUE2, PRUETH_QUEUE2,
+	PRUETH_QUEUE1, PRUETH_QUEUE1,
+};
+
+static u16 icssm_prueth_get_tx_queue_id(struct prueth *prueth,
+					struct sk_buff *skb)
+{
+	u16 vlan_tci, pcp;
+	int err;
+
+	err = vlan_get_tag(skb, &vlan_tci);
+	if (likely(err))
+		pcp = 0;
+	else
+		pcp = (vlan_tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+
+	/* Below code (pcp >>= 1) is made common for all
+	 * protocols (i.e., EMAC, RSTP, HSR and PRP)*
+	 * pcp value 0,1 will be updated to 0 mapped to QUEUE4
+	 * pcp value 2,3 will be updated to 1 mapped to QUEUE4
+	 * pcp value 4,5 will be updated to 2 mapped to QUEUE3
+	 * pcp value 6,7 will be updated to 3 mapped to QUEUE3
+	 */
+	pcp >>= 1;
+
+	return emac_pcp_tx_priority_queue_map[pcp];
+}
+
+/**
+ * icssm_emac_ndo_start_xmit - EMAC Transmit function
+ * @skb: SKB pointer
+ * @ndev: EMAC network adapter
+ *
+ * Called by the system to transmit a packet - we queue the packet in
+ * EMAC hardware transmit queue
+ *
+ * Return: enum netdev_tx
+ */
+static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
+						struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret;
+	u16 qid;
+
+	qid = icssm_prueth_get_tx_queue_id(emac->prueth, skb);
+	ret = icssm_prueth_tx_enqueue(emac, skb, qid);
+	if (ret) {
+		if (ret != -ENOBUFS && netif_msg_tx_err(emac) &&
+		    net_ratelimit())
+			netdev_err(ndev, "packet queue failed: %d\n", ret);
+		goto fail_tx;
+	}
+
+	emac->stats.tx_packets++;
+	emac->stats.tx_bytes += skb->len;
+	dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+
+fail_tx:
+	if (ret == -ENOBUFS) {
+		netif_stop_queue(ndev);
+		hrtimer_start(&emac->tx_hrtimer,
+			      us_to_ktime(HR_TIMER_TX_DELAY_US),
+			      HRTIMER_MODE_REL_PINNED);
+		ret = NETDEV_TX_BUSY;
+	} else {
+		/* error */
+		emac->stats.tx_dropped++;
+		ret = NET_XMIT_DROP;
+	}
+
+	return ret;
+}
+
+/**
+ * icssm_emac_ndo_get_stats64 - EMAC get statistics function
+ * @ndev: The EMAC network adapter
+ * @stats: rtnl_link_stats structure
+ *
+ * Called when system wants to get statistics from the device.
+ *
+ */
+static void icssm_emac_ndo_get_stats64(struct net_device *ndev,
+				       struct rtnl_link_stats64 *stats)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	stats->rx_packets = emac->stats.rx_packets;
+	stats->rx_bytes = emac->stats.rx_bytes;
+	stats->tx_packets = emac->stats.tx_packets;
+	stats->tx_bytes = emac->stats.tx_bytes;
+	stats->tx_dropped = emac->stats.tx_dropped;
+	stats->rx_over_errors = emac->stats.rx_over_errors;
+	stats->rx_length_errors = emac->stats.rx_length_errors;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = icssm_emac_ndo_open,
 	.ndo_stop = icssm_emac_ndo_stop,
+	.ndo_start_xmit = icssm_emac_ndo_start_xmit,
+	.ndo_get_stats64 = icssm_emac_ndo_get_stats64,
 };
 
 /* get emac_port corresponding to eth_node name */
@@ -508,6 +1123,17 @@ static int icssm_prueth_node_mac(struct device_node *eth_node)
 		return PRUETH_MAC_INVALID;
 }
 
+static enum hrtimer_restart icssm_emac_tx_timer_callback(struct hrtimer *timer)
+{
+	struct prueth_emac *emac =
+			container_of(timer, struct prueth_emac, tx_hrtimer);
+
+	if (netif_queue_stopped(emac->ndev))
+		netif_wake_queue(emac->ndev);
+
+	return HRTIMER_NORESTART;
+}
+
 static int icssm_prueth_netdev_init(struct prueth *prueth,
 				    struct device_node *eth_node)
 {
@@ -539,16 +1165,37 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 	/* by default eth_type is EMAC */
 	switch (port) {
 	case PRUETH_PORT_MII0:
+		emac->tx_port_queue = PRUETH_PORT_QUEUE_MII0;
+
+		/* packets from MII0 are on queues 1 through 2 */
+		emac->rx_queue_start = PRUETH_QUEUE1;
+		emac->rx_queue_end = PRUETH_QUEUE2;
+
 		emac->dram = PRUETH_MEM_DRAM0;
 		emac->pru = prueth->pru0;
 		break;
 	case PRUETH_PORT_MII1:
+		emac->tx_port_queue = PRUETH_PORT_QUEUE_MII1;
+
+		/* packets from MII1 are on queues 3 through 4 */
+		emac->rx_queue_start = PRUETH_QUEUE3;
+		emac->rx_queue_end = PRUETH_QUEUE4;
+
 		emac->dram = PRUETH_MEM_DRAM1;
 		emac->pru = prueth->pru1;
 		break;
 	default:
 		return -EINVAL;
 	}
+
+	emac->rx_irq = of_irq_get_byname(eth_node, "rx");
+	if (emac->rx_irq < 0) {
+		ret = emac->rx_irq;
+		if (ret != -EPROBE_DEFER)
+			dev_err(prueth->dev, "could not get rx irq\n");
+		goto free;
+	}
+
 	/* get mac address from DT and set private and netdev addr */
 	ret = of_get_ethdev_address(eth_node, ndev);
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
@@ -579,6 +1226,11 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 	ndev->dev.of_node = eth_node;
 	ndev->netdev_ops = &emac_netdev_ops;
 
+	netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
+
+	hrtimer_setup(&emac->tx_hrtimer, &icssm_emac_tx_timer_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+
 	return 0;
 free:
 	emac->ndev = NULL;
@@ -603,6 +1255,7 @@ static void icssm_prueth_netdev_exit(struct prueth *prueth,
 
 	phy_disconnect(emac->phydev);
 
+	netif_napi_del(&emac->napi);
 	prueth->emac[mac] = NULL;
 }
 
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index f1d1deef888f..f5b6b1e99bd4 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -20,6 +20,12 @@
 
 /* PRUSS local memory map */
 #define ICSS_LOCAL_SHARED_RAM	0x00010000
+#define EMAC_MAX_PKTLEN		(ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
+/* Below macro is for 1528 Byte Frame support, to Allow even with
+ * Redundancy tag
+ */
+#define EMAC_MAX_FRM_SUPPORT (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN + \
+			      ICSSM_LRE_TAG_SIZE)
 
 /* PRU Ethernet Type - Ethernet functionality (protocol
  * implemented) provided by the PRU firmware being loaded.
@@ -76,6 +82,28 @@ struct prueth_queue_info {
 	u16 buffer_desc_end;
 };
 
+/**
+ * struct prueth_packet_info - Info about a packet in buffer
+ * @shadow: this packet is stored in the collision queue
+ * @port: port packet is on
+ * @length: length of packet
+ * @broadcast: this packet is a broadcast packet
+ * @error: this packet has an error
+ * @lookup_success: src mac found in FDB
+ * @flood: packet is to be flooded
+ * @timestamp: Specifies if timestamp is appended to the packet
+ */
+struct prueth_packet_info {
+	bool shadow;
+	unsigned int port;
+	unsigned int length;
+	bool broadcast;
+	bool error;
+	bool lookup_success;
+	bool flood;
+	bool timestamp;
+};
+
 /* In switch mode there are 3 real ports i.e. 3 mac addrs.
  * however Linux sees only the host side port. The other 2 ports
  * are the switch ports.
@@ -158,21 +186,39 @@ struct prueth_private_data {
 	const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
 };
 
+struct prueth_emac_stats {
+	u64 tx_packets;
+	u64 tx_dropped;
+	u64 tx_bytes;
+	u64 rx_packets;
+	u64 rx_bytes;
+	u64 rx_length_errors;
+	u64 rx_over_errors;
+};
+
 /* data for each emac port */
 struct prueth_emac {
 	struct prueth *prueth;
 	struct net_device *ndev;
+	struct napi_struct napi;
 
 	struct rproc *pru;
 	struct phy_device *phydev;
+	struct prueth_queue_desc __iomem *rx_queue_descs;
+	struct prueth_queue_desc __iomem *tx_queue_descs;
 
 	int link;
 	int speed;
 	int duplex;
+	int rx_irq;
 
+	enum prueth_port_queue_id tx_port_queue;
+	enum prueth_queue_id rx_queue_start;
+	enum prueth_queue_id rx_queue_end;
 	enum prueth_port port_id;
 	enum prueth_mem dram;
 	const char *phy_id;
+	u32 msg_enable;
 	u8 mac_addr[6];
 	phy_interface_t phy_if;
 
@@ -180,6 +226,9 @@ struct prueth_emac {
 	 * during link configuration
 	 */
 	spinlock_t lock;
+
+	struct hrtimer tx_hrtimer;
+	struct prueth_emac_stats stats;
 };
 
 struct prueth {
@@ -201,4 +250,11 @@ struct prueth {
 	size_t ocmc_ram_size;
 	u8 emac_configured;
 };
+
+void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
+			     struct prueth_packet_info *pkt_info);
+int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
+			 struct prueth_packet_info *pkt_info,
+			 const struct prueth_queue_info *rxqueue);
+
 #endif /* __NET_TI_PRUETH_H */
-- 
2.43.0


