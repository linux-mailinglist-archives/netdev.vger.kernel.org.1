Return-Path: <netdev+bounces-158077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C01A10656
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53253A83BF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9FF236EC3;
	Tue, 14 Jan 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ4UYQpB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A0236EBD
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856844; cv=none; b=JrwW/yNCTBNMQfX4PtsDi0fG0MDsT1a6t+CTKYkLXkBzcz1YdqkUPtA3k42jON1p9tvVxS6WjXObjyEiDf7Tw8WYduUhFKNhItPhssVMFuF2Qy5Wt1LF2e78uIhEz9Rjozb3cSEQFxIqUHuHijhBW1OYwsRALUThWNdoyagWn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856844; c=relaxed/simple;
	bh=kb/l7nCWmwgDztY5hXEpq0Ns5Wwp7k3+6eI1QpXE7h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5BWy1mFDmhyVfEGBweh0o0kJ6r1BxWr3919BU707MzGHB0Sgf4ouknnrT1RfoLiasyPnS+xURYAfqpwJwmvgRHJ2+JEBXNrrljjEWirzjA0x5hdm2S5mTdV2+yCbo38kK2o5bua7dTM782CFqwhljqzbQy4M8gQLAxS8qSoAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ4UYQpB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736856843; x=1768392843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kb/l7nCWmwgDztY5hXEpq0Ns5Wwp7k3+6eI1QpXE7h4=;
  b=fJ4UYQpBPGxQTDCzTeExgeAwNvFE5RfFDVQlRiO1I2C/ZmPRWluDpTc6
   3kFqyeBBXSEFZ15oZsX29PRabNGjimsE6p0ASikhmHhezkS+ZbOyaZw4w
   Y4Hp8F+p4zJOl5ZQhlDjlu60ccwI5iGSeS2bp3473mhr4RfSRoK21PKrA
   9/wVNSpJUsyC/9ykCmVSnJj1/Pp6Q9YfavTMChsk1ht0L1htIfjDEW3ve
   +UoGas8lyY8P5phJszqXo/SMOWYqp3tfQDMaSkwjtL++y7D8urb7P+bR/
   lS2l8wkuy1h/INuWNec06SvzCGFcIqZNtzOEobMecoKYvD0fpIQGfqHKR
   Q==;
X-CSE-ConnectionGUID: gRk29t0KQTGmrsIsnLMcWA==
X-CSE-MsgGUID: M4UtnlcvTV2BZPettaAnbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59631994"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="59631994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 04:14:02 -0800
X-CSE-ConnectionGUID: pJK6z2wmRu2U4Fdf59GNVw==
X-CSE-MsgGUID: sieOh7ZmQD6bvILFEpNJNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104641824"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa010.jf.intel.com with ESMTP; 14 Jan 2025 04:13:59 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH v4 iwl-next 03/10] idpf: move virtchnl structures to the header file
Date: Tue, 14 Jan 2025 13:11:02 +0100
Message-Id: <20250114121103.605288-4-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250114121103.605288-1-milena.olech@intel.com>
References: <20250114121103.605288-1-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move virtchnl structures to the header file to expose them for the PTP
virtchnl file.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
v1 -> v2: fix commit message title

 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 86 +------------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   | 84 ++++++++++++++++++
 2 files changed, 86 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 7004289b974c..a55ff20895ed 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -7,88 +7,6 @@
 #include "idpf_virtchnl.h"
 #include "idpf_ptp.h"
 
