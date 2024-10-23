Return-Path: <netdev+bounces-138415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F729AD72C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BA6283316
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609211FF7B1;
	Wed, 23 Oct 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="as8iU2aX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2291FAC36;
	Wed, 23 Oct 2024 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720929; cv=none; b=UEjPThJHg/KKTTzY1vTRRtoFLVY9Q46lMNp+JHemwochrJuLmNh5DwvoCRe5xnYoAiEXBexArdKqPyPfS5pg2K+vHOFsOYkEoVVU4aSEP6rW9qKONPKAmgzkWQc/HcYo3DSQbx0Oxx79dExTBS2H7AjcAvJ6rrdO3pxuuwSbwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720929; c=relaxed/simple;
	bh=tYIsnlYu8tQgs3FFqbphhsO7GFXXscQdLLBW4Ok9TdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dqlitAfulRJsiQ5JfQpam0G/FXQVbXrNi+TWcjAd4/R3L4xvBvw0pA3BsJta4etsADC+OFLWplbcnG1Qn6fyN0OVg1G1+6+kvC57tsx81r9iaQv/2Vznhnt6xIy9tZkhKa/gNw0UViVwdHuB91TDK/n3XnBr7/+yk3IomBWyNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=as8iU2aX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729720927; x=1761256927;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tYIsnlYu8tQgs3FFqbphhsO7GFXXscQdLLBW4Ok9TdI=;
  b=as8iU2aXsR2oF1TgozM/qP24TcCTiHikSMu1xlTY2UGVw/on5AgfxUJv
   Qa6EAqxIIkGzZOm2tdDCfubG1rnRkeaKdji/rB1j5utBnfFpaiCdQ5Ks/
   FIByCvbfJG+bRaGyyzpobmGRq10VSubycKkPi+81BSV8qQtHTaz/9KBUz
   pDGsWOq5LwjwXRX4F1Wo8Pdy6PAwDzq8yZA+K31tGZRatPl0M0/Y5oTdL
   EdZKV+VPkl2MEksp5AQYNrt3Rih5HFt3xcrpPrBLrvJZ0lg/UotO6XPmS
   cSG9FlvMvzIy34Vsz/0HvogZ+ey6r6r0NoSY6xpN1TyZ+yK97AzzAY0il
   g==;
X-CSE-ConnectionGUID: 1Xapdzk8QAqz3uJYdYtrIg==
X-CSE-MsgGUID: BGTP6e2oRi2jYdjqN96SDQ==
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="33409631"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 15:02:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 15:01:59 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 23 Oct 2024 15:01:55 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Oct 2024 00:01:24 +0200
Subject: [PATCH net-next v2 05/15] net: sparx5: add registers required by
 lan969x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-sparx5-lan969x-switch-driver-2-v2-5-a0b5fae88a0f@microchip.com>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Lan969x will require a few additional registers for certain operations.
Some are shared, some are not. Add these.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 0e8b18bcf179..561344f19062 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -2666,6 +2666,44 @@ extern const struct sparx5_regs *regs;
 #define CPU_PROC_CTRL_ACP_DISABLE_GET(x)\
 	FIELD_GET(CPU_PROC_CTRL_ACP_DISABLE, x)
 
