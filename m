Return-Path: <netdev+bounces-226438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B3BA066D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C56A620CDA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC22EA47E;
	Thu, 25 Sep 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUqaFdUa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32C2EC097
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814460; cv=none; b=cCryafO/1shxl1CbCvMeaBlWWSTevyYtH/UnOIge/GyWou0ySvtVt2x4O1g4ISoplQJU+72q31xD/RrOu6WJDtmBbYjPcCdCizL6JG0/6owdS6yYcr3rEgmuGz0SktxV2vTfmnrky436URhoz+xnX0VeKqoc4hQgReO/bAlI8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814460; c=relaxed/simple;
	bh=ykLhi+WcKmW7+gVKC4ajZ63BqypGmAKHuKRlaD2W8J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruKjnRM4Q9kF6GNa3LSRaaWIFA++gbaojNrS/ucQjWoKMml0YgGgBxJLlEalahmWwsjN5Iq8dVoaFELdKxxuKPySHkVihVzZ5mA2Nam/uvsAbo9mxbGAB9DNPPyalz9RGFv11m3d5KaDaH9xMXd9Fx+9ubhM96bIVm3G8R3XRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUqaFdUa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758814460; x=1790350460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykLhi+WcKmW7+gVKC4ajZ63BqypGmAKHuKRlaD2W8J8=;
  b=hUqaFdUa2hD/gxhGWreAyR6/tS0NR9cqzspnXGVZ/NcBV9GHAiDujWOm
   aVc+SrKW1zruJJepTiS6z2k2w/XQWAdLHOW+W8U540IajXB6rpbDq1pL/
   Pl7kz+Y+UzqBRgXpBGbQx53L9eTzrVDDuckharlmuQ33JI8Jkwu0oPWTX
   +NGnQ0kjv1wQKlN9cTT0TiKQ6RtAfIeQMviSPpV0/fQrIkfZDGl/trxWR
   xikD2UZLbM+5kiFsJZROa9e1Hhr6GqDEmxGoTgmc9D1238dO4Yf/jfnyy
   LGbqsK4NUKHUxumwNNmTbgN/ljI7fbLeaW9GXhJmwzA4AeqAnE8gL7hR4
   Q==;
X-CSE-ConnectionGUID: FtQBKBeSQKiw2MsP4EHxPA==
X-CSE-MsgGUID: XgxFQzXISR+TgyQ6xk5uCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64947231"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64947231"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:34:19 -0700
X-CSE-ConnectionGUID: ogqVkYnuTEqwvB6wZysmeQ==
X-CSE-MsgGUID: Ses6bB1+Rde3CKoFL3dGWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="208298266"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by fmviesa001.fm.intel.com with ESMTP; 25 Sep 2025 08:34:17 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: sreedevi.joshi@intel.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net 2/2] idpf: fix issue with ethtool -n command display
Date: Thu, 25 Sep 2025 10:33:58 -0500
Message-Id: <20250925153358.143112-3-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925153358.143112-1-sreedevi.joshi@intel.com>
References: <20250925153358.143112-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>

When ethtool -n is executed on an interface to display the flow steering
rules, "rxclass: Unknown flow type" error is generated.

The flow steering list maintained in the driver currently stores only the
location and q_index but other fields of the ethtool_rx_flow_spec are not
stored. This may be enough for the virtchnl command to delete the entry.
However, when the ethtool -n command is used to query the flow steering
rules, the ethtool_rx_flow_spec returned is not complete causing the
error below.

Resolve this by storing the flow spec (fsp) when rules are added and
returning the complete flow spec when rules are queried.

Also, change the return value from EINVAL to ENOENT when flow steering
entry is not found during query by location or when deleting an entry.

Add logic to detect and reject duplicate filter entries at the same
location.

Example:
Before the fix:
ethtool -n eth1
2 RX rings available
Total 2 rules

rxclass: Unknown flow type
rxclass: Unknown flow type

After the fix:
ethtool -n eth1
2 RX rings available
Total 2 rules

Filter: 0
        Rule Type: TCP over IPv4
        Src IP addr: 10.0.0.1 mask: 0.0.0.0
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 0 mask: 0xffff
        Action: Direct to queue 0

Filter: 1
        Rule Type: UDP over IPv4
        Src IP addr: 10.0.0.1 mask: 0.0.0.0
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 0 mask: 0xffff
        Action: Direct to queue 0

