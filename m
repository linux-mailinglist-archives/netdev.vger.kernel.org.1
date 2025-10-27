Return-Path: <netdev+bounces-233123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F094C0CB2E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DACE134C3A8
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E02F25F6;
	Mon, 27 Oct 2025 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbMBklpy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407D2E62A9
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557864; cv=none; b=bsTCgqaEwT/VZr94JMrK1QYIZNROeeNo74Ei3HuT7eJGj3Hv+RZxZ+GESfyGLuZwDPacHXFd5NIw63g5bQdXjRSuHf1OAEKQw3ikOzNPdoYyei5bsywpUbCGJx5yov1sE496auPiL2VONBXY+rk3W51keEGuPxDW0lBk/piPV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557864; c=relaxed/simple;
	bh=jqOKmErsdbja9tgUAS59D8e84rlJgey2JcmFKJOONL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoCapA+RmKOu5bZrE0G/+B99tJ0zFhpyAIS+MOk+ebPvSmrPSqkBZHFmNqJK9q62kjlxOahhtvt2uCVWSyxUB75wQsVStdHUtiGirYaxEjsmKkAvqbuSCgWDldWzo3MTmXfYE28xDMLbEkUuQTqO4M1gtJSzfoC9MDXu2712qCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbMBklpy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761557863; x=1793093863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jqOKmErsdbja9tgUAS59D8e84rlJgey2JcmFKJOONL8=;
  b=SbMBklpyC8usujryCaAppIXzZ7w1K+nOpjeAgSsupZNMLi92ZopSODEU
   NTOBLr92vMK+98XVdOk/ih95GscpfhfbjPOaEig3Ra8/hSYNyNV6BO79L
   zAgV2TzZxudFfdEyIAo/igw42xHSNe8ZGIxkXyXsKfwnKDphje6tXSosz
   sCNgRnuDUIN5608xhrC1d+qt4BM4QjcqHc+VI8J5x3AUqg6i1nKdzIrxJ
   ltNiUGGq+kOKNQGEYwoU/OrPZfkUE8MD43zjEcvm3beyW164XBn+PnSLm
   7N0hNv/kSUrO8iHmVWQOfUh+LHkjImZ7rfK9GRdoxvTI2M2i5oCB1bMvV
   A==;
X-CSE-ConnectionGUID: pQtfm6T5QWq2RcQTdsZFgg==
X-CSE-MsgGUID: NEJTeGLXTfyZ9nOdLdMryA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62663158"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="62663158"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:37:43 -0700
X-CSE-ConnectionGUID: yfNEGmz+T4OniHTuEQ3/iQ==
X-CSE-MsgGUID: rBhschT1RnuHRbiT+Jgdyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185349372"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 27 Oct 2025 02:37:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: Dan Nowlin <dan.nowlin@intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v7 2/6] ice: add virtchnl definitions and static data for GTP RSS
Date: Mon, 27 Oct 2025 10:37:32 +0100
Message-ID: <20251027093736.3582567-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251027093736.3582567-1-aleksandr.loktionov@intel.com>
References: <20251027093736.3582567-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add virtchnl protocol header and field definitions for advanced RSS
configuration including GTPC, GTPU, L2TPv2, ECPRI, PPP, GRE, and IP
fragment headers.

- Define new virtchnl protocol header types
- Add RSS field selectors for tunnel protocols
- Extend static mapping arrays for protocol field matching
- Add L2TPv2 session ID and length+session ID field support

This provides the foundational definitions needed for VF RSS
configuration of tunnel protocols.

Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Co-developed-by: Jie Wang <jie1x.wang@intel.com>
Signed-off-by: Jie Wang <jie1x.wang@intel.com>
Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Co-developed-by: Ting Xu <ting.xu@intel.com>
Signed-off-by: Ting Xu <ting.xu@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/rss.c | 91 +++++++++++++++++++++++
 include/linux/avf/virtchnl.h              | 48 ++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/virt/rss.c b/drivers/net/ethernet/intel/ice/virt/rss.c
