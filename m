Return-Path: <netdev+bounces-250355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8761CD29571
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9270A30E77FA
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027E32D0F3;
	Thu, 15 Jan 2026 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKODVwD+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6579328B52
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520897; cv=none; b=ba6FoyHK4L7kE47b7jWSwGKKXy+BkPDXVOuRJZL8lHvrRN/cSMjiOskZfALNvpQSiTPArSjS/AMdNT/PQru7uGFlfk7BQHelTQnV7jx9eeH3H7s+e5RLva+8xMvJentbyFf9i/YvAPGwvAfbDUEh8ST0NDNqXY7Ti8TfxgR1cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520897; c=relaxed/simple;
	bh=JrWc8+P36WhzUl/w08aNkv42ODiMoCmxKhLIG3GANm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggK1Ea7HeRN+211AupsM6zLLclPaNKfqfz8tV9FOYY1S928XVtnlyU1rYi2iPoNsYa3T4fPys55px613xtYRk70hvOCzf6MKt7Q/BPNoZIXJ1baWZXmWaMmbUuoXp3RhYlvhkA3xMuT9gsEn8YI7Kil0mkZPbAXJecPuBDFFq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKODVwD+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768520892; x=1800056892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JrWc8+P36WhzUl/w08aNkv42ODiMoCmxKhLIG3GANm8=;
  b=hKODVwD+eLh6hnb9/DeXF7OLyZrAnOivMIKzRdej7mbIA23ABLtJgI1Y
   FqU9e2agUvSNjBSneqdMZr/sTQQqLUnfmmpLMWVh7+x25EhzUz2RZay+1
   jKSzLybotPAbwlC9OqSmxrdf+kRcLR0W6XPJN/lzYV3/lw6XOk7rLKEh6
   HjU456PRwoWy4/Zvq2BJD62ZW2xqHWYtNpit07qwP49tD3Z2Rg8W2c+6h
   a1zVPVn3CCPvAEfEaHU15cTyvgMyoeaPefjIyhNdeZtCvxRSqsr9FQk6e
   4EiODkY2/0UBVQoAD+OLgjNBY9rxo/PVbcRgxh1b72AIy4VfgqSf0Fopj
   g==;
X-CSE-ConnectionGUID: Qc741E7iRU2kKgAiciPvEA==
X-CSE-MsgGUID: P1//rFY8Q52gEh4MJG3Hug==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69892390"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69892390"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:48:03 -0800
X-CSE-ConnectionGUID: 5x+YFJJjQz+080AhGDS48Q==
X-CSE-MsgGUID: HT5xdwA0SY+A1oHCvABbFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="205502037"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jan 2026 15:48:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 10/10] idpf: generalize mailbox API
Date: Thu, 15 Jan 2026 15:47:47 -0800
Message-ID: <20260115234749.2365504-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
References: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Add a control queue parameter to all mailbox APIs in order to make use
of those APIs for non-default mailbox as well.

Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  3 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 42 ++++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  6 +--
 4 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 9d685a914714..6c03de5eefe0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1383,7 +1383,7 @@ void idpf_mbx_task(struct work_struct *work)
 		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task,
 				   usecs_to_jiffies(300));
 
