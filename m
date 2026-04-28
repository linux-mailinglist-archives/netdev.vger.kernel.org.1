Return-Path: <netdev+bounces-281632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBErB2hE8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7E47D88B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A38303743B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E08E3115AF;
	Tue, 28 Apr 2026 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ynw64qNK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A330F535
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353801; cv=none; b=jaTA5ArL5dVAznSsSdxjVeAfaF8cWbXwtD0aFzQMWKLVKBPxlmCxTGa+2P3ykQ++i5cN0flBzY3BeITpx4SKqf2yk93NYEBp4e5zs9p/5n9z7mecjavjxD5nE1wouSF8deIScBvDu/gf3f6pQzIjlXMXA+NcuTHzklnkpx2SaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353801; c=relaxed/simple;
	bh=0xVyJt1pCyOB7ozvSkHWf6B/16Cegf7cHaqYCEEyn3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4vFkbTtPz/pQdMake0P1yBi3Fjt5rsQWFeKSmLpoUPb9KjY6mIb9aFDV7wZc/iUXgzoyMGf3ieJZj4BbUAHSBNxp8rWPTdc3T1xiEuJhaSnNg3IEmd3VgNJAZRxXlWHjGxAP6aDDExICjS7hZNe16/6o39SMf8XTqeSyvVb8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ynw64qNK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353800; x=1808889800;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0xVyJt1pCyOB7ozvSkHWf6B/16Cegf7cHaqYCEEyn3Y=;
  b=Ynw64qNKU0mdiGZZFZTEIJWld14zOVxkBNIrG7P5FphkW0VJTQHbPthE
   LljqFAjw96sd4ovh5i4KI+8Q7ZhIaXZkCLojzwXYWkGE5ln1o1AwP6mBa
   GdkS89vivWZruVPuN0u5nKdbjEart2WHaTzVzdaMhizEZKs8dBXS8Qaic
   V5i6+gbORhblDv7h3K9qCkCnHQ0dPcKKlvCvsich86bEMHkZGoToc241C
   mfEv4oLRCe8NQ6PyE7F3kFyqH6RBVy32afVKmIUK7B7SwkazlPh2e8K8x
   kwMNRIHxrEiKpcJKEQ1AozKbZfEL1lgFYIWTfA7lI1PED2Pd1E6YVgNrJ
   g==;
X-CSE-ConnectionGUID: vW5myZz4SnmKb2/w6zipAQ==
X-CSE-MsgGUID: aBKitFUyT2WZ67E+qPx3Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910532"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910532"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
X-CSE-ConnectionGUID: 07KAZQYzQ4OpaY5EfCeVkg==
X-CSE-MsgGUID: 0ZAzH66GT8yl/MBUYJkOpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800203"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:16 -0700
Subject: [PATCH net 04/11] iavf: add VIRTCHNL_OP_ADD_VLAN to success
 completion handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-4-cdcb48303fd8@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Xfy2gkIjGYqPlx+9hZpjfXzeXLZC0buEcrhafsHPqwY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLo4BK1gfWEwy3xhVZZj35rW1sbeIYPdaSUvH38s2l
 ys1JX/rKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCLp8Qx/RT4Lf6yZ6NfeHPOf
 LfM1h0HC04T6ws4rO/2a/h1905ThzsiwZcbf/aeWe07m+ul+PLUg++C53CCvte9L265+k72SWLO
 bBQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 77A7E47D88B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Petr Oros <poros@redhat.com>

The V1 ADD_VLAN opcode had no success handler; filters sent via V1
stayed in ADDING state permanently.  Add a fallthrough case so V1
filters also transition ADDING -> ACTIVE on PF confirmation.

Critically, add an `if (v_retval) break` guard: the error switch in
iavf_virtchnl_completion() does NOT return after handling errors,
it falls through to the success switch.  Without this guard, a
PF-rejected ADD would incorrectly mark ADDING filters as ACTIVE,
creating a driver/HW mismatch where the driver believes the filter
is installed but the PF never accepted it.

For V2, this is harmless: iavf_vlan_add_reject() in the error
block already kfree'd all ADDING filters, so the success handler
finds nothing to transition.

Fixes: 968996c070ef ("iavf: Fix VLAN_V2 addition/rejection")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 93ca79c3e3b5..4f2defd2331b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2876,9 +2876,13 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		spin_unlock_bh(&adapter->adv_rss_lock);
 		}
 		break;
+	case VIRTCHNL_OP_ADD_VLAN:
 	case VIRTCHNL_OP_ADD_VLAN_V2: {
 		struct iavf_vlan_filter *f;
 
+		if (v_retval)
+			break;
+
 		spin_lock_bh(&adapter->mac_vlan_list_lock);
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->state == IAVF_VLAN_ADDING)

-- 
2.54.0.rc2.531.gaf818d63126a


