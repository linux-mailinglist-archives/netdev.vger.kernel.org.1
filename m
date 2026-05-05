Return-Path: <netdev+bounces-284440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC19Nc/++WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:29:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B2F4CF694
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53B5E30A1AF2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B09481AB8;
	Tue,  5 May 2026 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ImuXno6f"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F843481657;
	Tue,  5 May 2026 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991133; cv=none; b=BD+XgPXIUOWCangUvLp86IXhb1pBYyp9MxiH92EH19WlnxB3SFltnFOsLRzM+NfUEHdjwf71pIaKKmUBC1EethQIsZesqQqTNUEmZe+4cTg/g4c58f/hdLhHhtNPUL5I+wPxkmkEFO6RvO2dqdwwAdweJ5olso0p/8uuJMgVyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991133; c=relaxed/simple;
	bh=82EgNLtMSVNgU/mEIWWr0cRD7rV6++PUg0BL6rsh5yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbEvMn7INaLSUqMTVUSqvKb6qT9ZTM+YWd/+UY0Tw5J0SzSpoIPYIkGW3DWO9qWPcTn6QEGFf31M6ylQg8BLQG+Flv8WiRYMd/Yj6L+kC+WosPd8zbnTTCkKCl/LSPW/f6LfjZluIk0ThsFYRVikrJPq6LzquLsyECFv2F0iUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ImuXno6f; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 103344E42BD2;
	Tue,  5 May 2026 14:25:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D91FE6053C;
	Tue,  5 May 2026 14:25:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24AD711AD0239;
	Tue,  5 May 2026 16:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yTEaWCgxoLI5pOkrLFtRrv/JgsL21vYZpx1CNxOR5DY=;
	b=ImuXno6faN2NM1/0lEhsLe2NVkqe6qOpAJC9p4T/qBl2K/cockn0+ncGzarp1zhXO4YgnH
	0P1cRpjkMSwD3Zux/MW7/sKrncKCgdwp6WY3/4+gTTGe0+i8YdFlxYczC9jyhP0qwbWfJx
	9yPPmpVTYD50UpBFvymPFIVNcM+BJo989GRB3Su4E2FdhFi9011b2xG6WLfdjZIhNI88R+
	t2N6+aqIA+XFmdEKoycsrMMKsKtnr0AtnXHKtGkRmJ+8oPZNsj3YTRCoMx0YXzpVfOB4Pg
	/7w6UHx9o1aP21cKxj3Lfa1amcW3T37SxDIKMK2hNnFavysLf4ye3jrIJaPMHg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 05 May 2026 16:25:06 +0200
Subject: [PATCH net-next 6/9] net: dsa: microchip: ensure each ksz_dev_ops
 has its own dsa_switch_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clean-ksz-driver-v1-6-05d70fa42461@bootlin.com>
References: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
In-Reply-To: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 31B2F4CF694
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Currently we have a single dsa_switch_ops for 4 very distinct families
of switches, and many dsa_switch_ops methods are simply a dispatches
through ksz_dev_ops. That creates an avoidable level of indirection.

As a preparation for removing that indirection layer, create a separate
dsa_switch_ops structure wherever we have a ksz_dev_ops. These
structures are not yet used - ksz_switch_ops from ksz_common.c still is.
However, this reduces the noise from subsequent changes.

All new dsa_switch_ops are exact copies of ksz_switch_ops. But we need
to export function prototypes from ksz_common.c so that they are
callable from individual drivers.

Note that "individual drivers" are not actual separate kernel modules.
All of ksz8.c, ksz9477.c and lan937x_main.c are part of the same
ksz_switch.ko. Only the "register interface" drivers are different
modules (ksz9477_i2c.o for I2C, ksz_spi.o for SPI, ksz8863_smi.o for
MDIO). So we don't need to export any symbol.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 184 +++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h         |   3 +
 drivers/net/dsa/microchip/ksz9477.c      |  62 ++++++++++
 drivers/net/dsa/microchip/ksz9477.h      |   1 +
 drivers/net/dsa/microchip/ksz_common.c   | 193 +++++++++++++++++--------------
 drivers/net/dsa/microchip/ksz_common.h   |  96 +++++++++++++++
 drivers/net/dsa/microchip/lan937x.h      |   1 +
 drivers/net/dsa/microchip/lan937x_main.c |  62 ++++++++++
 8 files changed, 516 insertions(+), 86 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index f311901c693f8..f7801269b11a4 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -31,6 +31,7 @@
 #include <linux/phylink.h>
 
 #include "ksz_common.h"
+#include "ksz_dcb.h"
 #include "ksz8_reg.h"
 #include "ksz8.h"
 
@@ -2227,6 +2228,189 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.pme_pwrite8 = ksz8_pme_pwrite8,
 };
 
