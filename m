Return-Path: <netdev+bounces-230668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F526BECC5D
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 11:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10F61A65369
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0DB287253;
	Sat, 18 Oct 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVsRlwoo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C6285CB9
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779325; cv=none; b=oodI6BhUkR+TY5NSFJqDYMRNmKFHM0Fuq5WPzOcT6TnocyLRlEvnpGUAqQYV9grbrGydNXoMKmdMOy7m/Gg8puBEB3w8zrIEmYCP0vgAa0iFllWf6ERJ/ULqC/ScgMgQJd8PMAljiKT07MpoqjAislc2vmVUtNKqmgNQY5P4Ab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779325; c=relaxed/simple;
	bh=QQSf2fBH1I4j49Rjfw8dWqqBHqMePF2agU/OEK725YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SMfOs/rz+1qOrwbaHXBSG/DMCyrFxtGDu8//iITG/xwh+eyQ8qr1y3Z2MdhPnYGHLAH6KyOR9oQT9C4uwE0tJuoponFszcp4EgbWLkyDZF0BtPRYZn3HjA8JlPtA7WGjiIE63UZWRolauR7WiqG3hJtIcYG4HulM+4+HOibHSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVsRlwoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD9C4CEF8;
	Sat, 18 Oct 2025 09:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760779325;
	bh=QQSf2fBH1I4j49Rjfw8dWqqBHqMePF2agU/OEK725YA=;
	h=From:Date:Subject:To:Cc:From;
	b=sVsRlwoo0wkMDAUzAZQgO5UNCIihquJ2tR3nf0sUHU/JR6lZtjiQ69TceRLnogk6D
	 LCL01WbnwqqBu502Bug4WLc+kFFyagg2PcS+OYzhHpI6vWlqW41jdD6zNbXRjSSx37
	 tg2vdN1NrQYSmJwjONIZcwdp/05wMpdPmBZ0ORgle+SHEOc0cVTXx07rqLNAqrgKsh
	 HZGhKe/d/4EU3L0Cl8p+TYOH2wJaXLK8uZoCc2gKZ4TGmTXdcLSJx1OLjzumPdS6zG
	 zVf7TT9feFcPtP0Px0gDD0j+EkObEU5RXMjBVo1C9WqLtUxcQQ0LwjrLnBsH70CB/b
	 BVxT6lvZkggqg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 18 Oct 2025 11:21:47 +0200
Subject: [PATCH net-next] net: airoha: Remove code duplication in
 airoha_regs.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-airoha-regs-cosmetics-v1-1-bbf6295c45fd@kernel.org>
X-B4-Tracking: v=1; b=H4sIACpc82gC/x3MQQqDMBBG4avIrB1IpKnVq0gXIf7VWdTIjIggu
 XtDl9/ivZsMKjAam5sUp5jkrcK3DaU1bgtY5mrqXBe88z1H0bxGVizGKdsXhyTj8MDgXEAfXk+
 q7a74yPX/Tu9SfmxsqmdnAAAA
X-Change-ID: 20251017-airoha-regs-cosmetics-54e9005e7586
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

This patch does not introduce any logical change, it just removes
duplicated code in airoha_regs.h.
Fix naming conventions in airoha_regs.h.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 102 ++++++++++++++--------------
 drivers/net/ethernet/airoha/airoha_regs.h | 109 ++++++++++++++----------------
 2 files changed, 100 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5825f6f29a92e8fff0596d7883a4c2648432a6ef..b06cab4ef25abb1f61915f84142835f30c15ce8f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -137,11 +137,11 @@ static void airoha_fe_maccr_init(struct airoha_eth *eth)
 
 	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++)
 		airoha_fe_set(eth, REG_GDM_FWD_CFG(p),
-			      GDM_TCP_CKSUM | GDM_UDP_CKSUM | GDM_IP4_CKSUM |
-			      GDM_DROP_CRC_ERR);
+			      GDM_TCP_CKSUM_MASK | GDM_UDP_CKSUM_MASK |
+			      GDM_IP4_CKSUM_MASK | GDM_DROP_CRC_ERR_MASK);
 
-	airoha_fe_rmw(eth, REG_CDM1_VLAN_CTRL, CDM1_VLAN_MASK,
-		      FIELD_PREP(CDM1_VLAN_MASK, 0x8100));
+	airoha_fe_rmw(eth, REG_CDM_VLAN_CTRL(1), CDM_VLAN_MASK,
+		      FIELD_PREP(CDM_VLAN_MASK, 0x8100));
 
 	airoha_fe_set(eth, REG_FE_CPORT_CFG, FE_CPORT_PAD);
 }
