Return-Path: <netdev+bounces-91001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72A78B0DFE
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9F61C23CEA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFF015FA68;
	Wed, 24 Apr 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+HNzJcy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774F15F41B
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972032; cv=none; b=akk2wLoz+cPwCy/FO3JaYqQPdRXbZrH/DkPDndTesDidK1SsnsSgH1OWvWfwEtqgD1MXNYN5kP0wggb5oiwveS0QZgVXMayXQesE6M6CD/BoF7VDOPpbGCJrzcfI17Ct6PCSIjzz/lBLGj44J4JaHVHysNoZqyYz66Qn2juJknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972032; c=relaxed/simple;
	bh=4yY12hwupKB4FyR2N3ZiXpbIfibLMwIZvGsG14deqFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVsNfbV8Rio5xSulkvNnrSkdjRwWV4Dw06JSFD5JVoG06v2hGaAumj7YNAjwLt/WzALYX9M4f1oqgLGTAAO7xR3FxVpKmI8V8P5XiFGux3xPrTux6sxAhPUjozRFZW3TEyFPjkdXwcmE8Ftxbq5AzS5QLeUqz9aZwXXrTXQPii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+HNzJcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C3AC2BBFC;
	Wed, 24 Apr 2024 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972032;
	bh=4yY12hwupKB4FyR2N3ZiXpbIfibLMwIZvGsG14deqFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G+HNzJcyrrxU7CSda9QjjWI164C/7dQo03jOO9JHW0Pa7I/dp+AXsPJr4ouHbfHZ0
	 n+cjRnyeevgx9rpmbMd7I0C3Or9oJNo+fCAkiFqE9k9zBQCouKCjZfTG744oKMD/Z9
	 FB+vT7PEa5a6ZwpLuGxUbCk65yEs6kvkJIRV4UY5Iptd9ZCg2xkPwD4Zxi2YXyqui8
	 aADVO++kIsUpOqZgDG/irv+xC03Otzt3tpNrM3YrJIVlxFTlEAAuQxDyF4TK+82XcN
	 QJ+5UiDDw2tXnf7IE3QIVAY0RfmTwB2ocUXukqkE5gMp1lZ4JlIn9vMLhmRhQXeecS
	 cMkwqiB7p/jTQ==
