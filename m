Return-Path: <netdev+bounces-151778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639839F0D79
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5EB16935F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7501E0DF2;
	Fri, 13 Dec 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X2DNIj4D"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE761E04AE;
	Fri, 13 Dec 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097294; cv=none; b=MOrmlRFabvWsdDi75z1NVhxeY7ukVW6bnrdzOcg+CVcMgOYURMBj2Ity/Xn2u5Bce7Oj7RUzbp4OtuRFXmSY6FDnk0h6xDI0WL+psE54g4JhZUF96MA6YvRNL0zoXFmUXN2ou1ak2li2qThaw2Ds/kE/2pc2O5A9muGibUDEdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097294; c=relaxed/simple;
	bh=vWMNHcXRs0gknr7PT4AktBKztNuboV1cArBDjIgJWRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ENG3TGcxxylK8O6ocPSqof5Xcnr9Y6/fxGGRCilLi8EWvitXpg9XRfsCyRSj451wTfPu88bPOMk9Ji9SgpR0eJA1MjwtNe2SwRGjv+JCyLnS+YX/YWnFop1cKuBCLecP1qy7qQar5T0NA45PEfMG7AOeUcoC6ZXqcYT7va4/35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X2DNIj4D; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734097292; x=1765633292;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vWMNHcXRs0gknr7PT4AktBKztNuboV1cArBDjIgJWRg=;
  b=X2DNIj4DzFyiBdSWykUojRAID5stXJayqqjgZLWzZjAzyqKqwAmTNWmA
   vznuViqx55ivxrNkjcvWqSsX559X/GaoM/h2JtaDH16E8ThzwHOdWaglf
   8lPNiizfkhUwTx7xPFPSbjJ5DUFETv98Sg1Tor/Zpo0GLJiabJc6yUDOP
   oa1cMnCj6FwBKUR7H1JTzMKfKgdOqJQpDjWHCWGF0j/3IcvmbYtbG7uiD
   itgONkav6LPpz/lstVQqEDORncdcvOQmv4pBtNBF6vVDFC7XIIegpINcS
   02cERgIufp3cwmdjrKaoO2tx/YFunOwvE1NojVw5MMwZdm3KXPdaxXJXK
   A==;
X-CSE-ConnectionGUID: +Dz6lc3EQgqK8+CPf2Bkrw==
X-CSE-MsgGUID: 4sh031OSRVSAX7w8H69PeQ==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="202965473"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 06:41:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 06:41:29 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 06:41:26 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 13 Dec 2024 14:41:03 +0100
Subject: [PATCH net-next v4 4/9] net: sparx5: skip low-speed configuration
 when port is RGMII
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241213-sparx5-lan969x-switch-driver-4-v4-4-d1a72c9c4714@microchip.com>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
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
	<robert.marko@sartura.hr>
X-Mailer: b4 0.14-dev

When doing a port config, we configure low-speed port devices, among
other things. We have a check to ensure, that the device is indeed a
low-speed device, an not a high-speed device. Add an additional check,
to ensure that the device is not an RGMII device.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 996dc4343019..0a1374422ccb 100644
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


