Return-Path: <netdev+bounces-284474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAqlAEEN+mntIgMAu9opvQ
	(envelope-from <netdev+bounces-284474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:31:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015E4D03AB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A2E7301AA41
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700EC48A2B8;
	Tue,  5 May 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFWW1cFN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1C48A2B0;
	Tue,  5 May 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995045; cv=none; b=Rw3qwGpVi+N0/X4aNxo5wPE9gfI0xbY5enOXE452P+8qtjdfP/H7FUin+n6cqHC6HirUk8wJt/aQGZtlAFuSMjBCXzrwZlHbKfMl4PL6tHe7F2zaJaL/Be77iJp3aQlZKRpAZU3AzFsQR5bPT/QOVsK/Tr4rnX8pRZXdphk7Z4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995045; c=relaxed/simple;
	bh=tW48HlJuAqt1uoO3c4Wb5mF08n2Ne4gOKzKaMUhMJ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPAkuG/F4JrNyHM+ylHZ6OkhFq4Ex8C06t4Zl4zMa7UbavHTOJzie72bHmoSrX12CFmrOUPaFpo5qyWP4SHnOdLzrjeej0t+D7e7gqDQLL+Dw0l+V+anNsYsl5nKgB93mnS16PEleLY/ORLV8i1znso/Cv6ivxp/MecIY8pb8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFWW1cFN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777995044; x=1809531044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tW48HlJuAqt1uoO3c4Wb5mF08n2Ne4gOKzKaMUhMJ3s=;
  b=YFWW1cFNRtegUxM8VRIooSwPwHnmk2ehbcLB1Maz3Qi2jm+EXHST+0Gy
   TVt+B/gSA2Z95SjMuMrtDxJiYtJPpkKQr2z2AGLXOq9InhNVXz4tQVgMW
   QtpvJPUjIEEX88mIavFseweHH77H+jao12bOVYyYfrHLSqi9442HECenX
   YnyV2BqTiu5q8EOCqe8QBe3BAMX9us0D3al653YrjjW023VOdMJqKnBc2
   ZbCG1e0LdzndqnvBW4NYoLNKlN+P/vbsJcpwCpRfPKJQSmiHS5NDPRkKC
   k6nIL6NUA15bbSF5tS05TqcgZs/L0NpUFXQkbtI+xAh9mTNZZBrSGwp+j
   A==;
X-CSE-ConnectionGUID: 2OouqM7dQeiCDGvzwM/glg==
X-CSE-MsgGUID: yIbzfe32RLyqIGb+ra7y1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="104317004"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="104317004"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:30:44 -0700
X-CSE-ConnectionGUID: 7QXW066YS9ebb1/WFX/Z1Q==
X-CSE-MsgGUID: /k/sMIPdTD+M2/1DK8EUfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="234971567"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa010.jf.intel.com with ESMTP; 05 May 2026 08:30:41 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kohei Enju <kohei@enjuk.jp>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v5 2/5] libeth: handle creating pools with unreadable buffers
Date: Tue,  5 May 2026 17:29:20 +0200
Message-ID: <20260505152923.1040589-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152923.1040589-1-aleksander.lobakin@intel.com>
References: <20260505152923.1040589-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6015E4D03AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284474-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

libeth uses netmems for quite some time already, so in order to
support unreadable frags / memory providers, it only needs to set
PP_FLAG_ALLOW_UNREADABLE_NETMEM when needed.
Also add a couple sanity checks to make sure the driver didn't mess
up the configuration options and, in case when an MP is installed,
return the truesize always equal to PAGE_SIZE, so that
libeth_rx_alloc() will never try to allocate frags. Memory providers
manage buffers on their own and expect 1:1 buffer / HW Rx descriptor
association.

Bonus: mention in the libeth_sqe_type description that
LIBETH_SQE_EMPTY should also be used for netmem Tx SQEs -- they
don't need DMA unmapping.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/tx.h                |  2 +-
 drivers/net/ethernet/intel/libeth/rx.c | 42 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index c3db5c6f1641..a66fc2b3a114 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -12,7 +12,7 @@
 
 /**
  * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
- * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX/XSk frame, no action required
+ * @LIBETH_SQE_EMPTY: empty OR netmem/XDP_TX/XSk frame, no action required
  * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
  * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
  * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 8874b714cdcc..11e6e8f353ef 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 
 #include <net/libeth/rx.h>
+#include <net/netdev_queues.h>
 
 /* Rx buffer management */
 
@@ -139,9 +140,47 @@ static bool libeth_rx_page_pool_params_zc(struct libeth_fq *fq,
 	fq->buf_len = clamp(mtu, LIBETH_RX_BUF_STRIDE, max);
 	fq->truesize = fq->buf_len;
 
+	/*
+	 * Allow frags only for kernel pages. `fq->truesize == pp->max_len`
+	 * will always fall back to regular page_pool_alloc_netmems()
+	 * regardless of the MTU / FQ buffer size.
+	 */
+	if (pp->flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM)
+		fq->truesize = pp->max_len;
+
 	return true;
 }
 
+/**
+ * libeth_rx_page_pool_check_unread - check input params for unreadable MPs
+ * @fq: buffer queue to check
+ * @pp: &page_pool_params for the queue
+ *
+ * Make sure we don't create an invalid pool with full-frame unreadable
+ * buffers, bidirectional unreadable buffers or so, and configure the
+ * ZC payload pool accordingly.
+ *
+ * Return: true on success, false on invalid input params.
+ */
+static bool libeth_rx_page_pool_check_unread(const struct libeth_fq *fq,
+					     struct page_pool_params *pp)
+{
+	if (!netif_rxq_has_unreadable_mp(pp->netdev, pp->queue_idx))
+		return true;
+
+	/* For now, the core stack doesn't allow XDP with unreadable frags */
+	if (fq->xdp)
+		return false;
+
+	/* It should be either a header pool or a ZC payload pool */
+	if (fq->type == LIBETH_FQE_HDR)
+		return !fq->hsplit;
+
+	pp->flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+
+	return fq->hsplit;
+}
+
 /**
  * libeth_rx_fq_create - create a PP with the default libeth settings
  * @fq: buffer queue struct to fill
@@ -165,6 +204,9 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 	struct page_pool *pool;
 	int ret;
 
+	if (!libeth_rx_page_pool_check_unread(fq, &pp))
+		return -EINVAL;
+
 	pp.dma_dir = fq->xdp ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 
 	if (!fq->hsplit)
-- 
2.54.0


