Return-Path: <netdev+bounces-305702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sJWoMToYTmpWDAIAu9opvQ
	(envelope-from <netdev+bounces-305702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:28:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC5723B78
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:28:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=duNol608;
	dmarc=pass (policy=reject) header.from=microchip.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305702-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305702-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF1E83066B5B
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7DC40DFA7;
	Wed,  8 Jul 2026 09:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9040D57E;
	Wed,  8 Jul 2026 09:18:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502341; cv=none; b=EM7SS2f0uNuT+G9I3Evc1+O2jteQfpAQ648ncmvJuOcBX6yfTV9aDPwuTMJuJj6fVLCy2fEKU8CdehnLGkZJTWY93P8JMjMbkkvzUV6/sZ/FvJzYieGqkw7q/h9+RMq/guxdqin052ZMCBs52lDyqTJ5+XFz30LEN5j+TFONr0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502341; c=relaxed/simple;
	bh=lr4UTcBgkHdKh2X40piIGkluWPWaV5lSaTxpgSr6V4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cTBF7cRQMrlZbfg9kByoQkZhN8Anegou0BiT6HFjG7ihlNa+DQmGDc3MtvCD/9oYnfdWL33ECmnXDu1GK99TJa3HIdI8kRhzc5R4scN6KwLrVyc8VuK4WOPoHPy/tNR81jgPDJUaD0FUEkePiwXUmycW4ihdpG+tDUH6Pien+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=duNol608; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1783502341; x=1815038341;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=lr4UTcBgkHdKh2X40piIGkluWPWaV5lSaTxpgSr6V4s=;
  b=duNol608jZOWcumZe26RQV+GffvcIrTnAYlWQNDS6k6u8UStnUuiFN3b
   7H67JrB47KBXOsTJQI2Rde9yetxF2BHglyYUiO66uhsv2Qf/zgdbhlxTl
   NZzcxoxa2RgSPZj1Z1f2uRUgxXc2hfe8UOvseSrImWKw9MdSxOLbWElbc
   /+Kv/i7NqEpSBJAN5z/999n5cf5A5hrDrE39zLPWmxKrKLZElofXZCkmK
   7I4uz2/G0LZxuQ1YVnAGIr6QKId4fBbWcPvJiZ9aZZ4q18AZ7PIY2Q2mO
   ParVbfWoCF1zh6gFqhoKxM7QV7qaP3rkimZZroNhZFg4mkatPeKGvvISV
   Q==;
X-CSE-ConnectionGUID: hqYjzHucQC6K/ainDeKLzw==
X-CSE-MsgGUID: z/DyPWqxTS6jLdj4qOS0dQ==
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="69588830"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 02:19:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 8 Jul 2026 02:18:58 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 8 Jul 2026 02:18:55 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Wed, 8 Jul 2026 11:18:20 +0200
Subject: [PATCH net-next v9 5/9] net: dsa: lan9645x: add bridge support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260708-dsa_lan9645x_switch_driver_base-v9-5-0d1512a326d7@microchip.com>
References: <20260708-dsa_lan9645x_switch_driver_base-v9-0-0d1512a326d7@microchip.com>
In-Reply-To: <20260708-dsa_lan9645x_switch_driver_base-v9-0-0d1512a326d7@microchip.com>
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
	TAGGED_FROM(0.00)[bounces-305702-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bridge.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:from_mime,microchip.com:email,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64BC5723B78

Add support for hardware offloading of the bridge. We support a single
bridge device.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v9:
- Drop the port_mux_lock teardown from the setup error path, as the
  mutex has been removed.

Changes in v8:
- Use lan9645x->num_phys_ports instead of CPU_PORT for the CPU port
  module in the port pgid and host flood helpers.

Changes in v5:
- use ds->ageing_time_max
- use packed p->host_flood_req for atomic r/w
- fix typo in set_ageing_time comment
- include lan9645x->bridge deref under lock in brige_join

Changes in v4:
- set_host_flood changed to per port work to coalesce values and skip
  atomic allocations

Changes in v3:
- allow disabling aging with explicit zero parameters.
- fix non-forwarding stp states
- fix restore host_flood requests on bridge leave
- destroy fwd_domain_lock mutex on setup err path

Changes in v2:
- variable name consistency
- port_set_learning use stp_state before writing to hw
- add set_host_flood for selftests, which need promic/all_multi on
standalone interfaces
---
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 309 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  27 ++
 2 files changed, 336 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index b253813518c2..c145d28ffbb9 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -67,7 +67,9 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 {
 	struct lan9645x *lan9645x = ds->priv;
 
+	destroy_workqueue(lan9645x->owq);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
+	mutex_destroy(&lan9645x->fwd_domain_lock);
 }
 
 static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
@@ -146,6 +148,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
 		return err;
 	}
 
+	mutex_init(&lan9645x->fwd_domain_lock);
+
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
 	       ANA_AGGR_CFG_AC_DMAC_ENA,
@@ -265,15 +269,34 @@ static int lan9645x_setup(struct dsa_switch *ds)
 
 	lan9645x_port_set_tail_drop_wm(lan9645x);
 
+	lan9645x->owq = alloc_ordered_workqueue("%s-owq", 0,
+						dev_name(lan9645x->dev));
+	if (!lan9645x->owq) {
+		err = -ENOMEM;
+		goto err_mutex;
+	}
+
 	ds->mtu_enforcement_ingress = true;
 	ds->assisted_learning_on_cpu_port = true;
 	ds->fdb_isolation = true;
 
+	/* ANA_AUTOAGE_AGE_PERIOD is a seconds-based field and entries are
+	 * aged after 2 * AGE_PERIOD, giving (2 * FIELD_MAX) seconds of
+	 * maximum aging.
+	 */
+	ds->ageing_time_max = 2U * MSEC_PER_SEC *
+			      FIELD_MAX(ANA_AUTOAGE_AGE_PERIOD);
+
 	dev_info(lan9645x->dev,
 		 "SKU features: max_ports=%d\n",
 		 lan9645x->num_phys_ports - lan9645x->num_port_dis);
 
 	return 0;
+
+err_mutex:
+	mutex_destroy(&lan9645x->fwd_domain_lock);
+	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
+	return err;
 }
 
 static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
