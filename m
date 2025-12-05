Return-Path: <netdev+bounces-243805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222FCA792A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 13:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF053061A66
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C048F32ED2C;
	Fri,  5 Dec 2025 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="bWBLRCF4"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3532BD00C;
	Fri,  5 Dec 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937986; cv=none; b=EVcLvIvEghUMt1UaK56fcOl1gOJgqG/DAdlDqWAjILK1IwEq4k3Str66ViYWokCy9niEYEDu4/4+u4sYHCpvSCXNSWePQ1okVk0je8cGHuZ+iwJoKy/LOFVGeIsausYitmPdEpe6+UQXpKPVOqovWyDoRXK9rIn93SD4wVrKO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937986; c=relaxed/simple;
	bh=tWRa8oyjUvpRsRdslinBFOdREKp5S/3MTxZX6fSdDQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgkEnAdYsfwydQH06b4LFQEZemyBxxRT9dzsB5MZpj91cGSNYEZ5mmaidHacdK8Icie5gEH+ObNNyyv8qRtOQOfQZ5qXNV6JH+8/gpJgkFhySyFvYupT6US/TK3rQ96GxYzPG3w2VJdjzOY0F0PKyiW1hlMbJRTf9d+6YrKeOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=bWBLRCF4; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oA0frL3VJZ0rF8taJyj3GSzziInjx5sYT3Kkvtv08QE=; b=bWBLRCF48oB7XQCMQoZMoCGPm1
	hS+MVEhM3fjSlZbq/m/2R0ZivzbnTB5p5dCy80M6mBHQSJM+dyig+DBI7x9oZlaZsJDOuKQi41Dzd
	sai8+IYJZXHfuO+8PvUIIiZOs3smpBjo36/j+MPRShvzThJgxXqtNlkO3riMMjo7l9P0dP2OKlSJw
	T+Mk4+Z+P18DPS344hW/0mM7hUC9suYEyjYVU0J1PsvjuHer6lxh69aBIi4zd732874qqAlg7aRPb
	pJha33HBf0SOy4kXSwTYd5IJckGPNVRMemefiqFgr8qlCq58Ki2i7N4YmLn0Wf2VINVWIdmh551fF
	PtJek/tA==;
