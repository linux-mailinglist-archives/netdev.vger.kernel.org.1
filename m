Return-Path: <netdev+bounces-114058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E834940D8B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916371F2383D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C4197A90;
	Tue, 30 Jul 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WM/HzT0B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210D196D8D
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331683; cv=none; b=n3WP09J5kLLwOSRQ6toHr50A5xR8cao7Jnw2kDAi5dCP/NKeI6JBj3tAL7sdANFic2gdgRAwtfGYhU3RyplelYwhgjItRWyczV/sAGu5FM7N6RrL2DPUgFnSMLBI0GWsFGa2Zo8s/KV8FGwfH4fyIUJ/MYwiyXBdHe5LDzEKtKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331683; c=relaxed/simple;
	bh=4OKZtdnn6RZohqBOn1kseZM9OT3dmWr9PFaaVNGGfYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7fFwcCzGNaXHLLV7iXP0KlyJg/53B3shUfVO6LRBpkyX0QrpPE8sTLNSM/JSjW9itOH+w9a7TKwkWAsykbJhCJvtzDg78LcXBwESPquqDeK37yzUubD2mJTPQZIHL/oe63nkyi6xY7ZkYwR5YdkE6901QsyyWRygfLai8OCQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WM/HzT0B; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722331681; x=1753867681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OKZtdnn6RZohqBOn1kseZM9OT3dmWr9PFaaVNGGfYI=;
  b=WM/HzT0B14y4Ug395bzmU57mQBgrb49B5arldOIvpuvYgx0swZJJ8SNX
   VH8Z2XNMTQc19f3yKqGjyJhFERxXJ1VKXPuyOiSUay2mBBpY08pEdNqUz
   xq+d2gNKFkV7nZSnBjWypnPEkkgCscz2lEd4LH1FuwyGJh0e1fO6exP0C
   bt0ZOZnNMXrcQ1lnMl31DODNH6pEc9rxPivbipN2+4cV/eosRCROYGEPt
   ahj7VRgpaXln4DfAVQVUp/K+yqjnnnd9NfCaDaZzg1rq/wSgTXpsMc5dJ
   m1YSqBYy4qV2xNU0CNJ4/BWu68OT/1FjQhdJ9146zMvaOOxGTyT5fAvxR
   w==;
X-CSE-ConnectionGUID: OZOldo3mQA+AOCNnAiw8bA==
X-CSE-MsgGUID: u3HPYFwKT5m9i6EckijvWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="45551320"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="45551320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:28:01 -0700
X-CSE-ConnectionGUID: 7umG6nb2SVSoskM+bR2i6g==
X-CSE-MsgGUID: 0skTcNCgRzmE3lc1MW6oRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84923197"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 02:27:56 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3BB6D2816F;
	Tue, 30 Jul 2024 10:27:55 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v8 07/14] iavf: add support for indirect access to PHC time
Date: Tue, 30 Jul 2024 05:15:02 -0400
Message-Id: <20240730091509.18846-8-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Implement support for reading the PHC time indirectly via the
VIRTCHNL_OP_1588_PTP_GET_TIME operation.

Based on some simple tests with ftrace, the latency of the indirect
clock access appears to be about ~110 microseconds. This is due to the
cost of preparing a message to send over the virtchnl queue.

This is expected, due to the increased jitter caused by sending messages
over virtchnl. It is not easy to control the precise time that the
message is sent by the VF, or the time that the message is responded to
by the PF, or the time that the message sent from the PF is received by
the VF.

For sending the request, note that many PTP related operations will
require sending of VIRTCHNL messages. Instead of adding a separate AQ
flag and storage for each operation, setup a simple queue mechanism for
queuing up virtchnl messages.

Each message will be converted to a iavf_ptp_aq_cmd structure which ends
with a flexible array member. A single AQ flag is added for processing
messages from this queue. In principle this could be extended to handle
arbitrary virtchnl messages. For now it is kept to PTP-specific as the
need is primarily for handling PTP-related commands.

Use this to implement .gettimex64 using the indirect method via the
virtchnl command. The response from the PF is processed and stored into
the cached_phc_time. A wait queue is used to allow the PTP clock gettime
request to sleep until the message is sent from the PF.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   9 +-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 161 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  16 ++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  93 ++++++++++
 4 files changed, 278 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3961c540c1c4..dc1908690e2d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2234,7 +2234,10 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		iavf_enable_vlan_insertion_v2(adapter, ETH_P_8021AD);
 		return 0;
 	}