index cbdbb32..71d7db6 100644
--- a/drivers/net/ethernet/intel/ice/virt/rss.c
+++ b/drivers/net/ethernet/intel/ice/virt/rss.c
@@ -36,6 +36,13 @@ static const struct ice_vc_hdr_match_type ice_vc_hdr_list[] = {
 	{VIRTCHNL_PROTO_HDR_ESP,	ICE_FLOW_SEG_HDR_ESP},
 	{VIRTCHNL_PROTO_HDR_AH,		ICE_FLOW_SEG_HDR_AH},
 	{VIRTCHNL_PROTO_HDR_PFCP,	ICE_FLOW_SEG_HDR_PFCP_SESSION},
+	{VIRTCHNL_PROTO_HDR_GTPC,	ICE_FLOW_SEG_HDR_GTPC},
+	{VIRTCHNL_PROTO_HDR_L2TPV2,	ICE_FLOW_SEG_HDR_L2TPV2},
+	{VIRTCHNL_PROTO_HDR_PPP,	ICE_FLOW_SEG_HDR_PPP},
+	{VIRTCHNL_PROTO_HDR_ECPRI,	ICE_FLOW_SEG_HDR_ECPRI_TP0},
+	{VIRTCHNL_PROTO_HDR_IPV4_FRAG,	ICE_FLOW_SEG_HDR_IPV_FRAG},
+	{VIRTCHNL_PROTO_HDR_IPV6_EH_FRAG,	ICE_FLOW_SEG_HDR_IPV_FRAG},
+	{VIRTCHNL_PROTO_HDR_GRE,        ICE_FLOW_SEG_HDR_GRE},
 };
 
 struct ice_vc_hash_field_match_type {
@@ -149,6 +156,90 @@ ice_vc_hash_field_match_type ice_vc_hash_field_list[] = {
 	{VIRTCHNL_PROTO_HDR_L2TPV3,
 		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_L2TPV3_SESS_ID),
 		BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV3_SESS_ID)},
+	{VIRTCHNL_PROTO_HDR_L2TPV2,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_L2TPV2_SESS_ID),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID)},
+	{VIRTCHNL_PROTO_HDR_L2TPV2,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_L2TPV2_LEN_SESS_ID),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID)},
+	{VIRTCHNL_PROTO_HDR_PPP,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_PPP_PROTO_ID),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_PPP_PROTO_ID)},
+	{VIRTCHNL_PROTO_HDR_GTPC,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_GTPC_TEID),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_TEID)},
+	{VIRTCHNL_PROTO_HDR_IPV4,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_CHKSUM),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_CHKSUM)},
+	{VIRTCHNL_PROTO_HDR_IPV4,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_ID),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_ID)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_TC),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_TC)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_HOP_LIMIT),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_HLIM)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX32_SRC),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE32_SA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX32_DST),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE32_DA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX40_SRC),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE40_SA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX40_DST),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE40_DA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX48_SRC),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE48_SA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX48_DST),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE48_DA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX56_SRC),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE56_SA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX56_DST),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE56_DA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX64_SRC),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE64_SA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX64_DST),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE64_DA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX96_SRC),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE96_SA)},
+	{VIRTCHNL_PROTO_HDR_IPV6,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PREFIX96_DST),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE96_DA)},
+	{VIRTCHNL_PROTO_HDR_TCP,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_TCP_CHKSUM),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_TCP_CHKSUM)},
+	{VIRTCHNL_PROTO_HDR_UDP,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_UDP_CHKSUM),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_UDP_CHKSUM)},
+	{VIRTCHNL_PROTO_HDR_GRE,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_GRE_PROTO),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_GRE_PROTO)},
+	{VIRTCHNL_PROTO_HDR_ECPRI,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ECPRI_MSG_TYPE),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_ECPRI_TP0_MSG_TYPE)},
+	{VIRTCHNL_PROTO_HDR_ECPRI,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ECPRI_PC_RTC_ID),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_ECPRI_TP0_PC_ID)},
+	{VIRTCHNL_PROTO_HDR_ECPRI,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ECPRI_REV),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_ECPRI_TP0_REV)},
+	{VIRTCHNL_PROTO_HDR_ECPRI,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ECPRI_CONCAT),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_ECPRI_TP0_CONCAT)},
+	{VIRTCHNL_PROTO_HDR_ECPRI,
+		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ECPRI_MSG_LEN),
+		BIT_ULL(ICE_FLOW_FIELD_IDX_ECPRI_TP0_MSG_LEN)},
 	{VIRTCHNL_PROTO_HDR_ESP, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ESP_SPI),
 		BIT_ULL(ICE_FLOW_FIELD_IDX_ESP_SPI)},
 	{VIRTCHNL_PROTO_HDR_AH, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_AH_SPI),
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 5be1881..b0d5164 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -1253,6 +1253,17 @@ enum virtchnl_proto_hdr_type {
 	VIRTCHNL_PROTO_HDR_ESP,
 	VIRTCHNL_PROTO_HDR_AH,
 	VIRTCHNL_PROTO_HDR_PFCP,
+	VIRTCHNL_PROTO_HDR_GTPC,
+	VIRTCHNL_PROTO_HDR_ECPRI,
+	VIRTCHNL_PROTO_HDR_L2TPV2,
+	VIRTCHNL_PROTO_HDR_PPP,
+	/* IPv4 and IPv6 Fragment header types are only associated to
+	 * VIRTCHNL_PROTO_HDR_IPV4 and VIRTCHNL_PROTO_HDR_IPV6 respectively,
+	 * cannot be used independently.
+	 */
+	VIRTCHNL_PROTO_HDR_IPV4_FRAG,
+	VIRTCHNL_PROTO_HDR_IPV6_EH_FRAG,
+	VIRTCHNL_PROTO_HDR_GRE,
 };
 
 /* Protocol header field within a protocol header. */
