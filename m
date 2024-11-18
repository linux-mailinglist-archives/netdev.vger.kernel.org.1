Return-Path: <netdev+bounces-145825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E79D1123
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACA128260C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC71A00F2;
	Mon, 18 Nov 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1mmvMLoj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0B19D8BE;
	Mon, 18 Nov 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934884; cv=none; b=oc9Tliz58oCjJuDJ9r9Pb956XR/zpmehnvPauA79PcOwxhC19SG8mPTC/VMB8034R+NwOiDYqnJuEYatsmMeddc81Deg0nOLDnbBG21L3VzbSAV8yBYHQls+qzlG9hqlzQ7izXHG503B22Ciq2q3t5d29HFyxW95fkKnKMgWmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934884; c=relaxed/simple;
	bh=gZ500P10yVXIKdiPBJoAEnTl8gEfa/8nVoOA0fZ9N88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SsRU562Mt9D6gZ/Umfv9+dm4exeKy63bnmdwqbRRk+ZnFn30I8ODQ80AE2aa3nyQHTfiryyThO5Ocq2nb0GvIgFlZGDOjM6yv39jiOJ+Diy1vt50xHLTwYISUYUqC8ErrrWRNUEJxo944WMteNBYu9Z9eloKUrJOsVvfF3jXceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1mmvMLoj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731934883; x=1763470883;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gZ500P10yVXIKdiPBJoAEnTl8gEfa/8nVoOA0fZ9N88=;
  b=1mmvMLoj7de36EzfygnLstSvegO4Eqh7Ygqk46nzwCH/6n7RLNaKWRx0
   9hGZpEn2a8mjMCLAB2c+D2TuSDZlbaFbi5pDXEQ0GUArXVqFseyl4bWNd
   6U11FPfG3hDvuitZX3ga1BRQkPAJkYbmxd7OOc8nYxXFx7H51MmEPHd1F
   3kK2YLYmLRifHcIoKie1hbLFBSURdvq82ySWeoXDYlXzEKlX98obJahnl
   /ohugY8t2z0ZyPbk2dJS5o/CWGt+2JzQj2IxX4NTdlxaS4vGHsF6aYLOt
   0r00mi05lNLcvS9vpMVGApe6XM+pzPPgtW0A0DoxRElnU4bsFwQqHwtNj
   g==;
X-CSE-ConnectionGUID: pV1s/Z6yQPOamzioY1xjCw==
X-CSE-MsgGUID: i7jMq5UWQsG/P94Fk0Tifg==
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="34953031"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2024 06:01:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Nov 2024 06:01:09 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Nov 2024 06:01:06 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 18 Nov 2024 14:00:50 +0100
Subject: [PATCH net-next v3 4/8] net: sparx5: use
 phy_interface_mode_is_rgmii()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241118-sparx5-lan969x-switch-driver-4-v3-4-3cefee5e7e3a@microchip.com>
References: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
In-Reply-To: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

Use the phy_interface_mode_is_rgmii() function to check if the PHY mode
is set to any of: RGMII, RGMII_ID, RGMII_RXID or RGMII_TXID in the
following places:

 - When selecting the MAC PCS, make sure we return NULL in case the PHY
   mode is RGMII (as there is no PCS to configure).

 - When doing a port config, make sure we do not do the low-speed device
   configuration, in case the PHY mode is RGMII.

Note that we could also have used is_port_rgmii() here, but it makes
more sense to me to use the phylink provided functions, as we are
called by phylink, and the RGMII modes have already been validated
against the supported interfaces of the ports.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c | 3 +++
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c    | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
index f8562c1a894d..cb55e05e5611 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
@@ -32,6 +32,9 @@ sparx5_phylink_mac_select_pcs(struct phylink_config *config,
 {
 	struct sparx5_port *port = netdev_priv(to_net_dev(config->dev));
 
+	if (phy_interface_mode_is_rgmii(interface))
+		return NULL;
+
 	return &port->phylink_pcs;
 }
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 8f4f19a2bd65..b494970752fd 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -994,6 +994,7 @@ int sparx5_port_config(struct sparx5 *sparx5,
 		       struct sparx5_port *port,
 		       struct sparx5_port_config *conf)
 {
+	bool rgmii = phy_interface_mode_is_rgmii(conf->phy_mode);
 	bool high_speed_dev = sparx5_is_baser(conf->portmode);
 	const struct sparx5_ops *ops = sparx5->data->ops;
 	int err, urgency, stop_wm;
@@ -1003,7 +1004,7 @@ int sparx5_port_config(struct sparx5 *sparx5,
 		return err;
 
 	/* high speed device is already configured */
-	if (!high_speed_dev)
+	if (!rgmii && !high_speed_dev)
 		sparx5_port_config_low_set(sparx5, port, conf);
 
 	/* Configure flow control */

-- 
2.34.1


