Return-Path: <netdev+bounces-169360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6AA4391B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963793BC983
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C122641C5;
	Tue, 25 Feb 2025 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1VM7+M0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9664263F42
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474576; cv=none; b=myyGGbsqwonYauVAmiBFzynRhfqGNsQby6r4zulzg5eBWAej595msizyUrAFgQSNDAYnHqnCqwrgXappwXPjABXBvt5hp6smSWYOmfM/o/ec5oZS/wsef0oMqHYvBcehwcPKSWg6UZUCuvZAzFaZstwTOzaOhxmWzmDkyIT/gf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474576; c=relaxed/simple;
	bh=p2lHx+ivZdf+2bsYoUoyEQpLiHAsgUf1x6J7T9tfMH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzRkUQvpPNmHVwovSRTOEsllBQL3JHnrRid+XuvcZq5lvvIaOyffQwoD6bALhAgvCq9DqWU5jCjJlT6lq/EKu6FdWPyxcWSEvODHK4jkkJxj7NlFbuKSvP+lh2viPROQz7Tr1QR4OWS4grjOMLUjRRCm9BsVsIBR1nOOqbtKP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1VM7+M0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740474574; x=1772010574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p2lHx+ivZdf+2bsYoUoyEQpLiHAsgUf1x6J7T9tfMH4=;
  b=H1VM7+M08zUEp6M74/zfBhCXK+ys3Qewz/gRkXAjGvVsEuj+GQrFhDxI
   JpsnG4nykUwQIxv0S4xVOOOtmAFWxVRz0pO8jqBcrJNzRbV+Mw87N5Lwb
   8rXiQXjihVP2OAqGR8yPI8hqKW/XOFWqggMNzUKGDQosnqZlwP/ddrk+r
   dR5dlE57qSH/7JaYRXFpuqWMphUxN2t2wK3DSxop42YXgrxjesJRE+NCX
   MmmK7K6KKbEzgFdB2gDYQ3RjoLBX4N2mmgzuSdXtZE8pSPBPbro3nZ4P5
   +9lrWjWBIOVvDNFbZtASafPFghAbtRRai9ScjnP+5iC1XWPSlokwtwajW
   g==;
X-CSE-ConnectionGUID: ZTsAbjazScGHntF9qzPLgg==
X-CSE-MsgGUID: 7vNHmrLiQEawesF4vA1POQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58810348"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58810348"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:09:34 -0800
X-CSE-ConnectionGUID: o+9dFX3gRHGoJ6Rd1FpILg==
X-CSE-MsgGUID: E+rWjXQ0T22J4soRLBBOew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121275700"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2025 01:09:33 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v2 5/5] ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()
Date: Tue, 25 Feb 2025 10:08:49 +0100
Message-ID: <20250225090847.513849-8-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Fix using the untrusted value of proto->raw.pkt_len in function
ice_vc_fdir_parse_raw() by verifying if it does not exceed the
VIRTCHNL_MAX_SIZE_RAW_PACKET value.

Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 14e3f0f89c78..6250629ee8f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -835,18 +835,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	u8 *pkt_buf, *msk_buf __free(kfree);
 	struct ice_parser_result rslt;
 	struct ice_pf *pf = vf->pf;
+	u16 pkt_len, udp_port = 0;
 	struct ice_parser *psr;
 	int status = -ENOMEM;
 	struct ice_hw *hw;
-	u16 udp_port = 0;
 
-	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
-	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
+	if (!proto->raw.pkt_len)
+		return -EINVAL;
+
+	pkt_len = proto->raw.pkt_len;
+
+	if (!pkt_len || pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
+		return -EINVAL;
+
+	pkt_buf = kzalloc(pkt_len, GFP_KERNEL);
+	msk_buf = kzalloc(pkt_len, GFP_KERNEL);
+
 	if (!pkt_buf || !msk_buf)
 		goto err_mem_alloc;
 
-	memcpy(pkt_buf, proto->raw.spec, proto->raw.pkt_len);
-	memcpy(msk_buf, proto->raw.mask, proto->raw.pkt_len);
+	memcpy(pkt_buf, proto->raw.spec, pkt_len);
+	memcpy(msk_buf, proto->raw.mask, pkt_len);
 
 	hw = &pf->hw;
 
@@ -862,7 +871,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	if (ice_get_open_tunnel_port(hw, &udp_port, TNL_VXLAN))
 		ice_parser_vxlan_tunnel_set(psr, udp_port, true);
 
-	status = ice_parser_run(psr, pkt_buf, proto->raw.pkt_len, &rslt);
+	status = ice_parser_run(psr, pkt_buf, pkt_len, &rslt);
 	if (status)
 		goto err_parser_destroy;
 
@@ -876,7 +885,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	}
 
 	status = ice_parser_profile_init(&rslt, pkt_buf, msk_buf,
-					 proto->raw.pkt_len, ICE_BLK_FD,
+					 pkt_len, ICE_BLK_FD,
 					 conf->prof);
 	if (status)
 		goto err_parser_profile_init;
@@ -885,7 +894,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		ice_parser_profile_dump(hw, conf->prof);
 
 	/* Store raw flow info into @conf */
-	conf->pkt_len = proto->raw.pkt_len;
+	conf->pkt_len = pkt_len;
 	conf->pkt_buf = pkt_buf;
 	conf->parser_ena = true;
 
-- 
2.47.0


