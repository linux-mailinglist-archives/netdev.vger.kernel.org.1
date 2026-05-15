Return-Path: <netdev+bounces-288496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJhkK6CjB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:52:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A05591A9
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12374308B207
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122913FE341;
	Fri, 15 May 2026 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRFSuVbP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A53F88A8;
	Fri, 15 May 2026 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885120; cv=none; b=KXfbSE2PARqHYvjQ5yb2kjoWRwz+NwTB5B3Q02ibGDvudjQFNeuFyH7NEehOvLFURi9hOZGY/ouZ7ab4FZOQixEKrIH3PxdOE5S/c5sV4BjZAiaeTwqUQdAwrDjRNCx2XWbLOadXQBsDLrX4a4q2P/bczwJOxUKAdcuYXuNxUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885120; c=relaxed/simple;
	bh=Koq1M8UEuGgcouIgYWs9J/2EwGOL+lSfreJPXpbrlLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5uJv2xDiD6Rtk0NuDC4Vi9rV54R1drydWOO571WBST+iNAY8ixaz5oLm2CT3ftEwNjgzmsMTRH2qVivMiwggVkXWKmB0cSzV3EdIXvmzLNuHitHKMW2tCOGNzv23uaYhyqUGvPv3Dr8znawqTyhM9cn8wX2Fw9S7gPhKAExfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRFSuVbP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778885117; x=1810421117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Koq1M8UEuGgcouIgYWs9J/2EwGOL+lSfreJPXpbrlLc=;
  b=iRFSuVbPH3XOOPd1GZHdCLP2UEPbYjQ73l2AUFhI/Y+tgXhTV5DSE6OB
   dMTR8ad6BkF4PlnmB8I4+ie/xQGry6UJZahjIYoH2SC4/ENR504ciNR+W
   OLYM0ca1IbSXiPW+ahvqnYCloYG666R51k2/rUNNe45sbsTiIWgXYh00w
   1a8Al609OtX35i6y9d2jPb8VmTb5gI6rml8i76eLCf1uZgxXI4OH9rfp8
   GHaBvX0QYOkNPkJX7WvE/o96NQCaGYv6aNmk6X2vWhnFOT+POsZPWJdD2
   jTfTFYZG+nkhGpPmjdF39UPV7jspPDIn0r3TQ1Nux0TpeVjdE1XdFffAZ
   A==;
X-CSE-ConnectionGUID: uPXwiO+SQZmCZUTlKMiRag==
X-CSE-MsgGUID: BSI6QKPBTDez8D9DSbMuug==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90949268"
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="90949268"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 15:45:08 -0700
X-CSE-ConnectionGUID: y4vDJqQfSkeXsRWUlHpILw==
X-CSE-MsgGUID: PYCXTuYxSYiEPQOol5/JNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="243146701"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 15 May 2026 15:45:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
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
	Bharath R <Bharath.r@intel.com>
Subject: [PATCH net-next v3 13/14] ixd: add the core initialization
Date: Fri, 15 May 2026 15:44:37 -0700
Message-ID: <20260515224443.2772147-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B6A05591A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288496-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mbx_task.work:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

From: Larysa Zaremba <larysa.zaremba@intel.com>

As the mailbox is setup, initialize the core. This makes use of the send
and receive mailbox message framework for virtchnl communication between
the driver and device Control Plane (CP).

To start with, driver confirms the virtchnl version with the CP. Once that
is done, it requests and gets the required capabilities and resources
needed such as max vectors, queues, vports etc.

Use a unified way of handling the virtchnl messages, where a single
function handles all related memory management and the caller only provides
the callbacks to fill the send buffer and to handle the response.

Place generic control queue message handling separately to facilitate the
addition of protocols other than virtchannel in the future.

Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Bharath R <Bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixd/Makefile       |   2 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  10 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     | 149 +++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |  33 ++++
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  25 ++-
 drivers/net/ethernet/intel/ixd/ixd_main.c     |   3 +
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c | 178 ++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |  12 ++
 8 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h

diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
index 164b2c86952f..90abf231fb16 100644
--- a/drivers/net/ethernet/intel/ixd/Makefile
+++ b/drivers/net/ethernet/intel/ixd/Makefile
@@ -6,5 +6,7 @@
 obj-$(CONFIG_IXD) += ixd.o
 
 ixd-y := ixd_main.o
