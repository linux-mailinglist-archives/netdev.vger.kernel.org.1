Return-Path: <netdev+bounces-220339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99338B4579B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A923D1C875C8
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EB9350D41;
	Fri,  5 Sep 2025 12:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D9350845
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074869; cv=none; b=imsxv99tLo0ohc5ax54bhFnMRZwUVA3fZPsIlMUkuHRxXChodVOItxjjv37Lkae5WJtcS3jUbmeUvXr/PlycH6aOFUtfkuznpOOSjAkiX2pSuzdv7yzqCySvGafcS9v7qH/hucQVtqenzvZyFbH3XjBXpvk90O63WPBNibW6XzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074869; c=relaxed/simple;
	bh=0u2LPcFf+k6oYTJX3krFbhUK2xXeKuu/9ZYzJU05NjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eXz24/SBrm1KlG6WgdwCCJV0fGYvxRICCaMw39/TYtrf2zky3scJ3z6HHIQPJCQbQ1a7J1sMPZKY4o0TlbkfqWrthhtgkGSQ0B0fOOf3BzWVtWneMmkUQb6AEPtKnpT+THASmc0CaSXrjbMOSCoq0EgKJauh0QrsM1+7lO8MxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uuVQz-0002RW-JF; Fri, 05 Sep 2025 14:20:53 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 05 Sep 2025 14:20:50 +0200
Subject: [PATCH] net: phy: NXP_TJA11XX: Update Kconfig with TJA1102 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-tja1102-kconfig-v1-1-a57e6ac4e264@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAKHVumgC/x3MQQqAIBBA0avIrBNGSciuEi3MppoCDY0IwrsnL
 d/i/xcyJaYMvXgh0c2ZY6hQjQC/ubCS5LkaNGqDFo28dqcUann4GBZepcEJXTe3WqGFWp2JFn7
 +4zCW8gEY3QopYQAAAA==
X-Change-ID: 20250905-tja1102-kconfig-50b0a8d42109
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.15-dev-5bfae
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=0u2LPcFf+k6oYTJX3krFbhUK2xXeKuu/9ZYzJU05NjU=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjYdXXxJduwLZHXpohzKa2RWTn1GuPnGPYuHsHUm7v3a
 aoem7++uKOUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjCRqLcM/6PdfuYEWS11yOwX
 26x27tLuAqas3RqfnmXOEPnrsjyyKpuR4ZDDKoMLdnrCrzquPpz+6LE0Z9c15hUH+q+xO/7q+7P
 dlxUA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Update the Kconfig description to indicate support for the TJA1102.

Fixes: 8f469506de2a ("net: phy: tja11xx: add initial TJA1102 support")
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/net/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a7fb1d7cae94..0e7dcdb0a666 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -361,7 +361,7 @@ config NXP_TJA11XX_PHY
 	tristate "NXP TJA11xx PHYs support"
 	depends on HWMON
 	help
-	  Currently supports the NXP TJA1100 and TJA1101 PHY.
+	  Currently supports the NXP TJA1100, TJA1101 and TJA1102 PHYs.
 
 config NCN26000_PHY
 	tristate "Onsemi 10BASE-T1S Ethernet PHY"

---
base-commit: 16c610162d1f1c332209de1c91ffb09b659bb65d
change-id: 20250905-tja1102-kconfig-50b0a8d42109

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>