Fixes: ada3e24b84a0 ("idpf: add flow steering support")
Signed-off-by: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Co-developed-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 57 ++++++++++++-------
 2 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 4f4cf21e3c46..ec759bc5b3ce 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -269,8 +269,7 @@ struct idpf_port_stats {
 
 struct idpf_fsteer_fltr {
 	struct list_head list;
-	u32 loc;
-	u32 q_index;
+	struct ethtool_rx_flow_spec fs;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 1352f18b60b0..6a39cc1feeb5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -38,11 +38,13 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		cmd->data = idpf_fsteer_max_rules(vport);
 		break;
 	case ETHTOOL_GRXCLSRULE:
-		err = -EINVAL;
+		err = -ENOENT;
 		spin_lock_bh(&vport_config->flow_steer_list_lock);
 		list_for_each_entry(f, &user_config->flow_steer_list, list)
-			if (f->loc == cmd->fs.location) {
-				cmd->fs.ring_cookie = f->q_index;
+			if (f->fs.location == cmd->fs.location) {
+				/* Avoid infoleak from padding: zero first, then assign fields */
+				memset(&cmd->fs, 0, sizeof(cmd->fs));
+				cmd->fs = f->fs;
 				err = 0;
 				break;
 			}
@@ -56,7 +58,7 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 				err = -EMSGSIZE;
 				break;
 			}
-			rule_locs[cnt] = f->loc;
+			rule_locs[cnt] = f->fs.location;
 			cnt++;
 		}
 		if (!err)
@@ -158,7 +160,7 @@ static int idpf_add_flow_steer(struct net_device *netdev,
 	struct idpf_vport *vport;
 	u32 flow_type, q_index;
 	u16 num_rxq;
-	int err;
+	int err = 0;
 
 	vport = idpf_netdev_to_vport(netdev);
 	vport_config = vport->adapter->vport_config[np->vport_idx];
@@ -184,6 +186,29 @@ static int idpf_add_flow_steer(struct net_device *netdev,
 	if (!rule)
 		return -ENOMEM;
 
+	fltr = kzalloc(sizeof(*fltr), GFP_KERNEL);
+	if (!fltr) {
+		err = -ENOMEM;
+		goto out_free_rule;
+	}
+
+	/* detect duplicate entry and reject before adding rules */
+	spin_lock_bh(&vport_config->flow_steer_list_lock);
+	list_for_each_entry(f, &user_config->flow_steer_list, list) {
+		if (f->fs.location == fsp->location) {
+			err = -EEXIST;
+			break;
+		}
+
+		if (f->fs.location > fsp->location)
+			break;
+		parent = f;
+	}
+	spin_unlock_bh(&vport_config->flow_steer_list_lock);
+
+	if (err)
+		goto out;
+
 	rule->vport_id = cpu_to_le32(vport->vport_id);
 	rule->count = cpu_to_le32(1);
 	info = &rule->rule_info[0];
@@ -222,28 +247,20 @@ static int idpf_add_flow_steer(struct net_device *netdev,
 		goto out;
 	}
 
-	fltr = kzalloc(sizeof(*fltr), GFP_KERNEL);
-	if (!fltr) {
-		err = -ENOMEM;
-		goto out;
-	}
+	/* Save a copy of the user's flow spec so ethtool can later retrieve it */
+	fltr->fs = *fsp;
 
-	fltr->loc = fsp->location;
-	fltr->q_index = q_index;
 	spin_lock_bh(&vport_config->flow_steer_list_lock);
-	list_for_each_entry(f, &user_config->flow_steer_list, list) {
-		if (f->loc >= fltr->loc)
-			break;
-		parent = f;
-	}
-
 	parent ? list_add(&fltr->list, &parent->list) :
 		 list_add(&fltr->list, &user_config->flow_steer_list);
 
 	user_config->num_fsteer_fltrs++;
 	spin_unlock_bh(&vport_config->flow_steer_list_lock);
+	goto out_free_rule;
 
 out:
+	kfree(fltr);
+out_free_rule:
 	kfree(rule);
 	return err;
 }
@@ -297,14 +314,14 @@ static int idpf_del_flow_steer(struct net_device *netdev,
 	spin_lock_bh(&vport_config->flow_steer_list_lock);
 	list_for_each_entry_safe(f, iter,
 				 &user_config->flow_steer_list, list) {
-		if (f->loc == fsp->location) {
+		if (f->fs.location == fsp->location) {
 			list_del(&f->list);
 			kfree(f);
 			user_config->num_fsteer_fltrs--;
 			goto out_unlock;
 		}
 	}
-	err = -EINVAL;
+	err = -ENOENT;
 
 out_unlock:
 	spin_unlock_bh(&vport_config->flow_steer_list_lock);
-- 
2.43.0


