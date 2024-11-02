Return-Path: <netdev+bounces-141208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A563D9BA0CC
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DDC282525
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44578276;
	Sat,  2 Nov 2024 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="JyXIQ46b"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F733F9;
	Sat,  2 Nov 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558019; cv=none; b=LkD9xEWuaHYe0U3pRPAqOLpRjfkpUtWleGzaAstw9EKYSLtXpNeGL6efWIEU2CK4J6itwfjs9EZlshx+6tUNicWr835sOn6sTFUNkUpaqels2OUbEH9RuGt4/TWCtX7y4+qTuWHs+8jo5WWFRaJ1R4PIKG72KTyRoaOZ4J9otBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558019; c=relaxed/simple;
	bh=JRd71z6CUMYCvugCsAT5+pDVaAsOQB1Rkz1mIIy1W6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ob3io1IceTVoBVv8+ogy+GQ61mTJg+EoYdQIkmlQPKFZi3vJcFgmukk7gzbaErWwh1HvQYm3xpgDzLH5hhGixyHQLnra6T7GMEKKmLssy5RZgoAoSVpHJ4PzR425HP0NJ02n4PfjG9UFnULIdeEWkMMgBAVfZ2rIJN7Tf1zK0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=JyXIQ46b; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=B0hFXMIsdTaqRLf4YssnEZtCdXxr4gtqyM7yHXkLYng=; b=JyXIQ46bQMP4AWdm
	lTjVzw0vycEL7kkq6u2n1qeEJguy/IgC80Oq1h1i9RTUX+tBF3Wl2vFloiIOpro2AXTyNCkmmNzHA
	3UW/c94O1RikbK4fsFeRCu+bDOFBr1L2RR1rQ3vgJsNeuT5rSKlK5F91jKwubgrlqHX+xx1e2R9bZ
	MeoYfZ7lBV+NxcQbyJG3O5MoGEv1wxnZha6iToKUSsVOp0EuDqecF6KSiDb6D0fp2wd5uAu7JwZmk
	wADNCFnq00CCacsoeRCV4rknSnFdkwX4/P7L++IaQ1QqfOPJ5UeOUawVFLV7yiXLMUhR5cK13LmCe
	p4urwaqKEhEkObTNCQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7FBm-00F6Ij-3D;
	Sat, 02 Nov 2024 14:33:19 +0000
From: linux@treblig.org
To: ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] sfc: Remove deadcode
Date: Sat,  2 Nov 2024 14:33:16 +0000
Message-ID: <20241102143317.24745-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ef4_farch_dimension_resources(), ef4_nic_fix_nodesc_drop_stat(),
ef4_ticks_to_usecs() and ef4_tx_get_copy_buffer_limited() were
copied over from efx_ equivalents in 2016 but never used by
commit 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new
sfc-falcon driver")

EF4_MAX_FLUSH_TIME is also unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/sfc/falcon/efx.c   |  8 --------
 drivers/net/ethernet/sfc/falcon/efx.h   |  1 -
 drivers/net/ethernet/sfc/falcon/farch.c | 22 ----------------------
 drivers/net/ethernet/sfc/falcon/nic.c   | 11 -----------
 drivers/net/ethernet/sfc/falcon/nic.h   |  5 -----
 drivers/net/ethernet/sfc/falcon/tx.c    |  8 --------
 drivers/net/ethernet/sfc/falcon/tx.h    |  3 ---
 7 files changed, 58 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 8925745f1c17..b07f7e4e2877 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -1886,14 +1886,6 @@ unsigned int ef4_usecs_to_ticks(struct ef4_nic *efx, unsigned int usecs)
 	return usecs * 1000 / efx->timer_quantum_ns;
 }
 
-unsigned int ef4_ticks_to_usecs(struct ef4_nic *efx, unsigned int ticks)
-{
-	/* We must round up when converting ticks to microseconds
-	 * because we round down when converting the other way.
-	 */
-	return DIV_ROUND_UP(ticks * efx->timer_quantum_ns, 1000);
-}
-
 /* Set interrupt moderation parameters */
 int ef4_init_irq_moderation(struct ef4_nic *efx, unsigned int tx_usecs,
 			    unsigned int rx_usecs, bool rx_adaptive,
diff --git a/drivers/net/ethernet/sfc/falcon/efx.h b/drivers/net/ethernet/sfc/falcon/efx.h
index d3b4646545fa..52508f2c8cb2 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.h
+++ b/drivers/net/ethernet/sfc/falcon/efx.h
@@ -198,7 +198,6 @@ int ef4_try_recovery(struct ef4_nic *efx);
 /* Global */
 void ef4_schedule_reset(struct ef4_nic *efx, enum reset_type type);
 unsigned int ef4_usecs_to_ticks(struct ef4_nic *efx, unsigned int usecs);
-unsigned int ef4_ticks_to_usecs(struct ef4_nic *efx, unsigned int ticks);
 int ef4_init_irq_moderation(struct ef4_nic *efx, unsigned int tx_usecs,
 			    unsigned int rx_usecs, bool rx_adaptive,
 			    bool rx_may_override_tx);
diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
index c64623c2e80c..01017c41338e 100644
--- a/drivers/net/ethernet/sfc/falcon/farch.c
+++ b/drivers/net/ethernet/sfc/falcon/farch.c
@@ -1631,28 +1631,6 @@ void ef4_farch_rx_push_indir_table(struct ef4_nic *efx)
 	}
 }
 
