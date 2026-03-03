Return-Path: <netdev+bounces-263180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDBlGf/SpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:24:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE61EF576
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09F3A300A257
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27296340D93;
	Tue,  3 Mar 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="01/GNy9W"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AD33C53A;
	Tue,  3 Mar 2026 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540632; cv=none; b=PBi4ebhbqReONA1w3KMOWxgDd+DbnQ9n1DpilNYGMrcKIQpd44nl0S5CKkbnNCBY5EOG6yuz5+Fq7NEAoq03BzflXrPSQ9MwZuw/3CvEhf073gL7Z+DpdnzQLBolPC5HaXShsd6/DbFCQWoZ3J2chHDivdfsJtsxsaBIqV+lR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540632; c=relaxed/simple;
	bh=6DxB+Zs04KqKRF1qLtPUMlSS/penQk7AgDZ3bI1KfT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SQtTSBrx6ikL2auWppa2UHJSo2t0ImAXhFvooZ8/b40AiYrEvuN9NevLaG621hknxAi2mDqrgdQkY5ibAyallYoFm077+SqcLp9ni/b8Ys+NS4sFP6nqq9XwKYuvUJeO/QGnyG5ClUu3JRwNCONTlcF0AG44oFLpz6axObgrGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=01/GNy9W; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772540629; x=1804076629;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6DxB+Zs04KqKRF1qLtPUMlSS/penQk7AgDZ3bI1KfT8=;
  b=01/GNy9WUdqEo9A3ihHhg8Eb694laTAaI3mwbsNcPNQIhKE+Pwu+5iEF
   yqXOqWa6jfmXG6Cn0G74tGD+AE7cGm0twX+UQGfA310ALtDNvlw+VCVnU
   USh/1s4cq0QkjNnqd54HdNNIoDcA/V/dGlXyPuT3pTixCV2LoPuMlSen+
   qKgeGmQQz3YeOGlDOWdyxg+6DxBYvGE9SJUaU3bD8sU7tWclqrfgdBH6R
   twgmR30cl1NiNKF0bTds05OPQe5KP3rwKlpZqijF/2kcYQz2cPQ8ivMoi
   LlITwSdPMdtbNhUgFn0+xKCeIV5aicPcJjyOuHBTlYUlM/vfo4j6nja4F
   Q==;
X-CSE-ConnectionGUID: O5MLb/nJR+Ce7h6ad0rSrA==
X-CSE-MsgGUID: WBSZFoAwThGcf3wVxUTS2Q==
X-IronPort-AV: E=Sophos;i="6.21,321,1763449200"; 
   d="scan'208";a="285516804"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 05:23:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 05:23:40 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Mar 2026 05:23:37 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 3 Mar 2026 13:22:32 +0100
Subject: [PATCH net-next 6/8] net: dsa: lan9645x: add vlan support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
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
X-Rspamd-Queue-Id: 67DE61EF576
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263180-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add support for vlanaware bridge. We reserve vid 4095 for standalone
mode, to implement fdb-isolation. An vlan-unaware bridge uses vid 0.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  63 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  20 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |   3 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c | 339 +++++++++++++++++++++
 5 files changed, 426 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
index eea1edc5c0e3..bb5eec14d225 100644
--- a/drivers/net/dsa/microchip/lan9645x/Makefile
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -5,3 +5,4 @@ mchp-lan9645x-objs := lan9645x_main.o \
 	lan9645x_npi.o \
 	lan9645x_port.o \
 	lan9645x_phylink.o \
+	lan9645x_vlan.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index b6efaf669a3f..1c8f20452487 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -172,6 +172,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
 	}
 
 	mutex_init(&lan9645x->fwd_domain_lock);
+	lan9645x_vlan_init(lan9645x);
 
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
@@ -471,11 +472,68 @@ static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
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
+	lan9645x_vlan_port_set_vlan_aware(p, enabled);
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
+	int err;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+
+	err = lan9645x_port_vlan_prepare(p, vlan->vid, pvid, untagged, extack);
+	if (err)
+		return err;
+
+	if (port == lan9645x->npi)
+		lan9645x_vlan_cpu_set_vlan(lan9645x, vlan->vid);
+
+	lan9645x_vlan_port_add_vlan(p, vlan->vid, pvid, untagged);
+
+	return 0;
+}
+
+static int lan9645x_port_vlan_del(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_vlan *vlan)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	if (port == lan9645x->npi)
+		lan9645x_vlan_cpu_clear_vlan(lan9645x, vlan->vid);
+
+	lan9645x_vlan_port_del_vlan(p, vlan->vid);
+
+	return 0;
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 	.connect_tag_protocol		= lan9645x_connect_tag_protocol,
@@ -497,6 +555,11 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.port_bridge_join		= lan9645x_port_bridge_join,
 	.port_bridge_leave		= lan9645x_port_bridge_leave,
 	.port_stp_state_set		= lan9645x_port_bridge_stp_state_set,
