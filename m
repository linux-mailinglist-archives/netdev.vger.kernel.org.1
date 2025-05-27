Return-Path: <netdev+bounces-193574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8957AC4913
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94728189189F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C11D6DDD;
	Tue, 27 May 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rclJDp+J"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87408A927;
	Tue, 27 May 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330008; cv=none; b=MpIkKDafAaMfPEawl419FxOQOfgCpcRUoVx2khj+F6UCjIHYXN1Wz7jx64at62W9dtfF0/e17weZa7M2tEk9g2bqcpMgNT8mW8xctahy5APiWdgboWsHuxFoQOAfBFWw3GG87Mah7q6UTkrtmScbSYn1hKldTz4PFSzM50RpN0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330008; c=relaxed/simple;
	bh=TNjh/wuX5iT/K8itYz4k8cQk43YjRqP9QbGeqWfxOqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iDE7Fsk8/d/WNpyYJWFhOl5arJhj4ztAjEnBc1VQxlCI6cxLQmZLdF3hdZFwxNRQJ9ZJmQiqtOsuElmhIawWSc3YFa1IE26Jnd9DtGp3SSARgKdsu93ikj1rwR59hEqwGttGf34OLXd2CYpnuEczBPHRBpo0DEwYPwEAK2+qQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rclJDp+J; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748330007; x=1779866007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TNjh/wuX5iT/K8itYz4k8cQk43YjRqP9QbGeqWfxOqs=;
  b=rclJDp+J92ES0aKAS7FWCAznuc85TD8xq8nJQ9rGtVmBO8ZddtiKEs8N
   4npbgTxiVgbyG91UwpGxNgDXE+1pB5WplF6syr1UnztegG8gs//GLz02c
   xLf+//8OPCSUENmL7dgj7pLJQZ5ev2Lx5x7B5/NwDAp0hj7huE4/rzW5y
   MLa25QGe0EDCjKBUuGvGG3QcIXpSB7Z9pfiQ9nXaHbh/T78iWerJhCaIb
   spuUKarM90kq7TMg967Fr2sX2HbUqOLpAfzcTTug3uJpAjHX73THXr1Wg
   s0LJY2EfM+54pEaxoeRkwOa6rWdpLSZoKDQVxH9yUSlusqVcAEQE9rV5X
   g==;
X-CSE-ConnectionGUID: 1ZW92RbUSnGn2JVxkn6AyA==
X-CSE-MsgGUID: G21TlYkQSkmY8JgtFPgYoQ==
X-IronPort-AV: E=Sophos;i="6.15,317,1739862000"; 
   d="scan'208";a="273468961"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2025 00:13:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 27 May 2025 00:13:07 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 27 May 2025 00:13:05 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] net: lan966x: Make sure to insert the vlan tags also in host mode
Date: Tue, 27 May 2025 09:08:50 +0200
Message-ID: <20250527070850.3504582-1-horatiu.vultur@microchip.com>
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
ping 10.0.0.2/24

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

Fixes: 6d2c186afa5d ("net: lan966x: Add vlan support.")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
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
index fa34a739c748e..f158ec6ab10cc 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
@@ -149,6 +149,27 @@ void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
 	port->vlan_aware = vlan_aware;
 }
 
+/* When the interface is in host mode, the interface should not be vlan aware
+ * but it should insert all the tags that it gets from the network stack.
+ * The tags are no in the data of the frame but actually in the skb and the ifh
+ * is confiured already to get this tag. So what we need to do is to update the
+ * rewriter to insert the vlan tag for all frames which have a vlan tag
+ * different than 0.
+ */
+void lan966x_vlan_port_rew_host(struct lan966x_port *port)
+{
+	struct lan966x *lan966x = port->lan966x;
+	u32 val;
+
+	/* Tag all frames except when VID == DEFAULT_VLAN */
+	val = REW_TAG_CFG_TAG_CFG_SET(1);
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


