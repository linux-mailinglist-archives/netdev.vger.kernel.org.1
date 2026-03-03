Return-Path: <netdev+bounces-263179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPlDGKnTpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:27:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176061EF65B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87312308C5A7
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319C33F5B8;
	Tue,  3 Mar 2026 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="trHiXEl8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7A31E858;
	Tue,  3 Mar 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540631; cv=none; b=j1Un/N/f//SAwr4g7WbFug8e/Mq/t//TdpG3acFk8xB7np3JySe1XLBNZf3XAlHBwVIQ3ur2DynayZBeOFmBF+7o3lFLrcXVNxMaByxsY3VoyLZQ+0V9VwoZJDNDqOeAjtHO313R3uA+f8b03VUyprGYscdi6/fWZCeTMg20bCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540631; c=relaxed/simple;
	bh=O/DHICdzdu2VKnZNC6QH2UQKRBYCKkbFUkQJ3jJLxu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d2qBG9Lung4EdsMa2sjQhm7bQkCWydM+gnhqGJz6CY1szSJYPDIJUbR0nbgmA0/G6h1a9JgeRXFUU5rCvyMuXZl75Ru8oBQDhcm9f/VLjzlopdfrTzamSKL+/ptgHR7sHCPG0JfC4TEFEsXCVLu/3Qo2xtlK8pVQ0iBaFIc52xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=trHiXEl8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772540629; x=1804076629;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=O/DHICdzdu2VKnZNC6QH2UQKRBYCKkbFUkQJ3jJLxu0=;
  b=trHiXEl8TnFiSb1xBGSTtLzJGgPSKdddn8tOw+CPRluNm31Iwb2+hACW
   dMJAojb7Wm03hvF6QN02kFsvg51Thy/lP2zj3T3MOw5Tq7ewphY6ol2j5
   MAelMm0nspvwSuMoZJCDFB4fmEQ8AOpmbvOhBAPgcIbUofElyfxv9y6QF
   FBP+v3vyLghWTKTHOaWTLgF69S9dHo66usjYkZI2pJ8GNPcou7KC86e0w
   WD5LsiVtyztcojxAVi0bwNs7HmN6sNQBCqg03dcIYy7Tz5vmmiZdzjoOa
   Tqye5J0RkFfeUa6CJ+LgW0i1VHkfRtUFxha3fl3TKzjK07IhVrZvoQI+S
   Q==;
X-CSE-ConnectionGUID: O5MLb/nJR+Ce7h6ad0rSrA==
X-CSE-MsgGUID: /wieGEIZR3SB63waoy6eSA==
X-IronPort-AV: E=Sophos;i="6.21,321,1763449200"; 
   d="scan'208";a="285516802"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 05:23:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 05:23:36 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Mar 2026 05:23:33 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 3 Mar 2026 13:22:31 +0100
Subject: [PATCH net-next 5/8] net: dsa: lan9645x: add bridge support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
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
X-Rspamd-Queue-Id: 176061EF65B
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-263179-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bridge.dev:url]
X-Rspamd-Action: no action

Add support for hardware offloading of the bridge. We support a single
bridge device.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 196 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  11 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |   2 +
 3 files changed, 209 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index 739013f049d0..b6efaf669a3f 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -171,6 +171,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
 		return err;
 	}
 
+	mutex_init(&lan9645x->fwd_domain_lock);
+
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
 	       ANA_AGGR_CFG_AC_DMAC_ENA,
@@ -288,6 +290,192 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
 	lan9645x_phylink_get_caps(ds->priv, port, config);
 }
 