Received: from [122.175.9.182] (port=9516 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vRUzb-00000003o4B-32hV;
	Fri, 05 Dec 2025 07:32:59 -0500
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	basharath@couthit.com,
	afd@ti.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alok.a.tiwari@oracle.com,
	horms@kernel.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [RFC PATCH net-next v9 1/3] net: ti: icssm-prueth: Add helper functions to configure and maintain FDB
Date: Fri,  5 Dec 2025 17:59:11 +0530
Message-ID: <20251205123146.462397-2-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205123146.462397-1-parvathi@couthit.com>
References: <20251205123146.462397-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

Introduce helper functions to configure and maintain Forwarding
Database (FDB) tables to aid with the switch mode feature for PRU-ICSS
ports. The PRU-ICSS FDB is maintained such that it is always in sync with
the Linux bridge driver FDB.

The FDB is used by the driver to determine whether to flood a packet,
received from the user plane, to both ports or direct it to a specific port
using the flags in the FDB table entry.

The FDB is implemented in two main components: the Index table and the
MAC Address table. Adding, deleting, and maintaining entries are handled
by the PRUETH driver. There are two types of entries:

Dynamic: created from the received packets and are subject to aging.
Static: created by the user and these entries never age out.

8-bit hash value obtained using the source MAC address is used to identify
the index to the Index/Hash table. A bucket-based approach is used to
collate source MAC addresses with the same hash value. The Index/Hash table
holds the bucket index (16-bit value) and the number of entries in the
bucket with the same hash value (16-bit value). This table can hold up to
256 entries, with each entry consuming 4 bytes of memory. The bucket index
value points to the MAC address table indicating the start of MAC addresses
having the same hash values.

Each entry in the MAC Address table consists of:
1. 6 bytes of the MAC address,
2. 2-byte aging time, and
3. 1-byte each for port information and flags respectively.

When a new entry is added to the FDB, the hash value is calculated using an
XOR operation on the 6-byte MAC address. The result is used as an index
into the Hash/Index table to check if any entries exist. If no entries are
present, the first available empty slot in the MAC Address table is
allocated to insert this MAC address. If entries with the same hash value
are already present, the new MAC address entry is added to the MAC Address
table in such a way that it ensures all entries are grouped together and
sorted in ascending MAC address order. This approach helps efficiently
manage FDB entries.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   3 +
 .../ethernet/ti/icssm/icssm_prueth_fdb_tbl.h  |  76 +++
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 598 ++++++++++++++++++
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |  20 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  26 +
 6 files changed, 724 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 93c0a4d0e33a..1fd149dd6115 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
-icssm-prueth-y := icssm/icssm_prueth.o
+icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o
 
 obj-$(CONFIG_TI_CPSW) += cpsw-common.o
 obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index 8e7e0af08144..4b50133c5a72 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -15,6 +15,7 @@
 
 #include "icssm_switch.h"
 #include "icssm_prueth_ptp.h"
+#include "icssm_prueth_fdb_tbl.h"
 
 /* ICSSM size of redundancy tag */
 #define ICSSM_LRE_TAG_SIZE	6
@@ -248,6 +249,8 @@ struct prueth {
 	struct prueth_emac *emac[PRUETH_NUM_MACS];
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
 
+	struct fdb_tbl *fdb_tbl;
+
 	unsigned int eth_type;
 	size_t ocmc_ram_size;
 	u8 emac_configured;
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
new file mode 100644
index 000000000000..9089259d96ea
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019-2021 Texas Instruments Incorporated - https://www.ti.com */
+#ifndef __NET_TI_PRUSS_FDB_TBL_H
+#define __NET_TI_PRUSS_FDB_TBL_H
+
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include "icssm_prueth.h"
+
+/* 4 bytes */
+struct fdb_index_tbl_entry {
+	/* Bucket Table index of first Bucket with this MAC address */
+	u16 bucket_idx;
+	u16 bucket_entries; /* Number of entries in this bucket */
+};
+
+/* 4 * 256 = 1024 = 0x200 bytes */
+struct fdb_index_array {
+	struct fdb_index_tbl_entry index_tbl_entry[FDB_INDEX_TBL_MAX_ENTRIES];
+};
+
+/* 10 bytes */
+struct fdb_mac_tbl_entry {
+	u8  mac[ETH_ALEN];
+	u16 age;
+	u8  port; /* 0 based: 0=port1, 1=port2 */
+	union {
+		struct {
+			u8  is_static:1;
+			u8  active:1;
+		};
+		u8 flags;
+	};
+};
+
+/* 10 * 256 = 2560 = 0xa00 bytes */
+struct fdb_mac_tbl_array {
+	struct fdb_mac_tbl_entry mac_tbl_entry[FDB_MAC_TBL_MAX_ENTRIES];
+};
+
+/* 1 byte */
+struct fdb_stp_config {
+	u8  state; /* per-port STP state (defined in FW header) */
+};
+
+/* 1 byte */
+struct fdb_flood_config {
+	u8 host_flood_enable:1;
+	u8 port1_flood_enable:1;
+	u8 port2_flood_enable:1;
+};
+
+/* 2 byte */
+struct fdb_arbitration {
+	u8  host_lock;
+	u8  pru_locks;
+};
+
+struct fdb_tbl {
+	/* fdb index table */
+	struct fdb_index_array __iomem *index_a;
+	/* fdb MAC table */
+	struct fdb_mac_tbl_array __iomem *mac_tbl_a;
+	/* port 1 stp config */
+	struct fdb_stp_config __iomem *port1_stp_cfg;
+	/* port 2 stp config */
+	struct fdb_stp_config __iomem *port2_stp_cfg;
+	/* per-port flood enable */
+	struct fdb_flood_config __iomem *flood_enable_flags;
+	/* fdb locking mechanism */
+	struct fdb_arbitration __iomem *locks;
+	/* total number of entries in hash table */
+	u16 total_entries;
+};
+
+#endif
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
new file mode 100644
index 000000000000..82851d38cd46
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments PRUETH Switch Driver
+ *
+ * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com
+ */
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/remoteproc.h>
+#include <net/switchdev.h>
+#include "icssm_prueth.h"
+#include "icssm_prueth_switch.h"
+#include "icssm_prueth_fdb_tbl.h"
+
+#define FDB_IDX_TBL_ENTRY(n) (&prueth->fdb_tbl->index_a->index_tbl_entry[n])
+
+#define FDB_MAC_TBL_ENTRY(n) (&prueth->fdb_tbl->mac_tbl_a->mac_tbl_entry[n])
+
+#define FLAG_IS_STATIC	BIT(0)
+#define FLAG_ACTIVE	BIT(1)
+
+void icssm_prueth_sw_free_fdb_table(struct prueth *prueth)
+{
+	if (prueth->emac_configured)
+		return;
+
+	kfree(prueth->fdb_tbl);
+	prueth->fdb_tbl = NULL;
+}
+
+void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth)
+{
+	struct fdb_tbl *t = prueth->fdb_tbl;
+	void __iomem *sram_base;
+	u8 val;
+
+	sram_base = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+
+	t->index_a = sram_base + V2_1_FDB_TBL_OFFSET;
+	t->mac_tbl_a = sram_base + FDB_MAC_TBL_OFFSET;
+	t->port1_stp_cfg = sram_base + FDB_PORT1_STP_CFG_OFFSET;
+	t->port2_stp_cfg = sram_base + FDB_PORT2_STP_CFG_OFFSET;
+	t->flood_enable_flags = sram_base + FDB_FLOOD_ENABLE_FLAGS_OFFSET;
+	t->locks = sram_base + FDB_LOCKS_OFFSET;
+
+	val = readb(t->flood_enable_flags);
+	/* host_flood_enable = 1 */
+	val |= BIT(0);
+	/* port1_flood_enable = 1 */
+	val |= BIT(1);
+	/* port2_flood_enable = 1 */
+	val |= BIT(2);
+	writeb(val, t->flood_enable_flags);
+
+	writeb(0, &t->locks->host_lock);
+	t->total_entries = 0;
+}
+
+static u8 icssm_pru_lock_done(struct fdb_tbl *fdb_tbl)
+{
+	return readb(&fdb_tbl->locks->pru_locks);
+}
+
+static int icssm_prueth_sw_fdb_spin_lock(struct fdb_tbl *fdb_tbl)
+{
+	u8 done;
+	int ret;
+
+	/* Take the host lock */
+	writeb(1, &fdb_tbl->locks->host_lock);
+
+	/* Wait for the PRUs to release their locks */
+	ret = read_poll_timeout(icssm_pru_lock_done, done, done == 0,
+				1, 10, false, fdb_tbl);
+	return ret;
+}
+
+static void icssm_prueth_sw_fdb_spin_unlock(struct fdb_tbl *fdb_tbl)
+{
+	writeb(0, &fdb_tbl->locks->host_lock);
+}
+
+static u8 icssm_prueth_sw_fdb_hash(const u8 *mac)
+{
+	return (mac[0] ^ mac[1] ^ mac[2] ^ mac[3] ^ mac[4] ^ mac[5]);
+}
+
+static int
+icssm_prueth_sw_fdb_search(struct fdb_mac_tbl_array __iomem *mac_tbl,
+			   struct fdb_index_tbl_entry __iomem *bucket_info,
+			   const u8 *mac)
+{
+	unsigned int bucket_entries, mac_tbl_idx;
+	u8 tmp_mac[ETH_ALEN];
+	int i;
+
+	mac_tbl_idx = readw(&bucket_info->bucket_idx);
+	bucket_entries = readw(&bucket_info->bucket_entries);
+	for (i = 0; i < bucket_entries; i++, mac_tbl_idx++) {
+		memcpy_fromio(tmp_mac, mac_tbl->mac_tbl_entry[mac_tbl_idx].mac,
+			      ETH_ALEN);
+		if (ether_addr_equal(mac, tmp_mac))
+			return mac_tbl_idx;
+	}
+
+	return -ENODATA;
+}
+
+static int icssm_prueth_sw_fdb_find_open_slot(struct fdb_tbl *fdb_tbl)
+{
+	unsigned int i;
+	u8 flags;
+
+	for (i = 0; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
+		flags = readb(&fdb_tbl->mac_tbl_a->mac_tbl_entry[i].flags);
+		if (!(flags & FLAG_ACTIVE))
+			break;
+	}
+
+	return i;
+}
+
+static int
+icssm_prueth_sw_find_fdb_insert(struct fdb_tbl *fdb, struct prueth *prueth,
+				struct fdb_index_tbl_entry __iomem *bkt_info,
+				const u8 *mac, const u8 port)
+{
+	struct fdb_mac_tbl_array __iomem *mac_tbl = fdb->mac_tbl_a;
+	unsigned int bucket_entries, mac_tbl_idx;
+	struct fdb_mac_tbl_entry __iomem *e;
+	u8 mac_from_hw[ETH_ALEN];
+	s8 cmp;
+	int i;
+
+	mac_tbl_idx = readw(&bkt_info->bucket_idx);
+	bucket_entries = readw(&bkt_info->bucket_entries);
+
+	for (i = 0; i < bucket_entries; i++, mac_tbl_idx++) {
+		e = &mac_tbl->mac_tbl_entry[mac_tbl_idx];
+		memcpy_fromio(mac_from_hw, e->mac, ETH_ALEN);
+		cmp = memcmp(mac, mac_from_hw, ETH_ALEN);
+		if (cmp < 0) {
+			return mac_tbl_idx;
+		} else if (cmp == 0) {
+			if (readb(&e->port) != port) {
+				/* MAC is already in FDB, only port is
+				 * different. So just update the port.
+				 * Note: total_entries and bucket_entries
+				 * remain the same.
+				 */
+				writeb(port, &e->port);
+			}
+
+			/* MAC and port are the same, touch the fdb */
+			writew(0, &e->age);
+			return -EEXIST;
+		}
+	}
+
+	return mac_tbl_idx;
+}
+
+static int
+icssm_prueth_sw_fdb_empty_slot_left(struct fdb_mac_tbl_array __iomem *mac_tbl,
+				    unsigned int mac_tbl_idx)
+{
+	u8 flags;
+	int i;
+
+	for (i = mac_tbl_idx - 1; i > -1; i--) {
+		flags = readb(&mac_tbl->mac_tbl_entry[i].flags);
+		if (!(flags & FLAG_ACTIVE))
+			break;
+	}
+
+	return i;
+}
+
+static int
+icssm_prueth_sw_fdb_empty_slot_right(struct fdb_mac_tbl_array __iomem *mac_tbl,
+				     unsigned int mac_tbl_idx)
+{
+	u8 flags;
+	int i;
+
+	for (i = mac_tbl_idx; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
+		flags = readb(&mac_tbl->mac_tbl_entry[i].flags);
+		if (!(flags & FLAG_ACTIVE))
+			return i;
+	}
+
+	return -1;
+}
+
+static void icssm_prueth_sw_fdb_move_range_left(struct prueth *prueth,
+						u16 left, u16 right)
+{
+	struct fdb_mac_tbl_entry entry;
+	u32 sz = 0;
+	u16 i;
+
+	sz = sizeof(struct fdb_mac_tbl_entry);
+	for (i = left; i < right; i++) {
+		memcpy_fromio(&entry, FDB_MAC_TBL_ENTRY(i + 1), sz);
+		memcpy_toio(FDB_MAC_TBL_ENTRY(i), &entry, sz);
+	}
+}
+
+static void icssm_prueth_sw_fdb_move_range_right(struct prueth *prueth,
+						 u16 left, u16 right)
+{
+	struct fdb_mac_tbl_entry entry;
+	u32 sz = 0;
+	u16 i;
+
+	sz = sizeof(struct fdb_mac_tbl_entry);
+	for (i = right; i > left; i--) {
+		memcpy_fromio(&entry, FDB_MAC_TBL_ENTRY(i - 1), sz);
+		memcpy_toio(FDB_MAC_TBL_ENTRY(i), &entry, sz);
+	}
+}
+
+static void icssm_prueth_sw_fdb_update_index_tbl(struct prueth *prueth,
+						 u16 left, u16 right)
+{
+	unsigned int hash, hash_prev;
+	u8 mac[ETH_ALEN];
+	unsigned int i;
+
+	/* To ensure we don't improperly update the
+	 * bucket index, initialize with an invalid
+	 * hash in case we are in leftmost slot
+	 */
+	hash_prev = 0xff;
+
+	if (left > 0) {
+		memcpy_fromio(mac, FDB_MAC_TBL_ENTRY(left - 1)->mac, ETH_ALEN);
+		hash_prev = icssm_prueth_sw_fdb_hash(mac);
+	}
+
+	/* For each moved element, update the bucket index */
+	for (i = left; i <= right; i++) {
+		memcpy_fromio(mac, FDB_MAC_TBL_ENTRY(i)->mac, ETH_ALEN);
+		hash = icssm_prueth_sw_fdb_hash(mac);
+
+		/* Only need to update buckets once */
+		if (hash != hash_prev)
+			writew(i, &FDB_IDX_TBL_ENTRY(hash)->bucket_idx);
+
+		hash_prev = hash;
+	}
+}
+
+static struct fdb_mac_tbl_entry __iomem *
+icssm_prueth_sw_find_free_mac(struct prueth *prueth, struct fdb_index_tbl_entry
+			      __iomem *bucket_info, u8 suggested_mac_tbl_idx,
+			      bool *update_indexes, const u8 *mac)
+{
+	s16 empty_slot_idx = 0, left = 0, right = 0;
+	unsigned int mti = suggested_mac_tbl_idx;
+	struct fdb_mac_tbl_array __iomem *mt;
+	struct fdb_tbl *fdb;
+	u8 flags;
+
+	fdb = prueth->fdb_tbl;
+	mt = fdb->mac_tbl_a;
+
+	flags = readb(&FDB_MAC_TBL_ENTRY(mti)->flags);
+	if (!(flags & FLAG_ACTIVE)) {
+		/* Claim the entry */
+		flags |= FLAG_ACTIVE;
+		writeb(flags, &FDB_MAC_TBL_ENTRY(mti)->flags);
+
+		return FDB_MAC_TBL_ENTRY(mti);
+	}
+
+	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
+		return NULL;
+
+	empty_slot_idx = icssm_prueth_sw_fdb_empty_slot_left(mt, mti);
+	if (empty_slot_idx == -1) {
+		/* Nothing available on the left. But table isn't full
+		 * so there must be space to the right,
+		 */
+		empty_slot_idx = icssm_prueth_sw_fdb_empty_slot_right(mt, mti);
+
+		/* Shift right */
+		left = mti;
+		right = empty_slot_idx;
+		icssm_prueth_sw_fdb_move_range_right(prueth, left, right);
+
+		/* Claim the entry */
+		flags = readb(&FDB_MAC_TBL_ENTRY(mti)->flags);
+		flags |= FLAG_ACTIVE;
+		writeb(flags, &FDB_MAC_TBL_ENTRY(mti)->flags);
+
+		memcpy_toio(FDB_MAC_TBL_ENTRY(mti)->mac, mac, ETH_ALEN);
+
+		/* There is a chance we moved something in a
+		 * different bucket, update index table
+		 */
+		icssm_prueth_sw_fdb_update_index_tbl(prueth, left, right);
+
+		return FDB_MAC_TBL_ENTRY(mti);
+	}
+
+	if (empty_slot_idx == mti - 1) {
+		/* There is space immediately left of the open slot,
+		 * which means the inserted MAC address
+		 * must be the lowest-valued MAC address in bucket.
+		 * Update bucket pointer accordingly.
+		 */
+		writew(empty_slot_idx, &bucket_info->bucket_idx);
+
+		/* Claim the entry */
+		flags = readb(&FDB_MAC_TBL_ENTRY(mti)->flags);
+		flags |= FLAG_ACTIVE;
+		writeb(flags, &FDB_MAC_TBL_ENTRY(mti)->flags);
+
+		return FDB_MAC_TBL_ENTRY(empty_slot_idx);
+	}
+
+	/* There is empty space to the left, shift MAC table entries left */
+	left = empty_slot_idx;
+	right = mti - 1;
+	icssm_prueth_sw_fdb_move_range_left(prueth, left, right);
+
+	/* Claim the entry */
+	flags = readb(&FDB_MAC_TBL_ENTRY(mti - 1)->flags);
+	flags |= FLAG_ACTIVE;
+	writeb(flags, &FDB_MAC_TBL_ENTRY(mti - 1)->flags);
+
+	memcpy_toio(FDB_MAC_TBL_ENTRY(mti - 1)->mac, mac, ETH_ALEN);
+
+	/* There is a chance we moved something in a
+	 * different bucket, update index table
+	 */
+	icssm_prueth_sw_fdb_update_index_tbl(prueth, left, right);
+
+	return FDB_MAC_TBL_ENTRY(mti - 1);
+}
+
+static int icssm_prueth_sw_insert_fdb_entry(struct prueth_emac *emac,
+					    const u8 *mac, u8 is_static)
+{
+	struct fdb_index_tbl_entry __iomem *bucket_info;
+	struct fdb_mac_tbl_entry __iomem *mac_info;
+	struct prueth *prueth = emac->prueth;
+	unsigned int hash_val, mac_tbl_idx;
+	struct prueth_emac *other_emac;
+	enum prueth_port other_port_id;
+	int total_fdb_entries;
+	struct fdb_tbl *fdb;
+	u8 flags;
+	s16 ret;
+	int err;
+	u16 val;
+
+	fdb = prueth->fdb_tbl;
+	other_port_id = (emac->port_id == PRUETH_PORT_MII0) ?
+			 PRUETH_PORT_MII1 : PRUETH_PORT_MII0;
+
+	other_emac = prueth->emac[other_port_id - 1];
+
+	err = icssm_prueth_sw_fdb_spin_lock(fdb);
+	if (err) {
+		dev_err(prueth->dev, "PRU lock timeout %d\n", err);
+		return err;
+	}
+
+	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES) {
+		icssm_prueth_sw_fdb_spin_unlock(fdb);
+		return -ENOMEM;
+	}
+
+	if (ether_addr_equal(mac, emac->mac_addr) ||
+	    ether_addr_equal(mac, other_emac->mac_addr)) {
+		icssm_prueth_sw_fdb_spin_unlock(fdb);
+		/* Don't insert fdb of own mac addr */
+		return -EINVAL;
+	}
+
+	/* Get the bucket that the mac belongs to */
+	hash_val = icssm_prueth_sw_fdb_hash(mac);
+	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
+
+	if (!readw(&bucket_info->bucket_entries)) {
+		mac_tbl_idx = icssm_prueth_sw_fdb_find_open_slot(fdb);
+		writew(mac_tbl_idx, &bucket_info->bucket_idx);
+	}
+
+	ret = icssm_prueth_sw_find_fdb_insert(fdb, prueth, bucket_info, mac,
+					      emac->port_id - 1);
+	if (ret < 0) {
+		icssm_prueth_sw_fdb_spin_unlock(fdb);
+		/* mac is already in fdb table */
+		return 0;
+	}
+
+	mac_tbl_idx = ret;
+
+	mac_info = icssm_prueth_sw_find_free_mac(prueth, bucket_info,
+						 mac_tbl_idx, NULL,
+						 mac);
+	if (!mac_info) {
+		/* Should not happen */
+		dev_warn(prueth->dev, "OUT of FDB MEM\n");
+		icssm_prueth_sw_fdb_spin_unlock(fdb);
+		return -ENOMEM;
+	}
+
+	memcpy_toio(mac_info->mac, mac, ETH_ALEN);
+	writew(0, &mac_info->age);
+	writeb(emac->port_id - 1, &mac_info->port);
+
+	flags = readb(&mac_info->flags);
+	if (is_static)
+		flags |= FLAG_IS_STATIC;
+	else
+		flags &= ~FLAG_IS_STATIC;
+
+	/* bit 1 - active */
+	flags |= FLAG_ACTIVE;
+	writeb(flags, &mac_info->flags);
+
+	val = readw(&bucket_info->bucket_entries);
+	val++;
+	writew(val, &bucket_info->bucket_entries);
+
+	fdb->total_entries++;
+
+	total_fdb_entries = fdb->total_entries;
+
+	icssm_prueth_sw_fdb_spin_unlock(fdb);
+
+	dev_dbg(prueth->dev, "added fdb: %pM port=%d total_entries=%u\n",
+		mac, emac->port_id, total_fdb_entries);
+
+	return 0;
+}
+
+static int icssm_prueth_sw_delete_fdb_entry(struct prueth_emac *emac,
+					    const u8 *mac, u8 is_static)
+{
+	struct fdb_index_tbl_entry __iomem *bucket_info;
+	struct fdb_mac_tbl_entry __iomem *mac_info;
+	struct fdb_mac_tbl_array __iomem *mt;
+	unsigned int hash_val, mac_tbl_idx;
+	unsigned int idx, entries;
+	struct prueth *prueth;
+	int total_fdb_entries;
+	s16 ret, left, right;
+	struct fdb_tbl *fdb;
+	u8 flags;
+	int err;
+	u16 val;
+
+	prueth = emac->prueth;
+	fdb = prueth->fdb_tbl;
+	mt = fdb->mac_tbl_a;
+
+	err = icssm_prueth_sw_fdb_spin_lock(fdb);
+	if (err) {
+		dev_err(prueth->dev, "PRU lock timeout %d\n", err);
+		return err;
+	}
+
+	if (fdb->total_entries == 0) {
+		icssm_prueth_sw_fdb_spin_unlock(fdb);
+		return 0;
+	}
+
+	/* Get the bucket that the mac belongs to */
+	hash_val = icssm_prueth_sw_fdb_hash(mac);
+	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
+
+	ret = icssm_prueth_sw_fdb_search(mt, bucket_info, mac);
+	if (ret < 0) {
+		icssm_prueth_sw_fdb_spin_unlock(fdb);
+		return ret;
+	}
+
+	mac_tbl_idx = ret;
+	mac_info = FDB_MAC_TBL_ENTRY(mac_tbl_idx);
+
+	/* Shift all elements in bucket to the left. No need to
+	 * update index table since only shifting within bucket.
+	 */
+	left = mac_tbl_idx;
+	idx = readw(&bucket_info->bucket_idx);
+	entries = readw(&bucket_info->bucket_entries);
+	right = idx + entries - 1;
+	icssm_prueth_sw_fdb_move_range_left(prueth, left, right);
+
+	/* Remove end of bucket from table */
+	mac_info = FDB_MAC_TBL_ENTRY(right);
+	flags = readb(&mac_info->flags);
+	/* active = 0 */
+	flags &= ~FLAG_ACTIVE;
+	writeb(flags, &mac_info->flags);
+	val = readw(&bucket_info->bucket_entries);
+	val--;
+	writew(val, &bucket_info->bucket_entries);
+	fdb->total_entries--;
+
+	total_fdb_entries = fdb->total_entries;
+
+	icssm_prueth_sw_fdb_spin_unlock(fdb);
+
+	dev_dbg(prueth->dev, "del fdb: %pM total_entries=%u\n",
+		mac, total_fdb_entries);
+
+	return 0;
+}
+
+int icssm_prueth_sw_do_purge_fdb(struct prueth_emac *emac)
+{
+	struct fdb_index_tbl_entry __iomem *bucket_info;
+	struct prueth *prueth = emac->prueth;
+	u8 flags, mac[ETH_ALEN];
+	unsigned int hash_val;
+	struct fdb_tbl *fdb;
+	int ret, i;
+	u16 val;
+
+	fdb = prueth->fdb_tbl;
+
+	ret = icssm_prueth_sw_fdb_spin_lock(fdb);
+	if (ret) {
+		dev_err(prueth->dev, "PRU lock timeout %d\n", ret);
+		return ret;
+	}
+
+	if (fdb->total_entries == 0) {
+		icssm_prueth_sw_fdb_spin_unlock(fdb);
+		return 0;
+	}
+
+	for (i = 0; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
+		flags = readb(&fdb->mac_tbl_a->mac_tbl_entry[i].flags);
+		if ((flags & FLAG_ACTIVE) && !(flags & FLAG_IS_STATIC)) {
+			/* Get the bucket that the mac belongs to */
+			memcpy_fromio(mac, FDB_MAC_TBL_ENTRY(i)->mac,
+				      ETH_ALEN);
+			hash_val = icssm_prueth_sw_fdb_hash(mac);
+			bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
+			flags &= ~FLAG_ACTIVE;
+			writeb(flags,
+			       &fdb->mac_tbl_a->mac_tbl_entry[i].flags);
+			val = readw(&bucket_info->bucket_entries);
+			val--;
+			writew(val, &bucket_info->bucket_entries);
+			fdb->total_entries--;
+		}
+	}
+
+	icssm_prueth_sw_fdb_spin_unlock(fdb);
+	return 0;
+}
+
+int icssm_prueth_sw_init_fdb_table(struct prueth *prueth)
+{
+	if (prueth->emac_configured)
+		return 0;
+
+	prueth->fdb_tbl = kmalloc(sizeof(*prueth->fdb_tbl), GFP_KERNEL);
+	if (!prueth->fdb_tbl)
+		return -ENOMEM;
+
+	icssm_prueth_sw_fdb_tbl_init(prueth);
+
+	return 0;
+}
+
+/**
+ * icssm_prueth_sw_fdb_add - insert fdb entry
+ *
+ * @emac: EMAC data structure
+ * @fdb: fdb info
+ *
+ */
+void icssm_prueth_sw_fdb_add(struct prueth_emac *emac,
+			     struct switchdev_notifier_fdb_info *fdb)
+{
+	icssm_prueth_sw_insert_fdb_entry(emac, fdb->addr, 1);
+}
+
+/**
+ * icssm_prueth_sw_fdb_del - delete fdb entry
+ *
+ * @emac: EMAC data structure
+ * @fdb: fdb info
+ *
+ */
+void icssm_prueth_sw_fdb_del(struct prueth_emac *emac,
+			     struct switchdev_notifier_fdb_info *fdb)
+{
+	icssm_prueth_sw_delete_fdb_entry(emac, fdb->addr, 1);
+}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
new file mode 100644
index 000000000000..fd013ecdc707
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#ifndef __NET_TI_PRUETH_SWITCH_H
+#define __NET_TI_PRUETH_SWITCH_H
+
+#include "icssm_prueth.h"
+#include "icssm_prueth_fdb_tbl.h"
+
+void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth);
+int icssm_prueth_sw_init_fdb_table(struct prueth *prueth);
+void icssm_prueth_sw_free_fdb_table(struct prueth *prueth);
+int icssm_prueth_sw_do_purge_fdb(struct prueth_emac *emac);
+void icssm_prueth_sw_fdb_add(struct prueth_emac *emac,
+			     struct switchdev_notifier_fdb_info *fdb);
+void icssm_prueth_sw_fdb_del(struct prueth_emac *emac,
+			     struct switchdev_notifier_fdb_info *fdb);
+
+#endif /* __NET_TI_PRUETH_SWITCH_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
index 8b494ffdcde7..4200ccb1b425 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h
@@ -254,4 +254,30 @@
 #define P0_COL_BUFFER_OFFSET	0xEE00
 #define P0_Q1_BUFFER_OFFSET	0x0000
 