+const struct dsa_switch_ops ksz8463_switch_ops = {
+	.get_tag_protocol	= ksz_get_tag_protocol,
+	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.get_phy_flags		= ksz_get_phy_flags,
+	.setup			= ksz_setup,
+	.teardown		= ksz_teardown,
+	.phy_read		= ksz_phy_read16,
+	.phy_write		= ksz_phy_write16,
+	.phylink_get_caps	= ksz_phylink_get_caps,
+	.port_setup		= ksz_port_setup,
+	.set_ageing_time	= ksz_set_ageing_time,
+	.get_strings		= ksz_get_strings,
+	.get_ethtool_stats	= ksz_get_ethtool_stats,
+	.get_sset_count		= ksz_sset_count,
+	.port_bridge_join	= ksz_port_bridge_join,
+	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_hsr_join		= ksz_hsr_join,
+	.port_hsr_leave		= ksz_hsr_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
+	.port_stp_state_set	= ksz_port_stp_state_set,
+	.port_teardown		= ksz_port_teardown,
+	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
+	.port_bridge_flags	= ksz_port_bridge_flags,
+	.port_fast_age		= ksz_port_fast_age,
+	.port_vlan_filtering	= ksz_port_vlan_filtering,
+	.port_vlan_add		= ksz_port_vlan_add,
+	.port_vlan_del		= ksz_port_vlan_del,
+	.port_fdb_dump		= ksz_port_fdb_dump,
+	.port_fdb_add		= ksz_port_fdb_add,
+	.port_fdb_del		= ksz_port_fdb_del,
+	.port_mdb_add           = ksz_port_mdb_add,
+	.port_mdb_del           = ksz_port_mdb_del,
+	.port_mirror_add	= ksz_port_mirror_add,
+	.port_mirror_del	= ksz_port_mirror_del,
+	.get_stats64		= ksz_get_stats64,
+	.get_pause_stats	= ksz_get_pause_stats,
+	.port_change_mtu	= ksz_change_mtu,
+	.port_max_mtu		= ksz_max_mtu,
+	.get_wol		= ksz_get_wol,
+	.set_wol		= ksz_set_wol,
+	.suspend		= ksz_suspend,
+	.resume			= ksz_resume,
+	.get_ts_info		= ksz_get_ts_info,
+	.port_hwtstamp_get	= ksz_hwtstamp_get,
+	.port_hwtstamp_set	= ksz_hwtstamp_set,
+	.port_txtstamp		= ksz_port_txtstamp,
+	.port_rxtstamp		= ksz_port_rxtstamp,
+	.cls_flower_add		= ksz_cls_flower_add,
+	.cls_flower_del		= ksz_cls_flower_del,
+	.port_setup_tc		= ksz_setup_tc,
+	.support_eee		= ksz_support_eee,
+	.set_mac_eee		= ksz_set_mac_eee,
+	.port_get_default_prio	= ksz_port_get_default_prio,
+	.port_set_default_prio	= ksz_port_set_default_prio,
+	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
+	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
+	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
+	.port_get_apptrust	= ksz_port_get_apptrust,
+	.port_set_apptrust	= ksz_port_set_apptrust,
+};
+
+const struct dsa_switch_ops ksz87xx_switch_ops = {
+	.get_tag_protocol	= ksz_get_tag_protocol,
+	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.get_phy_flags		= ksz_get_phy_flags,
+	.setup			= ksz_setup,
+	.teardown		= ksz_teardown,
+	.phy_read		= ksz_phy_read16,
+	.phy_write		= ksz_phy_write16,
+	.phylink_get_caps	= ksz_phylink_get_caps,
+	.port_setup		= ksz_port_setup,
+	.set_ageing_time	= ksz_set_ageing_time,
+	.get_strings		= ksz_get_strings,
+	.get_ethtool_stats	= ksz_get_ethtool_stats,
+	.get_sset_count		= ksz_sset_count,
+	.port_bridge_join	= ksz_port_bridge_join,
+	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_hsr_join		= ksz_hsr_join,
+	.port_hsr_leave		= ksz_hsr_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
+	.port_stp_state_set	= ksz_port_stp_state_set,
+	.port_teardown		= ksz_port_teardown,
+	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
+	.port_bridge_flags	= ksz_port_bridge_flags,
+	.port_fast_age		= ksz_port_fast_age,
+	.port_vlan_filtering	= ksz_port_vlan_filtering,
+	.port_vlan_add		= ksz_port_vlan_add,
+	.port_vlan_del		= ksz_port_vlan_del,
+	.port_fdb_dump		= ksz_port_fdb_dump,
+	.port_fdb_add		= ksz_port_fdb_add,
+	.port_fdb_del		= ksz_port_fdb_del,
+	.port_mdb_add           = ksz_port_mdb_add,
+	.port_mdb_del           = ksz_port_mdb_del,
+	.port_mirror_add	= ksz_port_mirror_add,
+	.port_mirror_del	= ksz_port_mirror_del,
+	.get_stats64		= ksz_get_stats64,
+	.get_pause_stats	= ksz_get_pause_stats,
+	.port_change_mtu	= ksz_change_mtu,
+	.port_max_mtu		= ksz_max_mtu,
+	.get_wol		= ksz_get_wol,
+	.set_wol		= ksz_set_wol,
+	.suspend		= ksz_suspend,
+	.resume			= ksz_resume,
+	.get_ts_info		= ksz_get_ts_info,
+	.port_hwtstamp_get	= ksz_hwtstamp_get,
+	.port_hwtstamp_set	= ksz_hwtstamp_set,
+	.port_txtstamp		= ksz_port_txtstamp,
+	.port_rxtstamp		= ksz_port_rxtstamp,
+	.cls_flower_add		= ksz_cls_flower_add,
+	.cls_flower_del		= ksz_cls_flower_del,
+	.port_setup_tc		= ksz_setup_tc,
+	.support_eee		= ksz_support_eee,
+	.set_mac_eee		= ksz_set_mac_eee,
+	.port_get_default_prio	= ksz_port_get_default_prio,
+	.port_set_default_prio	= ksz_port_set_default_prio,
+	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
+	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
+	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
+	.port_get_apptrust	= ksz_port_get_apptrust,
+	.port_set_apptrust	= ksz_port_set_apptrust,
+};
+
+const struct dsa_switch_ops ksz88xx_switch_ops = {
+	.get_tag_protocol	= ksz_get_tag_protocol,
+	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.get_phy_flags		= ksz_get_phy_flags,
+	.setup			= ksz_setup,
+	.teardown		= ksz_teardown,
+	.phy_read		= ksz_phy_read16,
+	.phy_write		= ksz_phy_write16,
+	.phylink_get_caps	= ksz_phylink_get_caps,
+	.port_setup		= ksz_port_setup,
+	.set_ageing_time	= ksz_set_ageing_time,
+	.get_strings		= ksz_get_strings,
+	.get_ethtool_stats	= ksz_get_ethtool_stats,
+	.get_sset_count		= ksz_sset_count,
+	.port_bridge_join	= ksz_port_bridge_join,
+	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_hsr_join		= ksz_hsr_join,
+	.port_hsr_leave		= ksz_hsr_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
+	.port_stp_state_set	= ksz_port_stp_state_set,
+	.port_teardown		= ksz_port_teardown,
+	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
+	.port_bridge_flags	= ksz_port_bridge_flags,
+	.port_fast_age		= ksz_port_fast_age,
+	.port_vlan_filtering	= ksz_port_vlan_filtering,
+	.port_vlan_add		= ksz_port_vlan_add,
+	.port_vlan_del		= ksz_port_vlan_del,
+	.port_fdb_dump		= ksz_port_fdb_dump,
+	.port_fdb_add		= ksz_port_fdb_add,
+	.port_fdb_del		= ksz_port_fdb_del,
+	.port_mdb_add           = ksz_port_mdb_add,
+	.port_mdb_del           = ksz_port_mdb_del,
+	.port_mirror_add	= ksz_port_mirror_add,
+	.port_mirror_del	= ksz_port_mirror_del,
+	.get_stats64		= ksz_get_stats64,
+	.get_pause_stats	= ksz_get_pause_stats,
+	.port_change_mtu	= ksz_change_mtu,
+	.port_max_mtu		= ksz_max_mtu,
+	.get_wol		= ksz_get_wol,
+	.set_wol		= ksz_set_wol,
+	.suspend		= ksz_suspend,
+	.resume			= ksz_resume,
+	.get_ts_info		= ksz_get_ts_info,
+	.port_hwtstamp_get	= ksz_hwtstamp_get,
+	.port_hwtstamp_set	= ksz_hwtstamp_set,
+	.port_txtstamp		= ksz_port_txtstamp,
+	.port_rxtstamp		= ksz_port_rxtstamp,
+	.cls_flower_add		= ksz_cls_flower_add,
+	.cls_flower_del		= ksz_cls_flower_del,
+	.port_setup_tc		= ksz_setup_tc,
+	.support_eee		= ksz_support_eee,
+	.set_mac_eee		= ksz_set_mac_eee,
+	.port_get_default_prio	= ksz_port_get_default_prio,
+	.port_set_default_prio	= ksz_port_set_default_prio,
+	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
+	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
+	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
+	.port_get_apptrust	= ksz_port_get_apptrust,
+	.port_set_apptrust	= ksz_port_set_apptrust,
+};
+
 MODULE_AUTHOR("Tristram Ha <Tristram.Ha@microchip.com>");
 MODULE_DESCRIPTION("Microchip KSZ8795 Series Switch DSA Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 2d787d6d96b05..bc371cc26c6f1 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -17,5 +17,8 @@ extern const struct ksz_dev_ops ksz87xx_dev_ops;
 extern const struct ksz_dev_ops ksz88xx_dev_ops;
 extern const struct phylink_mac_ops ksz88x3_phylink_mac_ops;
 extern const struct phylink_mac_ops ksz8_phylink_mac_ops;
+extern const struct dsa_switch_ops ksz8463_switch_ops;
+extern const struct dsa_switch_ops ksz87xx_switch_ops;
+extern const struct dsa_switch_ops ksz88xx_switch_ops;
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 3fd2174364acf..9fb0169b5e29e 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -17,6 +17,7 @@
 
 #include "ksz9477_reg.h"
 #include "ksz_common.h"
+#include "ksz_dcb.h"
 #include "ksz9477.h"
 
 static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
@@ -1773,6 +1774,67 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.pcs_create = ksz9477_pcs_create,
 };
 
