Return-Path: <netdev+bounces-247513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124DDCFB6C4
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3385430196A4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA11DDA24;
	Wed,  7 Jan 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxQn1eVM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CE19AD5C
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744424; cv=none; b=oCB+M9iWU8U44INmTgSGazi9yMM06iOIgftB9YQ1TdtDB2vS+wqD/dRRGisN4NiInagsqhoO1UnHIesQ/So+cblev9xZoUJWAb0xldsXMfPgZnh8WkuWdHC6t9E9LIf62hVJcpbByBRsocNhu8o2HOSNBA73QQmXj+/qBvlNqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744424; c=relaxed/simple;
	bh=bZQ+/4PbLSwwzwQBnjb8hhYKQ+QA7M/ZWE71k3YbzGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVsJ9WlVuV73p+mK/flsmpoY9bkA+VSRt9+KwWVYs7/WghFhZ9eh6w7f+52E2QXF13ON80FplfbDnxD6Ozt8CZAlwDypLrYOmdYW9BL7NjceF6sCvdIhdPgmkvc7Qr1k68/5zCso15h/2Xsq04vNmRu+muY+7TiLLFwXIrgPVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxQn1eVM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744423; x=1799280423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZQ+/4PbLSwwzwQBnjb8hhYKQ+QA7M/ZWE71k3YbzGg=;
  b=fxQn1eVM8jtMx1zPe5bbcRpjbLWwdG1MCdYRth/CWsKmoe5cUXdwG2+6
   Vb9CNwqE8LUE3Fwiu+aet1cZksNXUyH4AtNp0v33cVzJGuuFMi6fFrru8
   6pVvPA5zL0z6bOhGsHQaLIxZ9q61Bu0oLn+vuqjAfJGeMCVV6CbPdEBZf
   kyNmaiLtOeF1nPG7CMypcI/6XHR6+G8YBvR3FzZj1kD0frP1F8/CzW7Wb
   JzWa0O/JTWDaNBIs/l5bDXuC+lty1+H5E94NWugt00u0Llri/iSQpoPwo
   /G0Zzlg/0Chw47QsKbbp2xaBbEuf2qgQ6upXBPqHywCxwz5GtTnMjR6/R
   A==;
X-CSE-ConnectionGUID: 42JZC/agSaCnDPMZuuC0qg==
X-CSE-MsgGUID: lPrRdgVsTcCZQOJuJ4WTqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161684"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161684"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:55 -0800
X-CSE-ConnectionGUID: 70FfVLr8QkS2D3in59UJaA==
X-CSE-MsgGUID: wURHrlcXSciZiA4pC4V3tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841213"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	David Decotigny <ddecotig@google.com>
Subject: [PATCH net 12/13] idpf: cap maximum Rx buffer size
Date: Tue,  6 Jan 2026 16:06:44 -0800
Message-ID: <20260107000648.1861994-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
References: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

The HW only supports a maximum Rx buffer size of 16K-128. On systems
using large pages, the libeth logic can configure the buffer size to be
larger than this. The upper bound is PAGE_SIZE while the lower bound is
MTU rounded up to the nearest power of 2. For example, ARM systems with
a 64K page size and an mtu of 9000 will set the Rx buffer size to 16K,
which will cause the config Rx queues message to fail.

Initialize the bufq/fill queue buf_len field to the maximum supported
size. This will trigger the libeth logic to cap the maximum Rx buffer
size by reducing the upper bound.

Fixes: 74d1412ac8f37 ("idpf: use libeth Rx buffer management for payload buffer")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: David Decotigny <ddecotig@google.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 +++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f51d52297e1e..7f3933ca9edc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -695,9 +695,10 @@ static int idpf_rx_buf_alloc_singleq(struct idpf_rx_queue *rxq)
 static int idpf_rx_bufs_init_singleq(struct idpf_rx_queue *rxq)
 {
 	struct libeth_fq fq = {
-		.count	= rxq->desc_count,
-		.type	= LIBETH_FQE_MTU,
-		.nid	= idpf_q_vector_to_mem(rxq->q_vector),
+		.count		= rxq->desc_count,
+		.type		= LIBETH_FQE_MTU,
+		.buf_len	= IDPF_RX_MAX_BUF_SZ,
+		.nid		= idpf_q_vector_to_mem(rxq->q_vector),
 	};
 	int ret;
 
@@ -754,6 +755,7 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
 		.truesize	= bufq->truesize,
 		.count		= bufq->desc_count,
 		.type		= type,
+		.buf_len	= IDPF_RX_MAX_BUF_SZ,
 		.hsplit		= idpf_queue_has(HSPLIT_EN, bufq),
 		.xdp		= idpf_xdp_enabled(bufq->q_vector->vport),
 		.nid		= idpf_q_vector_to_mem(bufq->q_vector),
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 0472698ca192..423cc9486dce 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -101,6 +101,7 @@ do {								\
 		idx = 0;					\
 } while (0)
 
+#define IDPF_RX_MAX_BUF_SZ			(16384 - 128)
 #define IDPF_RX_BUF_STRIDE			32
 #define IDPF_RX_BUF_POST_STRIDE			16
 #define IDPF_LOW_WATERMARK			64
-- 
2.47.1