+ixd-y += ixd_ctlq.o
 ixd-y += ixd_dev.o
 ixd-y += ixd_lib.o
+ixd-y += ixd_virtchnl.o
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index 99c44f2aa659..98d1f22534b5 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -10,19 +10,29 @@
  * struct ixd_adapter - Data structure representing a CPF
  * @cp_ctx: Control plane communication context
  * @init_task: Delayed initialization after reset
+ * @mbx_task: Control queue Rx handling
  * @xnm: virtchnl transaction manager
  * @asq: Send control queue info
  * @arq: Receive control queue info
+ * @vc_ver: Negotiated virtchnl version
+ * @caps: Negotiated virtchnl capabilities
  */
 struct ixd_adapter {
 	struct libie_ctlq_ctx cp_ctx;
 	struct {
 		struct delayed_work init_work;
 		u8 reset_retries;
+		u8 vc_retries;
 	} init_task;
+	struct delayed_work mbx_task;
 	struct libie_ctlq_xn_manager *xnm;
 	struct libie_ctlq_info *asq;
 	struct libie_ctlq_info *arq;
+	struct {
+		u32 major;
+		u32 minor;
+	} vc_ver;
+	struct virtchnl2_get_capabilities caps;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
new file mode 100644
index 000000000000..216aa5c02122
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_ctlq.h"
+#include "ixd_virtchnl.h"
+
+/**
+ * ixd_ctlq_clean_sq - Clean the send control queue after sending the message
+ * @adapter: The adapter that sent the messages
+ * @num_sent: Number of sent messages to be released
+ *
+ * Free the libie send resources after sending the message and handling
+ * the response.
+ */
+static void ixd_ctlq_clean_sq(struct ixd_adapter *adapter, u16 num_sent)
+{
+	if (!num_sent)
+		return;
+
+	struct libie_ctlq_xn_clean_params params = {
+		.ctlq = adapter->asq,
+		.ctx = &adapter->cp_ctx,
+		.num_msgs = num_sent,
+		.rel_tx_buf = kfree,
+	};
+
+	libie_ctlq_xn_send_clean(&params);
+}
+
+/**
+ * ixd_ctlq_init_sparams - Initialize control queue send parameters
+ * @adapter: The adapter with initialized mailbox
+ * @sparams: Parameters to initialize
+ * @msg_buf: DMA-mappable pointer to the message being sent
+ * @msg_size: Message size
+ */
+static void ixd_ctlq_init_sparams(struct ixd_adapter *adapter,
+				  struct libie_ctlq_xn_send_params *sparams,
+				  void *msg_buf, size_t msg_size)
+{
+	*sparams = (struct libie_ctlq_xn_send_params) {
+		.rel_tx_buf = kfree,
+		.xnm = adapter->xnm,
+		.ctlq = adapter->asq,
+		.timeout_ms = IXD_CTLQ_TIMEOUT,
+		.send_buf = (struct kvec) {
+			.iov_base = msg_buf,
+			.iov_len = msg_size,
+		},
+	};
+}
+
+/**
+ * ixd_ctlq_do_req - Perform a standard virtchnl request
+ * @adapter: The adapter with initialized mailbox
+ * @req: virtchnl request description
+ *
+ * Return: %0 if a message was sent and received a response
+ * that was successfully handled by the custom callback,
+ * negative error otherwise.
+ */
+int ixd_ctlq_do_req(struct ixd_adapter *adapter, const struct ixd_ctlq_req *req)
+{
+	struct libie_ctlq_xn_send_params send_params = {};
+	u8 onstack_send_buff[LIBIE_CP_TX_COPYBREAK] = {};
+	struct kvec *recv_mem;
+	void *send_buff;
+	int err;
+
+	send_buff = libie_cp_can_send_onstack(req->send_size) ?
+		    &onstack_send_buff : kzalloc(req->send_size, GFP_KERNEL);
+	if (!send_buff)
+		return -ENOMEM;
+
+	ixd_ctlq_init_sparams(adapter, &send_params, send_buff,
+			      req->send_size);
+
+	send_params.chnl_opcode = req->opcode;
+
+	if (req->send_buff_init)
+		req->send_buff_init(adapter, send_buff, req->ctx);
+
+	err = libie_ctlq_xn_send(&send_params);
+	if (err)
+		return err;
+
+	recv_mem = &send_params.recv_mem;
+	if (req->recv_process)
+		err = req->recv_process(adapter, recv_mem->iov_base,
+					recv_mem->iov_len, req->ctx);
+
+	ixd_ctlq_clean_sq(adapter, 1);
+	libie_ctlq_release_rx_buf(recv_mem);
+
+	return err;
+}
+
+/**
+ * ixd_ctlq_handle_msg - Default control queue message handler
+ * @ctx: Control plane communication context
+ * @msg: Message received
+ */
+static void ixd_ctlq_handle_msg(struct libie_ctlq_ctx *ctx,
+				struct libie_ctlq_msg *msg)
+{
+	struct ixd_adapter *adapter = pci_get_drvdata(ctx->mmio_info.pdev);
+
+	if (ixd_vc_can_handle_msg(msg))
+		ixd_vc_recv_event_msg(adapter, msg);
+	else
+		dev_dbg_ratelimited(ixd_to_dev(adapter),
+				    "Received an unsupported opcode 0x%x from the CP\n",
+				    msg->chnl_opcode);
+
+	libie_ctlq_release_rx_buf(&msg->recv_mem);
+}
+
+/**
+ * ixd_ctlq_recv_mb_msg - Receive a potential message over mailbox periodically
+ * @adapter: The adapter with initialized mailbox
+ */
+static void ixd_ctlq_recv_mb_msg(struct ixd_adapter *adapter)
+{
+	struct libie_ctlq_xn_recv_params xn_params = {
+		.xnm = adapter->xnm,
+		.ctlq = adapter->arq,
+		.ctlq_msg_handler = ixd_ctlq_handle_msg,
+		.budget = LIBIE_CTLQ_MAX_XN_ENTRIES,
+	};
+
+	libie_ctlq_xn_recv(&xn_params);
+}
+
+/**
+ * ixd_ctlq_rx_task - Periodically check for mailbox responses and events
+ * @work: work handle
+ */
+void ixd_ctlq_rx_task(struct work_struct *work)
+{
+	struct ixd_adapter *adapter;
+
+	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
+
+	queue_delayed_work(system_unbound_wq, &adapter->mbx_task,
+			   msecs_to_jiffies(300));
+
+	ixd_ctlq_recv_mb_msg(adapter);
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.h b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
new file mode 100644
index 000000000000..e7191d3870b7
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_CTLQ_H_
+#define _IXD_CTLQ_H_
+
+#include <linux/intel/virtchnl2.h>
+
+#define IXD_CTLQ_TIMEOUT 2000
+
+/**
+ * struct ixd_ctlq_req - Standard virtchnl request description
+ * @opcode: protocol opcode, only virtchnl2 is needed for now
+ * @send_size: required length of the send buffer
+ * @send_buff_init: function to initialize the allocated send buffer
+ * @recv_process: function to handle the CP response
+ * @ctx: additional context for callbacks
+ */
+struct ixd_ctlq_req {
+	enum virtchnl2_op opcode;
+	size_t send_size;
+	void (*send_buff_init)(struct ixd_adapter *adapter, void *send_buff,
+			       void *ctx);
+	int (*recv_process)(struct ixd_adapter *adapter, void *recv_buff,
+			    size_t recv_size, void *ctx);
+	void *ctx;
+};
+
+int ixd_ctlq_do_req(struct ixd_adapter *adapter,
+		    const struct ixd_ctlq_req *req);
+void ixd_ctlq_rx_task(struct work_struct *work);
+
+#endif /* _IXD_CTLQ_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
index afc413d3650f..24080cb30c43 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "ixd.h"
+#include "ixd_virtchnl.h"
 
 #define IXD_DFLT_MBX_Q_LEN 64
 
@@ -67,6 +68,8 @@ static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
  */
 void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter)
 {
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
 	if (adapter->xnm)
 		libie_ctlq_xn_deinit(adapter->xnm, &adapter->cp_ctx);
 
@@ -108,6 +111,8 @@ int ixd_init_dflt_mbx(struct ixd_adapter *adapter)
 		return -ENOENT;
 	}
 
+	queue_delayed_work(system_unbound_wq, &adapter->mbx_task, 0);
+
 	return 0;
 }
 
