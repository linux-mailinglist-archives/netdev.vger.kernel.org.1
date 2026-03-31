Return-Path: <netdev+bounces-273577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCqtFO+sy2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:15:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B0368962
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CA6C3010BA0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DC23BC68A;
	Tue, 31 Mar 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ww9QFOHm"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D522E401;
	Tue, 31 Mar 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955735; cv=none; b=I4+2dd3DSko3ObgOzTAvFGupokO5UHmtGrxEo9JrMLfUuOiecHgW2P77YZEu5zasvOdJck7grYGsufqTOKv9bCBTpv9K7ous2TO0Xtc/bQJz8zE6CBVBWSPLEqkJxxM/Q7o5HLSav3HrPQSN/5macAFDoDDd8izeR/aVlhwIkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955735; c=relaxed/simple;
	bh=KAmfbuI5iwBdif8vuQXeQM3y5aMskbCK6lMhutpjoPM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GtO2wvV8eNRbX+EtpYAw0Znew0anMi20D/n34u3LDI5JG6ktBw5Mn5ScFJgiF3Z6chp8RthuSRXFYnNGVwjQHsJptrdgxeGsydX2T9e+sRK804r0E0WyQgtoYI7zh5PozEDe5gLOEFDVrWQzrvAFRlLy38z6xtgJPpYdeX2ulhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ww9QFOHm; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774955728; bh=W3ie+6gJsI4heJrNDtkK8uVfwNtxUifLJg0p9H4vwD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ww9QFOHm9hzbE8okmeKAKfcdBjdtAEG88FExkrAhyUKXe/KZ4Z6N2yLa17quQtaD9
	 p2FKd2n9oTXsJzgDPV2mYsDYJZgO4yQKxH1+GK4/dCwT01s9ApUU0d7PVxg0iDvvhe
	 N2lBFZGvBRnBjvyv2zbStTDsNV/9YW1F7vDpISJ4=
Received: from June.localdomain ([123.121.145.35])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 3D8378DC; Tue, 31 Mar 2026 19:15:24 +0800
X-QQ-mid: xmsmtpt1774955724tv92778pr
Message-ID: <tencent_E0D6D670591F561A4020EBC8283A39504E08@qq.com>
X-QQ-XMAILINFO: N9lasXYeZMXWJX5COvWqHTPxphuU+rOt3KcBzhvKYH3b+yTVgnWq/5MIBF03bS
	 u8ZeOoYA1Dto3CcRUvO6b0k0T2r8zYPToEfpbw2Q9kuDEZWGNn+5VYN1uK+brRrKrcAoQ68NPXbC
	 uoDp9+aLehuT0FQHiGw1FDMeBrqtEoUzcrdYXtkOjXn5+rLQsc7gKMc5M8bwJC/mQJEBU0YFIwfy
	 aUHuzV7WKNqkSXhfqzqnopYP3MLN32wBWVodzdtoqGDbZ55yO8aF0xpRq5en25OVOKn3qR/aP0wL
	 5fivYzLMU4nMxFZb4WxiH79yDSyeklEqEB1VktluGwgF4Ig5PiCAZOC3qETf8grpC8oNUunWo9WM
	 SLMIh72zcXl4PXh+2bgPH6FNr6/J93JHUERTFN/a9HFuCjRzFPb8fekZ9RDHyjSPBIRKmoNCumwS
	 NZxTO5sVoesqxra8LxiOCVAeBUuVYQLMHpp2GU48FHFBtl3nNxaW4CBNCSiA9KZfAmmVT5KfH1eJ
	 46S30lrM+GUzN0a4hjK/lnMU0xifoYupOIv8OCrMlt56k5GJjms9+fCizsPKs3FbeqMrddaUyG0H
	 e/q0rauzAN7IDxGm/SHYr3MlUeSay8iIAnyI0ur0yIubcgiFhVq6hs6LT3Ds5J9YM2DsBCXjk1Tw
	 GzNnZfhDVwSwsrKICOVYYFCvB06ZU1BKG5nCaFJz74/rRF5BLQ0lBn2/Q/zxX+jxhBq8b2cPLbUN
	 PLIJj8yVZbXKGwCaRmbzdjvk5BBm0h9kORmVXsp5RYo8nnr4cB/58ehwVeKUn3jHpgGcz11nbpKs
	 HTlEfkS5gxUKvOXWELyR+Ny+JfN57lRXBu3xPH8aw0VuLyaZFJEHpnvOmqvyTnvTKf4/pZDTISBi
	 SYjB+br4CD6yLNqcclHbBgnArmLe3R7HKlUf97g5gZt8nDNU4siJ2rRKL2vZzWNQSwitUy6i12dV
	 iNlYWJUSMvLcpkE7vW5IGHzXm6oM6oPLzHK6npfY0nkF8GagXLgA0saYDHxrq/zvZQ6m62YZDpYf
	 bCzj3qQg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
Subject: 
Date: Tue, 31 Mar 2026 19:14:40 +0800
X-OQ-MSGID: <20260331111521.79097-1-1742789905@qq.com>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	EMPTY_SUBJECT(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273577-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: B97B0368962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo Abeni,

This is v2 of the DMA mapping error handling fix for ns83820. Changes since v1:

- Added queue restart check in error path to avoid potential TX queue stall
  (as pointed out by the AI review)
- Adjusted variable declarations to follow reverse christmas tree order
- Switched from dma_unmap_single to dma_unmap_page for fragments

Thanks to reviewers for the feedback.

Subject: [PATCH v2] net: ns83820: fix DMA mapping error handling in
 hard_start_xmit

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