+const struct dsa_switch_ops ksz9477_switch_ops = {
+	.get_tag_protocol	= ksz_get_tag_protocol,
+	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.get_phy_flags		= ksz_get_phy_flags,
+	.setup			= ksz_setup,
+	.teardown		= ksz_teardown,
+	.phy_read		= ksz_phy_read16,
+	.phy_write		= ksz_phy_write16,
+	.phylink_get_caps	= ksz_phylink_get_caps,
+	.port_setup		= ksz_port_setup,
+	.set_ageing_time	= ksz_set_ageing_time,
+	.get_strings		= ksz_get_strings,
+	.get_ethtool_stats	= ksz_get_ethtool_stats,
+	.get_sset_count		= ksz_sset_count,
+	.port_bridge_join	= ksz_port_bridge_join,
+	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_hsr_join		= ksz_hsr_join,
+	.port_hsr_leave		= ksz_hsr_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
+	.port_stp_state_set	= ksz_port_stp_state_set,
+	.port_teardown		= ksz_port_teardown,
+	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
+	.port_bridge_flags	= ksz_port_bridge_flags,
+	.port_fast_age		= ksz_port_fast_age,
+	.port_vlan_filtering	= ksz_port_vlan_filtering,
+	.port_vlan_add		= ksz_port_vlan_add,
+	.port_vlan_del		= ksz_port_vlan_del,
+	.port_fdb_dump		= ksz_port_fdb_dump,
+	.port_fdb_add		= ksz_port_fdb_add,
+	.port_fdb_del		= ksz_port_fdb_del,
+	.port_mdb_add           = ksz_port_mdb_add,
+	.port_mdb_del           = ksz_port_mdb_del,
+	.port_mirror_add	= ksz_port_mirror_add,
+	.port_mirror_del	= ksz_port_mirror_del,
+	.get_stats64		= ksz_get_stats64,
+	.get_pause_stats	= ksz_get_pause_stats,
+	.port_change_mtu	= ksz_change_mtu,
+	.port_max_mtu		= ksz_max_mtu,
+	.get_wol		= ksz_get_wol,
+	.set_wol		= ksz_set_wol,
+	.suspend		= ksz_suspend,
+	.resume			= ksz_resume,
+	.get_ts_info		= ksz_get_ts_info,
+	.port_hwtstamp_get	= ksz_hwtstamp_get,
+	.port_hwtstamp_set	= ksz_hwtstamp_set,
+	.port_txtstamp		= ksz_port_txtstamp,
+	.port_rxtstamp		= ksz_port_rxtstamp,
+	.cls_flower_add		= ksz_cls_flower_add,
+	.cls_flower_del		= ksz_cls_flower_del,
+	.port_setup_tc		= ksz_setup_tc,
+	.support_eee		= ksz_support_eee,
+	.set_mac_eee		= ksz_set_mac_eee,
+	.port_get_default_prio	= ksz_port_get_default_prio,
+	.port_set_default_prio	= ksz_port_set_default_prio,
+	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
+	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
+	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
+	.port_get_apptrust	= ksz_port_get_apptrust,
+	.port_set_apptrust	= ksz_port_set_apptrust,
+};
+
 MODULE_AUTHOR("Woojung Huh <Woojung.Huh@microchip.com>");
 MODULE_DESCRIPTION("Microchip KSZ9477 Series Switch DSA Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 26a91f1a4c871..bacadcbc478cc 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -93,5 +93,6 @@ void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 
 extern const struct ksz_dev_ops ksz9477_dev_ops;
 extern const struct phylink_mac_ops ksz9477_phylink_mac_ops;
+extern const struct dsa_switch_ops ksz9477_switch_ops;
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 308740829e76c..e48b9d5c06301 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1258,6 +1258,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz8463_dev_ops,
+		.switch_ops = &ksz8463_switch_ops,
 		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
@@ -1283,6 +1284,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1313,6 +1315,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz87xx_dev_ops,
+		.switch_ops = &ksz87xx_switch_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
@@ -1354,6 +1357,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz87xx_dev_ops,
+		.switch_ops = &ksz87xx_switch_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
@@ -1381,6 +1385,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz87xx_dev_ops,
+		.switch_ops = &ksz87xx_switch_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
@@ -1408,6 +1413,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz88xx_dev_ops,
+		.switch_ops = &ksz88xx_switch_ops,
 		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
@@ -1442,6 +1448,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz88xx_dev_ops,
+		.switch_ops = &ksz88xx_switch_ops,
 		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
@@ -1465,6 +1472,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz88xx_dev_ops,
+		.switch_ops = &ksz88xx_switch_ops,
 		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
@@ -1490,6 +1498,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.phy_errata_9477 = true,
 		.mib_names = ksz9477_mib_names,
@@ -1527,6 +1536,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 8,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.phy_errata_9477 = true,
 		.mib_names = ksz9477_mib_names,
@@ -1562,6 +1572,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 8,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.phy_errata_9477 = true,
 		.mib_names = ksz9477_mib_names,
@@ -1595,6 +1606,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 8,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1624,6 +1636,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1654,6 +1667,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.phy_errata_9477 = true,
 		.mib_names = ksz9477_mib_names,
@@ -1690,6 +1704,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1724,6 +1739,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
+		.switch_ops = &lan937x_switch_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1754,6 +1770,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
+		.switch_ops = &lan937x_switch_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1784,6 +1801,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
+		.switch_ops = &lan937x_switch_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1818,6 +1836,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
+		.switch_ops = &lan937x_switch_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1852,6 +1871,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.tc_cbs_supported = true,
 		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
+		.switch_ops = &lan937x_switch_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
@@ -1884,6 +1904,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 8,
 		.ops = &ksz9477_dev_ops,
+		.switch_ops = &ksz9477_switch_ops,
 		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
 		.phy_errata_9477 = true,
 		.mib_names = ksz9477_mib_names,
@@ -1949,8 +1970,8 @@ static int ksz_check_device_id(struct ksz_device *dev)
 	return 0;
 }
 
