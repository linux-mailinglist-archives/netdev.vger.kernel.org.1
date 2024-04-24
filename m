Return-Path: <netdev+bounces-90999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDD8B0DFB
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B12B2A51C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761F161308;
	Wed, 24 Apr 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmCcWUxt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1C15F3FA
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972026; cv=none; b=RTIdeXM1fYYlbG3yWmZmiewpuBDYQXXXqutB/ApO9vAMymDF0H+1Bm0X4dvsaGeRGdIbH2Vcr1Zi9BGZvQuRVCiiac8M6cPUZ610fSUgLa0EgdJLzApNvbiU7fxdWxnUv3oRQFNnsSuxRAMT3jkgQl+svblObiaIg/me1V+dkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972026; c=relaxed/simple;
	bh=acPd/YxHJyslb2vlUSl9OkWKpvQBrLC3hvH2lycgiCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3+fKSft9WuDvLOB1P+PJnAalL9+RoDmfOOnD2CXDxu0f0nDWq9EdFlJG7CsCEsTWSzmYgqgdXSj+s83JUtPBH0UcotNd/aY4ikYOUVW4bFIoFpBwXHbly44tNpm/OEm06RNJMisJQ7pL3CqO5kwk83liq670Yu6poXQiqyX7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmCcWUxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B630C4AF0A;
	Wed, 24 Apr 2024 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972025;
	bh=acPd/YxHJyslb2vlUSl9OkWKpvQBrLC3hvH2lycgiCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DmCcWUxtT8RRYTZP2WOJg+X+afnboCGYgeVAumEngbe0qpFKxZBOQOY5SqXkaP40U
	 M92eyJF+Qum6r3zsR157RSsZJpfYl9FQBLiDJsCGOfvLo0VSB0+UXcTRYtyISnXLJJ
	 JV79P5IiyQ70gIRnL1UK4CV1r/pgwT06My40YpKgP9PZ7KY53NAquREh0mkp+Tn2zj
	 1Jn/6YhRnPvccKFUhXGdc+rT2JxYuh5xEs9lB4E5OtKioNTwsW3e7NeHqHlBte6GJ2
	 sI9pAYpZGgXa/DoXCib+1+drj6QoSxW6jHR/ouvYvH3oLVqN0r6FibwKnneX77k5f2
	 bhf71u5bd6I/A==
From: Simon Horman <horms@kernel.org>
Date: Wed, 24 Apr 2024 16:13:24 +0100
Subject: [PATCH net-next v2 2/4] net: lan966x: Correct spelling in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-lan743x-confirm-v2-2-f0480542e39f@kernel.org>
References: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
In-Reply-To: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.12.3

Correct spelling in comments, as flagged by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ifh.h  | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 4 ++--
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_port.c | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ifh.h b/drivers/net/ethernet/microchip/lan966x/lan966x_ifh.h
index f3b1e0d31826..e706163ce9cc 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ifh.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ifh.h
@@ -78,7 +78,7 @@
 /* Classified internal priority for queuing */
 #define IFH_POS_QOS_CLASS            100
 
-/* Bit mask with eight cpu copy classses */
+/* Bit mask with eight cpu copy classes */
 #define IFH_POS_CPUQ                 92
 
 /* Relearn + learn flags (*) */
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 2635ef8958c8..b7e75da65834 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -276,7 +276,7 @@ static int lan966x_port_ifh_xmit(struct sk_buff *skb,
 		++i;
 	}
 
-	/* Inidcate EOF and valid bytes in the last word */
+	/* Indicate EOF and valid bytes in the last word */
 	lan_wr(QS_INJ_CTRL_GAP_SIZE_SET(1) |
 	       QS_INJ_CTRL_VLD_BYTES_SET(skb->len < LAN966X_BUFFER_MIN_SZ ?
 				     0 : last) |
@@ -520,7 +520,7 @@ bool lan966x_hw_offload(struct lan966x *lan966x, u32 port, struct sk_buff *skb)
 	u32 val;
 
 	/* The IGMP and MLD frames are not forward by the HW if
-	 * multicast snooping is enabled, therefor don't mark as
+	 * multicast snooping is enabled, therefore don't mark as
 	 * offload to allow the SW to forward the frames accordingly.
 	 */
 	val = lan_rd(lan966x, ANA_CPU_FWD_CFG(port));
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index caa9e0533c96..f8bebbcf77b2 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -326,7 +326,7 @@ struct lan966x {
 
 	u8 base_mac[ETH_ALEN];
 
-	spinlock_t tx_lock; /* lock for frame transmition */
+	spinlock_t tx_lock; /* lock for frame transmission */
 
 	struct net_device *bridge;
 	u16 bridge_mask;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
index 2e83bbb9477e..fdfa4040d9ee 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
@@ -88,7 +88,7 @@ static void lan966x_port_link_down(struct lan966x_port *port)
 		SYS_FRONT_PORT_MODE_HDX_MODE,
 		lan966x, SYS_FRONT_PORT_MODE(port->chip_port));
 
-	/* 8: Flush the queues accociated with the port */
+	/* 8: Flush the queues associated with the port */
 	lan_rmw(QSYS_SW_PORT_MODE_AGING_MODE_SET(3),
 		QSYS_SW_PORT_MODE_AGING_MODE,
 		lan966x, QSYS_SW_PORT_MODE(port->chip_port));
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
index 3c44660128da..fa34a739c748 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
@@ -157,7 +157,7 @@ void lan966x_vlan_port_apply(struct lan966x_port *port)
 
 	pvid = lan966x_vlan_port_get_pvid(port);
 
-	/* Ingress clasification (ANA_PORT_VLAN_CFG) */
+	/* Ingress classification (ANA_PORT_VLAN_CFG) */
 	/* Default vlan to classify for untagged frames (may be zero) */
 	val = ANA_VLAN_CFG_VLAN_VID_SET(pvid);
 	if (port->vlan_aware)

-- 
2.43.0


