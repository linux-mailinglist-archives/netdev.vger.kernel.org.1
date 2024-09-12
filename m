Return-Path: <netdev+bounces-127754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3FF97655F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A082847C7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40919F105;
	Thu, 12 Sep 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kM+1+Ahu"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816F190675;
	Thu, 12 Sep 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132820; cv=none; b=ne7MJRL4GczqHEtRamcAB7r96EcL+EGalGt7q8WzK9pIGkV6OIBPLWEKyIOfPyKuvkaHiRXlpiU6Ux7OAHqigpMFcMEFOISzupBUXNxgbwc4l/p377wAmcJjCl7nIElJ3lihCGrPtRTP+tdDhLLOPTqtGY6uLTeGfdzx6jYjnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132820; c=relaxed/simple;
	bh=j2CDIlRAqYOUw44emUEbwqYGv+uqh685KjTuPfyHLrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYIfMTnRZ9cBD/I/nYTy8UtisRQNUQihmPgpSB3pvROs/Xx+NNpbimP7Wdcb3bjZSYrkAEjLaNIjpaJeKmuXIiYGMw7VLYF644YpnC1Iak3Nu7bhv9IQojvV/gXQuwiLh+7h5LH8ml37OlGTDyAnPpm8rwlGZGqBuxxul04PqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kM+1+Ahu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EE1C20010;
	Thu, 12 Sep 2024 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726132816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHe8OJYspWoaHU9WVb1XPlu+LICOnsvuNjbBgFu9lGE=;
	b=kM+1+AhumfKj2pTrFIuWJUd90X9YjLZrXXZzVgBn8jxs6jRX0NbupMbsGas9fkz/vCZjCI
	Q8F9bqsv0UJpYcKjA2qRfT/KEMzdQoV2vdOiu84ktM+8WQ+bwchlobk6OtOjxtCi+6U49L
	aSsJAQpeyHrCTrU84ATDhKn+ILeubJLnJXo40AZcN/mtqQbDYpz63YSRefnnshP7fF50NV
	NSFWqTuOIUVHDDF0gM2uW/lpY8YYpQaCUnzA/ciYhBghV9L6eUzFuhdoXH5V54vFmmotJQ
	oCF7GBZ4aU+Jlc2uwOoIMRa6U046tH4yQqmDNNF3sYD+r6nxnN6bpEuugf0Xfw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 12 Sep 2024 11:20:04 +0200
Subject: [PATCH ethtool-next 3/3] ethtool.8: Add documentation for new C33
 PSE features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-feature_poe_power_cap-v1-3-499e3dd996d7@bootlin.com>
References: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
In-Reply-To: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add documentation to described the newly C33 PSE features supported.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 ethtool.8.in | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 3b4df42..39bbd2e 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -542,6 +542,7 @@ ethtool \- query or control network driver and hardware settings
 .BR enable | disable ]
 .RB [ c33\-pse\-admin\-control
 .BR enable | disable ]
+.BN c33\-pse\-avail\-pw\-limit N
 .HP
 .B ethtool \-\-flash\-module\-firmware
 .I devname
@@ -1809,6 +1810,36 @@ status depend on internal PSE state machine and automatic PD classification
 support. It corresponds to IEEE 802.3-2022 30.9.1.1.5
 (aPSEPowerDetectionStatus) with potential values being
 .B disabled, searching, delivering power, test, fault, other fault
+.TP
+.B c33-pse-extended-state
+This attribute indicates the Extended state of the c33 PSE. The extended
+state correlated with the c33 PSE Extended Substate allows to have more
+detail on the c33 PSE current error state.
+It corresponds to IEEE 802.3-2022 33.2.4.4 Variables.
+.TP
+.B c33-pse-extended-substate
+This attribute indicates the Extended substate of the c33 PSE. Correlated
+with the c33 PSE Extended state value, it allows to have more detail on the
+c33 PSE current error state.
+.TP
+.B c33-pse-power-class
+This attribute identifies the power class of the c33 PSE. It depends on
+the class negotiated between the PSE and the PD. It corresponds to
+IEEE 802.3-2022 30.9.1.1.8 (aPSEPowerClassification).
+.TP
+.B c33-pse-actual-power
+This attribute identifies the actual power drawn by the c33 PSE. It
+corresponds to ``IEEE 802.3-2022`` 30.9.1.1.23 (aPSEActualPower). Actual
+power is reported in mW.
+.TP
+.B c33-pse-available-power-limit
+This attribute identifies the configured c33 PSE power limit in mW.
+.TP
+.B c33-pse-power-limit-ranges
+This attribute specifies the allowed power limit ranges in mW for
+configuring the c33-pse-avail-pw-limit parameter. It defines the valid
+power levels that can be assigned to the c33 PSE in compliance with the
+c33 standard.
 
 .RE
 .TP
@@ -1823,6 +1854,11 @@ This parameter manages PoDL PSE Admin operations in accordance with the IEEE
 .A2 c33-pse-admin-control \ enable disable
 This parameter manages c33 PSE Admin operations in accordance with the IEEE
 802.3-2022 30.9.1.2.1 (acPSEAdminControl) specification.
+.TP
+.B c33-pse-avail-pw-limit \ N
+This parameter manages c33 PSE Available Power Limit in mW, in accordance
+with the IEEE 802.3-2022 33.2.4.4 Variables (pse_available_power)
+specification.
 
 .RE
 .TP

-- 
2.34.1


