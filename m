Return-Path: <netdev+bounces-132659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52055992B80
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16140286465
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BD1D2B10;
	Mon,  7 Oct 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rz397/jq"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6B1D2780;
	Mon,  7 Oct 2024 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303567; cv=none; b=UWvKcEEbR7MksdQ9Zo6RiuREl/+LJDZfwq6uEglJ4K/7MFSbLiuYmaTB4mgvbzfFySfBfd2jttDXwQz9Au073RfNgjIpVXmzwy8NJv22UJQW8V2T+7SMHJragENe07HnebyCCqJAEfO3xvAIs8LELBvm0ChauZw0Pi66qqlX4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303567; c=relaxed/simple;
	bh=XVB7UJJCr/qf0hPwflV9ZKUcwosiuI4w7GG7pLjN4kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8wyFe667bYL2Fq2RvgJvwBryiuYIeBX3GGk0sZws1Xp0bvT868tyWElTlQ08pIUaEoEH9bJ469Sw0P6CmMMbduI+B0gS1ZJxuKu9xZ2GReOp+wg8B0GCGkEBwTMfR182DfI7GMTmqRpK4ctFVIulTUK/SU2sn9Vb/BT20S9Ym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rz397/jq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6896020005;
	Mon,  7 Oct 2024 12:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728303557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pg580Ry3VlAsGHyS5CkIwdwzGTxEmOyviaHGBYrll7U=;
	b=Rz397/jqnTAX2f3W9lIe5fqhET3C/f0si4x4DYwKOQwJbigCR+dSvf5JQWnrNejcNwvBTQ
	FrgHfZSHvnCtl9FydhqGEMlpUQ2A28DBj+/1iz5ClI18JswkDp3g9AITBVkpIstTvOmd9B
	3QuZDxNSOeaMZGbhcsk+iDFW7qdbHFlfKZ+NiG2+b6FZG3rW8wZIbd5qrOtzSeL2yhHFzk
	9kX5szIgfwZ8FFCJwb09U+Fn6K1Pw3FlJwLdAvJYwsEfkNDs4NRhXSLhOaEx+FFps5qjhi
	3L9k8jbN4uRfAw2JXuKgsd0bZh8XZgJzojxXvyEDhr24T5T/QSxcMbdn86Tqnw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 07 Oct 2024 14:18:50 +0200
Subject: [PATCH ethtool-next v2 2/2] ethtool.8: Add documentation for new
 C33 PSE features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-feature_poe_power_cap-v2-2-cbd1aa1064df@bootlin.com>
References: <20241007-feature_poe_power_cap-v2-0-cbd1aa1064df@bootlin.com>
In-Reply-To: <20241007-feature_poe_power_cap-v2-0-cbd1aa1064df@bootlin.com>
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
index 151e520..1bd524d 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -545,6 +545,7 @@ ethtool \- query or control network driver and hardware settings
 .BR enable | disable ]
 .RB [ c33\-pse\-admin\-control
 .BR enable | disable ]
+.BN c33\-pse\-avail\-pw\-limit N
 .HP
 .B ethtool \-\-flash\-module\-firmware
 .I devname
@@ -1815,6 +1816,36 @@ status depend on internal PSE state machine and automatic PD classification
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
@@ -1829,6 +1860,11 @@ This parameter manages PoDL PSE Admin operations in accordance with the IEEE
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


