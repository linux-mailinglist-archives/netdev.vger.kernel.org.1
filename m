Return-Path: <netdev+bounces-270990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLw/OHVtwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:54:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDAD306D13
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9403430AD4E8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01C3EB7F0;
	Tue, 24 Mar 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Sb3aWWQ6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C513E6DF1;
	Tue, 24 Mar 2026 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349463; cv=none; b=Kj7Tcwi3DJT2XAFW72VydlIE1HF46F3JXSa7AOmpdWQQujKYmLMKFVpk3Y/XDLqnvYXaPgL+GndBrglj2vdS4qZkgD7fgD6e/1b4T5ZEsdsDWSF+3O/i8fhUlaqQNZVBQ6pzz00/5V3jwTd3lTKOlwTS0TjiEoDyYZKsjNJyGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349463; c=relaxed/simple;
	bh=Tb3efkXS7fFgl4HWaqDWV5a2X7Ipfn4kCCYVUlLy06I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eL7wMeNHiDOmJ4PkLkt0siYGZuHDtg2I9261FSL2sFXiqfHwv41cq9fSMqD5TIV0tCN9B4nt4VYXHIMT+nhJ4g33/l6v1QlF2wWTu4PzPmsKcJhsAbyLb80CrbJ1Tb6UBjtvkNVMNRPIJ7Fr30Ln+Iopkvqf+Dw59sPWUr+K2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Sb3aWWQ6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774349459; x=1805885459;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Tb3efkXS7fFgl4HWaqDWV5a2X7Ipfn4kCCYVUlLy06I=;
  b=Sb3aWWQ6BxW2Ux0qtkVeTFdV/QknbZv15L+qpKbssueFEcArFr90sG8J
   6vcd+we4VdNYf45izHVs4kyyGiflKeIEH7WSIm82mTxaeIMuezKKbJ07E
   UUQMlAJpAYVU3WPNl6GRXZwP1qb+1zRuuCHthyIW4VLTLhGoIyQK+jQfX
   SQlLweWokBFv4CnQUHsAX7lWve65pL4/WoVNgwVrl7nUQdqrtr6L+JZzg
   0vdabUTgIhxfozs2/L+Iuxa91GXWldLhWRZhxxuLwYfuMkPJ8bRSrVi4S
   QVLCJWIuG72LocfDA1TqwndSY4PXDztEbw4+p1XRtl0eYeaKcsd7y1Y4Z
   Q==;
X-CSE-ConnectionGUID: vgUXfekRRgebdU5TbZAl3Q==
X-CSE-MsgGUID: 4YNDcw/MRv2HyzjItq8CNQ==
X-IronPort-AV: E=Sophos;i="6.23,138,1770620400"; 
   d="scan'208";a="54371282"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2026 03:50:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 24 Mar 2026 03:50:27 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 24 Mar 2026 03:50:23 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 24 Mar 2026 11:46:49 +0100
Subject: [PATCH net-next v2 6/9] net: dsa: lan9645x: add vlan support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260324-dsa_lan9645x_switch_driver_base-v2-6-f7504e3b0681@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270990-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Queue-Id: 5EDAD306D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for vlanaware bridge. We reserve vid 4095 for standalone
mode, to implement fdb-isolation. A vlan-unaware bridge uses vid 0.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v2:
- redesign based on selftests which rely on changing vlan_default_pvid.
  Our HW limitations were too forward. Following Vladimirs changes to
  ocelot VLAN implementation, we now dynamically change egress tag
  configuration, allowing more states.
- selftests are passing, except an expected failure w.r.t ctag/stag
  conformance, which is a hw limitation.
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  49 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  28 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |   3 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c | 353 +++++++++++++++++++++
 5 files changed, 434 insertions(+)

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
index 599e589c4ec3..046c95a72242 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -156,6 +156,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
 	}
 
 	mutex_init(&lan9645x->fwd_domain_lock);
