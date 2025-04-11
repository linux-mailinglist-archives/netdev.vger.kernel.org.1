Return-Path: <netdev+bounces-181775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AE1A8677A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F55F7AFE1A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4A290082;
	Fri, 11 Apr 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQSm5cas"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA412857D1
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404251; cv=none; b=RyRghBcgAp7jLboR7BdDy2LJFnx6f/f0He2gQIw7DvHLijuzDiLwJ6aSxsQK0fwfKeBoxYzDxqY3gFX+W/Up4l1ozfnomLmaI33KN7+VJhCiQYxSoxczSFaGuqfoP+eQKsR/ljB1+hrF1Ee5wkBAAl0TMxbMod9JVdWwRaQ4yYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404251; c=relaxed/simple;
	bh=dhPPyebIl3Bhc1ADiKkeEuBCLtwAqTgNI7QXNC6e89M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc4mQtZ8dZYCkK5GT2jfNQZysA3ZeGCAAkOA5nP7eFRS451g8/eVOYNMIZXnY7nvRsYsUms2+K32mUe7t0FBC88qugDgPluPVdGeIw0ajNAVJ9UogxdnnDO3+rVOmZeZ2aRKLco2uepO4XS8HapiBlMyqqPUXxZGCOs230T+YiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQSm5cas; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404249; x=1775940249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dhPPyebIl3Bhc1ADiKkeEuBCLtwAqTgNI7QXNC6e89M=;
  b=aQSm5cas/nvucyuonMZZINn4zZBnYp/B78sT/nvvvT7QOh9N4UWhrxHC
   UWtm/YlqnwRnCV/weSHr681WYa1zMugDoX52uezUVYajidHsdaoxJ//jS
   twuS9CKDomUz3UhSkrqQEJ9JLh02+Egm/j/GNINMSBWLwTWxDLA2LzixK
   dnKAzRax72tEQO72kT1+tP2qVmikJ45k2rzoW9uFCvinHk3HwyG2CZyuN
   kFy7+iX2ZiBwA9eg9oQMMYtvq7o8ywdYcZb99D15lw6oL/W1dlMbYHSkI
   uY9bjg+uRlWhsv7wVzXtQ08Q6VyEnAwOHTJqQKL6y5YJf9t4p65t+M5gy
   w==;
X-CSE-ConnectionGUID: 3vHUdAYBToGlc5ct8bE7uA==
X-CSE-MsgGUID: jX7LHYnFSLekoO7E8Ad8mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103857"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103857"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:06 -0700
X-CSE-ConnectionGUID: yxkhsp8TQIu+rtodWjKoFA==
X-CSE-MsgGUID: PoY3AI0eScef5NssBb4Ckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241801"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	anthony.l.nguyen@intel.com,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 03/15] ice: receive LLDP on trusted VFs
Date: Fri, 11 Apr 2025 13:43:44 -0700
Message-ID: <20250411204401.3271306-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>

When a trusted VF tries to configure an LLDP multicast address, configure a
rule that would mirror the traffic to this VF, untrusted VFs are not
allowed to receive LLDP at all, so the request to add LLDP MAC address will
always fail for them.

Add a forwarding LLDP filter to a trusted VF when it tries to add an LLDP
multicast MAC address. The MAC address has to be added after enabling
trust (through restarting the LLDP service).

Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 48 ++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.h      |  3 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  4 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 26 +++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  8 +++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 53 +++++++++++++++++--
 8 files changed, 134 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index a7c510832824..67988c7ab08e 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -846,7 +846,7 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 			goto dcb_init_err;
 		}
 
-		ice_cfg_sw_lldp(pf_vsi, false, true);
+		ice_cfg_sw_rx_lldp(pf, true);
 
 		pf->dcbx_cap = ice_dcb_get_mode(port_info, true);
 		return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 7c2dc347e4e5..648815170477 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1818,7 +1818,7 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 			/* Remove rule to direct LLDP packets to default VSI.
 			 * The FW LLDP engine will now be consuming them.
 			 */
-			ice_cfg_sw_lldp(vsi, false, false);
+			ice_cfg_sw_rx_lldp(vsi->back, false);
 
 			/* AQ command to start FW LLDP agent will return an
 			 * error if the agent is already started
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 542b76b5707a..03bb16191237 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2065,12 +2065,15 @@ static void ice_vsi_set_tc_cfg(struct ice_vsi *vsi)
 }
 
 /**
- * ice_cfg_sw_lldp - Config switch rules for LLDP packet handling
+ * ice_vsi_cfg_sw_lldp - Config switch rules for LLDP packet handling
  * @vsi: the VSI being configured
  * @tx: bool to determine Tx or Rx rule
  * @create: bool to determine create or remove Rule
+ *
+ * Adding an ethtype Tx rule to the uplink VSI results in it being applied
+ * to the whole port, so LLDP transmission for VFs will be blocked too.
  */
-void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
+void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 {
 	int (*eth_fltr)(struct ice_vsi *v, u16 type, u16 flag,
 			enum ice_sw_fwd_act_type act);
@@ -2109,6 +2112,37 @@ void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 			 vsi->vsi_num, status);
 }
 