@@ -282,6 +305,282 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
 	lan9645x_phylink_get_caps(ds->priv, port, config);
 }
 
+static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	u32 age_secs = max(1, msecs / MSEC_PER_SEC / 2);
+	struct lan9645x *lan9645x = ds->priv;
+
+	/* Entry must suffer two aging scans before it is removed, so it is
+	 * aged after 2*AGE_PERIOD, and the unit is in seconds.
+	 * An age period of 0 disables automatic aging.
+	 */
+	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs ? age_secs : 0),
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
+	WARN_ON(chip_port > lan9645x->num_phys_ports);
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
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+
+	p->learn_ena = enabled;
+
+	enabled = enabled && (p->stp_state == BR_STATE_LEARNING ||
+			      p->stp_state == BR_STATE_FORWARDING);
+
+	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(enabled), ANA_PORT_CFG_LEARN_ENA,
+		lan9645x, ANA_PORT_CFG(port));
+}
+
+static int lan9645x_port_bridge_flags(struct dsa_switch *ds, int port,
+				      struct switchdev_brport_flags f,
+				      struct netlink_ext_ack *extack)
+{
+	struct lan9645x *lan9645x = ds->priv;
+
+	if (WARN_ON(port == lan9645x->npi))
+		return -EINVAL;
+
+	if (f.mask & BR_LEARNING)
+		lan9645x_port_set_learning(lan9645x, port,
+					   !!(f.val & BR_LEARNING));
+
+	if (f.mask & BR_FLOOD)
+		lan9645x_port_pgid_set(lan9645x, PGID_UC, port,
+				       !!(f.val & BR_FLOOD));
+
+	if (f.mask & BR_MCAST_FLOOD) {
+		bool ena = !!(f.val & BR_MCAST_FLOOD);
+
+		lan9645x_port_pgid_set(lan9645x, PGID_MC, port, ena);
+		lan9645x_port_pgid_set(lan9645x, PGID_MCIPV4, port, ena);
+		lan9645x_port_pgid_set(lan9645x, PGID_MCIPV6, port, ena);
+	}
+
+	if (f.mask & BR_BCAST_FLOOD)
+		lan9645x_port_pgid_set(lan9645x, PGID_BC, port,
+				       !!(f.val & BR_BCAST_FLOOD));
+
+	return 0;
+}
+
+static void lan9645x_update_fwd_mask(struct lan9645x *lan9645x)
+{
+	struct lan9645x_port *p;
+	struct dsa_port *dp;
+
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	/* Updates the source port PGIDs, making sure frames from p
+	 * are only forwarded to ports q != p, where q is relevant to forward
+	 */
+	dsa_switch_for_each_available_port(dp, lan9645x->ds) {
+		u32 mask = 0;
+
+		p = lan9645x_to_port(lan9645x, dp->index);
+
+		if (lan9645x_port_is_bridged(p) &&
+		    (lan9645x->bridge_fwd_mask & BIT(dp->index))) {
+			mask = lan9645x->bridge_mask &
+			       lan9645x->bridge_fwd_mask & ~BIT(dp->index);
+		}
+
+		lan_wr(mask, lan9645x, ANA_PGID(PGID_SRC + dp->index));
+	}
+}
+
+static void __lan9645x_port_mark_host_flood(struct lan9645x *lan9645x, int port,
+					    bool uc, bool mc)
+{
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	if (uc)
+		lan9645x->host_flood_uc_mask |= BIT(port);
+	else
+		lan9645x->host_flood_uc_mask &= ~BIT(port);
+
+	if (mc)
+		lan9645x->host_flood_mc_mask |= BIT(port);
+	else
+		lan9645x->host_flood_mc_mask &= ~BIT(port);
+}
+
+static void __lan9645x_port_set_host_flood(struct lan9645x *lan9645x)
+{
+	bool mc_ena, uc_ena;
+	u16 unbridged;
+
+	lockdep_assert_held(&lan9645x->fwd_domain_lock);
+
+	/* We want promiscuous and all_multi to affect standalone ports, for
+	 * debug and test purposes.
+	 *
+	 * However, the linux bridge is incredibly eager to put bridged ports in
+	 * promiscuous mode.
+	 *
+	 * This is unfortunate since lan9645x flood masks are global and not per
+	 * ingress port. When some port triggers unknown uc/mc to the CPU, the
+	 * traffic from any port is forwarded to the CPU.
+	 *
+	 * If the host CPU is weak, this can cause tremendous stress. Therefore,
+	 * we compromise by ignoring this host flood request for bridged ports.
+	 */
+	unbridged = ~lan9645x->bridge_mask & GENMASK(NUM_PHYS_PORTS - 1, 0);
+
+	uc_ena = !!(lan9645x->host_flood_uc_mask & unbridged);
+	lan9645x_port_pgid_set(lan9645x, PGID_UC, lan9645x->num_phys_ports,
+			       uc_ena);
+
+	mc_ena = !!(lan9645x->host_flood_mc_mask & unbridged);
+	lan9645x_port_pgid_set(lan9645x, PGID_MC, lan9645x->num_phys_ports,
+			       mc_ena);
+	lan9645x_port_pgid_set(lan9645x, PGID_MCIPV4, lan9645x->num_phys_ports,
+			       mc_ena);
+	lan9645x_port_pgid_set(lan9645x, PGID_MCIPV6, lan9645x->num_phys_ports,
+			       mc_ena);
+}
+
+static void lan9645x_host_flood_work_fn(struct work_struct *work)
+{
+	struct lan9645x_port *p = container_of(work, struct lan9645x_port,
+					       host_flood_work);
+	struct lan9645x *lan9645x = p->lan9645x;
+	u8 req;
+
+	req = READ_ONCE(p->host_flood_req);
+
+	mutex_lock(&lan9645x->fwd_domain_lock);
+	__lan9645x_port_mark_host_flood(lan9645x, p->chip_port,
+					req & LAN9645X_HOST_FLOOD_UC,
+					req & LAN9645X_HOST_FLOOD_MC);
+	__lan9645x_port_set_host_flood(lan9645x);
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+}
+
+/* Called in atomic context. */
+static void lan9645x_port_set_host_flood(struct dsa_switch *ds, int port,
+					 bool uc, bool mc)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	WRITE_ONCE(p->host_flood_req,
+		   (uc ? LAN9645X_HOST_FLOOD_UC : 0) |
+		   (mc ? LAN9645X_HOST_FLOOD_MC : 0));
+	queue_work(lan9645x->owq, &p->host_flood_work);
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
+	mutex_lock(&lan9645x->fwd_domain_lock);
+	if (lan9645x->bridge && lan9645x->bridge != bridge.dev) {
+		mutex_unlock(&lan9645x->fwd_domain_lock);
+		NL_SET_ERR_MSG_MOD(extack, "Only one bridge supported");
+		return -EBUSY;
+	}
+
+	/* First bridged port sets bridge dev */
+	if (!lan9645x->bridge_mask)
+		lan9645x->bridge = bridge.dev;
+
+	lan9645x->bridge_mask |= BIT(p->chip_port);
+	__lan9645x_port_set_host_flood(lan9645x);
+
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+
+	/* Later: stp_state_set updates forwarding */
+
+	return 0;
+}
+
+static void lan9645x_port_bridge_stp_state_set(struct dsa_switch *ds, int port,
+					       u8 state)
+{
+	struct lan9645x *lan9645x;
+	struct lan9645x_port *p;
+	bool learn_ena;
+
+	lan9645x = ds->priv;
+	p = lan9645x_to_port(lan9645x, port);
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
+	__lan9645x_port_set_host_flood(lan9645x);
+	lan9645x_update_fwd_mask(lan9645x);
+
+	mutex_unlock(&lan9645x->fwd_domain_lock);
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -295,6 +594,15 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
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
+	.port_set_host_flood		= lan9645x_port_set_host_flood,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
@@ -376,6 +684,7 @@ static int lan9645x_probe(struct platform_device *pdev)
 
 		p->lan9645x = lan9645x;
 		p->chip_port = port;
+		INIT_WORK(&p->host_flood_work, lan9645x_host_flood_work_fn);
 		lan9645x->ports[port] = p;
 	}
 
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index b9168052fcbc..a0cd1707e114 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -117,6 +117,9 @@
 				 (_cond), SLOW_RD_SLEEP_US,		\
 				 SLOW_RD_SLEEPTIMEOUT_US)
 