-static void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
-				 struct phylink_config *config)
+void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
+			  struct phylink_config *config)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -2095,8 +2116,8 @@ void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port)
 	spin_unlock(&mib->stats64_lock);
 }
 
-static void ksz_get_stats64(struct dsa_switch *ds, int port,
-			    struct rtnl_link_stats64 *s)
+void ksz_get_stats64(struct dsa_switch *ds, int port,
+		     struct rtnl_link_stats64 *s)
 {
 	struct ksz_device *dev = ds->priv;
 	struct ksz_port_mib *mib;
@@ -2108,8 +2129,8 @@ static void ksz_get_stats64(struct dsa_switch *ds, int port,
 	spin_unlock(&mib->stats64_lock);
 }
 
-static void ksz_get_pause_stats(struct dsa_switch *ds, int port,
-				struct ethtool_pause_stats *pause_stats)
+void ksz_get_pause_stats(struct dsa_switch *ds, int port,
+			 struct ethtool_pause_stats *pause_stats)
 {
 	struct ksz_device *dev = ds->priv;
 	struct ksz_port_mib *mib;
@@ -2121,8 +2142,8 @@ static void ksz_get_pause_stats(struct dsa_switch *ds, int port,
 	spin_unlock(&mib->stats64_lock);
 }
 
-static void ksz_get_strings(struct dsa_switch *ds, int port,
-			    u32 stringset, uint8_t *buf)
+void ksz_get_strings(struct dsa_switch *ds, int port,
+		     u32 stringset, uint8_t *buf)
 {
 	struct ksz_device *dev = ds->priv;
 	int i;
@@ -2729,7 +2750,7 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 
 static int ksz_parse_drive_strength(struct ksz_device *dev);
 
-static int ksz_setup(struct dsa_switch *ds)
+int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	u16 storm_mask, storm_rate;
@@ -2859,7 +2880,7 @@ static int ksz_setup(struct dsa_switch *ds)
 	return ret;
 }
 
-static void ksz_teardown(struct dsa_switch *ds)
+void ksz_teardown(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	struct dsa_port *dp;
@@ -2959,7 +2980,7 @@ void ksz_init_mib_timer(struct ksz_device *dev)
 	}
 }
 
-static int ksz_phy_read16(struct dsa_switch *ds, int addr, int reg)
+int ksz_phy_read16(struct dsa_switch *ds, int addr, int reg)
 {
 	struct ksz_device *dev = ds->priv;
 	u16 val = 0xffff;
@@ -2972,7 +2993,7 @@ static int ksz_phy_read16(struct dsa_switch *ds, int addr, int reg)
 	return val;
 }
 
-static int ksz_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val)
+int ksz_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val)
 {
 	struct ksz_device *dev = ds->priv;
 	int ret;
@@ -2984,7 +3005,7 @@ static int ksz_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val)
 	return 0;
 }
 