@@ -136,8 +141,26 @@ void ixd_init_task(struct work_struct *work)
 
 	adapter->init_task.reset_retries = 0;
 	err = ixd_init_dflt_mbx(adapter);
-	if (err)
+	if (err) {
 		dev_err(ixd_to_dev(adapter),
 			"Failed to initialize the default mailbox: %pe\n",
 			ERR_PTR(err));
+		return;
+	}
+
+	if (!ixd_vc_dev_init(adapter)) {
+		adapter->init_task.vc_retries = 0;
+		return;
+	}
+
+	ixd_deinit_dflt_mbx(adapter);
+	if (++adapter->init_task.vc_retries > 5) {
+		dev_err(ixd_to_dev(adapter),
+			"Failed to establish mailbox communications with the hardware\n");
+		return;
+	}
+
+	ixd_trigger_reset(adapter);
+	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
+			   msecs_to_jiffies(500));
 }
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index b4d4000b63ed..6d5e6aca77df 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "ixd.h"
+#include "ixd_ctlq.h"
 #include "ixd_lan_regs.h"
 
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
@@ -19,6 +20,7 @@ static void ixd_remove(struct pci_dev *pdev)
 
 	/* Do not mix removal with (re)initialization */
 	cancel_delayed_work_sync(&adapter->init_task.init_work);
