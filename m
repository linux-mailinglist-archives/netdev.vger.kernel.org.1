Return-Path: <netdev+bounces-137506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F44E9A6B6B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF8E281CF9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326CD1FDFAB;
	Mon, 21 Oct 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kSztVMiR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F331FCF43;
	Mon, 21 Oct 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519223; cv=none; b=AHQlc4+vnZrtu6DEaxwn6EEvCpjZDa4DC8oiULkJBvYA3AF6+VSHpwe6N3GDkGbeerPoeTY614H6do7z7uxY1cepLV2DDAyPzs5Qwe8eJUXHYvmeo4CKwCdiOdGZwiBzfy/TmvetbkwOuD4SgtPe0HVEOTZqQVQBbcT/Jt3XrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519223; c=relaxed/simple;
	bh=rwABD1s3aZAVELHR4mcTO5PabHV2RCqxETCwT5w+7vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bu1RbWgiZq26ijkkJ8LEA7kYMLUANlNU3KUHLRTOxcc4Jt8EWuAB1i+2vw1xs/qdblwRDhvQypcfgyE+H7gn0bjoRTCrMRSxVmYYcx8IpTy4lrkaUi9KKb96Aet8NV/av2+ESx2zeGKVTCdYiAbJEMXcRE/esKmpsqfIBDA4W+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kSztVMiR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519220; x=1761055220;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rwABD1s3aZAVELHR4mcTO5PabHV2RCqxETCwT5w+7vE=;
  b=kSztVMiRDang9uHjMN4eKVuCumZbejrgN83+01l/a0+UZ29hzlWRruiR
   F+EB2dzJ8g9u5pVncmIpAHrnA5ASG7NslPfAtFLuNlcU+eVXSUUNqiFZI
   DdNEi03GNKAcrv2GRNZeUzknSFh+8lUcUL1qbvRGdu74anO1TQSpPscfI
   R6s0cmqFxjT4kVG2Esr0hWoTyHO6i6bhgHtcYrbj1HWPEpRrT56dQEDO0
   cxKp7FfPmKbvQ/6pWMSBFAoTaTV+lcGIGIxbbRpe0BBQa90z3JaMRnIdr
   2QLQbkHQJ8zbOE9hV1TbWvkF8apthFx2V8i8KodWl3VSBtjAjtF6vlKBO
   Q==;
X-CSE-ConnectionGUID: Ky42XnPuQxK/Okp36Nw4mA==
X-CSE-MsgGUID: e2olz952RPOhnmGGDiB9GQ==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="200707747"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 06:59:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:58:58 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:58:54 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:38 +0200
Subject: [PATCH net-next 01/15] net: sparx5: add support for lan969x SKU's
 and core clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-1-c8c49ef21e0f@microchip.com>
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

In preparation for lan969x, add lan969x SKU's (Stock Keeping Unit) to
sparx5_target_chiptype and set the core clock frequency for these
throughout. Lan969x only supports a core clock frequency of 328MHz.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_calendar.c    | 17 +++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 14 +++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 35 +++++++++++++++-------
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  6 ++++
 4 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index b2a8d04ab509..1ae56194637f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -53,6 +53,22 @@ static u32 sparx5_target_bandwidth(struct sparx5 *sparx5)
 	case SPX5_TARGET_CT_7558:
 	case SPX5_TARGET_CT_7558TSN:
 		return 201000;
+	case SPX5_TARGET_CT_LAN9691VAO:
+		return 46000;
+	case SPX5_TARGET_CT_LAN9694RED:
+	case SPX5_TARGET_CT_LAN9694TSN:
+	case SPX5_TARGET_CT_LAN9694:
+		return 68000;
+	case SPX5_TARGET_CT_LAN9696RED:
+	case SPX5_TARGET_CT_LAN9696TSN:
+	case SPX5_TARGET_CT_LAN9692VAO:
+	case SPX5_TARGET_CT_LAN9696:
+		return 88000;
+	case SPX5_TARGET_CT_LAN9698RED:
+	case SPX5_TARGET_CT_LAN9698TSN:
+	case SPX5_TARGET_CT_LAN9693VAO:
+	case SPX5_TARGET_CT_LAN9698:
+		return 101000;
 	default:
 		return 0;
 	}
