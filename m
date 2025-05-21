Return-Path: <netdev+bounces-192296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AABCABF495
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614AA4E0BA7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133EE266592;
	Wed, 21 May 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WR4fOisG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D6266562;
	Wed, 21 May 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831448; cv=none; b=fXSXjOLco4fczYCGJ+eu9T+JhrU1WTsH3QQDQ6vEq56vRvrYnqmUYv/ujvbk6rzwbjQ7t/gdCBEgnR0ejjfeSSzS7rqp/Y9+h6fNYugllJ10l17BfnxpIycsUaMpIg/BJXx8MOCqUI4fD/rvkJPE5ELl/u6t1HYN6yFxIU0FUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831448; c=relaxed/simple;
	bh=tbVvEWwUPQ0G7AjWNLe9xc646p0TUIopt3jZzBbJx40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ggJmG24pjj2150BcB64DPZ2/HVJIXcBf8+AHfN9km8588vLq+v2LWlQTBY07RmxcJJEtoqCLjSrHRBNFdes3d3uZgkpRAel7zUnL/EOh3W5W3ITI6p8/F6CEraWvhsG2gsAD6auCwb18YE1qmVtnR/n/92MJAd8yikluyT3777A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WR4fOisG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747831446; x=1779367446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tbVvEWwUPQ0G7AjWNLe9xc646p0TUIopt3jZzBbJx40=;
  b=WR4fOisGQxeCgVjMYDZsY6THhdgi90aAcDykXABgaViR6j88DSjb4gaS
   M4BuzLKKJrJUr1J0cwRYvE632N2DRWSAX0HszTm9tl9iM4kyL0VHcy2m5
   k7RZoM1dPeSqmTKA/kLsgEJRaTCWCFg2GJ8EDI4lqo5lOIyYk3RHUo5O0
   70GxmLxYDETa5MD/7RoWfF6fPKzpBEvdKl3Y5mLHbujTDixHTdTSWASC7
   bbWwqwUrKbojfZ/ACS1u3E4tcatV/f3wmAwZyrchu2/624AamuxxuFWC1
   qh+t1vGMhZuHuzKDcratISmg1Tw/RuCgY9aopNaf1G7Ge6GDK6CVz2orI
   A==;
X-CSE-ConnectionGUID: 8vLVWBVUQ369tMbve2m25Q==
X-CSE-MsgGUID: l5aKfXWFRLywCIoNkSfgew==
X-IronPort-AV: E=Sophos;i="6.15,303,1739862000"; 
   d="scan'208";a="41899942"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2025 05:44:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 21 May 2025 05:43:41 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 21 May 2025 05:43:39 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: lan966x: Fix 1-step timestamping over ipv4 or ipv6
Date: Wed, 21 May 2025 14:41:59 +0200
Message-ID: <20250521124159.2713525-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When enabling 1-step timestamping for ptp frames that are over udpv4 or
udpv6 then the inserted timestamp is added at the wrong offset in the
frame, meaning that will modify the frame at the wrong place, so the
frame will be malformed.
To fix this, the HW needs to know which kind of frame it is to know
where to insert the timestamp. For that there is a field in the IFH that
says the PDU_TYPE, which can be NONE  which is the default value,
IPV4 or IPV6. Therefore make sure to set the PDU_TYPE so the HW knows
where to insert the timestamp.
Like I mention before the issue is not seen with L2 frames because by
default the PDU_TYPE has a value of 0, which represents the L2 frames.

Fixes: 77eecf25bd9d2f ("net: lan966x: Update extraction/injection for timestamping")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../ethernet/microchip/lan966x/lan966x_main.c |  6 +++
 .../ethernet/microchip/lan966x/lan966x_main.h |  5 ++
 .../ethernet/microchip/lan966x/lan966x_ptp.c  | 49 ++++++++++++++-----
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 0af143ec0f869..427bdc0e4908c 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -353,6 +353,11 @@ static void lan966x_ifh_set_rew_op(void *ifh, u64 rew_op)
 	lan966x_ifh_set(ifh, rew_op, IFH_POS_REW_CMD, IFH_WID_REW_CMD);
 }
 