-
+	if (adapter->aq_required & IAVF_FLAG_AQ_SEND_PTP_CMD) {
+		iavf_virtchnl_send_ptp_cmd(adapter);
+		return IAVF_SUCCESS;
+	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_STATS) {
 		iavf_request_stats(adapter);
 		return 0;
@@ -5326,6 +5329,10 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
+	INIT_LIST_HEAD(&adapter->ptp.aq_cmds);
+	init_waitqueue_head(&adapter->ptp.phc_time_waitqueue);
+	mutex_init(&adapter->ptp.aq_cmd_lock);
+
 	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
 	/* Initialization goes on in the work. Do not add more of it below. */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index 1344298481d4..46c4f8e11bdd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -3,6 +3,23 @@
 
 #include "iavf.h"
 
+/**
+ * clock_to_adapter - Convert clock info pointer to adapter pointer
+ * @ptp_info: PTP info structure
+ *
+ * Use container_of in order to extract a pointer to the iAVF adapter private
+ * structure.
+ *
+ * Return: pointer to iavf_adapter structure
+ */
+static struct iavf_adapter *clock_to_adapter(struct ptp_clock_info *ptp_info)
+{
+	struct iavf_ptp *ptp_priv;
+
+	ptp_priv = container_of(ptp_info, struct iavf_ptp, info);
+	return container_of(ptp_priv, struct iavf_adapter, ptp);
+}
+
 /**
  * iavf_ptp_cap_supported - Check if a PTP capability is supported
  * @adapter: private adapter structure
@@ -20,6 +37,138 @@ bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap)
 	return (adapter->ptp.hw_caps.caps & cap) == cap;
 }
 
+/**
+ * iavf_allocate_ptp_cmd - Allocate a PTP command message structure
+ * @v_opcode: the virtchnl opcode
+ * @msglen: length in bytes of the associated virtchnl structure
+ *
+ * Allocates a PTP command message and pre-fills it with the provided message
+ * length and opcode.
+ *
+ * Return: allocated PTP command
+ */
+static struct iavf_ptp_aq_cmd *iavf_allocate_ptp_cmd(enum virtchnl_ops v_opcode,
+						     u16 msglen)
+{
+	struct iavf_ptp_aq_cmd *cmd;
+
+	cmd = kzalloc(struct_size(cmd, msg, msglen), GFP_KERNEL);
+	if (!cmd)
+		return NULL;
+
+	cmd->v_opcode = v_opcode;
+	cmd->msglen = msglen;
+
+	return cmd;
+}
+
+/**
+ * iavf_queue_ptp_cmd - Queue PTP command for sending over virtchnl
+ * @adapter: private adapter structure
+ * @cmd: the command structure to send
+ *
+ * Queue the given command structure into the PTP virtchnl command queue tos
+ * end to the PF.
+ */
+static void iavf_queue_ptp_cmd(struct iavf_adapter *adapter,
+			       struct iavf_ptp_aq_cmd *cmd)
+{
+	mutex_lock(&adapter->ptp.aq_cmd_lock);
+	list_add_tail(&cmd->list, &adapter->ptp.aq_cmds);
+	mutex_unlock(&adapter->ptp.aq_cmd_lock);
+
+	adapter->aq_required |= IAVF_FLAG_AQ_SEND_PTP_CMD;
+	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+}
+
+/**
+ * iavf_send_phc_read - Send request to read PHC time
+ * @adapter: private adapter structure
+ *
+ * Send a request to obtain the PTP hardware clock time. This allocates the
+ * VIRTCHNL_OP_1588_PTP_GET_TIME message and queues it up to send to
+ * indirectly read the PHC time.
+ *
+ * This function does not wait for the reply from the PF.
+ *
+ * Return: 0 if success, error code otherwise
+ */
+static int iavf_send_phc_read(struct iavf_adapter *adapter)
+{
+	struct iavf_ptp_aq_cmd *cmd;
+
+	if (!adapter->ptp.initialized)
+		return -EOPNOTSUPP;
+
+	cmd = iavf_allocate_ptp_cmd(VIRTCHNL_OP_1588_PTP_GET_TIME,
+				    sizeof(struct virtchnl_phc_time));
+	if (!cmd)
+		return -ENOMEM;
+
+	iavf_queue_ptp_cmd(adapter, cmd);
+
+	return 0;
+}
+
+/**
+ * iavf_read_phc_indirect - Indirectly read the PHC time via virtchnl
+ * @adapter: private adapter structure
+ * @ts: storage for the timestamp value
+ * @sts: system timestamp values before and after the read
+ *
+ * Used when the device does not have direct register access to the PHC time.
+ * Indirectly reads the time via the VIRTCHNL_OP_1588_PTP_GET_TIME, and waits
+ * for the reply from the PF.
+ *
+ * Based on some simple measurements using ftrace and phc2sys, this clock
+ * access method has about a ~110 usec latency even when the system is not
+ * under load. In order to achieve acceptable results when using phc2sys with
+ * the indirect clock access method, it is recommended to use more
+ * conservative proportional and integration constants with the P/I servo.
+ *
+ * Return: 0 if success, error code otherwise
+ */
+static int iavf_read_phc_indirect(struct iavf_adapter *adapter,
+				  struct timespec64 *ts,
+				  struct ptp_system_timestamp *sts)
+{
+	long ret;
+	int err;
+
+	adapter->ptp.phc_time_ready = false;
+	ptp_read_system_prets(sts);
+
+	err = iavf_send_phc_read(adapter);
+	if (err)
+		return err;
+
+	ret = wait_event_interruptible_timeout(adapter->ptp.phc_time_waitqueue,
+					       adapter->ptp.phc_time_ready,
+					       HZ);
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		return -EBUSY;
+
+	*ts = ns_to_timespec64(adapter->ptp.cached_phc_time);
+
+	ptp_read_system_postts(sts);
+
+	return 0;
+}
+
+static int iavf_ptp_gettimex64(struct ptp_clock_info *ptp,
+			       struct timespec64 *ts,
+			       struct ptp_system_timestamp *sts)
+{
+	struct iavf_adapter *adapter = clock_to_adapter(ptp);
+
+	if (!adapter->ptp.initialized)
+		return -ENODEV;
+
+	return iavf_read_phc_indirect(adapter, ts, sts);
+}
+
 /**
  * iavf_ptp_register_clock - Register a new PTP for userspace
  * @adapter: private adapter structure
@@ -39,6 +188,7 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 dev_driver_string(dev),
 		 dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
+	ptp_info->gettimex64 = iavf_ptp_gettimex64;
 
 	adapter->ptp.clock = ptp_clock_register(ptp_info, dev);
 	if (IS_ERR(adapter->ptp.clock))
@@ -89,6 +239,8 @@ void iavf_ptp_init(struct iavf_adapter *adapter)
  */
 void iavf_ptp_release(struct iavf_adapter *adapter)
 {
+	struct iavf_ptp_aq_cmd *cmd, *tmp;
+
 	adapter->ptp.initialized = false;
 
 	if (!IS_ERR_OR_NULL(adapter->ptp.clock)) {
@@ -97,6 +249,15 @@ void iavf_ptp_release(struct iavf_adapter *adapter)
 		ptp_clock_unregister(adapter->ptp.clock);
 		adapter->ptp.clock = NULL;
 	}
+
+	/* Cancel any remaining uncompleted PTP clock commands */
+	mutex_lock(&adapter->ptp.aq_cmd_lock);
+	list_for_each_entry_safe(cmd, tmp, &adapter->ptp.aq_cmds, list) {
+		list_del(&cmd->list);
+		kfree(cmd);
+	}
+	adapter->aq_required &= ~IAVF_FLAG_AQ_SEND_PTP_CMD;
+	mutex_unlock(&adapter->ptp.aq_cmd_lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 4939c219bd18..24081b01fb16 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -6,10 +6,25 @@
 
 #include <linux/ptp_clock_kernel.h>
 
+/* structure used to queue PTP commands for processing */
+struct iavf_ptp_aq_cmd {
+	struct list_head list;
+	enum virtchnl_ops v_opcode;
+	u16 msglen;
+	u8 msg[];
+};
+
 /* fields used for PTP support */
 struct iavf_ptp {
+	wait_queue_head_t phc_time_waitqueue;
 	struct virtchnl_ptp_caps hw_caps;
+	struct list_head aq_cmds;
+	/* Lock protecting access to the AQ command list */
+	struct mutex aq_cmd_lock;
+	u64 cached_phc_time;
+	unsigned long cached_phc_updated;
 	bool initialized;
+	bool phc_time_ready;
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 };
@@ -18,5 +33,6 @@ void iavf_ptp_init(struct iavf_adapter *adapter);
 void iavf_ptp_release(struct iavf_adapter *adapter);
 void iavf_ptp_process_caps(struct iavf_adapter *adapter);
 bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap);
+void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter);
 
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a75a9cf46591..4163dfe90b4a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1532,6 +1532,63 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
 				  VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2);
 }
 
