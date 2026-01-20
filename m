Return-Path: <netdev+bounces-251633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLpNKukRcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:38:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6B4DF0B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D8FB467B3
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0723DA7EB;
	Tue, 20 Jan 2026 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhKfpG5W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6E3C008A
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949092; cv=none; b=ndVAPxmjevC8kLCIVDVF4syZPReJ9KpD6dlSxTdl4JVH72PS9ReuB3vCYoyF81Sh+tAMJ4rkrsjrkpMeUdBJ1cLYfJw3ybF0j8CErQZhdei3ScfMdRCJ8hl5Z240MuJDpzLiXk5hwMb0PrpRATRQcsWe1aTo4B4PNt+3ObPNenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949092; c=relaxed/simple;
	bh=Yhs+ocVB5WAnuyvxIX7IZInV1lvZe4TqMwx+zm0tX54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAKwaux4xlejnRPgL7mmSja92sXIa48+uFdnJg4F/kQvkz3KDRf3MMjG++wmBAoV4B1PwIGsRMJbzytm1U3FFfnmTXKQ0v0nxXfRF3Kv+SCwMCtngwDQVC9zHB4MrS5AYmIZFmNLAJa9Hk+qNNcbV0JUclfthBMiQQksAdY0VNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhKfpG5W; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768949087; x=1800485087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yhs+ocVB5WAnuyvxIX7IZInV1lvZe4TqMwx+zm0tX54=;
  b=jhKfpG5W88PeUcNYvX8P6XBArpqeY4ujxpoZndionjWc0WdSmSeRUkBP
   dBWHK/1ZvE7mbgwBMoVhJtwQA1JllEw1leFRLBWzi+eFTcs1s5VvI+dhz
   ZzOL2KyTk/vycM2PeZNIuTvBrPcbEtKEU+fXgBJWWNderowyGtThQia9j
   6bamDMq8rpCKikNYi1r1oMrZf8mPnucJqYMbHKwmlTdOkINDABLzERaV3
   YeukpdycgUls4HUDXKvK6/2f3Z1qWfK0Um8ilQkWERJmzi79raPJIk7xP
   o6J+tLyDBrkzrJm3XEPL4VIn8nhKboeJ6CVmU8us6NVseyMULQw4iKthq
   A==;
X-CSE-ConnectionGUID: ixSlOXn7QNS2yp9X+2xAMw==
X-CSE-MsgGUID: K3QcmkA8TPOktapK4LMSRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81548792"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81548792"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:44:38 -0800
X-CSE-ConnectionGUID: 9yVPWVoKSgiAtp7SrZ4Zmw==
X-CSE-MsgGUID: cbzxYb5BRNGNos9AWoo6LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236920153"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 14:44:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Cody Haas <chaas@riotgames.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 1/4] ice: Fix persistent failure in ice_get_rxfh
Date: Tue, 20 Jan 2026 14:44:25 -0800
Message-ID: <20260120224430.410377-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
References: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-251633-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,riotgames.com:email]
X-Rspamd-Queue-Id: 2BD6B4DF0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cody Haas <chaas@riotgames.com>

Several ioctl functions have the ability to call ice_get_rxfh, however
all of these ioctl functions do not provide all of the expected
information in ethtool_rxfh_param. For example, ethtool_get_rxfh_indir does
not provide an rss_key. This previously caused ethtool_get_rxfh_indir to
always fail with -EINVAL.

This change draws inspiration from i40e_get_rss to handle this
situation, by only calling the appropriate rss helpers when the
necessary information has been provided via ethtool_rxfh_param.

Fixes: b66a972abb6b ("ice: Refactor ice_set/get_rss into LUT and key specific functions")
Signed-off-by: Cody Haas <chaas@riotgames.com>
Closes: https://lore.kernel.org/intel-wired-lan/CAH7f-UKkJV8MLY7zCdgCrGE55whRhbGAXvgkDnwgiZ9gUZT7_w@mail.gmail.com/
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 +----
 drivers/net/ethernet/intel/ice/ice_main.c    | 28 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 147aaee192a7..00f75d87c73f 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -979,6 +979,7 @@ void ice_map_xdp_rings(struct ice_vsi *vsi);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
+int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
 int ice_set_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
 int ice_get_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
 int ice_set_rss_key(struct ice_vsi *vsi, u8 *seed);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 969d4f8f9c02..3565a5d96c6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3626,11 +3626,7 @@ ice_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 	if (!lut)
 		return -ENOMEM;
 
-	err = ice_get_rss_key(vsi, rxfh->key);
-	if (err)
-		goto out;
-
-	err = ice_get_rss_lut(vsi, lut, vsi->rss_table_size);
+	err = ice_get_rss(vsi, rxfh->key, lut, vsi->rss_table_size);
 	if (err)
 		goto out;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4bb68e7a00f5..6a9278487ccb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7988,6 +7988,34 @@ int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed)
 	return status;
 }
 
+/**
+ * ice_get_rss - Get RSS LUT and/or key
+ * @vsi: Pointer to VSI structure
+ * @seed: Buffer to store the key in
+ * @lut: Buffer to store the lookup table entries
+ * @lut_size: Size of buffer to store the lookup table entries
+ *
+ * Return: 0 on success, negative on failure
+ */
+int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
+{
+	int err;
+
+	if (seed) {
+		err = ice_get_rss_key(vsi, seed);
+		if (err)
+			return err;
+	}
+
+	if (lut) {
+		err = ice_get_rss_lut(vsi, lut, lut_size);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * ice_set_rss_hfunc - Set RSS HASH function
  * @vsi: Pointer to VSI structure
-- 
2.47.1


