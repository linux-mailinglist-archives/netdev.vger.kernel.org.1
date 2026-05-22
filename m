Return-Path: <netdev+bounces-290788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CqDDeU+EGrzVAYAu9opvQ
	(envelope-from <netdev+bounces-290788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:32:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDB85B30C0
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8ADEA30074A0
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3703D3334;
	Fri, 22 May 2026 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re+t7wup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D333F8BE;
	Fri, 22 May 2026 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449562; cv=none; b=NxtdHdkkuwXFlPO/6DAMHZKVLgpOKrrWdaobRkDo9tca1hcTDOuB4FktJwjrdStlOLzQWTTDOmKKJrDyWQ0xHh8wOCaUDkb7OEfPc67sFt4TpWOyP+TaDqbFFQKqbMrl0rY0QdpFYnOtyIQQjPyumB4xZ4ViXJbKbt16bgD3ROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449562; c=relaxed/simple;
	bh=UpuDhCtO1abQsM/sljVoZYRmS4qrJGRqJuhHDNEtMlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGtqSYwHRR0V3Ngz7bSQnitdexZocjYyCwo07m+giiosmTAGtTWW4zkfleLPp1e0Rk+02rmbcv/RAKynyDHn4PMspOyXQP7xQg/GjQCsglNdXR1GsOt1z1P3dxTxivd90JJ7oNMwR3hCzwYlkPkEWREEetmJ5otQmMZeO9OrRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re+t7wup; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BF61F00A3F;
	Fri, 22 May 2026 11:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779449558;
	bh=A1/jHdabRmrVtf8CjfHpK5fQ1bWAk/qm0GAv69dLX+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Re+t7wupo7auz9uokeFuCF2XB2REMlWo4KriB8U0OzGnsxTcBwaPqYiewREnRG8QA
	 ie62tKtZpqmfzlbcoLSxaqyJ8C8rkQOgFsp+bKQr1NnXh4XB2vvav2FF4Dxk83is5O
	 tFfNrZ+nVdDGD77ibFHmuBlejojQ7iI35FtlQo3GVGk63HfcDv2X+qJwoh5hVTJo2P
	 BkTGDvrdo69TKGLFmAFkzjb4+kPJ0WaW4LzlPa+knHuDUcPdIyuu5BttfUZi9MZndf
	 UTBv5ohZRjPwYMifCihGCbxLSTRu/AsD0Pb+HGmpiSf1a5ZYK8CSX6aS/bE0uh11l2
	 s3Q7GPVYpV2Xg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/3] fbnic: Track BDQ fragment geometry per ring
Date: Fri, 22 May 2026 13:32:20 +0200
Message-ID: <20260522113225.241337-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522113225.241337-1-bjorn@kernel.org>
References: <20260522113225.241337-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290788-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CEDB85B30C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fbnic programs BDQs in 4 KiB fragments, but the driver has so far
decoded buffer IDs using PAGE_SIZE-derived constants. That works while
HPQ and PPQ both use PAGE_SIZE buffers, but it makes the fragment
layout global even though the layout really belongs to the queue.

Store the fragment shift on each BDQ and use it when programming
buffer descriptors and decoding receive completions. HPQ and PPQ still
get the same PAGE_SIZE-derived value, so this does not change behavior
yet.