+
+	/* VLAN integration */
+	.port_vlan_filtering		= lan9645x_port_vlan_filtering,
+	.port_vlan_add			= lan9645x_port_vlan_add,
+	.port_vlan_del			= lan9645x_port_vlan_del,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index bf110bdbc90c..f1471344a9e9 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -181,6 +181,11 @@ struct lan9645x {
 	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
 	struct mutex fwd_domain_lock; /* lock forwarding configuration */
 
+	/* VLAN */
+	u16 vlan_mask[VLAN_N_VID]; /* Port mask per vlan */
+	u8 vlan_flags[VLAN_N_VID];
+	DECLARE_BITMAP(cpu_vlan_mask, VLAN_N_VID); /* CPU VLAN membership */
+
 	int num_port_dis;
 	bool dd_dis;
 	bool tsn_dis;
@@ -404,4 +409,19 @@ void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
 			       struct phylink_config *c);
 void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port);
 
+/* VLAN lan9645x_vlan.c */
+void lan9645x_vlan_init(struct lan9645x *lan9645x);
+void lan9645x_vlan_port_set_vlan_aware(struct lan9645x_port *p,
+				       bool vlan_aware);
+u16 lan9645x_vlan_unaware_pvid(bool is_bridged);
+void lan9645x_vlan_port_apply(struct lan9645x_port *p);
+void lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
+				 bool untagged);
+void lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid);
+void lan9645x_vlan_cpu_set_vlan(struct lan9645x *lan9645x, u16 vid);
+void lan9645x_vlan_cpu_clear_vlan(struct lan9645x *lan9645x, u16 vid);
+void lan9645x_vlan_set_hostmode(struct lan9645x_port *p);
+int lan9645x_port_vlan_prepare(struct lan9645x_port *p, u16 vid, bool pvid,
+			       bool untagged, struct netlink_ext_ack *extack);
+
 #endif /* __LAN9645X_MAIN_H__ */
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
index b60c64458957..d69018b015b5 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -44,6 +44,9 @@ int lan9645x_port_init(struct lan9645x *lan9645x, int port)
 		ANA_PORT_CFG_PORTID_VAL,
 		lan9645x, ANA_PORT_CFG(p->chip_port));
 
