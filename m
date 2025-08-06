Return-Path: <netdev+bounces-211973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38DB1CC75
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 21:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F0956460E
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 19:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897DA291C02;
	Wed,  6 Aug 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMZcAcx0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E9215F6C
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508143; cv=none; b=dpTMzVgs8r8xPKiLosKIe9WS6Y31bKbOpgzTnH8NrDCTmyt7UXVljEjySq2/bNeHxyEI4GJ13/tB368fE9R78jmZx4hJuD0wOsqrTh5MNmI95Bi11OZe/IlPaRdWjwcZ0L0xpquZTcSbw6d/EDrB2fEsKUY3mmQwzOop4sDg6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508143; c=relaxed/simple;
	bh=PBgzgXlnFwuVjfkiimgPrmli4Kh0Vf3fNYbs219ZXz4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EtvYh3kzd/7KhRUqft4lVh9FwyBPHwyLr5a+or3JAALKFkyihtVbe+6eRLbvFhSysFJY6YoPqulRUaThpZi82WSTTajCEQUW1n0NjJfUQp7HRMjS7KALHhsVu64KM0ntFUDKYebEGy0N/AGqDptWBL987QdB/EqfBKEbKZGM7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMZcAcx0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754508142; x=1786044142;
  h=from:to:cc:subject:date:message-id;
  bh=PBgzgXlnFwuVjfkiimgPrmli4Kh0Vf3fNYbs219ZXz4=;
  b=DMZcAcx01ueRNUu4mxQOvKdHJJzzlV8mMi2JdgLf8ssnwdFadWMIakVb
   7t297jbXGnwgbioawBKUb+w1jPHy7IRNGv7KxXi3MFXllZDm1SnZ5Jx8/
   W+gfWq5XGYdkJH3t5yixxzNYCgtX/7syCy/j7v0i5zaZlvPpFgWdcc5zC
   WVFbX5eld5xHBpHNmjZQHg4vjyKwIPlRt5RYH2VMZF8BwP/epQkiz725Z
   Wf+wi8aKtSrWNxkTFt9nOwPE7mG+vt61QVnq4dFbNjiKLFCpsQv0rfDkN
   gorXEDUCnAL8ITZ2I28PwCXYzGsiedK5BH4WanNo67ox8B4CUiXwqvStj
   g==;
X-CSE-ConnectionGUID: +n9yd/zlSFO7PQSpuXE4Ig==
X-CSE-MsgGUID: InE4yOA9SvWy+v2DDAghYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56050244"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56050244"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 12:22:21 -0700
X-CSE-ConnectionGUID: azGAOUoMSdSZS8fTXhCKdA==
X-CSE-MsgGUID: 4MemTOF5RUqEYpqi51pEhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170123379"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa004.fm.intel.com with ESMTP; 06 Aug 2025 12:22:21 -0700
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
	willemb@google.com
Subject: [PATCH iwl-net] idpf: set mac type when adding and removing MAC filters
Date: Wed,  6 Aug 2025 12:21:30 -0700
Message-Id: <20250806192130.3197-1-emil.s.tantilov@intel.com>
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

These errors occur during driver load or when changing the MAC via:
ip link set <iface> address <mac>

Add logic to set the MAC type before performing ADD/DEL operations.
Since only one primary MAC is supported per vport, the driver only needs
to perform ADD in idpf_set_mac().

Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
Reported-by: Jian Liu <jianliu@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  6 ++----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 80382ff4a5fa..77d554b0944b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2284,17 +2284,15 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	if (ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		goto unlock_mutex;
 
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
-
-	ether_addr_copy(vport->default_mac_addr, addr->sa_data);
 	eth_hw_addr_set(netdev, addr->sa_data);
 
 unlock_mutex:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 24febaaa8fbb..7563289dc1e3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3507,6 +3507,15 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
 	return le32_to_cpu(vport_msg->vport_id);
 }
 
+static void idpf_set_mac_type(struct idpf_vport *vport,
+			      struct virtchnl2_mac_addr *mac_addr)
+{
+	if (ether_addr_equal(vport->default_mac_addr, mac_addr->addr))
+		mac_addr->type = VIRTCHNL2_MAC_ADDR_PRIMARY;
+	else
+		mac_addr->type = VIRTCHNL2_MAC_ADDR_EXTRA;
+}
+
 /**
  * idpf_mac_filter_async_handler - Async callback for mac filters
  * @adapter: private data struct
@@ -3636,6 +3645,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 			    list) {
 		if (add && f->add) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->add = false;
 			if (i == total_filters)
@@ -3643,6 +3653,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 		}
 		if (!add && f->remove) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->remove = false;
 			if (i == total_filters)
-- 
2.37.3


