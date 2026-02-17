Return-Path: <netdev+bounces-259171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g8CNJ7DzlGlzJQIAu9opvQ
	(envelope-from <netdev+bounces-259171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 00:03:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20B151AC0
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 00:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 372FF3013AAB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF72727E0;
	Tue, 17 Feb 2026 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhJR1D1S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D451139579
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369389; cv=none; b=bzYpAAJtOl0a2EXrzW9Zs/UK5RylgukEH0jy05tb50A09d0mt2MPrv3zgSzrL5ZCyASP5qBSwdFTvY3+ukw7/vnrsaoD9O6mpiIElIoTsFx2Io2WsefImN2hKs2hgncWC+ITXyxOOR9MOmCjOXBJqw0QOfIgjfTUACp+uI10J/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369389; c=relaxed/simple;
	bh=ACQhzgqYI4BP9sufN+hWv/pC9E5bB06fTv1NUnF6qdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyBbwzQb90BzNa+lasdjyMNMuvpjuGh6qNy9EWk5yPQ/vXBZ8MXychLG97xI0p2hY1+AK8L/I2yyOZLCXzYQohMAbNoitxpwDIREaN7FOeyuGPJar27jOSzXYD25yHNirMdiX7o6JGMLVFt1GC1FCt4F7SzLo4ZWQezADzg+bn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhJR1D1S; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771369388; x=1802905388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ACQhzgqYI4BP9sufN+hWv/pC9E5bB06fTv1NUnF6qdA=;
  b=BhJR1D1ShWwiuhFtHM/uFDLaGNx7i0q9ycSCe7hzG4BJo6EzyQ6Hq8G/
   z6zVD57Ad5zErC8jbZoTtdm/Vck+zhxK2lLWoHTv33IyxxBrmajwcmb++
   OI5bKF3oBIpWzIXiPd3C6ji+YJ+WTiwuOK/ERl+NUJay8FnvXk3Gzc8mK
   P5O+ITXL1x5TLGqnS5FWQjptA+NIwMc8hqAUu+o6qmmeN6YbJNeOVX1Qt
   /MJCleo6YeD2aCVS2O03zJMBEfTBe0Y/U9KsxuxJ0TP54/SrLOz9G398h
   bd6yYTjpOWoXsftimAmsBBkKH+E/UX14jTJqkHrll+dhs/LJx5HCJ11Aa
   g==;
X-CSE-ConnectionGUID: PGo4k0/3QhKzOCDqU0xzeA==
X-CSE-MsgGUID: Dh/c4DCiREKqQFszRftLDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72541560"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72541560"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 15:03:07 -0800
X-CSE-ConnectionGUID: qR4X/p4tQaWBRVbfjFOlPw==
X-CSE-MsgGUID: /lrV/rykTearZIkt9IlOcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="212732208"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa007.fm.intel.com with ESMTP; 17 Feb 2026 15:03:05 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Zoltan Fodor <zoltan.fodor@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net] ice: update PCS latency settings for E825 10G/25Gb modes
Date: Tue, 17 Feb 2026 23:59:56 +0100
Message-Id: <20260217225956.1593920-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259171-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: BF20B151AC0
X-Rspamd-Action: no action

Update MAC Rx/Tx offset registers settings (PHY_MAC_[RX|TX]_OFFSET
registers) with the data obtained with the latest research. It applies
to PCS latency settings for the following speeds/modes:
* 10Gb NO-FEC
        - TX latency changed from 71.25 ns to 73 ns
        - RX latency changed from -25.6 ns to -28 ns
* 25Gb NO-FEC
	- TX latency changed from 28.17 ns to 33 ns
        - RX latency changed from -12.45 ns to -12 ns
* 25Gb RS-FEC
        - TX latency changed from 64.5 ns to 69 ns
        - RX latency changed from -3.6 ns to -3 ns

The original data came from simulation and pre-production hardware.
The new data measures the actual delays and as such is more accurate.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Co-developed-by: Zoltan Fodor <zoltan.fodor@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Zoltan Fodor <zoltan.fodor@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 19dddd9b53dd..4d298c27bfb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -78,14 +78,14 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.blktime = 0x666, /* 3.2 */
 		.tx_offset = {
 			.serdes = 0x234c, /* 17.6484848 */
-			.no_fec = 0x8e80, /* 71.25 */
+			.no_fec = 0x93d9, /* 73 */
 			.fc = 0xb4a4, /* 90.32 */
 			.sfd = 0x4a4, /* 2.32 */
 			.onestep = 0x4ccd /* 38.4 */
 		},
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
-			.no_fec = 0xffffcccd, /* -25.6 */
+			.no_fec = 0xffffc7b6, /* -28 */
 			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
@@ -118,17 +118,17 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.mktime = 0x147b, /* 10.24, only if RS-FEC enabled */
 		.tx_offset = {
 			.serdes = 0xe1e, /* 7.0593939 */
-			.no_fec = 0x3857, /* 28.17 */
+			.no_fec = 0x4266, /* 33 */
 			.fc = 0x48c3, /* 36.38 */
-			.rs = 0x8100, /* 64.5 */
+			.rs = 0x8a00, /* 69 */
 			.sfd = 0x1dc, /* 0.93 */
 			.onestep = 0x1eb8 /* 15.36 */
 		},
 		.rx_offset = {
 			.serdes = 0xfffff7a9, /* -4.1697 */
-			.no_fec = 0xffffe71a, /* -12.45 */
+			.no_fec = 0xffffe700, /* -12 */
 			.fc = 0xfffe894d, /* -187.35 */
-			.rs = 0xfffff8cd, /* -3.6 */
+			.rs = 0xfffff8cc, /* -3 */
 			.sfd = 0x1dc, /* 0.93 */
 			.bs_ds = 0x14 /* 0.0387879, RS-FEC 0 */
 		}

base-commit: acd2abc52dea91c3bc3d1b6dd8a92b9631d48bbf
-- 
2.39.3


