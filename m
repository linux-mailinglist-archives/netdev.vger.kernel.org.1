Return-Path: <netdev+bounces-289039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COrNJuAHC2r4/QQAu9opvQ
	(envelope-from <netdev+bounces-289039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFA56CC96
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15475308E73A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F680413D64;
	Mon, 18 May 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yuu3KZ4w"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62D413229;
	Mon, 18 May 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107229; cv=none; b=Kfv01nH9pTNPXEeEZWs5BR7EbSci8V+M9mapOj0Q+HaudaMjNHPbGSLcw532VXWrCCrUnnrk7sqd8j6x2G7+KTDEKcY62MxvNgOtXV1yGszQTWXFjTbGKUoadAayy5mC6L4R3/njlrUBcKooD43m17rELbR75TLRSXjwkCFIjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107229; c=relaxed/simple;
	bh=5NlKPJZPuOpsLLo9Jja76KrxiKQIr5sqV8Va7r7FbAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GB02Sw1AjNsGPZaLjEUi5h52yHy2oECeUMk3eVlzbcq7kwMtHOFnHDTbLn2aWnvmCvVrOrrbymAarLPkRz5/6ynEj7uePln5m1Du9Ommi+3C326ukzS8ac/eMucy6diB7Gpkqgjm6gDyIcwSopXJrtTM40/C9No/ZjyEbiTzE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yuu3KZ4w; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779107226; x=1810643226;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5NlKPJZPuOpsLLo9Jja76KrxiKQIr5sqV8Va7r7FbAk=;
  b=Yuu3KZ4wvqCA4adahlRsACcUUDG4HpHr88kInNp0tVqj71QqRvV4W5U8
   BPWvgcAd9EaKWbG0L05dTaUd6tjeEcGA82snY9s5X3wMpTnwMPx0fS/ea
   PJxZqW9oBJOP/v2/BUFTvV0rsGAqCri00vMyFjCTeq5wino0b00yzvZIg
   DrCG+agTnvvzN1Npd+ttaA7BFvm9Qu/ONpwGIuvw0dXnocjiFq42I6UcA
   VVMpnxHBTBlPA93ZFMQb6pYKcE88B40JhP9rOBQoFutZWLWJMPx9e1tgA
   qDm9zafCLKlmfkp0zFLlhrfuVVjRJiyigApF0fM5Cg7kVu3DdA6ZB3f9S
   w==;
X-CSE-ConnectionGUID: xSEO98PuSQ27jkhhYFTPeQ==
X-CSE-MsgGUID: OVwbtKEXSpOuyP1Tlar7lA==
X-IronPort-AV: E=Sophos;i="6.23,241,1770620400"; 
   d="scan'208";a="56880976"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 05:27:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 18 May 2026 05:27:05 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 18 May 2026 05:27:02 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 18 May 2026 14:25:03 +0200
Subject: [PATCH net-next v5 8/9] net: dsa: lan9645x: add mdb management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260518-dsa_lan9645x_switch_driver_base-v5-8-968fbf34ffa3@microchip.com>
References: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
In-Reply-To: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Russell King
	<linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Queue-Id: 43DFA56CC96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Add support for dsa mdb callbacks. L2 multicast and IP multicast is
handled differently. IP multicast stores the port group mask inline in
the mac table. L2 multicast points to a PGID index, which encodes the
port group mask.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v5:
- skip igmp/mld redir for npi port

Changes in v4:
- clean up fresh mdb when hw mac table write fails.
- avoid void return in lan9645x_offload_fwd_mark

Changes in v3:
- avoid mdb add/del dealloc when mac table writes fail
- dealloc mdb entries on deinit

Changes in v2:
- New file: selftests required implementation of the mdb callbacks.
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  |  14 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  62 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  21 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c  | 397 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |  11 +-
 include/linux/dsa/lan9645x.h                       |  11 +
 net/dsa/tag_lan9645x.c                             |  19 +-
 8 files changed, 533 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
index 70815edca5b9..2413d11fe849 100644
--- a/drivers/net/dsa/microchip/lan9645x/Makefile
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X) += mchp-lan9645x.o
 mchp-lan9645x-objs := \
 	lan9645x_mac.o \
 	lan9645x_main.o \
