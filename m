Return-Path: <netdev+bounces-284730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHFIEPzt+mn3UQMAu9opvQ
	(envelope-from <netdev+bounces-284730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD14D73C9
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148A1306A5CD
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B936AB5E;
	Wed,  6 May 2026 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ooV9qgDT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB379EEA;
	Wed,  6 May 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052375; cv=none; b=ZjaU+LHXVE6Ybw1nHT7/g4TXrEuzUhf7NnMh/qJZ3lXgAu2yxQ+JkkwCYGN6ku0tfGpOV3hlYhetvqwhbVPTFwhyvYSctSfss8pydSXVhgMn0hMAAm4cxZMVoRAHzE4sXNcbrlg0YTVFLSpNUhbTCk94dw5oaej9tIWnLd3bsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052375; c=relaxed/simple;
	bh=7kododvTQ68yKTSDo3YpbRkIFBnTYQ7gfRla+bTGEck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FSHXNC9tVNbT1fg63mfxWZTR68WEMhIoc3C3dlpMAXQHQV3gzqZHIb5Xb/jwu47sg9+wS8BZDId6CGarzTl6bDscTKHQkBXNKkB5arN/bESgUi78hzG1KmoXZ3VonHOUCt7Qe8ZTsV8CPyW3Kl5wqd2rx7bwyU9ecuX8Z5Qylxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ooV9qgDT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778052372; x=1809588372;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7kododvTQ68yKTSDo3YpbRkIFBnTYQ7gfRla+bTGEck=;
  b=ooV9qgDTKZYw752bLVpjY3pH0JoitpuIKODN0f9nI3il3lpm1ZRZoR6c
   NBHU69hiHnVtzhF5nd1PG23vpYYVwhqb4ymABwKoxmzz30hj2Nf2zXvH+
   a+kla8ECy1o2umwU7F9Qpo8yFd0ZC3S8TmUryo6NCyYX/nx9a6Mvc2x0v
   u3wF1Ti2w3/OgNPF87hNz4TllyrnpvEbaK2N2xFhAdMOlZ9ndB8+meJ6M
   T4STKDeKDRSkb/T+EsuXKb6yOzg10X3rcKEteQSYCI5iwXX5+6+sBhEpg
   rfPlqxgdMwXcWpBghmLCoLgOjJKQgIrbwQvCREdAAWxJYOozjPQCgggw5
   A==;
X-CSE-ConnectionGUID: qz5Evn+OQfO8zCrhGrl+XA==
X-CSE-MsgGUID: st7y93lxRreywRzRdtcX3g==
X-IronPort-AV: E=Sophos;i="6.23,219,1770620400"; 
   d="scan'208";a="56331557"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2026 00:26:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 6 May 2026 00:26:11 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 6 May 2026 00:26:08 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 6 May 2026 09:25:36 +0200
Subject: [PATCH net v2 1/4] net: sparx5: defer VCAP debugfs creation until
 after netdev registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260506-misc-fixes-sparx5-lan969x-v2-1-fb236aa96908@microchip.com>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
In-Reply-To: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: EFFD14D73C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284730-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,microchip.com:mid]

Commit 3a95973e7c79 ("net: sparx5: move VCAP initialization to probe")
moved sparx5_vcap_init() ahead of sparx5_register_netdevs() in probe.
The VCAP init path ends by calling vcap_port_debugfs() for every port,
which uses netdev_name(ndev) as the debugfs file name. At that point
the netdevs have only been allocated, not registered, so dev->name
still holds the "eth%d" template and netdev_name() returns
"(unnamed net_device)". Every port tries to create the same file under
vcaps/, producing a flood of warnings at boot:

  debugfs: '(unnamed net_device)' already exists in 'vcaps'
  debugfs: '(unnamed net_device)' already exists in 'vcaps'
  ...

Move the debugfs setup into a new sparx5_debugfs() helper in
sparx5_debugfs.c, invoked after sparx5_register_notifier_blocks()
succeeds so the netdev names are finalized. sparx5_vcap_init() now
only deals with VCAP state. The sparx5/ debugfs root is created in
the new helper as well.

