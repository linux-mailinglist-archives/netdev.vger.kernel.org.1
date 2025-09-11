Return-Path: <netdev+bounces-222018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542F3B52BA3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE721C83591
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56B2E267E;
	Thu, 11 Sep 2025 08:29:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8AB2E1C44
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579360; cv=none; b=jDCEUlXfu+XftZcgg5a1fTxY4HFAvDpy7W/mjFBlx5j+Cl1H+NcILcdPrXPTa5ndJ9u+6+h8/Wykcn+2JwNh6zZGwgOREadFIxIOgOf6M1OCE1MPkBFaLpiGD4UOqXqleaVylWxyTrW/nawxUvjLGvyaq3Q9nxqGea/s2VMWLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579360; c=relaxed/simple;
	bh=cectbzOwSX7/raq+3N3bfK5CjRa4tK2nFA3zl8Ny/eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e98MnjEYcFeNINT2wtfo+54KdHgbqxClRZpfNKuxRhRwFAZjZb47uWudAtzOgPR1KHGSKtkipx8ykj+aVzXunUd/IlZoAEbLGra2hLYzR+X/jty18SC6YApJOexD/5m2koqjhQcazdVkbpDbO/AZ49M50X07aTw2+fLOaRkO550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uwcfy-0004dq-5J; Thu, 11 Sep 2025 10:29:06 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 11 Sep 2025 10:29:03 +0200
Subject: [PATCH v2] net: phy: micrel: Update Kconfig help text
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-micrel-kconfig-v2-1-e8f295059050@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAE6IwmgC/13MQQ6CMBCF4auQWVszjBZSV9zDsBAYYKK2pEWCI
 b27lcSNy/8l79sgsBcOcMk28LxIEGdT0CGDdrzZgZV0qYGQNBrU6imt54e6t872MihsTElFWZw
 0F5BOk+de1h281qlHCbPz791f8u/6o8w/teQqV0QdnpvGIGqqJrbDa/bOynrsGOoY4wcFQPSCs
 QAAAA==
X-Change-ID: 20250905-micrel-kconfig-0b97267635e6
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=cectbzOwSX7/raq+3N3bfK5CjRa4tK2nFA3zl8Ny/eg=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsg41BFw/lrh1YxDPBXvs1rFb6z1UpsS+dRGek/9vZrFp
 z+qm7e6d5SyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACZyLp/hf/znq8q3vC3q+ZZc
 OJpiHpISduxWFMcMa5GmHN+Io07XAxkZDoUUPeRanhPQNuXNL0sdoZuK/JZd1Sk/+qwdbF/ytv9
 lBgA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This driver by now supports 17 different Microchip (formerly known as
Micrel) chips: KSZ9021, KSZ9031, KSZ9131, KSZ8001, KS8737, KSZ8021,
KSZ8031, KSZ8041, KSZ8051, KSZ8061, KSZ8081, KSZ8873MLL, KSZ886X,
KSZ9477, LAN8814, LAN8804 and LAN8841.

Support for the VSC8201 was removed in commit 51f932c4870f ("micrel phy
driver - updated(1)")

Update the help text to reflect that, list families instead of models to
ease future maintenance.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Changes in v2:
- Don't capitalize "micrel" in commit message (Thanks, Jakub)
- Name chip families with the common xxx-placeholders (Thanks, Jakub)
- Be a bit more specific as to which families
- Link to v1: https://lore.kernel.org/r/20250909-micrel-kconfig-v1-1-22d04bb90052@pengutronix.de
---
 drivers/net/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a7fb1d7cae94..e543eef36d98 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -298,7 +298,7 @@ config MICREL_PHY
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select PHY_PACKAGE
 	help
-	  Supports the KSZ9021, VSC8201, KS8001 PHYs.
+	  Supports the KSZ8xxx, KSZ9xxx, and LAN88xx families of Micrel/Microchip PHYs.
 
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"

---
base-commit: 16c610162d1f1c332209de1c91ffb09b659bb65d
change-id: 20250905-micrel-kconfig-0b97267635e6

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>


