Return-Path: <netdev+bounces-213876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B3B2731C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50871BC0FBC
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F02882AF;
	Thu, 14 Aug 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXEy9tjV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EF22577C
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755215033; cv=none; b=XFoXlHmbIckOlL3fLdFZqSpBDnB8zIuF56PYl/P5jIEfWzuzoXCxv+cwjcGuNPUuvGO9YLuHqb6GO4pmNlbv/JLV7PX3X4uKdCh/9nYLLeUI0/MUj+VcLkRfR1XJd7yo+1hbhFnz5j0VwDHB8N/xcei44zOSn8d+rz/xDgkHyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755215033; c=relaxed/simple;
	bh=6OdWZb19OX2HpH2y0378xB1uyIm7WipJ1iU4Gtu0iGc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DVUwI+0K8SJXgGAXbqAkrTfpktdVu59trrVA6qIOa/4YEvoJ9y+6a55k8EzRu9J8o+J9h9tHZxvQAtvF98sNG6jgkyc1oezswkiDQs8eDLrjtOXES0uUSwRKUeurxPK9q2VStPD4QeaztxIfuCVs6YEzs+6jvqCpdUXg6M8LtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXEy9tjV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755215032; x=1786751032;
  h=from:to:cc:subject:date:message-id;
  bh=6OdWZb19OX2HpH2y0378xB1uyIm7WipJ1iU4Gtu0iGc=;
  b=nXEy9tjVLKQW4kKx/QJDExkJ21szoGGkLy3uZyzIbMyYSGZ+7zj6C1Gl
   ptf2D7lVZn0AV7BArakbXlFP9KjnLNdP0skPAAZXa+e6/9fWjTUWnpQtl
   jArBJZ5UTKnYtK3i0DsK7+frGAuEYUAvul09zl1t+YdbjgyJuTuO4NFEw
   cKMLsEia5RQrCmXx91BKtTHaZ3enYCVvPvVCA156y/2VZMZuN2TxqlKI2
   opPu1Kfqw/aCRG0F//u+n3ZE6Ps4oRhhRt2LdmbdhxkhUcoI2s3q/E6aU
   a4lbYk5sxWX4OUccXXFvFQTmfasQ/WAKdtF51+RQRaFTFweWYLvbZEKih
   Q==;
X-CSE-ConnectionGUID: vYZZHkphTb25W/i8HVK2Tg==
X-CSE-MsgGUID: JetxC7JSTMO+hBSXSK4J7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="74994577"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="74994577"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:43:51 -0700
X-CSE-ConnectionGUID: /ALntabWRxyYZvNXNHNh2A==
X-CSE-MsgGUID: nRfHu1FOTZCEBJBXHCW7AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166099831"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2025 16:43:51 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jianliu@redhat.com,
	mschmidt@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	pmenzel@molgen.mpg.de
Subject: [PATCH iwl-net v3] idpf: set mac type when adding and removing MAC filters
Date: Thu, 14 Aug 2025 16:43:00 -0700
Message-Id: <20250814234300.2926-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On control planes that allow changing the MAC address of the interface,
the driver must provide a MAC type to avoid errors such as:

idpf 0000:0a:00.0: Transaction failed (op 535)
idpf 0000:0a:00.0: Received invalid MAC filter payload (op 535) (len 0)
idpf 0000:0a:00.0: Transaction failed (op 536)

These errors occur during driver load or when changing the MAC via:
ip link set <iface> address <mac>

Add logic to set the MAC type when sending ADD/DEL (opcodes 535/536) to
the control plane. Since only one primary MAC is supported per vport, the
driver only needs to send an ADD opcode when setting it. Remove the old
address by calling __idpf_del_mac_filter(), which skips the message and
just clears the entry from the internal list. This avoids an error on DEL
as it attempts to remove an address already cleared by the preceding ADD
opcode.

Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
Reported-by: Jian Liu <jianliu@redhat.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
Changelog:
v3:
- Update the commit message to clarify the change in logic from ADD/DEL 
  to just ADD in idpf_set_mac() is to avoid another case where the control plane will 
  return an error.
- s/old_address/old_mac_address/g
- Refactored idpf_set_mac_type() to use ternary operator for setting
  the MAC type based on whether the address is primary or not.

v2:
- Make sure to clear the primary MAC from the internal list, following
  successful change.
- Update the description to include the error on 536 opcode and
  mention the removal of the old address.

v1:
https://lore.kernel.org/intel-wired-lan/20250806192130.3197-1-emil.s.tantilov@intel.com/
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  9 ++++++---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 12 ++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 2c2a3e85d693..513032cb5f08 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2344,6 +2344,7 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
 	struct sockaddr *addr = p;
+	u8 old_mac_addr[ETH_ALEN];
 	struct idpf_vport *vport;
 	int err = 0;
 
@@ -2367,17 +2368,19 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	if (ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		goto unlock_mutex;
 
+	ether_addr_copy(old_mac_addr, vport->default_mac_addr);
+	ether_addr_copy(vport->default_mac_addr, addr->sa_data);
 	vport_config = vport->adapter->vport_config[vport->idx];
 	err = idpf_add_mac_filter(vport, np, addr->sa_data, false);
 	if (err) {
 		__idpf_del_mac_filter(vport_config, addr->sa_data);
+		ether_addr_copy(vport->default_mac_addr, netdev->dev_addr);
 		goto unlock_mutex;
 	}
 
-	if (is_valid_ether_addr(vport->default_mac_addr))
-		idpf_del_mac_filter(vport, np, vport->default_mac_addr, false);
+	if (is_valid_ether_addr(old_mac_addr))
+		__idpf_del_mac_filter(vport_config, old_mac_addr);
 
-	ether_addr_copy(vport->default_mac_addr, addr->sa_data);
 	eth_hw_addr_set(netdev, addr->sa_data);
 
 unlock_mutex:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index a028c69f7fdc..6330d4a0ae07 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3765,6 +3765,16 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
 	return le32_to_cpu(vport_msg->vport_id);
 }
 
+static void idpf_set_mac_type(struct idpf_vport *vport,
+			      struct virtchnl2_mac_addr *mac_addr)
+{
+	bool is_primary;
+
+	is_primary = ether_addr_equal(vport->default_mac_addr, mac_addr->addr);
+	mac_addr->type = is_primary ? VIRTCHNL2_MAC_ADDR_PRIMARY :
+				      VIRTCHNL2_MAC_ADDR_EXTRA;
+}
+
 /**
  * idpf_mac_filter_async_handler - Async callback for mac filters
  * @adapter: private data struct
@@ -3894,6 +3904,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 			    list) {
 		if (add && f->add) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->add = false;
 			if (i == total_filters)
@@ -3901,6 +3912,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 		}
 		if (!add && f->remove) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->remove = false;
 			if (i == total_filters)
-- 
2.37.3


