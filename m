Return-Path: <netdev+bounces-189261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A3AB159C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDBB1BC885E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF5A293B5E;
	Fri,  9 May 2025 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OT4Lou4H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516529374B;
	Fri,  9 May 2025 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798227; cv=none; b=Q/4SoKYLpRTJQTLW+q/2RMtOWXh90R7tszNuy8RMLAe2DXS5P6y2rQLYidFD5QVkGzQd7JyHFc6uyGR2n11aPGhDbbQoCKoZMHDHt8KXj8k4hRRvxb6A/8/voQ4fXSwX07KVbDGYjvAOeBMcJlg/YMQddBECmeLox3uKLXPquq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798227; c=relaxed/simple;
	bh=7OYoU9EnuY8nCxXVszix0Hudtn8bLTL89+v0wqbvGy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ki9svvJLiUXHAd7rGa8ZkVWQuABLfOe5yw7a6AgaVfVD+uF51gQlQGqlfWXEVdZszelVZfY7TbT2/zTkWs4IaFTEPtN3vrymHi6eJCVQawT7CsXt/CNdryC+XvHv8L5oaNKXNurGImxd9hKUkmEoHo1VfNlNU1ISJKv0s9Bk0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OT4Lou4H; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746798225; x=1778334225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7OYoU9EnuY8nCxXVszix0Hudtn8bLTL89+v0wqbvGy4=;
  b=OT4Lou4HuBIBYpoWnbZAV80TsSr7AgWNTEJRkCPkZw4vbBpOlacEg5OF
   80bAMDqXsWOHqjfE1BK1i6x5kgQoI6MjUMAr4g3qWB12Xu6qINkNqj8G4
   gZcVEMwvl7iGPNI0CSr/cZZds3NqI5sLlJWNsiMeUVn9Z1NHT3/IPiNVI
   Qo+Y4yJmGI2w4jsofn1lpwatfgM+Mi0vybgg1CpiIIX4ybR5QAVjVsaBR
   XQzge05o07EcQ75fE8RNCtpQFGRdgLd2Pvae9RtOM+PIcjIXDW19QzdfH
   iJzcMxMUn53yj7zcWg0h/HzajBFXEdaphkvqjuuuApX1Xmz0+oLCAQHVK
   Q==;
X-CSE-ConnectionGUID: 5cYmDSQXQu+xWDJ9wxT6gw==
X-CSE-MsgGUID: qRZ2/xqqRjyIbljxAXW8vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48532889"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48532889"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 06:43:44 -0700
X-CSE-ConnectionGUID: sRkk197LRUWOeMqsivqSkQ==
X-CSE-MsgGUID: NquFjkXCQTya37F2kO3qHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136323205"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2025 06:43:37 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E978A3430F;
	Fri,  9 May 2025 14:43:34 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: [PATCH iwl-next v3 07/15] idpf: remove 'vport_params_reqd' field
Date: Fri,  9 May 2025 15:43:04 +0200
Message-ID: <20250509134319.66631-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250509134319.66631-1-larysa.zaremba@intel.com>
References: <20250509134319.66631-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

While sending a create vport message to the device control plane, a create
vport virtchnl message is prepared with all the required info to initialize
the vport. This info is stored in the adapter struct but never used
thereafter. So, remove the said field.

Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 --
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 --
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 31 ++++++-------------
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index b3758e6516b5..1c9b61d78d92 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -584,7 +584,6 @@ struct idpf_vc_xn_manager;
  * @avail_queues: Device given queue limits
  * @vports: Array to store vports created by the driver
  * @netdevs: Associated Vport netdevs
- * @vport_params_reqd: Vport params requested
  * @vport_params_recvd: Vport params received
  * @vport_ids: Array of device given vport identifiers
  * @singleq_pt_lkup: Lookup table for singleq RX ptypes
