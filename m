Return-Path: <netdev+bounces-273606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IHlDqW8y2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:23:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A137536969C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47141306DD66
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192C3E1208;
	Tue, 31 Mar 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MNS9KWvo"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E02C3251;
	Tue, 31 Mar 2026 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959724; cv=none; b=Al3/1ifH319cT29tFFpd3JcAwywPmNCmJhrfScXSPcS1+fz5WOH8IrqKHuGr3jxoE/s0Blazwm1yoEy1fruSXcw5y6Q8kOAj0OrKAzBO2L0eZHqnLJUacbuDAQHIf8/tzLYkQbyMDrhtdoelyrEKxrCCzryCjQL8xIsm1sIDao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959724; c=relaxed/simple;
	bh=1F1azVAzkT5EnuLUYMWDHmBo8/lC/xePJ10aJO0UJ6U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fa40/3aPvLxZZJaqlvQ2MEqaIKAphorQHfmMUaZHLBCnTP4O5pEwRH85Xr3jWgXLq6kKW5hop+kxtAE5cPRDP4GNXDgTPDsxEh3XGnQojijxXc3XuSAuCi+o70fCr1BaoJUaYAQIBFjf8p5mwauMIjlOvN9+u/fJq4yQAwkz9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MNS9KWvo; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774959712; bh=O1e29pfqzsnpzKtY/9sbB9RKg3xV42wt1iDskPHFzQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MNS9KWvoZFbfngeFBxHXXL2XXtWZ4xvkV7EqFh5Y3Zr7VKgtNQqwAsTRfltQvjQtR
	 HOt8JRmY1vx/EcHPuGf4uVLGjlvgQSuE+IBoq9m3e0pU9dIGOZF2AA+Mh1eTXQLGz8
	 i1BUbz31T/XM6KjWQDZHsmqf61+ooef9S6Soef4A=
Received: from June.localdomain ([123.121.145.35])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 570A9069; Tue, 31 Mar 2026 20:21:48 +0800
X-QQ-mid: xmsmtpt1774959708te05er9gl
Message-ID: <tencent_EB7280CE1394ABF5035CDA078FC60A481906@qq.com>
X-QQ-XMAILINFO: Ni33zkRHTF0SdHDtUXCekrUCvOTv7j8tUUuiDz/dyPNROWYDTPZVrCzHgkVorD
	 5Fdf+80AxlGTXNdsHbTKrjvreWjdF7LkX1EgEpIR+qGap7Gd0A+MtZnIRMyE/AVfvkJmGNot10Kf
	 UFsIqwQi5ALk+jnoz/f9ztAOc4aVU/N+qScimtgipTMPjTzh23uVX6bgwt28lW6FflkE3JTn6kY7
	 Du3ICNXac3AntMfbdEqUgctCspjBfpvs8TI4B6uu832tT2g3ICt8SJZI6qp/rsHze9JQGBYWzW0z
	 87arifJqhqY49noXLl0+FxFwy3z7P1mwYGHA+6RbJg1M18Zg+clm6oLK2APmcUAH5wln6wKGf1Ao
	 BDA9yUh5Tg+s/idE/FwX11SI0uPTWAI1elHVELQ8xaeUi8sBKw2r7c2ijHUfdaeyA+44ap+4wxWR
	 dfT1E/sRGTvhqWMZ8WtN7dbxfd2qxgWuCb8f33JAwzfDlZBYsLM9p4ReA4lDSsnSX7hB5bmQnpV3
	 dFyaZUrsF2S7mg9gav1mRaiyRyznva8Wrmft5RJrU2tnRAF1qOszau7wxORpBQ+reAnlZewAo9mD
	 RoBiyTdIJuy7Mmeb8Pl3+jDLmdCxVUELoKAYbEHbbRT9/fL/SFCQ2jpjE4klo0DjD6jReKrKhHTm
	 vwQf5r5TkvTpIxHgptt/Fvw0zh44vmYRWtn/h1C0j9SJzIbtUprgV0FcmbcPi2wcj+ZHgPsgq9B6
	 uFv7IK4AoHVcniymp4HEOH1xFYj2Lpuv1IYsZNcwVtsDxTIsbYocavYpQNl6DCLJ0MOe0SMAq+1B
	 eSBRCznHL4Nu8IKZ8cDitajEHGPPgT7PzrW22cXpzigKEqyuXjV+htqCKj/yxlUn0JaOyvKNDF9a
	 vhGecSObaoDcEXX41/75jQ0Dc1nUMviifM4WPXYmHCBIIKCkbURL2+s1NiFKEoAVPyZwBVVhfmut
	 4cCNGJgAgcUx1iI7GbufQcBJpyeFjlVzjutLBdGuFjkEuqp9A3Tm/LUk9svCVZ1J/dWMsqQRQkUi
	 IsBhM10xApmKB5Z5yLkWBTALHQg4a39vlmTFfT/R3gRuKtp9MRQW+srReWgwhwgq4jJnMxf3oyTN
	 27pwcMjxNh9lTEKVzG7Df8u2ctGRDknBiWeA6MsXn/vde5Vcgf4d6NWmptBUKUj6PMaqdElqqj+d
	 pLflg=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Wang Jun <1742789905@qq.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wang Jun <1742789905@qq.com>
