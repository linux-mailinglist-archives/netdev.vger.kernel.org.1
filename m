Return-Path: <netdev+bounces-239139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B2C647D4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6A53A6A31
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFDF3375B9;
	Mon, 17 Nov 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJted9By"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9F335BC6;
	Mon, 17 Nov 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387376; cv=none; b=a+b6dp26qRbJtHqkZ7pU3cnnhlChN1Gw8XqZh1qajIQmOVGniUCTF0JVgBVtCQsEfHcmV03yvXHTg1zbV22e7LOfdawKskdMmVkE31y4oFpoiRLX1l3DH+4qOHvZ5stYEWhBS2Zn2J+l9nzElgMmZG2c7CTkw3jwIFmbpRY/Lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387376; c=relaxed/simple;
	bh=KyIMXsqbQ/CLB4hCnfdeMDbuBOyaNAGAafbhW0WEGtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO1WbZBb8T+NExNZdPqL0euNI6pz3RT2bHeob91F0j06ATfs7fTGmUEVCSUPv4IYbBEzAuKvNg+wcQCazl0YBLUnUBJs3q37PPOTREKZYKtHvo+fwkRd0Ei0vxXxNhz3SoCKBsseq8PnSxVtZfFfYioFoHtcIb6T9RKE1d2OupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJted9By; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763387373; x=1794923373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KyIMXsqbQ/CLB4hCnfdeMDbuBOyaNAGAafbhW0WEGtU=;
  b=YJted9ByLi3PuCpRdgijcEVa21fCFE4WPbXC2uwm59KvV90+S5lajhtx
   E40rgVaiCbtpaZ9MrkoC3h+fOT/poil3Yb+0LP94yhH7pHgwiGjYGV9S7
   INqY8uEpWR/lVdXOpG/EFB+ckaJ2ulFQf0+S71P44iL3e6oqvGGeDlA75
   RGWuTYvahDHUht2b52w4FSqM3xwQJSjRaOeAA0Lru+ggy/mgiQMx7bL8I
   /M8pyFwXXC/eMsEueAJGEwK/haQN+JEnW/CQ7faGNXhxq85l/K9xcSg6C
   ljkn5piYAG1eue0oHe+xd95CGYJ2RzHI+yZuaPrMyiZBPtd/OszSw2+HP
   Q==;
X-CSE-ConnectionGUID: 3okxxmaFSReb33fje9r0Pg==
X-CSE-MsgGUID: Ex1CUCFETMqQcP2Ogr+Wsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76846114"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="76846114"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 05:49:32 -0800
X-CSE-ConnectionGUID: Goufk0rKSwGVslBcXLfDtA==
X-CSE-MsgGUID: WnZwOg0/SvK4pn8ETbY8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190115719"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 17 Nov 2025 05:49:27 -0800
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6703737E39;
	Mon, 17 Nov 2025 13:49:25 +0000 (GMT)
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
Subject: [PATCH iwl-next v5 07/15] idpf: remove 'vport_params_reqd' field
Date: Mon, 17 Nov 2025 14:48:47 +0100
Message-ID: <20251117134912.18566-8-larysa.zaremba@intel.com>
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

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

While sending a create vport message to the device control plane, a create
vport virtchnl message is prepared with all the required info to initialize
the vport. This info is stored in the adapter struct but never used
thereafter. So, remove the said field.

Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 --
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 --
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 31 ++++++-------------
 3 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 78e55baf4600..1a1ea3fef092 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -638,7 +638,6 @@ struct idpf_vc_xn_manager;
  * @avail_queues: Device given queue limits
  * @vports: Array to store vports created by the driver
  * @netdevs: Associated Vport netdevs
- * @vport_params_reqd: Vport params requested
  * @vport_params_recvd: Vport params received
  * @vport_ids: Array of device given vport identifiers
  * @singleq_pt_lkup: Lookup table for singleq RX ptypes
@@ -697,7 +696,6 @@ struct idpf_adapter {
 	struct idpf_avail_queue_info avail_queues;
 	struct idpf_vport **vports;
 	struct net_device **netdevs;
-	struct virtchnl2_create_vport **vport_params_reqd;
 	struct virtchnl2_create_vport **vport_params_recvd;
 	u32 *vport_ids;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 36a53c9e08c2..dca7861a0a2a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1111,8 +1111,6 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 
 	kfree(adapter->vport_params_recvd[idx]);
 	adapter->vport_params_recvd[idx] = NULL;
-	kfree(adapter->vport_params_reqd[idx]);
-	adapter->vport_params_reqd[idx] = NULL;
 
 	kfree(vport);
 	adapter->num_alloc_vports--;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index a53689885c8c..eb834f29ff77 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1548,14 +1548,10 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
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
 
@@ -1572,8 +1568,7 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 	err = idpf_vport_calc_total_qs(adapter, idx, vport_msg, max_q);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Enough queues are not available");
-
-		return err;
+		goto rel_buf;
 	}
 
 	if (!adapter->vport_params_recvd[idx]) {
@@ -1581,7 +1576,7 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 							   GFP_KERNEL);
 		if (!adapter->vport_params_recvd[idx]) {
 			err = -ENOMEM;
-			goto free_vport_params;
+			goto rel_buf;
 		}
 	}
 
@@ -1597,13 +1592,15 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
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
@@ -3401,8 +3398,6 @@ static void idpf_vport_params_buf_rel(struct idpf_adapter *adapter)
 {
 	kfree(adapter->vport_params_recvd);
 	adapter->vport_params_recvd = NULL;
-	kfree(adapter->vport_params_reqd);
-	adapter->vport_params_reqd = NULL;
 	kfree(adapter->vport_ids);
 	adapter->vport_ids = NULL;
 }
@@ -3417,17 +3412,11 @@ static int idpf_vport_params_buf_alloc(struct idpf_adapter *adapter)
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


