Return-Path: <netdev+bounces-141221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350959BA10F
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E0A1F21BAA
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949191AB6C7;
	Sat,  2 Nov 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="B2sad9+f"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D619F409;
	Sat,  2 Nov 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560598; cv=none; b=NZLyOMJLdQBn5W+/uSIlE2dt52XPT6yuETneqOQtCcIDqMwB1Ng8/AS4yPmTQu2ZTycRSydrmKVGKdQSn7Z7iwaUcm7csmmSg7/FXKvKaJ/RdQneP58qqVnFr2JYOiaYHEk07J8vYLNSC0P5TKcDVwVQD590lqqQ/Dk/sepsHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560598; c=relaxed/simple;
	bh=P5HZuhcGf3cFBA+A3tV5V3VnkK+SmRrbOL72QSgrTKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwZZGptKnjpJlWauIbh1z4U4yn75rJ+Db6V6yMPSgD91rXlexQgUvGDXPh0uyTSoTn7CTMzyQipxOcn9M9Gp4gntmxeVqpBDSo1IWeeLwvjf/RUHrAVS0YIk7tVkSVZ1sWgVRluZJ311xIPzsyKzOd4SAWE0eNOySJzKNchQS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=B2sad9+f; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=yrQTyP91hTnzUDfr+6Z9M449GasNlZJsvCf6FX7ZLlY=; b=B2sad9+f1PHt+PgD
	BwJtNHQLBDsArkExCpm49vTqBbJQSdZucuFfaOHo9BkPRW7Dwpe79ZCX8hr7QGZGhvtZKavXwSAjZ
	ODMtfY0rvM8hqOAm5eNmRLFdSrrvupSLv8PjXgx6tt4onfZ5bs1B9UZGqHv766W6mKxauAB/QSvs8
	yls05WaaOfx21ayQUZTSJtah6WcftN/I7092jqG/YuDRyMot2qXrPWmZ0YmufBZoMoVGFKulXp0HS
	PfnHQ2nOFjmlXt2f2DK5PwVRhl+0nwiTLsxErfHLyx5KuAFQurnEl2zgps6OazCoz3+hpJ5gzpEFG
	iQAlRw//GhWkONkR8Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7Fra-00F6WZ-2I;
	Sat, 02 Nov 2024 15:16:30 +0000
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
Subject: [PATCH net-next 4/4] sfc: Remove more unused functions
Date: Sat,  2 Nov 2024 15:16:25 +0000
Message-ID: <20241102151625.39535-5-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102151625.39535-1-linux@treblig.org>
References: <20241102151625.39535-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

efx_ticks_to_usecs(), efx_reconfigure_port(), efx_ptp_get_mode(), and
efx_tx_get_copy_buffer_limited() are unused.
They seem to be partially due to the later splits to Siena, but
some seem unused for longer.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/sfc/efx.c        |  8 --------
 drivers/net/ethernet/sfc/efx.h        |  1 -
 drivers/net/ethernet/sfc/efx_common.c | 16 ----------------
 drivers/net/ethernet/sfc/efx_common.h |  1 -
 drivers/net/ethernet/sfc/ptp.c        |  5 -----
 drivers/net/ethernet/sfc/ptp.h        |  1 -
 drivers/net/ethernet/sfc/tx.c         |  8 --------
 drivers/net/ethernet/sfc/tx.h         |  3 ---
 8 files changed, 43 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 36b3b57e2055..0382ac30d1aa 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -417,14 +417,6 @@ unsigned int efx_usecs_to_ticks(struct efx_nic *efx, unsigned int usecs)
 	return usecs * 1000 / efx->timer_quantum_ns;
 }
 
-unsigned int efx_ticks_to_usecs(struct efx_nic *efx, unsigned int ticks)
-{
-	/* We must round up when converting ticks to microseconds
-	 * because we round down when converting the other way.
-	 */
-	return DIV_ROUND_UP(ticks * efx->timer_quantum_ns, 1000);
-}
-
 /* Set interrupt moderation parameters */
 int efx_init_irq_moderation(struct efx_nic *efx, unsigned int tx_usecs,
 			    unsigned int rx_usecs, bool rx_adaptive,
diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
index 7a6cab883d66..45e191686625 100644
--- a/drivers/net/ethernet/sfc/efx.h
+++ b/drivers/net/ethernet/sfc/efx.h
@@ -168,7 +168,6 @@ extern const struct ethtool_ops efx_ethtool_ops;
 
 /* Global */
 unsigned int efx_usecs_to_ticks(struct efx_nic *efx, unsigned int usecs);
-unsigned int efx_ticks_to_usecs(struct efx_nic *efx, unsigned int ticks);
 int efx_init_irq_moderation(struct efx_nic *efx, unsigned int tx_usecs,
 			    unsigned int rx_usecs, bool rx_adaptive,
 			    bool rx_may_override_tx);
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 13cf647051af..c88ec3e24836 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -635,22 +635,6 @@ int __efx_reconfigure_port(struct efx_nic *efx)
 	return rc;
 }
 
