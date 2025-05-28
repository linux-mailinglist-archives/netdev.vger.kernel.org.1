Return-Path: <netdev+bounces-193935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1554FAC6621
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 11:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7023A97CF
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502192777FE;
	Wed, 28 May 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HvUQP+Gj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6AB1EB193;
	Wed, 28 May 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425162; cv=none; b=MK2aFRUUqX46Zw8MhD8Lq1x7siLQJmffZ5F5UQQw083W3Qpx+EUCONc8S2q8kC4FKOmLSgSeYCybEcsgqv5idMcSDZYT+xeZ34Rx4iGuKhLd4DwsEQQb44VSg2GQuzHAHhFuD4tC4rKD1/MIeUtx4kraP7mCr7dnVYkBOG9TMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425162; c=relaxed/simple;
	bh=6LD09DYS/0kYn1kkjqpbETm1/pEymJDs2xvRz8uJ0/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QpeDIRFezXOyZwk00QpIIBPLW4U57nr+VTHmE7XLTQ2a0YHJ3ATZiKsGu8YPwTHh8HhhhB5MHedeaFNgUYXgvjATUEWd1h9ekDgbYQcwAxB4B6LmAEmK4tanbvpAY2aIECEAhwcdsQ2E6pVmoLsSBgBrAuHERhf8UhizOjgQnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HvUQP+Gj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748425161; x=1779961161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6LD09DYS/0kYn1kkjqpbETm1/pEymJDs2xvRz8uJ0/A=;
  b=HvUQP+GjjGMx3X0dHUqSSFTW0231s8ofvj/IrHl3hgv6T7fuQ1WTsznM
   ie/qCBZ3vPK0/FlnXOTwcVEn/g2D3LrwdSCrztmBQa5JzwpT9fDgNEqHp
   1xiyUTMBkeP1KCkzfe8wcqhGU0Ozg9uJBAYQd+QlD/gcxu4HISAuU7M5Q
   invkOJLcwGftd2mczMHZkyz4y+fuq0ChRN2OBcs7MxK0BNtMgPgEM5Vxx
   h8DtYSeJgYC7xKlURw7so/5BkOJim1adiD9eXcev5u7CC4opXgzezlSf3
   NSmTmgxMY6yMEsnLugNlJfqBmw/63NtinR4ViXowYqhL/CqiUaG37B+WG
   g==;
X-CSE-ConnectionGUID: 7lF291wvQn+FgAjIRLT7Iw==
X-CSE-MsgGUID: wkNj7d69SDqxvKOXLpOy7A==
X-IronPort-AV: E=Sophos;i="6.15,320,1739862000"; 
   d="scan'208";a="42157104"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2025 02:39:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 28 May 2025 02:38:34 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 28 May 2025 02:38:32 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
Subject: [PATCH net v2] net: lan966x: Make sure to insert the vlan tags also in host mode
Date: Wed, 28 May 2025 11:36:19 +0200
Message-ID: <20250528093619.3738998-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When running these commands on DUT (and similar at the other end)
ip link set dev eth0 up
ip link add link eth0 name eth0.10 type vlan id 10
ip addr add 10.0.0.1/24 dev eth0.10
ip link set dev eth0.10 up
ping 10.0.0.2

The ping will fail.

The reason why is failing is because, the network interfaces for lan966x
have a flag saying that the HW can insert the vlan tags into the
frames(NETIF_F_HW_VLAN_CTAG_TX). Meaning that the frames that are
transmitted don't have the vlan tag inside the skb data, but they have
it inside the skb. We already get that vlan tag and put it in the IFH
but the problem is that we don't configure the HW to rewrite the frame
when the interface is in host mode.
The fix consists in actually configuring the HW to insert the vlan tag
if it is different than 0.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Fixes: 6d2c186afa5d ("net: lan966x: Add vlan support.")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v1->v2:
- fix typos
- set REW_TAG_CFG_TAG_CFG_SET to a value of 2 to match the comments
---
 .../ethernet/microchip/lan966x/lan966x_main.c |  1 +
 .../ethernet/microchip/lan966x/lan966x_main.h |  1 +
 .../microchip/lan966x/lan966x_switchdev.c     |  1 +
 .../ethernet/microchip/lan966x/lan966x_vlan.c | 21 +++++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 427bdc0e4908c..7001584f1b7a6 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -879,6 +879,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 	lan966x_vlan_port_set_vlan_aware(port, 0);
 	lan966x_vlan_port_set_vid(port, HOST_PVID, false, false);
 	lan966x_vlan_port_apply(port);
+	lan966x_vlan_port_rew_host(port);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 1f9df67f05044..4f75f06883693 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -497,6 +497,7 @@ void lan966x_vlan_port_apply(struct lan966x_port *port);
 bool lan966x_vlan_cpu_member_cpu_vlan_mask(struct lan966x *lan966x, u16 vid);
 void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
 				      bool vlan_aware);
+void lan966x_vlan_port_rew_host(struct lan966x_port *port);
 int lan966x_vlan_port_set_vid(struct lan966x_port *port,
 			      u16 vid,
 			      bool pvid,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c b/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
index 1c88120eb291a..bcb4db76b75cd 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
@@ -297,6 +297,7 @@ static void lan966x_port_bridge_leave(struct lan966x_port *port,
 	lan966x_vlan_port_set_vlan_aware(port, false);
 	lan966x_vlan_port_set_vid(port, HOST_PVID, false, false);
 	lan966x_vlan_port_apply(port);
+	lan966x_vlan_port_rew_host(port);
 }
 
 int lan966x_port_changeupper(struct net_device *dev,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
index fa34a739c748e..7da22520724ce 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
@@ -149,6 +149,27 @@ void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
 	port->vlan_aware = vlan_aware;
 }
 
+/* When the interface is in host mode, the interface should not be vlan aware
+ * but it should insert all the tags that it gets from the network stack.
+ * The tags are not in the data of the frame but actually in the skb and the ifh
+ * is configured already to get this tag. So what we need to do is to update the
+ * rewriter to insert the vlan tag for all frames which have a vlan tag
+ * different than 0.
+ */
+void lan966x_vlan_port_rew_host(struct lan966x_port *port)
+{
+	struct lan966x *lan966x = port->lan966x;
+	u32 val;
+
+	/* Tag all frames except when VID=0*/
+	val = REW_TAG_CFG_TAG_CFG_SET(2);
+
+	/* Update only some bits in the register */
+	lan_rmw(val,
+		REW_TAG_CFG_TAG_CFG,
+		lan966x, REW_TAG_CFG(port->chip_port));
+}
+
 void lan966x_vlan_port_apply(struct lan966x_port *port)
 {
 	struct lan966x *lan966x = port->lan966x;
-- 
2.34.1


