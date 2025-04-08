Return-Path: <netdev+bounces-180221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C74A80A6B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB65B500B9A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9EE27BF9B;
	Tue,  8 Apr 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beHoPgWi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574826B2D2;
	Tue,  8 Apr 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116525; cv=none; b=nhfQMTXT4qwhQrv7WQH/uVxLTqqTBtfpaxbT/MwNv7Wcmkq9kwnvf6+4741e68PJ50tsF+aMGPl+BVNGQ+8zdam/i1syyd6ZoMQVo90bTJ8zc9LHZ1g/aN28xPyzxkczx7uZXprBYuCirOgBt8SZEgfbcpf6lDuZoJWPYgOmebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116525; c=relaxed/simple;
	bh=OaYTOBc5LLXRyxkecxJrCY6ul2AkpqpojL/CEq2Llgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmBmPeUpcv6wC+HBCt9wG71BAtK3cYm2e0DpRp+7d7/sfqZDP0tAVt3Z9jIVgIVazbrncW+UgPEJZ2l8fq2XFDwGp2/1wCZIMLU3T6jIGEJTkqwGUe+FAWzLBVNsc28txr1vLRujWmw+GQ745diRpF69MHPSW/uOsp63stiSAdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beHoPgWi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744116523; x=1775652523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OaYTOBc5LLXRyxkecxJrCY6ul2AkpqpojL/CEq2Llgg=;
  b=beHoPgWicV81WiJCJUAJ2D3aqYhwsO1SsJ77ym/YQNj/F9KUxP9gZcg8
   vv8wmwDsnnoB5eDLZFy+/IJ42ROIbfhbs5+ULR100ywxo83+QlNzP5TN0
   VpwZnS1Xd/X6ickZ9CbkRU7rdtjGEZaku9tiR8wLcYJfPrfBqCM+Xs571
   khJagZ3AlXTlNGHxADlpOymcghBxyluNEz9pHxpSa0B1VA5B+OYuTof55
   kh4r3kg2YW5dFu6wvw14TKmNUJj+EitpLhKd3cGqhGigb97TYvvLvrNw7
   Sb5rkjXtqnqom4vaPZLF6OsUbu2wK90Uqz2g9SOx4IF6SFmglkjM0pvXH
   g==;
X-CSE-ConnectionGUID: E5OWg/6QQcKb30GWaCPoaw==
X-CSE-MsgGUID: OY3DQMnkT52FqbOgvi2yBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56184892"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="56184892"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 05:48:42 -0700
X-CSE-ConnectionGUID: x33dqxdaT1KCynLPHhtNyg==
X-CSE-MsgGUID: j95g/k6XQIa62SeL0HnJHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133130688"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Apr 2025 05:48:34 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 054CA34315;
	Tue,  8 Apr 2025 13:48:30 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wenjun Wu <wenjun1.wu@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Phani R Burra <phani.r.burra@intel.com>
Subject: [PATCH iwl-next 06/14] libeth: add bookkeeping support for control queue messages
Date: Tue,  8 Apr 2025 14:47:52 +0200
Message-ID: <20250408124816.11584-7-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250408124816.11584-1-larysa.zaremba@intel.com>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phani R Burra <phani.r.burra@intel.com>

All send control queue messages are allocated/freed in libeth itself
and tracked with the unique transaction (Xn) ids until they receive
response or time out. Responses can be received out of order, therefore
transactions are stored in an array and tracked though a bitmap.

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
---
 drivers/net/ethernet/intel/libeth/controlq.c | 578 +++++++++++++++++++
 include/net/libeth/controlq.h                | 169 ++++++
 2 files changed, 747 insertions(+)

diff --git a/drivers/net/ethernet/intel/libeth/controlq.c b/drivers/net/ethernet/intel/libeth/controlq.c
index 2ce419591495..f01666701039 100644
--- a/drivers/net/ethernet/intel/libeth/controlq.c
+++ b/drivers/net/ethernet/intel/libeth/controlq.c
@@ -603,6 +603,584 @@ u32 libeth_ctlq_recv(struct libeth_ctlq_info *ctlq, struct libeth_ctlq_msg *msg,
 }
 EXPORT_SYMBOL_NS_GPL(libeth_ctlq_recv, "LIBETH_CP");
 
