Return-Path: <netdev+bounces-185257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFBDA99875
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F28A3B705D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A528DEFD;
	Wed, 23 Apr 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0ODsiLu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3C28CF7C
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436446; cv=none; b=gGD62aqJzIHJb6rqqv06SCQlgm4fxYOY8cZxRNR0UgXDv7PkoUWPCGmNeOSBSh2X8TXL3/5MbMLBLadJJCiWm5XphfPynBKekK9JTmuf6ZUarQfdUElwFh68kE49wN8q9XKxqhr2o8fno9KdR2X71QcSHJICbMP+txJ/sD4aGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436446; c=relaxed/simple;
	bh=GEcShooZ59WTGpvzIKKWGhzv3gV5R0EJBdI0OFUPXt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/ruSu7muwvI/svI1rzvxpkT7KLb7ebiJ7QYoip4lGFidzbZnN/5wJ/kreJGbEmPowBtyRDkaPO21O8mR9vPmjdrePxs7lQhHxR8FR8HxQszHdyVxBYgvbr50/hU0X2Iw1uTyLB2IEHxBCxL9Ua4kcKRBEUYaIBYiWtoj+3hTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0ODsiLu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745436445; x=1776972445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GEcShooZ59WTGpvzIKKWGhzv3gV5R0EJBdI0OFUPXt0=;
  b=L0ODsiLuZgBJtMSCvIGOq4qYzSLRjw+RUr2FRFSze/7S3pzqDhJlMH3U
   GAlG6RnbGi+RJjvz/CYKSx2RWcpVd5Q0ZSoghTtisPrHvdEVLlqMOPG0v
   dCO0D2Bky9IZe6rjsfdiPCMeSTTU3wiYRPBzBhsCd05k5i5WrGfn/89LK
   OSBIF9PVFvtPTFZoUEfBROUKKF+Rv7P6Q4XC4miCorp/RaOaBu2cUXvJk
   WipU7s61HnwKDg2n4ZTQ43Pf8c6PFJNL8q2b+esbpWtmWYTyA8sUdEd6Y
   1r60zyjK5UuOUanePh3+tgxpkVR9xE5YfLv/UPAOvRfozYU27FvQfyH0e
   w==;
X-CSE-ConnectionGUID: rzIf4te8Ryq7/rX91lunfA==
X-CSE-MsgGUID: I5Fh1nkaRQ+8EyJ2Cc9s1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47176407"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47176407"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 12:27:25 -0700
X-CSE-ConnectionGUID: PKRT1r65TdOKVDArMP/8xg==
X-CSE-MsgGUID: OS2im9iBSui/neRWUUjQZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163442521"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 12:27:18 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	ahmed.zaki@intel.com,
	sridhar.samudrala@intel.com,
	aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com,
	dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	almasrymina@google.com,
	willemb@google.com,
	pmenzel@molgen.mpg.de
Subject: [PATCH iwl-next v5 1/3] virtchnl2: rename enum virtchnl2_cap_rss
Date: Wed, 23 Apr 2025 13:27:03 -0600
Message-ID: <20250423192705.1648119-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423192705.1648119-1-ahmed.zaki@intel.com>
References: <20250423192705.1648119-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "enum virtchnl2_cap_rss" will be used for negotiating flow
steering capabilities. Instead of adding a new enum, rename
virtchnl2_cap_rss to virtchnl2_flow_types. Also rename the enum's
constants.

Flow steering will use this enum in the next patches.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 20 +++++------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 16 ++++-----
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 34 +++++++++----------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 294f4b7032a1..c21903310354 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -647,16 +647,16 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
 			    enum idpf_cap_field field, u64 flag);
 
 #define IDPF_CAP_RSS (\
-	VIRTCHNL2_CAP_RSS_IPV4_TCP	|\
-	VIRTCHNL2_CAP_RSS_IPV4_TCP	|\
-	VIRTCHNL2_CAP_RSS_IPV4_UDP	|\
-	VIRTCHNL2_CAP_RSS_IPV4_SCTP	|\
-	VIRTCHNL2_CAP_RSS_IPV4_OTHER	|\
-	VIRTCHNL2_CAP_RSS_IPV6_TCP	|\
-	VIRTCHNL2_CAP_RSS_IPV6_TCP	|\
-	VIRTCHNL2_CAP_RSS_IPV6_UDP	|\
-	VIRTCHNL2_CAP_RSS_IPV6_SCTP	|\
-	VIRTCHNL2_CAP_RSS_IPV6_OTHER)
+	VIRTCHNL2_FLOW_IPV4_TCP		|\
+	VIRTCHNL2_FLOW_IPV4_TCP		|\
+	VIRTCHNL2_FLOW_IPV4_UDP		|\
+	VIRTCHNL2_FLOW_IPV4_SCTP	|\
+	VIRTCHNL2_FLOW_IPV4_OTHER	|\
+	VIRTCHNL2_FLOW_IPV6_TCP		|\
+	VIRTCHNL2_FLOW_IPV6_TCP		|\
+	VIRTCHNL2_FLOW_IPV6_UDP		|\
+	VIRTCHNL2_FLOW_IPV6_SCTP	|\
+	VIRTCHNL2_FLOW_IPV6_OTHER)
 
 #define IDPF_CAP_RSC (\
 	VIRTCHNL2_CAP_RSC_IPV4_TCP	|\
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index f1f6b63bfeb0..06c33b638e60 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -849,14 +849,14 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_SEG_TX_SINGLE_TUNNEL);
 
 	caps.rss_caps =