-/* Reinitialise the MAC to pick up new PHY settings, even if the port is
- * disabled.
- */
-int efx_reconfigure_port(struct efx_nic *efx)
-{
-	int rc;
-
-	EFX_ASSERT_RESET_SERIALISED(efx);
-
-	mutex_lock(&efx->mac_lock);
-	rc = __efx_reconfigure_port(efx);
-	mutex_unlock(&efx->mac_lock);
-
-	return rc;
-}
-
 /**************************************************************************
  *
  * Device reset and suspend
diff --git a/drivers/net/ethernet/sfc/efx_common.h b/drivers/net/ethernet/sfc/efx_common.h
index 2c54dac3e662..19a8ca530969 100644
--- a/drivers/net/ethernet/sfc/efx_common.h
+++ b/drivers/net/ethernet/sfc/efx_common.h
@@ -40,7 +40,6 @@ void efx_destroy_reset_workqueue(void);
 void efx_start_monitor(struct efx_nic *efx);
 
 int __efx_reconfigure_port(struct efx_nic *efx);
-int efx_reconfigure_port(struct efx_nic *efx);
 
 #define EFX_ASSERT_RESET_SERIALISED(efx)				\
 	do {								\
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index aaacdcfa54ae..36bceeeb6483 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -1800,11 +1800,6 @@ int efx_ptp_tx(struct efx_nic *efx, struct sk_buff *skb)
 	return NETDEV_TX_OK;
 }
 
-int efx_ptp_get_mode(struct efx_nic *efx)
-{
-	return efx->ptp_data->mode;
-}
-
 int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
 			unsigned int new_mode)
 {
diff --git a/drivers/net/ethernet/sfc/ptp.h b/drivers/net/ethernet/sfc/ptp.h
index 6946203499ef..feab7bdd7889 100644
--- a/drivers/net/ethernet/sfc/ptp.h
+++ b/drivers/net/ethernet/sfc/ptp.h
@@ -26,7 +26,6 @@ int efx_ptp_get_ts_config(struct efx_nic *efx,
 void efx_ptp_get_ts_info(struct efx_nic *efx,
 			 struct kernel_ethtool_ts_info *ts_info);
 bool efx_ptp_is_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
-int efx_ptp_get_mode(struct efx_nic *efx);
 int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
 			unsigned int new_mode);
 int efx_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
index fe2d476028e7..6b4a343a455d 100644
--- a/drivers/net/ethernet/sfc/tx.c
+++ b/drivers/net/ethernet/sfc/tx.c
@@ -49,14 +49,6 @@ static inline u8 *efx_tx_get_copy_buffer(struct efx_tx_queue *tx_queue,
 	return (u8 *)page_buf->addr + offset;
 }
 
-u8 *efx_tx_get_copy_buffer_limited(struct efx_tx_queue *tx_queue,
-				   struct efx_tx_buffer *buffer, size_t len)
-{
-	if (len > EFX_TX_CB_SIZE)
-		return NULL;
-	return efx_tx_get_copy_buffer(tx_queue, buffer);
-}
-
 static void efx_tx_maybe_stop_queue(struct efx_tx_queue *txq1)
 {
 	/* We need to consider all queues that the net core sees as one */
diff --git a/drivers/net/ethernet/sfc/tx.h b/drivers/net/ethernet/sfc/tx.h
index f2c4d2f89919..f882749af8c3 100644
--- a/drivers/net/ethernet/sfc/tx.h
+++ b/drivers/net/ethernet/sfc/tx.h
@@ -15,9 +15,6 @@
 unsigned int efx_tx_limit_len(struct efx_tx_queue *tx_queue,
 			      dma_addr_t dma_addr, unsigned int len);
 
-u8 *efx_tx_get_copy_buffer_limited(struct efx_tx_queue *tx_queue,
-				   struct efx_tx_buffer *buffer, size_t len);
-
 /* What TXQ type will satisfy the checksum offloads required for this skb? */
 static inline unsigned int efx_tx_csum_type_skb(struct sk_buff *skb)
 {
-- 
2.47.0


