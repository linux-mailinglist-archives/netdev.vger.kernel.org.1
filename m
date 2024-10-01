Return-Path: <netdev+bounces-130893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D081F98BE79
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E29F2821C5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E41C7B74;
	Tue,  1 Oct 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rPSAurOU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF811C6F58;
	Tue,  1 Oct 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790692; cv=none; b=GErrX6VL0f6OeDbcZZ8uQQ1xumKEL86TV4u3xzQhN66SDdRwVq3xFD0lSGj833gwXoIvVrL/+6M/NMnU1/dO1b/R4bOkfnT6iH5fobeEKhtxTfDt+giNFBK6GPT18IDXTLMzQ+aBQKCusFCYGHqNmAC2878YFxqXDh5JGAvFSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790692; c=relaxed/simple;
	bh=nyWRTdX8w9cLaNZ0pXNis3d4Qg0mu0iewO0RMK+0WIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ibCa5xr6+G39Yzz7MYnQNaPfxYezF1z3kxxfLG6s5HrYEoWRlJPkp/m7+4DfpSfVrdWEnw5ikahbKj7+ktfPDV0Nnna+fSzopdoccSLVazptzfzGN84BcBbzhdFKcm5rpf/g5juwf93JEx05Lp+wJmUuOKYksq1gZXYE062Gwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rPSAurOU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790690; x=1759326690;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nyWRTdX8w9cLaNZ0pXNis3d4Qg0mu0iewO0RMK+0WIo=;
  b=rPSAurOUr8InX8MbVrX2EfUuc3nL8iVy4UFZPRQKcM3Wnt60buDbwpfk
   hID1ypZZReSYyPYuFhOi48vk/wd5VP09ZJzbf3oHRhwkdLqBgh9RqbsPI
   W62vFv5kM0pDpFDoU4HqATSVKnX4zWahWiuYSHZt8NSVcL2nw2s04EYbr
   zGjML2dVh56yZeu3D/s9A0UiyYMZopu9jvh1QsWFJkVJuthJkNAdhsPKa
   yMWAYwpDHXo7emBDaBtZMs4GDdXJaFDbc1kDAIWKKseO46AhiIyS5asm+
   +/mLjpqimM4mN/B7sFr5vTWEFC5ZB671GK8E2eS6kf8XQFRKWdVmkvEFz
   w==;
X-CSE-ConnectionGUID: xZlwFxFMQxGj0XznyNUoig==
X-CSE-MsgGUID: 457mZgCYTbmbECTFVtBwiw==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33057487"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:09 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:06 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:33 +0200
Subject: [PATCH net-next 03/15] net: sparx5: rename *spx5 to *sparx5 in a
 few places
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-3-8c6896fdce66@microchip.com>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x, we need to handle platform specific
constants (which will be added in a subsequent patch). These constants
will be accessed through a macro that requires the *sparx5 context
pointer to be called exactly that.

Therefore rename *spx5 to *sparx5 in a few places.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  6 +--
 .../net/ethernet/microchip/sparx5/sparx5_pgid.c    | 18 ++++----
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   | 48 +++++++++++-----------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index e3f22b730d80..fdff83537418 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -438,9 +438,9 @@ enum sparx5_pgid_type {
 	SPX5_PGID_MULTICAST,
 };
 