+/**
+ * libeth_ctlq_xn_pop_free - get a free Xn entry from the free list
+ * @xnm: Xn transaction manager
+ *
+ * Retrieve a free Xn entry from the free list.
+ *
+ * Return: valid Xn entry pointer or NULL if there are no free Xn entries.
+ */
+static struct libeth_ctlq_xn *
+libeth_ctlq_xn_pop_free(struct libeth_ctlq_xn_manager *xnm)
+{
+	struct libeth_ctlq_xn *xn;
+	u32 free_idx;
+
+	guard(spinlock)(&xnm->free_xns_bm_lock);
+
+	if (unlikely(xnm->shutdown))
+		return NULL;
+
+	free_idx = find_next_bit(xnm->free_xns_bm, LIBETH_CTLQ_MAX_XN_ENTRIES,
+				 0);
+	if (free_idx == LIBETH_CTLQ_MAX_XN_ENTRIES)
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
+ * __libeth_ctlq_xn_push_free - unsafely push a Xn entry into the free list
+ * @xnm: Xn transaction manager
+ * @xn: xn entry to be added into the free list
+ */
+static void __libeth_ctlq_xn_push_free(struct libeth_ctlq_xn_manager *xnm,
+				       struct libeth_ctlq_xn *xn)
+{
+	__set_bit(xn->index, xnm->free_xns_bm);
+
+	if (likely(!xnm->shutdown))
+		return;
+
+	if (bitmap_full(xnm->free_xns_bm, LIBETH_CTLQ_MAX_XN_ENTRIES))
+		complete(&xnm->can_destroy);
+}
+
+/**
+ * libeth_ctlq_xn_push_free - push a Xn entry into the free list
+ * @xnm: Xn transaction manager
+ * @xn: xn entry to be added into the free list, not locked
+ *
+ * Safely add a used Xn entry back to the free list.
+ */
+static void libeth_ctlq_xn_push_free(struct libeth_ctlq_xn_manager *xnm,
+				     struct libeth_ctlq_xn *xn)
+{
+	guard(spinlock)(&xnm->free_xns_bm_lock);
+
+	__libeth_ctlq_xn_push_free(xnm, xn);
+}
+
+/**
+ * libeth_ctlq_xn_put - put an Xn that will not be used in the current thread
+ * @xnm: Xn transaction manager
+ * @xn: async xn entry to be put for now, not locked
+ *
+ * If the Xn manager is being shutdown, nothing will handle the related
+ * async request.
+ */
+static void libeth_ctlq_xn_put(struct libeth_ctlq_xn_manager *xnm,
+			       struct libeth_ctlq_xn *xn)
+{
+	guard(spinlock)(&xnm->free_xns_bm_lock);
+
+	if (unlikely(xnm->shutdown))
+		__libeth_ctlq_xn_push_free(xnm, xn);
+}
+
+/**
+ * libeth_ctlq_xn_deinit_dma - free the DMA memory allocated for send messages
+ * @dev: device pointer
+ * @xnm: pointer to the transaction manager
+ * @num_entries: number of Xn entries to free the DMA for
+ */
+static void libeth_ctlq_xn_deinit_dma(struct device *dev,
+				      struct libeth_ctlq_xn_manager *xnm,
+				      u32 num_entries)
+{
+	for (u32 i = 0; i < num_entries; i++) {
+		struct libeth_ctlq_xn *xn = &xnm->ring[i];
+
+		libeth_cp_free_dma_mem(dev, xn->dma_mem);
+		kfree(xn->dma_mem);
+	}
+}
+
+/**
+ * libeth_ctlq_xn_init_dma - pre-allocate DMA memory for send messages that use
+ * stack variables
+ * @dev: device pointer
+ * @xnm: pointer to transaction manager
+ *
+ * Return: %0 on success or error if memory allocation fails
+ */
+static int libeth_ctlq_xn_init_dma(struct device *dev,
+				   struct libeth_ctlq_xn_manager *xnm)
+{
+	u32 i;
+
+	for (i = 0; i < LIBETH_CTLQ_MAX_XN_ENTRIES; i++) {
+		struct libeth_ctlq_xn *xn = &xnm->ring[i];
+		struct libeth_cp_dma_mem *dma_mem;
+
+		dma_mem = kzalloc(sizeof(*dma_mem), GFP_KERNEL);
+		if (!dma_mem)
+			goto dealloc_dma;
+
+		dma_mem->va = libeth_cp_alloc_dma_mem(dev, dma_mem,
+						      LIBETH_CTLQ_MAX_BUF_LEN);
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
+	libeth_ctlq_xn_deinit_dma(dev, xnm, i);
+
+	return -ENOMEM;
+}
+
+/**
+ * libeth_ctlq_xn_process_recv - process Xn data in receive message
+ * @params: Xn receive param information to handle a receive message
+ * @ctlq_msg: received control queue message
+ *
+ * Process a control queue receive message and send a complete event
+ * notification.
+ *
+ * Return: true if a message has been processed, false otherwise.
+ */
+static bool
+libeth_ctlq_xn_process_recv(struct libeth_ctlq_xn_recv_params *params,
+			    struct libeth_ctlq_msg *ctlq_msg)
+{
+	struct libeth_ctlq_xn_manager *xnm = params->xnm;
+	struct libeth_ctlq_xn *xn;
+	u16 msg_cookie, xn_index;
+	struct kvec *response;
+	int status;
+	u16 data;
+
+	data = ctlq_msg->sw_cookie;
+	xn_index = FIELD_GET(LIBETH_CTLQ_XN_INDEX_M, data);
+	msg_cookie = FIELD_GET(LIBETH_CTLQ_XN_COOKIE_M, data);
+	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
+
+	xn = &xnm->ring[xn_index];
+	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
+	    msg_cookie != xn->cookie)
+		return false;
+
+	spin_lock(&xn->xn_lock);
+	if (xn->state != LIBETH_CTLQ_XN_ASYNC &&
+	    xn->state != LIBETH_CTLQ_XN_WAITING) {
+		spin_unlock(&xn->xn_lock);
+		return false;
+	}
+
+	response = &ctlq_msg->recv_mem;
+	if (xn->state == LIBETH_CTLQ_XN_ASYNC) {
+		xn->resp_cb(xn->send_ctx, response, status);
+		xn->state = LIBETH_CTLQ_XN_IDLE;
+		spin_unlock(&xn->xn_lock);
+		libeth_ctlq_xn_push_free(xnm, xn);
+
+		return true;
+	}
+
+	xn->recv_mem = *response;
+	xn->state = status ? LIBETH_CTLQ_XN_COMPLETED_FAILED :
+			     LIBETH_CTLQ_XN_COMPLETED_SUCCESS;
+
+	complete(&xn->cmd_completion_event);
+	spin_unlock(&xn->xn_lock);
+
+	return true;
+}
+
+/**
+ * libeth_xn_check_async_timeout - Check for asynchronous message timeouts
+ * @xnm: Xn transaction manager
+ *
+ * Call the corresponding callback to notify the caller about the timeout.
+ */
+static void libeth_xn_check_async_timeout(struct libeth_ctlq_xn_manager *xnm)
+{
+	u32 idx;
+
+	for_each_clear_bit(idx, xnm->free_xns_bm, LIBETH_CTLQ_MAX_XN_ENTRIES) {
+		struct libeth_ctlq_xn *xn = &xnm->ring[idx];
+		u64 timeout_ms;
+
+		spin_lock(&xn->xn_lock);
+
+		timeout_ms = ktime_ms_delta(ktime_get(), xn->timestamp);
+		if (xn->state != LIBETH_CTLQ_XN_ASYNC ||
+		    timeout_ms < xn->timeout_ms) {
+			spin_unlock(&xn->xn_lock);
+			continue;
+		}
+
+		xn->resp_cb(xn->send_ctx, NULL, -ETIMEDOUT);
+		xn->state = LIBETH_CTLQ_XN_IDLE;
+		spin_unlock(&xn->xn_lock);
+		libeth_ctlq_xn_push_free(xnm, xn);
+	}
+}
+
+/**
+ * libeth_ctlq_xn_recv - process control queue receive message
+ * @params: Xn receive param information to handle a receive message
+ *
+ * Process a receive message and update the receive queue buffer.
+ *
+ * Return: true if a message has been processed, false otherwise.
+ */
+bool libeth_ctlq_xn_recv(struct libeth_ctlq_xn_recv_params *params)
+{
+	struct libeth_ctlq_msg ctlq_msg;
+	u32 num_msgs;
+
+	num_msgs = libeth_ctlq_recv(params->ctlq, &ctlq_msg, 1);
+
+	if (num_msgs && !libeth_ctlq_xn_process_recv(params, &ctlq_msg))
+		params->ctlq_msg_handler(params->xnm->ctx, &ctlq_msg);
+
+	libeth_ctlq_post_rx_buffs(params->ctlq);
+	libeth_xn_check_async_timeout(params->xnm);
+
+	return !!num_msgs;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_ctlq_xn_recv, "LIBETH_CP");
+
+/**
+ * libeth_cp_map_dma_mem - map a given virtual address for DMA
+ * @dev: device information
+ * @va: virtual address to be mapped
+ * @size: size of the memory
+ * @direction: DMA direction either from/to device
+ * @dma_mem: memory for DMA information to be stored
+ *
+ * Return: true on success, false on DMA map failure.
+ */
+static bool libeth_cp_map_dma_mem(struct device *dev, void *va, size_t size,
+				  int direction,
+				  struct libeth_cp_dma_mem *dma_mem)
+{
+	dma_mem->pa = dma_map_single(dev, va, size, direction);
+
+	return dma_mapping_error(dev, dma_mem->pa) ? false : true;
+}
+
+/**
+ * libeth_cp_unmap_dma_mem - unmap previously mapped DMA address
+ * @dev: device information
+ * @dma_mem: DMA memory information
+ */
+static void libeth_cp_unmap_dma_mem(struct device *dev,
+				    const struct libeth_cp_dma_mem *dma_mem)
+{
+	dma_unmap_single(dev, dma_mem->pa, dma_mem->size,
+			 dma_mem->direction);
+}
+
+/**
+ * libeth_ctlq_xn_process_send - process and send a control queue message
+ * @params: Xn send param information for sending a control queue message
+ * @xn: Assigned Xn entry for tracking the control queue message
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+static
+int libeth_ctlq_xn_process_send(struct libeth_ctlq_xn_send_params *params,
+				struct libeth_ctlq_xn *xn)
+{
+	size_t buf_len = params->send_buf.iov_len;
+	struct device *dev = params->ctlq->dev;
+	void *buf = params->send_buf.iov_base;
+	struct libeth_cp_dma_mem *dma_mem;
+	u16 cookie;
+	int ret;
+
+	if (!buf || !buf_len)
+		return -EOPNOTSUPP;
+
+	if (libeth_cp_can_send_onstack(buf_len)) {
+		dma_mem = xn->dma_mem;
+		memcpy(dma_mem->va, buf, buf_len);
+	} else {
+		dma_mem = &xn->send_dma_mem;
+		dma_mem->va = buf;
+		dma_mem->size = buf_len;
+		dma_mem->direction = DMA_TO_DEVICE;
+
+		if (!libeth_cp_map_dma_mem(dev, buf, buf_len, DMA_TO_DEVICE,
+					   dma_mem))
+			return -ENOMEM;
+	}
+
+	cookie = FIELD_PREP(LIBETH_CTLQ_XN_COOKIE_M, xn->cookie) |
+		 FIELD_PREP(LIBETH_CTLQ_XN_INDEX_M, xn->index);
+
+	scoped_guard(spinlock, &params->ctlq->lock) {
+		if (!params->ctlq_msg || params->resp_cb) {
+			struct libeth_ctlq_info *ctlq = params->ctlq;
+
+			*ctlq->tx_msg[ctlq->next_to_use] =
+				params->ctlq_msg ? *params->ctlq_msg :
+				(struct libeth_ctlq_msg) {
+					.opcode = LIBETH_CTLQ_SEND_MSG_TO_CP
+				};
+			params->ctlq_msg = ctlq->tx_msg[ctlq->next_to_use];
+		}
+
+		params->ctlq_msg->sw_cookie = cookie;
+		params->ctlq_msg->send_mem = *dma_mem;
+		params->ctlq_msg->data_len = buf_len;
+		params->ctlq_msg->chnl_opcode = params->chnl_opcode;
+		ret = libeth_ctlq_send(params->ctlq, params->ctlq_msg, 1);
+	}
+
+	if (ret && !libeth_cp_can_send_onstack(buf_len))
+		libeth_cp_unmap_dma_mem(dev, dma_mem);
+
+	return ret;
+}
+
+/**
+ * libeth_ctlq_xn_send - Function to send a control queue message
+ * @params: Xn send param information for sending a control queue message
+ *
+ * Send a control queue (mailbox or config) message.
+ * Based on the params value, the call can be completed synchronously or
+ * asynchronously.
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+int libeth_ctlq_xn_send(struct libeth_ctlq_xn_send_params *params)
+{
+	bool free_send = !libeth_cp_can_send_onstack(params->send_buf.iov_len);
+	struct libeth_ctlq_xn *xn;
+	int ret;
+
+	if (params->send_buf.iov_len > LIBETH_CTLQ_MAX_BUF_LEN) {
+		ret = -EINVAL;
+		goto free_buf;
+	}
+
+	xn = libeth_ctlq_xn_pop_free(params->xnm);
+	/* no free transactions available */
+	if (unlikely(!xn)) {
+		ret = -EAGAIN;
+		goto free_buf;
+	}
+
+	spin_lock(&xn->xn_lock);
+
+	xn->state = params->resp_cb ? LIBETH_CTLQ_XN_ASYNC :
+				      LIBETH_CTLQ_XN_WAITING;
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
+	ret = libeth_ctlq_xn_process_send(params, xn);
+	if (ret)
+		goto release_xn;
+	else
+		free_send = false;
+
+	spin_unlock(&xn->xn_lock);
+
+	if (params->resp_cb) {
+		libeth_ctlq_xn_put(params->xnm, xn);
+		return 0;
+	}
+
+	wait_for_completion_timeout(&xn->cmd_completion_event,
+				    msecs_to_jiffies(params->timeout_ms));
+
+	spin_lock(&xn->xn_lock);
+	switch (xn->state) {
+	case LIBETH_CTLQ_XN_WAITING:
+		ret = -ETIMEDOUT;
+		break;
+	case LIBETH_CTLQ_XN_COMPLETED_SUCCESS:
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
+		libeth_ctlq_release_rx_buf(xn->ctlq, &xn->recv_mem);
+
+release_xn:
+	xn->state = LIBETH_CTLQ_XN_IDLE;
+	reinit_completion(&xn->cmd_completion_event);
+	spin_unlock(&xn->xn_lock);
+	libeth_ctlq_xn_push_free(params->xnm, xn);
+free_buf:
+	if (free_send)
+		params->rel_tx_buf(params->send_buf.iov_base);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_ctlq_xn_send, "LIBETH_CP");
+
+/**
+ * libeth_ctlq_xn_send_clean - cleanup the send control queue message buffers
+ * @params: Xn clean param information for send complete handling
+ *
+ * Cleanup the send buffers for the given control queue, if force is set, then
+ * clear all the outstanding send messages irrrespective their send status.
+ * Force should be used during deinit or reset.
+ *
+ * Return: number of send buffers cleaned.
+ */
+u32 libeth_ctlq_xn_send_clean(const struct libeth_ctlq_xn_clean_params *params)
+{
+	struct libeth_ctlq_info *ctlq = params->ctlq;
+	struct device *dev = ctlq->dev;
+	u32 ntc, i;
+
+	spin_lock(&ctlq->lock);
+	ntc = ctlq->next_to_clean;
+
+	for (i = 0; i < params->num_msgs; i++) {
+		struct libeth_ctlq_msg *msg = ctlq->tx_msg[ntc];
+		struct libeth_ctlq_desc *desc;
+		u64 qword;
+
+		desc = &ctlq->descs[ntc];
+		qword = le64_to_cpu(desc->qword0);
+
+		if (!FIELD_GET(LIBETH_CTLQ_DESC_FLAG_DD, qword))
+			break;
+
+		dma_rmb();
+
+		if (!libeth_cp_can_send_onstack(msg->data_len)) {
+			libeth_cp_unmap_dma_mem(dev, &msg->send_mem);
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
+EXPORT_SYMBOL_NS_GPL(libeth_ctlq_xn_send_clean, "LIBETH_CP");
+
+/**
+ * libeth_ctlq_xn_deinit - deallocate and free the transaction manager resources
+ * @xnm: pointer to the transaction manager
+ * @ctx: controlq context structure
+ *
+ * All Rx processing must be stopped beforehand.
+ */
+void libeth_ctlq_xn_deinit(struct libeth_ctlq_xn_manager *xnm,
+			   struct libeth_ctlq_ctx *ctx)
+{
+	bool must_wait = false;
+	u32 i;
+
+	/* Should be no new clear bits after this */
+	spin_lock(&xnm->free_xns_bm_lock);
+		xnm->shutdown = true;
+
+	for_each_clear_bit(i, xnm->free_xns_bm, LIBETH_CTLQ_MAX_XN_ENTRIES) {
+		struct libeth_ctlq_xn *xn = &xnm->ring[i];
+
+		spin_lock(&xn->xn_lock);
+
+		if (xn->state == LIBETH_CTLQ_XN_WAITING ||
+		    xn->state == LIBETH_CTLQ_XN_IDLE) {
+			complete(&xn->cmd_completion_event);
+			must_wait = true;
+		} else if (xn->state == LIBETH_CTLQ_XN_ASYNC) {
+			__libeth_ctlq_xn_push_free(xnm, xn);
+		}
+
+		spin_unlock(&xn->xn_lock);
+	}
+
+	spin_unlock(&xnm->free_xns_bm_lock);
+
+	if (must_wait)
+		wait_for_completion(&xnm->can_destroy);
+
+	libeth_ctlq_xn_deinit_dma(&ctx->mmio_info.pdev->dev, xnm,
+				  LIBETH_CTLQ_MAX_XN_ENTRIES);
+	kfree(xnm);
+	libeth_ctlq_deinit(ctx);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_ctlq_xn_deinit, "LIBETH_CP");
+
+/**
+ * libeth_ctlq_xn_init - initialize the Xn transaction manager
+ * @params: Xn init param information for allocating Xn manager resources
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+int libeth_ctlq_xn_init(struct libeth_ctlq_xn_init_params *params)
+{
+	struct libeth_ctlq_xn_manager *xnm;
+	int ret;
+
+	ret = libeth_ctlq_init(params->ctx, params->cctlq_info, params->num_qs);
+	if (ret)
+		return ret;
+
+	xnm = kzalloc(sizeof(*xnm), GFP_KERNEL);
+	if (!xnm)
+		goto ctlq_deinit;
+
+	ret = libeth_ctlq_xn_init_dma(&params->ctx->mmio_info.pdev->dev, xnm);
+	if (ret)
+		goto free_xnm;
+
+	spin_lock_init(&xnm->free_xns_bm_lock);
+	init_completion(&xnm->can_destroy);
+	bitmap_fill(xnm->free_xns_bm, LIBETH_CTLQ_MAX_XN_ENTRIES);
+
+	for (u32 i = 0; i < LIBETH_CTLQ_MAX_XN_ENTRIES; i++) {
+		struct libeth_ctlq_xn *xn = &xnm->ring[i];
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
+	libeth_ctlq_deinit(params->ctx);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_ctlq_xn_init, "LIBETH_CP");
+
 MODULE_DESCRIPTION("Control Plane communication API");
 MODULE_IMPORT_NS("LIBETH");
 MODULE_LICENSE("GPL");
diff --git a/include/net/libeth/controlq.h b/include/net/libeth/controlq.h
index 35e69d0f48a4..a564a8cccb06 100644
--- a/include/net/libeth/controlq.h
+++ b/include/net/libeth/controlq.h
@@ -4,6 +4,8 @@
 #ifndef __LIBETH_CONTROLQ_H
 #define __LIBETH_CONTROLQ_H
 
+#include <linux/ktime.h>
+
 #include <linux/intel/virtchnl2.h>
 
 #include <net/libeth/pci.h>
@@ -20,6 +22,8 @@
 #define LIBETH_CTLQ_SEND_MSG_TO_CP		0x801
 #define LIBETH_CTLQ_SEND_MSG_TO_PEER		0x804
 
+#define LIBETH_CP_TX_COPYBREAK		128
+
 /**
  * struct libeth_ctlq_ctx - contains controlq info and MMIO region info
  * @mmio_info: MMIO region info structure
@@ -60,11 +64,13 @@ struct libeth_ctlq_reg {
  * @va: virtual address
  * @pa: physical address
  * @size: memory size
+ * @direction: memory to device or device to memory
  */
 struct libeth_cp_dma_mem {
 	void		*va;
 	dma_addr_t	pa;
 	size_t		size;
+	int		direction;
 };
 
 /**
@@ -248,4 +254,167 @@ u32 libeth_ctlq_recv(struct libeth_ctlq_info *ctlq, struct libeth_ctlq_msg *msg,
 
 int libeth_ctlq_post_rx_buffs(struct libeth_ctlq_info *ctlq);
 
+/* Only 8 bits are available in descriptor for Xn index */
+#define LIBETH_CTLQ_MAX_XN_ENTRIES		256
+#define LIBETH_CTLQ_XN_COOKIE_M			GENMASK(15, 8)
+#define LIBETH_CTLQ_XN_INDEX_M			GENMASK(7, 0)
+
+/**
+ * enum libeth_ctlq_xn_state - Transaction state of a virtchnl message
+ * @LIBETH_CTLQ_XN_IDLE: transaction is available to use
+ * @LIBETH_CTLQ_XN_WAITING: waiting for transaction to complete
+ * @LIBETH_CTLQ_XN_COMPLETED_SUCCESS: transaction completed with success
+ * @LIBETH_CTLQ_XN_COMPLETED_FAILED: transaction completed with failure
+ * @LIBETH_CTLQ_XN_ASYNC: asynchronous virtchnl message transaction type
+ */
+enum libeth_ctlq_xn_state {
+	LIBETH_CTLQ_XN_IDLE = 0,
+	LIBETH_CTLQ_XN_WAITING,
+	LIBETH_CTLQ_XN_COMPLETED_SUCCESS,
+	LIBETH_CTLQ_XN_COMPLETED_FAILED,
+	LIBETH_CTLQ_XN_ASYNC,
+};
+
+/**
+ * struct libeth_ctlq_xn - structure representing a virtchnl transaction entry
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
+struct libeth_ctlq_xn {
+	void (*resp_cb)(void *ctx, struct kvec *mem, int status);
+	spinlock_t			xn_lock;	/* protects state */
+	struct libeth_ctlq_info		*ctlq;
+	struct completion		cmd_completion_event;
+	struct libeth_cp_dma_mem	*dma_mem;
+	struct libeth_cp_dma_mem	send_dma_mem;
+	struct kvec			recv_mem;
+	void				*send_ctx;
+	u64				timeout_ms;
+	ktime_t				timestamp;
+	u32				virtchnl_opcode;
+	enum libeth_ctlq_xn_state	state;
+	u8				cookie;
+	u8				index;
+};
+
+/**
+ * struct libeth_ctlq_xn_manager - structure representing the array of virtchnl
+ *				   transaction entries
+ * @ctx: pointer to controlq context structure
+ * @free_xns_bm_lock: lock to protect the free Xn entries bit map
+ * @free_xns_bm: bitmap that represents the free Xn entries
+ * @ring: array of Xn entries
+ * @cookie: unique message identifier
+ */
+struct libeth_ctlq_xn_manager {
+	struct libeth_ctlq_ctx	*ctx;
+	spinlock_t		free_xns_bm_lock;	/* get/check entries */
+	DECLARE_BITMAP(free_xns_bm, LIBETH_CTLQ_MAX_XN_ENTRIES);
+	struct libeth_ctlq_xn	ring[LIBETH_CTLQ_MAX_XN_ENTRIES];
+	struct completion	can_destroy;
+	bool			shutdown;
+	u8			cookie;
+};
+
+/**
+ * struct libeth_ctlq_xn_send_params - structure representing send Xn entry
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
+struct libeth_ctlq_xn_send_params {
+	void (*resp_cb)(void *ctx, struct kvec *mem, int status);
+	void (*rel_tx_buf)(const void *buf_va);
+	struct libeth_ctlq_xn_manager		*xnm;
+	struct libeth_ctlq_info			*ctlq;
+	struct libeth_ctlq_msg			*ctlq_msg;
+	struct kvec				send_buf;
+	struct kvec				recv_mem;
+	void					*send_ctx;
+	u64					timeout_ms;
+	u32					chnl_opcode;
+};
+
+/**
+ * libeth_cp_can_send_onstack - find if a virtchnl message can be sent using a
+ * stack variable
+ * @size: virtchnl buffer size
+ */
+static inline bool libeth_cp_can_send_onstack(u32 size)
+{
+	return size <= LIBETH_CP_TX_COPYBREAK;
+}
+
+/**
+ * struct libeth_ctlq_xn_recv_params - structure representing receive Xn entry
+ * @ctlq_msg_handler: callback to handle a message originated from the peer
+ * @xnm: Xn manager to process Xn entries
+ * @ctx: pointer to context structure
+ * @ctlq: control queue information
+ */
+struct libeth_ctlq_xn_recv_params {
+	void (*ctlq_msg_handler)(struct libeth_ctlq_ctx *ctx,
+				 struct libeth_ctlq_msg *msg);
+	struct libeth_ctlq_xn_manager		*xnm;
+	struct libeth_ctlq_info			*ctlq;
+};
+
+/**
+ * struct libeth_ctlq_xn_clean_params - Data structure used for cleaning the
+ * control queue messages
+ * @rel_tx_buf: driver entry point for freeing the send buffer after send
+ * @ctx: pointer to context structure
+ * @ctlq: control queue information
+ * @send_ctx: context for call back function
+ * @num_msgs: number of messages to be cleaned
+ */
+struct libeth_ctlq_xn_clean_params {
+	void (*rel_tx_buf)(const void *buf_va);
+	struct libeth_ctlq_ctx			*ctx;
+	struct libeth_ctlq_info			*ctlq;
+	void					*send_ctx;
+	u16					num_msgs;
+};
+
+/**
+ * struct libeth_ctlq_xn_init_params - Data structure used for initializing the
+ * Xn transaction manager
+ * @cctlq_info: control queue information
+ * @ctx: pointer to controlq context structure
+ * @xnm: Xn manager to process Xn entries
+ * @num_qs: number of control queues needs to initialized
+ */
+struct libeth_ctlq_xn_init_params {
+	struct libeth_ctlq_create_info		*cctlq_info;
+	struct libeth_ctlq_ctx			*ctx;
+	struct libeth_ctlq_xn_manager		*xnm;
+	u32					num_qs;
+};
+
+int libeth_ctlq_xn_init(struct libeth_ctlq_xn_init_params *params);
+void libeth_ctlq_xn_deinit(struct libeth_ctlq_xn_manager *xnm,
+			   struct libeth_ctlq_ctx *ctx);
+int libeth_ctlq_xn_send(struct libeth_ctlq_xn_send_params *params);
+bool libeth_ctlq_xn_recv(struct libeth_ctlq_xn_recv_params *params);
+u32 libeth_ctlq_xn_send_clean(const struct libeth_ctlq_xn_clean_params *params);
+
 #endif /* __LIBETH_CONTROLQ_H */
-- 
2.47.0