@@ -396,46 +396,46 @@ static int airoha_fe_mc_vlan_clear(struct airoha_eth *eth)
 static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
 {
 	/* CDM1_CRSN_QSEL */
-	airoha_fe_rmw(eth, REG_CDM1_CRSN_QSEL(CRSN_22 >> 2),
-		      CDM1_CRSN_QSEL_REASON_MASK(CRSN_22),
-		      FIELD_PREP(CDM1_CRSN_QSEL_REASON_MASK(CRSN_22),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(1, CRSN_22 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_22),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_22),
 				 CDM_CRSN_QSEL_Q1));
-	airoha_fe_rmw(eth, REG_CDM1_CRSN_QSEL(CRSN_08 >> 2),
-		      CDM1_CRSN_QSEL_REASON_MASK(CRSN_08),
-		      FIELD_PREP(CDM1_CRSN_QSEL_REASON_MASK(CRSN_08),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(1, CRSN_08 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_08),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_08),
 				 CDM_CRSN_QSEL_Q1));
-	airoha_fe_rmw(eth, REG_CDM1_CRSN_QSEL(CRSN_21 >> 2),
-		      CDM1_CRSN_QSEL_REASON_MASK(CRSN_21),
-		      FIELD_PREP(CDM1_CRSN_QSEL_REASON_MASK(CRSN_21),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(1, CRSN_21 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_21),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_21),
 				 CDM_CRSN_QSEL_Q1));
-	airoha_fe_rmw(eth, REG_CDM1_CRSN_QSEL(CRSN_24 >> 2),
-		      CDM1_CRSN_QSEL_REASON_MASK(CRSN_24),
-		      FIELD_PREP(CDM1_CRSN_QSEL_REASON_MASK(CRSN_24),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(1, CRSN_24 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_24),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_24),
 				 CDM_CRSN_QSEL_Q6));
-	airoha_fe_rmw(eth, REG_CDM1_CRSN_QSEL(CRSN_25 >> 2),
-		      CDM1_CRSN_QSEL_REASON_MASK(CRSN_25),
-		      FIELD_PREP(CDM1_CRSN_QSEL_REASON_MASK(CRSN_25),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(1, CRSN_25 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_25),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_25),
 				 CDM_CRSN_QSEL_Q1));
 	/* CDM2_CRSN_QSEL */
-	airoha_fe_rmw(eth, REG_CDM2_CRSN_QSEL(CRSN_08 >> 2),
-		      CDM2_CRSN_QSEL_REASON_MASK(CRSN_08),
-		      FIELD_PREP(CDM2_CRSN_QSEL_REASON_MASK(CRSN_08),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(2, CRSN_08 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_08),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_08),
 				 CDM_CRSN_QSEL_Q1));
-	airoha_fe_rmw(eth, REG_CDM2_CRSN_QSEL(CRSN_21 >> 2),
-		      CDM2_CRSN_QSEL_REASON_MASK(CRSN_21),
-		      FIELD_PREP(CDM2_CRSN_QSEL_REASON_MASK(CRSN_21),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(2, CRSN_21 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_21),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_21),
 				 CDM_CRSN_QSEL_Q1));
-	airoha_fe_rmw(eth, REG_CDM2_CRSN_QSEL(CRSN_22 >> 2),
-		      CDM2_CRSN_QSEL_REASON_MASK(CRSN_22),
-		      FIELD_PREP(CDM2_CRSN_QSEL_REASON_MASK(CRSN_22),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(2, CRSN_22 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_22),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_22),
 				 CDM_CRSN_QSEL_Q1));
-	airoha_fe_rmw(eth, REG_CDM2_CRSN_QSEL(CRSN_24 >> 2),
-		      CDM2_CRSN_QSEL_REASON_MASK(CRSN_24),
-		      FIELD_PREP(CDM2_CRSN_QSEL_REASON_MASK(CRSN_24),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(2, CRSN_24 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_24),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_24),
 				 CDM_CRSN_QSEL_Q6));