+	lan9645x_mdb.o \
 	lan9645x_npi.o \
 	lan9645x_phylink.o \
 	lan9645x_port.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
index 1079e49f6271..1470ac38b635 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
@@ -142,6 +142,20 @@ int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
 	return err;
 }
 
+int lan9645x_mact_learn_cpu_copy(struct lan9645x *lan9645x, int port,
+				 const unsigned char *addr, u16 vid,
+				 enum macaccess_entry_type type, bool cpu_copy)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+	err = __lan9645x_mact_learn_cpu_copy(lan9645x, port, addr, vid, type,
+					     cpu_copy);
+	mutex_unlock(&lan9645x->mact_lock);
+
+	return err;
+}
+
 int lan9645x_mact_flush(struct lan9645x *lan9645x, int port)
 {
 	int err;
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index a76e61fb3709..2650cdb5e11d 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -70,6 +70,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 	destroy_workqueue(lan9645x->owq);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
 	lan9645x_mac_deinit(lan9645x);
+	lan9645x_mdb_deinit(lan9645x);
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 }
 
@@ -156,6 +157,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
 	err = lan9645x_mac_init(lan9645x);
 	if (err)
 		goto err_mutex;
+	lan9645x_mdb_init(lan9645x);
 
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
@@ -289,6 +291,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
 
 err_mac:
 	lan9645x_mac_deinit(lan9645x);
+	lan9645x_mdb_deinit(lan9645x);
 err_mutex:
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
@@ -688,6 +691,61 @@ static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
 	return lan9645x_mact_forget(lan9645x, addr, vid, ENTRYTYPE_LOCKED);
 }
 
+static int lan9645x_mdb_add(struct dsa_switch *ds, int port,
+			    const struct switchdev_obj_port_mdb *mdb,
+			    struct dsa_db db)
+{
+	struct net_device *bridge_dev = lan9645x_db2bridge(db);
+	struct lan9645x *lan9645x = ds->priv;
+
+	dev_dbg(lan9645x->dev, "port=%d addr=%pM vid=%u\n", port, mdb->addr,
+		mdb->vid);
+
+	if (IS_ERR(bridge_dev))
+		return PTR_ERR(bridge_dev);
+
+	if (dsa_is_cpu_port(ds, port) && !bridge_dev &&
+	    dsa_mdb_present_in_other_db(ds, port, mdb, db))
+		return 0;
+
+	if (port == lan9645x->npi)
+		port = CPU_PORT;
+
+	return lan9645x_mdb_port_add(lan9645x, port, mdb, bridge_dev);
+}
+
+static int lan9645x_mdb_del(struct dsa_switch *ds, int port,
+			    const struct switchdev_obj_port_mdb *mdb,
+			    struct dsa_db db)
+{
+	struct net_device *bridge_dev = lan9645x_db2bridge(db);
+	struct lan9645x *lan9645x = ds->priv;
+	int err;
+
+	dev_dbg(lan9645x->dev, "port=%d addr=%pM vid=%u\n", port, mdb->addr,
+		mdb->vid);
+
+	if (IS_ERR(bridge_dev))
+		return PTR_ERR(bridge_dev);
+
+	if (dsa_is_cpu_port(ds, port) && !bridge_dev &&
+	    dsa_mdb_present_in_other_db(ds, port, mdb, db))
+		return 0;
+
+	if (port == lan9645x->npi)
+		port = CPU_PORT;
+
+	err = lan9645x_mdb_port_del(lan9645x, port, mdb, bridge_dev);
+	if (err == -ENOENT) {
+		dev_dbg(lan9645x->dev,
+			"mdb not found port=%d addr=%pM vid=%u\n", port,
+			mdb->addr, mdb->vid);
+		return 0;
+	}
+
+	return err;
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -721,6 +779,10 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.port_fdb_dump			= lan9645x_fdb_dump,
 	.port_fdb_add			= lan9645x_fdb_add,
 	.port_fdb_del			= lan9645x_fdb_del,
+
+	/* Multicast database */
+	.port_mdb_add			= lan9645x_mdb_add,
+	.port_mdb_del			= lan9645x_mdb_del,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index f5d8b7042d57..40d9de23e4bc 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -205,6 +205,14 @@ struct lan9645x {
 	/* VLAN entries */
 	struct lan9645x_vlan vlans[VLAN_N_VID];
 
+	/* Multicast Forwarding Database */
+	struct list_head mdb_entries;
+	struct list_head pgid_entries;
+	/* lock for mdb_entries and pgid_entries. Must be taken before mact_lock
+	 * if both are taken.
+	 */
+	struct mutex mdb_lock;
+
 	int num_port_dis;
 };
 
@@ -407,5 +415,18 @@ int lan9645x_mac_init(struct lan9645x *lan9645x);
 void lan9645x_mac_deinit(struct lan9645x *lan9645x);
 int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
 			   dsa_fdb_dump_cb_t *cb, void *data);