+	if (p->chip_port != lan9645x->npi)
+		lan9645x_vlan_set_hostmode(p);
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
new file mode 100644
index 000000000000..1fc2a0ffe3b1
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
@@ -0,0 +1,339 @@
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
+int lan9645x_port_vlan_prepare(struct lan9645x_port *p, u16 vid, bool pvid,
+			       bool untagged, struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+
+	if (p->chip_port == lan9645x->npi)
+		return 0;
+
+	if (untagged && p->untagged_vid && p->untagged_vid != vid) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only one egress-untagged VLAN allowed.");
+		return -EBUSY;
+	}
+
+	if (vid > VLAN_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "VLAN range 4094-4095 reserved.");
+		return -EBUSY;
+	}
+
+	return 0;
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
+static void lan9645x_vlan_set_mask(struct lan9645x *lan9645x, u16 vid)
+{
+	u16 mask = lan9645x->vlan_mask[vid];
+	u8 f = lan9645x->vlan_flags[vid];
+	bool cpu_dis;
+	u32 val;
+
+	cpu_dis = !(mask & BIT(CPU_PORT));
+
+	/* Set flags and the VID to configure */
+	val = ANA_VLANTIDX_VLAN_PGID_CPU_DIS_SET(cpu_dis) |
+	      ANA_VLANTIDX_V_INDEX_SET(vid) |
+	      ANA_VLANTIDX_VLAN_SEC_FWD_ENA_SET(!!(f & VLAN_S_FWD_ENA)) |
+	      ANA_VLANTIDX_VLAN_FLOOD_DIS_SET(!!(f & VLAN_FLD_DIS)) |
+	      ANA_VLANTIDX_VLAN_PRIV_VLAN_SET(!!(f & VLAN_PRV_VLAN)) |
+	      ANA_VLANTIDX_VLAN_LEARN_DISABLED_SET(!!(f & VLAN_LRN_DIS)) |
+	      ANA_VLANTIDX_VLAN_MIRROR_SET(!!(f & VLAN_MIR)) |
+	      ANA_VLANTIDX_VLAN_SRC_CHK_SET(!!(f & VLAN_SRC_CHK));
+
+	lan_wr(val, lan9645x, ANA_VLANTIDX);
+
+	/* Set the vlan port members mask, which enables ingress filtering */
+	lan_wr(mask, lan9645x, ANA_VLAN_PORT_MASK);
+
+	/* Issue a write command */
+	lan_wr(VLANACCESS_CMD_WRITE, lan9645x, ANA_VLANACCESS);
+
+	if (lan9645x_vlan_wait_for_completion(lan9645x))
+		dev_err(lan9645x->dev, "Vlan set mask failed\n");
+}
+
+static void lan9645x_vlan_port_add_vlan_mask(struct lan9645x_port *p, u16 vid)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+
+	lan9645x->vlan_mask[vid] |= BIT(p->chip_port);
+	lan9645x_vlan_set_mask(lan9645x, vid);
+}
+
+static void lan9645x_vlan_port_del_vlan_mask(struct lan9645x_port *p, u16 vid)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+
+	lan9645x->vlan_mask[vid] &= ~BIT(p->chip_port);
+	lan9645x_vlan_set_mask(lan9645x, vid);
+}
+
+static void lan9645x_vlan_cpu_add_vlan_mask(struct lan9645x *lan9645x, u16 vid)
+{
+	lan9645x->vlan_mask[vid] |= BIT(CPU_PORT);
+	lan9645x_vlan_set_mask(lan9645x, vid);
+}
+
+static void lan9645x_vlan_cpu_del_vlan_mask(struct lan9645x *lan9645x, u16 vid)
+{
+	lan9645x->vlan_mask[vid] &= ~BIT(CPU_PORT);
+	lan9645x_vlan_set_mask(lan9645x, vid);
+}
+
+static bool lan9645x_vlan_port_any_vlan_mask(struct lan9645x *lan9645x, u16 vid)
+{
+	return !!(lan9645x->vlan_mask[vid] & ~BIT(CPU_PORT));
+}
+
+void lan9645x_vlan_cpu_set_vlan(struct lan9645x *lan9645x, u16 vid)
+{
+	__set_bit(vid, lan9645x->cpu_vlan_mask);
+}
+
+void lan9645x_vlan_cpu_clear_vlan(struct lan9645x *lan9645x, u16 vid)
+{
+	__clear_bit(vid, lan9645x->cpu_vlan_mask);
+}
+
+static bool lan9645x_vlan_cpu_member_cpu_vlan_mask(struct lan9645x *lan9645x,
+						   u16 vid)
+{
+	return test_bit(vid, lan9645x->cpu_vlan_mask);
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
+static void lan9645x_vlan_port_set_vid(struct lan9645x_port *p, u16 vid,
+				       bool pvid, bool untagged)
+{
+	/* Egress vlan classification */
+	if (untagged)
+		p->untagged_vid = vid;
+
+	/* Default ingress vlan classification */
+	if (pvid)
+		p->pvid = vid;
+}
+
+static void lan9645x_vlan_port_remove_vid(struct lan9645x_port *p, u16 vid)
+{
+	if (p->pvid == vid)
+		p->pvid = 0;
+
+	if (p->untagged_vid == vid)
+		p->untagged_vid = 0;
+}
+
+void lan9645x_vlan_port_set_vlan_aware(struct lan9645x_port *p,
+				       bool vlan_aware)
+{
+	p->vlan_aware = vlan_aware;
+}
+
+void lan9645x_vlan_port_apply(struct lan9645x_port *p)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+	u32 val, tag_cfg;
+	u16 pvid;
+
+	pvid = lan9645x_vlan_port_get_pvid(p);
+
+	/* Ingress classification (ANA_PORT_VLAN_CFG) */
+	/* Default vlan to classify for untagged frames (may be zero) */
+	val = ANA_VLAN_CFG_VLAN_VID_SET(pvid);
+	if (p->vlan_aware)
+		val |= ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
+			ANA_VLAN_CFG_VLAN_POP_CNT_SET(1);
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
+			ANA_DROP_CFG_DROP_PRIO_S_TAGGED_ENA_SET(1) |
+			ANA_DROP_CFG_DROP_PRIO_C_TAGGED_ENA_SET(1);
+
+	lan_wr(val, lan9645x, ANA_DROP_CFG(p->chip_port));
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
+	val = REW_TAG_CFG_TAG_TPID_CFG_SET(3);
+	if (p->vlan_aware) {
+		if (p->untagged_vid)
+			tag_cfg = LAN9645X_TAG_NO_PVID_NO_UNAWARE;
+		else
+			tag_cfg = LAN9645X_TAG_ALL;
+
+		val |= REW_TAG_CFG_TAG_CFG_SET(tag_cfg);
+	}
+
+	lan_rmw(val,
+		REW_TAG_CFG_TAG_TPID_CFG |
+		REW_TAG_CFG_TAG_CFG,
+		lan9645x, REW_TAG_CFG(p->chip_port));
+
+	/* Set default VLAN and tag type to 8021Q */
+
+	lan_rmw(REW_PORT_VLAN_CFG_PORT_TPID_SET(ETH_P_8021AD) |
+		REW_PORT_VLAN_CFG_PORT_VID_SET(p->untagged_vid),
+		REW_PORT_VLAN_CFG_PORT_TPID |
+		REW_PORT_VLAN_CFG_PORT_VID,
+		lan9645x, REW_PORT_VLAN_CFG(p->chip_port));
+}
+
+void lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
+				 bool untagged)
+{
+	struct lan9645x *lan9645x = p->lan9645x;
+
+	if (lan9645x_vlan_cpu_member_cpu_vlan_mask(lan9645x, vid))
+		lan9645x_vlan_cpu_add_vlan_mask(lan9645x, vid);
+
+	lan9645x_vlan_port_set_vid(p, vid, pvid, untagged);
+	lan9645x_vlan_port_add_vlan_mask(p, vid);
+	lan9645x_vlan_port_apply(p);
+}
+
+void lan9645x_vlan_port_del_vlan(struct lan9645x_port *port, u16 vid)
+{
+	struct lan9645x *lan9645x = port->lan9645x;
+
+	lan9645x_vlan_port_remove_vid(port, vid);
+	lan9645x_vlan_port_del_vlan_mask(port, vid);
+	lan9645x_vlan_port_apply(port);
+
+	if (!lan9645x_vlan_port_any_vlan_mask(lan9645x, vid))
+		lan9645x_vlan_cpu_del_vlan_mask(lan9645x, vid);
+}
+
+static void lan9645x_vlan_port_rew_host(struct lan9645x_port *port)
+{
+	struct lan9645x *lan9645x = port->lan9645x;
+
+	lan_rmw(REW_TAG_CFG_TAG_CFG_SET(LAN9645X_TAG_NO_PVID_NO_UNAWARE) |
+		REW_TAG_CFG_TAG_TPID_CFG_SET(3),
+		REW_TAG_CFG_TAG_CFG |
+		REW_TAG_CFG_TAG_TPID_CFG,
+		lan9645x, REW_TAG_CFG(port->chip_port));
+
+	/* Standalone ports must have the reserved VID set in the rewriter,
+	 * because the TAG_CFG used above acts on this PORT_VID value, otherwise
+	 * untagged frames are tagged with HOST_PVID.
+	 *
+	 * Usually frames leaving the switch from standalone ports go to the
+	 * CPU, where tagging is disabled. But if we mirror a standalone port,
+	 * the problem becomes apparent.
+	 */
+	lan_rmw(REW_PORT_VLAN_CFG_PORT_TPID_SET(ETH_P_8021AD) |
+		REW_PORT_VLAN_CFG_PORT_VID_SET(HOST_PVID),
+		REW_PORT_VLAN_CFG_PORT_TPID |
+		REW_PORT_VLAN_CFG_PORT_VID,
+		lan9645x, REW_PORT_VLAN_CFG(port->chip_port));
+}
+
+void lan9645x_vlan_set_hostmode(struct lan9645x_port *p)
+{
+	lan9645x_vlan_port_set_vlan_aware(p, false);
+	lan9645x_vlan_port_set_vid(p, HOST_PVID, false, false);
+	lan9645x_vlan_port_apply(p);
+	lan9645x_vlan_port_rew_host(p);
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
+	for (vid = 1; vid < VLAN_N_VID; vid++) {
+		lan9645x->vlan_mask[vid] = 0;
+		lan9645x_vlan_set_mask(lan9645x, vid);
+	}
+
+	/* Set all the ports + cpu to be part of HOST_PVID and UNAWARE_PVID */
+	lan9645x->vlan_mask[HOST_PVID] = all_ports;
+	lan9645x_vlan_set_mask(lan9645x, HOST_PVID);
+
+	lan9645x->vlan_mask[UNAWARE_PVID] = all_ports;
+	lan9645x_vlan_set_mask(lan9645x, UNAWARE_PVID);
+
+	lan9645x_vlan_cpu_set_vlan(lan9645x, UNAWARE_PVID);
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


