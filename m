Return-Path: <netdev+bounces-139267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECA9B13B5
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 02:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C615F1F21D29
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F1B5661;
	Sat, 26 Oct 2024 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyeYLDv/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4CDF71;
	Sat, 26 Oct 2024 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901160; cv=none; b=C6inHwQqIASUh5CVVGyixtrrjmjByDEXvZZc5lyNs0mqxysy5Bgup1S7Et9+2cdq5EAdT/VK1XvdmwtPdmGBfOM34noIkP5ypiotihLPnrT63JIyGVLS1sbsKQsI+2sY4gMu88la0B3CY9oWSIr0mbJgPQ491nvGlSpRmGLDWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901160; c=relaxed/simple;
	bh=LdoeboTt1iJZ8l27Xbcv/vUqueDpoEQkChBB6rU81hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RY5j/KliJT7qXmSweDjYb9p7IURC5zcTg4WR+s6TVZwd+AQ6TMCfC5JSl/pZ+9s7yrXq7ShOJ0pimtFzkX+KEFwq0M1H2yY6SlHpaE0yQ/S2FDwnpv40xSIes3hzVyiQlnOaKaZGZcCEHaSFcObHnDJ1GHLGq73d+QKfkd/sjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyeYLDv/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729901158; x=1761437158;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LdoeboTt1iJZ8l27Xbcv/vUqueDpoEQkChBB6rU81hQ=;
  b=FyeYLDv/DJfY69GkkSozmZ+PUGz5d5CUSzZgbpnLQZ+8i5qcyVuDrPoT
   TOwFiVPb2sJN/yt/4xv3DSL3XUF76DR3Egeq0wLf8u5vntrHbfb1xc6iQ
   J8p+8WdGpqUikovVKYhK/wzAU1Q6ShGt5ITR1cxNvcT1KukUstZAPmP8n
   vqGqQ6MpV2fy6nX/EDSkVwnjQW9Z+Effl0Bv9hYSrDBnET163RbbeNst4
   OixDccpjmpAt8gLNenxQqHoIUDuUCas7JqFp4LRzd6BJeFoSTySGfc1PR
   JrkZzNTIlpGcsgYutl61/CY8SkhJpLUT40mLOeYHlVimv++URFCWlcZED
   g==;
X-CSE-ConnectionGUID: X5RMiA2HQdS8VeD1xFO1ag==
X-CSE-MsgGUID: +5XAiKHARg2UlnSJqAx7Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40959155"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40959155"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:54 -0700
X-CSE-ConnectionGUID: s/xajfKwR66W7Hngif27dQ==
X-CSE-MsgGUID: KPDowaYDRo6Ju/fGvfVtSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="104386858"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:54 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Oct 2024 17:04:59 -0700
Subject: [PATCH net-next v2 7/9] ice: reduce size of queue context fields
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-packing-pack-fields-and-ice-implementation-v2-7-734776c88e40@intel.com>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1

The ice_rlan_ctx and ice_tlan_ctx structures have some fields which are
intentionally sized larger necessary relative to the packed sizes the data
must fit into. This was done because the original ice_set_ctx() function
and its helpers did not correctly handle packing when the packed bits
straddled a byte. This is no longer the case with the use of the
<linux/packing.h> implementation.

Save some bytes in these structures by sizing the variables to the number
of bytes the actual bitpacked fields fit into.

There are a couple of gaps left in the structure, which is a result of the
fields being in the order they appear in the packed bit layout, but where
alignment forces some extra gaps. We could fix this, saving ~8 bytes from
each structure. However, these structures are not used heavily, and the
resulting savings is minimal:

$ bloat-o-meter ice-before-reorder.ko ice-after-reorder.ko
add/remove: 0/0 grow/shrink: 1/1 up/down: 26/-70 (-44)
Function                                     old     new   delta
ice_vsi_cfg_txq                             1873    1899     +26
ice_setup_rx_ctx.constprop                  1529    1459     -70
Total: Before=1459555, After=1459511, chg -0.00%

