Return-Path: <netdev+bounces-270991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOP+LYNtwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:54:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34499306D20
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D17C3050915
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1213E95B6;
	Tue, 24 Mar 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a7UD5pQk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18393E716C;
	Tue, 24 Mar 2026 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349465; cv=none; b=F+45Ubkc67JNh4UhRFS7d556JJXUVybJmRQeSKgtzV2uS28xoKDsHrZxkdWMYPlO1gzjDmXsm8kKJtTRlKFlTB/tGnwFaqBkMF312s/IG/0pS2urkLfX6vne5mYJdRo8kgRpV1/hqgjE6eg7aAjRs+CWJ6Jto5/GUywbjTHDmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349465; c=relaxed/simple;
	bh=EsNzF3sc87MdfE8dBtV9lZybhab7jt4X5Ze/nLTZcmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bOJSjbzaszI3wt3DtaQ+9ObnfA5hYsVhqNX8KTciqxkRtWDhIFfaSCfNW+mfEqakVx6Zwef6jriSM1IL/VZmZZ3/04eU+DIbTnuHp82fvR+rMvYkxyv7+hT6XB3N3WJTX8qyfh+qYLvBZUS8SkayrE+WW9qP9nHHNtXZzZH5fj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a7UD5pQk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774349459; x=1805885459;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EsNzF3sc87MdfE8dBtV9lZybhab7jt4X5Ze/nLTZcmM=;
  b=a7UD5pQklnNlCvbpf42tZqVv4JW5pAPdZlvKR+3d8cmbfK10pALdUAiF
   LqnYvMMLox/6V0THdD3fsrLTW3MGUd0N0AfQL4L8ggdfI5z7NNbP21eY5
   1jy+JRf0Vg18Z63Q/7JxhJcW7Eh8TucU+MzVxahHmodTyUfS068uAQrA/
   b2ZXFrSxM8db56eY9tAk34cxk3DPDPWKqdXOTf21inUkOmsLPUc7NJY8z
   8OENxgOkllxGIDui3VfnpQqBIBE2M9+sX9qn8nR/DrMhW5vMAd2w2JdSX
   Piq61vKoSQj9VGjwWUQ6DkAECbPFbRYR40HKpTJJw2RBkrSYXXVN9u9xb
   A==;
X-CSE-ConnectionGUID: vgUXfekRRgebdU5TbZAl3Q==
X-CSE-MsgGUID: MJr9pPFES4mlUQuKzUhVbA==
X-IronPort-AV: E=Sophos;i="6.23,138,1770620400"; 
   d="scan'208";a="54371283"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2026 03:50:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 24 Mar 2026 03:50:34 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 24 Mar 2026 03:50:31 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 24 Mar 2026 11:46:51 +0100
Subject: [PATCH net-next v2 8/9] net: dsa: lan9645x: add mdb management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260324-dsa_lan9645x_switch_driver_base-v2-8-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270991-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Queue-Id: 34499306D20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for dsa mdb callbacks. L2 multicast and IP multicast is
handled differently. IP multicast stores the port group mask inline in
the mac table. L2 multicast points to a PGID index, which encodes the
port group mask.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v2:
- New file: selftests required implementation of the mdb callbacks.
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  |  14 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  61 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  21 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c  | 391 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |   8 +
 include/linux/dsa/lan9645x.h                       |  11 +
 net/dsa/tag_lan9645x.c                             |  19 +-
 8 files changed, 524 insertions(+), 2 deletions(-)

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
index 6335714dca21..13bf027af969 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
@@ -215,6 +215,20 @@ int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
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
index 32c0301030a4..24a60f40f6b8 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -72,6 +72,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 	destroy_workqueue(lan9645x->owq);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
 	lan9645x_mac_deinit(lan9645x);
+	lan9645x_mdb_deinit(lan9645x);
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 }
 
@@ -159,6 +160,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
 	mutex_init(&lan9645x->fwd_domain_lock);
 	lan9645x_vlan_init(lan9645x);
 	lan9645x_mac_init(lan9645x);
+	lan9645x_mdb_init(lan9645x);
 
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
@@ -669,6 +671,61 @@ static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
 	return err;
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
 
