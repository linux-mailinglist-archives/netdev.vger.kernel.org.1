Return-Path: <netdev+bounces-153691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D271C9F9398
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918EE188BB93
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AC217706;
	Fri, 20 Dec 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZqAQQ5BL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D255215771;
	Fri, 20 Dec 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702576; cv=none; b=CckH4El1bhIvWDnJcrHZx238P0dGr+aCwE4C6J8YhmWJ799lAhJQjVVZ+LNhKcosYrhLpuFTno4Ih/T8SFMyFAWG57uHheY7ftOuaVhr+zDVq1D5jp2pb2nUMCI4iyxIEPYkRPTDbdxNttIbmbS2E+aL8HoxgetW7/r4pIjlnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702576; c=relaxed/simple;
	bh=DQqXsBk8sYDOENdYyi6xpxkvVQxjssr0ADx5wWVj0Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gtJgrzgfnpsDE3jSXuBRz2sxPepd/waElXtKkCehY48z9w5WahyE9P6rkUJl4hCngiItj+3YADn+68K6Hg//DJQJD5B/RfakayP90h3GtGh4/O6KTN2m+XM38VZVzH2CrJ58KuaIrlLpexXuWgDwhhrq2yQ83wrQL+tEh2UQqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZqAQQ5BL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734702575; x=1766238575;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DQqXsBk8sYDOENdYyi6xpxkvVQxjssr0ADx5wWVj0Lw=;
  b=ZqAQQ5BL8tSxNSZOtWl8F3KHGPM80VcPhdS4+LjYcOQeIbQnF7d9jUuz
   YVn46yCPKFAgcbc884owXNEMq5UX5eJhtii6NLVMmNceW2DeHcBrLSydE
   alirM7Du3xkKTZf/5RVLzNV0zZOyke/4qjGhWT/eCN8o9sRivS1AEhLbF
   gfZvwh8WgIc97pz9nNkOGqQl1ST8fHYywJ5IKbVds2cegJQKk7Sdx2RUe
   IaJve1swM8EoTPSgcrcaKjBoD+bIkRQAKeYFcLMRYx7Svvugcp4R+fi3k
   aiuwwKd2frTwz4Qu9z95uvq0SUdQhDZ9Sw9ZSeI4cizPR2wYeh8UJfMhU
   g==;
X-CSE-ConnectionGUID: mIAoSPyhQLi+IAfuQfXUsw==
X-CSE-MsgGUID: mOJ13HshSOSgpieaCq6k9g==
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="267028401"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 06:49:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 06:49:08 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 06:49:05 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Dec 2024 14:48:44 +0100
Subject: [PATCH net-next v5 5/9] net: sparx5: only return PCS for modes
 that require it
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-sparx5-lan969x-switch-driver-4-v5-5-fa8ba5dff732@microchip.com>
References: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
In-Reply-To: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.14-dev

The RGMII ports have no PCS to configure. Make sure we only return the
PCS for port modes that require it.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Tested-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
index f8562c1a894d..035d2f1bea0d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
@@ -32,7 +32,19 @@ sparx5_phylink_mac_select_pcs(struct phylink_config *config,
 {
 	struct sparx5_port *port = netdev_priv(to_net_dev(config->dev));
 
-	return &port->phylink_pcs;
+	/* Return the PCS for all the modes that require it. */
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_5GBASER:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_25GBASER:
+		return &port->phylink_pcs;
+	default:
+		return NULL;
+	}
 }
 
 static void sparx5_phylink_mac_config(struct phylink_config *config,

-- 
2.34.1