Thus, the fields are left in the same order as the packed bit layout,
despite the gaps this causes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 32 ++++++++------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 31d4a445d640..1479b45738af 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -375,23 +375,17 @@ enum ice_rx_flex_desc_status_error_1_bits {
 #define ICE_TX_DRBELL_Q_CTX_SIZE_DWORDS	5
 #define GLTCLAN_CQ_CNTX(i, CQ)		(GLTCLAN_CQ_CNTX0(CQ) + ((i) * 0x0800))
 
-/* RLAN Rx queue context data
- *
- * The sizes of the variables may be larger than needed due to crossing byte
- * boundaries. If we do not have the width of the variable set to the correct
- * size then we could end up shifting bits off the top of the variable when the
- * variable is at the top of a byte and crosses over into the next byte.
- */
+/* RLAN Rx queue context data */
 struct ice_rlan_ctx {
 	u16 head;
-	u16 cpuid; /* bigger than needed, see above for reason */
+	u8 cpuid;
 #define ICE_RLAN_BASE_S 7
 	u64 base;
 	u16 qlen;
 #define ICE_RLAN_CTX_DBUF_S 7
-	u16 dbuf; /* bigger than needed, see above for reason */
+	u8 dbuf;
 #define ICE_RLAN_CTX_HBUF_S 6
-	u16 hbuf; /* bigger than needed, see above for reason */
+	u8 hbuf;
 	u8 dtype;
 	u8 dsize;
 	u8 crcstrip;
@@ -399,12 +393,12 @@ struct ice_rlan_ctx {
 	u8 hsplit_0;
 	u8 hsplit_1;
 	u8 showiv;
-	u32 rxmax; /* bigger than needed, see above for reason */
+	u16 rxmax;
 	u8 tphrdesc_ena;
 	u8 tphwdesc_ena;
 	u8 tphdata_ena;
 	u8 tphhead_ena;
-	u16 lrxqthresh; /* bigger than needed, see above for reason */
+	u8 lrxqthresh;
 	u8 prefena;	/* NOTE: normally must be set to 1 at init */
 };
 
@@ -535,18 +529,12 @@ enum ice_tx_ctx_desc_eipt_offload {
 #define ICE_LAN_TXQ_MAX_QGRPS	127
 #define ICE_LAN_TXQ_MAX_QDIS	1023
 
-/* Tx queue context data
- *
- * The sizes of the variables may be larger than needed due to crossing byte
- * boundaries. If we do not have the width of the variable set to the correct
- * size then we could end up shifting bits off the top of the variable when the
- * variable is at the top of a byte and crosses over into the next byte.
- */
+/* Tx queue context data */
 struct ice_tlan_ctx {
 #define ICE_TLAN_CTX_BASE_S	7
 	u64 base;		/* base is defined in 128-byte units */
 	u8 port_num;
-	u16 cgd_num;		/* bigger than needed, see above for reason */
+	u8 cgd_num;
 	u8 pf_num;
 	u16 vmvf_num;
 	u8 vmvf_type;
@@ -557,7 +545,7 @@ struct ice_tlan_ctx {
 	u8 tsyn_ena;
 	u8 internal_usage_flag;
 	u8 alt_vlan;
-	u16 cpuid;		/* bigger than needed, see above for reason */
+	u8 cpuid;
 	u8 wb_mode;
 	u8 tphrd_desc;
 	u8 tphrd;
@@ -566,7 +554,7 @@ struct ice_tlan_ctx {
 	u16 qnum_in_func;
 	u8 itr_notification_mode;
 	u8 adjust_prof_id;
-	u32 qlen;		/* bigger than needed, see above for reason */
+	u16 qlen;
 	u8 quanta_prof_idx;
 	u8 tso_ena;
 	u16 tso_qnum;

-- 
2.47.0.265.g4ca455297942


