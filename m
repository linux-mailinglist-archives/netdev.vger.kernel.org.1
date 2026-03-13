Return-Path: <netdev+bounces-267472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEsAKJMbtGlLhQAAu9opvQ
	(envelope-from <netdev+bounces-267472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:13:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049B284AB8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B0632D8330
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF9371884;
	Fri, 13 Mar 2026 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ezpu2I3U"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E8336887;
	Fri, 13 Mar 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410847; cv=none; b=LUnlr0zOwhSezlADD6GNdqMWqdftS0R13wVs5gWr2JXTpS570G6Ah2QHYCd4MBbL1jVBiwZ4rR9f0gwe+fxR4CU3pEQJq2XFdOyKv5neOPM0hMtKywvSHFdJ2Vwl8em2+LtfZ8ASYz6IHE/xJtzzf0hTIYH1SkXOrw28f3QuYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410847; c=relaxed/simple;
	bh=5Acg9CGaZtA13cxA3Glo77VuchPa23MsbsvlqgX73cU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnsaVVxvBRlLlUuQC/zNDRBl5pf02xbGYKPmHmRCK6GKA3L1Ps1I4nP5wXVKDk93ZQRFWemRHWqIx16Q0XCSgS0mf4Sz8gCRuvp47diTpSGO07kR44rWKrF38S89iGxaClQABBz8ZFo7EhXT5oypTnOdrsn7hMNlqAnykVzvziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ezpu2I3U; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773410846; x=1804946846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Acg9CGaZtA13cxA3Glo77VuchPa23MsbsvlqgX73cU=;
  b=ezpu2I3UochJH9rDZ44YlYFXDXRjfG5s+ucUPC/hsu82JjlTujaP8BOu
   DB2OgcanyDvGAPoZGxnES0cuJHVjoH3X1ZDwRegXGLO8kAFiaLW3Uu19c
   NeknlgGjwupSLBZIWsb9klfFdSQUjzl+9bh79RToBDyvf0Z0Gx2oQ9apb
   hAl2Nx1/GTF/3V2zeL1GduWHL4bgk3TCOYPJiH4BcTPHPT2AL+v5q2GBE
   pm3AIdEnWRx6arr6DwZM7l4mbrB59iu3SWP+4pG63NcTx///oDK2MCtFs
   DveGZPBcEB4mqcCiwAsK7yW2IPkm36YFSL4JtnWuFvvZvCZR6bvTvsK1L
   w==;
X-CSE-ConnectionGUID: POGdrE6UQh+zFq3Y+VGZ5g==
X-CSE-MsgGUID: DA6iPSUYQ3WG74wDgn5QmQ==
X-IronPort-AV: E=Sophos;i="6.23,118,1770620400"; 
   d="scan'208";a="221884778"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:07:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 13 Mar 2026 07:06:47 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Mar 2026 07:06:46 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 3/3] net: macb: add support for Microchip pic64hpsc ethernet endpoint
Date: Fri, 13 Mar 2026 07:06:10 -0700
Message-ID: <20260313140610.3681752-4-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313140610.3681752-1-charles.perry@microchip.com>
References: <20260313140610.3681752-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267472-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Queue-Id: 2049B284AB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pic64hpsc doesn't have the USRIO register so MACB_CAPS_USRIO_DISABLED is
used.

pic64hpsc does support PTP and has the timestamping unit so
MACB_CAPS_GEM_HAS_PTP is used.

jumbo_max_len is set to 16383 (0x3FFF) as reported by the DCFG2 register
bits 0..13. The JML register also has a default value of 0x3FFF.

dma_burst_length is set to 16 because that's what most other platforms
use and it worked for me so far. There is one other mode where bursts of
up to 256 are allowed but this might impact negatively other masters on
the NOC.  The register default value is 4 (bursts up to 4).

Signed-off-by: Charles Perry <charles.perry@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c653ea6cadef..66939c5cf926 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5626,6 +5626,14 @@ static const struct macb_config raspberrypi_rp1_config = {
 	.jumbo_max_len = 10240,
 };
 
+static const struct macb_config pic64hpsc_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_USRIO_DISABLED,
+	.dma_burst_length = 16,
+	.init = init_reset_optional,
+	.jumbo_max_len = 16383,
+};
+
 static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,at91sam9260-macb", .data = &at91sam9260_config },
 	{ .compatible = "cdns,macb" },
@@ -5644,6 +5652,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,zynq-gem", .data = &zynq_config }, /* deprecated */
 	{ .compatible = "sifive,fu540-c000-gem", .data = &fu540_c000_config },
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
+	{ .compatible = "microchip,pic64hpsc-gem", .data = &pic64hpsc_config},
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
 	{ .compatible = "mobileye,eyeq5-gem", .data = &eyeq5_config },
-- 
2.47.3


