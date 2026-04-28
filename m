Return-Path: <netdev+bounces-281685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDxrOFdj8GkRSwEAu9opvQ
	(envelope-from <netdev+bounces-281685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F93447EF8E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 100D0306FB8B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6CB3DBD5C;
	Tue, 28 Apr 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg0N6chZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6003DA5B6;
	Tue, 28 Apr 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360938; cv=none; b=GO3R+SuPSXFa0cBIiJJSAXetAfvHEt4k3nUSd314IHN0hLDm8F0mTlSDPmF9/GbYAnrd8eLKM3XyHlfdmjd1hrKUMh8lxJP+uc45nwneiAW5f6Fq47rSLIUz2+38fWa++/7yI1mXCuLVdcuk7yVHp775KUgimOTRG7lI4vUYOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360938; c=relaxed/simple;
	bh=AlIGB9lf9eF95T/O7YxOQaHcetghLMJ9AjutOyvepFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBSaouJk8X08rQl1V9RklhWfuVR6Sh5kGsVACfTSE8vHdN0iYZwNDCXG6jnwuYrYjTdz65fdVnYZ1b/t9Ux2p6zkhZGdxffe8IieeCNnSXgZwAtbwGnWA3Xsl7NKZPy65p2d/2gXmQRYygE9uAI5JR118dHGUAg45WMStaxII+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg0N6chZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360936; x=1808896936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AlIGB9lf9eF95T/O7YxOQaHcetghLMJ9AjutOyvepFM=;
  b=Rg0N6chZQ7NylPv2QjzdniwOaoVqnQfUGhaNsZIKc6xenO1hfLEvCeXT
   9a7HQLMPkw7pFWGtOLoc7XUnsif9yoXYHDd6ZScVh2T2HeO+BOH2wuvjE
   2haxLxkBaCQUp7MBRRLHoPQYd7sQpRHxtMoqON1JdXnJNrCsvaCfK2KBf
   0usLjSPGIZp+1n197zybuq6VEfNG9rCp8TX3i8p1QsS2DfG4ja5FGl22b
   EIhPz0OFqKuvHhye+xau5HWhBQPaKfcP5vWzaNi1/mhiex8HuuVlnZBcv
   kTlZz/snuSDGMWYoIh0ZmGTzdmFTy2EfF97zM/c7EcA1gFClZQAEO3dmM
   w==;
X-CSE-ConnectionGUID: cRFXabFxSneILjP+0NvsAw==
X-CSE-MsgGUID: D8oo87DWQcSiiage+KD0oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82126034"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82126034"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:22:14 -0700
X-CSE-ConnectionGUID: H5kDPuT4Ss+YWSlcnRBJxQ==
X-CSE-MsgGUID: pj2YPWByQj65M2GxjalYBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229308639"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 28 Apr 2026 00:22:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 092599D; Tue, 28 Apr 2026 09:22:10 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 4/9] thunderbolt / net: Move ring_frame_size() to thunderbolt.h
Date: Tue, 28 Apr 2026 09:22:04 +0200
Message-ID: <20260428072209.3084930-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F93447EF8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281685-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]

This function can be used outside of thunderbolt networking driver so
move it to the common header.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 16 ++++++----------
 include/linux/thunderbolt.h    | 10 +++++++++-
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index d8fcf18fc55c..49673f7e0055 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -38,7 +38,7 @@
 #define TBNET_MATCH_FRAGS_ID	BIT(1)
 #define TBNET_64K_FRAMES	BIT(2)
 #define TBNET_MAX_MTU		SZ_64K
-#define TBNET_FRAME_SIZE	SZ_4K
+#define TBNET_FRAME_SIZE	TB_MAX_FRAME_SIZE
 #define TBNET_MAX_PAYLOAD_SIZE	\
 	(TBNET_FRAME_SIZE - sizeof(struct thunderbolt_ip_frame_header))
 /* Rx packets need to hold space for skb_shared_info */
@@ -327,11 +327,6 @@ static void stop_login(struct tbnet *net)
 	netdev_dbg(net->dev, "login stopped\n");
 }
 
-static inline unsigned int tbnet_frame_size(const struct tbnet_frame *tf)
-{
-	return tf->frame.size ? : TBNET_FRAME_SIZE;
-}
-
 static void tbnet_free_buffers(struct tbnet_ring *ring)
 {
 	unsigned int i;
@@ -561,7 +556,7 @@ static struct tbnet_frame *tbnet_get_tx_buffer(struct tbnet *net)
 	tf->frame.size = 0;
 
 	dma_sync_single_for_cpu(dma_dev, tf->frame.buffer_phy,
-				tbnet_frame_size(tf), DMA_TO_DEVICE);
+				tb_ring_frame_size(&tf->frame), DMA_TO_DEVICE);
 
 	return tf;
 }
@@ -743,7 +738,7 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
 	}
 
 	/* Should be greater than just header i.e. contains data */
-	size = tbnet_frame_size(tf);
+	size = tb_ring_frame_size(&tf->frame);
 	if (size <= sizeof(*hdr)) {
 		net->stats.rx_length_errors++;
 		return false;
@@ -1010,7 +1005,8 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
 						hdr->frame_index, hdr->frame_count);
 			dma_sync_single_for_device(dma_dev,
 				frames[i]->frame.buffer_phy,
-				tbnet_frame_size(frames[i]), DMA_TO_DEVICE);
+				tb_ring_frame_size(&frames[i]->frame),
+						   DMA_TO_DEVICE);
 		}
 
 		return true;
@@ -1084,7 +1080,7 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
 	 */
 	for (i = 0; i < frame_count; i++) {
 		dma_sync_single_for_device(dma_dev, frames[i]->frame.buffer_phy,
-			tbnet_frame_size(frames[i]), DMA_TO_DEVICE);
+			tb_ring_frame_size(&frames[i]->frame), DMA_TO_DEVICE);
 	}
 
 	return true;
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index f60e3a1aecae..1d1bd458b5af 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -628,7 +628,15 @@ struct ring_frame {
 };
 
 /* Minimum size for ring_rx */
-#define TB_FRAME_SIZE		0x100
+#define TB_FRAME_SIZE		256
+#define TB_MAX_FRAME_SIZE	4096
+
+static inline size_t tb_ring_frame_size(const struct ring_frame *frame)
+{
+	if (frame->size)
+		return frame->size;
+	return TB_MAX_FRAME_SIZE;
+}
 
 struct tb_ring *tb_ring_alloc_tx(struct tb_nhi *nhi, int hop, int size,
 				 unsigned int flags);
-- 
2.50.1


