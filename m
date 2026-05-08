Return-Path: <netdev+bounces-285594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MoaIQhV/WkYawAAu9opvQ
	(envelope-from <netdev+bounces-285594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:14:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE364F10A3
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC203018743
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3732D63E5;
	Fri,  8 May 2026 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hT1pGLjn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41B2D2496
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209960; cv=none; b=ICdRP0UNOLDRUnv2uF6BhgIXiQc7EZmznCjz6Mm7V4nFVPSKsvpyUDlo948Idjhdb8BMLlR9moXv6B7IZSvbKi4iAbWo0LFyZKGTRsdaDi/7+GrjUJUgGVkbaZ07+ngBn1IW84qs/6Z9jHpEZUNUYswE7B1DwJrbXD15BjAxVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209960; c=relaxed/simple;
	bh=CBKMlV60ZbulVgXwKgQt5VEkfWvqAFPvIP4/ufqNnDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG3htcru3eW3C29QdNgRj8WvXTZp8pxR5UhfPW7ACAFEXfDmiLxyB8NaVn/RtnkYS2CSsyNMGq7IS+3j4HKXarM7UAo30JLf4KZ+g5cv36gnTXcMXM3GF1p9N568y+ZbZogrGI13a9T9f8I9XfnZuVKBUhAQKrTkk9DcJ0AjBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hT1pGLjn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778209959; x=1809745959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CBKMlV60ZbulVgXwKgQt5VEkfWvqAFPvIP4/ufqNnDs=;
  b=hT1pGLjnP+oUVkSZHmXkTMRfWtgJxUNYWRbyyG3Q6l9NztM0qRJ34uqI
   IlZNVgl49wR6ZdEuwLoPKu+4TcaDYFSufYPEA4e0r1DnwlIzAIATDR+95
   RisvRF7571xX7E21Pd4bekALlR6UyrzeCiJWISlAMVctst/C+gHXncG3I
   q0hB6kYZG1/kgyKwp6UPTZibIhUyoLyUQRomtz5e3vPkktYDcHWLLEi3g
   CFVJuvo+sICdRBYmjyKzN/Faq3t0EJ5vxUcyeBNiN3+yz7sWAfLiv2WXa
   wj4dU+VIjlIRp+8ASvaJ6ua1SNuKmaWz0gSE+/eKiSsg21PjpBKj6sRKj
   g==;
X-CSE-ConnectionGUID: QOc83e+AQbidYngNTCVsGw==
X-CSE-MsgGUID: YPyxYfZ8RGGMY/gaeZEdYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027512"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="79027512"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:12:38 -0700
X-CSE-ConnectionGUID: nofhen9zRsOgobpEuWrsaA==
X-CSE-MsgGUID: 3ivrJew4TH2fPViGhX0S6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="241623210"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 6/8] ixgbe: extract ixgbe_restart_auto_neg() to avoid code duplication
Date: Fri,  8 May 2026 05:12:24 +0200
Message-ID: <20260508031226.3601800-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EAE364F10A3
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285594-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jakub Chylkowski <jakubx.chylkowski@intel.com>

Both ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx()
end with the same three-line sequence that reads MDIO_CTRL1, sets
the MDIO_AN_CTRL1_RESTART bit, and writes MDIO_CTRL1 back.

Factor it out into a static helper ixgbe_restart_auto_neg() and call
it from both sites.

While at it, also check the return value of phy.ops.read_reg() in the
helper and skip the write on failure.  The original inlined code
ignored the read result and would OR MDIO_AN_CTRL1_RESTART into a
stale autoneg_reg value (left over from the prior MDIO_AN_ADVERTISE
write) and unconditionally write it back to MDIO_CTRL1 if the read
failed.  This is a small behavioral change: on read_reg() failure the
restart write is now skipped instead of being issued with a
potentially garbage value.

Signed-off-by: Jakub Chylkowski <jakubx.chylkowski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 36 ++++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index de8f6c6..c7387a4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1089,6 +1089,26 @@ int ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	return mdiobus_register(bus);
 }
 
+/**
+ * ixgbe_restart_auto_neg - restart PHY autonegotiation
+ * @hw: pointer to hardware structure
+ *
+ * Sets the restart autoneg bit in MDIO_CTRL1 to trigger a new
+ * autonegotiation cycle.
+ **/
+static void ixgbe_restart_auto_neg(struct ixgbe_hw *hw)
+{
+	u16 autoneg_reg;
+	int status;
+
+	status = hw->phy.ops.read_reg(hw, MDIO_CTRL1, MDIO_MMD_AN,
+				      &autoneg_reg);
+	if (status)
+		return;
+	autoneg_reg |= MDIO_AN_CTRL1_RESTART;
+	hw->phy.ops.write_reg(hw, MDIO_CTRL1, MDIO_MMD_AN, autoneg_reg);
+}
+
 /**
  *  ixgbe_setup_phy_link_generic - Set and restart autoneg
  *  @hw: pointer to hardware structure
@@ -1156,13 +1176,7 @@ int ixgbe_setup_phy_link_generic(struct ixgbe_hw *hw)
 		return 0;
 
 	/* Restart PHY autonegotiation and wait for completion */
-	hw->phy.ops.read_reg(hw, MDIO_CTRL1,
-			     MDIO_MMD_AN, &autoneg_reg);
-
-	autoneg_reg |= MDIO_AN_CTRL1_RESTART;
-
-	hw->phy.ops.write_reg(hw, MDIO_CTRL1,
-			      MDIO_MMD_AN, autoneg_reg);
+	ixgbe_restart_auto_neg(hw);
 
 	return status;
 }
@@ -1386,13 +1400,7 @@ int ixgbe_setup_phy_link_tnx(struct ixgbe_hw *hw)
 		return 0;
 
 	/* Restart PHY autonegotiation and wait for completion */
-	hw->phy.ops.read_reg(hw, MDIO_CTRL1,
-			     MDIO_MMD_AN, &autoneg_reg);
-
-	autoneg_reg |= MDIO_AN_CTRL1_RESTART;
-
-	hw->phy.ops.write_reg(hw, MDIO_CTRL1,
-			      MDIO_MMD_AN, autoneg_reg);
+	ixgbe_restart_auto_neg(hw);
 	return 0;
 }
 
-- 
2.52.0


