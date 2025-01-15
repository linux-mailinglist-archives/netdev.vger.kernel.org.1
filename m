Return-Path: <netdev+bounces-158423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8BBA11CB6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE04B169145
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB71A246A1D;
	Wed, 15 Jan 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lq0jTeo1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB76246A0E;
	Wed, 15 Jan 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931689; cv=none; b=H7NhfnZoP2fBQSCywT8Bz3QnfH1uGoxdMyzhbdraMYcu6U8c42TpTBXgbqooiFNS33dBxIPG+JJ5HOndsKw235oR8tKl49b6X7g/5JYTo/xPp856IPyiv/+eHmTBOmznMfMsMqAwkHHrKuKs5yDXmYkNYjeCVYqnFuVCyIae09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931689; c=relaxed/simple;
	bh=b/reqOtfl+L24dOdTrsEccgMQ+RY9mWVxC+9I84TZ30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvXYOhOusjF6dJNWIsrSsqtPK6ElgLF61bMXOj9sL3lgkAqTBY5w4f6ZBi98r3HUHCV21mm2ibtMHSA1Tcl3xj6XAmSrl74SrYua0yJUilAUv5tINrgQfFLnRYHvs/WlV2qLOtfaqlND8V7WjBT4dBNf/aDsGPQnPjx41HZYCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lq0jTeo1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736931687; x=1768467687;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=b/reqOtfl+L24dOdTrsEccgMQ+RY9mWVxC+9I84TZ30=;
  b=lq0jTeo1EwqXfsuqTI3+YUNFvaoWQH/jZGnYfBI5DSmJdMmbK9RwVqkz
   xfisHZjOWyEe7CxMUTcwgojOXPOqoW9vogTNHjqCmCsKB82Y6etzupHiM
   hsvS6GOUC01yevIKz2lkGbIEEKFtho7aVqWyezP5KL2SvLhHDYN/MS4Ha
   5EuZzmHu+cMYuhuA5i06MUIrV69rKX7VUdIT/Js3DINzdIESepDljpJEt
   wz3KE3xYgTiDvsb9vgqm7Qo+zMcgUHujU+Fy5ULpFMyZz25Ue6ykj/8Ky
   5C++6DEZNlkpZT7vkng9Bp/ca8ufwQjPKn+JPPOVxl19epRBUqGZLHvrt
   w==;
X-CSE-ConnectionGUID: uUIOS/pbQnKKbt5ehMoa8A==
X-CSE-MsgGUID: 97qeQKJLQzCT07+dLNTyJA==
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36185959"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2025 02:01:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 Jan 2025 02:00:38 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 15 Jan 2025 02:00:34 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 1/3] net: phy: microchip_rds_ptp: Header file library changes for PEROUT
Date: Wed, 15 Jan 2025 14:36:32 +0530
Message-ID: <20250115090634.12941-2-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250115090634.12941-1-divya.koppera@microchip.com>
References: <20250115090634.12941-1-divya.koppera@microchip.com>
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
v2 -> v3
- Removed redundant macros after modifying code to use
  nearby pulsewidth value of user input.

v1 -> v2
- Removed redundant Macros
- Given proper naming to event and pin
---
 drivers/net/phy/microchip_rds_ptp.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/phy/microchip_rds_ptp.h b/drivers/net/phy/microchip_rds_ptp.h
index e95c065728b5..25af68337b94 100644
--- a/drivers/net/phy/microchip_rds_ptp.h
+++ b/drivers/net/phy/microchip_rds_ptp.h
@@ -130,6 +130,23 @@
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
 /* Represents 1ppm adjustment in 2^32 format with
  * each nsec contains 4 clock cycles in 250MHz.
  * The value is calculated as following: (1/1000000)/((2^-32)/4)
@@ -138,6 +155,10 @@
 #define MCHP_RDS_PTP_FIFO_SIZE			8
 #define MCHP_RDS_PTP_MAX_ADJ			31249999
 
+#define MCHP_RDS_PTP_BUFFER_TIME		2
+#define MCHP_RDS_PTP_N_PIN			4
+#define MCHP_RDS_PTP_N_PEROUT			1
+
 #define BASE_CLK(p)				((p)->clk_base_addr)
 #define BASE_PORT(p)				((p)->port_base_addr)
 #define PTP_MMD(p)				((p)->mmd)
@@ -176,6 +197,9 @@ struct mchp_rds_ptp_clock {
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