+int lan9645x_mact_learn_cpu_copy(struct lan9645x *lan9645x, int port,
+				 const unsigned char *addr, u16 vid,
+				 enum macaccess_entry_type type, bool cpu_copy);
+
+/* Multicast Database lan9645x_mdb.c */
+int lan9645x_mdb_port_add(struct lan9645x *lan9645x, int port,
+			  const struct switchdev_obj_port_mdb *mdb,
+			  struct net_device *bridge);
+int lan9645x_mdb_port_del(struct lan9645x *lan9645x, int port,
+			  const struct switchdev_obj_port_mdb *mdb,
+			  struct net_device *bridge);
+void lan9645x_mdb_init(struct lan9645x *lan9645x);
+void lan9645x_mdb_deinit(struct lan9645x *lan9645x);
 
 #endif /* __LAN9645X_MAIN_H__ */
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
new file mode 100644
index 000000000000..0ba3e0974dc0
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+/* HW ignores dest_idx for IPv4/IPv6 types, so we use this dummy index */
+#define IP_ENTRY_PGID		0
+#define PGID_INDEX(pgid)	((pgid) ? (pgid)->index : IP_ENTRY_PGID)
+
+struct lan9645x_pgid_entry {
+	struct list_head list;
+	int index;
+	refcount_t refcount;
+	u16 ports;
+};
+
+struct lan9645x_mdb_entry {
+	struct list_head list;
+	unsigned char mac[ETH_ALEN];
+	u16 vid;
+	u16 ports;
+	struct lan9645x_pgid_entry *pgid;
+};
+
+void lan9645x_mdb_init(struct lan9645x *lan9645x)
+{
+	INIT_LIST_HEAD(&lan9645x->mdb_entries);
+	INIT_LIST_HEAD(&lan9645x->pgid_entries);
+	mutex_init(&lan9645x->mdb_lock);
+
+	/* Use CPU queues to communicate frame classification to the CPU */
+	lan_rmw(ANA_CPUQ_CFG_CPUQ_IGMP_SET(LAN9645X_CPUQ_IGMP) |
+		ANA_CPUQ_CFG_CPUQ_MLD_SET(LAN9645X_CPUQ_MLD) |
+		ANA_CPUQ_CFG_CPUQ_IPMC_CTRL_SET(LAN9645X_CPUQ_IPMC_CTRL),
+		ANA_CPUQ_CFG_CPUQ_IGMP |
+		ANA_CPUQ_CFG_CPUQ_MLD |
+		ANA_CPUQ_CFG_CPUQ_IPMC_CTRL,
+		lan9645x, ANA_CPUQ_CFG);
+}
+
+static enum macaccess_entry_type lan9645x_mdb_classify(const unsigned char *mac)
+{
+	if (ether_addr_is_ipv4_mcast(mac))
+		return ENTRYTYPE_MACV4;
+	if (ether_addr_is_ipv6_mcast(mac))
+		return ENTRYTYPE_MACV6;
+	return ENTRYTYPE_LOCKED;
+}
+
+static struct lan9645x_mdb_entry *
+lan9645x_mdb_entry_lookup(struct lan9645x *lan9645x, const unsigned char *mac,
+			  u16 vid)
+{
+	struct lan9645x_mdb_entry *mdb;
+
+	list_for_each_entry(mdb, &lan9645x->mdb_entries, list) {
+		if (ether_addr_equal(mdb->mac, mac) && mdb->vid == vid)
+			return mdb;
+	}
+
+	return NULL;
+}
+
+static struct lan9645x_mdb_entry *
+lan9645x_mdb_entry_alloc(struct lan9645x *lan9645x,
+			 const unsigned char addr[ETH_ALEN], u16 vid)
+{
+	struct lan9645x_mdb_entry *mdb_entry;
+
+	mdb_entry = kzalloc_obj(*mdb_entry);
+	if (!mdb_entry)
+		return ERR_PTR(-ENOMEM);
+
+	ether_addr_copy(mdb_entry->mac, addr);
+	mdb_entry->vid = vid;
+
+	list_add_tail(&mdb_entry->list, &lan9645x->mdb_entries);
+
+	dev_dbg(lan9645x->dev, "vid=%u addr=%pM\n", mdb_entry->vid,
+		mdb_entry->mac);
+
+	return mdb_entry;
+}
+
+static void lan9645x_mdb_encode_mac(unsigned char *dst, unsigned char *mac,
+				    u16 ports, enum macaccess_entry_type type)
+{
+	ether_addr_copy(dst, mac);
+
+	/* The HW encodes the portmask in the high bits of the mac for ip
+	 * multicast entries, to save on the limited PGID resources.
+	 *
+	 * IPv4 Multicast DMAC: 0x01005Exxxxxx
+	 * IPv6 Multicast DMAC: 0x3333xxxxxxxx
+	 *
+	 * which gives us 24 or 16 bits to encode the portmask.
+	 */
+	if (type == ENTRYTYPE_MACV4) {
+		dst[0] = 0;
+		dst[1] = ports >> 8;
+		dst[2] = ports & 0xff;
+	} else if (type == ENTRYTYPE_MACV6) {
+		dst[0] = ports >> 8;
+		dst[1] = ports & 0xff;
+	}
+}
+
+static void lan9645x_pgid_entry_put(struct lan9645x *lan9645x,
+				    struct lan9645x_pgid_entry *pgid_entry)
+{
+	if (!pgid_entry)
+		return;
+
+	if (!refcount_dec_and_test(&pgid_entry->refcount))
+		return;
+
+	dev_dbg(lan9645x->dev, "pgid=%d ports=0x%x", pgid_entry->index,
+		pgid_entry->ports);
+	/* We leave the PGID written in HW, as no entry is pointing to it. */
+	list_del(&pgid_entry->list);
+	kfree(pgid_entry);
+}
+
+static void lan9645x_mdb_entry_dealloc(struct lan9645x *lan9645x,
+				       struct lan9645x_mdb_entry *mdb_entry)
+{
+	dev_dbg(lan9645x->dev, "vid=%u addr=%pM\n", mdb_entry->vid,
+		mdb_entry->mac);
+	list_del(&mdb_entry->list);
+	lan9645x_pgid_entry_put(lan9645x, mdb_entry->pgid);
+	kfree(mdb_entry);
+}
+
+static struct lan9645x_pgid_entry *
+lan9645x_mdb_pgid_entry_lookup(struct lan9645x *lan9645x, u16 ports)
+{
+	struct lan9645x_pgid_entry *pgid_entry;
+
+	list_for_each_entry(pgid_entry, &lan9645x->pgid_entries, list) {
+		if (pgid_entry->ports == ports &&
+		    refcount_inc_not_zero(&pgid_entry->refcount))
+			return pgid_entry;
+	}
+
+	return NULL;
+}
+
+static struct lan9645x_pgid_entry *
+lan9645x_pgid_entry_alloc(struct lan9645x *lan9645x, int index, u16 ports)
+{
+	struct lan9645x_pgid_entry *pgid_entry;
+
+	pgid_entry = kzalloc_obj(*pgid_entry);
+	if (!pgid_entry)
+		return ERR_PTR(-ENOMEM);
+
+	pgid_entry->ports = ports;
+	pgid_entry->index = index;
+	refcount_set(&pgid_entry->refcount, 1);
+
+	list_add_tail(&pgid_entry->list, &lan9645x->pgid_entries);
+
+	dev_dbg(lan9645x->dev, "index=%d ports=0x%x", pgid_entry->index,
+		pgid_entry->ports);
+
+	lan_rmw(ANA_PGID_PGID_SET(pgid_entry->ports),
+		ANA_PGID_PGID, lan9645x,
+		ANA_PGID(pgid_entry->index));
+
+	return pgid_entry;
+}
+
+static struct lan9645x_pgid_entry *
+lan9645x_mdb_pgid_entry_create(struct lan9645x *lan9645x, u16 ports)
+{
+	struct lan9645x_pgid_entry *pgid_entry = NULL;
+	int index;
+
+	for (index = PGID_GP_START; index < PGID_GP_END; index++) {
+		bool used = false;
+
+		list_for_each_entry(pgid_entry, &lan9645x->pgid_entries, list) {
+			if (pgid_entry->index == index) {
+				used = true;
+				break;
+			}
+		}
+
+		if (!used)
+			return lan9645x_pgid_entry_alloc(lan9645x, index,
+							 ports);
+	}
+
+	return ERR_PTR(-ENOSPC);
+}
+
+static struct lan9645x_pgid_entry *
+lan9645x_mdb_pgid_entry_get(struct lan9645x *lan9645x, u16 ports,
+			    enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *pgid_entry;
+	u16 pgid_ports;
+
+	if (type == ENTRYTYPE_MACV4 || type == ENTRYTYPE_MACV6 || !ports)
+		return NULL;
+
+	/* CPU_PORT forwarding is handled by cpu_copy flag on mac table entry.
+	 * So we can strip CPU_PORT here to allow better PGID sharing.
+	 */
+	pgid_ports = ports & ~BIT(CPU_PORT);
+
+	pgid_entry = lan9645x_mdb_pgid_entry_lookup(lan9645x, pgid_ports);
+	if (!pgid_entry)
+		return lan9645x_mdb_pgid_entry_create(lan9645x, pgid_ports);
+
+	return pgid_entry;
+}
+
+static int lan9645x_mdb_update_dest(struct lan9645x *lan9645x,
+				    struct lan9645x_mdb_entry *mdb_entry,
+				    enum macaccess_entry_type type,
+				    struct lan9645x_pgid_entry *new_pgid,
+				    u16 new_ports)
+{
+	struct lan9645x_pgid_entry *old_pgid;
+	unsigned char mac[ETH_ALEN];
+	int err, pgid_index;
+	bool cpu_copy;
+
+	old_pgid = mdb_entry->pgid;
+	lan9645x_mdb_encode_mac(mac, mdb_entry->mac, new_ports, type);
+	cpu_copy = !!(new_ports & BIT(CPU_PORT));
+	pgid_index = PGID_INDEX(new_pgid);
+
+	/* For IP multicast, the hardware lookup uses the DMAC
+	 * (01:00:5E:.. / 33:33:..) as the (mac, vid) key, not the encoded mac.
+	 * Therefore, this CMD_LEARN will atomically rewrite the existing
+	 * hardware entry. We intentionally do not do a forget before learn
+	 * sequence, as that would not be atomic, and leave a forwarding gap.
+	 */
+	err = lan9645x_mact_learn_cpu_copy(lan9645x, pgid_index, mac,
+					   mdb_entry->vid, type, cpu_copy);
+	if (err) {
+		lan9645x_pgid_entry_put(lan9645x, new_pgid);
+		return err;
+	}
+	mdb_entry->pgid = new_pgid;
+	mdb_entry->ports = new_ports;
+	lan9645x_pgid_entry_put(lan9645x, old_pgid);
+	return 0;
+}
+
+static int __lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port,
+			      const unsigned char addr[ETH_ALEN], u16 vid,
+			      enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *new_pgid;
+	struct lan9645x_mdb_entry *mdb_entry;
+	u16 new_ports;
+	int err;
+
+	mdb_entry = lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
+	if (!mdb_entry) {
+		mdb_entry = lan9645x_mdb_entry_alloc(lan9645x, addr, vid);
+		if (IS_ERR(mdb_entry))
+			return PTR_ERR(mdb_entry);
+	}
+
+	if (mdb_entry->ports & BIT(chip_port))
+		return 0;
+
+	new_ports = mdb_entry->ports | BIT(chip_port);
+
+	/* Update PGID ptr for non-IP entries (L2 multicast) */
+	new_pgid = lan9645x_mdb_pgid_entry_get(lan9645x, new_ports, type);
+	if (IS_ERR(new_pgid)) {
+		/* Out of PGIDs or mem. Continue forwarding to old port
+		 * group, or remove if fresh mdb_entry.
+		 */
+		if (!mdb_entry->ports)
+			lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
+
+		return PTR_ERR(new_pgid);
+	}
+
+	err = lan9645x_mdb_update_dest(lan9645x, mdb_entry, type, new_pgid,
+				       new_ports);
+	if (err && !mdb_entry->ports)
+		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
+
+	return err;
+}
+
+static int __lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port,
+			      const unsigned char addr[ETH_ALEN], u16 vid,
+			      enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *new_pgid;
+	struct lan9645x_mdb_entry *mdb_entry;
+	u16 new_ports;
+	int err;
+
+	mdb_entry = lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
+	if (!mdb_entry)
+		return -ENOENT;
+
+	if (!(mdb_entry->ports & BIT(chip_port)))
+		return 0;
+
+	new_ports = mdb_entry->ports & ~BIT(chip_port);
+
+	if (!new_ports) {
+		/* For IP multicast hardware uses DMAC as key (mac,vid) not
+		 * encoded mac.
+		 */
+		err = lan9645x_mact_forget(lan9645x, mdb_entry->mac,
+					   mdb_entry->vid, type);
+		if (err)
+			return err;
+		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
+		return 0;
+	}
+
+	/* Update PGID ptr for non-IP entries (L2 multicast) */
+	new_pgid = lan9645x_mdb_pgid_entry_get(lan9645x, new_ports, type);
+	if (IS_ERR(new_pgid))
+		/* Continue forwarding to old port group. */
+		return PTR_ERR(new_pgid);
+
+	return lan9645x_mdb_update_dest(lan9645x, mdb_entry, type, new_pgid,
+					new_ports);
+}
+
+static int lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port,
+			    const unsigned char addr[ETH_ALEN], u16 vid,
+			    enum macaccess_entry_type type)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mdb_lock);
+	err = __lan9645x_mdb_add(lan9645x, chip_port, addr, vid, type);
+	mutex_unlock(&lan9645x->mdb_lock);
+	return err;
+}
+
+static int lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port,
+			    const unsigned char addr[ETH_ALEN], u16 vid,
+			    enum macaccess_entry_type type)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mdb_lock);
+	err = __lan9645x_mdb_del(lan9645x, chip_port, addr, vid, type);
+	mutex_unlock(&lan9645x->mdb_lock);
+	return err;
+}
+
+int lan9645x_mdb_port_add(struct lan9645x *lan9645x, int port,
+			  const struct switchdev_obj_port_mdb *mdb,
+			  struct net_device *bridge)
+{
+	enum macaccess_entry_type type;
+	u16 vid = mdb->vid;
+
+	type = lan9645x_mdb_classify(mdb->addr);
+
+	if (!vid)
+		vid = lan9645x_vlan_unaware_pvid(!!bridge);
+
+	return lan9645x_mdb_add(lan9645x, port, mdb->addr, vid, type);
+}
+
+int lan9645x_mdb_port_del(struct lan9645x *lan9645x, int port,
+			  const struct switchdev_obj_port_mdb *mdb,
+			  struct net_device *bridge)
+{
+	enum macaccess_entry_type type;
+	u16 vid = mdb->vid;
+
+	type = lan9645x_mdb_classify(mdb->addr);
+
+	if (!vid)
+		vid = lan9645x_vlan_unaware_pvid(!!bridge);
+
+	return lan9645x_mdb_del(lan9645x, port, mdb->addr, vid, type);
+}
+
+void lan9645x_mdb_deinit(struct lan9645x *lan9645x)
+{
+	struct lan9645x_mdb_entry *mdb, *tmp;
+
+	list_for_each_entry_safe(mdb, tmp, &lan9645x->mdb_entries, list)
+		lan9645x_mdb_entry_dealloc(lan9645x, mdb);
+
+	mutex_destroy(&lan9645x->mdb_lock);
+}
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
index 87eb0f6dce4c..b8300745ec40 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -208,8 +208,17 @@ int lan9645x_port_setup(struct dsa_switch *ds, int port)
 		ANA_PORT_CFG_PORTID_VAL,
 		lan9645x, ANA_PORT_CFG(p->chip_port));
 
