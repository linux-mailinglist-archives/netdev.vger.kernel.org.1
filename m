Return-Path: <netdev+bounces-306705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mTKULDpqUWppEQMAu9opvQ
	(envelope-from <netdev+bounces-306705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:55:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F973F382
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:55:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SaR+fwQ3;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306705-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306705-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9B0303F64F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628013CE4BA;
	Fri, 10 Jul 2026 21:53:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883D3D1A8F;
	Fri, 10 Jul 2026 21:53:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720408; cv=none; b=Pa9d8YGR88nF6hctE2+Fd4QTjZOHy0uIkgvTEq6xn9cPs5NICrI/yzLREsVUMiuRNO0aGDH1yX03PyHaXkWdltOMRtQn+dbnDNx0w9pCcqTXAYse3p9LOzORIrjgvAqIphJw7+O26vAxSNzmMNOSx6JB4nPKTyDGjAauLpunnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720408; c=relaxed/simple;
	bh=oM8ow8kQYPTosAaLyEvU8U0JZ7SJ5Cbf/iZPgECmuls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndYeqvdvBGRWKba7WKPPhcrPg5Yc9+Z9lyF289fvOwJkdQ2LLnyc0SCvDHvnvWRO6z/EdYd/zeSj+ls8si+/VI+PmxYbE6mgHsZG8zHMSggxoQcvxgZ3UI2X0PLixwVSxgnLNmlb+G4S3VAnw+XD8Z01S745J9pno+f8jbUbxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaR+fwQ3; arc=none smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783720406; x=1815256406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oM8ow8kQYPTosAaLyEvU8U0JZ7SJ5Cbf/iZPgECmuls=;
  b=SaR+fwQ3txFZIO8tTNg+Va3BtcT5lSGcTeCusyrePk5Hee7EIAt/2Pna
   KNP2zD/8K/d0OTZfamyRVmrk5ddnDbXwfjDG5uNe+cLc0TkaLm2hHOu6h
   ZGvUu4lJA61/qFgEx/bun4X09wejZ5fmly4wTRyUn2Lc/tV+Ad+P6idsA
   AeDvvrIDsB6D7NUAaHwPBoKUtvpWJHAduCD4CZ5wWpl/LNTctag+Kr27M
   pus/T/T+IGRSI4BOMmkOb1VQsx5iRR1RNwU4gwfamzSs029AGDhYA9siE
   d6h2nDt4P+xfwqwkw1lnJeLNEFrZiLFuAAc0rqcUXbMnmP7/ewS0/T9CB
   A==;
X-CSE-ConnectionGUID: 5/SOZQAQS+2g8bBhQ2EH/A==
X-CSE-MsgGUID: A13cqFdDROSvf8x3pI1mPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107220741"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107220741"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:53:22 -0700
X-CSE-ConnectionGUID: oOCjw7M9TPySMsEr/ASlMg==
X-CSE-MsgGUID: L+RJ/n3zQ3iCqvNSBY2q4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254494626"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2026 14:53:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Phani R Burra <phani.r.burra@intel.com>,
	anthony.l.nguyen@intel.com,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v4 05/15] libie: add bookkeeping support for control queue messages
Date: Fri, 10 Jul 2026 14:53:02 -0700
Message-ID: <20260710215313.1475803-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306705-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:phani.r.burra@intel.com,m:anthony.l.nguyen@intel.com,m:larysa.zaremba@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:bharath.r@intel.com,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 086F973F382

From: Phani R Burra <phani.r.burra@intel.com>

All send control queue messages are allocated/freed in libie itself and
tracked with the unique transaction (Xn) ids until they receive response or
time out. Responses can be received out of order, therefore transactions
are stored in an array and tracked though a bitmap.

Pre-allocated DMA memory is used where possible. It reduces the driver
overhead in handling memory allocation/free and message timeouts.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
Co-developed-by: Victor Raj <victor.raj@intel.com>
Signed-off-by: Victor Raj <victor.raj@intel.com>
Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/controlq.c | 607 ++++++++++++++++++++
 include/linux/net/intel/libie/controlq.h    | 175 ++++++
 2 files changed, 782 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 5d5ccf0dedcc..885b4437b4f0 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -611,6 +611,613 @@ u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
 }
 EXPORT_SYMBOL_NS_GPL(libie_ctlq_recv, "LIBIE_CP");
 
