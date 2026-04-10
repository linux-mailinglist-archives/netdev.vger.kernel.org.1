Return-Path: <netdev+bounces-277305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B8oGXy72GmmhQgAu9opvQ
	(envelope-from <netdev+bounces-277305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:57:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC43D4682
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42F493004910
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11133AA51D;
	Fri, 10 Apr 2026 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mwIcnVoR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B313AD51B;
	Fri, 10 Apr 2026 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811447; cv=none; b=qXyjsWj1f5bMKldhNk61V0pHCSeiSqNE1NBxfAQfla8JjIsgZ0Ro2Hg2HRGGc5d/5LGPnVuo7ysGwEBYE4iesCGLLf8LsBbNj17YsclMkZAJZSIce0+OAF9jB6FWk38gMGYsjU1axw/CufAblKBrRzcVfD3v2JwJYA1nAEqC138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811447; c=relaxed/simple;
	bh=zPonBjj2W3jsUQ+gNcr9aSITP9viwV36SEGBbrB1juo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QcYXVuIgXNjm7tpKju3Uk4VyweSFe87p8uvjXY3dQ4XoFsnWpAoN4TV3D5XY2eqc0PyAurWKcxagbD+l2kL+ROGwfRtJ3BZem8B5bE6ME41OeuI1hlu2HjVFGvUijAjudqBvTENFHc/Ts80foZHGfHMup45gUtlYf4q5/4jJtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mwIcnVoR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775811444; x=1807347444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zPonBjj2W3jsUQ+gNcr9aSITP9viwV36SEGBbrB1juo=;
  b=mwIcnVoRmpqOoZbkvzkz6oRHl9mL1RCZ0KQDgJcksD12Mi+2+dhYBgCZ
   42KePe95isXAj11LMNCikwOT27+ahN9z2sIwbFBC7B4nyAM4eJcBxObDT
   9CVNjBrlOKD2pSXm+sZsxUEMLhAC+P4jUAv/vhjU3GavGWhrSaiczucxt
   U+vEprlQ/AAk9pK/gSbHz7Vz8O3XNWFBaaAk1H6Kv2hHSk+htnpcLFNsQ
   qvgW8KONnzukb3wjzIYw3s3Fmxlae7SBv2ghDxtuDPUldoU5DgoXAMkKm
   7KF7yAy7eq0Frw+m+SX73km9d89ApqRnqphPE5509yaXF5MWAPp0QIuvt
   g==;
X-CSE-ConnectionGUID: uH/kOClzTs2gK5JOehpkWw==
X-CSE-MsgGUID: 6oGeLdW6ROmJIk9q1duyaw==
X-IronPort-AV: E=Sophos;i="6.23,171,1770620400"; 
   d="scan'208";a="55162218"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:57:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 10 Apr 2026 01:57:16 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 10 Apr 2026 01:57:13 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: lan743x: rename chip_rev to fpga_rev
Date: Fri, 10 Apr 2026 14:27:10 +0530
Message-ID: <20260410085710.9246-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-277305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CEC43D4682
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variable chip_rev stores the value read from the FPGA_REV
register and represents the FPGA revision. Rename it to fpga_rev
to better reflect its meaning.

No functional change intended.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index b4cabde6625a..f3332417162e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -36,7 +36,7 @@ static bool pci11x1x_is_a0(struct lan743x_adapter *adapter)
 
 static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
-	u32 chip_rev;
+	u32 fpga_rev;
 	u32 cfg_load;
 	u32 hw_cfg;
 	u32 strap;
@@ -63,9 +63,9 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 		else
 			adapter->is_sgmii_en = false;
 	} else {
-		chip_rev = lan743x_csr_read(adapter, FPGA_REV);
-		if (chip_rev) {
-			if (chip_rev & FPGA_SGMII_OP)
+		fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
+		if (fpga_rev) {
+			if (fpga_rev & FPGA_SGMII_OP)
 				adapter->is_sgmii_en = true;
 			else
 				adapter->is_sgmii_en = false;
-- 
2.34.1


