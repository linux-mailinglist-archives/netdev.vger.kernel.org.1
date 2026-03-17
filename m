Return-Path: <netdev+bounces-268799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBUBEvjguWlhPAIAu9opvQ
	(envelope-from <netdev+bounces-268799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:17:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E383A2B418D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9457A3086427
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51B3FB059;
	Tue, 17 Mar 2026 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9f5rLyg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50983389E18;
	Tue, 17 Mar 2026 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788967; cv=none; b=d0L1aGtJspXezj7o6VLZVUGUdpr1NNKcEJ7KUoiSvzVrUJ93X0bhnRud6fl7XCXonU2dLugBxwcmmNW8/8IMj25gYEGwTxjzKay86O1+JwVI0O9bOh3Hw3H7MBK5Dp4TDZECNH2VQQ4iNn/hXIi1J+RxDkbufO7eofoMNjbl5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788967; c=relaxed/simple;
	bh=T99AvXnoW34Wk5Jv4j6PusmLEPYF0756/Z+7I6NwkpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8b6oQxfDdXypsEnXmdlv4oDe2Tw4S2wZg98jXDeCp8dPT49bvDs8WpXLyEIONZBY/7ztr9vLkI11vALf1q/9kVvll41kCFy+e2IsWGLcbhOPw5kTMSV5IDH1Nj61lxMgI9yUS4LAndJvL6/C5qo7zwnHMYesjgtfM1iZA/N01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9f5rLyg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773788966; x=1805324966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T99AvXnoW34Wk5Jv4j6PusmLEPYF0756/Z+7I6NwkpQ=;
  b=d9f5rLygy8CvFNRn+eyZEmc7dKsABUhxIUlzU4bKp0cclNV9VElA3qwB
   m29dLlxXG0byXmWmeMygwR7DvwUH9RxCG4+dh1Bz/ZiCfG49E5mLHfbqG
   krpM16o/DkcXe1764utIkRGX6yUe1rlFxvzXCMRAxqExVQRblRflIfAQj
   4X5VVtcNEfqRq63zMdQeYRNmaFGYMB9y4rmU7zhelkloU+8IEjq2SGj0E
   HuycB4Q7egyg5tUNJf4CcslecQcM6VMH/hDmaigjDFNj1XI3mOYCziwNa
   D3m9PaTC4fW9XyCrDa8n3CHMiT/fcUEscuB4WjkY2DzXeQDtMeAJ+I1+9
   Q==;
X-CSE-ConnectionGUID: pNuCnfhaQzuTQqihyy5+Ug==
X-CSE-MsgGUID: GBKono2BTj+Uekr5aG7H1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74811619"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74811619"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 16:09:22 -0700
X-CSE-ConnectionGUID: uY0x8oiHTFKaxZcZ/wsQ7g==
X-CSE-MsgGUID: JLm+Ht4gSAmKwcddjoHj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226566389"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2026 16:09:21 -0700
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
	natalia.wochtman@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 06/15] libie: add bookkeeping support for control queue messages