-	if (p->chip_port != lan9645x->npi)
+	if (p->chip_port != lan9645x->npi) {
 		lan9645x_vlan_set_hostmode(p);
 
+		lan_rmw(ANA_CPU_FWD_CFG_IGMP_REDIR_ENA_SET(true) |
+			ANA_CPU_FWD_CFG_MLD_REDIR_ENA_SET(true) |
+			ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA_SET(true),
+			ANA_CPU_FWD_CFG_IGMP_REDIR_ENA |
+			ANA_CPU_FWD_CFG_MLD_REDIR_ENA |
+			ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA,
+			lan9645x, ANA_CPU_FWD_CFG(p->chip_port));
+	}
+
 	return 0;
 }
diff --git a/include/linux/dsa/lan9645x.h b/include/linux/dsa/lan9645x.h
index 34c18bf975d0..ac0e70c704a5 100644
--- a/include/linux/dsa/lan9645x.h
+++ b/include/linux/dsa/lan9645x.h
@@ -131,4 +131,15 @@
 #define IFH_DUPL_DISC_ENA_SZ		1
 #define IFH_RCT_AVAIL_SZ		1
 
+/* Chip has 8 cpu queues. The cpu queues used by a frame is passed as a mask in
+ * the IFH on extraction. We use this to avoid classifying IGMP and MLD frames
+ * in the tag driver.
+ */
+enum {
+	LAN9645X_CPUQ_DEF = 0,
+	LAN9645X_CPUQ_IGMP = 1,
+	LAN9645X_CPUQ_MLD = 2,
+	LAN9645X_CPUQ_IPMC_CTRL = 3,
+};
+
 #endif /* _NET_DSA_TAG_LAN9645X_H_ */
diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
index 0b639228215e..4db1ed055d2e 100644
--- a/net/dsa/tag_lan9645x.c
+++ b/net/dsa/tag_lan9645x.c
@@ -155,6 +155,20 @@ static void lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
 					     LAN9645X_IFH_TAG_TYPE_C;
 }
 
+static void lan9645x_offload_fwd_mark(struct sk_buff *skb, u32 cpuq)
+{
+	u32 cpu_redir;
+
+	/* IGMP/MLD are trapped to CPU, and must be forwarded by the stack */
+	cpu_redir = BIT(LAN9645X_CPUQ_IGMP) | BIT(LAN9645X_CPUQ_MLD);
+	if (cpuq & cpu_redir) {
+		skb->offload_fwd_mark = 0;
+		return;
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+}
+
 static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
 				     struct net_device *ndev)
 {
@@ -195,7 +209,7 @@ static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
 static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
-	u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs;
+	u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs, cpuq;
 	struct dsa_port *dp;
 	u32 ifh_gap_len = 0;
 	u16 vlan_tpid;
@@ -218,6 +232,7 @@ static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
 	tag_type = lan9645x_ifh_get(ifh, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
 	vlan_tci = lan9645x_ifh_get(ifh, IFH_TCI, IFH_TCI_SZ);
 	qos_class = lan9645x_ifh_get(ifh, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
+	cpuq = lan9645x_ifh_get(ifh, IFH_CPUQ, IFH_CPUQ_SZ);
 
 	/* Set skb->data at start of real header
 	 *
@@ -260,7 +275,7 @@ static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
 		return NULL;
 	}
 
-	dsa_default_offload_fwd_mark(skb);
+	lan9645x_offload_fwd_mark(skb, cpuq);
 
 	skb->priority = qos_class;
 

-- 
2.52.0