+	lan9645x_vlan_init(lan9645x);
 
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
@@ -535,11 +536,54 @@ static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
 	if (!lan9645x->bridge_mask)
 		lan9645x->bridge = NULL;
 
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
+	lan9645x_vlan_port_del_vlan(p, vlan->vid);
+
+	return 0;
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -562,6 +606,11 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
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
index 42048e16bb47..b2b2a88083c3 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -7,6 +7,7 @@
 
 #include <linux/dsa/lan9645x.h>
 #include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/regmap.h>
 #include <net/dsa.h>
 
@@ -150,6 +151,17 @@ enum lan9645x_vlan_port_tag {
 	LAN9645X_TAG_ALL = 3,
 };
 
+struct lan9645x_vlan {
+	u32 portmask: 10, /* ports 0-8 + CPU_PORT */
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
@@ -174,6 +186,9 @@ struct lan9645x {
 	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
 	struct mutex fwd_domain_lock; /* lock forwarding configuration */
 
+	/* VLAN entries */
+	struct lan9645x_vlan vlans[VLAN_N_VID];
+
 	int num_port_dis;
 	bool dd_dis;
 	bool tsn_dis;
@@ -186,6 +201,9 @@ struct lan9645x_port {
 	u8 stp_state;
 	bool learn_ena;
 
+	bool vlan_aware;
+	u16 pvid;
+
 	bool rx_internal_delay;
 	bool tx_internal_delay;
 };
@@ -349,4 +367,14 @@ void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
 			       struct phylink_config *c);
 void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port);
 
+/* VLAN lan9645x_vlan.c */
+void lan9645x_vlan_init(struct lan9645x *lan9645x);
+u16 lan9645x_vlan_unaware_pvid(bool is_bridged);
+void lan9645x_vlan_port_apply(struct lan9645x_port *p);
+int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
+				bool untagged,
+				struct netlink_ext_ack *extack);
+void lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid);
+void lan9645x_vlan_set_hostmode(struct lan9645x_port *p);
+
 #endif /* __LAN9645X_MAIN_H__ */
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
index ba3cbb8d75b3..3fe8de0ce902 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -175,5 +175,8 @@ int lan9645x_port_setup(struct dsa_switch *ds, int port)
 		ANA_PORT_CFG_PORTID_VAL,
 		lan9645x, ANA_PORT_CFG(p->chip_port));
 