+/* DEV1G:PHASE_DETECTOR_CTRL:PHAD_CTRL */
+#define DEV2G5_PHAD_CTRL(t, g)                                                 \
+	__REG(TARGET_DEV2G5, t, regs->tsize[TC_DEV2G5], 200, g, 2,             \
+	      regs->gsize[GW_DEV2G5_PHASE_DETECTOR_CTRL], 0, 0, 1, 4)
+
+#define DEV2G5_PHAD_CTRL_PHAD_ENA\
+	BIT(regs->fpos[FP_DEV2G5_PHAD_CTRL_PHAD_ENA])
+#define DEV2G5_PHAD_CTRL_PHAD_ENA_SET(x)\
+	spx5_field_prep(DEV2G5_PHAD_CTRL_PHAD_ENA, x)
+#define DEV2G5_PHAD_CTRL_PHAD_ENA_GET(x)\
+	spx5_field_get(DEV2G5_PHAD_CTRL_PHAD_ENA, x)
+
+/* LAN969X ONLY */
+#define DEV2G5_PHAD_CTRL_DIV_CFG                 GENMASK(11, 9)
+#define DEV2G5_PHAD_CTRL_DIV_CFG_SET(x)\
+	FIELD_PREP(DEV2G5_PHAD_CTRL_DIV_CFG, x)
+#define DEV2G5_PHAD_CTRL_DIV_CFG_GET(x)\
+	FIELD_GET(DEV2G5_PHAD_CTRL_DIV_CFG, x)
+
+/* DEV1G:PHASE_DETECTOR_CTRL:PHAD_CTRL */
+#define DEV2G5_PHAD_CTRL(t, g)                                                 \
+	__REG(TARGET_DEV2G5, t, regs->tsize[TC_DEV2G5], 200, g, 2,             \
+	      regs->gsize[GW_DEV2G5_PHASE_DETECTOR_CTRL], 0, 0, 1, 4)
+
+#define DEV2G5_PHAD_CTRL_PHAD_ENA\
+	BIT(regs->fpos[FP_DEV2G5_PHAD_CTRL_PHAD_ENA])
+#define DEV2G5_PHAD_CTRL_PHAD_ENA_SET(x)\
+	spx5_field_prep(DEV2G5_PHAD_CTRL_PHAD_ENA, x)
+#define DEV2G5_PHAD_CTRL_PHAD_ENA_GET(x)\
+	spx5_field_get(DEV2G5_PHAD_CTRL_PHAD_ENA, x)
+
+/* LAN969X ONLY */
+#define DEV2G5_PHAD_CTRL_DIV_CFG                 GENMASK(11, 9)
+#define DEV2G5_PHAD_CTRL_DIV_CFG_SET(x)\
+	FIELD_PREP(DEV2G5_PHAD_CTRL_DIV_CFG, x)
+#define DEV2G5_PHAD_CTRL_DIV_CFG_GET(x)\
+	FIELD_GET(DEV2G5_PHAD_CTRL_DIV_CFG, x)
+
 /* DEV10G:MAC_CFG_STATUS:MAC_ENA_CFG */
 #define DEV10G_MAC_ENA_CFG(t)                                                  \
 	__REG(TARGET_DEV10G, t, regs->tsize[TC_DEV10G], 0, 0, 1, 60, 0, 0, 1,  \
@@ -2869,6 +2907,11 @@ extern const struct sparx5_regs *regs;
 #define DEV10G_DEV_RST_CTRL_MAC_RX_RST_GET(x)\
 	FIELD_GET(DEV10G_DEV_RST_CTRL_MAC_RX_RST, x)
 
+/* DEV10G:DEV_CFG_STATUS:PTP_STAMPER_CFG */
+#define DEV10G_PTP_STAMPER_CFG(t)                                              \
+	__REG(TARGET_DEV10G, t, regs->tsize[TC_DEV10G], 436, 0, 1, 52, 20, 0,  \
+	      1, 4)
+
 /* DEV10G:PCS25G_CFG_STATUS:PCS25G_CFG */
 #define DEV10G_PCS25G_CFG(t)                                                   \
 	__REG(TARGET_DEV10G, t, regs->tsize[TC_DEV10G], 488, 0, 1, 32, 0, 0, 1,\
@@ -4267,6 +4310,11 @@ extern const struct sparx5_regs *regs;
 #define DEV5G_DEV_RST_CTRL_MAC_RX_RST_GET(x)\
 	FIELD_GET(DEV5G_DEV_RST_CTRL_MAC_RX_RST, x)
 
+/* DEV10G:DEV_CFG_STATUS:PTP_STAMPER_CFG */
+#define DEV5G_PTP_STAMPER_CFG(t)                                               \
+	__REG(TARGET_DEV5G, t, regs->tsize[TC_DEV5G], 436, 0, 1, 52, 20, 0, 1, \
+	      4)
+
 /* DSM:RAM_CTRL:RAM_INIT */
 #define DSM_RAM_INIT                                                           \
 	__REG(TARGET_DSM, 0, 1, 0, 0, 1, 4, 0, 0, 1, 4)
@@ -4444,6 +4492,27 @@ extern const struct sparx5_regs *regs;
 #define DSM_TAXI_CAL_CFG_CAL_PGM_ENA_GET(x)\
 	FIELD_GET(DSM_TAXI_CAL_CFG_CAL_PGM_ENA, x)
 
+/* LAN969X ONLY */
+#define DSM_TAXI_CAL_CFG_CAL_SEL_STAT            BIT(23)
+#define DSM_TAXI_CAL_CFG_CAL_SEL_STAT_SET(x)\
+	FIELD_PREP(DSM_TAXI_CAL_CFG_CAL_SEL_STAT, x)
+#define DSM_TAXI_CAL_CFG_CAL_SEL_STAT_GET(x)\
+	FIELD_GET(DSM_TAXI_CAL_CFG_CAL_SEL_STAT, x)
+
+/* LAN969X ONLY */
+#define DSM_TAXI_CAL_CFG_CAL_SWITCH              BIT(22)
+#define DSM_TAXI_CAL_CFG_CAL_SWITCH_SET(x)\
+	FIELD_PREP(DSM_TAXI_CAL_CFG_CAL_SWITCH, x)
+#define DSM_TAXI_CAL_CFG_CAL_SWITCH_GET(x)\
+	FIELD_GET(DSM_TAXI_CAL_CFG_CAL_SWITCH, x)
+
+/* LAN969X ONLY */
+#define DSM_TAXI_CAL_CFG_CAL_PGM_SEL             BIT(21)
+#define DSM_TAXI_CAL_CFG_CAL_PGM_SEL_SET(x)\
+	FIELD_PREP(DSM_TAXI_CAL_CFG_CAL_PGM_SEL, x)
+#define DSM_TAXI_CAL_CFG_CAL_PGM_SEL_GET(x)\
+	FIELD_GET(DSM_TAXI_CAL_CFG_CAL_PGM_SEL, x)
+
 /* EACL:ES2_KEY_SELECT_PROFILE:VCAP_ES2_KEY_SEL */
 #define EACL_VCAP_ES2_KEY_SEL(g, r)                                            \
 	__REG(TARGET_EACL, 0, 1, regs->gaddr[GA_EACL_ES2_KEY_SELECT_PROFILE],  \
@@ -6720,6 +6789,69 @@ extern const struct sparx5_regs *regs;
 	      regs->gcnt[GC_PTP_PHASE_DETECTOR_CTRL],                          \
 	      regs->gsize[GW_PTP_PHASE_DETECTOR_CTRL], 4, 0, 1, 4)
 
+/* LAN969X ONLY */
+/* DEVCPU_PTP:PTP_TS_FIFO:PTP_TWOSTEP_CTRL */
+#define PTP_TWOSTEP_CTRL                                                       \
+	__REG(TARGET_PTP, 0, 1, 612, 0, 1, 16, 0, 0, 1, 4)
+
+#define PTP_TWOSTEP_CTRL_PTP_OVWR_ENA            BIT(12)
+#define PTP_TWOSTEP_CTRL_PTP_OVWR_ENA_SET(x)\
+	FIELD_PREP(PTP_TWOSTEP_CTRL_PTP_OVWR_ENA, x)
+#define PTP_TWOSTEP_CTRL_PTP_OVWR_ENA_GET(x)\
+	FIELD_GET(PTP_TWOSTEP_CTRL_PTP_OVWR_ENA, x)
+
+#define PTP_TWOSTEP_CTRL_PTP_NXT                 BIT(11)
+#define PTP_TWOSTEP_CTRL_PTP_NXT_SET(x)\
+	FIELD_PREP(PTP_TWOSTEP_CTRL_PTP_NXT, x)
+#define PTP_TWOSTEP_CTRL_PTP_NXT_GET(x)\
+	FIELD_GET(PTP_TWOSTEP_CTRL_PTP_NXT, x)
+
+#define PTP_TWOSTEP_CTRL_PTP_VLD                 BIT(10)
+#define PTP_TWOSTEP_CTRL_PTP_VLD_SET(x)\
+	FIELD_PREP(PTP_TWOSTEP_CTRL_PTP_VLD, x)
+#define PTP_TWOSTEP_CTRL_PTP_VLD_GET(x)\
+	FIELD_GET(PTP_TWOSTEP_CTRL_PTP_VLD, x)
+
+#define PTP_TWOSTEP_CTRL_STAMP_TX                BIT(9)
+#define PTP_TWOSTEP_CTRL_STAMP_TX_SET(x)\
+	FIELD_PREP(PTP_TWOSTEP_CTRL_STAMP_TX, x)
+#define PTP_TWOSTEP_CTRL_STAMP_TX_GET(x)\
+	FIELD_GET(PTP_TWOSTEP_CTRL_STAMP_TX, x)
+
+#define PTP_TWOSTEP_CTRL_STAMP_PORT              GENMASK(8, 1)
+#define PTP_TWOSTEP_CTRL_STAMP_PORT_SET(x)\
+	FIELD_PREP(PTP_TWOSTEP_CTRL_STAMP_PORT, x)
+#define PTP_TWOSTEP_CTRL_STAMP_PORT_GET(x)\
+	FIELD_GET(PTP_TWOSTEP_CTRL_STAMP_PORT, x)
+
+#define PTP_TWOSTEP_CTRL_PTP_OVFL                BIT(0)
+#define PTP_TWOSTEP_CTRL_PTP_OVFL_SET(x)\
+	FIELD_PREP(PTP_TWOSTEP_CTRL_PTP_OVFL, x)
+#define PTP_TWOSTEP_CTRL_PTP_OVFL_GET(x)\
+	FIELD_GET(PTP_TWOSTEP_CTRL_PTP_OVFL, x)
+
+/* LAN969X ONLY */
+/* DEVCPU_PTP:PTP_TS_FIFO:PTP_TWOSTEP_STAMP_NSEC */
+#define PTP_TWOSTEP_STAMP_NSEC                                                 \
+	__REG(TARGET_PTP, 0, 1, 612, 0, 1, 16, 4, 0, 1, 4)
+
+#define PTP_TWOSTEP_STAMP_NSEC_NS                GENMASK(29, 0)
+#define PTP_TWOSTEP_STAMP_NSEC_NS_SET(x)\
+	FIELD_PREP(PTP_TWOSTEP_STAMP_NSEC_NS, x)
+#define PTP_TWOSTEP_STAMP_NSEC_NS_GET(x)\
+	FIELD_GET(PTP_TWOSTEP_STAMP_NSEC_NS, x)
+
+/* LAN969X ONLY */
+/* DEVCPU_PTP:PTP_TS_FIFO:PTP_TWOSTEP_STAMP_SUBNS */
+#define PTP_TWOSTEP_STAMP_SUBNS                                                \
+	__REG(TARGET_PTP, 0, 1, 612, 0, 1, 16, 8, 0, 1, 4)
+
+#define PTP_TWOSTEP_STAMP_SUBNS_NS               GENMASK(7, 0)
+#define PTP_TWOSTEP_STAMP_SUBNS_NS_SET(x)\
+	FIELD_PREP(PTP_TWOSTEP_STAMP_SUBNS_NS, x)
+#define PTP_TWOSTEP_STAMP_SUBNS_NS_GET(x)\
+	FIELD_GET(PTP_TWOSTEP_STAMP_SUBNS_NS, x)
+
 /* QFWD:SYSTEM:SWITCH_PORT_MODE */
 #define QFWD_SWITCH_PORT_MODE(r)                                               \
 	__REG(TARGET_QFWD, 0, 1, 0, 0, 1, 340, 0, r,                           \

-- 
2.34.1