Subject: [PATCH v2] net: ns83820: fix DMA mapping error handling in hard_start_xmit
Date: Tue, 31 Mar 2026 20:21:41 +0800
X-OQ-MSGID: <20260331122147.79236-1-1742789905@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <51dfd8ae-dc4e-4837-9b00-c596c457117e@redhat.com>
References: <51dfd8ae-dc4e-4837-9b00-c596c457117e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273606-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,bjtu.edu.cn,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1742789905@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: A137536969C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo Abeni,

This is v2 of the DMA mapping error handling fix for ns83820. Changes since v1:

- Added queue restart check in error path to avoid potential TX queue stall
  (as pointed out by the AI review)
- Adjusted variable declarations to follow reverse christmas tree order
- Switched from dma_unmap_single to dma_unmap_page for fragments

Thanks to reviewers for the feedback.

---

The ns83820 driver currently ignores the return values of dma_map_single()
and skb_frag_dma_map() in the transmit path. If DMA mapping fails due to
IOMMU exhaustion or SWIOTLB pressure, the driver may proceed with invalid
DMA addresses, potentially causing hardware errors, data corruption, or
system instability.

Additionally, if mapping fails midway through processing fragmented
packets, previously mapped DMA resources are not released, leading to
DMA resource leaks.

Fix this by:
1. Checking dma_mapping_error() after each DMA mapping call.
2. Implementing an error handling path to unmap successfully mapped
   buffers (both linear and fragments) using dma_unmap_single() /
   dma_unmap_page().
3. Freeing the skb using dev_kfree_skb_any() to safely handle both
   process and softirq contexts.
4. Returning NETDEV_TX_OK to drop the packet gracefully and prevent
   TX queue stagnation.
5. Moving the queue restart check (for race conditions when the queue
   was stopped) into a common label, so that the error path also
   executes it, avoiding a possible permanent TX queue stall.

This ensures compliance with the DMA API guidelines and improves driver
stability under memory pressure.

Signed-off-by: Wang Jun <1742789905@qq.com>
---
 drivers/net/ethernet/natsemi/ns83820.c | 31 +++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index cdbf82affa7b..f8d037db4ffb 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -1051,6 +1051,12 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
 	int stopped = 0;
 	int do_intr = 0;
 	volatile __le32 *first_desc;
+	int i;
+	int frag_mapped_count = 0;
+	unsigned int main_len = 0;
+	unsigned int frag_dma_len[MAX_SKB_FRAGS];
+	dma_addr_t main_buf = 0;
+	dma_addr_t frag_dma_addr[MAX_SKB_FRAGS];
 
 	dprintk("ns83820_hard_start_xmit\n");
 
@@ -1120,6 +1126,12 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
 		len -= skb->data_len;
 	buf = dma_map_single(&dev->pci_dev->dev, skb->data, len,
 			     DMA_TO_DEVICE);
+	if (dma_mapping_error(&dev->pci_dev->dev, buf)) {
+		dev_kfree_skb_any(skb);
+		goto check_queue_and_return;
+	}
+	main_buf = buf;
+	main_len = len;
 
 	first_desc = dev->tx_descs + (free_idx * DESC_SIZE);
 
@@ -1144,6 +1156,15 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
 
 		buf = skb_frag_dma_map(&dev->pci_dev->dev, frag, 0,
 				       skb_frag_size(frag), DMA_TO_DEVICE);
+		if (dma_mapping_error(&dev->pci_dev->dev, buf))
+			goto dma_map_error;
+
+		if (frag_mapped_count < MAX_SKB_FRAGS) {
+			frag_dma_addr[frag_mapped_count] = buf;
+			frag_dma_len[frag_mapped_count] = skb_frag_size(frag);
+			frag_mapped_count++;
+		}
+
 		dprintk("frag: buf=%08Lx  page=%08lx offset=%08lx\n",
 			(long long)buf, (long) page_to_pfn(frag->page),
 			frag->page_offset);
@@ -1161,12 +1182,20 @@ static netdev_tx_t ns83820_hard_start_xmit(struct sk_buff *skb,
 	spin_unlock_irq(&dev->tx_lock);
 
 	kick_tx(dev);
-
+check_queue_and_return:
 	/* Check again: we may have raced with a tx done irq */
 	if (stopped && (dev->tx_done_idx != tx_done_idx) && start_tx_okay(dev))
 		netif_start_queue(ndev);
 
 	return NETDEV_TX_OK;
+dma_map_error:
+	dma_unmap_single(&dev->pci_dev->dev, main_buf, main_len, DMA_TO_DEVICE);
+	for (i = 0; i < frag_mapped_count; i++) {
+		dma_unmap_page(&dev->pci_dev->dev, frag_dma_addr[i],
+			       frag_dma_len[i], DMA_TO_DEVICE);
+	}
+	dev_kfree_skb_any(skb);
+	goto check_queue_and_return;
 }
 
 static void ns83820_update_stats(struct ns83820 *dev)
-- 
2.43.0