-#define IDPF_VC_XN_MIN_TIMEOUT_MSEC	2000
-#define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
-#define IDPF_VC_XN_IDX_M		GENMASK(7, 0)
-#define IDPF_VC_XN_SALT_M		GENMASK(15, 8)
-#define IDPF_VC_XN_RING_LEN		U8_MAX
-
-/**
- * enum idpf_vc_xn_state - Virtchnl transaction status
- * @IDPF_VC_XN_IDLE: not expecting a reply, ready to be used
- * @IDPF_VC_XN_WAITING: expecting a reply, not yet received
- * @IDPF_VC_XN_COMPLETED_SUCCESS: a reply was expected and received,
- *				  buffer updated
- * @IDPF_VC_XN_COMPLETED_FAILED: a reply was expected and received, but there
- *				 was an error, buffer not updated
- * @IDPF_VC_XN_SHUTDOWN: transaction object cannot be used, VC torn down
- * @IDPF_VC_XN_ASYNC: transaction sent asynchronously and doesn't have the
- *		      return context; a callback may be provided to handle
- *		      return
- */
-enum idpf_vc_xn_state {
-	IDPF_VC_XN_IDLE = 1,
-	IDPF_VC_XN_WAITING,
-	IDPF_VC_XN_COMPLETED_SUCCESS,
-	IDPF_VC_XN_COMPLETED_FAILED,
-	IDPF_VC_XN_SHUTDOWN,
-	IDPF_VC_XN_ASYNC,
-};
-
-struct idpf_vc_xn;
-/* Callback for asynchronous messages */
-typedef int (*async_vc_cb) (struct idpf_adapter *, struct idpf_vc_xn *,
-			    const struct idpf_ctlq_msg *);
-
-/**
- * struct idpf_vc_xn - Data structure representing virtchnl transactions
- * @completed: virtchnl event loop uses that to signal when a reply is
- *	       available, uses kernel completion API
- * @state: virtchnl event loop stores the data below, protected by the
- *	   completion's lock.
- * @reply_sz: Original size of reply, may be > reply_buf.iov_len; it will be
- *	      truncated on its way to the receiver thread according to
- *	      reply_buf.iov_len.
- * @reply: Reference to the buffer(s) where the reply data should be written
- *	   to. May be 0-length (then NULL address permitted) if the reply data
- *	   should be ignored.
- * @async_handler: if sent asynchronously, a callback can be provided to handle
- *		   the reply when it's received
- * @vc_op: corresponding opcode sent with this transaction
- * @idx: index used as retrieval on reply receive, used for cookie
- * @salt: changed every message to make unique, used for cookie
- */
-struct idpf_vc_xn {
-	struct completion completed;
-	enum idpf_vc_xn_state state;
-	size_t reply_sz;
-	struct kvec reply;
-	async_vc_cb async_handler;
-	u32 vc_op;
-	u8 idx;
-	u8 salt;
-};
-
-/**
- * struct idpf_vc_xn_params - Parameters for executing transaction
- * @send_buf: kvec for send buffer
- * @recv_buf: kvec for recv buffer, may be NULL, must then have zero length
- * @timeout_ms: timeout to wait for reply
- * @async: send message asynchronously, will not wait on completion
- * @async_handler: If sent asynchronously, optional callback handler. The user
- *		   must be careful when using async handlers as the memory for
- *		   the recv_buf _cannot_ be on stack if this is async.
- * @vc_op: virtchnl op to send
- */
-struct idpf_vc_xn_params {
-	struct kvec send_buf;
-	struct kvec recv_buf;
-	int timeout_ms;
-	bool async;
-	async_vc_cb async_handler;
-	u32 vc_op;
-};
-
 /**
  * struct idpf_vc_xn_manager - Manager for tracking transactions
  * @ring: backing and lookup for transactions
@@ -450,8 +368,8 @@ static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
  * >= @recv_buf.iov_len, but we never overflow @@recv_buf_iov_base). < 0 for
  * error.
  */
