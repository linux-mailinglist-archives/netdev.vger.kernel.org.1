Return-Path: <netdev+bounces-227757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77EBB6AC0
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 14:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 570234EBFF3
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E22EFD9F;
	Fri,  3 Oct 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J+kQcRdz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1122EF662;
	Fri,  3 Oct 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494991; cv=none; b=nQwUvXYUcwfeXIcHe7keWVb5cK07wBcw8yvdxSFDcrTa8czwLKc1XBk6553IlST3/x4YYQezesiclXXebERRPqY3GAqpxAbZkbT+qiewSNmk3Yb3ARaI/mjLJGUqFXQrgzmUMNTH8cjxbsz6/8SblpiP1JjvZVb2bGjkrzUr6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494991; c=relaxed/simple;
	bh=RC9HyGQ6QSohaeISaCdw19nbbVwsVyT87/EVmTYnn1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nhS7rvhv2dM2B0f86VjfKb35Di/gyaa9FOvk5dKT0Yk27o1BZmsYNDKlRQ6XDc4tdNJgLlxIlJcrc6h8IoJP4falSwMVHkS6kosFg6wUKkaA7W8mxPCiT65zrbCb9UjaDYJWJNx3tOGv0CePiGFJDXSRMAwO9Fg4MMnfxQEXlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J+kQcRdz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759494989; x=1791030989;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=RC9HyGQ6QSohaeISaCdw19nbbVwsVyT87/EVmTYnn1g=;
  b=J+kQcRdzwsg73gYsiCCPQHT+W2xJ2GsczE3HKdCi6HSETXy70CsHELzt
   e8DgtoDSQASDPtpxdlQlSjA1HavOAY18Sk7nicyHDoWJKKVFGTuxEfwpe
   EnMYC4ltv45PGI4eM8N8Ng5gpXjLr4mLj9LoER/PxSORIlgioshouBMf7
   MceeYSuKE5glmZNAnH/KHfYsLzakXTO+muzYKOwJa51JzvUAIICeYifMf
   jZW1T8fj3a3syu5ygjNJQ2y4cxTr3rz5SzocGRTeqa3HrJcYEsqx1Vgjz
   xtiHVvfJDEpZkO5IgLoOILgbLAcslFjMUJ0DeSws3YtGS3M2vm41K7SCg
   g==;
X-CSE-ConnectionGUID: 0nDMz/hwSCOo3uHbo/xgMA==
X-CSE-MsgGUID: JVDXOMwZQtaJThf3BLML/A==
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="278678034"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2025 05:36:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 3 Oct 2025 05:36:02 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 3 Oct 2025 05:36:00 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 3 Oct 2025 14:35:59 +0200
Subject: [PATCH net] net: sparx5/lan969x: fix flooding configuration on
 bridge join/leave
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251003-fix-flood-fwd-v1-1-48eb478b2904@microchip.com>
X-B4-Tracking: v=1; b=H4sIAC7D32gC/x2M0QrCMBAEf6XsswdpS631V8SHNLnYA71IIiqU/
 rtXH2fZmRWVi3DFuVlR+C1Vshq0hwZh8XpjkmiMznVD61xPSb6U7jlHSp9I/cTpNMYjT2OAOc/
 Cdvj3LlB+4Wrj7CvTXLyGZU89vCi27QdxuJLkewAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
CC: Steen Hegelund <steen.hegelund@microchip.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

The sparx5 driver programs UC/MC/BC flooding in sparx5_update_fwd() by
unconditionally applying bridge_fwd_mask to all flood PGIDs. Any bridge
topology change that triggers sparx5_update_fwd() (for example enslaving
another port) therefore reinstalls flooding in hardware for already
bridged ports, regardless of their per-port flood flags.

This results in clobbering of the flood masks, and desynchronization
between software and hardware: the bridge still reports “flood off” for
the port, but hardware has flooding enabled due to unconditional PGID
reprogramming.

Steps to reproduce:

    $ ip link add br0 type bridge
    $ ip link set br0 up
    $ ip link set eth0 master br0
    $ ip link set eth0 up
    $ bridge link set dev eth0 flood off
    $ ip link set eth1 master br0
    $ ip link set eth1 up

At this point, flooding is silently re-enabled for eth0. Software still
shows “flood off” for eth0, but hardware has flooding enabled.

