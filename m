Return-Path: <netdev+bounces-281630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KbsoEU1E8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E047D876
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 251833004CB7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A72F12C5;
	Tue, 28 Apr 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gu6y5Jem"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036321419A4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353799; cv=none; b=TICbO+6pQTGME0991CLXuKBuLU8DIDpgOwPDpWYLFAQVbA0H/yGZTqRE4uq0f0laOPNWwlPSRfEpdEHMukG34/qTeGTWYlHNhRF3ibVgQUUfl0hsu4PD7l2bXwxwOyDRvfUBJK3rle90PdaUyIlek0SvFeY8DeOai6xoeRRqAb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353799; c=relaxed/simple;
	bh=QuKwCGamYpEK7cQfu5b6x15fzmgUbzw/E2D0XPX9524=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYA9vX/c+xhbPCkG97/L7En8CvrlzQHDAwhWAYH67cIJjAHeLulrx0uePwtmm/bqfI9uLMhk7sQ7HiIYQckX0yf9VmulR1k9uutmHpW2yG2lxiSYM8qVnmzfHD00K1K+XdhApN8FlqTRucS35WFNQlyYbf4ZAV45J6lMWE+H+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gu6y5Jem; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353797; x=1808889797;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QuKwCGamYpEK7cQfu5b6x15fzmgUbzw/E2D0XPX9524=;
  b=gu6y5JemjswQjeBjtlLIBrF/wWh2tKXhgXvQVFFokJFMzrycDcecHZ5e
   jDHOPIV0lvdUetzvlXTdLOuF/1CEz38b97MD/SkP3LmUWgAwg3KVO3k55
   nwjJHrnXq0jLzP+GBh//BvBhmLPjJXP2YN/+kF+IzcPvXWEyfIvPAy5zo
   4tWIlB1x7vSHfhHysy9VJqq8b+Byl+juJ0ZtXHa/3HPbLmot2N7wZ0sz8
   fzzK/sP5sl/7Ga64kJ6LkU31HvxRSbkCd6k1G5B3IJaEryqCN+7ylbBmQ
   bSCBtXWLrMie1TNoleq4v8FLxdqG3HOE2gtlyul4ZOGRRzByopG63zKEZ
   Q==;
X-CSE-ConnectionGUID: lVN/WbebT9eJ2VatC01EVg==
X-CSE-MsgGUID: QutJTOeZSRO2ExW455GN3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910510"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910510"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:15 -0700
X-CSE-ConnectionGUID: /0XZMdskQnmyb48Zmt1ZdQ==
X-CSE-MsgGUID: vJClCeAzT9yHHsJFcTi68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800194"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:13 -0700
Subject: [PATCH net 01/11] iavf: rename IAVF_VLAN_IS_NEW to
 IAVF_VLAN_ADDING
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-1-cdcb48303fd8@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=1dV4HnIgJi3D9ZSa6z/IljWWPU1eCfyMNh20rGqI6yU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLg5vg7stJv8pNn15tPhMr5DlFj+f1iMOJf84LKeke
 hzsNlzSUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwESiYhj+e7ccui9zvffd7K0e
 JRq/T01eHf/qXVOTxO2Y3RILDdI0+hn+aYXNz+8+1RaX8+3HzLyXhTMEdJiTWGbcvSu+u+d+uJc
 LIwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 1B9E047D876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281630-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Petr Oros <poros@redhat.com>

Rename the IAVF_VLAN_IS_NEW state to IAVF_VLAN_ADDING to better
describe what the state represents: an ADD request has been sent to
the PF and is waiting for a response.

This is a pure rename with no behavioral change, preparing for a
cleanup of the VLAN filter state machine.

Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h          | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index e9fb0a0919e3..47a862ca5e2c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -158,7 +158,7 @@ struct iavf_vlan {
 enum iavf_vlan_state_t {
 	IAVF_VLAN_INVALID,
 	IAVF_VLAN_ADD,		/* filter needs to be added */
-	IAVF_VLAN_IS_NEW,	/* filter is new, wait for PF answer */
+	IAVF_VLAN_ADDING,	/* ADD sent to PF, waiting for response */
 	IAVF_VLAN_ACTIVE,	/* filter is accepted by PF */
 	IAVF_VLAN_DISABLE,	/* filter needs to be deleted by PF, then marked INACTIVE */
 	IAVF_VLAN_INACTIVE,	/* filter is inactive, we are in IFF_DOWN */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a52c100dcbc5..6b06ae872a0c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -746,7 +746,7 @@ static void iavf_vlan_add_reject(struct iavf_adapter *adapter)
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
-		if (f->state == IAVF_VLAN_IS_NEW) {
+		if (f->state == IAVF_VLAN_ADDING) {
 			list_del(&f->list);
 			kfree(f);
 			adapter->num_vlan_filters--;
@@ -812,7 +812,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 			if (f->state == IAVF_VLAN_ADD) {
 				vvfl->vlan_id[i] = f->vlan.vid;
 				i++;
-				f->state = IAVF_VLAN_IS_NEW;
+				f->state = IAVF_VLAN_ADDING;
 				if (i == count)
 					break;
 			}
@@ -874,7 +874,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 				vlan->tpid = f->vlan.tpid;
 
 				i++;
-				f->state = IAVF_VLAN_IS_NEW;
+				f->state = IAVF_VLAN_ADDING;
 			}
 		}
 
@@ -2910,7 +2910,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 
 		spin_lock_bh(&adapter->mac_vlan_list_lock);
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
-			if (f->state == IAVF_VLAN_IS_NEW)
+			if (f->state == IAVF_VLAN_ADDING)
 				f->state = IAVF_VLAN_ACTIVE;
 		}
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);

-- 
2.54.0.rc2.531.gaf818d63126a


