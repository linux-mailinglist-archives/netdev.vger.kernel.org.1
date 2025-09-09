Return-Path: <netdev+bounces-221121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFCCB4A5B2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 10:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F15188C14A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 08:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67323255F2C;
	Tue,  9 Sep 2025 08:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA5257459
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407431; cv=none; b=BDzdszY/AMphE2Om1USmuq46OzSh4mn785NI5VpyG0JGEHVqgr/vo5Ac3/wXAas215z5vaI8bsZL8MOISjWfpXhHJPWWYdneg4jRMVWEh+RGp7g+uTSw8fbBOQVZ/YVrdXCq8yd/lhuX0i5cgpUUxomj2dfaHii+me4bSstoOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407431; c=relaxed/simple;
	bh=u45UUVfUv61DL+OkdKfXNcJsNkGdrzFc4oiaOSYv4Qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BOhRKZAB4d0l8X/kBEsXGY+oS22I5JdHc/8MF0ECJePwZzCXphU5kfwS5/7Ec4vgSI+h4mMgS8VzfJZmIaBFRignmfN4xLI6oAoXiehMCc+58tnA44jnRewQuqqKYhUT3QS4TPpIGWjkFpIFfHz+qmxz2RSsEcImk1qojqBUQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uvtx0-0002Gw-Oe; Tue, 09 Sep 2025 10:43:42 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Tue, 09 Sep 2025 10:43:38 +0200
Subject: [PATCH] net: phy: MICREL: Update Kconfig help text
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-micrel-kconfig-v1-1-22d04bb90052@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALnov2gC/x3MQQqAIBBA0avIrBPMULGrRIuyyYZKQyGC8O5Jy
 7f4/4WMiTBDz15IeFOmGCrahoHbpuCR01INUkglrFD8JJfw4LuLYSXPxWyN1EZ3CjXU6Eq40vM
 Ph7GUD4awoHZgAAAA
X-Change-ID: 20250905-micrel-kconfig-0b97267635e6
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=u45UUVfUv61DL+OkdKfXNcJsNkGdrzFc4oiaOSYv4Qw=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjY/2JvllX+SecmtXMXHy960dSSt/Fnz6W43JsPI35wc
 7+4EcgR3FHKwiDGxSArpsgSqyanIGTsf92s0i4WZg4rE8gQBi5OAZjIXg2G/xEuiv93NDAVenJx
 bvk5p5LNgNWtQ2JJY+eV9Dc961+o3mdk2NBxRNOK9Qav1pPPj8otHX/1Fu7yNDOZki0ScWAxY5w
 2JwA=
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

Update the help text to reflect that.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/net/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a7fb1d7cae94..d59399fa583c 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -298,7 +298,7 @@ config MICREL_PHY
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select PHY_PACKAGE
 	help
-	  Supports the KSZ9021, VSC8201, KS8001 PHYs.
+	  Supports the KSZ and LAN88 families of Micrel/Microchip PHYs.
 
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"

---
base-commit: 16c610162d1f1c332209de1c91ffb09b659bb65d
change-id: 20250905-micrel-kconfig-0b97267635e6

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>