+
 	/* Leave the device clean on exit */
 	ixd_trigger_reset(adapter);
 	ixd_deinit_dflt_mbx(adapter);
@@ -110,6 +112,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_DELAYED_WORK(&adapter->init_task.init_work,
 			  ixd_init_task);
+	INIT_DELAYED_WORK(&adapter->mbx_task, ixd_ctlq_rx_task);
 
 	ixd_trigger_reset(adapter);
 	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
new file mode 100644
index 000000000000..66049d1b1d15
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_ctlq.h"
+#include "ixd_virtchnl.h"
+
+/**
+ * ixd_vc_recv_event_msg - Handle virtchnl event message
+ * @adapter: The adapter handling the message
+ * @ctlq_msg: Message received
+ */
+void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
+			   struct libie_ctlq_msg *ctlq_msg)
+{
+	int payload_size = ctlq_msg->data_len;
+	struct virtchnl2_event *v2e;
+
+	if (payload_size < sizeof(*v2e)) {
+		dev_warn_ratelimited(ixd_to_dev(adapter),
+				     "Failed to receive valid payload for event msg (op 0x%X len %u)\n",
+				     ctlq_msg->chnl_opcode,
+				     payload_size);
+		return;
+	}
+
+	v2e = (struct virtchnl2_event *)ctlq_msg->recv_mem.iov_base;
+
+	dev_dbg(ixd_to_dev(adapter), "Got event 0x%X from the CP\n",
+		le32_to_cpu(v2e->event));
+}
+
+/**
+ * ixd_vc_can_handle_msg - Decide if an event has to be handled by virtchnl code
+ * @ctlq_msg: Message received
+ *
+ * Return: %true if virtchnl code can handle the event, %false otherwise
+ */
+bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg)
+{
+	return ctlq_msg->chnl_opcode == VIRTCHNL2_OP_EVENT;
+}
+
+/**
+ * ixd_handle_caps - Handle VIRTCHNL2_OP_GET_CAPS response
+ * @adapter: The adapter for which the capabilities are being updated
+ * @recv_buff: Buffer containing the response
+ * @recv_size: Response buffer size
+ * @ctx: unused
+ *
+ * Return: %0 if the response format is correct and was handled as expected,
+ * negative error otherwise.
+ */
+static int ixd_handle_caps(struct ixd_adapter *adapter, void *recv_buff,
+			   size_t recv_size, void *ctx)
+{
+	if (recv_size < sizeof(adapter->caps))
+		return -EBADMSG;
+
+	adapter->caps = *(typeof(adapter->caps) *)recv_buff;
+
+	return 0;
+}
+
+/**
+ * ixd_req_vc_caps - Request and save device capability
+ * @adapter: The adapter to get the capabilities for
+ *
+ * Return: success or error if sending the get capability message fails
+ */
+static int ixd_req_vc_caps(struct ixd_adapter *adapter)
+{
+	const struct ixd_ctlq_req req = {
+		.opcode = VIRTCHNL2_OP_GET_CAPS,
+		.send_size = sizeof(struct virtchnl2_get_capabilities),
+		.ctx = NULL,
+		.send_buff_init = NULL,
+		.recv_process = ixd_handle_caps,
+	};
+
+	return ixd_ctlq_do_req(adapter, &req);
+}
+
+/**
+ * ixd_get_vc_ver - Get version info from adapter
+ *
+ * Return: filled in virtchannel2 version info, ready for sending
+ */
+static struct virtchnl2_version_info ixd_get_vc_ver(void)
+{
+	return (struct virtchnl2_version_info) {
+		.major = cpu_to_le32(VIRTCHNL2_VERSION_MAJOR_2),
+		.minor = cpu_to_le32(VIRTCHNL2_VERSION_MINOR_0),
+	};
+}
+
+static void ixd_fill_vc_ver(struct ixd_adapter *adapter, void *send_buff,
+			    void *ctx)
+{
+	*(struct virtchnl2_version_info *)send_buff = ixd_get_vc_ver();
+}
+
+/**
+ * ixd_handle_vc_ver - Handle VIRTCHNL2_OP_VERSION response
+ * @adapter: The adapter for which the version is being updated
+ * @recv_buff: Buffer containing the response
+ * @recv_size: Response buffer size
+ * @ctx: Unused
+ *
+ * Return: %0 if the response format is correct and was handled as expected,
+ * negative error otherwise.
+ */
+static int ixd_handle_vc_ver(struct ixd_adapter *adapter, void *recv_buff,
+			     size_t recv_size, void *ctx)
+{
+	struct virtchnl2_version_info need_ver = ixd_get_vc_ver();
+	struct virtchnl2_version_info *recv_ver;
+
+	if (recv_size < sizeof(need_ver))
+		return -EBADMSG;
+
+	recv_ver = recv_buff;
+	if (le32_to_cpu(need_ver.major) > le32_to_cpu(recv_ver->major))
+		return -EOPNOTSUPP;
+
+	adapter->vc_ver.major = le32_to_cpu(recv_ver->major);
+	adapter->vc_ver.minor = le32_to_cpu(recv_ver->minor);
+
+	return 0;
+}
+
+/**
+ * ixd_req_vc_version - Request and save Virtchannel2 version
+ * @adapter: The adapter to get the version for
+ *
+ * Return: success or error if sending fails or the response was not as expected
+ */
+static int ixd_req_vc_version(struct ixd_adapter *adapter)
+{
+	const struct ixd_ctlq_req req = {
+		.opcode = VIRTCHNL2_OP_VERSION,
+		.send_size = sizeof(struct virtchnl2_version_info),
+		.ctx = NULL,
+		.send_buff_init = ixd_fill_vc_ver,
+		.recv_process = ixd_handle_vc_ver,
+	};
+
+	return ixd_ctlq_do_req(adapter, &req);
+}
+
+/**
+ * ixd_vc_dev_init - virtchnl device core initialization
+ * @adapter: device information
+ *
+ * Return: %0 on success or error if any step of the initialization fails
+ */
+int ixd_vc_dev_init(struct ixd_adapter *adapter)
+{
+	int err;
+
+	err = ixd_req_vc_version(adapter);
+	if (err) {
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting virtchnl version failed, error=%pe\n",
+			 ERR_PTR(err));
+		return err;
+	}
+
+	err = ixd_req_vc_caps(adapter);
+	if (err) {
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting virtchnl capabilities failed, error=%pe\n",
+			 ERR_PTR(err));
+		return err;
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
new file mode 100644
index 000000000000..1a53da8b545c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_VIRTCHNL_H_
+#define _IXD_VIRTCHNL_H_
+
+int ixd_vc_dev_init(struct ixd_adapter *adapter);
+bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg);
+void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
+			   struct libie_ctlq_msg *ctlq_msg);
+
+#endif /* _IXD_VIRTCHNL_H_ */
-- 
2.47.1