Fixes: 3a95973e7c79 ("net: sparx5: move VCAP initialization to probe")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Makefile     |  3 ++-
 .../net/ethernet/microchip/sparx5/sparx5_debugfs.c | 26 ++++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  4 ++--
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  7 ++++++
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |  6 -----
 5 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index d447f9e84d92..eb5c81527f41 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -14,7 +14,8 @@ sparx5-switch-y  := sparx5_main.o sparx5_packet.o \
  sparx5_psfp.o sparx5_mirror.o sparx5_regs.o
 
 sparx5-switch-$(CONFIG_SPARX5_DCB) += sparx5_dcb.o
-sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
+sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o \
+				    sparx5_debugfs.o
 
 sparx5-switch-$(CONFIG_LAN969X_SWITCH) += lan969x/lan969x_regs.o \
 					  lan969x/lan969x.o \
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_debugfs.c b/drivers/net/ethernet/microchip/sparx5/sparx5_debugfs.c
new file mode 100644
index 000000000000..f6cb1eeaab80
--- /dev/null
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_debugfs.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip Sparx5 Switch driver debug filesystem support
+ *
+ * Copyright (c) 2026 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include <linux/debugfs.h>
+
+#include "sparx5_main.h"
+#include "vcap_api_debugfs.h"
+
+void sparx5_debugfs(struct sparx5 *sparx5)
+{
+	const struct sparx5_consts *consts = sparx5->data->consts;
+	struct vcap_control *ctrl = sparx5->vcap_ctrl;
+	struct dentry *dir;
+	int idx;
+
+	sparx5->debugfs_root = debugfs_create_dir("sparx5", NULL);
+
+	dir = vcap_debugfs(sparx5->dev, sparx5->debugfs_root, ctrl);
+	for (idx = 0; idx < consts->n_ports; ++idx)
+		if (sparx5->ports[idx])
+			vcap_port_debugfs(sparx5->dev, dir, ctrl,
+					  sparx5->ports[idx]->ndev);
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index dad713e9ddd5..bec07560e6fe 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -820,8 +820,6 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	/* Default values, some from DT */
 	sparx5->coreclock = SPX5_CORE_CLOCK_DEFAULT;
 
-	sparx5->debugfs_root = debugfs_create_dir("sparx5", NULL);
-
 	ports = of_get_child_by_name(np, "ethernet-ports");
 	if (!ports) {
 		dev_err(sparx5->dev, "no ethernet-ports child node found\n");
@@ -1000,6 +998,8 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_netdevs;
 	}
 
+	sparx5_debugfs(sparx5);
+
 	goto cleanup_config;
 
 cleanup_netdevs:
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 6a745bb71b5c..d5e6644ff124 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -565,6 +565,13 @@ void sparx5_get_hwtimestamp(struct sparx5 *sparx5,
 int sparx5_vcap_init(struct sparx5 *sparx5);
 void sparx5_vcap_deinit(struct sparx5 *sparx5);
 
+/* sparx5_debugfs.c */
+#if defined(CONFIG_DEBUG_FS)
+void sparx5_debugfs(struct sparx5 *sparx5);
+#else
+static inline void sparx5_debugfs(struct sparx5 *sparx5) {}
+#endif
+
 /* sparx5_pgid.c */
 enum sparx5_pgid_type {
 	SPX5_PGID_FREE,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index 95b93e46a41d..dd446b3a9f20 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -2035,7 +2035,6 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 	const struct sparx5_vcap_inst *cfg;
 	struct vcap_control *ctrl;
 	struct vcap_admin *admin;
-	struct dentry *dir;
 	int err = 0, idx;
 
 	/* Create a VCAP control instance that owns the platform specific VCAP
@@ -2074,11 +2073,6 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 			sparx5_vcap_port_key_selection(sparx5, admin);
 		list_add_tail(&admin->list, &ctrl->list);
 	}
-	dir = vcap_debugfs(sparx5->dev, sparx5->debugfs_root, ctrl);
-	for (idx = 0; idx < consts->n_ports; ++idx)
-		if (sparx5->ports[idx])
-			vcap_port_debugfs(sparx5->dev, dir, ctrl,
-					  sparx5->ports[idx]->ndev);
 
 	return err;
 }

-- 
2.34.1


