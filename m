Return-Path: <netdev+bounces-291770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAAuHdjBFWqkaQcAu9opvQ
	(envelope-from <netdev+bounces-291770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:52:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACE5D9178
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB69D30591EF
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8B378807;
	Tue, 26 May 2026 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O+05WKtW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D8377EDF;
	Tue, 26 May 2026 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810073; cv=none; b=q4rqf/PSg1toIxYSaFvUCkwOCr4K16zgS7yy7z+91cFiagAJkqoWtjQoCd7qif+UEJd7+0+KwOvBq0zRjLfWw9JdtvJ91bHWxav+XDCMR2/nHdB5tWJH+RU0lTSuIe4b3HewYpd5ANiv0tYs7l9HpnJ8liQfhFqvPDeZPljnzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810073; c=relaxed/simple;
	bh=u5JTNPjt/nv/5O1/PPBBPqQ34DiJhU+KwdmR4fuGbsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiacZV9IPOt7zaMI50mRHsAY6qToL1kHU/emDMbzrgdRsvExArNgcPi/mT3h4bLvJbsgNC5NAId9y5o6a+Sw7mM8bnm1H9qrdvhLq4GhkhcFPZ7pBp+cZCSUJeLkCYNWB4Di9FQlug4AWf4NC9qJWn3fJc8sIxUzOWPzfbyCJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O+05WKtW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779810071; x=1811346071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u5JTNPjt/nv/5O1/PPBBPqQ34DiJhU+KwdmR4fuGbsI=;
  b=O+05WKtWvn5OpyTDJA97yr6MBpDcz+Y9L5hNWxWCP4XfrdWSI8o4u/e9
   u7GRrP+qaHVLmpmRT/gX/DIIMPWLHSHkBx/94xpOBjR5lZzw3BWDdcr9Y
   XmW4UH9u5C9aESf6cJ6AlIyLL2KQMK8F0VtZxoq3cw1mXBccQfrH+nZVy
   5HBsOdKao43wBRRuNYGnkBN8vYBFkSzPg/QJJn1VbGkdepGIyVJKLXoj/
   M8ra3jubiJeMQYoQFJffxxGB6QwSTuCn42XLgpp4zdFMuo+8R1/I9k9iq
   lMAe5F7mvJC543pJgZHfe2d/cdF/E5MPRj5rFgQIhcUkGPdG4hx8vZsHe
   g==;
X-CSE-ConnectionGUID: rsQBhLVbTfish/5CzWaMiw==
X-CSE-MsgGUID: /2TC3ES/RyKwuIZPSOE3Ig==
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="58485901"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2026 08:41:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 26 May 2026 08:41:05 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 26 May 2026 08:41:02 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 1/2] net: lan743x: add RMII strap status detection for PCI11x1x
Date: Tue, 26 May 2026 21:10:53 +0530
Message-ID: <20260526154054.19829-2-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526154054.19829-1-thangaraj.s@microchip.com>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-291770-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:email,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Queue-Id: E9ACE5D9178
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend pci11x1x_strap_get_status() to read the RMII strap bits from
the STRAP_READ register. The is_rmii_en flag is initialized to
false and updated based on the hardware strap only if SGMII is not
already enabled. This ensures correct interface identification during
adapter initialization.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 7 +++++++
 drivers/net/ethernet/microchip/lan743x_main.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f3332417162e..7d6ffaf13b5e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -42,6 +42,7 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 	u32 strap;
 	int ret;
 
+	adapter->is_rmii_en = false;
 	/* Timeout = 100 (i.e. 1 sec (10 msce * 100)) */
 	ret = lan743x_hs_syslock_acquire(adapter, 100);
 	if (ret < 0) {
@@ -73,6 +74,12 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_sgmii_en = false;
 		}
 	}
+
+	if (!adapter->is_sgmii_en && strap & STRAP_READ_USE_RMII_EN_) {
+		if (strap & STRAP_READ_RMII_EN_)
+			adapter->is_rmii_en = true;
+	}
+
 	netif_dbg(adapter, drv, adapter->netdev,
 		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
 }
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 160d94a7cee6..1d7d37456553 100644
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
@@ -1071,6 +1073,7 @@ struct lan743x_adapter {
 	struct lan743x_rx       rx[LAN743X_USED_RX_CHANNELS];
 	bool			is_pci11x1x;
 	bool			is_sgmii_en;
+	bool			is_rmii_en;
 	/* protect ethernet syslock */
 	spinlock_t		eth_syslock_spinlock;
 	bool			eth_syslock_en;
-- 
2.34.1