+static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	u32 age_secs = max(1, msecs / 1000 / 2);
+	struct lan9645x *lan9645x = ds->priv;
+
+	/* Entry is must suffer two aging scans before it is removed, so an
+	 * entry is aged after 2*AGE_PERIOD, and the unit is in seconds.
+	 * An age period of 0 disables automatic aging.
+	 */
+	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(age_secs),
+		ANA_AUTOAGE_AGE_PERIOD,
+		lan9645x, ANA_AUTOAGE);
+	return 0;
+}
+
+static int lan9645x_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					  struct switchdev_brport_flags flags,
+					  struct netlink_ext_ack *extack)
+{
+	if (flags.mask &
+	    ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void lan9645x_port_pgid_set(struct lan9645x *lan9645x, u16 pgid,
+				   int chip_port, bool enabled)
+{
+	u32 reg_msk, port_msk;
+
+	WARN_ON(chip_port > CPU_PORT);
+
+	port_msk = ANA_PGID_PGID_SET(enabled ? BIT(chip_port) : 0);
+	reg_msk = ANA_PGID_PGID_SET(BIT(chip_port));
+
+	lan_rmw(port_msk, reg_msk, lan9645x, ANA_PGID(pgid));
+}
+
+static void lan9645x_port_set_learning(struct lan9645x *lan9645x, int port,
+				       bool enabled)
+{
+	struct lan9645x_port *p;
+
+	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(enabled), ANA_PORT_CFG_LEARN_ENA,
+		lan9645x, ANA_PORT_CFG(port));
+
+	p = lan9645x_to_port(lan9645x, port);
+	p->learn_ena = enabled;
+}
+
+static int lan9645x_port_bridge_flags(struct dsa_switch *ds, int port,
+				      struct switchdev_brport_flags f,
+				      struct netlink_ext_ack *extack)
+{
+	struct lan9645x *l = ds->priv;
+
+	if (WARN_ON(port == l->npi))
+		return -EINVAL;
+
+	if (f.mask & BR_LEARNING)
+		lan9645x_port_set_learning(l, port, !!(f.val & BR_LEARNING));
+
+	if (f.mask & BR_FLOOD)
+		lan9645x_port_pgid_set(l, PGID_UC, port, !!(f.val & BR_FLOOD));
+
+	if (f.mask & BR_MCAST_FLOOD) {
+		bool ena = !!(f.val & BR_MCAST_FLOOD);
+
+		lan9645x_port_pgid_set(l, PGID_MC, port, ena);
+		lan9645x_port_pgid_set(l, PGID_MCIPV4, port, ena);
+		lan9645x_port_pgid_set(l, PGID_MCIPV6, port, ena);
+	}
+
+	if (f.mask & BR_BCAST_FLOOD)
+		lan9645x_port_pgid_set(l, PGID_BC, port,
+				       !!(f.val & BR_BCAST_FLOOD));
+
+	return 0;
+}
+
+static void lan9645x_update_fwd_mask(struct lan9645x *lan9645x)
+{
+	struct lan9645x_port *p;
+	int port;
+
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	/* Updates the source port PGIDs, making sure frames from p
+	 * are only forwarded to ports q != p, where q is relevant to forward
+	 */
+	lan9645x_for_each_chipport(lan9645x, port) {
+		u32 mask = 0;
+
+		p = lan9645x_to_port(lan9645x, port);
+
+		if (lan9645x_port_is_bridged(p)) {
+			mask = lan9645x->bridge_mask &
+			       lan9645x->bridge_fwd_mask & ~BIT(p->chip_port);
+		}
+
+		lan_wr(mask, lan9645x, ANA_PGID(PGID_SRC + port));
+	}
+}
+
+static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge,
+				     bool *tx_fwd_offload,
+				     struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	if (lan9645x->bridge && lan9645x->bridge != bridge.dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Only one bridge supported");
+		return -EBUSY;
+	}
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+	/* First bridged port sets bridge dev */
+	if (!lan9645x->bridge_mask)
+		lan9645x->bridge = bridge.dev;
+
+	lan9645x->bridge_mask |= BIT(p->chip_port);
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+
+	/* Later: stp_state_set updates forwarding */
+
+	return 0;
+}
+
+static void lan9645x_port_stp_state_set(struct lan9645x *lan9645x, int port,
+					u8 state)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+	bool learn_ena;
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+
+	p->stp_state = state;
+
+	if (state == BR_STATE_FORWARDING)
+		lan9645x->bridge_fwd_mask |= BIT(p->chip_port);
+	else
+		lan9645x->bridge_fwd_mask &= ~BIT(p->chip_port);
+
+	learn_ena = (state == BR_STATE_LEARNING ||
+		     state == BR_STATE_FORWARDING) && p->learn_ena;
+
+	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(learn_ena),
+		ANA_PORT_CFG_LEARN_ENA, lan9645x,
+		ANA_PORT_CFG(p->chip_port));
+
+	lan9645x_update_fwd_mask(lan9645x);
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+}
+
+static void lan9645x_port_bridge_stp_state_set(struct dsa_switch *ds, int port,
+					       u8 state)
+{
+	lan9645x_port_stp_state_set(ds->priv, port, state);
+}
+
+static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
+				       struct dsa_bridge bridge)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+
+	lan9645x->bridge_mask &= ~BIT(p->chip_port);
+
+	/* Last port leaving clears bridge dev */
+	if (!lan9645x->bridge_mask)
+		lan9645x->bridge = NULL;
+
+	lan9645x_update_fwd_mask(lan9645x);
+
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 	.connect_tag_protocol		= lan9645x_connect_tag_protocol,
@@ -301,6 +489,14 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	/* MTU  */
 	.port_change_mtu		= lan9645x_change_mtu,
 	.port_max_mtu			= lan9645x_get_max_mtu,
+
+	/* Bridge integration */
+	.set_ageing_time		= lan9645x_set_ageing_time,
+	.port_pre_bridge_flags		= lan9645x_port_pre_bridge_flags,
+	.port_bridge_flags		= lan9645x_port_bridge_flags,
+	.port_bridge_join		= lan9645x_port_bridge_join,
+	.port_bridge_leave		= lan9645x_port_bridge_leave,
+	.port_stp_state_set		= lan9645x_port_bridge_stp_state_set,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index a51b637f28bf..bf110bdbc90c 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -175,6 +175,12 @@ struct lan9645x {
 	/* debugfs */
 	struct dentry *debugfs_root;
 
+	/* Forwarding Database */
+	struct net_device *bridge; /* Only support single bridge */
+	u16 bridge_mask; /* Mask for bridged ports */
+	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
+	struct mutex fwd_domain_lock; /* lock forwarding configuration */
+
 	int num_port_dis;
 	bool dd_dis;
 	bool tsn_dis;
@@ -273,6 +279,11 @@ lan9645x_chipport_to_ndev(struct lan9645x *lan9645x, int port)
 	return lan9645x_port_to_ndev(lan9645x_to_port(lan9645x, port));
 }
 
+static inline bool lan9645x_port_is_bridged(struct lan9645x_port *p)
+{
+	return p && (p->lan9645x->bridge_mask & BIT(p->chip_port));
+}
+
 static inline bool lan9645x_port_is_used(struct lan9645x *lan9645x, int port)
 {
 	struct dsa_port *dp;
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
index 038868ae0a32..b60c64458957 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -15,6 +15,8 @@ int lan9645x_port_init(struct lan9645x *lan9645x, int port)
 		ANA_PORT_CFG_LEARN_ENA,
 		lan9645x, ANA_PORT_CFG(p->chip_port));
 
+	p->learn_ena = false;
+
 	lan9645x_port_set_maxlen(lan9645x, port, ETH_DATA_LEN);
 
 	lan9645x_phylink_port_down(lan9645x, port);

-- 
2.52.0