-static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
-			       const struct idpf_vc_xn_params *params)
+ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
+			const struct idpf_vc_xn_params *params)
 {
 	const struct kvec *send_buf = &params->send_buf;
 	struct idpf_vc_xn *xn;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 83da5d8da56b..3522c1238ea2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -4,6 +4,88 @@
 #ifndef _IDPF_VIRTCHNL_H_
 #define _IDPF_VIRTCHNL_H_
 
+#define IDPF_VC_XN_MIN_TIMEOUT_MSEC	2000
+#define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
+#define IDPF_VC_XN_IDX_M		GENMASK(7, 0)
+#define IDPF_VC_XN_SALT_M		GENMASK(15, 8)
+#define IDPF_VC_XN_RING_LEN		U8_MAX
+
+/**
+ * enum idpf_vc_xn_state - Virtchnl transaction status
+ * @IDPF_VC_XN_IDLE: not expecting a reply, ready to be used
+ * @IDPF_VC_XN_WAITING: expecting a reply, not yet received
+ * @IDPF_VC_XN_COMPLETED_SUCCESS: a reply was expected and received, buffer
+ *				  updated
+ * @IDPF_VC_XN_COMPLETED_FAILED: a reply was expected and received, but there
+ *				 was an error, buffer not updated
+ * @IDPF_VC_XN_SHUTDOWN: transaction object cannot be used, VC torn down
+ * @IDPF_VC_XN_ASYNC: transaction sent asynchronously and doesn't have the
+ *		      return context; a callback may be provided to handle
+ *		      return
+ */
+enum idpf_vc_xn_state {
+	IDPF_VC_XN_IDLE = 1,
+	IDPF_VC_XN_WAITING,
+	IDPF_VC_XN_COMPLETED_SUCCESS,
+	IDPF_VC_XN_COMPLETED_FAILED,
+	IDPF_VC_XN_SHUTDOWN,
+	IDPF_VC_XN_ASYNC,
+};
+
+struct idpf_vc_xn;
+/* Callback for asynchronous messages */
+typedef int (*async_vc_cb) (struct idpf_adapter *, struct idpf_vc_xn *,
+			    const struct idpf_ctlq_msg *);
+
+/**
+ * struct idpf_vc_xn - Data structure representing virtchnl transactions
+ * @completed: virtchnl event loop uses that to signal when a reply is
+ *	       available, uses kernel completion API
+ * @state: virtchnl event loop stores the data below, protected by the
+ *	   completion's lock.
+ * @reply_sz: Original size of reply, may be > reply_buf.iov_len; it will be
+ *	      truncated on its way to the receiver thread according to
+ *	      reply_buf.iov_len.
+ * @reply: Reference to the buffer(s) where the reply data should be written
+ *	   to. May be 0-length (then NULL address permitted) if the reply data
+ *	   should be ignored.
+ * @async_handler: if sent asynchronously, a callback can be provided to handle
+ *		   the reply when it's received
+ * @vc_op: corresponding opcode sent with this transaction
+ * @idx: index used as retrieval on reply receive, used for cookie
+ * @salt: changed every message to make unique, used for cookie
+ */
+struct idpf_vc_xn {
+	struct completion completed;
+	enum idpf_vc_xn_state state;
+	size_t reply_sz;
+	struct kvec reply;
+	async_vc_cb async_handler;
+	u32 vc_op;
+	u8 idx;
+	u8 salt;
+};
+
+/**
+ * struct idpf_vc_xn_params - Parameters for executing transaction
+ * @send_buf: kvec for send buffer
+ * @recv_buf: kvec for recv buffer, may be NULL, must then have zero length
+ * @timeout_ms: timeout to wait for reply
+ * @async: send message asynchronously, will not wait on completion
+ * @async_handler: If sent asynchronously, optional callback handler. The user
+ *		   must be careful when using async handlers as the memory for
+ *		   the recv_buf _cannot_ be on stack if this is async.
+ * @vc_op: virtchnl op to send
+ */
+struct idpf_vc_xn_params {
+	struct kvec send_buf;
+	struct kvec recv_buf;
+	int timeout_ms;
+	bool async;
+	async_vc_cb async_handler;
+	u32 vc_op;
+};
+
 struct idpf_adapter;
 struct idpf_netdev_priv;
 struct idpf_vec_regs;
@@ -11,6 +93,8 @@ struct idpf_vport;
 struct idpf_vport_max_q;
 struct idpf_vport_user_config_data;
 
+ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
+			const struct idpf_vc_xn_params *params);
 int idpf_init_dflt_mbx(struct idpf_adapter *adapter);
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter);
 int idpf_vc_core_init(struct idpf_adapter *adapter);
-- 
2.31.1


