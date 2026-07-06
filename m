Return-Path: <netdev+bounces-304930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id imeHOux5S2pOSAEAu9opvQ
	(envelope-from <netdev+bounces-304930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:48:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E894070EC37
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:48:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=N+inEnI+;
	dmarc=pass (policy=reject) header.from=microchip.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304930-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304930-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71E18300107A
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B25342A166;
	Mon,  6 Jul 2026 09:34:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06D422548;
	Mon,  6 Jul 2026 09:33:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330443; cv=none; b=bhOwsWx3aKRznb7Ul90A+yWoJUZ9n+ZcafskTI6PR9hNlMZb/KJzR487KU781S3fBdO/O/5rakO1FTviXCov5hkWCxJmS1VgahTLX73GYefbliAcCk9wDR+0zo41UgvhtyUJ4whPn6PveDQgI8FiNE+aKi4kDUleTsnyOvnio6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330443; c=relaxed/simple;
	bh=1JL2JcRPykcNOXZTIj7DSdSZdXzQeo47vikrlB/NC40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUgD1agprPu7i6wceoxja+AbqmDIr2VfHm6b3Buk3XBamvhbtNutTG0B4bgiq65U/HbvHBgx12UXCL/k6Sc+01dx5bj8jtH961KNHDLJll3g/plQSY5t6yWjirG7C0NQpFqaYy8Qig2c/hO62OeScoUYLhUx0izxht7frfHNLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N+inEnI+; arc=none smtp.client-ip=68.232.154.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1783330439; x=1814866439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JL2JcRPykcNOXZTIj7DSdSZdXzQeo47vikrlB/NC40=;
  b=N+inEnI+PX1842HbuFOn5Vq2O+neCXZFFjMn+7orTtZ3SFb8t6hi1uOa
   kW63W2zf2H56MI8ShkQeLSyy0c15ZODP2Er1Cc+ITkRmORJ06ZLPXNJmf
   5LxQxuOYlk5VT6b3nbaIlsDYakTEaMMoPMYFXkx5JvnVtHOG5xK/izw91
   jPFmH5R4tllKbvaHMyNrEGVzOPQ0CEdvbyseIg+nNM5lGH8GDX0v6F2cy
   FicdFDc0kBNFq6mvJsNIFlw+JC1vbu+7CuKkZcV4xik9LzvSIo8Sr+t+P
   iI+sNkcQgI0BzMEe2zbgnVv9mzrNU3RR/gEeDmbLNmAkGtGdalJp4FRN0
   A==;
X-CSE-ConnectionGUID: srxHzna7TxyI0LjVtT+l4Q==
X-CSE-MsgGUID: bmiwaOOeR2mncEczngPfzg==
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="60494878"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:32:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 6 Jul 2026 02:32:53 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 6 Jul 2026 02:32:49 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 1/2] net: lan743x: add RMII strap status detection for PCI11x1x
Date: Mon, 6 Jul 2026 15:01:49 +0530
Message-ID: <20260706093150.9033-2-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093150.9033-1-thangaraj.s@microchip.com>
References: <20260706093150.9033-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304930-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E894070EC37

Extend pci11x1x_strap_get_status() to read the RMII strap bits from
the STRAP_READ register. The is_rmii_en flag is initialized to
false and updated based on the hardware strap only if SGMII is not
already enabled. This ensures correct interface identification during
adapter initialization.

Update the netif_dbg() to report the selected interface as SGMII,
RMII, or RGMII.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 12 ++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e759171bfd76..3a418105cd11 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -42,6 +42,7 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 	u32 strap;
 	int ret;
 
+	adapter->is_rmii_en = false;
 	/* Timeout = 100 (i.e. 1 sec (10 msce * 100)) */
 	ret = lan743x_hs_syslock_acquire(adapter, 100);
 	if (ret < 0) {
@@ -73,8 +74,15 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_sgmii_en = false;
 		}
 	}
-	netif_dbg(adapter, drv, adapter->netdev,
-		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
+
+	if (!adapter->is_sgmii_en && strap & STRAP_READ_USE_RMII_EN_) {
+		if (strap & STRAP_READ_RMII_EN_)
+			adapter->is_rmii_en = true;
+	}
+
+	netif_dbg(adapter, drv, adapter->netdev, "Selected I/F: %s\n",
+		  adapter->is_sgmii_en ? "SGMII" :
+		  adapter->is_rmii_en  ? "RMII"  : "RGMII");
 }
 
 static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 1573c8f9c993..1f8d9294a6ef 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -36,7 +36,9 @@
 #define FPGA_SGMII_OP			BIT(24)
 
 #define STRAP_READ			(0x0C)
+#define STRAP_READ_USE_RMII_EN_		BIT(23)
 #define STRAP_READ_USE_SGMII_EN_	BIT(22)
+#define STRAP_READ_RMII_EN_		BIT(7)
 #define STRAP_READ_SGMII_EN_		BIT(6)
 #define STRAP_READ_SGMII_REFCLK_	BIT(5)
 #define STRAP_READ_SGMII_2_5G_		BIT(4)
@@ -1072,6 +1074,7 @@ struct lan743x_adapter {
 	struct lan743x_rx       rx[LAN743X_USED_RX_CHANNELS];
 	bool			is_pci11x1x;
 	bool			is_sgmii_en;
+	bool			is_rmii_en;
 	/* protect ethernet syslock */
 	spinlock_t		eth_syslock_spinlock;
 	bool			eth_syslock_en;
-- 
2.34.1