+#define V2_1_FDB_TBL_LOC          PRUETH_MEM_SHARED_RAM
+#define V2_1_FDB_TBL_OFFSET       0x2000
+
+#define FDB_INDEX_TBL_MAX_ENTRIES     256
+#define FDB_MAC_TBL_MAX_ENTRIES       256
+
+#define FDB_INDEX_TBL_OFFSET    V2_1_FDB_TBL_OFFSET
+#define FDB_INDEX_TBL_SIZE      (FDB_INDEX_TBL_MAX_ENTRIES * \
+				 sizeof(struct fdb_index_tbl_entry))
+
+#define FDB_MAC_TBL_OFFSET      (FDB_INDEX_TBL_OFFSET + FDB_INDEX_TBL_SIZE)
+#define FDB_MAC_TBL_SIZE        (FDB_MAC_TBL_MAX_ENTRIES * \
+				 sizeof(struct fdb_mac_tbl_entry))
+
+#define FDB_PORT1_STP_CFG_OFFSET        (FDB_MAC_TBL_OFFSET + FDB_MAC_TBL_SIZE)
+#define FDB_PORT_STP_CFG_SIZE           sizeof(struct fdb_stp_config)
+#define FDB_PORT2_STP_CFG_OFFSET        (FDB_PORT1_STP_CFG_OFFSET + \
+					 FDB_PORT_STP_CFG_SIZE)
+
+#define FDB_FLOOD_ENABLE_FLAGS_OFFSET   (FDB_PORT2_STP_CFG_OFFSET + \
+					FDB_PORT_STP_CFG_SIZE)
+#define FDB_FLOOD_ENABLE_FLAGS_SIZE     sizeof(struct fdb_flood_config)
+
+#define FDB_LOCKS_OFFSET        (FDB_FLOOD_ENABLE_FLAGS_OFFSET + \
+				 FDB_FLOOD_ENABLE_FLAGS_SIZE)
+
 #endif /* __ICSS_SWITCH_H */
-- 
2.43.0


