Return-Path: <netdev+bounces-243594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37478CA45A7
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64A83091CC2
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757F2DEA86;
	Thu,  4 Dec 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nb0SPnxX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D892ECD39;
	Thu,  4 Dec 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863516; cv=none; b=lGd2YMnDaOA5HazQWWOi3iPwOASdNjj5BugUS9qwn6o1qJnCQFHW6OMiISLPw/llbm9JNujg8rb19S8AhDQdzIpT0sHSqAQLEsOGWOxPs6Hl9eaAkrAhJcCvmyE4Dpsl4HcbnlFlIcN1a78XVr6kUC/BvtZJ8dwG+vNj77iH1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863516; c=relaxed/simple;
	bh=L3OiQcHDPaq3/WHNiZqPxGXFgCaFXawWIxwJ16AU97w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYGkjZwfxjMx6s9QobQaloxCkGIpIS1krJ92j3XdvMwfk4ZRcJPeifURoiAO0eO0kBLS8XEfwqrqO8xFemxGBLkaOpqU9MUe1a2hc/VF0v8qBgSbl+uCt33wLJUYkTcVF+W7y03dfrnZIxrKMT+9h8dwHirHmin8Iec5BmCLbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nb0SPnxX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764863514; x=1796399514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3OiQcHDPaq3/WHNiZqPxGXFgCaFXawWIxwJ16AU97w=;
  b=nb0SPnxXp0cVb+Uf6fLVn3c9H0u7W+vqsQkgbLC7PSYAXC2BJmknB79G
   n2jOfoP3R2R8LwZB5Pmn9L6KUtuKh2l43THuNAZRXxVpLZb7PNKfpf911
   F8+CVS0Y8mO7DK/5TTKTdpdhRuuKvtVDfDN6o0vbW3WoGL2QJY1b5FOZZ
   jt5S9jUPmd+yjLVD6BotE3ilXe7Ps1hwSsHjmpKuYtug0GSu2hlzVuBCV
   Jt99vIH9hFzwT/p1qnTDjDYN8GJOmfS1rGaDGoGbWCUzB1jlbHymDYMox
   FAK9QVXSbniEs/Xk6Hm2xz8C9yE8ch2a5qi0eidxe12FS3uD8/QLFM7bA
   Q==;
X-CSE-ConnectionGUID: GRrG/ttqQHq1snIYHSPbGw==
X-CSE-MsgGUID: Z+HAxkVrQGKBXbVJBVlyKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="92365119"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="92365119"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 07:51:54 -0800
X-CSE-ConnectionGUID: R5UzEMHEQgW0sxAPMd0OeQ==
X-CSE-MsgGUID: 5ei7+SQ4Ty6ytCEl+C5d6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="194677273"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2025 07:51:51 -0800
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 2/5] libeth: handle creating pools with unreadable buffers
Date: Thu,  4 Dec 2025 16:51:30 +0100
Message-ID: <20251204155133.2437621-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/net/ethernet/intel/libeth/rx.c | 45 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

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
index 9ac3a1448b2f..9b45c9cdd599 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 
 #include <net/libeth/rx.h>
+#include <net/netdev_queues.h>
 
 /* Rx buffer management */
 
@@ -139,9 +140,50 @@ static bool libeth_rx_page_pool_params_zc(struct libeth_fq *fq,
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
+	if (!pp->netdev)
+		return true;
+
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
@@ -166,6 +208,9 @@ int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev)
 	struct page_pool *pool;
 	int ret;
 
+	if (!libeth_rx_page_pool_check_unread(fq, &pp))
+		return -EINVAL;
+
 	pp.dma_dir = fq->xdp ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 
 	if (!fq->hsplit)
-- 
2.52.0