@@ -641,7 +640,6 @@ struct idpf_adapter {
 	struct idpf_avail_queue_info avail_queues;
 	struct idpf_vport **vports;
 	struct net_device **netdevs;
-	struct virtchnl2_create_vport **vport_params_reqd;
 	struct virtchnl2_create_vport **vport_params_recvd;
 	u32 *vport_ids;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 492b03d8f718..0075c9c7be2f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -958,8 +958,6 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 
 	kfree(adapter->vport_params_recvd[idx]);
 	adapter->vport_params_recvd[idx] = NULL;
-	kfree(adapter->vport_params_reqd[idx]);
-	adapter->vport_params_reqd[idx] = NULL;
 
 	kfree(vport);
 	adapter->num_alloc_vports--;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index bdeaab65dcb0..43030a50b6cf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1307,14 +1307,10 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 	ssize_t reply_sz;
 
 	buf_size = sizeof(struct virtchnl2_create_vport);
-	if (!adapter->vport_params_reqd[idx]) {
-		adapter->vport_params_reqd[idx] = kzalloc(buf_size,
-							  GFP_KERNEL);
-		if (!adapter->vport_params_reqd[idx])
-			return -ENOMEM;
-	}
+	vport_msg = kzalloc(buf_size, GFP_KERNEL);
+	if (!vport_msg)
+		return -ENOMEM;
 
-	vport_msg = adapter->vport_params_reqd[idx];
 	vport_msg->vport_type = cpu_to_le16(VIRTCHNL2_VPORT_TYPE_DEFAULT);
 	vport_msg->vport_index = cpu_to_le16(idx);
 
@@ -1331,8 +1327,7 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 	err = idpf_vport_calc_total_qs(adapter, idx, vport_msg, max_q);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Enough queues are not available");
-
-		return err;
+		goto rel_buf;
 	}
 
 	if (!adapter->vport_params_recvd[idx]) {
@@ -1340,7 +1335,7 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 							   GFP_KERNEL);
 		if (!adapter->vport_params_recvd[idx]) {
 			err = -ENOMEM;
-			goto free_vport_params;
+			goto rel_buf;
 		}
 	}
 
@@ -1356,13 +1351,15 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 		goto free_vport_params;
 	}
 
+	kfree(vport_msg);
+
 	return 0;
 
 free_vport_params:
 	kfree(adapter->vport_params_recvd[idx]);
 	adapter->vport_params_recvd[idx] = NULL;
-	kfree(adapter->vport_params_reqd[idx]);
-	adapter->vport_params_reqd[idx] = NULL;
+rel_buf:
+	kfree(vport_msg);
 
 	return err;
 }
@@ -2845,8 +2842,6 @@ static void idpf_vport_params_buf_rel(struct idpf_adapter *adapter)
 {
 	kfree(adapter->vport_params_recvd);
 	adapter->vport_params_recvd = NULL;
-	kfree(adapter->vport_params_reqd);
-	adapter->vport_params_reqd = NULL;
 	kfree(adapter->vport_ids);
 	adapter->vport_ids = NULL;
 }
@@ -2861,17 +2856,11 @@ static int idpf_vport_params_buf_alloc(struct idpf_adapter *adapter)
 {
 	u16 num_max_vports = idpf_get_max_vports(adapter);
 
-	adapter->vport_params_reqd = kcalloc(num_max_vports,
-					     sizeof(*adapter->vport_params_reqd),
-					     GFP_KERNEL);
-	if (!adapter->vport_params_reqd)
-		return -ENOMEM;
-
 	adapter->vport_params_recvd = kcalloc(num_max_vports,
 					      sizeof(*adapter->vport_params_recvd),
 					      GFP_KERNEL);
 	if (!adapter->vport_params_recvd)
-		goto err_mem;
+		return -ENOMEM;
 
 	adapter->vport_ids = kcalloc(num_max_vports, sizeof(u32), GFP_KERNEL);
 	if (!adapter->vport_ids)
-- 
2.47.0


