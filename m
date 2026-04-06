Return-Path: <netdev+bounces-275754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMoEOBom1Gn5rgcAu9opvQ
	(envelope-from <netdev+bounces-275754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:31:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15B3A78C3
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF5BC301F283
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114339185D;
	Mon,  6 Apr 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpOQ7KpS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3F390215
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511048; cv=none; b=bQkZZcyZz3V4fbZESKmLt7vhSO3W1Lvwcs3QRUmor0Q83A7YLuKpTSYZN7mvmjqbqcZrpToYOiNbGKLDbVq9vIVPxpjVB89TTkwGphVq8bxDEwvxpWmvlvKHOfMp5cdBCvdjY3ctJqp1TP/AiNRaM/akQTeSP4CLwY3x6y8hYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511048; c=relaxed/simple;
	bh=BBwjgRdaqANREThw2MhZ2ChLB2tk9qMkoLA5ZQTZyf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqlyb+hfshx+J7A2RTecWmVkc7t0QX8Qj49cIt4BlZxuQygqzOoDTQwQEeDz5ni26bS4vZs32Orrc/6xkQGTC4+W2xSpvUMnCf/sA2AW1s6B56/Yyp6kkrGPs2vUNMAQVqe/slCm7E9hYVS5TBk/rZecgw3miqbShJSLoWxIfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpOQ7KpS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775511047; x=1807047047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBwjgRdaqANREThw2MhZ2ChLB2tk9qMkoLA5ZQTZyf0=;
  b=TpOQ7KpSL0nplwQ6zoXZjhIZbs4KtOIczZ3nrWZhcZm7PmCEvhEJ+MtP
   Bg48+XtYkzXLs7pmiQk8cnrfDKeqLE5oezQzJv5XOayvN5gAO9pPPaT63
   cjoww39/L36JzBl31n4koX10QdpRqxfgHeSbQ/tIW72ZVjjElFherW9Tp
   uQqJey0HL2Srl2yWCtqn9MRSwF0tMopVb6112MoOso8up9finf+B4hH2k
   gQc6DhG8eEU/LqsBTG4UeNlr8I/6Rf84X2Y3SRLiCQKfKkmGbxHmblB2j
   AkXjBIReaeqPdWJBa5dKQPdmPgHfiuNw94SggyNmp8bFX98PGVZK9RBd+
   Q==;
X-CSE-ConnectionGUID: u4xDLCb1Q6+dEmsfwvEepw==
X-CSE-MsgGUID: vU5XjGAQTVSVpM3ST9rOYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79057429"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="79057429"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 14:30:42 -0700
X-CSE-ConnectionGUID: e1Wc+tVgTb+ixZ5vVbDVqQ==
X-CSE-MsgGUID: xe5PDSMUS2K/74gNIUe7Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="228248117"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2026 14:30:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	Xiaoqiang Xiong <xxiong@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 7/9] ixgbevf: add missing negotiate_features op to Hyper-V ops table
Date: Mon,  6 Apr 2026 14:30:34 -0700
Message-ID: <20260406213038.444732-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
References: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275754-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F15B3A78C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Schmidt <mschmidt@redhat.com>

Commit a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by
negotiating supported features") added the .negotiate_features callback
to ixgbe_mac_operations and populated it in ixgbevf_mac_ops, but forgot
to add it to ixgbevf_hv_mac_ops. This leaves the function pointer NULL
on Hyper-V VMs.

During probe, ixgbevf_negotiate_api() calls ixgbevf_set_features(),
which unconditionally dereferences hw->mac.ops.negotiate_features().
On Hyper-V this results in a NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  [...]
  Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine [...]
  Workqueue: events work_for_cpu_fn
  RIP: 0010:0x0
  [...]
  Call Trace:
   ixgbevf_negotiate_api+0x66/0x160 [ixgbevf]
   ixgbevf_sw_init+0xe4/0x1f0 [ixgbevf]
   ixgbevf_probe+0x20f/0x4a0 [ixgbevf]
   local_pci_probe+0x50/0xa0
   work_for_cpu_fn+0x1a/0x30
   [...]

Add ixgbevf_hv_negotiate_features_vf() that returns -EOPNOTSUPP and
wire it into ixgbevf_hv_mac_ops. The caller already handles -EOPNOTSUPP
gracefully.

Fixes: a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by negotiating supported features")
Reported-by: Xiaoqiang Xiong <xxiong@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-155455
Assisted-by: Claude:claude-4.6-opus-high Cursor
Tested-by: Xiaoqiang Xiong <xxiong@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index b67b580f7f1c..f6df86d124b9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -709,6 +709,12 @@ static int ixgbevf_negotiate_features_vf(struct ixgbe_hw *hw, u32 *pf_features)
 	return err;
 }
 
+static int ixgbevf_hv_negotiate_features_vf(struct ixgbe_hw *hw,
+					    u32 *pf_features)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
  *  @hw: pointer to the HW structure
@@ -1142,6 +1148,7 @@ static const struct ixgbe_mac_operations ixgbevf_hv_mac_ops = {
 	.setup_link		= ixgbevf_setup_mac_link_vf,
 	.check_link		= ixgbevf_hv_check_mac_link_vf,
 	.negotiate_api_version	= ixgbevf_hv_negotiate_api_version_vf,
+	.negotiate_features	= ixgbevf_hv_negotiate_features_vf,
 	.set_rar		= ixgbevf_hv_set_rar_vf,
 	.update_mc_addr_list	= ixgbevf_hv_update_mc_addr_list_vf,
 	.update_xcast_mode	= ixgbevf_hv_update_xcast_mode,
-- 
2.47.1