+/**
+ * ice_cfg_sw_rx_lldp - Enable/disable software handling of LLDP
+ * @pf: the PF being configured
+ * @enable: enable or disable
+ *
+ * Configure switch rules to enable/disable LLDP handling by software
+ * across PF.
+ */
+void ice_cfg_sw_rx_lldp(struct ice_pf *pf, bool enable)
+{
+	struct ice_vsi *vsi;
+	struct ice_vf *vf;
+	unsigned int bkt;
+
+	vsi = ice_get_main_vsi(pf);
+	ice_vsi_cfg_sw_lldp(vsi, false, enable);
+
+	if (!test_bit(ICE_FLAG_SRIOV_ENA, pf->flags))
+		return;
+
+	ice_for_each_vf(pf, bkt, vf) {
+		vsi = ice_get_vf_vsi(vf);
+
+		if (WARN_ON(!vsi))
+			continue;
+
+		if (ice_vf_is_lldp_ena(vf))
+			ice_vsi_cfg_sw_lldp(vsi, false, enable);
+	}
+}
+
 /**
  * ice_set_agg_vsi - sets up scheduler aggregator node and move VSI into it
  * @vsi: pointer to the VSI
@@ -2537,7 +2571,7 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params)
 	if (!ice_is_safe_mode(pf) && vsi->type == ICE_VSI_PF) {
 		ice_fltr_add_eth(vsi, ETH_P_PAUSE, ICE_FLTR_TX,
 				 ICE_DROP_PACKET);
-		ice_cfg_sw_lldp(vsi, true, true);
+		ice_vsi_cfg_sw_lldp(vsi, true, true);
 	}
 
 	if (!vsi->agg_node)
@@ -2834,9 +2868,11 @@ int ice_vsi_release(struct ice_vsi *vsi)
 	/* The Rx rule will only exist to remove if the LLDP FW
 	 * engine is currently stopped
 	 */
-	if (!ice_is_safe_mode(pf) && vsi->type == ICE_VSI_PF &&
-	    !test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
-		ice_cfg_sw_lldp(vsi, false, false);
+	if (!ice_is_safe_mode(pf) &&
+	    !test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags) &&
+	    (vsi->type == ICE_VSI_PF || (vsi->type == ICE_VSI_VF &&
+	     ice_vf_is_lldp_ena(vsi->vf))))
+		ice_vsi_cfg_sw_lldp(vsi, false, false);
 
 	ice_vsi_decfg(vsi);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index b4c9cb28a016..654516c5fc3e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -29,7 +29,8 @@ ice_vsi_stop_lan_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 
 int ice_vsi_stop_xdp_tx_rings(struct ice_vsi *vsi);
 
-void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create);
+void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create);
+void ice_cfg_sw_rx_lldp(struct ice_pf *pf, bool enable);
 
 int ice_set_link(struct ice_vsi *vsi, bool ena);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index f1648cf103b7..0e4dc1a5cff0 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -63,6 +63,7 @@ static void ice_free_vf_res(struct ice_vf *vf)
 	if (vf->lan_vsi_idx != ICE_NO_VSI) {
 		ice_vf_vsi_release(vf);
 		vf->num_mac = 0;
+		vf->num_mac_lldp = 0;
 	}
 
 	last_vector_idx = vf->first_vector_idx + vf->num_msix - 1;
@@ -1402,6 +1403,9 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
+	while (!trusted && vf->num_mac_lldp)
+		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
+
 	vf->trusted = trusted;
 	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 815ad0bfe832..48cd533e93b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -226,6 +226,7 @@ static void ice_vf_clear_counters(struct ice_vf *vf)
 		vsi->num_vlan = 0;
 
 	vf->num_mac = 0;
+	vf->num_mac_lldp = 0;
 	memset(&vf->mdd_tx_events, 0, sizeof(vf->mdd_tx_events));
 	memset(&vf->mdd_rx_events, 0, sizeof(vf->mdd_rx_events));
 }
@@ -1401,3 +1402,28 @@ struct ice_vsi *ice_get_vf_ctrl_vsi(struct ice_pf *pf, struct ice_vsi *vsi)
 	rcu_read_unlock();
 	return ctrl_vsi;
 }
