Return-Path: <netdev+bounces-97165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A278C9AB4
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 11:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BB81C2034E
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A303521A19;
	Mon, 20 May 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kr94X6U2"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BE4596F;
	Mon, 20 May 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198484; cv=none; b=C1e+O1q8U7ohXXfM6R07AQeplUaxs9kECKOMvUgcGqyn+Mwf61eIY43qHaoP/BIdFXWZv/xJ2Isri72lQ0iAraIJkR4pKVeLejf6Ir7pBUFb2XNm5J3sSEB1RfRoeXnXW7KECxQ2lM9LqDM1VnESmZeerz+B3SugkQFowKzLoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198484; c=relaxed/simple;
	bh=1haICXQKaBrTiO6DB9+MCAFP6OxRlBqu5Bdpx7Fp3jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XojKil5SLwttK/f4nUV6tWYnkKdpP7U6eAyh1xw8eFCEsOaumJrdDQHfgIFUlZLOismWAhAcHXa4CbzXa3gTqU8+jJMfKY6eLDwHUPkdQ1KD30QSEMId3kMza1jhc+1VOBYfg2MXshpGvdS/RB/DLUkz+97synr0aIf13tcpw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kr94X6U2; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C10BC0004;
	Mon, 20 May 2024 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716198473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uVlNsuE1oL117lAiv0Tm0OhteAAQy0vckswo+mDHsYY=;
	b=Kr94X6U2RceGPDbJ6kOXZrZDszZVyK4fYwmcNAhlZGs3iTzDhh1wwpHK/UipykhjQ64ssZ
	XzOAnIPnTAinLr1kWOHjBIAUnr6ddD5deBgsa7H74UfahJjH3CJVUyQ5tpKkzDvIGSeMri
	DxyZ9fHhzWgANGBpBiMXw1aTHjrOoWJfxvlvdoOXq4ne2SR7gzyZOr6apJmZx98YblnMPk
	93rM2tZp7dBnh/mr7hcPSATZqbIpNAYPm11ZW82x7hl5Sa5vDtoOhOHDRpj+0hXpxNAXEc
	pkYMcAyYRbne7iCtg0D06BYYe1D9NhrAZhbEuKktWDP6s59Z2OvuJI1nzm96Aw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 20 May 2024 11:47:33 +0200
Subject: [PATCH ethtool-next] ethtool: Add missing clause 33 PSE manual
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240520-fix_missing_doc-v1-1-965c7debfc0e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIADQcS2YC/x2M4QpAMBRGX0X3t9UsU7yKJM2HW2zaXVLy7pafp
 845DwkiQ6grHoq4WDj4DFVZkNsmv0LxnJmMNrW2RquF7/FgEfbrOAenmkljga1s3TrK1RmRlf/
 YE9KWQtiVx51oeN8PN8YGIG8AAAA=
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add missing descriptions for clause 33 options and return values for
the show-pse and set-pse commands.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 ethtool.8.in | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 5924b8d..264df74 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -536,6 +536,8 @@ ethtool \- query or control network driver and hardware settings
 .I devname
 .RB [ podl\-pse\-admin\-control
 .BR enable | disable ]
+.RB [ c33\-pse\-admin\-control
+.BR enable | disable ]
 .
 .\" Adjust lines (i.e. full justification) and hyphenate.
 .ad
@@ -1756,6 +1758,21 @@ status depend on internal PSE state machine and automatic PD classification
 support. It corresponds to IEEE 802.3-2018 30.15.1.1.3
 (aPoDLPSEPowerDetectionStatus) with potential values being
 .B disabled, searching, delivering power, sleep, idle, error
+.TP
+.B c33-pse-admin-state
+This attribute indicates the operational status of c33 PSE functions, which
+can be modified using the
+.B c33-pse-admin-control
+parameter. It corresponds to IEEE 802.3-2022 30.9.1.1.2 (aPSEAdminState),
+with potential values being
+.B enabled, disabled
+.TP
+.B c33-pse-power-detection-status
+This attribute indicates the power detection status of the c33 PSE. The
+status depend on internal PSE state machine and automatic PD classification
+support. It corresponds to IEEE 802.3-2022 30.9.1.1.5
+(aPSEPowerDetectionStatus) with potential values being
+.B disabled, searching, delivering power, test, fault, other fault
 .RE
 
 .RE
@@ -1767,6 +1784,10 @@ Set Power Sourcing Equipment (PSE) parameters.
 .A2 podl-pse-admin-control \ enable disable
 This parameter manages PoDL PSE Admin operations in accordance with the IEEE
 802.3-2018 30.15.1.2.1 (acPoDLPSEAdminControl) specification.
+.TP
+.A2 c33-pse-admin-control \ enable disable
+This parameter manages c33 PSE Admin operations in accordance with the IEEE
+802.3-2022 30.9.1.2.1 (acPSEAdminControl) specification.
 
 .SH BUGS
 Not supported (in part or whole) on all network drivers.

---
base-commit: edf00bab748b4e2d9620a106d84b03fdfb4d44da
change-id: 20240520-fix_missing_doc-6a0efe51549c

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


