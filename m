Return-Path: <netdev+bounces-13437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904B73B9E1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16F5281C2C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6330AD4A;
	Fri, 23 Jun 2023 14:17:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE6100B6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:17:34 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540AC10D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=npkaTZ8i1DMcOkcpPkQEXRjBMNY/dOpptseL3fShnLs=; b=ewJAlvE7pY74DLybvB6tRMjHb/
	+ATgHVgs6OX/HD1545EN3cFMWx8eHCqr+6LELk+nSv2HnUdGj26HHGgV/BQNcWPZtLLtJqZOAg0Ol
	hOw8mOMJieu291xFXvXkurCwzp8bGpM0VjTBEMoorQzYJElaZ7sly+/mXY5r86Qg3AZ3MXe877/lS
	IuYAQzPKI0bezAkwMzV2KjlrKSiVz1rkaGPRhgw3iXv05aw7HV7k9Xmdt7xuzcdAFH6Zn8cVQdo5w
	G8baAoOt5hyPzXx7b2CBbGg7QR8lkzMU0Fb/XxLmkqR4R7vPYRnjUH4h32/WtA4sO9UuJnn11t/OV
	J6FUrNRg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35954 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qChbJ-0005Pw-DM; Fri, 23 Jun 2023 15:17:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qChbI-00Fms3-N2; Fri, 23 Jun 2023 15:17:24 +0100
In-Reply-To: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
References: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 07/14] net: dsa: mv88e6xxx: export
 mv88e6xxx_pcs_decode_state()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qChbI-00Fms3-N2@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jun 2023 15:17:24 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rename and export the PCS state decoding function so our PCS can
make use of the functionality provided by this.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/serdes.c | 11 +++++------
 drivers/net/dsa/mv88e6xxx/serdes.h |  5 +++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 80167d53212f..7ea36d04d9fa 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -45,9 +45,8 @@ static int mv88e6390_serdes_write(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_phy_write_c45(chip, lane, device, reg, val);
 }
 
-static int mv88e6xxx_serdes_pcs_get_state(struct mv88e6xxx_chip *chip,
-					  u16 bmsr, u16 lpa, u16 status,
-					  struct phylink_link_state *state)
+int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
+			       u16 status, struct phylink_link_state *state)
 {
 	state->link = false;
 
@@ -88,7 +87,7 @@ static int mv88e6xxx_serdes_pcs_get_state(struct mv88e6xxx_chip *chip,
 			state->speed = SPEED_10;
 			break;
 		default:
-			dev_err(chip->dev, "invalid PHY speed\n");
+			dev_err(dev, "invalid PHY speed\n");
 			return -EINVAL;
 		}
 	} else if (state->link &&
@@ -211,7 +210,7 @@ int mv88e6352_serdes_pcs_get_state(struct mv88e6xxx_chip *chip, int port,
 		return err;
 	}
 
-	return mv88e6xxx_serdes_pcs_get_state(chip, bmsr, lpa, status, state);
+	return mv88e6xxx_pcs_decode_state(chip->dev, bmsr, lpa, status, state);
 }
 
 int mv88e6352_serdes_pcs_an_restart(struct mv88e6xxx_chip *chip, int port,
@@ -942,7 +941,7 @@ static int mv88e6390_serdes_pcs_get_state_sgmii(struct mv88e6xxx_chip *chip,
 		return err;
 	}
 
-	return mv88e6xxx_serdes_pcs_get_state(chip, bmsr, lpa, status, state);
+	return mv88e6xxx_pcs_decode_state(chip->dev, bmsr, lpa, status, state);
 }
 
 static int mv88e6390_serdes_pcs_get_state_10g(struct mv88e6xxx_chip *chip,
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index e245687ddb1d..93d40d66d7c5 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -12,6 +12,8 @@
 
 #include "chip.h"
 
+struct phylink_link_state;
+
 #define MV88E6352_ADDR_SERDES		0x0f
 #define MV88E6352_SERDES_PAGE_FIBER	0x01
 #define MV88E6352_SERDES_IRQ		0x0b
@@ -107,6 +109,9 @@
 #define MV88E6393X_ERRATA_4_8_REG		0xF074
 #define MV88E6393X_ERRATA_4_8_BIT		BIT(14)
 
+int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
+			       u16 status, struct phylink_link_state *state);
+
 int mv88e6185_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
-- 
2.30.2


