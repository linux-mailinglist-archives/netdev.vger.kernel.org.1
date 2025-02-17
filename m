Return-Path: <netdev+bounces-166946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09352A3802E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5B3188BF65
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C521764B;
	Mon, 17 Feb 2025 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLoLIXdN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076F217646
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788111; cv=none; b=iBYv7yncvZw3P9M2xPrz510Edpqf61RPGWaNjuiUd0jQr5/xq7gSY1UQHcJWDghQ+DChKJCoKNsajKWFg0qIZZpxNf+Ea8rtpTu0EeiI8JHfwJ5zoIDSBpuv0+n8wpdmqmYezO85BfHE9rQ8Yq+i2gy7ZjaXQbfg4IXqz5RCxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788111; c=relaxed/simple;
	bh=eind2xzv457E4eHcksBryEozwBnJEEjhqhm0h6DsxyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxc7SMSlhW8ByF1epGc/W6rP3Ug20vvWjsp4C6z1Nu1rn3ABISlfiQ8fZawLrP6DZqH4JfPGtPwgoVTH6EnQfenQIMQIPTua3ulWLM7lL6nDgi2G0Qh46dmVwX2dRTxNxwr4kR/8zhfqUFllQUyYsGwbHQunk6EORpp+4lENx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLoLIXdN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739788110; x=1771324110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eind2xzv457E4eHcksBryEozwBnJEEjhqhm0h6DsxyQ=;
  b=jLoLIXdNVg/2obuMJHDJef0CuLKOLy1LICuoj3iNpGpKc491BEBHCmJS
   miw2bhoMZQoFLTN6bRYKD9wswD8ruvKsbK+8vX5u25PkwAeZY+uu/XPdM
   mST91ISksGohIf6UzEA0mwdLGL7S0WGlZ6D+RR8Z8UgrvJDOZn48mFeeg
   H7WZayuiaInAykTlwgnv1Rb3tGwAkrveyVLpH+8Db61eQxFSmTIz0QweF
   6tW3U0FkgIHBiTzyDmYar0htks5/Cnm1Bcuyi057DE5j0Dv1MvyaohGfu
   Iy1/zaA+H5gBv3SuXBrwhAaDA1gguY7fWadjl7nLzQ/jZPOaYrA362sr1
   w==;
X-CSE-ConnectionGUID: rjynj3NmQwG6MPtvOh2LCQ==
X-CSE-MsgGUID: bVhFXtpDTO20ofY2Jm5B+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40168395"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40168395"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 02:28:30 -0800
X-CSE-ConnectionGUID: vCeOmfrgTpydwcKwXMC62A==
X-CSE-MsgGUID: AkkyC4K9QqmCMrXVCg1/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114598244"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa010.fm.intel.com with ESMTP; 17 Feb 2025 02:28:28 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net 1/4] virtchnl: make proto and filter action count unsigned
Date: Mon, 17 Feb 2025 11:27:43 +0100
Message-ID: <20250217102744.300357-4-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

Count can never be negative and valid. Change it to unsigned
to simplify handling virtchnl messages in drivers.

Fixes: 1f7ea1cd6a374 ("ice: Enable FDIR Configure for AVF")
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 include/linux/avf/virtchnl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 4811b9a14604..cf0afa60e4a7 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -1343,7 +1343,7 @@ struct virtchnl_proto_hdrs {
 	 * 2 - from the second inner layer
 	 * ....
 	 **/
-	int count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
+	u32 count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
 	union {
 		struct virtchnl_proto_hdr
 			proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
@@ -1395,7 +1395,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(36, virtchnl_filter_action);
 
 struct virtchnl_filter_action_set {
 	/* action number must be less then VIRTCHNL_MAX_NUM_ACTIONS */
-	int count;
+	u32 count;
 	struct virtchnl_filter_action actions[VIRTCHNL_MAX_NUM_ACTIONS];
 };
 
-- 
2.47.0