From: Simon Horman <horms@kernel.org>
Date: Wed, 24 Apr 2024 16:13:26 +0100
Subject: [PATCH net-next v2 4/4] net: sparx5: Correct spelling in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-lan743x-confirm-v2-4-f0480542e39f@kernel.org>
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
v2
- Use 'extack' in place of 'extact', not 'exact'
  Thanks to Daniel Machon.
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c      | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c    | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c      | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_ag_api.h        | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c           | 4 ++--
 drivers/net/ethernet/microchip/vcap/vcap_api_client.h    | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api_private.h   | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 141897dfe388..1915998f6079 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -143,7 +143,7 @@ static void sparx5_fdma_rx_activate(struct sparx5 *sparx5, struct sparx5_rx *rx)
 
 static void sparx5_fdma_rx_deactivate(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
-	/* Dectivate the RX channel */
+	/* Deactivate the RX channel */
 	spx5_rmw(0, BIT(rx->channel_id) & FDMA_CH_ACTIVATE_CH_ACTIVATE,
 		 sparx5, FDMA_CH_ACTIVATE);
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index ac7e1cffbcec..f3f5fb420468 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -67,7 +67,7 @@ static void sparx5_xtr_grp(struct sparx5 *sparx5, u8 grp, bool byte_swap)
 	for (i = 0; i < IFH_LEN; i++)
 		ifh[i] = spx5_rd(sparx5, QS_XTR_RD(grp));
 
-	/* Decode IFH (whats needed) */
+	/* Decode IFH (what's needed) */
 	sparx5_ifh_parse(ifh, &fi);
 
 	/* Map to port netdev */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 60dd2fd603a8..062e486c002c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -370,7 +370,7 @@ static int sparx5_port_disable(struct sparx5 *sparx5, struct sparx5_port *port,
 	/* 6: Wait while the last frame is exiting the queues */
 	usleep_range(8 * spd_prm, 10 * spd_prm);
 
-	/* 7: Flush the queues accociated with the port->portno */
+	/* 7: Flush the queues associated with the port->portno */
 	spx5_rmw(HSCH_FLUSH_CTRL_FLUSH_PORT_SET(port->portno) |
 		 HSCH_FLUSH_CTRL_FLUSH_DST_SET(1) |
 		 HSCH_FLUSH_CTRL_FLUSH_SRC_SET(1) |
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index 4af85d108a06..0b4abc3eb53d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -190,7 +190,7 @@ static int sparx5_port_bridge_join(struct sparx5_port *port,
 	/* Remove standalone port entry */
 	sparx5_mact_forget(sparx5, ndev->dev_addr, 0);
 
-	/* Port enters in bridge mode therefor don't need to copy to CPU
+	/* Port enters in bridge mode therefore don't need to copy to CPU
 	 * frames for multicast in case the bridge is not requesting them
 	 */
 	__dev_mc_unsync(ndev, sparx5_mc_unsync);
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_ag_api.h b/drivers/net/ethernet/microchip/vcap/vcap_ag_api.h
index c3569a4c7b69..4735fad05708 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_ag_api.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_ag_api.h
@@ -290,7 +290,7 @@ enum vcap_keyfield_set {
  *   Sparx5: TCP flag RST , LAN966x: TCP: TCP flag RST. PTP over UDP: messageType
  *   bit 3
  * VCAP_KF_L4_SEQUENCE_EQ0_IS: W1, sparx5: is2/es2, lan966x: is2
- *   Set if TCP sequence number is 0, LAN966x: Overlayed with PTP over UDP:
+ *   Set if TCP sequence number is 0, LAN966x: Overlaid with PTP over UDP:
  *   messageType bit 0
  * VCAP_KF_L4_SPORT: W16, sparx5: is0/is2/es2, lan966x: is1/is2
  *   TCP/UDP source port
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 80ae5e1708a6..2687765abe52 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -327,7 +327,7 @@ static int vcap_find_keystream_typegroup_sw(struct vcap_control *vctrl,
 }
 
 /* Verify that the typegroup information, subword count, keyset and type id
- * are in sync and correct, return the list of matchin keysets
+ * are in sync and correct, return the list of matching keysets
  */
 int
 vcap_find_keystream_keysets(struct vcap_control *vctrl,
@@ -2943,7 +2943,7 @@ void vcap_netbytes_copy(u8 *dst, u8 *src, int count)
 }
 EXPORT_SYMBOL_GPL(vcap_netbytes_copy);
 
-/* Convert validation error code into tc extact error message */
+/* Convert validation error code into tc extack error message */
 void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule)
 {
 	switch (vrule->exterr) {
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
index 56874f2adbba..cdf79e17ca54 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
@@ -238,7 +238,7 @@ const struct vcap_set *vcap_keyfieldset(struct vcap_control *vctrl,
 /* Copy to host byte order */
 void vcap_netbytes_copy(u8 *dst, u8 *src, int count);
 
-/* Convert validation error code into tc extact error message */
+/* Convert validation error code into tc extack error message */
 void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule);
 
 /* Cleanup a VCAP instance */
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_private.h b/drivers/net/ethernet/microchip/vcap/vcap_api_private.h
index df81d9ff502b..844bdf6b5f45 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_private.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_private.h
@@ -109,7 +109,7 @@ int vcap_addr_keysets(struct vcap_control *vctrl, struct net_device *ndev,
 		      struct vcap_keyset_list *kslist);
 
 /* Verify that the typegroup information, subword count, keyset and type id
- * are in sync and correct, return the list of matchin keysets
+ * are in sync and correct, return the list of matching keysets
  */
 int vcap_find_keystream_keysets(struct vcap_control *vctrl, enum vcap_type vt,
 				u32 *keystream, u32 *mskstream, bool mask,

-- 
2.43.0


