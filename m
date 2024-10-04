Return-Path: <netdev+bounces-132142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C47B9908D9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459382839B6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA421C82F3;
	Fri,  4 Oct 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KI9IOlr3"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE61C7274;
	Fri,  4 Oct 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058578; cv=none; b=FYccUhKQl/9grOdkD2suDMfz//r2HDmx0brcXAnYmFWr0p67fET63GL/Cc2oOM/DNoz4+2TuXyBZtMuNHwKCF1BBgTvwFkX6BKRKadY7o67k5vjoJW5PNLFUu7zmkC08aW88wJYKoC67y3IZCrthFXYQ7C0crHTyvknMBY+HjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058578; c=relaxed/simple;
	bh=rAWpMtyvcBRdtxRlnUDXb/bpryEr0mMERltzyczUZ6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBS4+3eRQmyQG/VjQIp02tAN1DWq8Jps1PoSnRRfnfVnQoA7hWoWTKuI8YCwppsWDlDTGqZaLrXyc/qxCybHueNBdoam5G5++R9UX5fG7Id5HW+f0tos04Rhr35Z3x2B7wM95Ltt26viggwBjUKltPm0r/XsZQoaDOjCjN9CmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KI9IOlr3; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D2DD20012;
	Fri,  4 Oct 2024 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWhLd3vDKecLf43Ct4Q5pvEcdnHZ2BjA0Ud7Z6NbNnY=;
	b=KI9IOlr3ZroGDVJwZBUxGDphPPHWXrZwULxfsezS+povC9iBvwUoZjmZ0Obgo0odGHbo/u
	IhddPguuILaFebua7zyi0/sAs0Cj6R36MpBNFJOVXIwYZAPNgQiZSXr0BMyRiKuUhOpKRX
	PBqX9r3vSdWeFMocvIZli5mQy4qgrMwt6I3DTlv+HOGUNd312KOIvh4iYXpq5uR7y4oWw/
	/I5CykLaBMdhOorpUQYhcdrfNrZQkwkMqDEX5QO8n2w8Qu/UzJ8BOgho+vjQfEN2cdg1LC
	CoohEvXumtsoqRrYn6mRXg22E/iGlT/vdq64DyZqBPdeLUD6jD5p4hD2A5PYIg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v2 9/9] netlink: specs: introduce phy-set command along with configurable attributes
Date: Fri,  4 Oct 2024 18:15:59 +0200
Message-ID: <20241004161601.2932901-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Update the ethnl specification to include the newly introduced isolated
attribute, and describe the newly introduced ETHTOOL_PHY_SET command.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2 : Dropped loopback mode

 Documentation/netlink/specs/ethtool.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a050d755b9c..6f5cdb3af64d 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1132,6 +1132,9 @@ attribute-sets:
       -
         name: downstream-sfp-name
         type: string
+      -
+        name: isolate
+        type: u8
 
 operations:
   enum-model: directional
@@ -1950,4 +1953,16 @@ operations:
             - upstream-index
             - upstream-sfp-name
             - downstream-sfp-name
+            - isolate
       dump: *phy-get-op
+    -
+      name: phy-set
+      doc: Set configuration attributes for attached PHY devices
+
+      attribute-set: phy
+
+      do:
+        request:
+          attributes:
+            - header
+            - isolate
-- 
2.46.1