-static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
+u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3016,7 +3037,7 @@ void ksz_phylink_mac_link_down(struct phylink_config *config,
 		schedule_delayed_work(&dev->mib_read, 0);
 }
 
-static int ksz_sset_count(struct dsa_switch *ds, int port, int sset)
+int ksz_sset_count(struct dsa_switch *ds, int port, int sset)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3026,8 +3047,8 @@ static int ksz_sset_count(struct dsa_switch *ds, int port, int sset)
 	return dev->info->mib_cnt;
 }
 
-static void ksz_get_ethtool_stats(struct dsa_switch *ds, int port,
-				  uint64_t *buf)
+void ksz_get_ethtool_stats(struct dsa_switch *ds, int port,
+			   uint64_t *buf)
 {
 	const struct dsa_port *dp = dsa_to_port(ds, port);
 	struct ksz_device *dev = ds->priv;
@@ -3044,10 +3065,10 @@ static void ksz_get_ethtool_stats(struct dsa_switch *ds, int port,
 	mutex_unlock(&mib->cnt_mutex);
 }
 
-static int ksz_port_bridge_join(struct dsa_switch *ds, int port,
-				struct dsa_bridge bridge,
-				bool *tx_fwd_offload,
-				struct netlink_ext_ack *extack)
+int ksz_port_bridge_join(struct dsa_switch *ds, int port,
+			 struct dsa_bridge bridge,
+			 bool *tx_fwd_offload,
+			 struct netlink_ext_ack *extack)
 {
 	/* port_stp_state_set() will be called after to put the port in
 	 * appropriate state so there is no need to do anything.
@@ -3056,22 +3077,22 @@ static int ksz_port_bridge_join(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static void ksz_port_bridge_leave(struct dsa_switch *ds, int port,
-				  struct dsa_bridge bridge)
+void ksz_port_bridge_leave(struct dsa_switch *ds, int port,
+			   struct dsa_bridge bridge)
 {
 	/* port_stp_state_set() will be called after to put the port in
 	 * forwarding state so there is no need to do anything.
 	 */
 }
 
-static void ksz_port_fast_age(struct dsa_switch *ds, int port)
+void ksz_port_fast_age(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
 	dev->dev_ops->flush_dyn_mac_table(dev, port);
 }
 
-static int ksz_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+int ksz_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3081,9 +3102,9 @@ static int ksz_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	return dev->dev_ops->set_ageing_time(dev, msecs);
 }
 
-static int ksz_port_fdb_add(struct dsa_switch *ds, int port,
-			    const unsigned char *addr, u16 vid,
-			    struct dsa_db db)
+int ksz_port_fdb_add(struct dsa_switch *ds, int port,
+		     const unsigned char *addr, u16 vid,
+		     struct dsa_db db)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3093,9 +3114,9 @@ static int ksz_port_fdb_add(struct dsa_switch *ds, int port,
 	return dev->dev_ops->fdb_add(dev, port, addr, vid, db);
 }
 
-static int ksz_port_fdb_del(struct dsa_switch *ds, int port,
-			    const unsigned char *addr,
-			    u16 vid, struct dsa_db db)
+int ksz_port_fdb_del(struct dsa_switch *ds, int port,
+		     const unsigned char *addr,
+		     u16 vid, struct dsa_db db)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3105,8 +3126,8 @@ static int ksz_port_fdb_del(struct dsa_switch *ds, int port,
 	return dev->dev_ops->fdb_del(dev, port, addr, vid, db);
 }
 
-static int ksz_port_fdb_dump(struct dsa_switch *ds, int port,
-			     dsa_fdb_dump_cb_t *cb, void *data)
+int ksz_port_fdb_dump(struct dsa_switch *ds, int port,
+		      dsa_fdb_dump_cb_t *cb, void *data)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3116,9 +3137,9 @@ static int ksz_port_fdb_dump(struct dsa_switch *ds, int port,
 	return dev->dev_ops->fdb_dump(dev, port, cb, data);
 }
 
-static int ksz_port_mdb_add(struct dsa_switch *ds, int port,
-			    const struct switchdev_obj_port_mdb *mdb,
-			    struct dsa_db db)
+int ksz_port_mdb_add(struct dsa_switch *ds, int port,
+		     const struct switchdev_obj_port_mdb *mdb,
+		     struct dsa_db db)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3128,9 +3149,9 @@ static int ksz_port_mdb_add(struct dsa_switch *ds, int port,
 	return dev->dev_ops->mdb_add(dev, port, mdb, db);
 }
 
-static int ksz_port_mdb_del(struct dsa_switch *ds, int port,
-			    const struct switchdev_obj_port_mdb *mdb,
-			    struct dsa_db db)
+int ksz_port_mdb_del(struct dsa_switch *ds, int port,
+		     const struct switchdev_obj_port_mdb *mdb,
+		     struct dsa_db db)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3163,7 +3184,7 @@ static int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev,
 	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
 }
 
-static int ksz_port_setup(struct dsa_switch *ds, int port)
+int ksz_port_setup(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 	int ret;
@@ -3233,7 +3254,7 @@ void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	ksz_update_port_member(dev, port);
 }
 
-static void ksz_port_teardown(struct dsa_switch *ds, int port)
+void ksz_port_teardown(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3252,9 +3273,9 @@ static void ksz_port_teardown(struct dsa_switch *ds, int port)
 	}
 }
 
-static int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
-				     struct switchdev_brport_flags flags,
-				     struct netlink_ext_ack *extack)
+int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+			      struct switchdev_brport_flags flags,
+			      struct netlink_ext_ack *extack)
 {
 	if (flags.mask & ~(BR_LEARNING | BR_ISOLATED))
 		return -EINVAL;
@@ -3262,9 +3283,9 @@ static int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
-				 struct switchdev_brport_flags flags,
-				 struct netlink_ext_ack *extack)
+int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
+			  struct switchdev_brport_flags flags,
+			  struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
 	struct ksz_port *p = &dev->ports[port];