@@ -74,6 +90,7 @@ static u32 sparx5_clk_to_bandwidth(enum sparx5_core_clockfreq cclock)
 {
 	switch (cclock) {
 	case SPX5_CORE_CLOCK_250MHZ: return 83000; /* 250000 / 3 */
+	case SPX5_CORE_CLOCK_328MHZ: return 109375; /* 328000 / 3 */
 	case SPX5_CORE_CLOCK_500MHZ: return 166000; /* 500000 / 3 */
 	case SPX5_CORE_CLOCK_625MHZ: return  208000; /* 625000 / 3 */
 	default: return 0;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index d1e9bc030c80..f48b5769e1b3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -475,6 +475,20 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 		else if (sparx5->coreclock == SPX5_CORE_CLOCK_250MHZ)
 			freq = 0; /* Not supported */
 		break;
+	case SPX5_TARGET_CT_LAN9694:
+	case SPX5_TARGET_CT_LAN9691VAO:
+	case SPX5_TARGET_CT_LAN9694TSN:
+	case SPX5_TARGET_CT_LAN9694RED:
+	case SPX5_TARGET_CT_LAN9696:
+	case SPX5_TARGET_CT_LAN9692VAO:
+	case SPX5_TARGET_CT_LAN9696TSN:
+	case SPX5_TARGET_CT_LAN9696RED:
+	case SPX5_TARGET_CT_LAN9698:
+	case SPX5_TARGET_CT_LAN9693VAO:
+	case SPX5_TARGET_CT_LAN9698TSN:
+	case SPX5_TARGET_CT_LAN9698RED:
+		freq = SPX5_CORE_CLOCK_328MHZ;
+		break;
 	default:
 		dev_err(sparx5->dev, "Target (%#04x) not supported\n",
 			sparx5->target_ct);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 364ae92969bc..f117cf65cf8c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -26,16 +26,28 @@
 
 /* Target chip type */
 enum spx5_target_chiptype {
-	SPX5_TARGET_CT_7546    = 0x7546,  /* SparX-5-64  Enterprise */
-	SPX5_TARGET_CT_7549    = 0x7549,  /* SparX-5-90  Enterprise */
-	SPX5_TARGET_CT_7552    = 0x7552,  /* SparX-5-128 Enterprise */
-	SPX5_TARGET_CT_7556    = 0x7556,  /* SparX-5-160 Enterprise */
-	SPX5_TARGET_CT_7558    = 0x7558,  /* SparX-5-200 Enterprise */
-	SPX5_TARGET_CT_7546TSN = 0x47546, /* SparX-5-64i Industrial */
-	SPX5_TARGET_CT_7549TSN = 0x47549, /* SparX-5-90i Industrial */
-	SPX5_TARGET_CT_7552TSN = 0x47552, /* SparX-5-128i Industrial */
-	SPX5_TARGET_CT_7556TSN = 0x47556, /* SparX-5-160i Industrial */
-	SPX5_TARGET_CT_7558TSN = 0x47558, /* SparX-5-200i Industrial */
+	SPX5_TARGET_CT_7546       = 0x7546,  /* SparX-5-64  Enterprise */
+	SPX5_TARGET_CT_7549       = 0x7549,  /* SparX-5-90  Enterprise */
+	SPX5_TARGET_CT_7552       = 0x7552,  /* SparX-5-128 Enterprise */
+	SPX5_TARGET_CT_7556       = 0x7556,  /* SparX-5-160 Enterprise */
+	SPX5_TARGET_CT_7558       = 0x7558,  /* SparX-5-200 Enterprise */
+	SPX5_TARGET_CT_7546TSN    = 0x47546, /* SparX-5-64i Industrial */
+	SPX5_TARGET_CT_7549TSN    = 0x47549, /* SparX-5-90i Industrial */
+	SPX5_TARGET_CT_7552TSN    = 0x47552, /* SparX-5-128i Industrial */
+	SPX5_TARGET_CT_7556TSN    = 0x47556, /* SparX-5-160i Industrial */
+	SPX5_TARGET_CT_7558TSN    = 0x47558, /* SparX-5-200i Industrial */
+	SPX5_TARGET_CT_LAN9694    = 0x9694,  /* lan969x-40 */
+	SPX5_TARGET_CT_LAN9691VAO = 0x9691,  /* lan969x-40-VAO */
+	SPX5_TARGET_CT_LAN9694TSN = 0x9695,  /* lan969x-40-TSN */
+	SPX5_TARGET_CT_LAN9694RED = 0x969A,  /* lan969x-40-RED */
+	SPX5_TARGET_CT_LAN9696    = 0x9696,  /* lan969x-60 */
+	SPX5_TARGET_CT_LAN9692VAO = 0x9692,  /* lan969x-65-VAO */
+	SPX5_TARGET_CT_LAN9696TSN = 0x9697,  /* lan969x-60-TSN */
+	SPX5_TARGET_CT_LAN9696RED = 0x969B,  /* lan969x-60-RED */
+	SPX5_TARGET_CT_LAN9698    = 0x9698,  /* lan969x-100 */
+	SPX5_TARGET_CT_LAN9693VAO = 0x9693,  /* lan969x-100-VAO */
+	SPX5_TARGET_CT_LAN9698TSN = 0x9699,  /* lan969x-100-TSN */
+	SPX5_TARGET_CT_LAN9698RED = 0x969C,  /* lan969x-100-RED */
 };
 
 enum sparx5_port_max_tags {
@@ -192,6 +204,7 @@ struct sparx5_port {
 enum sparx5_core_clockfreq {
 	SPX5_CORE_CLOCK_DEFAULT,  /* Defaults to the highest supported frequency */
 	SPX5_CORE_CLOCK_250MHZ,   /* 250MHZ core clock frequency */
+	SPX5_CORE_CLOCK_328MHZ,   /* 328MHZ core clock frequency */
 	SPX5_CORE_CLOCK_500MHZ,   /* 500MHZ core clock frequency */
 	SPX5_CORE_CLOCK_625MHZ,   /* 625MHZ core clock frequency */
 };
@@ -641,6 +654,8 @@ static inline u32 sparx5_clk_period(enum sparx5_core_clockfreq cclock)
 	switch (cclock) {
 	case SPX5_CORE_CLOCK_250MHZ:
 		return 4000;
+	case SPX5_CORE_CLOCK_328MHZ:
+		return 3048;
 	case SPX5_CORE_CLOCK_500MHZ:
 		return 2000;
 	case SPX5_CORE_CLOCK_625MHZ:
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 9b15e44f9e64..a511f14312f1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -38,6 +38,9 @@ static u64 sparx5_ptp_get_1ppm(struct sparx5 *sparx5)
 	case SPX5_CORE_CLOCK_250MHZ:
 		res = 2301339409586;
 		break;
+	case SPX5_CORE_CLOCK_328MHZ:
+		res = 1756832768924;
+		break;
 	case SPX5_CORE_CLOCK_500MHZ:
 		res = 1150669704793;
 		break;
@@ -60,6 +63,9 @@ static u64 sparx5_ptp_get_nominal_value(struct sparx5 *sparx5)
 	case SPX5_CORE_CLOCK_250MHZ:
 		res = 0x1FF0000000000000;
 		break;
+	case SPX5_CORE_CLOCK_328MHZ:
+		res = 0x18604697DD0F9B5B;
+		break;
 	case SPX5_CORE_CLOCK_500MHZ:
 		res = 0x0FF8000000000000;
 		break;

-- 
2.34.1