@@ -702,6 +759,10 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
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
index 012d5bb17013..c7e4276dd74a 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -218,6 +218,14 @@ struct lan9645x {
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
 	bool dd_dis;
 	bool tsn_dis;
@@ -422,5 +430,18 @@ int lan9645x_mact_entry_del(struct lan9645x *lan9645x, int pgid,
 			    const unsigned char *mac, u16 vid);
 int lan9645x_mact_entry_add(struct lan9645x *lan9645x, int pgid,
 			    const unsigned char *mac, u16 vid);
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
index 000000000000..4cf92887a4eb
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+/* HW ignores dest_idx for IPv4/IPv6 types, so we use this dummy index */
+#define IP_ENTRY_PGID 0
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
+void lan9645x_mdb_deinit(struct lan9645x *lan9645x)
+{
+	mutex_destroy(&lan9645x->mdb_lock);
+}
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
+static int lan9645x_mdb_pgid_index(struct lan9645x_mdb_entry *mdb_entry,
+				   enum macaccess_entry_type type)
+{
+	switch (type) {
+	case ENTRYTYPE_MACV4:
+	case ENTRYTYPE_MACV6:
+		return IP_ENTRY_PGID;
+	default:
+		return mdb_entry->pgid->index;
+	}
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
+static void lan9645x_mdb_encode_mac(unsigned char *mac,
+				    struct lan9645x_mdb_entry *mdb_entry,
+				    enum macaccess_entry_type type)
+{
+	ether_addr_copy(mac, mdb_entry->mac);
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
+		mac[0] = 0;
+		mac[1] = mdb_entry->ports >> 8;
+		mac[2] = mdb_entry->ports & 0xff;
+	} else if (type == ENTRYTYPE_MACV6) {
+		mac[0] = mdb_entry->ports >> 8;
+		mac[1] = mdb_entry->ports & 0xff;
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
+lan9645x_mdb_pgid_entry_get(struct lan9645x *lan9645x,
+			    struct lan9645x_mdb_entry *mdb_entry,
+			    enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *pgid_entry;
+	u16 pgid_ports;
+
+	if (type == ENTRYTYPE_MACV4 || type == ENTRYTYPE_MACV6 ||
+	    !mdb_entry->ports)
+		return NULL;
+
+	/* CPU_PORT forwarding is handled by cpu_copy flag on mac table entry.
+	 * So we can strip CPU_PORT here to allow better PGID sharing.
+	 */
+	pgid_ports = mdb_entry->ports & ~BIT(CPU_PORT);
+
+	pgid_entry = lan9645x_mdb_pgid_entry_lookup(lan9645x, pgid_ports);
+	if (!pgid_entry)
+		return lan9645x_mdb_pgid_entry_create(lan9645x, pgid_ports);
+
+	return pgid_entry;
+}
+
+static int __lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port,
+			      const unsigned char addr[ETH_ALEN], u16 vid,
+			      enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *old_pgid, *new_pgid;
+	struct lan9645x_mdb_entry *mdb_entry;
+	unsigned char mac[ETH_ALEN];
+	int err, pgid_index;
+	bool cpu_copy;
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
+	mdb_entry->ports |= BIT(chip_port);
+
+	/* Encode mac for IP mc */
+	lan9645x_mdb_encode_mac(mac, mdb_entry, type);
+
+	/* Update PGID ptr for non-IP entries (L2 multicast) */
+	old_pgid = mdb_entry->pgid;
+	new_pgid = lan9645x_mdb_pgid_entry_get(lan9645x, mdb_entry, type);
+	if (IS_ERR(new_pgid)) {
+		/* Out of PGIDs or mem. Continue forwarding to old port
+		 * group, or remove if fresh mdb_entry.
+		 */
+		mdb_entry->ports &= ~BIT(chip_port);
+		if (!mdb_entry->ports)
+			lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
+
+		return PTR_ERR(new_pgid);
+	}
+	mdb_entry->pgid = new_pgid;
+
+	cpu_copy = !!(mdb_entry->ports & BIT(CPU_PORT));
+	pgid_index = lan9645x_mdb_pgid_index(mdb_entry, type);
+
+	/* Make sure to write on top of existing entry, so we do not disrupt
+	 * flowing traffic.
+	 */
+	err = lan9645x_mact_learn_cpu_copy(lan9645x, pgid_index, mac,
+					   mdb_entry->vid, type, cpu_copy);
+	lan9645x_pgid_entry_put(lan9645x, old_pgid);
+	return err;
+}
+
+static int __lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port,
+			      const unsigned char addr[ETH_ALEN], u16 vid,
+			      enum macaccess_entry_type type)
+{
+	struct lan9645x_pgid_entry *old_pgid, *new_pgid;
+	struct lan9645x_mdb_entry *mdb_entry;
+	unsigned char mac[ETH_ALEN];
+	int err, pgid_index;
+	bool cpu_copy;
+
+	mdb_entry = lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
+	if (!mdb_entry)
+		return -ENOENT;
+
+	if (!(mdb_entry->ports & BIT(chip_port)))
+		return 0;
+
+	mdb_entry->ports &= ~BIT(chip_port);
+
+	/* Encode mac for IP mc */
+	lan9645x_mdb_encode_mac(mac, mdb_entry, type);
+
+	/* Update PGID ptr for non-IP entries (L2 multicast) */
+	old_pgid = mdb_entry->pgid;
+	new_pgid = lan9645x_mdb_pgid_entry_get(lan9645x, mdb_entry, type);
+	if (IS_ERR(new_pgid)) {
+		/* Continue forwarding to old port group. */
+		mdb_entry->ports |= BIT(chip_port);
+		return PTR_ERR(new_pgid);
+	}
+	mdb_entry->pgid = new_pgid;
+
+	if (!mdb_entry->ports) {
+		lan9645x_mact_forget(lan9645x, mac, mdb_entry->vid, type);
+		lan9645x_pgid_entry_put(lan9645x, old_pgid);
+		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
+		return 0;
+	}
+
+	cpu_copy = !!(mdb_entry->ports & BIT(CPU_PORT));
+	pgid_index = lan9645x_mdb_pgid_index(mdb_entry, type);
+
+	err = lan9645x_mact_learn_cpu_copy(lan9645x, pgid_index, mac,
+					   mdb_entry->vid, type, cpu_copy);
+	lan9645x_pgid_entry_put(lan9645x, old_pgid);
+	return err;
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
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
index 3fe8de0ce902..2c13249e79d3 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -175,6 +175,14 @@ int lan9645x_port_setup(struct dsa_switch *ds, int port)
 		ANA_PORT_CFG_PORTID_VAL,
 		lan9645x, ANA_PORT_CFG(p->chip_port));
 
+	lan_rmw(ANA_CPU_FWD_CFG_IGMP_REDIR_ENA_SET(true) |
+		ANA_CPU_FWD_CFG_MLD_REDIR_ENA_SET(true) |
+		ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA_SET(true),
+		ANA_CPU_FWD_CFG_IGMP_REDIR_ENA |
+		ANA_CPU_FWD_CFG_MLD_REDIR_ENA |
+		ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA,
+		lan9645x, ANA_CPU_FWD_CFG(p->chip_port));
+
 	if (p->chip_port != lan9645x->npi)
 		lan9645x_vlan_set_hostmode(p);
 
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
index 9130fb0d61be..e15ed29e5e87 100644
--- a/net/dsa/tag_lan9645x.c
+++ b/net/dsa/tag_lan9645x.c
@@ -152,6 +152,20 @@ static void lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
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
+	return dsa_default_offload_fwd_mark(skb);
+}
+
 static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
 				     struct net_device *ndev)
 {
@@ -192,7 +206,7 @@ static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
 static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
-	u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs;
+	u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs, cpuq;
 	u8 *orig_skb_data = skb->data;
 	struct dsa_port *dp;
 	u32 ifh_gap_len = 0;
@@ -212,6 +226,7 @@ static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
 	tag_type = lan9645x_ifh_get(ifh, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
 	vlan_tci = lan9645x_ifh_get(ifh, IFH_TCI, IFH_TCI_SZ);
 	qos_class = lan9645x_ifh_get(ifh, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
+	cpuq = lan9645x_ifh_get(ifh, IFH_CPUQ, IFH_CPUQ_SZ);
 
 	/* Set skb->data at start of real header
 	 *
@@ -242,7 +257,7 @@ static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
 		return NULL;
 	}
 
-	dsa_default_offload_fwd_mark(skb);
+	lan9645x_offload_fwd_mark(skb, cpuq);
 
 	skb->priority = qos_class;
 

-- 
2.52.0