This prepares PPQ to use a larger io_uring zcrx buffer size without
changing the HPQ layout.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 29 ++------
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 68 ++++++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  6 ++
 4 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 64b958df7774..0ff972f8febc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -109,17 +109,13 @@ enum {
 
 /* Rx Buffer Descriptor Format
  *
- * The layout of this can vary depending on the page size of the system.
+ * Buffer descriptors describe 4 KiB BDQ fragments. A BDQ buffer may be one
+ * fragment, or a power-of-two number of fragments.
  *
- * If the page size is 4K then the layout will simply consist of ID for
- * the 16 most significant bits, and the lower 46 are essentially the page
- * address with the lowest 12 bits being reserved 0 due to the fact that
- * a page will be aligned.
- *
- * If the page size is larger than 4K then the lower n bits of the ID and
- * page address will be reserved for the fragment ID. This fragment will
- * be 4K in size and will be used to index both the DMA address and the ID
- * by the same amount.
+ * The address field stores the 4 KiB-aligned DMA address. The ID field stores
+ * the software buffer ID, with the low n bits used as the fragment ID when a
+ * buffer spans multiple 4 KiB fragments. The driver increments both the
+ * address and ID by one fragment for each descriptor belonging to a buffer.
  */
 #define FBNIC_BD_DESC_ADDR_MASK			DESC_GENMASK(45, 12)
 #define FBNIC_BD_DESC_ID_MASK			DESC_GENMASK(63, 48)
@@ -127,16 +123,6 @@ enum {
 	(FBNIC_BD_DESC_ADDR_MASK & ~(FBNIC_BD_DESC_ADDR_MASK - 1))
 #define FBNIC_BD_FRAG_COUNT \
 	(PAGE_SIZE / FBNIC_BD_FRAG_SIZE)
-#define FBNIC_BD_FRAG_ADDR_MASK \
-	(FBNIC_BD_DESC_ADDR_MASK & \
-	 ~(FBNIC_BD_DESC_ADDR_MASK * FBNIC_BD_FRAG_COUNT))
-#define FBNIC_BD_FRAG_ID_MASK \
-	(FBNIC_BD_DESC_ID_MASK & \
-	 ~(FBNIC_BD_DESC_ID_MASK * FBNIC_BD_FRAG_COUNT))
-#define FBNIC_BD_PAGE_ADDR_MASK \
-	(FBNIC_BD_DESC_ADDR_MASK & ~FBNIC_BD_FRAG_ADDR_MASK)
-#define FBNIC_BD_PAGE_ID_MASK \
-	(FBNIC_BD_DESC_ID_MASK & ~FBNIC_BD_FRAG_ID_MASK)
 
 /* Rx Completion Queue Descriptors */
 #define FBNIC_RCD_TYPE_MASK			DESC_GENMASK(62, 61)
@@ -151,9 +137,6 @@ enum {
 
 /* Address/Length Completion Descriptors */
 #define FBNIC_RCD_AL_BUFF_ID_MASK		DESC_GENMASK(15, 0)
-#define FBNIC_RCD_AL_BUFF_FRAG_MASK		(FBNIC_BD_FRAG_COUNT - 1)
-#define FBNIC_RCD_AL_BUFF_PAGE_MASK \
-	(FBNIC_RCD_AL_BUFF_ID_MASK & ~FBNIC_RCD_AL_BUFF_FRAG_MASK)
 #define FBNIC_RCD_AL_BUFF_LEN_MASK		DESC_GENMASK(28, 16)
 #define FBNIC_RCD_AL_BUFF_OFF_MASK		DESC_GENMASK(43, 32)
 #define FBNIC_RCD_AL_PAGE_FIN			DESC_BIT(60)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index 3c4563c8f403..1cd9dbab423b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -181,8 +181,8 @@ static int fbnic_dbg_tcq_desc_seq_show(struct seq_file *s, void *v)
 static int fbnic_dbg_bdq_desc_seq_show(struct seq_file *s, void *v)
 {
 	struct fbnic_ring *ring = s->private;
+	unsigned int desc_count, i;
 	char hdr[80];
-	int i;
 
 	/* Generate header on first entry */
 	fbnic_dbg_ring_show(s);
@@ -197,7 +197,8 @@ static int fbnic_dbg_bdq_desc_seq_show(struct seq_file *s, void *v)
 		return 0;
 	}
 
-	for (i = 0; i < (ring->size_mask + 1) * FBNIC_BD_FRAG_COUNT; i++) {
+	desc_count = (ring->size_mask + 1) * fbnic_bdq_frag_count(ring);
+	for (i = 0; i < desc_count; i++) {
 		u64 bd = le64_to_cpu(ring->desc[i]);
 
 		seq_printf(s, "%04x %#04llx %#014llx\n", i,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 9cd85a0d0c3a..9a9675d04c16 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -870,19 +870,31 @@ static void fbnic_clean_bdq(struct fbnic_ring *ring, unsigned int hw_head,
 	ring->head = head;
 }
 
+static u16 fbnic_rcd_bdq_idx(const struct fbnic_ring *bdq, u64 rcd)
+{
+	return FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rcd) >> bdq->frag_shift;
+}
+
+static unsigned int fbnic_rcd_frag_offset(const struct fbnic_ring *bdq,
+					  u64 rcd)
+{
+	return (FIELD_GET(FBNIC_RCD_AL_BUFF_ID_MASK, rcd) &
+		(fbnic_bdq_frag_count(bdq) - 1)) * FBNIC_BD_FRAG_SIZE;
+}
+
 static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, netmem_ref netmem)
 {
-	__le64 *bdq_desc = &bdq->desc[id * FBNIC_BD_FRAG_COUNT];
+	u16 frag_count = fbnic_bdq_frag_count(bdq);
+	__le64 *bdq_desc = &bdq->desc[id * frag_count];
 	dma_addr_t dma = page_pool_get_dma_addr_netmem(netmem);
-	u64 bd, i = FBNIC_BD_FRAG_COUNT;
+	u64 bd, i = frag_count;
 
-	bd = (FBNIC_BD_PAGE_ADDR_MASK & dma) |
-	     FIELD_PREP(FBNIC_BD_PAGE_ID_MASK, id);
+	bd = (FBNIC_BD_DESC_ADDR_MASK & dma) |
+	     FIELD_PREP(FBNIC_BD_DESC_ID_MASK, (u64)id << bdq->frag_shift);
 
-	/* In the case that a page size is larger than 4K we will map a
-	 * single page to multiple fragments. The fragments will be
-	 * FBNIC_BD_FRAG_COUNT in size and the lower n bits will be use
-	 * to indicate the individual fragment IDs.
+	/* In the case that the buffer is larger than 4K we will map it
+	 * to multiple fragments. The lower n bits will be used to
+	 * indicate the individual fragment IDs.
 	 */
 	do {
 		*bdq_desc = cpu_to_le64(bd);
@@ -927,7 +939,7 @@ static void fbnic_fill_bdq(struct fbnic_ring *bdq)
 		/* Force DMA writes to flush before writing to tail */
 		dma_wmb();
 
-		writel(i * FBNIC_BD_FRAG_COUNT, bdq->doorbell);
+		writel(i * fbnic_bdq_frag_count(bdq), bdq->doorbell);
 	}
 }
 
@@ -958,7 +970,8 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 			      struct fbnic_pkt_buff *pkt,
 			      struct fbnic_q_triad *qt)
 {
-	unsigned int hdr_pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+	struct fbnic_ring *hpq = &qt->sub0;
+	unsigned int hdr_pg_idx = fbnic_rcd_bdq_idx(hpq, rcd);
 	unsigned int hdr_pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
 	struct page *page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
@@ -976,8 +989,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
 	frame_sz = hdr_pg_end - hdr_pg_start;
 	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
-	hdr_pg_start += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
-			FBNIC_BD_FRAG_SIZE;
+	hdr_pg_start += fbnic_rcd_frag_offset(hpq, rcd);
 
 	/* Sync DMA buffer */
 	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
@@ -998,7 +1010,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 			      struct fbnic_pkt_buff *pkt,
 			      struct fbnic_q_triad *qt)
 {
-	unsigned int pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+	struct fbnic_ring *ppq = &qt->sub1;
+	unsigned int pg_idx = fbnic_rcd_bdq_idx(ppq, rcd);
 	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
 	netmem_ref netmem = fbnic_page_pool_get_data(qt, pg_idx);
@@ -1008,12 +1021,11 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
 
-	pg_off += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
-		  FBNIC_BD_FRAG_SIZE;
+	pg_off += fbnic_rcd_frag_offset(ppq, rcd);
 
 	/* Sync DMA buffer */
-	page_pool_dma_sync_netmem_for_cpu(qt->sub1.page_pool, netmem,
-					  pg_off, truesize);
+	page_pool_dma_sync_netmem_for_cpu(ppq->page_pool, netmem, pg_off,
+					  truesize);
 
 	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
 	if (unlikely(!added)) {
@@ -1256,12 +1268,12 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 
 		switch (FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd)) {
 		case FBNIC_RCD_TYPE_HDR_AL:
-			head0 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+			head0 = fbnic_rcd_bdq_idx(&qt->sub0, rcd);
 			fbnic_pkt_prepare(nv, rcd, pkt, qt);
 
 			break;
 		case FBNIC_RCD_TYPE_PAY_AL:
-			head1 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+			head1 = fbnic_rcd_bdq_idx(&qt->sub1, rcd);
 			fbnic_add_rx_frag(nv, rcd, pkt, qt);
 
 			break;
@@ -1609,6 +1621,7 @@ static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
 	ring->doorbell = doorbell;
 	ring->q_idx = q_idx;
 	ring->flags = flags;
+	ring->frag_shift = ilog2(FBNIC_BD_FRAG_COUNT);
 	ring->deferred_head = -1;
 }
 
@@ -1890,15 +1903,18 @@ static int fbnic_alloc_rx_ring_desc(struct fbnic_net *fbn,
 	size_t desc_size = sizeof(*rxr->desc);
 	u32 rxq_size;
 	size_t size;
+	u16 frag_count;
 
 	switch (rxr->doorbell - fbnic_ring_csr_base(rxr)) {
 	case FBNIC_QUEUE_BDQ_HPQ_TAIL:
-		rxq_size = fbn->hpq_size / FBNIC_BD_FRAG_COUNT;
-		desc_size *= FBNIC_BD_FRAG_COUNT;
+		frag_count = fbnic_bdq_frag_count(rxr);
+		rxq_size = fbn->hpq_size / frag_count;
+		desc_size *= frag_count;
 		break;
 	case FBNIC_QUEUE_BDQ_PPQ_TAIL:
-		rxq_size = fbn->ppq_size / FBNIC_BD_FRAG_COUNT;
-		desc_size *= FBNIC_BD_FRAG_COUNT;
+		frag_count = fbnic_bdq_frag_count(rxr);
+		rxq_size = fbn->ppq_size / frag_count;
+		desc_size *= frag_count;
 		break;
 	case FBNIC_QUEUE_RCQ_HEAD:
 		rxq_size = fbn->rcq_size;
@@ -2564,7 +2580,7 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 	hpq->tail = 0;
 	hpq->head = 0;
 
-	log_size = fls(hpq->size_mask) + ilog2(FBNIC_BD_FRAG_COUNT);
+	log_size = fls(hpq->size_mask) + hpq->frag_shift;
 
 	/* Store descriptor ring address and size */
 	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_HPQ_BAL, lower_32_bits(hpq->dma));
@@ -2576,7 +2592,7 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 	if (!ppq->size_mask)
 		goto write_ctl;
 
-	log_size = fls(ppq->size_mask) + ilog2(FBNIC_BD_FRAG_COUNT);
+	log_size = fls(ppq->size_mask) + ppq->frag_shift;
 
 	/* Add enabling of PPQ to BDQ control */
 	bdq_ctl |= FBNIC_QUEUE_BDQ_CTL_PPQ_ENABLE;
@@ -2845,8 +2861,10 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
 
 	fbnic_ring_init(&qt->sub0, real->sub0.doorbell, real->sub0.q_idx,
 			real->sub0.flags);
+	qt->sub0.frag_shift = real->sub0.frag_shift;
 	fbnic_ring_init(&qt->sub1, real->sub1.doorbell, real->sub1.q_idx,
 			real->sub1.flags);
+	qt->sub1.frag_shift = real->sub1.frag_shift;
 	fbnic_ring_init(&qt->cmpl, real->cmpl.doorbell, real->cmpl.q_idx,
 			real->cmpl.flags);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index e03c9d2c38dc..332cd0e29e15 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -121,6 +121,7 @@ struct fbnic_ring {
 	u16 size_mask;			/* Size of ring in descriptors - 1 */
 	u8 q_idx;			/* Logical netdev ring index */
 	u8 flags;			/* Ring flags (FBNIC_RING_F_*) */
+	u8 frag_shift;			/* BDQ: ilog2(buf_size / 4096) */
 
 	u32 head, tail;			/* Head/Tail of ring */
 
@@ -162,6 +163,11 @@ struct fbnic_napi_vector {
 
 extern const struct netdev_queue_mgmt_ops fbnic_queue_mgmt_ops;
 
+static inline u16 fbnic_bdq_frag_count(const struct fbnic_ring *bdq)
+{
+	return 1U << bdq->frag_shift;
+}
+
 netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
 netdev_features_t
 fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
-- 
2.53.0


