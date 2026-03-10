Return-Path: <netdev+bounces-266346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKo5Fl2NsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4F2584C4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A450324A7B2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AB3C8724;
	Tue, 10 Mar 2026 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J/M7YFWl"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD703F0775;
	Tue, 10 Mar 2026 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177812; cv=none; b=MFQOW8kJVT2hcbGjjAegKFIYirxwGl8HSdEpj+EbQ1WRWzuUrt3w/prJ/gxjjZ2F6t6WsiVLTa5a+rQnqhaAfiECE32+INxZfndlLzFUyIcegeU8nAmdyi3xUHkPt5gnEBEaFQHl2g2Zrc20woDudKU9EG3O9Rj1rDFlCrcVoas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177812; c=relaxed/simple;
	bh=VVyrO46ggUtH5dYSmpUwCJwPzHoFuASF4LLfOrCMNKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWtZZZQW8Ehe1Gyydhg5HqrcBJL26AxXMcFZbJMQ1uHlRvafkSW1p+azuKsaJULWYmlQEsa/Ny9xtqSIPHuQLTZWvJ1gBU/sQIWOLSaLP0vEmCcDbxIbJ8Cs4aY4+ybOosLeaDM2YioP3DfWHCf55z3L0rFJXxtaJlqgDqcd6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J/M7YFWl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773177806; x=1804713806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VVyrO46ggUtH5dYSmpUwCJwPzHoFuASF4LLfOrCMNKA=;
  b=J/M7YFWlACbqnE4J+Bfmf7hhg7okviNOfCbCNm/gpopnpgNArJC8JIjl
   M5SISm6OXTlzzugibEhZx97ZnAnDOGNmjxWDxl1DwYvCp7HhQn+hzKuZt
   tdai1QeusrjrZmcKpC3Dx0Oh1tPCiG4bgWKA0olUpnVNzr7NTdqavI/Pz
   soR+BUFmtRXL9hwbxlJx4VTXA3I6Eq6q2oVSlCAYlwgYh+vZk4Bdl7tRi
   rvJHQDUHOlJJnDGuBU9qkz2E39/fyidDFfF2MDo9C71MAKQyxgutdlkBy
   XoLIhrEw8oC+YN2usOfUXK2RAJ2AGkaOd2+v9ARX57UzsRTquPVjvH4Fw
   w==;
X-CSE-ConnectionGUID: A5M1IvIGR8Kc/SXjbvrhaA==
X-CSE-MsgGUID: QeXzYW+zREyCHHMlD36xCA==
X-IronPort-AV: E=Sophos;i="6.23,112,1770620400"; 
   d="scan'208";a="54912637"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2026 14:23:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 10 Mar 2026 14:22:59 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 10 Mar 2026 14:22:59 -0700
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
Subject: [PATCH net-next v2 3/3] net: macb: add support for Microchip pic64hpsc ethernet endpoint
Date: Tue, 10 Mar 2026 14:22:02 -0700
Message-ID: <20260310212202.3991199-4-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310212202.3991199-1-charles.perry@microchip.com>
References: <20260310212202.3991199-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: DFD4F2584C4
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-266346-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Action: no action

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
 drivers/net/ethernet/cadence/macb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 96e15f58e173..d1fc6a9b9fe5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5414,6 +5414,15 @@ static const struct macb_config raspberrypi_rp1_config = {
 	.jumbo_max_len = 10240,
 };
 
+static const struct macb_config pic64hpsc_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_USRIO_DISABLED,
+	.dma_burst_length = 16,
+	.clk_init = macb_clk_init,
+	.init = init_reset_optional,
+	.jumbo_max_len = 16383,
+};
+
 static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,at91sam9260-macb", .data = &at91sam9260_config },
 	{ .compatible = "cdns,macb" },
@@ -5432,6 +5441,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,zynq-gem", .data = &zynq_config }, /* deprecated */
 	{ .compatible = "sifive,fu540-c000-gem", .data = &fu540_c000_config },
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
+	{ .compatible = "microchip,pic64hpsc-gem", .data = &pic64hpsc_config},
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
 	{ .compatible = "mobileye,eyeq5-gem", .data = &eyeq5_config },
-- 
2.47.3


