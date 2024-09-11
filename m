Return-Path: <netdev+bounces-127343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A4A9751ED
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5948CB23D10
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D59187FE9;
	Wed, 11 Sep 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O59TEY/a"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E9176FD2;
	Wed, 11 Sep 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057360; cv=none; b=XRExmrpoKOVFWWpOQP+13RMzzupBQtRIrquAr/AProaJZEe3jUr+S3egoshIabk9pqgr9zJMffjn76cCmklfKHB01FWaWQd3AtKbbDzvj6OS41/HH2aNYPaOD+2gPDvQi+5ZyI9pMNmEBUqjJuJV3e6TXrDYOs7q/o1pThCBW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057360; c=relaxed/simple;
	bh=blFGFyAduLWx63BOYMp1KN1TLMQWpesxNpbWCDDui8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LRp6DkPBFHzmPyV8sNOB7OnfynsxutSnp2J7iWjJL3SjSfAZESBj/1+SI5x2IKI8a0i8IxeqMvxEWWWLb4Bttvu2W5GszizjKgiQ2sxi1nnXJeP+2wJcgCQTzkoj9LfMuSpykua0Afm2DGf7ApfADrXjAACSiNFHXVIpoiJgbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O59TEY/a; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBB96240008;
	Wed, 11 Sep 2024 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726057349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xC4ofXG4/VRyxZNU6w0RPA76zhDL5g9ioT3bWLFNSKs=;
	b=O59TEY/aTxwdzRjOHhVFLiaIaWb9tqPBEUz3Eu8ESQWyGvkQT24fwuPuGoHQTNQNlSNmfR
	SYONoKTYmpoomKHCGyIQQiExRV0YgXMm5eYg/+WgUbsPtTBF0jjRgMb+d4rz/sQriflbYM
	h+0t12Ntx8yFKbxfBOoolRUFMEYSIZPTUXQ6vehwwXZoXWII6+vEnADDZ6A6Wnb9bCLQHH
	Y2jQpTOcZDFNnLA7I2xyGmhrCxAX3MoWXEN5Kr/do9LX4Rq0GlEOEGMWfQUi6+nubiwOeA
	JusI7+JIYwYt8g9ysCy5PatCHrZq+gkCertXM4FJxy1qu7qXo7i9a3dyIrUcPQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 11 Sep 2024 14:22:04 +0200
Subject: [PATCH ethtool-next v2] ethtool: Add missing clause 33 PSE manual
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240911-fix_missing_doc-v2-1-e2eade6886b9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGuL4WYC/3WNwQqDMBBEf0X23JQkGIs99T+KiCarLmi2JEEs4
 r835N7jMG/enBAxEEZ4VicE3CkS+xz0rQK7DH5GQS5n0FLX0mgpJjr6jWIkP/eOrWgGiRMaZer
 WQl59AmakGN+AaUnMq/B4JOhyu1BMHL7lbleF+WvelVCibYx9OBwnK/E1MqeV/N3yBt11XT/10
 ya4vgAAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Add missing descriptions for clause 33 options and return values for
the show-pse and set-pse commands.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Rebase on top of ethtool-next
- Link to v1: https://lore.kernel.org/r/20240520-fix_missing_doc-v1-1-965c7debfc0e@bootlin.com
---
 ethtool.8.in | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 5b8b8d6..bf8af57 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -540,6 +540,8 @@ ethtool \- query or control network driver and hardware settings
 .I devname
 .RB [ podl\-pse\-admin\-control
 .BR enable | disable ]
+.RB [ c33\-pse\-admin\-control
+.BR enable | disable ]
 .HP
 .B ethtool \-\-flash\-module\-firmware
 .I devname
@@ -1792,6 +1794,21 @@ status depend on internal PSE state machine and automatic PD classification
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
@@ -1803,6 +1820,10 @@ Set Power Sourcing Equipment (PSE) parameters.
 .A2 podl-pse-admin-control \ enable disable
 This parameter manages PoDL PSE Admin operations in accordance with the IEEE
 802.3-2018 30.15.1.2.1 (acPoDLPSEAdminControl) specification.
+.TP
+.A2 c33-pse-admin-control \ enable disable
+This parameter manages c33 PSE Admin operations in accordance with the IEEE
+802.3-2022 30.9.1.2.1 (acPSEAdminControl) specification.
 
 .RE
 .TP

---
base-commit: b3ee7c0fa87032dec614dcc716c08a3b77d80fb0
change-id: 20240520-fix_missing_doc-6a0efe51549c

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


