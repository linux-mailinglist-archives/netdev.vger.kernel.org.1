Return-Path: <netdev+bounces-137493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A638B9A6B3F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68061C238C6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5531F470E;
	Mon, 21 Oct 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TeMGy0PM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E081E7C01;
	Mon, 21 Oct 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519160; cv=none; b=OfscfTZ+8wcAHPDtBX/v0l6SLAh2RAEWsf6SYYCmLFirWgNsM9OWf2t4FdRYjwyakw/2mEdvPep/NbzA91jZvH2MbvA5lit7cxw4UYJWnOnikeqmuEURkf2O0EG5ElrSK5Z6V8EujLVTxxpL7yfxFk/DjpV8ep4Qf8AebOGwVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519160; c=relaxed/simple;
	bh=NkPxRxWfAVQiAUbjYg1fwrrGHvCaftzBoyopFC36UcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ivEBA7zipy0xGMJrlx23UaLHElhbXk9NZ7QL8UEIsWabhVgd0IVPlRo14T+WgfTRxGLBjf0nsmB9xH67splEBl+sEyUU4MMg70F9pUMhaM8zXv5BlMCUv3/YyUfEmqN0AkcQ90KR2po0Ic0LcY86TfjdwHiC+8TthWC0tLYqAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TeMGy0PM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519158; x=1761055158;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NkPxRxWfAVQiAUbjYg1fwrrGHvCaftzBoyopFC36UcE=;
  b=TeMGy0PMtML8fWfjEN17y3qShQigbMDWxxzgy7/zNv1wSqEFNkN0qYUn
   xg/XlVqCNmGjfmwskXrNeULgIe1o6GsCvI4ZSHeX9MKYHs2fZFUP2vmy8
   kDFHyBusKxKjCho1dhfoRiTEt8gdn1ArOceuRxGR+8KPQfs3tesr8JphV
   99+HoSKZY3kN78rmNlPVUspG8pKlfIc9Wa3sOPvT+INd5iLlY6tWAG8j8
   5vhWMpmjcA1MX9Ha+FDoy7kTlmRlPIW1WC9ttdo1defT0W/JNnLcdbAgA
   PfIPKp8m+dmEY8kpyhTs9hsYnRzNA8fC4prUJn5n435HCQs0ETPNvS3Uw
   Q==;
X-CSE-ConnectionGUID: Ky42XnPuQxK/Okp36Nw4mA==
X-CSE-MsgGUID: cx9NyoD1QK2xgp86akPsfw==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="200707750"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 06:59:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:10 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:07 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:41 +0200
Subject: [PATCH net-next 04/15] net: sparx5: add sparx5 context pointer to
 a few functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-4-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x, add the sparx5 context pointer to certain
IFH (Internal Frame Header) functions. This is required, as the
is_sparx5() function will be used here in a subsequent patch.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c   |  2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h   | 11 +++++++----
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c |  9 ++++++---
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 13 ++++++++-----
 4 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 88f7509f0980..0027144a2af2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -154,7 +154,7 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
 	skb = rx->skb[fdma->dcb_index][fdma->db_index];
 	skb_put(skb, fdma_db_len_get(db_hw));
 	/* Now do the normal processing of the skb */
-	sparx5_ifh_parse((u32 *)skb->data, &fi);
+	sparx5_ifh_parse(sparx5, (u32 *)skb->data, &fi);
 	/* Map to port netdev */
 	port = fi.src_port < sparx5->data->consts->n_ports ?
 		       sparx5->ports[fi.src_port] :
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 2a3b4e855590..15f5d38776c4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -401,7 +401,7 @@ struct frame_info {
 };
 
 void sparx5_xtr_flush(struct sparx5 *sparx5, u8 grp);
-void sparx5_ifh_parse(u32 *ifh, struct frame_info *info);
+void sparx5_ifh_parse(struct sparx5 *sparx5, u32 *ifh, struct frame_info *info);
 irqreturn_t sparx5_xtr_handler(int irq, void *_priv);
 netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev);
 int sparx5_manual_injection_mode(struct sparx5 *sparx5);
@@ -469,10 +469,13 @@ static inline int sparx5_dcb_init(struct sparx5 *sparx5)
 #endif
 
 /* sparx5_netdev.c */
-void sparx5_set_port_ifh_timestamp(void *ifh_hdr, u64 timestamp);
+void sparx5_set_port_ifh_timestamp(struct sparx5 *sparx5, void *ifh_hdr,
+				   u64 timestamp);
 void sparx5_set_port_ifh_rew_op(void *ifh_hdr, u32 rew_op);
