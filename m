Return-Path: <netdev+bounces-247514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D59FCFB6EB
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8987730BD0DD
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F41DE8AE;
	Wed,  7 Jan 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQsiKGNR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591231A0712
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744424; cv=none; b=tfCDpqnnexDkI0kOBe8+7+FX0d/1BzMzOmDhoe6SlcygaHDKeK9cDIjzAxQCQjQXPKfE6zv5BxHYyxywy18Fgvd/GTzt+WShg7Sno3cLlufzlhXBxKO0UmpyGG4bhP+aCtUElafMwI7GEvx0yTif5u7Bo3nFOdR68PQI9qilx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744424; c=relaxed/simple;
	bh=QHq2WtYL9VcIfMhYPsn+EFICzpKkcRRDqYjmQVRG568=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzO3DsWcZIXCvkZTbE4+XJtApYX+wetd6Su1GUxiV4Ep6TbudX9JxWIt+hlvfSB50x90Xm+0rt8x/5ePbuTBboRbcdk/ZWkkobNb0IFP8ZbOYdBBD0K07Kmxz/j3OD05JG6CNiLtwN5kO3tmiAuDHHI2s1tFmITTl+uU6VIUqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQsiKGNR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744424; x=1799280424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QHq2WtYL9VcIfMhYPsn+EFICzpKkcRRDqYjmQVRG568=;
  b=SQsiKGNRipafgAJJ/Ii7rpsQd6QCdxRtBX7XMcL9wCRB6ACz9/W20VcV
   EWRdxaBYIQpQnsmwWoVPIuInBAOnTrte/OhF9cvl8P3t3Dfufz1wDg1MG
   /etL/K/KLpdYoFfMdCWmAtYgQl5qjf3BcWkAcQNQ5lFBJFOTojtyIIbFp
   mkYKcQM9Ad7WQ4LzDbI1nadJ1BLng7ZByTeeCuSo4f2+TQnjULCJ1HuTW
   vD1SJMQk0sa561Q9TbnG+5IEnLqBnZwbqwm5l/nJeNut8wJiIJzbs0DWG
   2vnQ+am6A4eWkRoeHliVubjR0WX3Etw2gCwjo92sLtt21Y1Yyyc87v7eB
   g==;
X-CSE-ConnectionGUID: FIL1wBetQxW6dr3p9MOnkg==
X-CSE-MsgGUID: WUmydXtARgWgESjSkzg/Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161690"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161690"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:55 -0800
X-CSE-ConnectionGUID: /SgQcFIGTXukQleDSryGNA==
X-CSE-MsgGUID: s2joSnTISveXlnJCQ65TCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841216"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	tatyana.e.nikolova@intel.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 13/13] idpf: fix aux device unplugging when rdma is not supported by vport
Date: Tue,  6 Jan 2026 16:06:45 -0800
Message-ID: <20260107000648.1861994-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
References: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

If vport flags do not contain VIRTCHNL2_VPORT_ENABLE_RDMA, driver does not
allocate vdev_info for this vport. This leads to kernel NULL pointer
dereference in idpf_idc_vport_dev_down(), which references vdev_info for
every vport regardless.

Check, if vdev_info was ever allocated before unplugging aux device.

Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 7e20a07e98e5..6dad0593f7f2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -322,7 +322,7 @@ static void idpf_idc_vport_dev_down(struct idpf_adapter *adapter)
 	for (i = 0; i < adapter->num_alloc_vports; i++) {
 		struct idpf_vport *vport = adapter->vports[i];
 
-		if (!vport)
+		if (!vport || !vport->vdev_info)
 			continue;
 
 		idpf_unplug_aux_dev(vport->vdev_info->adev);
-- 
2.47.1