-		cpu_to_le64(VIRTCHNL2_CAP_RSS_IPV4_TCP		|
-			    VIRTCHNL2_CAP_RSS_IPV4_UDP		|
-			    VIRTCHNL2_CAP_RSS_IPV4_SCTP		|
-			    VIRTCHNL2_CAP_RSS_IPV4_OTHER	|
-			    VIRTCHNL2_CAP_RSS_IPV6_TCP		|
-			    VIRTCHNL2_CAP_RSS_IPV6_UDP		|
-			    VIRTCHNL2_CAP_RSS_IPV6_SCTP		|
-			    VIRTCHNL2_CAP_RSS_IPV6_OTHER);
+		cpu_to_le64(VIRTCHNL2_FLOW_IPV4_TCP		|
+			    VIRTCHNL2_FLOW_IPV4_UDP		|
+			    VIRTCHNL2_FLOW_IPV4_SCTP		|
+			    VIRTCHNL2_FLOW_IPV4_OTHER		|
+			    VIRTCHNL2_FLOW_IPV6_TCP		|
+			    VIRTCHNL2_FLOW_IPV6_UDP		|
+			    VIRTCHNL2_FLOW_IPV6_SCTP		|
+			    VIRTCHNL2_FLOW_IPV6_OTHER);
 
 	caps.hsplit_caps =
 		cpu_to_le32(VIRTCHNL2_CAP_RX_HSPLIT_AT_L4V4	|
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 11b8f6f05799..1094b3989bf0 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -151,22 +151,22 @@ enum virtchnl2_cap_seg {
 	VIRTCHNL2_CAP_SEG_TX_DOUBLE_TUNNEL	= BIT(8),
 };
 
-/* Receive Side Scaling Flow type capability flags */
-enum virtchnl2_cap_rss {
-	VIRTCHNL2_CAP_RSS_IPV4_TCP		= BIT(0),
-	VIRTCHNL2_CAP_RSS_IPV4_UDP		= BIT(1),
-	VIRTCHNL2_CAP_RSS_IPV4_SCTP		= BIT(2),
-	VIRTCHNL2_CAP_RSS_IPV4_OTHER		= BIT(3),
-	VIRTCHNL2_CAP_RSS_IPV6_TCP		= BIT(4),
-	VIRTCHNL2_CAP_RSS_IPV6_UDP		= BIT(5),
-	VIRTCHNL2_CAP_RSS_IPV6_SCTP		= BIT(6),
-	VIRTCHNL2_CAP_RSS_IPV6_OTHER		= BIT(7),
-	VIRTCHNL2_CAP_RSS_IPV4_AH		= BIT(8),
-	VIRTCHNL2_CAP_RSS_IPV4_ESP		= BIT(9),
-	VIRTCHNL2_CAP_RSS_IPV4_AH_ESP		= BIT(10),
-	VIRTCHNL2_CAP_RSS_IPV6_AH		= BIT(11),
-	VIRTCHNL2_CAP_RSS_IPV6_ESP		= BIT(12),
-	VIRTCHNL2_CAP_RSS_IPV6_AH_ESP		= BIT(13),
+/* Receive Side Scaling and Flow Steering Flow type capability flags */
+enum virtchnl2_flow_types {
+	VIRTCHNL2_FLOW_IPV4_TCP		= BIT(0),
+	VIRTCHNL2_FLOW_IPV4_UDP		= BIT(1),
+	VIRTCHNL2_FLOW_IPV4_SCTP	= BIT(2),
+	VIRTCHNL2_FLOW_IPV4_OTHER	= BIT(3),
+	VIRTCHNL2_FLOW_IPV6_TCP		= BIT(4),
+	VIRTCHNL2_FLOW_IPV6_UDP		= BIT(5),
+	VIRTCHNL2_FLOW_IPV6_SCTP	= BIT(6),
+	VIRTCHNL2_FLOW_IPV6_OTHER	= BIT(7),
+	VIRTCHNL2_FLOW_IPV4_AH		= BIT(8),
+	VIRTCHNL2_FLOW_IPV4_ESP		= BIT(9),
+	VIRTCHNL2_FLOW_IPV4_AH_ESP	= BIT(10),
+	VIRTCHNL2_FLOW_IPV6_AH		= BIT(11),
+	VIRTCHNL2_FLOW_IPV6_ESP		= BIT(12),
+	VIRTCHNL2_FLOW_IPV6_AH_ESP	= BIT(13),
 };
 
 /* Header split capability flags */
@@ -458,7 +458,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_version_info);
  * @seg_caps: See enum virtchnl2_cap_seg.
  * @hsplit_caps: See enum virtchnl2_cap_rx_hsplit_at.
  * @rsc_caps: See enum virtchnl2_cap_rsc.
- * @rss_caps: See enum virtchnl2_cap_rss.
+ * @rss_caps: See enum virtchnl2_flow_types.
  * @other_caps: See enum virtchnl2_cap_other.
  * @mailbox_dyn_ctl: DYN_CTL register offset and vector id for mailbox
  *		     provided by CP.
-- 
2.43.0


