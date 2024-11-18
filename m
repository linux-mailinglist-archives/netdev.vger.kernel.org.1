Return-Path: <netdev+bounces-145828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC2D9D112F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4C8B26367
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779441AA1CF;
	Mon, 18 Nov 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f463fUh6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10AE1A08B6;
	Mon, 18 Nov 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934886; cv=none; b=cXqdE31d9uN7lS87RIAZ9EXTFjXCsuXUTG/sl9dIgUBv3pnR4MrLfq+29c9NPEl2l3bs1ogRsx0Kiq4JYPGhViJ/uzpgMWaOQVa5JLnOwb3NPlkzY3R6yYVauBhg1nd1NYydgbM+15K4FsHAmpNc0Y1YuzC0HmCyiRgCcmDeNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934886; c=relaxed/simple;
	bh=RcHLfgcSHz1AR6bIJm3t4pmOATMcmKjLpWbNz628tX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TDJqWpxCcfu3BEtP4knf4fiCnPtACmIba++gVKA30Dl2BczWDoZ0JYAA0mxKjWgiebbr2OopIWIteZ5ME8/QogjrcuVrKuTW0OU1Fqi8q7mtWhYCqQmyArUnbCs+PgIPK6desuFw6OGuy2WJxDiHtXXB3W1CbCObIcohe5MaFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f463fUh6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731934884; x=1763470884;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RcHLfgcSHz1AR6bIJm3t4pmOATMcmKjLpWbNz628tX0=;
  b=f463fUh6WkzDsfXkkDeI80U9Ews6Dxngjsy+oR75tH5Lch4Mh0/d+2QP
   UZfbLDDZY0CFLg2Hzb1lAsw3Yy6N2H13wHXxZnmp3HfHDtx8vTW8ZGCp+
   OQ2oPYwK5G6vHougJxCNPJtG74mpo+YTDsbvmtx/JntQZnYGJRitSAiTe
   NxPBO+XeGJHVPTzS9Uilf732iitocc6rszdR1suwBcqAJ/1ecKQMxkOF7
   BWFOkb4PgduxNzXUBd5KE/g0v8ppcSdatUiTs5hhMIgH79PvYDuFmSDB0
   2D/4qp5owxaT9WNZPQK1cEemhTUTO8+ZJelmQGkCJJMbxwYYKOwQz3ar5
   w==;
X-CSE-ConnectionGUID: DbRaG4tGSXe42+jZNuS/Pw==
X-CSE-MsgGUID: AXqNjeRfRsyiP4+4YNaafg==
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="37994321"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2024 06:01:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Nov 2024 06:01:12 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Nov 2024 06:01:09 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 18 Nov 2024 14:00:51 +0100
Subject: [PATCH net-next v3 5/8] net: sparx5: verify RGMII speeds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241118-sparx5-lan969x-switch-driver-4-v3-5-3cefee5e7e3a@microchip.com>
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

When doing a port config, we verify the port speed against the PHY mode
and supported speeds of that PHY mode.

Add checks for the four RGMII phy modes: RGMII, RGMII_ID, RGMII_TXID and
RGMII_RXID.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index b494970752fd..9f0f687bd994 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -257,6 +257,15 @@ static int sparx5_port_verify_speed(struct sparx5 *sparx5,
 		     conf->speed != SPEED_25000))
 			return sparx5_port_error(port, conf, SPX5_PERR_SPEED);
 		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		if (conf->speed != SPEED_1000 &&
+		    conf->speed != SPEED_100 &&
+		    conf->speed != SPEED_10)
+			return sparx5_port_error(port, conf, SPX5_PERR_SPEED);
+		break;
 	default:
 		return sparx5_port_error(port, conf, SPX5_PERR_IFTYPE);
 	}

-- 
2.34.1