+/**
+ * iavf_virtchnl_send_ptp_cmd - Send one queued PTP command
+ * @adapter: adapter private structure
+ *
+ * De-queue one PTP command request and send the command message to the PF.
+ * Clear IAVF_FLAG_AQ_SEND_PTP_CMD if no more messages are left to send.
+ */
+void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter)
+{
+	struct device *dev = &adapter->pdev->dev;
+	struct iavf_ptp_aq_cmd *cmd;
+	int err;
+
+	if (WARN_ON(!adapter->ptp.initialized)) {
+		/* This shouldn't be possible to hit, since no messages should
+		 * be queued if PTP is not initialized.
+		 */
+		adapter->aq_required &= ~IAVF_FLAG_AQ_SEND_PTP_CMD;
+		return;
+	}
+
+	mutex_lock(&adapter->ptp.aq_cmd_lock);
+	cmd = list_first_entry_or_null(&adapter->ptp.aq_cmds,
+				       struct iavf_ptp_aq_cmd, list);
+	if (!cmd) {
+		/* no further PTP messages to send */
+		adapter->aq_required &= ~IAVF_FLAG_AQ_SEND_PTP_CMD;
+		goto out_unlock;
+	}
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(dev, "Cannot send PTP command %d, command %d pending\n",
+			cmd->v_opcode, adapter->current_op);
+		goto out_unlock;
+	}
+
+	err = iavf_send_pf_msg(adapter, cmd->v_opcode, cmd->msg, cmd->msglen);
+	if (!err) {
+		/* Command was sent without errors, so we can remove it from
+		 * the list and discard it.
+		 */
+		list_del(&cmd->list);
+		kfree(cmd);
+	} else {
+		/* We failed to send the command, try again next cycle */
+		dev_warn(dev, "Failed to send PTP command %d\n", cmd->v_opcode);
+	}
+
+	if (list_empty(&adapter->ptp.aq_cmds))
+		/* no further PTP messages to send */
+		adapter->aq_required &= ~IAVF_FLAG_AQ_SEND_PTP_CMD;
+
+out_unlock:
+	mutex_unlock(&adapter->ptp.aq_cmd_lock);
+}
+
 /**
  * iavf_print_link_message - print link up or down
  * @adapter: adapter structure
@@ -2103,6 +2160,39 @@ static void iavf_activate_fdir_filters(struct iavf_adapter *adapter)
 		adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
 }
 
+/**
+ * iavf_virtchnl_ptp_get_time - Respond to VIRTCHNL_OP_1588_PTP_GET_TIME
+ * @adapter: private adapter structure
+ * @data: the message from the PF
+ * @len: length of the message from the PF
+ *
+ * Handle the VIRTCHNL_OP_1588_PTP_GET_TIME message from the PF. This message
+ * is sent by the PF in response to the same op as a request from the VF.
+ * Extract the 64bit nanoseconds time from the message and store it in
+ * cached_phc_time. Then, notify any thread that is waiting for the update via
+ * the wait queue.
+ */
+static void iavf_virtchnl_ptp_get_time(struct iavf_adapter *adapter,
+				       void *data, u16 len)
+{
+	struct virtchnl_phc_time *msg;
+
+	if (len == sizeof(*msg)) {
+		msg = (struct virtchnl_phc_time *)data;
+	} else {
+		dev_err_once(&adapter->pdev->dev,
+			     "Invalid VIRTCHNL_OP_1588_PTP_GET_TIME from PF. Got size %u, expected %zu\n",
+			     len, sizeof(*msg));
+		return;
+	}
+
+	adapter->ptp.cached_phc_time = msg->time;
+	adapter->ptp.cached_phc_updated = jiffies;
+	adapter->ptp.phc_time_ready = true;
+
+	wake_up(&adapter->ptp.phc_time_waitqueue);
+}
+
 /**
  * iavf_virtchnl_completion
  * @adapter: adapter structure
@@ -2513,6 +2603,9 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		/* process any state change needed due to new capabilities */
 		iavf_ptp_process_caps(adapter);
 		break;
+	case VIRTCHNL_OP_1588_PTP_GET_TIME:
+		iavf_virtchnl_ptp_get_time(adapter, msg, msglen);
+		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		iavf_irq_enable(adapter, true);
-- 
2.38.1