To fix this, flooding is now set explicitly during bridge join/leave,
through sparx5_port_attr_bridge_flags():

    On bridge join, UC/MC/BC flooding is enabled by default.

    On bridge leave, UC/MC/BC flooding is disabled.

    sparx5_update_fwd() no longer touches the flood PGIDs, clobbering
    the flood masks, and desynchronizing software and hardware.

    Initialization of the flooding PGIDs have been moved to
    sparx5_start(). This is required as flooding PGIDs defaults to
    0x3fffffff in hardware and the initialization was previously handled
    in sparx5_update_fwd(), which was removed.

With this change, user-configured flooding flags persist across bridge
updates and are no longer overridden by sparx5_update_fwd().

Fixes: d6fce5141929 ("net: sparx5: add switching support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c      |  5 +++++
 drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c | 12 ++++++++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c      | 10 ----------
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 74ad1d73b465..40b1bfc600a7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -708,6 +708,11 @@ static int sparx5_start(struct sparx5 *sparx5)
 	/* Init masks */
 	sparx5_update_fwd(sparx5);
 
+	/* Init flood masks */
+	for (int pgid = sparx5_get_pgid(sparx5, PGID_UC_FLOOD);
+	     pgid <= sparx5_get_pgid(sparx5, PGID_BCAST); pgid++)
+		sparx5_pgid_clear(sparx5, pgid);
+
 	/* CPU copy CPU pgids */
 	spx5_wr(ANA_AC_PGID_MISC_CFG_PGID_CPU_COPY_ENA_SET(1), sparx5,
 		ANA_AC_PGID_MISC_CFG(sparx5_get_pgid(sparx5, PGID_CPU)));
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index bc9ecb9392cd..0a71abbd3da5 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -176,6 +176,7 @@ static int sparx5_port_bridge_join(struct sparx5_port *port,
 				   struct net_device *bridge,
 				   struct netlink_ext_ack *extack)
 {
+	struct switchdev_brport_flags flags = {0};
 	struct sparx5 *sparx5 = port->sparx5;
 	struct net_device *ndev = port->ndev;
 	int err;
@@ -205,6 +206,11 @@ static int sparx5_port_bridge_join(struct sparx5_port *port,
 	 */
 	__dev_mc_unsync(ndev, sparx5_mc_unsync);
 
+	/* Enable uc/mc/bc flooding */
+	flags.mask = BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	flags.val = flags.mask;
+	sparx5_port_attr_bridge_flags(port, flags);
+
 	return 0;
 
 err_switchdev_offload:
@@ -215,6 +221,7 @@ static int sparx5_port_bridge_join(struct sparx5_port *port,
 static void sparx5_port_bridge_leave(struct sparx5_port *port,
 				     struct net_device *bridge)
 {
+	struct switchdev_brport_flags flags = {0};
 	struct sparx5 *sparx5 = port->sparx5;
 
 	switchdev_bridge_port_unoffload(port->ndev, NULL, NULL, NULL);
@@ -234,6 +241,11 @@ static void sparx5_port_bridge_leave(struct sparx5_port *port,
 
 	/* Port enters in host more therefore restore mc list */
 	__dev_mc_sync(port->ndev, sparx5_mc_sync, sparx5_mc_unsync);
+
+	/* Disable uc/mc/bc flooding */
+	flags.mask = BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	flags.val = 0;
+	sparx5_port_attr_bridge_flags(port, flags);
 }
 
 static int sparx5_port_changeupper(struct net_device *dev,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
index d42097aa60a0..494782871903 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
@@ -167,16 +167,6 @@ void sparx5_update_fwd(struct sparx5 *sparx5)
 	/* Divide up fwd mask in 32 bit words */
 	bitmap_to_arr32(mask, sparx5->bridge_fwd_mask, SPX5_PORTS);
 
-	/* Update flood masks */
-	for (port = sparx5_get_pgid(sparx5, PGID_UC_FLOOD);
-	     port <= sparx5_get_pgid(sparx5, PGID_BCAST); port++) {
-		spx5_wr(mask[0], sparx5, ANA_AC_PGID_CFG(port));
-		if (is_sparx5(sparx5)) {
-			spx5_wr(mask[1], sparx5, ANA_AC_PGID_CFG1(port));
-			spx5_wr(mask[2], sparx5, ANA_AC_PGID_CFG2(port));
-		}
-	}
-
 	/* Update SRC masks */
 	for (port = 0; port < sparx5->data->consts->n_ports; port++) {
 		if (test_bit(port, sparx5->bridge_fwd_mask)) {

---
base-commit: 07fdad3a93756b872da7b53647715c48d0f4a2d0
change-id: 20251003-fix-flood-fwd-39ef87d6e97c

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