-	idpf_recv_mb_msg(adapter);
+	idpf_recv_mb_msg(adapter, adapter->hw.arq);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index 8c2008477621..7527b967e2e7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -158,7 +158,8 @@ static void idpf_vf_trigger_reset(struct idpf_adapter *adapter,
 	/* Do not send VIRTCHNL2_OP_RESET_VF message on driver unload */
 	if (trig_cause == IDPF_HR_FUNC_RESET &&
 	    !test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
-		idpf_send_mb_msg(adapter, VIRTCHNL2_OP_RESET_VF, 0, NULL, 0);
+		idpf_send_mb_msg(adapter, adapter->hw.asq,
+				 VIRTCHNL2_OP_RESET_VF, 0, NULL, 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 029f77c62f41..db701bc0b91c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -117,13 +117,15 @@ static void idpf_recv_event_msg(struct idpf_adapter *adapter,
 
 /**
  * idpf_mb_clean - Reclaim the send mailbox queue entries
- * @adapter: Driver specific private structure
+ * @adapter: driver specific private structure
+ * @asq: send control queue info
  *
  * Reclaim the send mailbox queue entries to be used to send further messages
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
-static int idpf_mb_clean(struct idpf_adapter *adapter)
+static int idpf_mb_clean(struct idpf_adapter *adapter,
+			 struct idpf_ctlq_info *asq)
 {
 	u16 i, num_q_msg = IDPF_DFLT_MBX_Q_LEN;
 	struct idpf_ctlq_msg **q_msg;
@@ -134,7 +136,7 @@ static int idpf_mb_clean(struct idpf_adapter *adapter)
 	if (!q_msg)
 		return -ENOMEM;
 
-	err = idpf_ctlq_clean_sq(adapter->hw.asq, &num_q_msg, q_msg);
+	err = idpf_ctlq_clean_sq(asq, &num_q_msg, q_msg);
 	if (err)
 		goto err_kfree;
 
@@ -206,7 +208,8 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
 
 /**
  * idpf_send_mb_msg - Send message over mailbox
- * @adapter: Driver specific private structure
+ * @adapter: driver specific private structure
+ * @asq: control queue to send message to
  * @op: virtchnl opcode
  * @msg_size: size of the payload
  * @msg: pointer to buffer holding the payload
@@ -214,10 +217,10 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  *
  * Will prepare the control queue message and initiates the send api
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
-int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     u16 msg_size, u8 *msg, u16 cookie)
+int idpf_send_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *asq,
+		     u32 op, u16 msg_size, u8 *msg, u16 cookie)
 {
 	struct idpf_ctlq_msg *ctlq_msg;
 	struct idpf_dma_mem *dma_mem;
@@ -231,7 +234,7 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
 	if (idpf_is_reset_detected(adapter))
 		return 0;
 
-	err = idpf_mb_clean(adapter);
+	err = idpf_mb_clean(adapter, asq);
 	if (err)
 		return err;
 
@@ -267,7 +270,7 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
 	ctlq_msg->ctx.indirect.payload = dma_mem;
 	ctlq_msg->ctx.sw_cookie.data = cookie;
 
-	err = idpf_ctlq_send(&adapter->hw, adapter->hw.asq, 1, ctlq_msg);
+	err = idpf_ctlq_send(&adapter->hw, asq, 1, ctlq_msg);
 	if (err)
 		goto send_error;
 
@@ -463,7 +466,7 @@ ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 	cookie = FIELD_PREP(IDPF_VC_XN_SALT_M, xn->salt) |
 		 FIELD_PREP(IDPF_VC_XN_IDX_M, xn->idx);
 
-	retval = idpf_send_mb_msg(adapter, params->vc_op,
+	retval = idpf_send_mb_msg(adapter, adapter->hw.asq, params->vc_op,
 				  send_buf->iov_len, send_buf->iov_base,
 				  cookie);
 	if (retval) {
@@ -662,12 +665,14 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 
 /**
  * idpf_recv_mb_msg - Receive message over mailbox
- * @adapter: Driver specific private structure
+ * @adapter: driver specific private structure
+ * @arq: control queue to receive message from
+ *
+ * Will receive control queue message and posts the receive buffer.
  *
- * Will receive control queue message and posts the receive buffer. Returns 0
- * on success and negative on failure.
+ * Return: 0 on success and negative on failure.
  */
-int idpf_recv_mb_msg(struct idpf_adapter *adapter)
+int idpf_recv_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *arq)
 {
 	struct idpf_ctlq_msg ctlq_msg;
 	struct idpf_dma_mem *dma_mem;
@@ -679,7 +684,7 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
 		 * actually received on num_recv.
 		 */
 		num_recv = 1;
-		err = idpf_ctlq_recv(adapter->hw.arq, &num_recv, &ctlq_msg);
+		err = idpf_ctlq_recv(arq, &num_recv, &ctlq_msg);
 		if (err || !num_recv)
 			break;
 
@@ -695,8 +700,7 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
 		else
 			err = idpf_vc_xn_forward_reply(adapter, &ctlq_msg);
 
-		post_err = idpf_ctlq_post_rx_buffs(&adapter->hw,
-						   adapter->hw.arq,
+		post_err = idpf_ctlq_post_rx_buffs(&adapter->hw, arq,
 						   &num_recv, &dma_mem);
 
 		/* If post failed clear the only buffer we supplied */
@@ -3392,7 +3396,7 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter)
 {
 	if (adapter->hw.arq && adapter->hw.asq) {
-		idpf_mb_clean(adapter);
+		idpf_mb_clean(adapter, adapter->hw.asq);
 		idpf_ctlq_deinit(&adapter->hw);
 	}
 	adapter->hw.arq = NULL;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 3e5a22bbeabd..fe065911ad5a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -123,9 +123,9 @@ bool idpf_sideband_action_ena(struct idpf_vport *vport,
 			      struct ethtool_rx_flow_spec *fsp);
 unsigned int idpf_fsteer_max_rules(struct idpf_vport *vport);
 
-int idpf_recv_mb_msg(struct idpf_adapter *adapter);
-int idpf_send_mb_msg(struct idpf_adapter *adapter, u32 op,
-		     u16 msg_size, u8 *msg, u16 cookie);
+int idpf_recv_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *arq);
+int idpf_send_mb_msg(struct idpf_adapter *adapter, struct idpf_ctlq_info *asq,
+		     u32 op, u16 msg_size, u8 *msg, u16 cookie);
 
 struct idpf_queue_ptr {
 	enum virtchnl2_queue_type	type;
-- 
2.47.1


