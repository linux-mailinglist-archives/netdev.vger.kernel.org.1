Return-Path: <netdev+bounces-171593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C411A4DBED
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E515A16FBCF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6113200BA9;
	Tue,  4 Mar 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBdW0/m0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE51FF5EF
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086553; cv=none; b=UHRSpd9kmm64z2J38x/iYQdwH0IZX2zL0chjiTNoKU5oml2amEGSFi2EHH2qF7DqCV42nDNpD9dw/0Vnnsnn07C1euRYniHBlnMa0XXz0x1Q1niPMhKt3gTpVWDzUKRTqzB+o2f0c8LwmUGlW0/lMzH2MObh5XPtfQJLnAzdpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086553; c=relaxed/simple;
	bh=+FokbEjIo6EWGZsc1hJnWYHHvZiQYXYkKTV6GBaOM3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8U3Tx93zjJ6XPFPbZzj3iOLBvcngan2EQytv/qXSYUTr/kzk8FCXrgs3959LEn5ZGgiRItBMs86Sy2n8QIBmdVAKir4Uc2Grs2cMZoyQyj3MtAjhsfsK08cZRduZggxZ+L6QggV7xqDnhjGZCxwjYNVgbuvkuuG0AiwH3qqM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBdW0/m0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741086552; x=1772622552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FokbEjIo6EWGZsc1hJnWYHHvZiQYXYkKTV6GBaOM3Q=;
  b=aBdW0/m0aRDup57f6GAMxOKMtCuWdOtuo9GQ0AAtMMIWstw3cupE8q3X
   oBz+eFdQdL1l7732s7acC+k9j8yFql51dcx4gHpnvNYpDy5I9KCpi2rbB
   dRC/cMWgGilPboGKcX/ZFElZIvPfYgguS6tAqRwvO9naRTwLNJGe4MVs2
   /EEudtdEL527DmBuoAbcnk+Q8nwXNN5ymkALcs5D/6kayVz+LHUddIWB1
   EYGkcEmRp5Jj43Btz05Ye9uStOBEFBuN+PpfBBm91ZcPM28dK6+coI7xf
   6qfMBLzIr+qTWEL92+Bf+kACPB7QNR/TzMJgHM0UZ6X4oloKFa7S4tnR0
   w==;
X-CSE-ConnectionGUID: cWdz94lWRMCjpUYeskuI/Q==
X-CSE-MsgGUID: za6rgR36RaWHTSlRWhmMNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41247017"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41247017"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:09:12 -0800
X-CSE-ConnectionGUID: r6hfVo9aSf6a9e7Hsj5xvg==
X-CSE-MsgGUID: fneyscdOQKWxJnR366XkAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118341352"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa007.fm.intel.com with ESMTP; 04 Mar 2025 03:09:10 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v3 2/5] ice: stop truncating queue ids when checking
Date: Tue,  4 Mar 2025 12:08:32 +0100
Message-ID: <20250304110833.95997-5-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

Queue IDs can be up to 4096, fix invalid check to stop
truncating IDs to 8 bits.

Fixes: bf93bf791cec8 ("ice: introduce ice_virtchnl.c and ice_virtchnl.h")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b6285433307c..343f2b4b0dc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -565,7 +565,7 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
  *
  * check for the valid queue ID
  */
-static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u8 qid)
+static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u16 qid)
 {
 	/* allocated Tx and Rx queues should be always equal for VF VSI */
 	return qid < vsi->alloc_txq;
-- 
2.47.0


