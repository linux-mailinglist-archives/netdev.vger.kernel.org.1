Return-Path: <netdev+bounces-151781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196329F0D85
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7C7281ED5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978AD1E2610;
	Fri, 13 Dec 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y9HrDAwp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A61E0DD6;
	Fri, 13 Dec 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097329; cv=none; b=kB8F+FWKLAPO1N6sdn/4QtmryNniX0jLUkMw30Rph/FKJzXf7s5qlMOp3t4pQW/htG2JyKf29+SsUeC7oDog/Ec/vwK6jK9NJi65acryeJIiyUQgqIE01uQKxmNF2S0HHNCdLEphLOEC9CrjVTdM7B1GfdrHuP0KZ2t5ROm5g1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097329; c=relaxed/simple;
	bh=F3r/K1kISTkKC1t7Gw8laQbefuONz2HC9HBE8faHn18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=slyiEycga2Yn3Bkl5/GfAgETVdyGq+6svkx5zvr9dcYsXB2EtMM+ESadA94r+9bYCLk+tXAJ32vsK1PQycV6znCuY4dqU0npcKqPjm+bwpKYrb/uBuzsPkTj7Orbx3/aAwzNdmvcAk5Zl7qbNP4ZHQ6/Ezk8qPESmHzV2IU0XEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y9HrDAwp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734097327; x=1765633327;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=F3r/K1kISTkKC1t7Gw8laQbefuONz2HC9HBE8faHn18=;
  b=y9HrDAwpw6ZC+kAyef/Fbt9TQJ7m3iwFOnmza4aFL3zhc6edyTQ5Q7qu
   HsiQ2N8xeDw8rgteff14vDGcc6DuG1K2sf7XU2KE6FKIjzCW6VFhZUloG
   D9oE3SIIRJRbnp4G0l1dWOxq9LE2GQNeNB41vawl9xgIsftYNb0d8um7i
   Zy+h+OWRo3EJHXVPl6CsBUBGQ9qho7d3yNmYB7TaZl5n6hYFqqYEyKYxq
   XNji9xf7goi76Qq0LqSlfZfbR7RQiPP2GBiIImUKOoWWpJK6PUFY9Tp6G
   sWPhHM5xtjFEWLQ2q8PKVrQJ40NN15A799KCM13BCl9nJy6qmLY9K74X5
   g==;
X-CSE-ConnectionGUID: itc9LroWQgSaHh3I2qeP/g==
X-CSE-MsgGUID: 71gWVYObRKGWL70ZOac+/w==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="39217648"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 06:42:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 06:41:36 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 06:41:33 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 13 Dec 2024 14:41:05 +0100
Subject: [PATCH net-next v4 6/9] net: sparx5: verify RGMII speeds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241213-sparx5-lan969x-switch-driver-4-v4-6-d1a72c9c4714@microchip.com>
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

When doing a port config, we verify the port speed against the PHY mode
and supported speeds of that PHY mode. Add checks for the four RGMII phy
modes: RGMII, RGMII_ID, RGMII_TXID and RGMII_RXID.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 0a1374422ccb..86d6c9e9ec7c 100644
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


