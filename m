Return-Path: <netdev+bounces-277288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJX9HOWr2GlPgwgAu9opvQ
	(envelope-from <netdev+bounces-277288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:51:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A713D3988
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03B4030131C4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3653A5428;
	Fri, 10 Apr 2026 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUjPmbQK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA243332EBC
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807368; cv=none; b=r12RRACpvy5rqb2hMf595M1ILnuC880B4IGZMYWdd8kTt79VicRIBQcBABTD5wuaK4Eslfd73DyY+wMXKLS2F8TrfPaNfou//N4rDm7VpdJc7+VL+4tAKwNUtxqt82U9EB6gXfwACVwiBN/s98vFni+rOha6EdBW85iR6hPXJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807368; c=relaxed/simple;
	bh=76l1DpkeYFYQbHgxmmAEoNFOKiq3yLo1D4+eNocGcQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5QTEhpwQgSUJ3aDX9ZP74p+kP7Mi/m1Ow1xaQXDomz3lwk/uA7kxm40JyNbALUf8qjvx6oozdQwQLw/TZRYB1jC/Iqu6pgaUzkNAKcbZcLCDBB+EI+qwHT0btixIDcjEfPBAkoJufu38b4PmdMN2mbkBRzfUc3699UxnoYlrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUjPmbQK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807368; x=1807343368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76l1DpkeYFYQbHgxmmAEoNFOKiq3yLo1D4+eNocGcQQ=;
  b=dUjPmbQKVwCk2D/e0JEdwAASFbMnGumxOZszoWHLtcLLyyCAnVrmCTFc
   qtNokuxjPN3B24hUrJM+vJgyVuA3wgK74NEOEb6ryejh+qzfXbmu+pPLF
   RgLaNDlGtbXBKtLAfBbXEmFjCIcsKSis5VVaqMc0SlsbOIyi09ZqIzRHZ
   OtNWf8yYVYi+5cz+GBGHpjFwG1uCpED9T83N0jYNw016N4+n3EP5SVD1T
   szOcO0Lp0WYUEOqsEZl5rWBhIHRWsNKCRp/vAVOHKVpW4zRIjtCcmxrIK
   80c/UhwhpDws+QA5iXVDpUTyrm+YJZ1NoTL6W33dzF/4ssGHsPHQJprhy
   A==;
X-CSE-ConnectionGUID: yk1jWA2nRZCscPO+D+ivaw==
X-CSE-MsgGUID: SvC+bjoRT1epJ3vcgHY/kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007922"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007922"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:27 -0700
X-CSE-ConnectionGUID: BGghsdzWSX+egzL449Q2nw==
X-CSE-MsgGUID: aznF2ibFQ+6jUPvJqzkiFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941857"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:26 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next 2/10] ice: allow setting advertised speed and duplex for all media types
Date: Fri, 10 Apr 2026 09:49:13 +0200
Message-ID: <20260410074921.1254213-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277288-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9A713D3988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

When AUI media type support was added, the set of media types that
support configuring speed and duplex via autonegotiation was not
updated. This results in AUI media types being rejected when the user
sets speed and duplex via ethtool.

Fix this by only refusing media type NONE or UNKNOWN (in strict mode);
all other media types should support setting speed and duplex.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 17 +++++++++++------
 drivers/net/ethernet/intel/ice/ice_type.h    |  2 ++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b5a63b1..96ce6b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2217,6 +2217,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	u8 autoneg_changed = 0;
 	u64 phy_type_high = 0;
 	u64 phy_type_low = 0;
+	bool lenient_mode;
 	bool linkup;
 	int err;
 
@@ -2225,10 +2226,14 @@ ice_set_link_ksettings(struct net_device *netdev,
 	if (!pi)
 		return -EIO;
 
-	if (pi->phy.media_type != ICE_MEDIA_BASET &&
-	    pi->phy.media_type != ICE_MEDIA_FIBER &&
-	    pi->phy.media_type != ICE_MEDIA_BACKPLANE &&
-	    pi->phy.media_type != ICE_MEDIA_DA &&
+	lenient_mode = test_bit(ICE_FLAG_LINK_LENIENT_MODE_ENA, pf->flags);
+
+	/* Setting the speed and duplex advertised by autonegotiation is
+	 * supported for all media types, so only return unsupported for media
+	 * type none or unknown in strict mode.
+	 */
+	if ((pi->phy.media_type == ICE_MEDIA_NONE ||
+	     (pi->phy.media_type == ICE_MEDIA_UNKNOWN && !lenient_mode)) &&
 	    pi->phy.link_info.link_info & ICE_AQ_LINK_UP)
 		return -EOPNOTSUPP;
 
@@ -2258,7 +2263,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	if (!bitmap_subset(copy_ks.link_modes.advertising,
 			   safe_ks.link_modes.supported,
 			   __ETHTOOL_LINK_MODE_MASK_NBITS)) {
-		if (!test_bit(ICE_FLAG_LINK_LENIENT_MODE_ENA, pf->flags))
+		if (!lenient_mode)
 			netdev_info(netdev, "The selected speed is not supported by the current media. Please select a link speed that is supported by the current media.\n");
 		err = -EOPNOTSUPP;
 		goto done;
@@ -2359,7 +2364,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 		 * intersect the requested advertised speed with NVM media type
 		 * PHY types.
 		 */
-		if (test_bit(ICE_FLAG_LINK_LENIENT_MODE_ENA, pf->flags)) {
+		if (lenient_mode) {
 			config.phy_type_high = cpu_to_le64(phy_type_high) &
 					       pf->nvm_phy_type_hi;
 			config.phy_type_low = cpu_to_le64(phy_type_low) &

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -151,6 +151,8 @@ enum ice_media_type {
 	ICE_MEDIA_UNKNOWN = 0,
 	ICE_MEDIA_FIBER,
 	ICE_MEDIA_BASET,
 	ICE_MEDIA_BACKPLANE,
 	ICE_MEDIA_DA,
+	ICE_MEDIA_AUI,
+	ICE_MEDIA_NONE,
 };
-- 
2.52.0