+
+/**
+ * ice_vf_update_mac_lldp_num - update the VF's number of LLDP addresses
+ * @vf: a VF to add the address to
+ * @vsi: the corresponding VSI
+ * @incr: is the rule added or removed
+ */
+void ice_vf_update_mac_lldp_num(struct ice_vf *vf, struct ice_vsi *vsi,
+				bool incr)
+{
+	bool lldp_by_fw = test_bit(ICE_FLAG_FW_LLDP_AGENT, vsi->back->flags);
+	bool was_ena = ice_vf_is_lldp_ena(vf) && !lldp_by_fw;
+	bool is_ena;
+
+	if (WARN_ON(!vsi)) {
+		vf->num_mac_lldp = 0;
+		return;
+	}
+
+	vf->num_mac_lldp += incr ? 1 : -1;
+	is_ena = ice_vf_is_lldp_ena(vf) && !lldp_by_fw;
+
+	if (was_ena != is_ena)
+		ice_vsi_cfg_sw_lldp(vsi, false, is_ena);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 799b2c1f1184..f4c9ca1f51ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -134,6 +134,7 @@ struct ice_vf {
 	unsigned long vf_caps;		/* VF's adv. capabilities */
 	u8 num_req_qs;			/* num of queue pairs requested by VF */
 	u16 num_mac;
+	u16 num_mac_lldp;
 	u16 num_vf_qs;			/* num of queue configured per VF */
 	u8 vlan_strip_ena;		/* Outer and Inner VLAN strip enable */
 #define ICE_INNER_VLAN_STRIP_ENA	BIT(0)
@@ -180,6 +181,11 @@ static inline u16 ice_vf_get_port_vlan_tpid(struct ice_vf *vf)
 	return vf->port_vlan_info.tpid;
 }
 
+static inline bool ice_vf_is_lldp_ena(struct ice_vf *vf)
+{
+	return vf->num_mac_lldp && vf->trusted;
+}
+
 /* VF Hash Table access functions
  *
  * These functions provide abstraction for interacting with the VF hash table.
@@ -245,6 +251,8 @@ ice_vf_clear_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m);
 int ice_reset_vf(struct ice_vf *vf, u32 flags);
 void ice_reset_all_vfs(struct ice_pf *pf);
 struct ice_vsi *ice_get_vf_ctrl_vsi(struct ice_pf *pf, struct ice_vsi *vsi);
+void ice_vf_update_mac_lldp_num(struct ice_vf *vf, struct ice_vsi *vsi,
+				bool incr);
 #else /* CONFIG_PCI_IOV */
 static inline struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 7c3006eb68dd..b147f6cf2615 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -2265,6 +2265,51 @@ ice_vfhw_mac_add(struct ice_vf *vf, struct virtchnl_ether_addr *vc_ether_addr)
 	}
 }
 
+/**
+ * ice_is_mc_lldp_eth_addr - check if the given MAC is a multicast LLDP address
+ * @mac: address to check
+ *
+ * Return: true if the address is one of the three possible LLDP multicast
+ *	   addresses, false otherwise.
+ */
+static bool ice_is_mc_lldp_eth_addr(const u8 *mac)
+{
+	const u8 lldp_mac_base[] = {0x01, 0x80, 0xc2, 0x00, 0x00};
+
+	if (memcmp(mac, lldp_mac_base, sizeof(lldp_mac_base)))
+		return false;
+
+	return (mac[5] == 0x0e || mac[5] == 0x03 || mac[5] == 0x00);
+}
+
+/**
+ * ice_vc_can_add_mac - check if the VF is allowed to add a given MAC
+ * @vf: a VF to add the address to
+ * @mac: address to check
+ *
+ * Return: true if the VF is allowed to add such MAC address, false otherwise.
+ */
+static bool ice_vc_can_add_mac(const struct ice_vf *vf, const u8 *mac)
+{
+	struct device *dev = ice_pf_to_dev(vf->pf);
+
+	if (is_unicast_ether_addr(mac) &&
+	    !ice_can_vf_change_mac((struct ice_vf *)vf)) {
+		dev_err(dev,
+			"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
+		return false;
+	}
+
+	if (!vf->trusted && ice_is_mc_lldp_eth_addr(mac)) {
+		dev_warn(dev,
+			 "An untrusted VF %u is attempting to configure an LLDP multicast address\n",
+			 vf->vf_id);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * ice_vc_add_mac_addr - attempt to add the MAC address passed in
  * @vf: pointer to the VF info
@@ -2283,10 +2328,8 @@ ice_vc_add_mac_addr(struct ice_vf *vf, struct ice_vsi *vsi,
 	if (ether_addr_equal(mac_addr, vf->dev_lan_addr))
 		return 0;
 
-	if (is_unicast_ether_addr(mac_addr) && !ice_can_vf_change_mac(vf)) {
-		dev_err(dev, "VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
+	if (!ice_vc_can_add_mac(vf, mac_addr))
 		return -EPERM;
-	}
 
 	ret = ice_fltr_add_mac(vsi, mac_addr, ICE_FWD_TO_VSI);
 	if (ret == -EEXIST) {
@@ -2301,6 +2344,8 @@ ice_vc_add_mac_addr(struct ice_vf *vf, struct ice_vsi *vsi,
 		return ret;
 	} else {
 		vf->num_mac++;
+		if (ice_is_mc_lldp_eth_addr(mac_addr))
+			ice_vf_update_mac_lldp_num(vf, vsi, true);
 	}
 
 	ice_vfhw_mac_add(vf, vc_ether_addr);
@@ -2395,6 +2440,8 @@ ice_vc_del_mac_addr(struct ice_vf *vf, struct ice_vsi *vsi,
 	ice_vfhw_mac_del(vf, vc_ether_addr);
 
 	vf->num_mac--;
+	if (ice_is_mc_lldp_eth_addr(mac_addr))
+		ice_vf_update_mac_lldp_num(vf, vsi, false);
 
 	return 0;
 }
-- 
2.47.1