+#define LAN9645X_HOST_FLOOD_UC		BIT(0)
+#define LAN9645X_HOST_FLOOD_MC		BIT(1)
+
 /* NPI port prefix config encoding
  *
  * 0: No CPU extraction header (normal frames)
@@ -158,6 +161,11 @@ struct lan9645x {
 	struct dsa_switch *ds;
 	struct regmap *rmap[NUM_TARGETS];
 
+	u16 host_flood_uc_mask;
+	u16 host_flood_mc_mask;
+
+	struct workqueue_struct *owq;
+
 	int shared_queue_sz;
 
 	/* NPI chip_port */
@@ -166,6 +174,12 @@ struct lan9645x {
 	u8 num_phys_ports;
 	struct lan9645x_port **ports;
 
+	/* Forwarding Database */
+	struct net_device *bridge; /* Only support single bridge */
+	u16 bridge_mask; /* Mask for bridged ports */
+	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
+	struct mutex fwd_domain_lock; /* lock forwarding configuration */
+
 	int num_port_dis;
 };
 
@@ -173,9 +187,17 @@ struct lan9645x_port {
 	struct lan9645x *lan9645x;
 
 	u8 chip_port;
+	u8 stp_state;
+	bool learn_ena;
 
 	bool rx_internal_delay;
 	bool tx_internal_delay;
+
+	struct work_struct host_flood_work;
+	/* Packed host flood request deposited by port_set_host_flood (atomic
+	 * context) and consumed by host_flood_work_fn.
+	 */
+	u8 host_flood_req;
 };
 
 extern const struct phylink_mac_ops lan9645x_phylink_mac_ops;
@@ -222,6 +244,11 @@ static inline struct lan9645x_port *lan9645x_to_port(struct lan9645x *lan9645x,
 	return lan9645x->ports[port];
 }
 
+static inline bool lan9645x_port_is_bridged(struct lan9645x_port *p)
+{
+	return p && (p->lan9645x->bridge_mask & BIT(p->chip_port));
+}
+
 static inline struct regmap *lan_tgt2rmap(struct lan9645x *lan9645x,
 					  enum lan9645x_target t, int tinst)
 {

-- 
2.52.0


