Return-Path: <netdev+bounces-270671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLHwDpSPwWmuTwQAu9opvQ
	(envelope-from <netdev+bounces-270671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:08:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E02FBE6D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2B2A309F9F1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E830B517;
	Mon, 23 Mar 2026 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="GRcEtjXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E030BBB6
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291154; cv=none; b=QGN1DhTR925i3SVnhJSK+zuvqEISCkQqbPWVTqzxJ5vjMGIb0TRJdsU6TYGmlOCvEYpoXS5uVG/Cc6t3jIRNvWneTVMPmZbNXZiLtgIy+NJEhs/hsv2qrT8xMqfwS8mFEQCVk97DSjrL2+SnY111npbgSE8Y/wFrKMASJPinJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291154; c=relaxed/simple;
	bh=QZEPYt8xTmiyony78MCUXZEL4YpGdh1C5eyW5Y+WVnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8p3dVqRhdWgI8oqdLANBOkdN14Mq5KM5EhEWxbslc0IolO8YbhbgQm7z1RYd8UhXHLPOXjkNyoJgb8UFfhAfnBgNbn/BNzOeA9an8SEwvkJV2zWdgqfOGv6QF73kK3z7LBhsZyD+ImvfH0ZlG9Anfex9pFBxS9bXCflXDZtwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=GRcEtjXf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35ba749f441so406568a91.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291149; x=1774895949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlYbsuuA0c6fnb8KG9NYIAfHIVUNtAjohKtZhGZnEFE=;
        b=GRcEtjXf9wFvu+xYEDTlC95J3t5Afl7j8vWfiVFtz72GOOyjdm4wmLfK1Q9lErmpj7
         6aEp1oZ1DJ75crjkDcQ469jouSJVZBwDmf835cRb7vzShS81Mcpw3pHVKY4+nLMwB4Rh
         kVezPNPewbC+zxlPoDKYtJhRa2DQ3jCXLxrt6QKMNI7CHeNtS0pvUJW5Db8KIx/72eDi
         /Abe/I+M12vbqN90J8br2WAvO+xqJxiIbYsSv5dxN0N7rIbhMGTtWu84wuzGEm4mtA5a
         oJ1YHKxoicHDNPl/cj8r+xE+o8/NpmE9eH/0niTttWK5BT5h+prIPh1fA1AKNt/X9FHw
         ND/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291149; x=1774895949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VlYbsuuA0c6fnb8KG9NYIAfHIVUNtAjohKtZhGZnEFE=;
        b=LRnnBFh0IBkGgJZiOJDWT7yqRoI6WcnO01iNGAzpwSfKeRI4Na+eEdnR7KkiEH9e2M
         fuazZqxdJMFh4otCX9vsMbWmwGDf1uVCMJtRuCTkb+lhUaGkUjlewAydMotxSfWhxp24
         63hFXfF+SnwPfzQqNzL4dv/x9yY8biwOAQds8X5zd18xKHiEo3Fl8Z2w+VlrFk48PlUd
         z1Gm/oMsOfvpRait8MLFdLbGuqC7I6gxxXNO/C8O9JkEin2HHqtiqA6+z9Pg8m8RuF3e
         S49nVeiumHr0JUJMNG3N/Zoo3Kp+G8G7ay4Tiu62Q8XpZnwEJswrdKYmrI/h+pc/iwN9
         vYHg==
X-Gm-Message-State: AOJu0YxzK3IGEsn4fMu64XYqIcFqayBKVXqraAZmvKsrTwLdl84dhS2V
	KnLmEBCFlwpbD0VrpF7ruNdXJBwJxJHz7RXwpGinS+eqhQmJctw5lSS+dTdGaSvOpG492V5c0FU
	RuVeOhio=
X-Gm-Gg: ATEYQzx+5nO0wH95h7wKSgyeZ+0lYDvC/1qdqfdQV3BGbQHZQ3awLySXj0a75Xk4Tz0
	riTLuxZLtuS2pmhez1/SBG0LKW5NtnyTPTi6lVOIPiN4pXGM47YuQ3AcSpL9Cuvp4WreqjmJFcm
	AVg/h+aG/cv1j5+iGTM5VGZKhaBbjlT4ubR7Q9QlAo15zE9IUF//MFItmaz1PUWXeQ3giIl+Kh3
	CMz2I/m91Uwkrrr2WhLHp9SiPgqhmKTEaTi8uvGasH5sl23wwdK3Mx4aF4ALce08G2n9gIfsBpk
	JWLjmzUr4JbHLSazUEs8W27u/DcjGvBH3bq5vp/zGrAhpUjS9PzjO+cgf4YSd0uLtsg9UXTxZwR
	2lIygWf5bo2CSDgllY+o584JySAflYQvbxR+GSIZBC0jNrRIycRa2ojYuzYUmFL2W0ZdbJyHey/
	6fHtM=
X-Received: by 2002:a17:90b:1b0e:b0:35b:9dba:be26 with SMTP id 98e67ed59e1d1-35bd2c0885cmr11136098a91.10.1774291148765;
        Mon, 23 Mar 2026 11:39:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3f34b2bsm10304089a91.8.2026.03.23.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:08 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v5 05/12] net: bnxt: Use dma_unmap_len for TX completion unmapping
