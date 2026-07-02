Return-Path: <netdev+bounces-303998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DPTCFdwKRmrtIAsAu9opvQ
	(envelope-from <netdev+bounces-303998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:53:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A286F3EF8
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:53:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=DWkJgp87;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303998-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303998-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E869E31037CE
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 06:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6E38D403;
	Thu,  2 Jul 2026 06:46:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1938D41A;
	Thu,  2 Jul 2026 06:46:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974777; cv=none; b=NxzIdYd05kgFYt6jpkTqWTt+X1Gvi6RnYonqlS95n8mJpJEnv2HcBi5R5OYqhYUNT+1xPA5smYhLx79xRGzmFnKGmnmgs2O4pcA26u0gJ6KKaza96VY/fkgpvhrmBqXC9YcgK3mVcscH/mdjK6ulR6ZtFGY8PcDI9wHt70x4Vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974777; c=relaxed/simple;
	bh=Z4wempHW55pE9yoHJyQ0QEe7URgHCMr5a7FMBqlzRhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lElwcA7eo+hjdyvgfDZdfbhdoXi2copSZVLYm3DtwpzjIO2G5M5a0rycIQbJz80b7jx/Npg/bPVApKNR0TVbqjtl9bS3+rC0Io+rWQ91mnQBsD8zgTZ/G6EhVaJXT1X9NM7S8yuE5klV64mDtx5PnKo/cGa4pxzUM4Csxecjcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DWkJgp87; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782974776; x=1814510776;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Z4wempHW55pE9yoHJyQ0QEe7URgHCMr5a7FMBqlzRhE=;
  b=DWkJgp87HItfGkhOiu4XlNRv4WnGYpGRBBHnY2/szZbKJuGRflnW0vZX
   m45feSjM143zZu00xDZVQKUzD8ihAFsOXNUPj1XwXyS439yFw/ck/pKxJ
   3Ikfj0wvqfgRUGByD5fygMCQuuMKVXiWVCMvuGrtmUxqvjrhkz1seWIld
   bDZ/ZnxgF4THPYJToiSvu5Ds6IfdVXVL4TYpW7POVGzeFj0LwT6j/nKsc
   THOzfJGlkDV+K/1EejmWxBsYKH+RqKgOFYGKSSjJ3BEoE/SEJ4ybf10R2
   vM2lu/rKnFgVx6izsLcEFcVtCLUMiPSzv95VwDZ6tFLHOyX7DWhvVOdfE
   w==;
X-CSE-ConnectionGUID: lkudt1gmQEqM0/EP8sqaIw==
X-CSE-MsgGUID: X6SblvczSPqkJdXvUFvUNw==
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="291391543"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:46:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 1 Jul 2026 23:46:11 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 1 Jul 2026 23:46:08 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Thu, 2 Jul 2026 08:45:17 +0200
Subject: [PATCH net-next v8 6/9] net: dsa: lan9645x: add vlan support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260702-dsa_lan9645x_switch_driver_base-v8-6-90228d8bba58@microchip.com>
References: <20260702-dsa_lan9645x_switch_driver_base-v8-0-90228d8bba58@microchip.com>
In-Reply-To: <20260702-dsa_lan9645x_switch_driver_base-v8-0-90228d8bba58@microchip.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303998-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:woojung.huh@microchip.com,m:linux@armlinux.org.uk,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:jensemil.schulzostergaard@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9A286F3EF8

Add VLAN support for VLAN-aware and VLAN-unaware bridges.

VID 4095 (HOST_PVID) is reserved and used internally as the port
VLAN for standalone (non-bridged) ports so their FDB domain is
isolated from bridged traffic.

VID 0 is used internally as the port VLAN for VLAN-unaware bridge ports
(UNAWARE_PVID).

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v8:
- Use lan9645x->num_phys_ports instead of CPU_PORT for the CPU port
  module, and reword the portmask comment.

Changes in v5:
- switch -EBUSY to -EINVAL for vlan add/del in the reserved range.
- remove reserved HSR vlan
- update commit message

Changes in v4:
- fix clear HOST_PVID vlan membership when a port joins a bridge
- explicit default value write to tag type register for untagged frames
- use lan_rmw for ANA_DROP_CFG
- add comment for error path in lan9645x_vlan_hw_wr
- use dsa_switch_for_each_user_port to iterate ports

Changes in v3:
- use SET register macros in vlan_hw_wr
- add vlan id bounds check to vlan_del
- return vlan_hw_wr timeout err on init
- move cpu vlan action after bounds check

Changes in v2:
- redesign based on selftests which rely on changing vlan_default_pvid.
  Our HW limitations were too forward. Following Vladimirs changes to
  ocelot VLAN implementation, we now dynamically change egress tag
  configuration, allowing more states.
- selftests are passing, except an expected failure w.r.t ctag/stag
  conformance, which is a hw limitation.
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  50 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  29 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |   3 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c | 403 +++++++++++++++++++++
 5 files changed, 486 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
index 7cc0ae0ada40..e049114b3563 100644
--- a/drivers/net/dsa/microchip/lan9645x/Makefile
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -6,3 +6,4 @@ mchp-lan9645x-objs := \
 	lan9645x_npi.o \
 	lan9645x_phylink.o \
 	lan9645x_port.o \
+	lan9645x_vlan.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index 4dd449d9014b..4de59efea791 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -151,6 +151,9 @@ static int lan9645x_setup(struct dsa_switch *ds)
 
 	mutex_init(&lan9645x->port_mux_lock);
 	mutex_init(&lan9645x->fwd_domain_lock);
+	err = lan9645x_vlan_init(lan9645x);
+	if (err)
+		goto err_mutex;
 
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
@@ -524,6 +527,7 @@ static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
 
 	lan9645x->bridge_mask |= BIT(p->chip_port);
 	__lan9645x_port_set_host_flood(lan9645x);
+	lan9645x_vlan_clear_hostmode(p);
 
 	mutex_unlock(&lan9645x->fwd_domain_lock);
 
@@ -579,11 +583,52 @@ static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
 		lan9645x->bridge = NULL;
 
 	__lan9645x_port_set_host_flood(lan9645x);
+	lan9645x_vlan_set_hostmode(p);
 	lan9645x_update_fwd_mask(lan9645x);
 
 	mutex_unlock(&lan9645x->fwd_domain_lock);
 }
 
