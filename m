Return-Path: <netdev+bounces-290653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMOyI07GD2qJPgYAu9opvQ
	(envelope-from <netdev+bounces-290653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:58:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E97095AE32F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E3A2302D5CE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144C311977;
	Fri, 22 May 2026 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IW0uhXmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A13126AD
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418629; cv=none; b=q4l8lJqwNwVpBAYdgpaqeiP6SQQ9fm50yMkGwPtAogvIKfunJ6s2FzOhOmc1uRM2jogBhZTqEpqQh44LPiowqupMozPMVfZyuOtDs4f9betAyZCe+DVfpMfq0GkFg7P47ZuwKtdLoIGCVI2JUzJIVRj0LH0y33uu6bh4ZLTf8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418629; c=relaxed/simple;
	bh=/bpA+EcRM8jisp5vIwaXJiLrfiq2O03BaisKSzhKiJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJdDAligkVm1355jLEukKCccONFHAEl54p2cTyKEYGeQbaLoC4jIHkpKGtLifBNndUf0Pv0KlO6wrwKs/zo/bHqQfQDebirCRZ2aia4iL9ghYeWCtxMmAKR97fYNmI/PqndBlJbzgjCRdsprqfxR32T5m971vpNr2xDzxAmML0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IW0uhXmQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779418628; x=1810954628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/bpA+EcRM8jisp5vIwaXJiLrfiq2O03BaisKSzhKiJs=;
  b=IW0uhXmQGLJ1STW/VQtRq4hHGi3iR7elGTjZGyMXO94EbDfwiIEIfnnP
   Zcxm7ZYfkq6M7abCJ8wIgWZ5C49q4OTt/jYDy/rV6/5SnC4DQyusF/2PT
   12bMW0u4JB9Tdi7v53ENlWQUNgY8AS0v7+TpVGd9//GPNg/2VMHnCSVOx
   B6KHwM5npHgVjaEQtU0NHtubQr8mpIFJe/zjcZWFI8n/7069GcTFxqJpR
   wSrrfldkNnips8Sck4vV+VVqw/QGI87sYsUQV0eksianhL7Jt55ovZus3
   uRVKhzn46nvtROgLMY0So7lTCAvTD0njCIk4W94EGlQm7aamzYzzdjkG7
   g==;
X-CSE-ConnectionGUID: XZNT1s75Se6UReoCtYLSxQ==
X-CSE-MsgGUID: QCcRy1v5RiK/FLEpIKYTIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105811765"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="105811765"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 19:57:07 -0700
X-CSE-ConnectionGUID: jbutY0gHTY+JeRq6rahV3w==
X-CSE-MsgGUID: otHWT591QXamiUnL5yyTAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="245035654"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 21 May 2026 19:57:08 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 2/2] iavf: log primary MAC address confirmed by PF
Date: Fri, 22 May 2026 04:57:02 +0200
Message-ID: <20260522025702.1764129-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522025702.1764129-1-aleksandr.loktionov@intel.com>
References: <20260522025702.1764129-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290653-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E97095AE32F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Print an informational message in iavf_mac_add_ok() when the PF
confirms the primary MAC filter. This gives operators a clear
confirmation of the active MAC address in dmesg.

Save the confirmed address to a local variable and emit the log after
releasing mac_vlan_list_lock to avoid holding a spinlock across printk.
Print f->macaddr directly rather than adapter->hw.mac.addr: the filter
address is the value the PF actually accepted and is protected by the
held lock, while hw.mac.addr is not.

Suggested-by: Norbert Zulinski <norbertx.zulinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 146fc680..62b0910 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -692,19 +692,31 @@ void iavf_del_ether_addrs(struct iavf_adapter *adapter)
  * iavf_mac_add_ok
  * @adapter: adapter structure
  *
- * Submit list of filters based on PF response.
+ * Mark MAC filters as handled after PF confirms the add request.
+ * Logs the confirmed primary MAC address when applicable.
  **/
 static void iavf_mac_add_ok(struct iavf_adapter *adapter)
 {
 	struct iavf_mac_filter *f, *ftmp;
+	u8 primary_mac[ETH_ALEN] = {};
+	bool log_primary = false;
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
 		f->is_new_mac = false;
-		if (!f->add && !f->add_handled)
+		if (!f->add && !f->add_handled) {
 			f->add_handled = true;
+			if (f->is_primary) {
+				ether_addr_copy(primary_mac, f->macaddr);
+				log_primary = true;
+			}
+		}
 	}
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
+	if (log_primary)
+		netdev_info(adapter->netdev,
+			    "MAC address set to %pM\n", primary_mac);
 }
 
 /**
-- 
2.52.0


