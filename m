Return-Path: <netdev+bounces-266015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFmkL078r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:11:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814E24A08E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAA9F30048F3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B173803CD;
	Tue, 10 Mar 2026 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4dR1RZI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F792D978B
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140744; cv=none; b=hbNaU/Vrcqijt2HcRFZFXmB7NR1PAfv9BIQKwjZL+QAAGlPywQL73Z8uJ75RFfFsywsC0s68P7B6bBmH4Q6zbs9Ra6aWpyKZBNRSpSJy6xYt65GqMQ4e/crGZBua5zGuuNjSgyiPraFzRWMlQK5bF2FhOHh72FbLOsDgOMTI56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140744; c=relaxed/simple;
	bh=N1yevfBzWeOgVxt0F8Q44T2B0T9lvIlOBDPrD3TIn5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1QdPG7CshNcyNVrb4gLjdfjac8hqkaG+4DfyoOG8g4acw/pqJpwNGw7An/IJ3rmC1DagjU239qO/qNtfQrBxJXkDExbAk0RZavt2kR0sn3qRJCf0uL3Rv34cjHVXFqa9ZoNy3z3ToECyJKsXSOdLsFAQH/J8ryAg1nnybAv/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4dR1RZI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773140743; x=1804676743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N1yevfBzWeOgVxt0F8Q44T2B0T9lvIlOBDPrD3TIn5Q=;
  b=N4dR1RZIjq9h+8unjmP4gM23Wk/ycF50phQwq9wb4pQevjPIxgv1z6rF
   jsewkipJCCmsPLkKTyCJNVYruT+aGE+aqjFzPge6MLIDapc/D5as9KM0y
   XR/gddLOlVbYxwltdy7swto+nZnNDL+rTZHPki553LRTAF/3JPyutqDuj
   OW8zPrd/a4WhXnu4xxCWIh/GNDjJxqeKS+lyfaCms01lubvOcMmvtikpk
   8fvetMmJzAloOyt6QA+b2ieGdcKWn5qgekyTUFBtiPCmO9rNMM65/ebIo
   i+1Eu7K2m7qrY4FTTr8uQfmJ6gOmR/JEIOR8oQFnRBA41jJxK5ST6SinV
   w==;
X-CSE-ConnectionGUID: mMs3n65tSDmj8NFNN+vZiQ==
X-CSE-MsgGUID: vLfM7M5/QzyCpAvVW5RaWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74225162"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74225162"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:05:42 -0700
X-CSE-ConnectionGUID: q5hBKdgiRICkSRCkORz+KQ==
X-CSE-MsgGUID: 4npV0y24R6ukVATqs35T0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216461242"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa006.fm.intel.com with ESMTP; 10 Mar 2026 04:05:41 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net] ice: fix posted write support for sideband queue operations
Date: Tue, 10 Mar 2026 12:06:33 +0100
Message-ID: <20260310110700.345904-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3814E24A08E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266015-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msg.data:url]
X-Rspamd-Action: no action

On E830, PTP time adjustment commands sent via
SBQ don't generate completion responses, causing the driver to
timeout waiting and return -EIO, when trying:

phc_ctl eth8 get adj 2 get
dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5

Add support for posted mode not to wait for completion response.

Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c   | 7 ++++++-
 drivers/net/ethernet/intel/ice/ice_controlq.c | 4 ++++
 drivers/net/ethernet/intel/ice/ice_controlq.h | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8866902efb91..df9e5422b981 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1765,6 +1765,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 {
 	struct ice_sbq_cmd_desc desc = {0};
 	struct ice_sbq_msg_req msg = {0};
+	struct ice_sq_cd cd = {0};
 	u16 msg_len;
 	int status;
 
@@ -1785,10 +1786,14 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 		 */
 		msg_len -= sizeof(msg.data);
 
+	if (in->opcode == ice_sbq_msg_wr)
+		cd.postpone = 1;
+
 	desc.flags = cpu_to_le16(flags);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
-	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
+	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, &cd);
+
 	if (!status && !in->opcode)
 		in->data = le32_to_cpu
 			(((struct ice_sbq_msg_cmpl *)&msg)->data);
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index dcb837cadd18..5fb3a8441beb 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1086,6 +1086,10 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	wr32(hw, cq->sq.tail, cq->sq.next_to_use);
 	ice_flush(hw);
 
+	/* If the message is posted, don't wait for completion. */
+	if (cd && cd->postpone)
+		goto sq_send_command_error;
+
 	/* Wait for the command to complete. If it finishes within the
 	 * timeout, copy the descriptor back to temp.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 788040dd662e..7c98d3a0314e 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -77,6 +77,7 @@ struct ice_ctl_q_ring {
 /* sq transaction details */
 struct ice_sq_cd {
 	struct libie_aq_desc *wb_desc;
+	u8 postpone : 1;
 };
 
 /* rq event information */

base-commit: acd2abc52dea91c3bc3d1b6dd8a92b9631d48bbf
-- 
2.43.0


