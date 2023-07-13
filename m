Return-Path: <netdev+bounces-17472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F3751BF4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B261C21294
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EECDFBE1;
	Thu, 13 Jul 2023 08:42:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C6F9F3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:42:45 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989730E8
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=npkaTZ8i1DMcOkcpPkQEXRjBMNY/dOpptseL3fShnLs=; b=ULdoi5hSB9W+Ta8PRLmKaGokyw
	ImvpcN71uXG8OngR4HZUlBVVIE++Ludi0hiuXZobxoVv3gtsRG7JW+99AWI9FX8tiF6p7N8gWyI0K
	uheUUiLK3jL2leVoSRu7ul5551ituuYEGK5kgyubG9jR7qr0z2CeyZiJbRv5nQPEB79uHm+8lxbRo
	qataNkRgkZV8KbEECDTJPn1sUWfZCGYkM70/5yuCrX9Z3iISVI2d2Oysv1FN9+4o33mYnKG/FiSTj
	srzkNGEJxDZXteaDrTs7TIr5SAo4Iida/xtra36CYpmduhiUJXXjlSyBKGDL+ew5sSR2ATsgzpRuZ
	w0+edH/A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37332 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qJruI-00069D-1q;
	Thu, 13 Jul 2023 09:42:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qJruI-00Gkjq-D3; Thu, 13 Jul 2023 09:42:38 +0100
In-Reply-To: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
References: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 07/11] net: dsa: mv88e6xxx: export
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
Message-Id: <E1qJruI-00Gkjq-D3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jul 2023 09:42:38 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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