+static int lan9645x_port_vlan_filtering(struct dsa_switch *ds, int port,
+					bool enabled,
+					struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+	p->vlan_aware = enabled;
+	lan9645x_vlan_port_apply(p);
+
+	return 0;
+}
+
+static int lan9645x_port_vlan_add(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_vlan *vlan,
+				  struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+	bool pvid, untagged;
+
+	p = lan9645x_to_port(lan9645x, port);
+	pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+
+	return lan9645x_vlan_port_add_vlan(p, vlan->vid, pvid, untagged,
+					   extack);
+}
+
+static int lan9645x_port_vlan_del(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_vlan *vlan)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+	return lan9645x_vlan_port_del_vlan(p, vlan->vid);
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -606,6 +651,11 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.port_bridge_leave		= lan9645x_port_bridge_leave,
 	.port_stp_state_set		= lan9645x_port_bridge_stp_state_set,
 	.port_set_host_flood		= lan9645x_port_set_host_flood,
+
+	/* VLAN integration */
+	.port_vlan_filtering		= lan9645x_port_vlan_filtering,
+	.port_vlan_add			= lan9645x_port_vlan_add,
+	.port_vlan_del			= lan9645x_port_vlan_del,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index 6eae01bb337b..335afdef4492 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -7,6 +7,7 @@
 
 #include <linux/dsa/lan9645x.h>
 #include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/regmap.h>
 #include <net/dsa.h>
 
@@ -156,6 +157,17 @@ enum lan9645x_vlan_port_tag {
 	LAN9645X_TAG_ALL = 3,
 };
 
+struct lan9645x_vlan {
+	u32 portmask: 10, /* ports 0-8 + CPU port module */
+	    untagged: 9, /* ports 0-8 */
+	    src_chk: 1,
+	    mir: 1,
+	    lrn_dis: 1,
+	    prv_vlan: 1,
+	    fld_dis: 1,
+	    s_fwd_ena: 1;
+};
+
 struct lan9645x {
 	struct device *dev;
 	struct dsa_switch *ds;
@@ -182,6 +194,9 @@ struct lan9645x {
 	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
 	struct mutex fwd_domain_lock; /* lock forwarding configuration */
 
+	/* VLAN entries */
+	struct lan9645x_vlan vlans[VLAN_N_VID];
+
 	int num_port_dis;
 };
 
@@ -192,6 +207,9 @@ struct lan9645x_port {
 	u8 stp_state;
 	bool learn_ena;
 
+	bool vlan_aware;
+	u16 pvid;
+
 	bool rx_internal_delay;
 	bool tx_internal_delay;
 
@@ -358,4 +376,15 @@ void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
 			       struct phylink_config *c);
 void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port);
 