@@ -1275,6 +1286,8 @@ enum virtchnl_proto_hdr_field {
 	VIRTCHNL_PROTO_HDR_IPV4_DSCP,
 	VIRTCHNL_PROTO_HDR_IPV4_TTL,
 	VIRTCHNL_PROTO_HDR_IPV4_PROT,
+	VIRTCHNL_PROTO_HDR_IPV4_CHKSUM,
+	VIRTCHNL_PROTO_HDR_IPV4_ID,
 	/* IPV6 */
 	VIRTCHNL_PROTO_HDR_IPV6_SRC =
 		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_IPV6),
@@ -1282,14 +1295,29 @@ enum virtchnl_proto_hdr_field {
 	VIRTCHNL_PROTO_HDR_IPV6_TC,
 	VIRTCHNL_PROTO_HDR_IPV6_HOP_LIMIT,
 	VIRTCHNL_PROTO_HDR_IPV6_PROT,
+	/* IPV6 Prefix */
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX32_SRC,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX32_DST,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX40_SRC,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX40_DST,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX48_SRC,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX48_DST,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX56_SRC,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX56_DST,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX64_SRC,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX64_DST,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX96_SRC,
+	VIRTCHNL_PROTO_HDR_IPV6_PREFIX96_DST,
 	/* TCP */
 	VIRTCHNL_PROTO_HDR_TCP_SRC_PORT =
 		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_TCP),
 	VIRTCHNL_PROTO_HDR_TCP_DST_PORT,
+	VIRTCHNL_PROTO_HDR_TCP_CHKSUM,
 	/* UDP */
 	VIRTCHNL_PROTO_HDR_UDP_SRC_PORT =
 		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_UDP),
 	VIRTCHNL_PROTO_HDR_UDP_DST_PORT,
+	VIRTCHNL_PROTO_HDR_UDP_CHKSUM,
 	/* SCTP */
 	VIRTCHNL_PROTO_HDR_SCTP_SRC_PORT =
 		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_SCTP),
@@ -1317,6 +1345,26 @@ enum virtchnl_proto_hdr_field {
 	VIRTCHNL_PROTO_HDR_PFCP_S_FIELD =
 		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_PFCP),
 	VIRTCHNL_PROTO_HDR_PFCP_SEID,
+	/* GTPC */
+	VIRTCHNL_PROTO_HDR_GTPC_TEID =
+		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_GTPC),
+	/* L2TPV2 */
+	VIRTCHNL_PROTO_HDR_L2TPV2_SESS_ID =
+		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_L2TPV2),
+	VIRTCHNL_PROTO_HDR_L2TPV2_LEN_SESS_ID,
+	/* PPP */
+	VIRTCHNL_PROTO_HDR_PPP_PROTO_ID =
+		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_PPP),
+	/* GRE */
+	VIRTCHNL_PROTO_HDR_GRE_PROTO =
+		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_GRE),
+	/* ECPRI */
+	VIRTCHNL_PROTO_HDR_ECPRI_MSG_TYPE =
+		PROTO_HDR_FIELD_START(VIRTCHNL_PROTO_HDR_ECPRI),
+	VIRTCHNL_PROTO_HDR_ECPRI_PC_RTC_ID,
+	VIRTCHNL_PROTO_HDR_ECPRI_REV,
+	VIRTCHNL_PROTO_HDR_ECPRI_CONCAT,
+	VIRTCHNL_PROTO_HDR_ECPRI_MSG_LEN,
 };
 
 struct virtchnl_proto_hdr {
-- 
2.49.0