@@ -3283,9 +3304,9 @@ static int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
-						  int port,
-						  enum dsa_tag_protocol mp)
+enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
+					   int port,
+					   enum dsa_tag_protocol mp)
 {
 	struct ksz_device *dev = ds->priv;
 	enum dsa_tag_protocol proto = DSA_TAG_PROTO_NONE;
@@ -3314,8 +3335,8 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	return proto;
 }
 
-static int ksz_connect_tag_protocol(struct dsa_switch *ds,
-				    enum dsa_tag_protocol proto)
+int ksz_connect_tag_protocol(struct dsa_switch *ds,
+			     enum dsa_tag_protocol proto)
 {
 	struct ksz_tagger_data *tagger_data;
 
@@ -3333,8 +3354,8 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 	}
 }
 
-static int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
-				   bool flag, struct netlink_ext_ack *extack)
+int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
+			    bool flag, struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3344,9 +3365,9 @@ static int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
 	return dev->dev_ops->vlan_filtering(dev, port, flag, extack);
 }
 
-static int ksz_port_vlan_add(struct dsa_switch *ds, int port,
-			     const struct switchdev_obj_port_vlan *vlan,
-			     struct netlink_ext_ack *extack)
+int ksz_port_vlan_add(struct dsa_switch *ds, int port,
+		      const struct switchdev_obj_port_vlan *vlan,
+		      struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3356,8 +3377,8 @@ static int ksz_port_vlan_add(struct dsa_switch *ds, int port,
 	return dev->dev_ops->vlan_add(dev, port, vlan, extack);
 }
 
-static int ksz_port_vlan_del(struct dsa_switch *ds, int port,
-			     const struct switchdev_obj_port_vlan *vlan)
+int ksz_port_vlan_del(struct dsa_switch *ds, int port,
+		      const struct switchdev_obj_port_vlan *vlan)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3367,9 +3388,9 @@ static int ksz_port_vlan_del(struct dsa_switch *ds, int port,
 	return dev->dev_ops->vlan_del(dev, port, vlan);
 }
 
-static int ksz_port_mirror_add(struct dsa_switch *ds, int port,
-			       struct dsa_mall_mirror_tc_entry *mirror,
-			       bool ingress, struct netlink_ext_ack *extack)
+int ksz_port_mirror_add(struct dsa_switch *ds, int port,
+			struct dsa_mall_mirror_tc_entry *mirror,
+			bool ingress, struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3379,8 +3400,8 @@ static int ksz_port_mirror_add(struct dsa_switch *ds, int port,
 	return dev->dev_ops->mirror_add(dev, port, mirror, ingress, extack);
 }
 
-static void ksz_port_mirror_del(struct dsa_switch *ds, int port,
-				struct dsa_mall_mirror_tc_entry *mirror)
+void ksz_port_mirror_del(struct dsa_switch *ds, int port,
+			 struct dsa_mall_mirror_tc_entry *mirror)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3388,7 +3409,7 @@ static void ksz_port_mirror_del(struct dsa_switch *ds, int port,
 		dev->dev_ops->mirror_del(dev, port, mirror);
 }
 
-static int ksz_change_mtu(struct dsa_switch *ds, int port, int mtu)
+int ksz_change_mtu(struct dsa_switch *ds, int port, int mtu)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3398,7 +3419,7 @@ static int ksz_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	return dev->dev_ops->change_mtu(dev, port, mtu);
 }
 
-static int ksz_max_mtu(struct dsa_switch *ds, int port)
+int ksz_max_mtu(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3446,7 +3467,7 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
  * Returns: true if the internal PHY on the given port supports fully
  * operational EEE, false otherwise.
  */
-static bool ksz_support_eee(struct dsa_switch *ds, int port)
+bool ksz_support_eee(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3489,8 +3510,8 @@ static bool ksz_support_eee(struct dsa_switch *ds, int port)
 	return false;
 }
 
-static int ksz_set_mac_eee(struct dsa_switch *ds, int port,
-			   struct ethtool_keee *e)
+int ksz_set_mac_eee(struct dsa_switch *ds, int port,
+		    struct ethtool_keee *e)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3735,8 +3756,8 @@ static int ksz_switch_detect(struct ksz_device *dev)
 	return 0;
 }
 
-static int ksz_cls_flower_add(struct dsa_switch *ds, int port,
-			      struct flow_cls_offload *cls, bool ingress)
+int ksz_cls_flower_add(struct dsa_switch *ds, int port,
+		       struct flow_cls_offload *cls, bool ingress)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -3756,8 +3777,8 @@ static int ksz_cls_flower_add(struct dsa_switch *ds, int port,
 	return -EOPNOTSUPP;
 }
 
-static int ksz_cls_flower_del(struct dsa_switch *ds, int port,
-			      struct flow_cls_offload *cls, bool ingress)
+int ksz_cls_flower_del(struct dsa_switch *ds, int port,
+		       struct flow_cls_offload *cls, bool ingress)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -4160,8 +4181,8 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 	return -EOPNOTSUPP;
 }
 
-static int ksz_setup_tc(struct dsa_switch *ds, int port,
-			enum tc_setup_type type, void *type_data)
+int ksz_setup_tc(struct dsa_switch *ds, int port,
+		 enum tc_setup_type type, void *type_data)
 {
 	switch (type) {
 	case TC_SETUP_QDISC_CBS:
@@ -4220,8 +4241,8 @@ int ksz_handle_wake_reason(struct ksz_device *dev, int port)
  * If enabled and supported, it sets the supported and active WoL
  * flags.
  */
-static void ksz_get_wol(struct dsa_switch *ds, int port,
-			struct ethtool_wolinfo *wol)
+void ksz_get_wol(struct dsa_switch *ds, int port,
+		 struct ethtool_wolinfo *wol)
 {
 	struct ksz_device *dev = ds->priv;
 	const u16 *regs = dev->info->regs;
@@ -4268,8 +4289,8 @@ static void ksz_get_wol(struct dsa_switch *ds, int port,
  *
  * Return: 0 on success, or other error codes on failure.
  */
-static int ksz_set_wol(struct dsa_switch *ds, int port,
-		       struct ethtool_wolinfo *wol)
+int ksz_set_wol(struct dsa_switch *ds, int port,
+		struct ethtool_wolinfo *wol)
 {
 	u8 pme_ctrl = 0, pme_ctrl_old = 0;
 	struct ksz_device *dev = ds->priv;
@@ -4383,8 +4404,8 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 	}
 }
 
-static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
-				    const unsigned char *addr)
+int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
+			     const unsigned char *addr)
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct ethtool_wolinfo wol;
@@ -4536,8 +4557,8 @@ void ksz_switch_macaddr_put(struct dsa_switch *ds)
 	kfree(switch_macaddr);
 }
 