-void sparx5_pgid_init(struct sparx5 *spx5);
-int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx);
-int sparx5_pgid_free(struct sparx5 *spx5, u16 idx);
+void sparx5_pgid_init(struct sparx5 *sparx5);
+int sparx5_pgid_alloc_mcast(struct sparx5 *sparx5, u16 *idx);
+int sparx5_pgid_free(struct sparx5 *sparx5, u16 idx);
 
 /* sparx5_pool.c */
 struct sparx5_pool_entry {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c b/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
index af8b435009f4..97adccea5352 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_pgid.c
@@ -1,21 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include "sparx5_main.h"
 
-void sparx5_pgid_init(struct sparx5 *spx5)
+void sparx5_pgid_init(struct sparx5 *sparx5)
 {
 	int i;
 
 	for (i = 0; i < PGID_TABLE_SIZE; i++)
-		spx5->pgid_map[i] = SPX5_PGID_FREE;
+		sparx5->pgid_map[i] = SPX5_PGID_FREE;
 
 	/* Reserved for unicast, flood control, broadcast, and CPU.
 	 * These cannot be freed.
 	 */
 	for (i = 0; i <= PGID_CPU; i++)
-		spx5->pgid_map[i] = SPX5_PGID_RESERVED;
+		sparx5->pgid_map[i] = SPX5_PGID_RESERVED;
 }
 
-int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx)
+int sparx5_pgid_alloc_mcast(struct sparx5 *sparx5, u16 *idx)
 {
 	int i;
 
@@ -23,8 +23,8 @@ int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx)
 	 * are reserved for flood masks and CPU. Start alloc after that.
 	 */
 	for (i = PGID_MCAST_START; i < PGID_TABLE_SIZE; i++) {
-		if (spx5->pgid_map[i] == SPX5_PGID_FREE) {
-			spx5->pgid_map[i] = SPX5_PGID_MULTICAST;
+		if (sparx5->pgid_map[i] == SPX5_PGID_FREE) {
+			sparx5->pgid_map[i] = SPX5_PGID_MULTICAST;
 			*idx = i;
 			return 0;
 		}
@@ -33,14 +33,14 @@ int sparx5_pgid_alloc_mcast(struct sparx5 *spx5, u16 *idx)
 	return -EBUSY;
 }
 
-int sparx5_pgid_free(struct sparx5 *spx5, u16 idx)
+int sparx5_pgid_free(struct sparx5 *sparx5, u16 idx)
 {
 	if (idx <= PGID_CPU || idx >= PGID_TABLE_SIZE)
 		return -EINVAL;
 
-	if (spx5->pgid_map[idx] == SPX5_PGID_FREE)
+	if (sparx5->pgid_map[idx] == SPX5_PGID_FREE)
 		return -EINVAL;
 
-	spx5->pgid_map[idx] = SPX5_PGID_FREE;
+	sparx5->pgid_map[idx] = SPX5_PGID_FREE;
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index 0b4abc3eb53d..bcee9adcfbdb 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -359,10 +359,10 @@ static int sparx5_switchdev_event(struct notifier_block *nb,
 	struct sparx5_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info;
 	struct switchdev_notifier_info *info = ptr;
-	struct sparx5 *spx5;
+	struct sparx5 *sparx5;
 	int err;
 
-	spx5 = container_of(nb, struct sparx5, switchdev_nb);
+	sparx5 = container_of(nb, struct sparx5, switchdev_nb);
 
 	switch (event) {
 	case SWITCHDEV_PORT_ATTR_SET:
@@ -379,7 +379,7 @@ static int sparx5_switchdev_event(struct notifier_block *nb,
 
 		switchdev_work->dev = dev;
 		switchdev_work->event = event;
-		switchdev_work->sparx5 = spx5;
+		switchdev_work->sparx5 = sparx5;
 
 		fdb_info = container_of(info,
 					struct switchdev_notifier_fdb_info,
@@ -503,10 +503,10 @@ static struct sparx5_mdb_entry *sparx5_mdb_get_entry(struct sparx5 *sparx5,
 	return found;
 }
 
-static void sparx5_cpu_copy_ena(struct sparx5 *spx5, u16 pgid, bool enable)
+static void sparx5_cpu_copy_ena(struct sparx5 *sparx5, u16 pgid, bool enable)
 {
 	spx5_rmw(ANA_AC_PGID_MISC_CFG_PGID_CPU_COPY_ENA_SET(enable),
-		 ANA_AC_PGID_MISC_CFG_PGID_CPU_COPY_ENA, spx5,
+		 ANA_AC_PGID_MISC_CFG_PGID_CPU_COPY_ENA, sparx5,
 		 ANA_AC_PGID_MISC_CFG(pgid));
 }
 
@@ -515,7 +515,7 @@ static int sparx5_handle_port_mdb_add(struct net_device *dev,
 				      const struct switchdev_obj_port_mdb *v)
 {
 	struct sparx5_port *port = netdev_priv(dev);
-	struct sparx5 *spx5 = port->sparx5;
+	struct sparx5 *sparx5 = port->sparx5;
 	struct sparx5_mdb_entry *entry;
 	bool is_host, is_new;
 	int err, i;
@@ -529,40 +529,40 @@ static int sparx5_handle_port_mdb_add(struct net_device *dev,
 	/* When VLAN unaware the vlan value is not parsed and we receive vid 0.
 	 * Fall back to bridge vid 1.
 	 */
-	if (!br_vlan_enabled(spx5->hw_bridge_dev))
+	if (!br_vlan_enabled(sparx5->hw_bridge_dev))
 		vid = 1;
 	else
 		vid = v->vid;
 
 	is_new = false;
-	entry = sparx5_mdb_get_entry(spx5, v->addr, vid);
+	entry = sparx5_mdb_get_entry(sparx5, v->addr, vid);
 	if (!entry) {
-		err = sparx5_alloc_mdb_entry(spx5, v->addr, vid, &entry);
+		err = sparx5_alloc_mdb_entry(sparx5, v->addr, vid, &entry);
 		is_new = true;
 		if (err)
 			return err;
 	}
 
-	mutex_lock(&spx5->mdb_lock);
+	mutex_lock(&sparx5->mdb_lock);
 
 	/* Add any mrouter ports to the new entry */
 	if (is_new && ether_addr_is_ip_mcast(v->addr))
 		for (i = 0; i < SPX5_PORTS; i++)
-			if (spx5->ports[i] && spx5->ports[i]->is_mrouter)
-				sparx5_pgid_update_mask(spx5->ports[i],
+			if (sparx5->ports[i] && sparx5->ports[i]->is_mrouter)
+				sparx5_pgid_update_mask(sparx5->ports[i],
 							entry->pgid_idx,
 							true);
 
 	if (is_host && !entry->cpu_copy) {
-		sparx5_cpu_copy_ena(spx5, entry->pgid_idx, true);
+		sparx5_cpu_copy_ena(sparx5, entry->pgid_idx, true);
 		entry->cpu_copy = true;
 	} else if (!is_host) {
 		sparx5_pgid_update_mask(port, entry->pgid_idx, true);
 		set_bit(port->portno, entry->port_mask);
 	}
-	mutex_unlock(&spx5->mdb_lock);
+	mutex_unlock(&sparx5->mdb_lock);
 
-	sparx5_mact_learn(spx5, entry->pgid_idx, entry->addr, entry->vid);
+	sparx5_mact_learn(sparx5, entry->pgid_idx, entry->addr, entry->vid);
 
 	return 0;
 }
@@ -572,7 +572,7 @@ static int sparx5_handle_port_mdb_del(struct net_device *dev,
 				      const struct switchdev_obj_port_mdb *v)
 {
 	struct sparx5_port *port = netdev_priv(dev);
-	struct sparx5 *spx5 = port->sparx5;
+	struct sparx5 *sparx5 = port->sparx5;
 	struct sparx5_mdb_entry *entry;
 	bool is_host;
 	u16 vid;
@@ -582,18 +582,18 @@ static int sparx5_handle_port_mdb_del(struct net_device *dev,
 
 	is_host = netif_is_bridge_master(v->obj.orig_dev);
 
-	if (!br_vlan_enabled(spx5->hw_bridge_dev))
+	if (!br_vlan_enabled(sparx5->hw_bridge_dev))
 		vid = 1;
 	else
 		vid = v->vid;
 
-	entry = sparx5_mdb_get_entry(spx5, v->addr, vid);
+	entry = sparx5_mdb_get_entry(sparx5, v->addr, vid);
 	if (!entry)
 		return 0;
 
-	mutex_lock(&spx5->mdb_lock);
+	mutex_lock(&sparx5->mdb_lock);
 	if (is_host && entry->cpu_copy) {
-		sparx5_cpu_copy_ena(spx5, entry->pgid_idx, false);
+		sparx5_cpu_copy_ena(sparx5, entry->pgid_idx, false);
 		entry->cpu_copy = false;
 	} else if (!is_host) {
 		clear_bit(port->portno, entry->port_mask);
@@ -602,15 +602,15 @@ static int sparx5_handle_port_mdb_del(struct net_device *dev,
 		if (!port->is_mrouter || !ether_addr_is_ip_mcast(v->addr))
 			sparx5_pgid_update_mask(port, entry->pgid_idx, false);
 	}
-	mutex_unlock(&spx5->mdb_lock);
+	mutex_unlock(&sparx5->mdb_lock);
 
 	if (bitmap_empty(entry->port_mask, SPX5_PORTS) && !entry->cpu_copy) {
 		 /* Clear pgid in case mrouter ports exists
 		  * that are not part of the group.
 		  */
-		sparx5_pgid_clear(spx5, entry->pgid_idx);
-		sparx5_mact_forget(spx5, entry->addr, entry->vid);
-		sparx5_free_mdb_entry(spx5, entry->addr, entry->vid);
+		sparx5_pgid_clear(sparx5, entry->pgid_idx);
+		sparx5_mact_forget(sparx5, entry->addr, entry->vid);
+		sparx5_free_mdb_entry(sparx5, entry->addr, entry->vid);
 	}
 	return 0;
 }

-- 
2.34.1