Date: Mon, 23 Mar 2026 11:38:30 -0700
Message-ID: <20260323183844.3146982-6-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270671-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,dama-to.20230601.gappssmtp.com:dkim,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 3F8E02FBE6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store the DMA mapping length in each TX buffer descriptor via
dma_unmap_len_set at submit time, and use dma_unmap_len at completion
time.

This is a no-op for normal packets but prepares for software USO,
where header BDs set dma_unmap_len to 0 because the header buffer
is unmapped collectively rather than per-segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 rfcv2:
   - Use some local variables to shorten long lines. No functional change from
     rfcv1.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 63 ++++++++++++++---------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4d4e7643f7dd..fe15b32b12e7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -656,6 +656,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto tx_free;
 
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
+	dma_unmap_len_set(tx_buf, len, len);
 	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
 		TX_BD_CNT(last_frag + 2);
 
@@ -720,6 +721,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
 					  mapping, mapping);
+		dma_unmap_len_set(tx_buf, len, len);
 
 		txbd->tx_bd_haddr = cpu_to_le64(mapping);
 
@@ -809,7 +811,8 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	u16 hw_cons = txr->tx_hw_cons;
 	unsigned int tx_bytes = 0;
 	u16 cons = txr->tx_cons;
-	skb_frag_t *frag;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 	int tx_pkts = 0;
 	bool rc = false;
 
@@ -844,19 +847,27 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			goto next_tx_int;
 		}
 
-		dma_unmap_single(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
-				 skb_headlen(skb), DMA_TO_DEVICE);
+		if (dma_unmap_len(tx_buf, len)) {
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len,
+					 DMA_TO_DEVICE);
+		}
+
 		last = tx_buf->nr_frags;
 
 		for (j = 0; j < last; j++) {
-			frag = &skb_shinfo(skb)->frags[j];
 			cons = NEXT_TX(cons);
 			tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
-			netmem_dma_unmap_page_attrs(&pdev->dev,
-						    dma_unmap_addr(tx_buf,
-								   mapping),
-						    skb_frag_size(frag),
-						    DMA_TO_DEVICE, 0);
+			if (dma_unmap_len(tx_buf, len)) {
+				dma_addr = dma_unmap_addr(tx_buf, mapping);
+				dma_len = dma_unmap_len(tx_buf, len);
+
+				netmem_dma_unmap_page_attrs(&pdev->dev,
+							    dma_addr, dma_len,
+							    DMA_TO_DEVICE, 0);
+			}
 		}
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
@@ -3402,6 +3413,8 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 {
 	int i, max_idx;
 	struct pci_dev *pdev = bp->pdev;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 
 	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
 
@@ -3412,10 +3425,10 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 		if (idx  < bp->tx_nr_rings_xdp &&
 		    tx_buf->action == XDP_REDIRECT) {
-			dma_unmap_single(&pdev->dev,
-					 dma_unmap_addr(tx_buf, mapping),
-					 dma_unmap_len(tx_buf, len),
-					 DMA_TO_DEVICE);
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len, DMA_TO_DEVICE);
 			xdp_return_frame(tx_buf->xdpf);
 			tx_buf->action = 0;
 			tx_buf->xdpf = NULL;
@@ -3437,23 +3450,27 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 			continue;
 		}
 
-		dma_unmap_single(&pdev->dev,
-				 dma_unmap_addr(tx_buf, mapping),
-				 skb_headlen(skb),
-				 DMA_TO_DEVICE);
+		if (dma_unmap_len(tx_buf, len)) {
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len, DMA_TO_DEVICE);
+		}
 
 		last = tx_buf->nr_frags;
 		i += 2;
 		for (j = 0; j < last; j++, i++) {
 			int ring_idx = i & bp->tx_ring_mask;
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
 
 			tx_buf = &txr->tx_buf_ring[ring_idx];
-			netmem_dma_unmap_page_attrs(&pdev->dev,
-						    dma_unmap_addr(tx_buf,
-								   mapping),
-						    skb_frag_size(frag),
-						    DMA_TO_DEVICE, 0);
+			if (dma_unmap_len(tx_buf, len)) {
+				dma_addr = dma_unmap_addr(tx_buf, mapping);
+				dma_len = dma_unmap_len(tx_buf, len);
+
+				netmem_dma_unmap_page_attrs(&pdev->dev,
+							    dma_addr, dma_len,
+							    DMA_TO_DEVICE, 0);
+			}
 		}
 		dev_kfree_skb(skb);
 	}
-- 
2.52.0


