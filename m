Return-Path: <netdev+bounces-247508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA090CFB6DF
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77F33090DFB
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F317A2FC;
	Wed,  7 Jan 2026 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O27hWILB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F978F26
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744421; cv=none; b=Puq9C17ErpohgHTcq63wkox7qJPTaEqX5rGDwzFxELG1djSoyTkxVmUc0BAQftqvCGw0eN9jawR+gzIoVbrjkpzhO83K+wZdq2gYAd6q9D7zMiezrcZ4L9OvRhDSqhdxppBP1yypj6WJ4TNpp5jPzANShxL7Ks8IfDeJ1dKTyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744421; c=relaxed/simple;
	bh=KVo2Yo+ctszDBHlooK1jFRQkfcVE1zTpATB0CXinmJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHcHsJDueh4wTU2kjMMErZQY8IlpU+Gyd0Qv5ZY4hqA4cwr3QG/5pdDoJj/o27r8h5oVx62+mNelHfeoKT5Wu9kdZA3lZpLuNmICaWwCTNT9sYvcPcf0/ykkl5zFreTF+4l1tcwEiRvYRtWFTXSlIdx96jsz5oWg6HAm2kLKXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O27hWILB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744419; x=1799280419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVo2Yo+ctszDBHlooK1jFRQkfcVE1zTpATB0CXinmJI=;
  b=O27hWILBUCI/csRFTrgiOt5Pfr1EBU0h6GKn8S4FntHUqYhJndBRsj4I
   pjyrgElPjuAdGYkaCogrO8/fYF8DV5gRA6C85sPO1t+bszqM7H4QIXeGK
   sUCAwz+0IT8IRJvBJYRLPuOhxII/LukNVhhA4/Jcg+4PZwg4TtXOja/Ow
   mugX+LtRl9fmn+MqOgEE4yMdG9+UydcFwx+ktCKPXSV1OkdOzd46M1X3u
   MInW69yt+hSbqxjgQLfU9dl8OEr8KkPz6/rizb6sPtVh6sm7kt+5X2LHR
   L7gq6LjMfQRtMt7KBdcsOkyh9oLYqvWrUErjea8iqhRj6odvhl4zQvXrw
   A==;
X-CSE-ConnectionGUID: Gu92FwNpQUeKx+Fy5yDfWQ==
X-CSE-MsgGUID: NERWLofiQQ2Ie0DsFqzu1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161651"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161651"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:54 -0800
X-CSE-ConnectionGUID: NpiyS8g4QWaITUjGxKmOqg==
X-CSE-MsgGUID: pa5kAu/jSDWcZ5NT5SZ2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841196"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
	anthony.l.nguyen@intel.com,
	sridhar.samudrala@intel.com,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net 07/13] idpf: fix issue with ethtool -n command display
Date: Tue,  6 Jan 2026 16:06:39 -0800
Message-ID: <20260107000648.1861994-8-anthony.l.nguyen@intel.com>
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
location and change logic to perform upfront validation of all error
conditions before adding flow rules through virtchnl. This avoids the
need for additional virtchnl delete messages when subsequent operations
fail, which was missing in the original upstream code.

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 59 ++++++++++++-------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index a61821333f5d..dab36c0c3cdc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -284,8 +284,7 @@ struct idpf_port_stats {
 
 struct idpf_fsteer_fltr {
 	struct list_head list;
-	u32 loc;
-	u32 q_index;
+	struct ethtool_rx_flow_spec fs;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 00481fec8179..7000f6283a33 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -54,11 +54,15 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
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
+				/* Avoid infoleak from padding: zero first,
+				 * then assign fields
+				 */
+				memset(&cmd->fs, 0, sizeof(cmd->fs));
+				cmd->fs = f->fs;
 				err = 0;
 				break;
 			}
@@ -72,7 +76,7 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 				err = -EMSGSIZE;
 				break;
 			}
-			rule_locs[cnt] = f->loc;
+			rule_locs[cnt] = f->fs.location;
 			cnt++;
 		}
 		if (!err)
@@ -174,7 +178,7 @@ static int idpf_add_flow_steer(struct net_device *netdev,
 	struct idpf_vport *vport;
 	u32 flow_type, q_index;
 	u16 num_rxq;
-	int err;
+	int err = 0;
 
 	vport = idpf_netdev_to_vport(netdev);
 	vport_config = vport->adapter->vport_config[np->vport_idx];
@@ -200,6 +204,29 @@ static int idpf_add_flow_steer(struct net_device *netdev,
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
@@ -238,28 +265,20 @@ static int idpf_add_flow_steer(struct net_device *netdev,
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
@@ -313,14 +332,14 @@ static int idpf_del_flow_steer(struct net_device *netdev,
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
2.47.1


