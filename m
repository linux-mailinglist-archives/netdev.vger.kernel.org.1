Return-Path: <netdev+bounces-226433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97E1BA045D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BAF7BC382
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68692EAD15;
	Thu, 25 Sep 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDAMlfrm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21B2E3B0D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813891; cv=none; b=rhJju3jvzN2Oxh7t2CdWS14qlko+ELKa/vYpoBO7W/KOlTv6UtW/6Zl7y+r0v5gpReEaIKl4x9k8FdK/K2be9B+UGPcA60WTgACfcGA7vWQFSCvsM6BfnYVjsI23XnzT186GZuw9Z5VYIZHdVIF42Mj6z6D2w563WtTi9PvXdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813891; c=relaxed/simple;
	bh=yaPLH+CvbobB9/kM4hvtASC4VGUUgHoNNmrLgIbY30w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eTMI0iqnuc8EW01yZ2edW2Xl8fWPc5j/EFgBwElgqG3r7SCJweLi27kPksNAIcFBpxBpQdL+ZhurR7uzTv/PxzYxqVx+j+gCOIFlUFX96D8q4l+Awsxzp9nXpWU5sYDaSZ1MILrxXhFmh9+wY+hVa1bEBckV/Mxlg02djGrJOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDAMlfrm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758813890; x=1790349890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yaPLH+CvbobB9/kM4hvtASC4VGUUgHoNNmrLgIbY30w=;
  b=SDAMlfrmjYacVqTKWiKfSxH5wm+Y4B+LrooGEw3lkmoCcBx7R8n3DUvw
   BAMRNFYK6nDsi+aGGtxHgX1ILdAjnf1MmTbc5zQt1xh6MH8ky2Ox9oiHJ
   Esov26OSxupXGmUF5FPIMpznuE9G9S/QqYKjoFbdqVyrGwNjKRGjiBnbK
   +sFKfsXeh19Fu1m+dGoGikTh7S00vywJ7kokLuE/c9QX8u4XKGIC3PlFB
   AMpw3CFU5cxb82XWcRjBdB9nmJ3g6zYAaeCRTHNNainKsspqjmGnjhGQG
   7MSfFGChMrBlujGMwUYBaeNivTHqlyBL8L3T+MsS7nw9NzxdaHNHPhuWB
   Q==;
X-CSE-ConnectionGUID: 1DbjHJblTiqc+AqT5YzrCg==
X-CSE-MsgGUID: 1zGD21deTbKzMkPT8PIXSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="78777078"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="78777078"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:24:49 -0700
X-CSE-ConnectionGUID: Tpzf8DvCRzWDDtaae5hesg==
X-CSE-MsgGUID: EVzQmLvLRG2DbtHYBA1ssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="177291718"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2025 08:24:49 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH] idpf: fix issue with ethtool -n command display
Date: Thu, 25 Sep 2025 10:24:40 -0500
Message-Id: <20250925152440.142107-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
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
2.25.1


