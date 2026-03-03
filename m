Return-Path: <netdev+bounces-263222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI39K+DqpmnjZgAAu9opvQ
	(envelope-from <netdev+bounces-263222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:06:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC81F10BA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DF98308957D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC536C0C5;
	Tue,  3 Mar 2026 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ArjcEI27"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58945367F40;
	Tue,  3 Mar 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546083; cv=none; b=NeYwE306S1O6R7b6fsfwZmtyvfdtE7hdV9Pb7bChJA5HweUFzGE/Q23B4XdXK9yAa6iWStVbKvsuxlscPXJmOoaqpY5EH71v5FLMoD7Iw0d8zweTGXk8LBCSQyUuX/iE+eh9SuuqxdH704UPzvl/taB7f2nuXmFgHUmoAw43YCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546083; c=relaxed/simple;
	bh=kREZyk51t/pc57Q7Omi8G1cdvAJLhFQE4zUug5/PuCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1WZZQ1UgE2z5jZmkhAqMPqttgrF6C5O8/3mWg2GaUOFI0ZbZL1RZHZFfnhvX/slZbANXMbgb/BwlDspolVg6DHbVIG2FaixfKgi1fDMYq2PV+cRct5BjZ/yvaf2OBFeydoR3oPLYQv12X5SO7M4xJctMGNZw2HFMS8W9SbUEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ArjcEI27; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CDF801A2381;
	Tue,  3 Mar 2026 13:54:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A45175FF29;
	Tue,  3 Mar 2026 13:54:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07880103696E4;
	Tue,  3 Mar 2026 14:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772546077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bOKnk01pRviZLzaDWepX3/tqvs4TA97JeFVo66U4bvo=;
	b=ArjcEI27A2kjWXTzjqONKg56X9MOLf6vc5Rom6R7l6bibdyoet1H/9rM3Zy+8LpXt4ssUR
	AZVrJlm9ox4trCbtry40eQHxBVN1BN/DP5Sp86FNNnjwMQuv8kfh1kiZp+KO5S3YHWgJEJ
	SL/1Xfsoz3C92P+UUAKTgoDS8BGSd7q96kocMWFF4W8Aibvkh627esKwXMn6uswQMkoCLo
	0FcYFOu8ogOQ3UxKg4W5olQUgBAhKzM/qRPrUMY2jgmiFfL078f+C3683MzP1Dgq9bQIuv
	oDlo22pTDQUC88et5V6XBuFBbCpKoJVQHcpZ5Ndu0esrbRUXCSFDXShWx6z+DQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 03 Mar 2026 14:54:27 +0100
Subject: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
In-Reply-To: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
To: Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 41AC81F10BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263222-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

If phandles to receiver and/or transmitter regulators for an SFP device are
found, enable them at probe time.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/sfp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f4bf53da3d4fd..602c166f60ddf 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
@@ -3095,6 +3096,14 @@ static int sfp_probe(struct platform_device *pdev)
 	struct sfp *sfp;
 	int err, i;
 
+	err = devm_regulator_get_enable_optional(&pdev->dev, "vccr");
+	if (err && err != -ENODEV)
+		return err;
+
+	err = devm_regulator_get_enable_optional(&pdev->dev, "vcct");
+	if (err && err != -ENODEV)
+		return err;
+
 	sfp = sfp_alloc(&pdev->dev);
 	if (IS_ERR(sfp))
 		return PTR_ERR(sfp);

-- 
2.52.0