+	if (p->chip_port != lan9645x->npi)
+		lan9645x_vlan_set_hostmode(p);
+
 	return 0;
 }
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
new file mode 100644
index 000000000000..0459932a626c
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
@@ -0,0 +1,353 @@
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
+static void lan9645x_vlan_hw_wr(struct lan9645x *lan9645x, u16 vid)
+{
+	struct lan9645x_vlan *v = &lan9645x->vlans[vid];
+	bool cpu_dis = !(v->portmask & BIT(CPU_PORT));
+	u32 val;
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
+	lan_wr(v->portmask, lan9645x, ANA_VLAN_PORT_MASK);
+	lan_wr(VLANACCESS_CMD_WRITE, lan9645x, ANA_VLANACCESS);
+
+	if (lan9645x_vlan_wait_for_completion(lan9645x))
+		dev_err(lan9645x->dev, "Vlan set mask failed\n");
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
+	/* Default vlan to classify for untagged frames (may be zero) */
+	val = ANA_VLAN_CFG_VLAN_VID_SET(pvid);
+	if (p->vlan_aware)
+		val |= ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
+		       ANA_VLAN_CFG_VLAN_POP_CNT_SET(1);
+
+	lan_rmw(val,
+		ANA_VLAN_CFG_VLAN_VID |
+		ANA_VLAN_CFG_VLAN_AWARE_ENA |
+		ANA_VLAN_CFG_VLAN_POP_CNT,
+		lan9645x, ANA_VLAN_CFG(p->chip_port));
+
+	lan_rmw(DEV_MAC_TAGS_CFG_VLAN_AWR_ENA_SET(p->vlan_aware) |
+		DEV_MAC_TAGS_CFG_PB_ENA_SET(p->vlan_aware),
+		DEV_MAC_TAGS_CFG_VLAN_AWR_ENA |
+		DEV_MAC_TAGS_CFG_PB_ENA,
+		lan9645x, DEV_MAC_TAGS_CFG(p->chip_port));
+
+	/* Drop frames with multicast source address */
+	val = ANA_DROP_CFG_DROP_MC_SMAC_ENA_SET(1);
+	if (p->vlan_aware && !pvid)
+		/* If port is vlan-aware and tagged, drop untagged and priority
+		 * tagged frames.
+		 */
+		val |= ANA_DROP_CFG_DROP_UNTAGGED_ENA_SET(1) |
+		       ANA_DROP_CFG_DROP_PRIO_S_TAGGED_ENA_SET(1) |
+		       ANA_DROP_CFG_DROP_PRIO_C_TAGGED_ENA_SET(1);
+
+	lan_wr(val, lan9645x, ANA_DROP_CFG(p->chip_port));
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
+	v->portmask |= BIT(CPU_PORT) | BIT(p->chip_port);
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
+	if (p->chip_port == lan9645x->npi)
+		return lan9645x_vlan_cpu_add(p, vid, pvid, untagged);
+
+	if (vid > VLAN_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "VLAN range 4094-4095 reserved.");
+		return -EBUSY;
+	}
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
+void lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	struct lan9645x_vlan *v;
+
+	if (!vid)
+		return;
+
+	v = lan9645x_vlan_port_modify(p, vid, false, false);
+	v->portmask &= ~BIT(p->chip_port);
+
+	if (p->chip_port == lan9645x->npi)
+		v->portmask &= ~BIT(CPU_PORT);
+
+	lan9645x_vlan_hw_wr(lan9645x, vid);
+
+	if (p->chip_port == lan9645x->npi)
+		lan9645x_vlan_port_apply_ingress(p);
+	else
+		lan9645x_vlan_port_apply(p);
+}
+
+void lan9645x_vlan_set_hostmode(struct lan9645x_port *p)
+{
+	p->vlan_aware = false;
+	lan9645x_vlan_port_apply(p);
+}
+
+void lan9645x_vlan_init(struct lan9645x *lan9645x)
+{
+	u32 all_phys_ports, all_ports;
+	u16 port, vid;
+
+	all_phys_ports = GENMASK(lan9645x->num_phys_ports - 1, 0);
+	all_ports = all_phys_ports | BIT(CPU_PORT);
+
+	/* Clear VLAN table, by default all ports are members of all VLANS */
+	lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_INIT),
+	       lan9645x, ANA_VLANACCESS);
+
+	if (lan9645x_vlan_wait_for_completion(lan9645x))
+		dev_err(lan9645x->dev, "Vlan clear table failed\n");
+
+	for (vid = 1; vid < VLAN_N_VID; vid++)
+		lan9645x_vlan_hw_wr(lan9645x, vid);
+
+	/* Set all the ports + cpu to be part of HOST_PVID and UNAWARE_PVID */
+	lan9645x->vlans[HOST_PVID].portmask = all_ports;
+	lan9645x_vlan_hw_wr(lan9645x, HOST_PVID);
+
+	lan9645x->vlans[UNAWARE_PVID].portmask = all_ports;
+	lan9645x_vlan_hw_wr(lan9645x, UNAWARE_PVID);
+
+	/* Configure the CPU port to be vlan aware */
+	lan_wr(ANA_VLAN_CFG_VLAN_VID_SET(UNAWARE_PVID) |
+	       ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
+	       ANA_VLAN_CFG_VLAN_POP_CNT_SET(1),
+	       lan9645x, ANA_VLAN_CFG(CPU_PORT));
+
+	/* Set vlan ingress filter mask to all ports */
+	lan_wr(all_ports, lan9645x, ANA_VLANMASK);
+
+	for (port = 0; port < lan9645x->num_phys_ports; port++) {
+		lan_wr(0, lan9645x, REW_PORT_VLAN_CFG(port));
+		lan_wr(0, lan9645x, REW_TAG_CFG(port));
+	}
+}

-- 
2.52.0


