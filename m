Return-Path: <netdev+bounces-239133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CABEFC64802
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8434BBE9
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA8334363;
	Mon, 17 Nov 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liTpuVqe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0833344B;
	Mon, 17 Nov 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387365; cv=none; b=b1+IV9eD5WWIoUpt/UouIbzvFgOXNKK4AnKFtaCtFZumDS+IAnhG8sb9HpM720THq1iKjFFwfn84v7AdhJszrObst6JbLOMgrVR7WWWViyttxLxBNTkqoag+bfZ92eNXSyYtWOYn2GG0gQuAuxdyVZqkKzFxYxh60GCuYTctbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387365; c=relaxed/simple;
	bh=3s6JP8cxQ1vH1cWvg8nKuw8nN1jdP30KtuJAVsHlce0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji6l/fWfbucHtUsm3oOyXabFPkxAa1i0R2Bz0ADaBXByDOGOThjsuNQrGc2lJKMPuaFN6EWpCxBuiK/A33RtaVl2QZfTkX7F1coUbFS3ffYxGmnMYPUUOfiafcuRlMdqvFNs3Y3+ZVR5WgqdBOyz+Zu4cLKoyplqdYIgLdCOUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liTpuVqe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763387364; x=1794923364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3s6JP8cxQ1vH1cWvg8nKuw8nN1jdP30KtuJAVsHlce0=;
  b=liTpuVqeVsceQSMiEC4mn9SxmaSjoifnFMzJwmULTNn3ThL1iUcnDeIk
   yW/K4FELkvDwyjxxnUu6de0QorwQ1+1b3v76w0cqD1R5B7mCwPgmwGqbc
   ilnFoLpkt2n7YGQeTjdSIr5bfBwUYFuitHdfkzyltlX6b62IvR7D/WyUV
   oKO/0XEgp4web6N8uQBJcrdyVKQdjWdrdTSPgczjPeFRY+z3ANKH7PpDr
   +16WET5OIR7sa5t1q8pnaBFsIkXWHo46q2Z4ryxexNc4wrEnLaDYUwYwI
   IersY5Ie0sb2OEiXiVIQgm1EGR8TgZ5QuJQjox6tpfj3QtgB5E4UPnaDO
   Q==;
X-CSE-ConnectionGUID: gqghT43cQuqHAHwbyLyxTw==
X-CSE-MsgGUID: JntPVyXWSsKCAlPrPndETg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65266944"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="65266944"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 05:49:23 -0800
X-CSE-ConnectionGUID: LmoNDX2zTaSSQKGAstbfIw==
X-CSE-MsgGUID: p7XhSVCGSCaWlHmq9U20fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190684003"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 17 Nov 2025 05:49:18 -0800
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A893537E39;
	Mon, 17 Nov 2025 13:49:16 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	jayaprakash.shanmugam@intel.com,
	natalia.wochtman@intel.com,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v5 02/15] virtchnl: introduce control plane version fields
Date: Mon, 17 Nov 2025 14:48:42 +0100
Message-ID: <20251117134912.18566-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251117134912.18566-1-larysa.zaremba@intel.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Raj <victor.raj@intel.com>

In the virtchnl header file, add the Control Plane software version fields.

Signed-off-by: Victor Raj <victor.raj@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 include/linux/intel/virtchnl2.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/intel/virtchnl2.h b/include/linux/intel/virtchnl2.h
index 02ae447cc24a..7b0821732ff3 100644
--- a/include/linux/intel/virtchnl2.h
+++ b/include/linux/intel/virtchnl2.h
@@ -505,7 +505,8 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_version_info);
  *			    sent per transmit packet without needing to be
  *			    linearized.
  * @pad: Padding.
- * @reserved: Reserved.
+ * @cp_ver_major: Control Plane major version number.
+ * @cp_ver_minor: Control Plane minor version number.
  * @device_type: See enum virtchl2_device_type.
  * @min_sso_packet_len: Min packet length supported by device for single
  *			segment offload.
@@ -556,7 +557,8 @@ struct virtchnl2_get_capabilities {
 	__le16 max_tx_hdr_size;
 	u8 max_sg_bufs_per_tx_pkt;
 	u8 pad[3];
-	u8 reserved[4];
+	__le16 cp_ver_major;
+	__le16 cp_ver_minor;
 	__le32 device_type;
 	u8 min_sso_packet_len;
 	u8 max_hdr_buf_per_lso;
-- 
2.47.0


