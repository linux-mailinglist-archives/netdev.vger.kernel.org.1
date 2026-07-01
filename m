Return-Path: <netdev+bounces-303834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NpseAACCRWpkBQsAu9opvQ
	(envelope-from <netdev+bounces-303834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:09:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E46F1C08
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:09:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=bcijR4qz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303834-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303834-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C1CF30C5539
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668293A3E76;
	Wed,  1 Jul 2026 21:03:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699639F174
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939804; cv=none; b=sjw9d+bZzXgx4wc5t0rFNRDxG5s3hodqJbkbvqhqeG7Vzjkg95nEM3UKcm9ZAkLwloqSkQZZ5J4BnseFh3/1O0wVtNffmBxZrvSvQFlUDjRPJ9Uk+wNLUFsZhVJ8kP3kxd/rb6LVm3qEFq8yfUvxdIX1SdWFAHuPPBuFVydQh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939804; c=relaxed/simple;
	bh=STzjPCVK3r55Yks0ZpXjq/RjnG190j4D4tXpmbc83eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq2zrva0tl9YdQ1lW4Jt9tpyhBEmziF/GOIowGiQunAigEAZgnYMmNyX1QvkVM+yiSWgyX2RuOoweAdEoer91/52n+jmZPjaFcNAWFMZrcVvBCx0vWKzWrBG2Yam8mV6PdNST3PN8VBBwX3nvSz3B0kKXyZWqahRGIEEdx9Ogi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcijR4qz; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939798; x=1814475798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=STzjPCVK3r55Yks0ZpXjq/RjnG190j4D4tXpmbc83eY=;
  b=bcijR4qzmVLQLz6nvrg7Vl3vVfSzGHYy0+5KEnRlDzf69Z7z2xS0KbVt
   zWLKfD0Y75hM+ySonVLNUG4d09Q6YwNyAxcW0nmJRkNRL1S0HvO0Srns6
   fOkShHNArYiaWiCodVBzdpa/MaAinZ5FI90QOoNyRG03dEJ7nEqaPSO0A
   pb9P9Bsmc4eHWOJPo7MG4jw634Go1KwVU2kC5KyowVXWqMzJDTfr96z9f
   SOcFhXQAT54BnA+W9NxXBFrDvJfzHO+Cz3vaZgNUA7oD9vA9xzIwZQ4fa
   cqNtuHDwKbbpGMzja84q6dawCEb5oSF/4rqLOdoGhzt2z8Q5Xbi8adBaZ
   Q==;
X-CSE-ConnectionGUID: KsU/nLq3TgC7mF937MthAA==
X-CSE-MsgGUID: cUwLM9vzQ6uL1gdoF1VsYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069153"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069153"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:14 -0700
X-CSE-ConnectionGUID: 0vxM/oIsTWq1oC03f5mRBw==
X-CSE-MsgGUID: GlpO+jExTpu8t+lWo1jAew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561431"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	khai.wen.tan@intel.com,
	khai.wen.tan@linux.intel.com,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	hector.blanco.alcaine@intel.com,
	dima.ruinskiy@intel.com,
	Simon Horman <horms@kernel.org>,
	Moriya Kadosh <moriyax.kadosh@intel.com>
Subject: [PATCH net-next 10/11] igc: replace goto out with direct returns in igc_config_fc_after_link_up()
Date: Wed,  1 Jul 2026 14:02:59 -0700
Message-ID: <20260701210303.1745310-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303834-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:faizal.abdul.rahim@linux.intel.com,m:anthony.l.nguyen@intel.com,m:khai.wen.tan@intel.com,m:khai.wen.tan@linux.intel.com,m:faizal.abdul.rahim@intel.com,m:hong.aun.looi@intel.com,m:hector.blanco.alcaine@intel.com,m:dima.ruinskiy@intel.com,m:horms@kernel.org,m:moriyax.kadosh@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 217E46F1C08

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

The out: label only returns ret_val with no cleanup. The kernel coding
style guide states: "If there is no cleanup needed then just return
directly." (Documentation/process/coding-style.rst, section 7).

This improves readability ahead of a subsequent patch that introduces a
new goto label in this function.

No functional change.

Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 142beb9ae557..0a3d3f357505 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -458,15 +458,15 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
 				       &mii_status_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
 				       &mii_status_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 
 	if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
 		hw_dbg("Copper PHY and Auto Neg has not completed.\n");
-		goto out;
+		return ret_val;
 	}
 
 	/* The AutoNeg process has completed, so we now need to
@@ -478,11 +478,11 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->phy.ops.read_reg(hw, PHY_AUTONEG_ADV,
 				       &mii_nway_adv_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	ret_val = hw->phy.ops.read_reg(hw, PHY_LP_ABILITY,
 				       &mii_nway_lp_ability_reg);
 	if (ret_val)
-		goto out;
+		return ret_val;
 	/* Two bits in the Auto Negotiation Advertisement Register
 	 * (Address 4) and two bits in the Auto Negotiation Base
 	 * Page Ability Register (Address 5) determine flow control
@@ -598,7 +598,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
 	if (ret_val) {
 		hw_dbg("Error getting link speed and duplex\n");
-		goto out;
+		return ret_val;
 	}
 
 	if (duplex == HALF_DUPLEX)
@@ -610,10 +610,9 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	ret_val = igc_force_mac_fc(hw);
 	if (ret_val) {
 		hw_dbg("Error forcing flow control settings\n");
-		goto out;
+		return ret_val;
 	}
 
-out:
 	return ret_val;
 }
 
-- 
2.47.1