-void sparx5_set_port_ifh_pdu_type(void *ifh_hdr, u32 pdu_type);
-void sparx5_set_port_ifh_pdu_w16_offset(void *ifh_hdr, u32 pdu_w16_offset);
+void sparx5_set_port_ifh_pdu_type(struct sparx5 *sparx5, void *ifh_hdr,
+				  u32 pdu_type);
+void sparx5_set_port_ifh_pdu_w16_offset(struct sparx5 *sparx5, void *ifh_hdr,
+					u32 pdu_w16_offset);
 void sparx5_set_port_ifh(struct sparx5 *sparx5, void *ifh_hdr, u16 portno);
 bool sparx5_netdevice_check(const struct net_device *dev);
 struct net_device *sparx5_create_netdev(struct sparx5 *sparx5, u32 portno);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index d4e9986ef16a..a94d9a540bd3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -81,17 +81,20 @@ void sparx5_set_port_ifh_rew_op(void *ifh_hdr, u32 rew_op)
 	ifh_encode_bitfield(ifh_hdr, rew_op, VSTAX + 32,  10);
 }
 
-void sparx5_set_port_ifh_pdu_type(void *ifh_hdr, u32 pdu_type)
+void sparx5_set_port_ifh_pdu_type(struct sparx5 *sparx5, void *ifh_hdr,
+				  u32 pdu_type)
 {
 	ifh_encode_bitfield(ifh_hdr, pdu_type, 191, 4);
 }
 
-void sparx5_set_port_ifh_pdu_w16_offset(void *ifh_hdr, u32 pdu_w16_offset)
+void sparx5_set_port_ifh_pdu_w16_offset(struct sparx5 *sparx5, void *ifh_hdr,
+					u32 pdu_w16_offset)
 {
 	ifh_encode_bitfield(ifh_hdr, pdu_w16_offset, 195, 6);
 }
 
-void sparx5_set_port_ifh_timestamp(void *ifh_hdr, u64 timestamp)
+void sparx5_set_port_ifh_timestamp(struct sparx5 *sparx5, void *ifh_hdr,
+				   u64 timestamp)
 {
 	ifh_encode_bitfield(ifh_hdr, timestamp, 232,  40);
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index 5bfa86a71ac8..57fa9ff9dfce 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -32,7 +32,7 @@ void sparx5_xtr_flush(struct sparx5 *sparx5, u8 grp)
 	spx5_wr(0, sparx5, QS_XTR_FLUSH);
 }
 
-void sparx5_ifh_parse(u32 *ifh, struct frame_info *info)
+void sparx5_ifh_parse(struct sparx5 *sparx5, u32 *ifh, struct frame_info *info)
 {
 	u8 *xtr_hdr = (u8 *)ifh;
 
@@ -72,7 +72,7 @@ static void sparx5_xtr_grp(struct sparx5 *sparx5, u8 grp, bool byte_swap)
 		ifh[i] = spx5_rd(sparx5, QS_XTR_RD(grp));
 
 	/* Decode IFH (what's needed) */
-	sparx5_ifh_parse(ifh, &fi);
+	sparx5_ifh_parse(sparx5, ifh, &fi);
 
 	/* Map to port netdev */
 	port = fi.src_port < sparx5->data->consts->n_ports ?
@@ -242,9 +242,12 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 
 		sparx5_set_port_ifh_rew_op(ifh, SPARX5_SKB_CB(skb)->rew_op);
-		sparx5_set_port_ifh_pdu_type(ifh, SPARX5_SKB_CB(skb)->pdu_type);
-		sparx5_set_port_ifh_pdu_w16_offset(ifh, SPARX5_SKB_CB(skb)->pdu_w16_offset);
-		sparx5_set_port_ifh_timestamp(ifh, SPARX5_SKB_CB(skb)->ts_id);
+		sparx5_set_port_ifh_pdu_type(sparx5, ifh,
+					     SPARX5_SKB_CB(skb)->pdu_type);
+		sparx5_set_port_ifh_pdu_w16_offset(sparx5, ifh,
+						   SPARX5_SKB_CB(skb)->pdu_w16_offset);
+		sparx5_set_port_ifh_timestamp(sparx5, ifh,
+					      SPARX5_SKB_CB(skb)->ts_id);
 	}
 
 	skb_tx_timestamp(skb);

-- 
2.34.1