+/**
+ * libie_ctlq_xn_pop_free - get a free Xn entry from the free list
+ * @xnm: Xn transaction manager
+ *
+ * Retrieve a free Xn entry from the free list.
+ *
+ * Return: valid Xn entry pointer or NULL if there are no free Xn entries.
+ */
+static struct libie_ctlq_xn *
+libie_ctlq_xn_pop_free(struct libie_ctlq_xn_manager *xnm)
+{
+	struct libie_ctlq_xn *xn;
+	u32 free_idx;
+
+	guard(spinlock)(&xnm->free_xns_bm_lock);
+
+	if (unlikely(xnm->shutdown))
+		return NULL;
+
+	free_idx = find_next_bit(xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES,
+				 0);
+	if (free_idx == LIBIE_CTLQ_MAX_XN_ENTRIES)
+		return NULL;
+
+	__clear_bit(free_idx, xnm->free_xns_bm);
+	xn = &xnm->ring[free_idx];
+	xn->cookie = xnm->cookie++;
+
+	return xn;
+}
+
+/**
+ * __libie_ctlq_xn_push_free - unsafely push a Xn entry into the free list
+ * @xnm: Xn transaction manager
+ * @xn: xn entry to be added into the free list
+ *
+ * Return: whether xnm destruction can be triggered by the caller
+ */
+static bool __libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
+				      struct libie_ctlq_xn *xn)
+{
+	__set_bit(xn->index, xnm->free_xns_bm);
+
+	if (unlikely(xnm->shutdown) &&
+	    bitmap_full(xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES))
+		return true;
+
+	return false;
+}
+
+/**
+ * libie_ctlq_xn_push_free - push a Xn entry into the free list
+ * @xnm: Xn transaction manager
+ * @xn: xn entry to be added into the free list, not locked
+ *
+ * Safely add a used Xn entry back to the free list.
+ */
+static void libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
+				    struct libie_ctlq_xn *xn)
+{
+	bool can_destroy;
+
+	scoped_guard(spinlock, &xnm->free_xns_bm_lock)
+		can_destroy = __libie_ctlq_xn_push_free(xnm, xn);
+
+	if (can_destroy)
+		complete(&xnm->can_destroy);
+}
+
+/**
+ * libie_ctlq_xn_deinit_dma - free the DMA memory allocated for send messages
+ * @dev: device pointer
+ * @xnm: pointer to the transaction manager
+ * @num_entries: number of Xn entries to free the DMA for
+ */
+static void libie_ctlq_xn_deinit_dma(struct device *dev,
+				     struct libie_ctlq_xn_manager *xnm,
+				     u32 num_entries)
+{
+	for (u32 i = 0; i < num_entries; i++) {
+		struct libie_ctlq_xn *xn = &xnm->ring[i];
+
+		libie_cp_free_dma_mem(dev, xn->dma_mem);
+		kfree(xn->dma_mem);
+	}
+}
+
+/**
+ * libie_ctlq_xn_init_dma - pre-allocate DMA memory for send messages that use
+ * stack variables
+ * @dev: device pointer
+ * @xnm: pointer to transaction manager
+ *
+ * Return: %0 on success or error if memory allocation fails
+ */
+static int libie_ctlq_xn_init_dma(struct device *dev,
+				  struct libie_ctlq_xn_manager *xnm)
+{
+	u32 i;
+
+	for (i = 0; i < LIBIE_CTLQ_MAX_XN_ENTRIES; i++) {
+		struct libie_ctlq_xn *xn = &xnm->ring[i];
+		struct libie_cp_dma_mem *dma_mem;
+
+		dma_mem = kzalloc_obj(*dma_mem);
+		if (!dma_mem)
+			goto dealloc_dma;
+
+		dma_mem->va = libie_cp_alloc_dma_mem(dev, dma_mem,
+						     LIBIE_CTLQ_MAX_BUF_LEN);
+		if (!dma_mem->va) {
+			kfree(dma_mem);
+			goto dealloc_dma;
+		}
+
+		xn->dma_mem = dma_mem;
+	}
+
+	return 0;
+
+dealloc_dma:
+	libie_ctlq_xn_deinit_dma(dev, xnm, i);
+
+	return -ENOMEM;
+}
+
+/**
+ * libie_ctlq_xn_process_recv - process Xn data in receive message
+ * @params: Xn receive param information to handle a receive message
+ * @ctlq_msg: received control queue message
+ *
+ * Process a control queue receive message and send a complete event
+ * notification.
+ *
+ * Return: true if a message has been processed, false otherwise.
+ */
+static bool
+libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
+			   struct libie_ctlq_msg *ctlq_msg)
+{
+	struct libie_ctlq_xn_manager *xnm = params->xnm;
+	struct libie_ctlq_xn *xn;
+	u16 msg_cookie, xn_index;
+	struct kvec *response;
+	int status;
+	u16 data;
+
+	data = ctlq_msg->sw_cookie;
+	xn_index = FIELD_GET(LIBIE_CTLQ_XN_INDEX_M, data);
+	msg_cookie = FIELD_GET(LIBIE_CTLQ_XN_COOKIE_M, data);
+	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
+
+	xn = &xnm->ring[xn_index];
+	spin_lock(&xn->xn_lock);
+	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
+	    msg_cookie != xn->cookie) {
+		spin_unlock(&xn->xn_lock);
+		return false;
+	}
+
+	if (xn->state != LIBIE_CTLQ_XN_ASYNC &&
+	    xn->state != LIBIE_CTLQ_XN_WAITING) {
+		spin_unlock(&xn->xn_lock);
+		return false;
+	}
+
+	response = &ctlq_msg->recv_mem;
+	if (xn->state == LIBIE_CTLQ_XN_ASYNC) {
+		xn->resp_cb(xn->send_ctx, response, status);
+		libie_ctlq_release_rx_buf(response);
+		xn->state = LIBIE_CTLQ_XN_IDLE;
+		spin_unlock(&xn->xn_lock);
+		libie_ctlq_xn_push_free(xnm, xn);
+
+		return true;
+	}
+
+	xn->recv_mem = *response;
+	xn->state = status ? LIBIE_CTLQ_XN_COMPLETED_FAILED :
+			     LIBIE_CTLQ_XN_COMPLETED_SUCCESS;
+
+	complete(&xn->cmd_completion_event);
+	spin_unlock(&xn->xn_lock);
+
+	return true;
+}
+
+/**
+ * libie_xn_check_async_timeout - Check for asynchronous message timeouts
+ * @xnm: Xn transaction manager
+ *
+ * Call the corresponding callback to notify the caller about the timeout.
+ */
+static void libie_xn_check_async_timeout(struct libie_ctlq_xn_manager *xnm)
+{
+	u32 idx;
+
+	for_each_clear_bit(idx, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {
+		struct libie_ctlq_xn *xn = &xnm->ring[idx];
+		u64 timeout_ms;
+
+		spin_lock(&xn->xn_lock);
+
+		timeout_ms = ktime_ms_delta(ktime_get(), xn->timestamp);
+		if (xn->state != LIBIE_CTLQ_XN_ASYNC ||
+		    timeout_ms < xn->timeout_ms) {
+			spin_unlock(&xn->xn_lock);
+			continue;
+		}
+
+		xn->resp_cb(xn->send_ctx, NULL, -ETIMEDOUT);
+		xn->state = LIBIE_CTLQ_XN_IDLE;
+		spin_unlock(&xn->xn_lock);
+		libie_ctlq_xn_push_free(xnm, xn);
+	}
+}
+
+/**
+ * libie_ctlq_xn_recv - process control queue receive message
+ * @params: Xn receive param information to handle a receive message
+ *
+ * Process a receive message and update the receive queue buffer.
+ *
+ * Return: remaining budget.
+ */
+u32 libie_ctlq_xn_recv(struct libie_ctlq_xn_recv_params *params)
+{
+	struct libie_ctlq_msg ctlq_msg;
+	u32 budget = params->budget;
+
+	while (budget && libie_ctlq_recv(params->ctlq, &ctlq_msg, 1)) {
+		budget--;
+		if (!libie_ctlq_xn_process_recv(params, &ctlq_msg))
+			params->ctlq_msg_handler(params->xnm->ctx, &ctlq_msg);
+	}
+
+	libie_ctlq_post_rx_buffs(params->ctlq);
+	libie_xn_check_async_timeout(params->xnm);
+
+	return budget;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_recv, "LIBIE_CP");
+
+/**
+ * libie_cp_map_dma_mem - map a given virtual address for DMA
+ * @dev: device information
+ * @va: virtual address to be mapped
+ * @size: size of the memory
+ * @direction: DMA direction either from/to device
+ * @dma_mem: memory for DMA information to be stored
+ *
+ * Return: true on success, false on DMA map failure.
+ */
+static bool libie_cp_map_dma_mem(struct device *dev, void *va, size_t size,
+				 int direction,
+				  struct libie_cp_dma_mem *dma_mem)
+{
+	dma_mem->pa = dma_map_single(dev, va, size, direction);
+
+	return dma_mapping_error(dev, dma_mem->pa) ? false : true;
+}
+
+/**
+ * libie_cp_unmap_dma_mem - unmap previously mapped DMA address
+ * @dev: device information
+ * @dma_mem: DMA memory information
+ */
+static void libie_cp_unmap_dma_mem(struct device *dev,
+				   const struct libie_cp_dma_mem *dma_mem)
+{
+	dma_unmap_single(dev, dma_mem->pa, dma_mem->size,
+			 dma_mem->direction);
+}
+
+/**
+ * libie_ctlq_xn_process_send - process and send a control queue message
+ * @params: Xn send param information for sending a control queue message
+ * @xn: Assigned Xn entry for tracking the control queue message
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+static
+int libie_ctlq_xn_process_send(struct libie_ctlq_xn_send_params *params,
+			       struct libie_ctlq_xn *xn)
+{
+	size_t buf_len = params->send_buf.iov_len;
+	struct device *dev = params->ctlq->dev;
+	void *buf = params->send_buf.iov_base;
+	struct libie_cp_dma_mem *dma_mem;
+	u16 cookie;
+
+	if (!buf || !buf_len)
+		return -EOPNOTSUPP;
+
+	if (libie_cp_can_send_onstack(buf_len)) {
+		dma_mem = xn->dma_mem;
+		memcpy(dma_mem->va, buf, buf_len);
+	} else {
+		dma_mem = &xn->send_dma_mem;
+		dma_mem->va = buf;
+		dma_mem->size = buf_len;
+		dma_mem->direction = DMA_TO_DEVICE;
+
+		if (!libie_cp_map_dma_mem(dev, buf, buf_len, DMA_TO_DEVICE,
+					  dma_mem))
+			return -ENOMEM;
+	}
+
+	cookie = FIELD_PREP(LIBIE_CTLQ_XN_COOKIE_M, xn->cookie) |
+		 FIELD_PREP(LIBIE_CTLQ_XN_INDEX_M, xn->index);
+
+	scoped_guard(spinlock, &params->ctlq->lock) {
+		struct libie_ctlq_info *ctlq = params->ctlq;
+		struct libie_ctlq_msg *ctlq_msg;
+
+		if (!libie_ctlq_send_desc_avail(ctlq)) {
+			if (!libie_cp_can_send_onstack(buf_len))
+				libie_cp_unmap_dma_mem(dev, dma_mem);
+
+			return -EBUSY;
+		}
+
+		ctlq_msg = ctlq->tx_msg[ctlq->next_to_use];
+		if (params->ctlq_msg)
+			*ctlq_msg = *params->ctlq_msg;
+		else
+			/* Unused ctlq messages are already zeroed */
+			ctlq_msg->opcode = LIBIE_CTLQ_SEND_MSG_TO_CP;
+
+		ctlq_msg->sw_cookie = cookie;
+		ctlq_msg->send_mem = *dma_mem;
+		ctlq_msg->data_len = buf_len;
+		ctlq_msg->chnl_opcode = params->chnl_opcode;
+		libie_ctlq_send(params->ctlq, 1);
+	}
+
+	return 0;
+}
+
+/**
+ * libie_ctlq_xn_send - Function to send a control queue message
+ * @params: Xn send param information for sending a control queue message
+ *
+ * Send a control queue (mailbox or config) message.
+ * Based on the params value, the call can be completed synchronously or
+ * asynchronously.
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
+{
+	bool free_send = !libie_cp_can_send_onstack(params->send_buf.iov_len);
+	struct libie_ctlq_xn *xn;
+	int ret;
+
+	if (params->send_buf.iov_len > LIBIE_CTLQ_MAX_BUF_LEN) {
+		ret = -EINVAL;
+		goto free_buf;
+	}
+
+	xn = libie_ctlq_xn_pop_free(params->xnm);
+	/* no free transactions available */
+	if (unlikely(!xn)) {
+		ret = -EAGAIN;
+		goto free_buf;
+	}
+
+	spin_lock(&xn->xn_lock);
+	if (xn->state == LIBIE_CTLQ_XN_SHUTDOWN) {
+		ret = -ENXIO;
+		goto unlock_xn;
+	}
+
+	xn->state = params->resp_cb ? LIBIE_CTLQ_XN_ASYNC :
+				      LIBIE_CTLQ_XN_WAITING;
+	xn->ctlq = params->ctlq;
+	xn->virtchnl_opcode = params->chnl_opcode;
+
+	if (params->resp_cb) {
+		xn->send_ctx = params->send_ctx;
+		xn->resp_cb = params->resp_cb;
+		xn->timeout_ms = params->timeout_ms;
+		xn->timestamp = ktime_get();
+	}
+
+	ret = libie_ctlq_xn_process_send(params, xn);
+	if (ret)
+		goto release_xn;
+	else
+		free_send = false;
+
+	spin_unlock(&xn->xn_lock);
+
+	if (params->resp_cb)
+		return 0;
+
+	wait_for_completion_timeout(&xn->cmd_completion_event,
+				    msecs_to_jiffies(params->timeout_ms));
+
+	spin_lock(&xn->xn_lock);
+	switch (xn->state) {
+	case LIBIE_CTLQ_XN_WAITING:
+		ret = -ETIMEDOUT;
+		break;
+	case LIBIE_CTLQ_XN_COMPLETED_SUCCESS:
+		params->recv_mem = xn->recv_mem;
+		break;
+	default:
+		ret = -EBADMSG;
+		break;
+	}
+
+	/* Free the receive buffer in case of failure. On timeout, receive
+	 * buffer is not allocated.
+	 */
+	if (ret && ret != -ETIMEDOUT)
+		libie_ctlq_release_rx_buf(&xn->recv_mem);
+
+release_xn:
+	xn->state = LIBIE_CTLQ_XN_IDLE;
+	reinit_completion(&xn->cmd_completion_event);
+unlock_xn:
+	spin_unlock(&xn->xn_lock);
+	libie_ctlq_xn_push_free(params->xnm, xn);
+free_buf:
+	if (free_send)
+		params->rel_tx_buf(params->send_buf.iov_base);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_send, "LIBIE_CP");
+
+/**
+ * libie_ctlq_xn_send_clean - cleanup the send control queue message buffers
+ * @params: Xn clean param information for send complete handling
+ *
+ * Cleanup the send buffers for the given control queue, if force is set, then
+ * clear all the outstanding send messages irrespective their send status.
+ * Force should be used during deinit or reset.
+ *
+ * Return: number of send buffers cleaned.
+ */
+u32 libie_ctlq_xn_send_clean(const struct libie_ctlq_xn_clean_params *params)
+{
+	struct libie_ctlq_info *ctlq = params->ctlq;
+	struct device *dev = ctlq->dev;
+	u32 ntc, i;
+
+	spin_lock(&ctlq->lock);
+	ntc = ctlq->next_to_clean;
+
+	for (i = 0; i < params->num_msgs; i++) {
+		struct libie_ctlq_msg *msg = ctlq->tx_msg[ntc];
+		struct libie_ctlq_desc *desc;
+		u64 qword;
+
+		desc = &ctlq->descs[ntc];
+		qword = le64_to_cpu(desc->qword0);
+
+		if (!FIELD_GET(LIBIE_CTLQ_DESC_FLAG_DD, qword) &&
+		    !(unlikely(params->force) && msg->data_len))
+			break;
+
+		desc->qword0 = 0;
+
+		dma_mb();
+
+		if (!libie_cp_can_send_onstack(msg->data_len)) {
+			libie_cp_unmap_dma_mem(dev, &msg->send_mem);
+			params->rel_tx_buf(msg->send_mem.va);
+		}
+
+		memset(msg, 0, sizeof(*msg));
+
+		if (unlikely(++ntc == ctlq->ring_len))
+			ntc = 0;
+	}
+
+	ctlq->next_to_clean = ntc;
+	spin_unlock(&ctlq->lock);
+
+	return i;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_send_clean, "LIBIE_CP");
+
+/**
+ * libie_ctlq_xn_shutdown - terminate control queue transactions
+ * @xnm: pointer to the transaction manager
+ *
+ * Synchronously terminate existing transactions and stop accepting new ones.
+ */
+void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm)
+{
+	bool must_wait = false;
+	u32 i;
+
+	/* Should be no new clear bits after this */
+	spin_lock(&xnm->free_xns_bm_lock);
+	xnm->shutdown = true;
+
+	for_each_clear_bit(i, xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES) {
+		struct libie_ctlq_xn *xn = &xnm->ring[i];
+
+		spin_lock(&xn->xn_lock);
+
+		switch (xn->state) {
+		/* if an idle xn is not free, it is about to be either
+		 * freed or initialized, prevent the latter and wait
+		 */
+		case LIBIE_CTLQ_XN_IDLE:
+			xn->state = LIBIE_CTLQ_XN_SHUTDOWN;
+			fallthrough;
+		/* waiting thread possibly needs a push to return the xn,
+		 * transaction will be reported as timed out
+		 */
+		case LIBIE_CTLQ_XN_WAITING:
+			complete(&xn->cmd_completion_event);
+			fallthrough;
+		/* these states will return the xn soon */
+		case LIBIE_CTLQ_XN_COMPLETED_SUCCESS:
+		case LIBIE_CTLQ_XN_COMPLETED_FAILED:
+		case LIBIE_CTLQ_XN_SHUTDOWN:
+			must_wait = true;
+			break;
+		/* no thread should reference async xns at this point */
+		case LIBIE_CTLQ_XN_ASYNC:
+			xn->state = LIBIE_CTLQ_XN_IDLE;
+			__libie_ctlq_xn_push_free(xnm, xn);
+			break;
+		}
+
+		spin_unlock(&xn->xn_lock);
+	}
+
+	spin_unlock(&xnm->free_xns_bm_lock);
+
+	if (must_wait)
+		wait_for_completion(&xnm->can_destroy);
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_shutdown, "LIBIE_CP");
+
+/**
+ * libie_ctlq_xn_deinit - deallocate and free the transaction manager resources
+ * @xnm: pointer to the transaction manager
+ * @ctx: controlq context structure
+ *
+ * All Rx processing must be stopped beforehand.
+ */
+void libie_ctlq_xn_deinit(struct libie_ctlq_xn_manager *xnm,
+			  struct libie_ctlq_ctx *ctx)
+{
+	libie_ctlq_xn_shutdown(xnm);
+	libie_ctlq_xn_deinit_dma(&ctx->mmio_info.pdev->dev, xnm,
+				 LIBIE_CTLQ_MAX_XN_ENTRIES);
+	kfree(xnm);
+	libie_ctlq_deinit(ctx);
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_deinit, "LIBIE_CP");
+
+/**
+ * libie_ctlq_xn_init - initialize the Xn transaction manager
+ * @params: Xn init param information for allocating Xn manager resources
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+int libie_ctlq_xn_init(struct libie_ctlq_xn_init_params *params)
+{
+	struct libie_ctlq_xn_manager *xnm;
+	int ret;
+
+	ret = libie_ctlq_init(params->ctx, params->cctlq_info, params->num_qs);
+	if (ret)
+		return ret;
+
+	xnm = kzalloc_obj(*xnm);
+	if (!xnm)
+		goto ctlq_deinit;
+
+	ret = libie_ctlq_xn_init_dma(&params->ctx->mmio_info.pdev->dev, xnm);
+	if (ret)
+		goto free_xnm;
+
+	spin_lock_init(&xnm->free_xns_bm_lock);
+	init_completion(&xnm->can_destroy);
+	bitmap_fill(xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES);
+
+	for (u32 i = 0; i < LIBIE_CTLQ_MAX_XN_ENTRIES; i++) {
+		struct libie_ctlq_xn *xn = &xnm->ring[i];
+
+		xn->index = i;
+		init_completion(&xn->cmd_completion_event);
+		spin_lock_init(&xn->xn_lock);
+	}
+	xnm->ctx = params->ctx;
+	params->xnm = xnm;
+
+	return 0;
+
+free_xnm:
+	kfree(xnm);
+ctlq_deinit:
+	libie_ctlq_deinit(params->ctx);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_init, "LIBIE_CP");
+
 MODULE_DESCRIPTION("Control Plane communication API");
 MODULE_IMPORT_NS("LIBETH");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/net/intel/libie/controlq.h b/include/linux/net/intel/libie/controlq.h
index a176a0d2ba33..5c574c8b8a79 100644
--- a/include/linux/net/intel/libie/controlq.h
+++ b/include/linux/net/intel/libie/controlq.h
@@ -20,6 +20,8 @@
 #define LIBIE_CTLQ_SEND_MSG_TO_CP		0x801
 #define LIBIE_CTLQ_SEND_MSG_TO_PEER		0x804
 
+#define LIBIE_CP_TX_COPYBREAK		128
+
 /**
  * struct libie_ctlq_ctx - contains controlq info and MMIO region info
  * @mmio_info: MMIO region info structure
@@ -60,11 +62,13 @@ struct libie_ctlq_reg {
  * @va: virtual address
  * @pa: physical address
  * @size: memory size
+ * @direction: memory to device or device to memory
  */
 struct libie_cp_dma_mem {
 	void		*va;
 	dma_addr_t	pa;
 	size_t		size;
+	int		direction;
 };
 
 /**
@@ -246,4 +250,175 @@ u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
 
 int libie_ctlq_post_rx_buffs(struct libie_ctlq_info *ctlq);
 
+/* Only 8 bits are available in descriptor for Xn index */
+#define LIBIE_CTLQ_MAX_XN_ENTRIES		256
+#define LIBIE_CTLQ_XN_COOKIE_M			GENMASK(15, 8)
+#define LIBIE_CTLQ_XN_INDEX_M			GENMASK(7, 0)
+
+/**
+ * enum libie_ctlq_xn_state - Transaction state of a virtchnl message
+ * @LIBIE_CTLQ_XN_IDLE: transaction is available to use
+ * @LIBIE_CTLQ_XN_WAITING: waiting for transaction to complete
+ * @LIBIE_CTLQ_XN_COMPLETED_SUCCESS: transaction completed with success
+ * @LIBIE_CTLQ_XN_COMPLETED_FAILED: transaction completed with failure
+ * @LIBIE_CTLQ_XN_ASYNC: asynchronous virtchnl message transaction type
+ * @LIBIE_CTLQ_XN_SHUTDOWN: transaction cannot be used anymore
+ */
+enum libie_ctlq_xn_state {
+	LIBIE_CTLQ_XN_IDLE = 0,
+	LIBIE_CTLQ_XN_WAITING,
+	LIBIE_CTLQ_XN_COMPLETED_SUCCESS,
+	LIBIE_CTLQ_XN_COMPLETED_FAILED,
+	LIBIE_CTLQ_XN_ASYNC,
+	LIBIE_CTLQ_XN_SHUTDOWN,
+};
+
+/**
+ * struct libie_ctlq_xn - structure representing a virtchnl transaction entry
+ * @resp_cb: callback to handle the response of an asynchronous virtchnl message
+ * @xn_lock: lock to protect the transaction entry state
+ * @ctlq: send control queue information
+ * @cmd_completion_event: signal when a reply is available
+ * @dma_mem: DMA memory of send buffer that use stack variable
+ * @send_dma_mem: DMA memory of send buffer
+ * @recv_mem: receive buffer
+ * @send_ctx: context for callback function
+ * @timeout_ms: Xn transaction timeout in msecs
+ * @timestamp: timestamp to record the Xn send
+ * @virtchnl_opcode: virtchnl command opcode used for Xn transaction
+ * @state: transaction state of a virtchnl message
+ * @cookie: unique message identifier
+ * @index: index of the transaction entry
+ */
+struct libie_ctlq_xn {
+	void (*resp_cb)(void *ctx, struct kvec *mem, int status);
+	spinlock_t			xn_lock;	/* protects state */
+	struct libie_ctlq_info		*ctlq;
+	struct completion		cmd_completion_event;
+	struct libie_cp_dma_mem	*dma_mem;
+	struct libie_cp_dma_mem	send_dma_mem;
+	struct kvec			recv_mem;
+	void				*send_ctx;
+	u64				timeout_ms;
+	ktime_t				timestamp;
+	u32				virtchnl_opcode;
+	enum libie_ctlq_xn_state	state;
+	u8				cookie;
+	u8				index;
+};
+
+/**
+ * struct libie_ctlq_xn_manager - structure representing the array of virtchnl
+ *				   transaction entries
+ * @ctx: pointer to controlq context structure
+ * @free_xns_bm_lock: lock to protect the free Xn entries bit map
+ * @free_xns_bm: bitmap that represents the free Xn entries
+ * @ring: array of Xn entries
+ * @can_destroy: completion triggered by the last returned transaction
+ * @shutdown: shows the transactions the xnm shutdown is waiting for them
+ * @cookie: unique message identifier
+ */
+struct libie_ctlq_xn_manager {
+	struct libie_ctlq_ctx	*ctx;
+	spinlock_t		free_xns_bm_lock;	/* get/check entries */
+	DECLARE_BITMAP(free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES);
+	struct libie_ctlq_xn	ring[LIBIE_CTLQ_MAX_XN_ENTRIES];
+	struct completion	can_destroy;
+	bool			shutdown;
+	u8			cookie;
+};
+
+/**
+ * struct libie_ctlq_xn_send_params - structure representing send Xn entry
+ * @resp_cb: callback to handle the response of an asynchronous virtchnl message
+ * @rel_tx_buf: driver entry point for freeing the send buffer after send
+ * @xnm: Xn manager to process Xn entries
+ * @ctlq: send control queue information
+ * @ctlq_msg: control queue message information
+ * @send_buf: represents the buffer that carries outgoing information
+ * @recv_mem: receive buffer
+ * @send_ctx: context for call back function
+ * @timeout_ms: virtchnl transaction timeout in msecs
+ * @chnl_opcode: virtchnl message opcode
+ */
+struct libie_ctlq_xn_send_params {
+	void (*resp_cb)(void *ctx, struct kvec *mem, int status);
+	void (*rel_tx_buf)(const void *buf_va);
+	struct libie_ctlq_xn_manager		*xnm;
+	struct libie_ctlq_info			*ctlq;
+	struct libie_ctlq_msg			*ctlq_msg;
+	struct kvec				send_buf;
+	struct kvec				recv_mem;
+	void					*send_ctx;
+	u64					timeout_ms;
+	u32					chnl_opcode;
+};
+
+/**
+ * libie_cp_can_send_onstack - can a message be sent using a stack variable
+ * @size: ctlq data buffer size
+ *
+ * Return: %true if the message size is small enough for caller to pass
+ *	   an on-stack buffer, %false if kmalloc is needed
+ */
+static inline bool libie_cp_can_send_onstack(u32 size)
+{
+	return size <= LIBIE_CP_TX_COPYBREAK;
+}
+
+/**
+ * struct libie_ctlq_xn_recv_params - structure representing receive Xn entry
+ * @ctlq_msg_handler: callback to handle a message originated from the peer
+ * @xnm: Xn manager to process Xn entries
+ * @ctlq: control queue information
+ * @budget: maximum number of messages to process
+ */
+struct libie_ctlq_xn_recv_params {
+	void (*ctlq_msg_handler)(struct libie_ctlq_ctx *ctx,
+				 struct libie_ctlq_msg *msg);
+	struct libie_ctlq_xn_manager		*xnm;
+	struct libie_ctlq_info			*ctlq;
+	u32					budget;
+};
+
+/**
+ * struct libie_ctlq_xn_clean_params - Data structure used for cleaning the
+ * control queue messages
+ * @rel_tx_buf: driver entry point for freeing the send buffer after send
+ * @ctlq: control queue information
+ * @send_ctx: context for call back function
+ * @num_msgs: number of messages to be cleaned
+ * @force: clean even if DD is not yet set
+ */
+struct libie_ctlq_xn_clean_params {
+	void (*rel_tx_buf)(const void *buf_va);
+	struct libie_ctlq_info			*ctlq;
+	void					*send_ctx;
+	u16					num_msgs;
+	bool					force;
+};
+
+/**
+ * struct libie_ctlq_xn_init_params - Data structure used for initializing the
+ * Xn transaction manager
+ * @cctlq_info: control queue information
+ * @ctx: pointer to controlq context structure
+ * @xnm: Xn manager to process Xn entries
+ * @num_qs: number of control queues needs to initialized
+ */
+struct libie_ctlq_xn_init_params {
+	struct libie_ctlq_create_info		*cctlq_info;
+	struct libie_ctlq_ctx			*ctx;
+	struct libie_ctlq_xn_manager		*xnm;
+	u32					num_qs;
+};
+
+int libie_ctlq_xn_init(struct libie_ctlq_xn_init_params *params);
+void libie_ctlq_xn_deinit(struct libie_ctlq_xn_manager *xnm,
+			  struct libie_ctlq_ctx *ctx);
+void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm);
+int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params);
+u32 libie_ctlq_xn_recv(struct libie_ctlq_xn_recv_params *params);
+u32 libie_ctlq_xn_send_clean(const struct libie_ctlq_xn_clean_params *params);
+
 #endif /* __LIBIE_CONTROLQ_H */
-- 
2.47.1