-static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
-			struct netlink_ext_ack *extack)
+int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
+		 struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
 	enum hsr_version ver;
@@ -4585,8 +4606,8 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
 	return 0;
 }
 
-static int ksz_hsr_leave(struct dsa_switch *ds, int port,
-			 struct net_device *hsr)
+int ksz_hsr_leave(struct dsa_switch *ds, int port,
+		  struct net_device *hsr)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -4602,7 +4623,7 @@ static int ksz_hsr_leave(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static int ksz_suspend(struct dsa_switch *ds)
+int ksz_suspend(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 
@@ -4610,7 +4631,7 @@ static int ksz_suspend(struct dsa_switch *ds)
 	return 0;
 }
 
-static int ksz_resume(struct dsa_switch *ds)
+int ksz_resume(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 519e080c8910e..125740deb5a21 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -73,6 +73,7 @@ struct ksz_chip_data {
 	 */
 	bool phy_side_mdio_supported;
 	const struct ksz_dev_ops *ops;
+	const struct dsa_switch_ops *switch_ops;
 	const struct phylink_mac_ops *phylink_mac_ops;
 	bool phy_errata_9477;
 	bool ksz87xx_eee_link_erratum;
@@ -465,6 +466,16 @@ void ksz_switch_remove(struct ksz_device *dev);
 int ksz_switch_suspend(struct device *dev);
 int ksz_switch_resume(struct device *dev);
 
+int ksz_setup(struct dsa_switch *ds);
+void ksz_teardown(struct dsa_switch *ds);
+int ksz_port_setup(struct dsa_switch *ds, int port);
+void ksz_port_teardown(struct dsa_switch *ds, int port);
+
+enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
+					   int port,
+					   enum dsa_tag_protocol mp);
+int ksz_connect_tag_protocol(struct dsa_switch *ds,
+			     enum dsa_tag_protocol proto);
 void ksz_init_mib_timer(struct ksz_device *dev);
 bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port);
 void ksz_r_mib_stats64(struct ksz_device *dev, int port);
@@ -479,6 +490,58 @@ void ksz_switch_macaddr_put(struct dsa_switch *ds);
 void ksz_switch_shutdown(struct ksz_device *dev);
 int ksz_handle_wake_reason(struct ksz_device *dev, int port);
 
+int ksz_phy_read16(struct dsa_switch *ds, int addr, int reg);
+int ksz_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val);
+u32 ksz_get_phy_flags(struct dsa_switch *ds, int port);
+
+int ksz_sset_count(struct dsa_switch *ds, int port, int sset);
+void ksz_get_ethtool_stats(struct dsa_switch *ds, int port,
+			   uint64_t *buf);
+void ksz_get_stats64(struct dsa_switch *ds, int port,
+		     struct rtnl_link_stats64 *s);
+void ksz_get_pause_stats(struct dsa_switch *ds, int port,
+			 struct ethtool_pause_stats *pause_stats);
+void ksz_get_strings(struct dsa_switch *ds, int port,
+		     u32 stringset, uint8_t *buf);
+
+int ksz_port_bridge_join(struct dsa_switch *ds, int port,
+			 struct dsa_bridge bridge,
+			 bool *tx_fwd_offload,
+			 struct netlink_ext_ack *extack);
+void ksz_port_bridge_leave(struct dsa_switch *ds, int port,
+			   struct dsa_bridge bridge);
+int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+			      struct switchdev_brport_flags flags,
+			      struct netlink_ext_ack *extack);
+int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
+			  struct switchdev_brport_flags flags,
+			  struct netlink_ext_ack *extack);
+int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
+			    bool flag, struct netlink_ext_ack *extack);
+int ksz_port_vlan_add(struct dsa_switch *ds, int port,
+		      const struct switchdev_obj_port_vlan *vlan,
+		      struct netlink_ext_ack *extack);
+int ksz_port_vlan_del(struct dsa_switch *ds, int port,
+		      const struct switchdev_obj_port_vlan *vlan);
+void ksz_port_fast_age(struct dsa_switch *ds, int port);
+int ksz_set_ageing_time(struct dsa_switch *ds, unsigned int msecs);
+int ksz_port_fdb_add(struct dsa_switch *ds, int port,
+		     const unsigned char *addr, u16 vid,
+		     struct dsa_db db);
+int ksz_port_fdb_del(struct dsa_switch *ds, int port,
+		     const unsigned char *addr,
+		     u16 vid, struct dsa_db db);
+int ksz_port_fdb_dump(struct dsa_switch *ds, int port,
+		      dsa_fdb_dump_cb_t *cb, void *data);
+int ksz_port_mdb_add(struct dsa_switch *ds, int port,
+		     const struct switchdev_obj_port_mdb *mdb,
+		     struct dsa_db db);
+int ksz_port_mdb_del(struct dsa_switch *ds, int port,
+		     const struct switchdev_obj_port_mdb *mdb,
+		     struct dsa_db db);
+
+void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
+			  struct phylink_config *config);
 void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config);
 int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
 				  u32 timer, bool tx_clock_stop);
@@ -489,6 +552,39 @@ void ksz_phylink_mac_link_down(struct phylink_config *config,
 			       unsigned int mode,
 			       phy_interface_t interface);
 