+/* VLAN lan9645x_vlan.c */
+int lan9645x_vlan_init(struct lan9645x *lan9645x);
+u16 lan9645x_vlan_unaware_pvid(bool is_bridged);
+void lan9645x_vlan_port_apply(struct lan9645x_port *p);
+int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
+				bool untagged,
+				struct netlink_ext_ack *extack);
+int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid);
+void lan9645x_vlan_set_hostmode(struct lan9645x_port *p);
+void lan9645x_vlan_clear_hostmode(struct lan9645x_port *p);
+
 #endif /* __LAN9645X_MAIN_H__ */
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
index 0642b59419c2..0548904dc4bd 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -210,5 +210,8 @@ int lan9645x_port_setup(struct dsa_switch *ds, int port)
 		ANA_PORT_CFG_PORTID_VAL,
 		lan9645x, ANA_PORT_CFG(p->chip_port));
 
+	if (p->chip_port != lan9645x->npi)
+		lan9645x_vlan_set_hostmode(p);
+
 	return 0;
 }
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
new file mode 100644
index 000000000000..e2116132b4d4
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+#define VLANACCESS_CMD_IDLE		0
+#define VLANACCESS_CMD_READ		1
+#define VLANACCESS_CMD_WRITE		2
+#define VLANACCESS_CMD_INIT		3
+
+struct lan9645x_vlan_port_info {
+	int untagged;
+	int tagged;
+	u16 untagged_vid;
+};
+
+/* Calculate VLAN state of a port, across all VLANS. */
+static void lan9645x_vlan_port_get_info(struct lan9645x *lan9645x, int port,
+					struct lan9645x_vlan_port_info *info)
+{
+	u16 vid;
+
+	info->untagged = 0;
+	info->tagged = 0;
+	info->untagged_vid = 0;
+
+	for (vid = 1; vid <= VLAN_MAX; vid++) {
+		struct lan9645x_vlan *v = &lan9645x->vlans[vid];
+
+		if (!(v->portmask & BIT(port)))
+			continue;
+
+		if (v->untagged & BIT(port)) {
+			info->untagged++;
+			info->untagged_vid = vid;
+		} else {
+			info->tagged++;
+		}
+
+		/* VLAN composition is invalid, so break early. */
+		if (info->untagged > 1 && info->tagged)
+			break;
+	}
+}
+
+static int lan9645x_vlan_wait_for_completion(struct lan9645x *lan9645x)
+{
+	u32 val;
+
+	return lan9645x_rd_poll_timeout(lan9645x, ANA_VLANACCESS, val,
+					ANA_VLANACCESS_VLAN_TBL_CMD_GET(val) ==
+					VLANACCESS_CMD_IDLE);
+}
+
+static int lan9645x_vlan_hw_wr(struct lan9645x *lan9645x, u16 vid)
+{
+	struct lan9645x_vlan *v = &lan9645x->vlans[vid];
+	bool cpu_dis = !(v->portmask & BIT(lan9645x->num_phys_ports));
+	u32 val;
+	int err;
+
+	val = ANA_VLANTIDX_VLAN_PGID_CPU_DIS_SET(cpu_dis) |
+	      ANA_VLANTIDX_V_INDEX_SET(vid) |
+	      ANA_VLANTIDX_VLAN_SEC_FWD_ENA_SET(v->s_fwd_ena) |
+	      ANA_VLANTIDX_VLAN_FLOOD_DIS_SET(v->fld_dis) |
+	      ANA_VLANTIDX_VLAN_PRIV_VLAN_SET(v->prv_vlan) |
+	      ANA_VLANTIDX_VLAN_LEARN_DISABLED_SET(v->lrn_dis) |
+	      ANA_VLANTIDX_VLAN_MIRROR_SET(v->mir) |
+	      ANA_VLANTIDX_VLAN_SRC_CHK_SET(v->src_chk);
+
+	lan_wr(val, lan9645x, ANA_VLANTIDX);
+	lan_wr(ANA_VLAN_PORT_MASK_VLAN_PORT_MASK_SET(v->portmask),
+	       lan9645x, ANA_VLAN_PORT_MASK);
+	lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_WRITE),
+	       lan9645x, ANA_VLANACCESS);
+
+	/* The VLAN access engine completes in a fixed ~1us vs the polling
+	 * timeout of 100_000 us. A timeout here therefore likely means the
+	 * register bus itself is dead, not that the VLAN op failed. There is no
+	 * meaningful recovery at runtime, so this function logs via dev_err()
+	 * and runtime callers discard the return value. Only
+	 * lan9645x_vlan_init() treats this as fatal so that probe fails early
+	 * on a broken bus.
+	 */
+	err = lan9645x_vlan_wait_for_completion(lan9645x);
+	if (err)
+		dev_err(lan9645x->dev, "Vlan set mask failed\n");
+
+	return err;
+}
+
+u16 lan9645x_vlan_unaware_pvid(bool is_bridged)
+{
+	return is_bridged ? UNAWARE_PVID : HOST_PVID;
+}
+
+static u16 lan9645x_vlan_port_get_pvid(struct lan9645x_port *port)
+{
+	bool is_bridged = lan9645x_port_is_bridged(port);
+
+	if (is_bridged && port->vlan_aware)
+		return port->pvid;
+	else
+		return lan9645x_vlan_unaware_pvid(is_bridged);
+}
+
+/* Dynamically choose the egress tagging mode based on the port vlan state:
+ *
+ * Standalone:
+ * TAG_NO_PVID_NO_UNAWARE with PORT_VID=HOST_PVID. This avoids leaking the
+ * internal HOST_PVID tag on ingress mirrored frames while leaving normal
+ * egress frames untagged.
+ *
+ * Bridged, VLAN-aware:
+ *  - N untagged, 0 tagged: TAG_DISABLED
+ *  - 1 untagged, N tagged: TAG_NO_PVID_NO_UNAWARE
+ *  - 0 untagged, N tagged: TAG_ALL
+ *
+ * Bridged, VLAN-unaware:
+ *   TAG_DISABLED
+ */
+static void
+lan9645x_vlan_port_apply_egress(struct lan9645x_port *p,
+				struct lan9645x_vlan_port_info *info)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	enum lan9645x_vlan_port_tag tag_cfg;
+	u16 port_vid = UNAWARE_PVID;
+
+	if (!lan9645x_port_is_bridged(p)) {
+		tag_cfg = LAN9645X_TAG_NO_PVID_NO_UNAWARE;
+		port_vid = HOST_PVID;
+	} else if (p->vlan_aware) {
+		struct lan9645x_vlan_port_info _info;
+
+		if (!info) {
+			lan9645x_vlan_port_get_info(lan9645x, p->chip_port,
+						    &_info);
+			info = &_info;
+		}
+
+		if (info->untagged == 1 && info->tagged) {
+			tag_cfg = LAN9645X_TAG_NO_PVID_NO_UNAWARE;
+			port_vid = info->untagged_vid;
+		} else if (info->untagged) {
+			tag_cfg = LAN9645X_TAG_DISABLED;
+		} else {
+			tag_cfg = LAN9645X_TAG_ALL;
+		}
+	} else {
+		tag_cfg = LAN9645X_TAG_DISABLED;
+	}
+
+	/* TAG_TPID_CFG encoding:
+	 *
+	 * 0: Use 0x8100.
+	 * 1: Use 0x88A8.
+	 * 2: Use custom value from PORT_VLAN_CFG.PORT_TPID.
+	 * 3: Use PORT_VLAN_CFG.PORT_TPID, unless ingress tag was a C-tag
+	 *    (EtherType = 0x8100)
+	 *
+	 * Use 3 and PORT_VLAN_CFG.PORT_TPID=0x88a8 to ensure stags are not
+	 * rewritten to ctags on egress.
+	 */
+	lan_rmw(REW_TAG_CFG_TAG_TPID_CFG_SET(3) |
+		REW_TAG_CFG_TAG_CFG_SET(tag_cfg),
+		REW_TAG_CFG_TAG_TPID_CFG |
+		REW_TAG_CFG_TAG_CFG,
+		lan9645x, REW_TAG_CFG(p->chip_port));
+
+	lan_rmw(REW_PORT_VLAN_CFG_PORT_TPID_SET(ETH_P_8021AD) |
+		REW_PORT_VLAN_CFG_PORT_VID_SET(port_vid),
+		REW_PORT_VLAN_CFG_PORT_TPID |
+		REW_PORT_VLAN_CFG_PORT_VID,
+		lan9645x, REW_PORT_VLAN_CFG(p->chip_port));
+}
+
+static void lan9645x_vlan_port_apply_ingress(struct lan9645x_port *p)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	u16 pvid;
+	u32 val;
+
+	pvid = lan9645x_vlan_port_get_pvid(p);
+
+	/* Default vlan to classify for untagged frames (may be zero), and set
+	 * their tag type to C-tag.
+	 */
+	val = ANA_VLAN_CFG_VLAN_VID_SET(pvid) |
+	      ANA_VLAN_CFG_VLAN_TAG_TYPE_SET(0);
+	if (p->vlan_aware)
+		val |= ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
+		       ANA_VLAN_CFG_VLAN_POP_CNT_SET(1);
+
+	lan_rmw(val,
+		ANA_VLAN_CFG_VLAN_VID |
+		ANA_VLAN_CFG_VLAN_AWARE_ENA |
+		ANA_VLAN_CFG_VLAN_POP_CNT |
+		ANA_VLAN_CFG_VLAN_TAG_TYPE,
+		lan9645x, ANA_VLAN_CFG(p->chip_port));
+
+	val = 0;
+	if (p->vlan_aware && !pvid)
+		/* If port is vlan-aware and tagged, drop untagged and priority
+		 * tagged frames.
+		 */
+		val = ANA_DROP_CFG_DROP_UNTAGGED_ENA_SET(1) |
+		      ANA_DROP_CFG_DROP_PRIO_S_TAGGED_ENA_SET(1) |
+		      ANA_DROP_CFG_DROP_PRIO_C_TAGGED_ENA_SET(1);
+
+	lan_rmw(val,
+		ANA_DROP_CFG_DROP_UNTAGGED_ENA |
+		ANA_DROP_CFG_DROP_PRIO_S_TAGGED_ENA |
+		ANA_DROP_CFG_DROP_PRIO_C_TAGGED_ENA,
+		lan9645x, ANA_DROP_CFG(p->chip_port));
+}
+
+void lan9645x_vlan_port_apply(struct lan9645x_port *p)
+{
+	lan9645x_vlan_port_apply_ingress(p);
+	lan9645x_vlan_port_apply_egress(p, NULL);
+}
+
+static struct lan9645x_vlan *lan9645x_vlan_port_modify(struct lan9645x_port *p,
+						       u16 vid, bool pvid,
+						       bool untagged)
+{
+	struct lan9645x_vlan *v = &p->lan9645x->vlans[vid];
+
+	if (untagged)
+		v->untagged |= BIT(p->chip_port);
+	else
+		v->untagged &= ~BIT(p->chip_port);
+
+	if (pvid)
+		p->pvid = vid;
+	else if (p->pvid == vid)
+		p->pvid = 0;
+
+	return v;
+}
+
+static int lan9645x_vlan_cpu_add(struct lan9645x_port *p, u16 vid, bool pvid,
+				 bool untagged)
+{
+	struct lan9645x_vlan *v;
+
+	v = lan9645x_vlan_port_modify(p, vid, pvid, untagged);
+	v->portmask |= BIT(p->lan9645x->num_phys_ports) | BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(p->lan9645x, vid);
+	lan9645x_vlan_port_apply_ingress(p);
+
+	return 0;
+}
+
+int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
+				bool untagged, struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	struct lan9645x_vlan_port_info info;
+	struct lan9645x_vlan old_vlan;
+	struct lan9645x_vlan *v;
+	u16 old_pvid;
+
+	/* Kernel VLAN core adds vid 0, which collides with our UNAWARE_PVID.
+	 * We handle priority tagged frames by other means.
+	 */
+	if (!vid)
+		return 0;
+
+	if (vid > VLAN_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "VLAN 4095 reserved.");
+		return -EINVAL;
+	}
+
+	if (p->chip_port == lan9645x->npi)
+		return lan9645x_vlan_cpu_add(p, vid, pvid, untagged);
+
+	old_vlan = lan9645x->vlans[vid];
+	old_pvid = p->pvid;
+
+	v = lan9645x_vlan_port_modify(p, vid, pvid, untagged);
+	v->portmask |= BIT(p->chip_port);
+
+	lan9645x_vlan_port_get_info(lan9645x, p->chip_port, &info);
+
+	if (info.untagged > 1 && info.tagged) {
+		*v = old_vlan;
+		p->pvid = old_pvid;
+		NL_SET_ERR_MSG_MOD(extack, "Only support 1 untagged port VLAN");
+		return -EBUSY;
+	}
+
+	lan9645x_vlan_hw_wr(lan9645x, vid);
+	lan9645x_vlan_port_apply_ingress(p);
+	lan9645x_vlan_port_apply_egress(p, &info);
+
+	return 0;
+}
+
+static int lan9645x_vlan_cpu_del(struct lan9645x_port *p, u16 vid)
+{
+	struct lan9645x_vlan *v;
+
+	v = lan9645x_vlan_port_modify(p, vid, false, false);
+	v->portmask &= ~BIT(p->lan9645x->num_phys_ports) & ~BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(p->lan9645x, vid);
+	lan9645x_vlan_port_apply_ingress(p);
+
+	return 0;
+}
+
+int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	struct lan9645x_vlan *v;
+
+	if (!vid)
+		return 0;
+
+	if (vid > VLAN_MAX)
+		return -EINVAL;
+
+	if (p->chip_port == lan9645x->npi)
+		return lan9645x_vlan_cpu_del(p, vid);
+
+	v = lan9645x_vlan_port_modify(p, vid, false, false);
+	v->portmask &= ~BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(lan9645x, vid);
+	lan9645x_vlan_port_apply(p);
+
+	return 0;
+}
+
+void lan9645x_vlan_set_hostmode(struct lan9645x_port *p)
+{
+	p->vlan_aware = false;
+	p->lan9645x->vlans[HOST_PVID].portmask |= BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID);
+	lan9645x_vlan_port_apply(p);
+}
+
+void lan9645x_vlan_clear_hostmode(struct lan9645x_port *p)
+{
+	p->lan9645x->vlans[HOST_PVID].portmask &= ~BIT(p->chip_port);
+	lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID);
+	lan9645x_vlan_port_apply(p);
+}
+
+int lan9645x_vlan_init(struct lan9645x *lan9645x)
+{
+	u32 all_phys_ports, all_ports;
+	struct dsa_port *dp;
+	u16 vid;
+	int err;
+
+	all_phys_ports = GENMASK(lan9645x->num_phys_ports - 1, 0);
+	all_ports = all_phys_ports | BIT(lan9645x->num_phys_ports);
+
+	/* Clear VLAN table, by default all ports are members of all VLANS */
+	lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_INIT),
+	       lan9645x, ANA_VLANACCESS);
+
+	err = lan9645x_vlan_wait_for_completion(lan9645x);
+	if (err) {
+		dev_err(lan9645x->dev, "Vlan clear table failed\n");
+		return err;
+	}
+
+	for (vid = 1; vid < VLAN_N_VID; vid++) {
+		err = lan9645x_vlan_hw_wr(lan9645x, vid);
+		if (err)
+			return err;
+	}
+
+	/* Set all the ports + cpu to be part of HOST_PVID and UNAWARE_PVID */
+	lan9645x->vlans[HOST_PVID].portmask = all_ports;
+	err = lan9645x_vlan_hw_wr(lan9645x, HOST_PVID);
+	if (err)
+		return err;
+
+	lan9645x->vlans[UNAWARE_PVID].portmask = all_ports;
+	err = lan9645x_vlan_hw_wr(lan9645x, UNAWARE_PVID);
+	if (err)
+		return err;
+
+	/* Configure the CPU port module to be vlan aware */
+	lan_wr(ANA_VLAN_CFG_VLAN_VID_SET(UNAWARE_PVID) |
+	       ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
+	       ANA_VLAN_CFG_VLAN_POP_CNT_SET(1),
+	       lan9645x, ANA_VLAN_CFG(lan9645x->num_phys_ports));
+
+	/* Set vlan ingress filter mask to all ports */
+	lan_wr(all_ports, lan9645x, ANA_VLANMASK);
+
+	dsa_switch_for_each_user_port(dp, lan9645x->ds) {
+		lan_wr(0, lan9645x, REW_PORT_VLAN_CFG(dp->index));
+		lan_wr(0, lan9645x, REW_TAG_CFG(dp->index));
+	}
+
+	return 0;
+}

-- 
2.52.0