-/* Looks at available SRAM resources and works out how many queues we
- * can support, and where things like descriptor caches should live.
- *
- * SRAM is split up as follows:
- * 0                          buftbl entries for channels
- * efx->vf_buftbl_base        buftbl entries for SR-IOV
- * efx->rx_dc_base            RX descriptor caches
- * efx->tx_dc_base            TX descriptor caches
- */
-void ef4_farch_dimension_resources(struct ef4_nic *efx, unsigned sram_lim_qw)
-{
-	unsigned vi_count;
-
-	/* Account for the buffer table entries backing the datapath channels
-	 * and the descriptor caches for those channels.
-	 */
-	vi_count = max(efx->n_channels, efx->n_tx_channels * EF4_TXQ_TYPES);
-
-	efx->tx_dc_base = sram_lim_qw - vi_count * TX_DC_ENTRIES;
-	efx->rx_dc_base = efx->tx_dc_base - vi_count * RX_DC_ENTRIES;
-}
-
 u32 ef4_farch_fpga_ver(struct ef4_nic *efx)
 {
 	ef4_oword_t altera_build;
diff --git a/drivers/net/ethernet/sfc/falcon/nic.c b/drivers/net/ethernet/sfc/falcon/nic.c
index 78c851b5a56f..1b91992e3698 100644
--- a/drivers/net/ethernet/sfc/falcon/nic.c
+++ b/drivers/net/ethernet/sfc/falcon/nic.c
@@ -511,14 +511,3 @@ void ef4_nic_update_stats(const struct ef4_hw_stat_desc *desc, size_t count,
 		}
 	}
 }
-
-void ef4_nic_fix_nodesc_drop_stat(struct ef4_nic *efx, u64 *rx_nodesc_drops)
-{
-	/* if down, or this is the first update after coming up */
-	if (!(efx->net_dev->flags & IFF_UP) || !efx->rx_nodesc_drops_prev_state)
-		efx->rx_nodesc_drops_while_down +=
-			*rx_nodesc_drops - efx->rx_nodesc_drops_total;
-	efx->rx_nodesc_drops_total = *rx_nodesc_drops;
-	efx->rx_nodesc_drops_prev_state = !!(efx->net_dev->flags & IFF_UP);
-	*rx_nodesc_drops -= efx->rx_nodesc_drops_while_down;
-}
diff --git a/drivers/net/ethernet/sfc/falcon/nic.h b/drivers/net/ethernet/sfc/falcon/nic.h
index ada6e036fd97..ac10c12967df 100644
--- a/drivers/net/ethernet/sfc/falcon/nic.h
+++ b/drivers/net/ethernet/sfc/falcon/nic.h
@@ -477,7 +477,6 @@ void ef4_farch_finish_flr(struct ef4_nic *efx);
 void falcon_start_nic_stats(struct ef4_nic *efx);
 void falcon_stop_nic_stats(struct ef4_nic *efx);
 int falcon_reset_xaui(struct ef4_nic *efx);
-void ef4_farch_dimension_resources(struct ef4_nic *efx, unsigned sram_lim_qw);
 void ef4_farch_init_common(struct ef4_nic *efx);
 void ef4_farch_rx_push_indir_table(struct ef4_nic *efx);
 
@@ -502,10 +501,6 @@ size_t ef4_nic_describe_stats(const struct ef4_hw_stat_desc *desc, size_t count,
 void ef4_nic_update_stats(const struct ef4_hw_stat_desc *desc, size_t count,
 			  const unsigned long *mask, u64 *stats,
 			  const void *dma_buf, bool accumulate);
-void ef4_nic_fix_nodesc_drop_stat(struct ef4_nic *efx, u64 *stat);
-
-#define EF4_MAX_FLUSH_TIME 5000
-
 void ef4_farch_generate_event(struct ef4_nic *efx, unsigned int evq,
 			      ef4_qword_t *event);
 
diff --git a/drivers/net/ethernet/sfc/falcon/tx.c b/drivers/net/ethernet/sfc/falcon/tx.c
index b9369483758c..e6e80b039ca2 100644
--- a/drivers/net/ethernet/sfc/falcon/tx.c
+++ b/drivers/net/ethernet/sfc/falcon/tx.c
@@ -40,14 +40,6 @@ static inline u8 *ef4_tx_get_copy_buffer(struct ef4_tx_queue *tx_queue,
 	return (u8 *)page_buf->addr + offset;
 }
 
-u8 *ef4_tx_get_copy_buffer_limited(struct ef4_tx_queue *tx_queue,
-				   struct ef4_tx_buffer *buffer, size_t len)
-{
-	if (len > EF4_TX_CB_SIZE)
-		return NULL;
-	return ef4_tx_get_copy_buffer(tx_queue, buffer);
-}
-
 static void ef4_dequeue_buffer(struct ef4_tx_queue *tx_queue,
 			       struct ef4_tx_buffer *buffer,
 			       unsigned int *pkts_compl,
diff --git a/drivers/net/ethernet/sfc/falcon/tx.h b/drivers/net/ethernet/sfc/falcon/tx.h
index 2a88c59cbbbe..868ed8a861ab 100644
--- a/drivers/net/ethernet/sfc/falcon/tx.h
+++ b/drivers/net/ethernet/sfc/falcon/tx.h
@@ -15,9 +15,6 @@
 unsigned int ef4_tx_limit_len(struct ef4_tx_queue *tx_queue,
 			      dma_addr_t dma_addr, unsigned int len);
 
-u8 *ef4_tx_get_copy_buffer_limited(struct ef4_tx_queue *tx_queue,
-				   struct ef4_tx_buffer *buffer, size_t len);
-
 int ef4_enqueue_skb_tso(struct ef4_tx_queue *tx_queue, struct sk_buff *skb,
 			bool *data_mapped);
 
-- 
2.47.0