+int ksz_port_mirror_add(struct dsa_switch *ds, int port,
+			struct dsa_mall_mirror_tc_entry *mirror,
+			bool ingress, struct netlink_ext_ack *extack);
+void ksz_port_mirror_del(struct dsa_switch *ds, int port,
+			 struct dsa_mall_mirror_tc_entry *mirror);
+int ksz_change_mtu(struct dsa_switch *ds, int port, int mtu);
+int ksz_max_mtu(struct dsa_switch *ds, int port);
+
+bool ksz_support_eee(struct dsa_switch *ds, int port);
+int ksz_set_mac_eee(struct dsa_switch *ds, int port,
+		    struct ethtool_keee *e);
+
+int ksz_cls_flower_add(struct dsa_switch *ds, int port,
+		       struct flow_cls_offload *cls, bool ingress);
+int ksz_cls_flower_del(struct dsa_switch *ds, int port,
+		       struct flow_cls_offload *cls, bool ingress);
+int ksz_setup_tc(struct dsa_switch *ds, int port,
+		 enum tc_setup_type type, void *type_data);
+
+void ksz_get_wol(struct dsa_switch *ds, int port,
+		 struct ethtool_wolinfo *wol);
+int ksz_set_wol(struct dsa_switch *ds, int port,
+		struct ethtool_wolinfo *wol);
+int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
+			     const unsigned char *addr);
+int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
+		 struct netlink_ext_ack *extack);
+int ksz_hsr_leave(struct dsa_switch *ds, int port,
+		  struct net_device *hsr);
+
+int ksz_suspend(struct dsa_switch *ds);
+int ksz_resume(struct dsa_switch *ds);
+
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
 {
diff --git a/drivers/net/dsa/microchip/lan937x.h b/drivers/net/dsa/microchip/lan937x.h
index c5e745a9f47f1..d12483f9081d8 100644
--- a/drivers/net/dsa/microchip/lan937x.h
+++ b/drivers/net/dsa/microchip/lan937x.h
@@ -8,5 +8,6 @@
 
 extern const struct ksz_dev_ops lan937x_dev_ops;
 extern const struct phylink_mac_ops lan937x_phylink_mac_ops;
+extern const struct dsa_switch_ops lan937x_switch_ops;
 
 #endif
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 4846ae2a2d69a..ff931b1143a52 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -15,6 +15,7 @@
 
 #include "lan937x_reg.h"
 #include "ksz_common.h"
+#include "ksz_dcb.h"
 #include "ksz9477.h"
 #include "lan937x.h"
 
@@ -712,6 +713,67 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.exit = lan937x_switch_exit,
 };
 
+const struct dsa_switch_ops lan937x_switch_ops = {
+	.get_tag_protocol	= ksz_get_tag_protocol,
+	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.get_phy_flags		= ksz_get_phy_flags,
+	.setup			= ksz_setup,
+	.teardown		= ksz_teardown,
+	.phy_read		= ksz_phy_read16,
+	.phy_write		= ksz_phy_write16,
+	.phylink_get_caps	= ksz_phylink_get_caps,
+	.port_setup		= ksz_port_setup,
+	.set_ageing_time	= ksz_set_ageing_time,
+	.get_strings		= ksz_get_strings,
+	.get_ethtool_stats	= ksz_get_ethtool_stats,
+	.get_sset_count		= ksz_sset_count,
+	.port_bridge_join	= ksz_port_bridge_join,
+	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_hsr_join		= ksz_hsr_join,
+	.port_hsr_leave		= ksz_hsr_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
+	.port_stp_state_set	= ksz_port_stp_state_set,
+	.port_teardown		= ksz_port_teardown,
+	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
+	.port_bridge_flags	= ksz_port_bridge_flags,
+	.port_fast_age		= ksz_port_fast_age,
+	.port_vlan_filtering	= ksz_port_vlan_filtering,
+	.port_vlan_add		= ksz_port_vlan_add,
+	.port_vlan_del		= ksz_port_vlan_del,
+	.port_fdb_dump		= ksz_port_fdb_dump,
+	.port_fdb_add		= ksz_port_fdb_add,
+	.port_fdb_del		= ksz_port_fdb_del,
+	.port_mdb_add           = ksz_port_mdb_add,
+	.port_mdb_del           = ksz_port_mdb_del,
+	.port_mirror_add	= ksz_port_mirror_add,
+	.port_mirror_del	= ksz_port_mirror_del,
+	.get_stats64		= ksz_get_stats64,
+	.get_pause_stats	= ksz_get_pause_stats,
+	.port_change_mtu	= ksz_change_mtu,
+	.port_max_mtu		= ksz_max_mtu,
+	.get_wol		= ksz_get_wol,
+	.set_wol		= ksz_set_wol,
+	.suspend		= ksz_suspend,
+	.resume			= ksz_resume,
+	.get_ts_info		= ksz_get_ts_info,
+	.port_hwtstamp_get	= ksz_hwtstamp_get,
+	.port_hwtstamp_set	= ksz_hwtstamp_set,
+	.port_txtstamp		= ksz_port_txtstamp,
+	.port_rxtstamp		= ksz_port_rxtstamp,
+	.cls_flower_add		= ksz_cls_flower_add,
+	.cls_flower_del		= ksz_cls_flower_del,
+	.port_setup_tc		= ksz_setup_tc,
+	.support_eee		= ksz_support_eee,
+	.set_mac_eee		= ksz_set_mac_eee,
+	.port_get_default_prio	= ksz_port_get_default_prio,
+	.port_set_default_prio	= ksz_port_set_default_prio,
+	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
+	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
+	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
+	.port_get_apptrust	= ksz_port_get_apptrust,
+	.port_set_apptrust	= ksz_port_set_apptrust,
+};
+
 MODULE_AUTHOR("Arun Ramadoss <arun.ramadoss@microchip.com>");
 MODULE_DESCRIPTION("Microchip LAN937x Series Switch DSA Driver");
 MODULE_LICENSE("GPL");

-- 
2.53.0


