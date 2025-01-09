Return-Path: <netdev+bounces-156638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B4A072F1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D5C166864
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872A1217712;
	Thu,  9 Jan 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yqR8M+8c"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8965B217648;
	Thu,  9 Jan 2025 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418202; cv=none; b=oVuS7oo7mobE1O9nYJqBLXRwTk4LDe3uVzTa+Urzia6UGwW85BlyBSZG/8yNxyac7tKnhFW25GUS2NZmtJt385gmUuERP0BeZUj9w/i+S9VC6y/phv6dZRFfQqMaehY11G7Dun5EJFDtsc1e9XfDiPQufFYTRwdL5wYsi+sG/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418202; c=relaxed/simple;
	bh=mJZJKnF0bdMm1BwL33UrjHSgsES8q4dVpDzbwRZ6TjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gX9vySoYUwIAEaIyuOZGfarGz2YTP7bMnCTrIcpluBM+jtE2nMYAvCkgJRd142tHuZmR9vixXJh8sMfK7Bx63u74Et7g6ICfResrAFFcSdZezArVAcr9mtBVVQqiRsOaHhWjC+OtS11v7DCXlcADSMg6uz7Gx7UWEgfEg9s6jQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yqR8M+8c; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736418199; x=1767954199;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=mJZJKnF0bdMm1BwL33UrjHSgsES8q4dVpDzbwRZ6TjE=;
  b=yqR8M+8cuDrF2i3fys58svLc2QCZlkbf+ujRisPF7ZXPPYvAvMhBc2xG
   mPQT6wkQdQVYvnqBzdqKk0y1IUoWr9hFa/JLJMxNHYNFHICokZf0mIYs5
   w6x31+D8r49NDX6PFhwY8dasqLNV9fKO1z2K+9Z6jke6MoyReaKlSJ1wB
   hTBrNT84qw+XkRELCA+T/XVJ9ixwd9S9gKmV7bPa6CxhmMqUfDlqdq3yB
   6Gg6Ki+chY7AwY6MESgsEN+tJtQSrSP9v3ivqygK6NZ4HuEyoTNY1QY/d
   WTJzNBmWpHxE8WkHnNCowSsUWW5DEi/m7SsCmyvCsEEhaw081cFP3kF2Z
   A==;
X-CSE-ConnectionGUID: pKZMzjv2RsiFZGF8PKVKgw==
X-CSE-MsgGUID: WPUYPzqLQNqY/JUHEUSrIg==
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="40189014"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 03:23:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 03:22:37 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 03:22:33 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 1/3] net: phy: microchip_rds_ptp: Header file library changes for PEROUT
Date: Thu, 9 Jan 2025 15:55:31 +0530
Message-ID: <20250109102533.15621-2-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250109102533.15621-1-divya.koppera@microchip.com>
References: <20250109102533.15621-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This ptp header file library changes will cover PEROUT
macros that are required to generate periodic output
from pin out

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v2
- Removed redundant Macros
- Given proper naming to event and pin
---
 drivers/net/phy/microchip_rds_ptp.h | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/phy/microchip_rds_ptp.h b/drivers/net/phy/microchip_rds_ptp.h
index e95c065728b5..2a3c566b028f 100644
--- a/drivers/net/phy/microchip_rds_ptp.h
+++ b/drivers/net/phy/microchip_rds_ptp.h
@@ -130,6 +130,38 @@
 #define MCHP_RDS_PTP_TSU_HARD_RESET		0xc1
 #define MCHP_RDS_PTP_TSU_HARDRESET		BIT(0)
 
+#define MCHP_RDS_PTP_CLK_TRGT_SEC_HI		0x15
+#define MCHP_RDS_PTP_CLK_TRGT_SEC_LO		0x16
+#define MCHP_RDS_PTP_CLK_TRGT_NS_HI		0x17
+#define MCHP_RDS_PTP_CLK_TRGT_NS_LO		0x18
+
+#define MCHP_RDS_PTP_CLK_TRGT_RELOAD_SEC_HI	0x19
+#define MCHP_RDS_PTP_CLK_TRGT_RELOAD_SEC_LO	0x1a
+#define MCHP_RDS_PTP_CLK_TRGT_RELOAD_NS_HI	0x1b
+#define MCHP_RDS_PTP_CLK_TRGT_RELOAD_NS_LO	0x1c
+
+#define MCHP_RDS_PTP_GEN_CFG			0x01
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_MASK	GENMASK(11, 8)
+
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_SET(value) (((value) & 0xF) << 4)
+#define MCHP_RDS_PTP_GEN_CFG_RELOAD_ADD		BIT(0)
+#define MCHP_RDS_PTP_GEN_CFG_POLARITY		BIT(1)
+
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_200MS_	13
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100MS_	12
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50MS_	11
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10MS_	10
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5MS_	9
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1MS_	8
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500US_	7
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100US_	6
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50US_	5
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10US_	4
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5US_	3
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1US_	2
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500NS_	1
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100NS_	0
+
 /* Represents 1ppm adjustment in 2^32 format with
  * each nsec contains 4 clock cycles in 250MHz.
  * The value is calculated as following: (1/1000000)/((2^-32)/4)
@@ -138,6 +170,10 @@
 #define MCHP_RDS_PTP_FIFO_SIZE			8
 #define MCHP_RDS_PTP_MAX_ADJ			31249999
 
+#define MCHP_RDS_PTP_BUFFER_TIME		2
+#define MCHP_RDS_PTP_N_PIN			4
+#define MCHP_RDS_PTP_N_PEROUT			1
+
 #define BASE_CLK(p)				((p)->clk_base_addr)
 #define BASE_PORT(p)				((p)->port_base_addr)
 #define PTP_MMD(p)				((p)->mmd)
@@ -176,6 +212,9 @@ struct mchp_rds_ptp_clock {
 	/* Lock for phc */
 	struct mutex ptp_lock;
 	u8 mmd;
+	int mchp_rds_ptp_event;
+	int event_pin;
+	struct ptp_pin_desc *pin_config;
 };
 
 struct mchp_rds_ptp_rx_ts {
-- 
2.17.1