+static void lan966x_ifh_set_oam_type(void *ifh, u64 oam_type)
+{
+	lan966x_ifh_set(ifh, oam_type, IFH_POS_PDU_TYPE, IFH_WID_PDU_TYPE);
+}
+
 static void lan966x_ifh_set_timestamp(void *ifh, u64 timestamp)
 {
 	lan966x_ifh_set(ifh, timestamp, IFH_POS_TIMESTAMP, IFH_WID_TIMESTAMP);
@@ -380,6 +385,7 @@ static netdev_tx_t lan966x_port_xmit(struct sk_buff *skb,
 			return err;
 
 		lan966x_ifh_set_rew_op(ifh, LAN966X_SKB_CB(skb)->rew_op);
+		lan966x_ifh_set_oam_type(ifh, LAN966X_SKB_CB(skb)->pdu_type);
 		lan966x_ifh_set_timestamp(ifh, LAN966X_SKB_CB(skb)->ts_id);
 	}
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 1efa584e71077..1f9df67f05044 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -75,6 +75,10 @@
 #define IFH_REW_OP_ONE_STEP_PTP		0x3
 #define IFH_REW_OP_TWO_STEP_PTP		0x4
 
+#define IFH_PDU_TYPE_NONE		0
+#define IFH_PDU_TYPE_IPV4		7
+#define IFH_PDU_TYPE_IPV6		8
+
 #define FDMA_RX_DCB_MAX_DBS		1
 #define FDMA_TX_DCB_MAX_DBS		1
 
@@ -254,6 +258,7 @@ struct lan966x_phc {
 
 struct lan966x_skb_cb {
 	u8 rew_op;
+	u8 pdu_type;
 	u16 ts_id;
 	unsigned long jiffies;
 };
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 63905bb5a63a8..87e5e81d40dc6 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -322,34 +322,55 @@ void lan966x_ptp_hwtstamp_get(struct lan966x_port *port,
 	*cfg = phc->hwtstamp_config;
 }
 
-static int lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb)
+static void lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb,
+				 u8 *rew_op, u8 *pdu_type)
 {
 	struct ptp_header *header;
 	u8 msgtype;
 	int type;
 
-	if (port->ptp_tx_cmd == IFH_REW_OP_NOOP)
-		return IFH_REW_OP_NOOP;
+	if (port->ptp_tx_cmd == IFH_REW_OP_NOOP) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
 	type = ptp_classify_raw(skb);
-	if (type == PTP_CLASS_NONE)
-		return IFH_REW_OP_NOOP;
+	if (type == PTP_CLASS_NONE) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
 	header = ptp_parse_header(skb, type);
-	if (!header)
-		return IFH_REW_OP_NOOP;
+	if (!header) {
+		*rew_op = IFH_REW_OP_NOOP;
+		*pdu_type = IFH_PDU_TYPE_NONE;
+		return;
+	}
 
-	if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP)
-		return IFH_REW_OP_TWO_STEP_PTP;
+	if (type & PTP_CLASS_L2)
+		*pdu_type = IFH_PDU_TYPE_NONE;
+	if (type & PTP_CLASS_IPV4)
+		*pdu_type = IFH_PDU_TYPE_IPV4;
+	if (type & PTP_CLASS_IPV6)
+		*pdu_type = IFH_PDU_TYPE_IPV6;
+
+	if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP) {
+		*rew_op = IFH_REW_OP_TWO_STEP_PTP;
+		return;
+	}
 
 	/* If it is sync and run 1 step then set the correct operation,
 	 * otherwise run as 2 step
 	 */
 	msgtype = ptp_get_msgtype(header, type);
-	if ((msgtype & 0xf) == 0)
-		return IFH_REW_OP_ONE_STEP_PTP;
+	if ((msgtype & 0xf) == 0) {
+		*rew_op = IFH_REW_OP_ONE_STEP_PTP;
+		return;
+	}
 
-	return IFH_REW_OP_TWO_STEP_PTP;
+	*rew_op = IFH_REW_OP_TWO_STEP_PTP;
 }
 
 static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
@@ -374,10 +395,12 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
 {
 	struct lan966x *lan966x = port->lan966x;
 	unsigned long flags;
+	u8 pdu_type;
 	u8 rew_op;
 
-	rew_op = lan966x_ptp_classify(port, skb);
+	lan966x_ptp_classify(port, skb, &rew_op, &pdu_type);
 	LAN966X_SKB_CB(skb)->rew_op = rew_op;
+	LAN966X_SKB_CB(skb)->pdu_type = pdu_type;
 
 	if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
 		return 0;
-- 
2.34.1


