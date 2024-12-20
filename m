Return-Path: <netdev+bounces-153693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5284F9F93A1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91A21891E22
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6A21882A;
	Fri, 20 Dec 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wdjcjKI6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26547217714;
	Fri, 20 Dec 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702577; cv=none; b=gt5nrO3AlZaEK0OAy9v+ji44KC3sN551kLyIGz4mncFrppOiUH/sBCmeQxzcJjMooQVUJ7Pt4AeZyAzLCXbGacEutnNX9m9spNCpCwYYCzesgxVvKr/kGFcxEyUh4D0/ekNOQh50PookiNWsc1XjOiRYKVo6eyaltTXlnXnkdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702577; c=relaxed/simple;
	bh=ZtCuUUw/6z67FIWk5TCdAKY5GIL2TBg4zuoZcoCP/PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=H2zGHGiAGO64GMEL1F+aBPDe8+x/GOCq07GvidAswEuTGr5qKxCUE9g0EDnblOXrHDM+5l3AiX3dfpql+3NKH75rGGi5lRAbTWb86VmrZ0dHUX1DzqWUlEjl/eqkOciHOkUQbjp7Wsk6strYC3lpDkO86DuVyjqhYN35eq5UP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wdjcjKI6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734702576; x=1766238576;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZtCuUUw/6z67FIWk5TCdAKY5GIL2TBg4zuoZcoCP/PI=;
  b=wdjcjKI6KI0iQN2X6G1+UMfh9mg1tFlyfqLMnIxP/djn/F2MDpGesA8s
   HwfQxHZwE9/eLIXAtmAhDXpcruSO2xcPYuAv7zS8uCICEuRqQwFYBGiYV
   tuipSFLuSfG0ZSPOXk8mPVT+AgIeCOo33vdJ/AMOIhpjVaLhnxRvmD5br
   n2Eo9i0H8ryMiuwqo/zfwJWWET20/fuq6jIVul3NwjCOlwcIEnswKuXek
   xe+3AmPTVZzrT1O579ebvy7fe1F2Q+kgEESwAIBbGS7ib4wjsc0PRuIc6
   b77ZoYuVlg7283nxHZNuuVPWvuxkvg7s6J2SwknVg3zrgTKYOOTTunTsR
   Q==;
X-CSE-ConnectionGUID: VjWhna/kQWqvw5X1MetOhw==
X-CSE-MsgGUID: JBnhnQwnRtayb1IgA2zJXA==
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="36250026"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 06:49:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 06:49:04 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 06:49:01 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Dec 2024 14:48:43 +0100
Subject: [PATCH net-next v5 4/9] net: sparx5: skip low-speed configuration
 when port is RGMII
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-sparx5-lan969x-switch-driver-4-v5-4-fa8ba5dff732@microchip.com>
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
	<robert.marko@sartura.hr>
X-Mailer: b4 0.14-dev

When doing a port config, we configure low-speed port devices, among
other things. We have a check to ensure, that the device is indeed a
low-speed device, an not a high-speed device. Add an additional check,
to ensure that the device is not an RGMII device.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Tested-by: Robert Marko <robert.marko@sartura.hr>
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