-	airoha_fe_rmw(eth, REG_CDM2_CRSN_QSEL(CRSN_25 >> 2),
-		      CDM2_CRSN_QSEL_REASON_MASK(CRSN_25),
-		      FIELD_PREP(CDM2_CRSN_QSEL_REASON_MASK(CRSN_25),
+	airoha_fe_rmw(eth, REG_CDM_CRSN_QSEL(2, CRSN_25 >> 2),
+		      CDM_CRSN_QSEL_REASON_MASK(CRSN_25),
+		      FIELD_PREP(CDM_CRSN_QSEL_REASON_MASK(CRSN_25),
 				 CDM_CRSN_QSEL_Q1));
 }
 
@@ -455,18 +455,18 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	airoha_fe_wr(eth, REG_FE_PCE_CFG,
 		     PCE_DPI_EN_MASK | PCE_KA_EN_MASK | PCE_MC_EN_MASK);
 	/* set vip queue selection to ring 1 */
-	airoha_fe_rmw(eth, REG_CDM1_FWD_CFG, CDM1_VIP_QSEL_MASK,
-		      FIELD_PREP(CDM1_VIP_QSEL_MASK, 0x4));
-	airoha_fe_rmw(eth, REG_CDM2_FWD_CFG, CDM2_VIP_QSEL_MASK,
-		      FIELD_PREP(CDM2_VIP_QSEL_MASK, 0x4));
+	airoha_fe_rmw(eth, REG_CDM_FWD_CFG(1), CDM_VIP_QSEL_MASK,
+		      FIELD_PREP(CDM_VIP_QSEL_MASK, 0x4));
+	airoha_fe_rmw(eth, REG_CDM_FWD_CFG(2), CDM_VIP_QSEL_MASK,
+		      FIELD_PREP(CDM_VIP_QSEL_MASK, 0x4));
 	/* set GDM4 source interface offset to 8 */
-	airoha_fe_rmw(eth, REG_GDM4_SRC_PORT_SET,
-		      GDM4_SPORT_OFF2_MASK |
-		      GDM4_SPORT_OFF1_MASK |
-		      GDM4_SPORT_OFF0_MASK,
-		      FIELD_PREP(GDM4_SPORT_OFF2_MASK, 8) |
-		      FIELD_PREP(GDM4_SPORT_OFF1_MASK, 8) |
-		      FIELD_PREP(GDM4_SPORT_OFF0_MASK, 8));
+	airoha_fe_rmw(eth, REG_GDM_SRC_PORT_SET(4),
+		      GDM_SPORT_OFF2_MASK |
+		      GDM_SPORT_OFF1_MASK |
+		      GDM_SPORT_OFF0_MASK,
+		      FIELD_PREP(GDM_SPORT_OFF2_MASK, 8) |
+		      FIELD_PREP(GDM_SPORT_OFF1_MASK, 8) |
+		      FIELD_PREP(GDM_SPORT_OFF0_MASK, 8));
 
 	/* set PSE Page as 128B */
 	airoha_fe_rmw(eth, REG_FE_DMA_GLO_CFG,
@@ -492,8 +492,8 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	airoha_fe_set(eth, REG_GDM_MISC_CFG,
 		      GDM2_RDM_ACK_WAIT_PREF_MASK |
 		      GDM2_CHN_VLD_MODE_MASK);
-	airoha_fe_rmw(eth, REG_CDM2_FWD_CFG, CDM2_OAM_QSEL_MASK,
-		      FIELD_PREP(CDM2_OAM_QSEL_MASK, 15));
+	airoha_fe_rmw(eth, REG_CDM_FWD_CFG(2), CDM_OAM_QSEL_MASK,
+		      FIELD_PREP(CDM_OAM_QSEL_MASK, 15));
 
 	/* init fragment and assemble Force Port */
 	/* NPU Core-3, NPU Bridge Channel-3 */
@@ -507,8 +507,8 @@ static int airoha_fe_init(struct airoha_eth *eth)
 		      FIELD_PREP(IP_ASSEMBLE_PORT_MASK, 0) |
 		      FIELD_PREP(IP_ASSEMBLE_NBQ_MASK, 22));
 
-	airoha_fe_set(eth, REG_GDM3_FWD_CFG, GDM3_PAD_EN_MASK);
-	airoha_fe_set(eth, REG_GDM4_FWD_CFG, GDM4_PAD_EN_MASK);
+	airoha_fe_set(eth, REG_GDM_FWD_CFG(3), GDM_PAD_EN_MASK);
+	airoha_fe_set(eth, REG_GDM_FWD_CFG(4), GDM_PAD_EN_MASK);
 
 	airoha_fe_crsn_qsel_init(eth);
 
@@ -516,7 +516,7 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	airoha_fe_set(eth, REG_FE_CPORT_CFG, FE_CPORT_PORT_XFC_MASK);
 
 	/* default aging mode for mbi unlock issue */
-	airoha_fe_rmw(eth, REG_GDM2_CHN_RLS,
+	airoha_fe_rmw(eth, REG_GDM_CHN_RLS(2),
 		      MBI_RX_AGE_SEL_MASK | MBI_TX_AGE_SEL_MASK,
 		      FIELD_PREP(MBI_RX_AGE_SEL_MASK, 3) |
 		      FIELD_PREP(MBI_TX_AGE_SEL_MASK, 3));
@@ -1703,7 +1703,7 @@ static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 
 	/* Forward the traffic to the proper GDM port */
 	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(2), pse_port);
-	airoha_fe_clear(eth, REG_GDM_FWD_CFG(2), GDM_STRIP_CRC);
+	airoha_fe_clear(eth, REG_GDM_FWD_CFG(2), GDM_STRIP_CRC_MASK);
 
 	/* Enable GDM2 loopback */
 	airoha_fe_wr(eth, REG_GDM_TXCHN_EN(2), 0xffffffff);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 69c5a143db8c079be0a6ecf41081cd3f5048c090..4b714b59740d5035fff0cdd1a405172d66f114b7 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -23,6 +23,8 @@
 #define GDM3_BASE			0x1100
 #define GDM4_BASE			0x2500
 
+#define CDM_BASE(_n)			\
+	((_n) == 2 ? CDM2_BASE : CDM1_BASE)
 #define GDM_BASE(_n)			\
 	((_n) == 4 ? GDM4_BASE :	\
 	 (_n) == 3 ? GDM3_BASE :	\
@@ -109,30 +111,24 @@
 #define PATN_DP_MASK			GENMASK(31, 16)
 #define PATN_SP_MASK			GENMASK(15, 0)
 
-#define REG_CDM1_VLAN_CTRL		CDM1_BASE
-#define CDM1_VLAN_MASK			GENMASK(31, 16)
+#define REG_CDM_VLAN_CTRL(_n)		CDM_BASE(_n)
+#define CDM_VLAN_MASK			GENMASK(31, 16)
 
-#define REG_CDM1_FWD_CFG		(CDM1_BASE + 0x08)
-#define CDM1_VIP_QSEL_MASK		GENMASK(24, 20)
+#define REG_CDM_FWD_CFG(_n)		(CDM_BASE(_n) + 0x08)
+#define CDM_OAM_QSEL_MASK		GENMASK(31, 27)
+#define CDM_VIP_QSEL_MASK		GENMASK(24, 20)
 
-#define REG_CDM1_CRSN_QSEL(_n)		(CDM1_BASE + 0x10 + ((_n) << 2))
-#define CDM1_CRSN_QSEL_REASON_MASK(_n)	\
-	GENMASK(4 + (((_n) % 4) << 3),	(((_n) % 4) << 3))
-
-#define REG_CDM2_FWD_CFG		(CDM2_BASE + 0x08)
-#define CDM2_OAM_QSEL_MASK		GENMASK(31, 27)
-#define CDM2_VIP_QSEL_MASK		GENMASK(24, 20)
-
-#define REG_CDM2_CRSN_QSEL(_n)		(CDM2_BASE + 0x10 + ((_n) << 2))
-#define CDM2_CRSN_QSEL_REASON_MASK(_n)	\
+#define REG_CDM_CRSN_QSEL(_n, _m)	(CDM_BASE(_n) + 0x10 + ((_m) << 2))
+#define CDM_CRSN_QSEL_REASON_MASK(_n)	\
 	GENMASK(4 + (((_n) % 4) << 3),	(((_n) % 4) << 3))
 
 #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
-#define GDM_DROP_CRC_ERR		BIT(23)
-#define GDM_IP4_CKSUM			BIT(22)
-#define GDM_TCP_CKSUM			BIT(21)
-#define GDM_UDP_CKSUM			BIT(20)
-#define GDM_STRIP_CRC			BIT(16)
+#define GDM_PAD_EN_MASK			BIT(28)
+#define GDM_DROP_CRC_ERR_MASK		BIT(23)
+#define GDM_IP4_CKSUM_MASK		BIT(22)
+#define GDM_TCP_CKSUM_MASK		BIT(21)
+#define GDM_UDP_CKSUM_MASK		BIT(20)
+#define GDM_STRIP_CRC_MASK		BIT(16)
 #define GDM_UCFQ_MASK			GENMASK(15, 12)
 #define GDM_BCFQ_MASK			GENMASK(11, 8)
 #define GDM_MCFQ_MASK			GENMASK(7, 4)
@@ -156,6 +152,10 @@
 #define LBK_CHAN_MODE_MASK		BIT(1)
 #define LPBK_EN_MASK			BIT(0)
 
+#define REG_GDM_CHN_RLS(_n)		(GDM_BASE(_n) + 0x20)
+#define MBI_RX_AGE_SEL_MASK		GENMASK(26, 25)
+#define MBI_TX_AGE_SEL_MASK		GENMASK(18, 17)
+
 #define REG_GDM_TXCHN_EN(_n)		(GDM_BASE(_n) + 0x24)
 #define REG_GDM_RXCHN_EN(_n)		(GDM_BASE(_n) + 0x28)
 
@@ -168,10 +168,10 @@
 #define FE_GDM_MIB_RX_CLEAR_MASK	BIT(1)
 #define FE_GDM_MIB_TX_CLEAR_MASK	BIT(0)
 
-#define REG_FE_GDM1_MIB_CFG		(GDM1_BASE + 0xf4)
+#define REG_FE_GDM_MIB_CFG(_n)		(GDM_BASE(_n) + 0xf4)
 #define FE_STRICT_RFC2819_MODE_MASK	BIT(31)
-#define FE_GDM1_TX_MIB_SPLIT_EN_MASK	BIT(17)
-#define FE_GDM1_RX_MIB_SPLIT_EN_MASK	BIT(16)
+#define FE_GDM_TX_MIB_SPLIT_EN_MASK	BIT(17)
+#define FE_GDM_RX_MIB_SPLIT_EN_MASK	BIT(16)
 #define FE_TX_MIB_ID_MASK		GENMASK(15, 8)
 #define FE_RX_MIB_ID_MASK		GENMASK(7, 0)
 
@@ -214,6 +214,33 @@
 #define REG_FE_GDM_RX_ETH_L511_CNT_L(_n)	(GDM_BASE(_n) + 0x198)
 #define REG_FE_GDM_RX_ETH_L1023_CNT_L(_n)	(GDM_BASE(_n) + 0x19c)
 
+#define REG_GDM_SRC_PORT_SET(_n)		(GDM_BASE(_n) + 0x23c)
+#define GDM_SPORT_OFF2_MASK			GENMASK(19, 16)
+#define GDM_SPORT_OFF1_MASK			GENMASK(15, 12)
+#define GDM_SPORT_OFF0_MASK			GENMASK(11, 8)
+
+#define REG_FE_GDM_TX_OK_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x280)
+#define REG_FE_GDM_TX_OK_BYTE_CNT_H(_n)		(GDM_BASE(_n) + 0x284)
+#define REG_FE_GDM_TX_ETH_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x288)
+#define REG_FE_GDM_TX_ETH_BYTE_CNT_H(_n)	(GDM_BASE(_n) + 0x28c)
+
+#define REG_FE_GDM_RX_OK_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x290)
+#define REG_FE_GDM_RX_OK_BYTE_CNT_H(_n)		(GDM_BASE(_n) + 0x294)
+#define REG_FE_GDM_RX_ETH_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x298)
+#define REG_FE_GDM_RX_ETH_BYTE_CNT_H(_n)	(GDM_BASE(_n) + 0x29c)
+#define REG_FE_GDM_TX_ETH_E64_CNT_H(_n)		(GDM_BASE(_n) + 0x2b8)
+#define REG_FE_GDM_TX_ETH_L64_CNT_H(_n)		(GDM_BASE(_n) + 0x2bc)
+#define REG_FE_GDM_TX_ETH_L127_CNT_H(_n)	(GDM_BASE(_n) + 0x2c0)
+#define REG_FE_GDM_TX_ETH_L255_CNT_H(_n)	(GDM_BASE(_n) + 0x2c4)
+#define REG_FE_GDM_TX_ETH_L511_CNT_H(_n)	(GDM_BASE(_n) + 0x2c8)
+#define REG_FE_GDM_TX_ETH_L1023_CNT_H(_n)	(GDM_BASE(_n) + 0x2cc)
+#define REG_FE_GDM_RX_ETH_E64_CNT_H(_n)		(GDM_BASE(_n) + 0x2e8)
+#define REG_FE_GDM_RX_ETH_L64_CNT_H(_n)		(GDM_BASE(_n) + 0x2ec)
+#define REG_FE_GDM_RX_ETH_L127_CNT_H(_n)	(GDM_BASE(_n) + 0x2f0)
+#define REG_FE_GDM_RX_ETH_L255_CNT_H(_n)	(GDM_BASE(_n) + 0x2f4)
+#define REG_FE_GDM_RX_ETH_L511_CNT_H(_n)	(GDM_BASE(_n) + 0x2f8)
+#define REG_FE_GDM_RX_ETH_L1023_CNT_H(_n)	(GDM_BASE(_n) + 0x2fc)
+
 #define REG_PPE_GLO_CFG(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x200)
 #define PPE_GLO_CFG_BUSY_MASK			BIT(31)
 #define PPE_GLO_CFG_FLOW_DROP_UPDATE_MASK	BIT(9)
@@ -326,44 +353,6 @@
 
 #define REG_UPDMEM_DATA(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x374)
 
-#define REG_FE_GDM_TX_OK_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x280)
-#define REG_FE_GDM_TX_OK_BYTE_CNT_H(_n)		(GDM_BASE(_n) + 0x284)
-#define REG_FE_GDM_TX_ETH_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x288)
-#define REG_FE_GDM_TX_ETH_BYTE_CNT_H(_n)	(GDM_BASE(_n) + 0x28c)
-
-#define REG_FE_GDM_RX_OK_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x290)
-#define REG_FE_GDM_RX_OK_BYTE_CNT_H(_n)		(GDM_BASE(_n) + 0x294)
-#define REG_FE_GDM_RX_ETH_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x298)
-#define REG_FE_GDM_RX_ETH_BYTE_CNT_H(_n)	(GDM_BASE(_n) + 0x29c)
-#define REG_FE_GDM_TX_ETH_E64_CNT_H(_n)		(GDM_BASE(_n) + 0x2b8)
-#define REG_FE_GDM_TX_ETH_L64_CNT_H(_n)		(GDM_BASE(_n) + 0x2bc)
-#define REG_FE_GDM_TX_ETH_L127_CNT_H(_n)	(GDM_BASE(_n) + 0x2c0)
-#define REG_FE_GDM_TX_ETH_L255_CNT_H(_n)	(GDM_BASE(_n) + 0x2c4)
-#define REG_FE_GDM_TX_ETH_L511_CNT_H(_n)	(GDM_BASE(_n) + 0x2c8)
-#define REG_FE_GDM_TX_ETH_L1023_CNT_H(_n)	(GDM_BASE(_n) + 0x2cc)
-#define REG_FE_GDM_RX_ETH_E64_CNT_H(_n)		(GDM_BASE(_n) + 0x2e8)
-#define REG_FE_GDM_RX_ETH_L64_CNT_H(_n)		(GDM_BASE(_n) + 0x2ec)
-#define REG_FE_GDM_RX_ETH_L127_CNT_H(_n)	(GDM_BASE(_n) + 0x2f0)
-#define REG_FE_GDM_RX_ETH_L255_CNT_H(_n)	(GDM_BASE(_n) + 0x2f4)
-#define REG_FE_GDM_RX_ETH_L511_CNT_H(_n)	(GDM_BASE(_n) + 0x2f8)
-#define REG_FE_GDM_RX_ETH_L1023_CNT_H(_n)	(GDM_BASE(_n) + 0x2fc)
-
-#define REG_GDM2_CHN_RLS		(GDM2_BASE + 0x20)
-#define MBI_RX_AGE_SEL_MASK		GENMASK(26, 25)
-#define MBI_TX_AGE_SEL_MASK		GENMASK(18, 17)
-
-#define REG_GDM3_FWD_CFG		GDM3_BASE
-#define GDM3_PAD_EN_MASK		BIT(28)
-
-#define REG_GDM4_FWD_CFG		GDM4_BASE
-#define GDM4_PAD_EN_MASK		BIT(28)
-#define GDM4_SPORT_OFFSET0_MASK		GENMASK(11, 8)
-
-#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x23c)
-#define GDM4_SPORT_OFF2_MASK		GENMASK(19, 16)
-#define GDM4_SPORT_OFF1_MASK		GENMASK(15, 12)
-#define GDM4_SPORT_OFF0_MASK		GENMASK(11, 8)
-
 #define REG_IP_FRAG_FP			0x2010
 #define IP_ASSEMBLE_PORT_MASK		GENMASK(24, 21)
 #define IP_ASSEMBLE_NBQ_MASK		GENMASK(20, 16)

---
base-commit: 1f89ed0ebf2696d1d8fa7625e26c692aa153774a
change-id: 20251017-airoha-regs-cosmetics-54e9005e7586

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