Date: Tue, 17 Mar 2026 16:08:54 -0700
Message-ID: <20260317230905.847744-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260317230905.847744-1-anthony.l.nguyen@intel.com>
References: <20260317230905.847744-1-anthony.l.nguyen@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268799-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E383A2B418D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/controlq.c | 591 ++++++++++++++++++++
 include/linux/intel/libie/controlq.h        | 174 ++++++
 2 files changed, 765 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index c7ed9e59dfee..8337bbbde972 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -601,6 +601,597 @@ u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
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
+ */
+static void __libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
+				      struct libie_ctlq_xn *xn)
+{
+	__set_bit(xn->index, xnm->free_xns_bm);
+
+	if (likely(!xnm->shutdown))
+		return;
+
+	if (bitmap_full(xnm->free_xns_bm, LIBIE_CTLQ_MAX_XN_ENTRIES))
+		complete(&xnm->can_destroy);
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
+	guard(spinlock)(&xnm->free_xns_bm_lock);
+
+	__libie_ctlq_xn_push_free(xnm, xn);
+}
+
+/**
+ * libie_ctlq_xn_put - put an Xn that will not be used in the current thread
+ * @xnm: Xn transaction manager
+ * @xn: async xn entry to be put for now, not locked
+ *
+ * If the Xn manager is being shutdown, nothing will handle the related
+ * async request.
+ */
+static void libie_ctlq_xn_put(struct libie_ctlq_xn_manager *xnm,
+			      struct libie_ctlq_xn *xn)
+{
+	guard(spinlock)(&xnm->free_xns_bm_lock);
+
+	if (unlikely(xnm->shutdown))
+		__libie_ctlq_xn_push_free(xnm, xn);
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
+	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
+	    msg_cookie != xn->cookie)
+		return false;
+
+	spin_lock(&xn->xn_lock);
+	if (xn->state != LIBIE_CTLQ_XN_ASYNC &&
+	    xn->state != LIBIE_CTLQ_XN_WAITING) {
+		spin_unlock(&xn->xn_lock);
+		return false;
+	}
+
+	response = &ctlq_msg->recv_mem;
+	if (xn->state == LIBIE_CTLQ_XN_ASYNC) {
+		xn->resp_cb(xn->send_ctx, response, status);
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
+	int ret;
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
+		if (!params->ctlq_msg || params->resp_cb) {
+			struct libie_ctlq_info *ctlq = params->ctlq;
+
+			*ctlq->tx_msg[ctlq->next_to_use] =
+				params->ctlq_msg ? *params->ctlq_msg :
+				(struct libie_ctlq_msg) {
+					.opcode = LIBIE_CTLQ_SEND_MSG_TO_CP
+				};
+			params->ctlq_msg = ctlq->tx_msg[ctlq->next_to_use];
+		}
+
+		params->ctlq_msg->sw_cookie = cookie;
+		params->ctlq_msg->send_mem = *dma_mem;
+		params->ctlq_msg->data_len = buf_len;
+		params->ctlq_msg->chnl_opcode = params->chnl_opcode;
+		ret = libie_ctlq_send(params->ctlq, params->ctlq_msg, 1);
+	}
+
+	if (ret && !libie_cp_can_send_onstack(buf_len))
+		libie_cp_unmap_dma_mem(dev, dma_mem);
+
+	return ret;
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
+	if (params->resp_cb) {
+		libie_ctlq_xn_put(params->xnm, xn);
+		return 0;
+	}
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
+		    !params->force)
+			break;
+
+		dma_rmb();
+
+		if (!libie_cp_can_send_onstack(msg->data_len)) {
+			libie_cp_unmap_dma_mem(dev, &msg->send_mem);
+			params->rel_tx_buf(msg->send_mem.va);
+		}
+
+		memset(msg, 0, sizeof(*msg));
+		desc->qword0 = 0;
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
+		if (xn->state == LIBIE_CTLQ_XN_WAITING ||
+		    xn->state == LIBIE_CTLQ_XN_IDLE) {
+			complete(&xn->cmd_completion_event);
+			must_wait = true;
+		} else if (xn->state == LIBIE_CTLQ_XN_ASYNC) {
+			__libie_ctlq_xn_push_free(xnm, xn);
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
diff --git a/include/linux/intel/libie/controlq.h b/include/linux/intel/libie/controlq.h
index a7e92744c814..6566bb60126d 100644
--- a/include/linux/intel/libie/controlq.h
+++ b/include/linux/intel/libie/controlq.h
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
@@ -246,4 +250,174 @@ u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
 
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
+ */
+enum libie_ctlq_xn_state {
+	LIBIE_CTLQ_XN_IDLE = 0,
+	LIBIE_CTLQ_XN_WAITING,
+	LIBIE_CTLQ_XN_COMPLETED_SUCCESS,
+	LIBIE_CTLQ_XN_COMPLETED_FAILED,
+	LIBIE_CTLQ_XN_ASYNC,
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
+ * @ctx: pointer to context structure
+ * @ctlq: control queue information
+ * @send_ctx: context for call back function
+ * @num_msgs: number of messages to be cleaned
+ */
+struct libie_ctlq_xn_clean_params {
+	void (*rel_tx_buf)(const void *buf_va);
+	struct libie_ctlq_ctx			*ctx;
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


