Return-Path: <netdev+bounces-146659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BB9D4EE7
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D7D2814B7
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC151DE8AD;
	Thu, 21 Nov 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p6xzK8ud"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7941DE880;
	Thu, 21 Nov 2024 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200230; cv=none; b=gnEXv4eJ+MXs0cdgCtaUNM6vOnGQ5yZUfC0vMYYfFP1ro0L/gz2KD011YnmsgomsG9SsyF0BcAtnceB+jic+OTYpfUKylzhrqG8Q6CmfN87wNNvYmLdnpYfITOD+ZCVd8q7RXSIfVN6gBKZd8spQIiNkLVZA9QWeG5fgLDXU7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200230; c=relaxed/simple;
	bh=4XBU9fiQlzWzOj4Ap5N0rMJeKmyzkpk9Ed8r2jHf+oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifVLa7ArRwImhrKALc8bFmKxTf7TWSCkO1nPVjWzFDnQBvuEzFzB43/D8VcV6SWYtT3eW80fJpxwHOgfVlFlzlghi/fmsziHsSZGtNyGmYgiVUFXXqD8EreLkO0aIYlPygLQgcTNQLkvJqgc/Z6TmQuekFrudomafykSGptioeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p6xzK8ud; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FC784000F;
	Thu, 21 Nov 2024 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N74s09ADogUFQ5VtdAqKfmIMNkv7NvPfQkufVZ2lQ5w=;
	b=p6xzK8udS0cuZPR3JGcj0GZY1ANZTkUW3fTqcJepb/PjLYeoRsnKr+R58FV8FfHbSo+4yj
	gL5xeeWgNNdJOuZvEdSto9eNVbow+RX3paCACaEj1H07FxdEqCznMFI8s8T6af6HgFydau
	NTGUCu0JkRpvWX7V1rmpk4EFrglyqyW9EQ4EHc2qmkc6x2fMpARV4KupgT2iyCyVHiOec0
	dcNnZW7wSk98H+bJD2YpTajftkk0KjxygXocawWCDj7GIMxcZBLMh/TMf3AadnuSXyuCci
	Gnyr3Tfz5Uq3zn9mwcJhnnj9dy4HdDBlP3jTZk5wK4Vjpnyg75s6fpU5imBv0w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:33 +0100
Subject: [PATCH RFC net-next v3 07/27] net: pse-pd: tps23881: Add missing
 configuration register after disable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-7-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

When setting the PWOFF register, the controller resets multiple
configuration registers. This patch ensures these registers are
reconfigured as needed following a disable operation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- New patch
---
 drivers/net/pse-pd/tps23881.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 6fd76ecb2961..58864b7d28d2 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -157,7 +157,34 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 				       BIT(chan % 4));
 	}
 
-	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
+	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
+	if (ret)
+		return ret;
+
+	/* PWOFF command resets lots of register which need to be
+	 * configured again. According to the datasheet "It may take upwards
+	 * of 5ms after PWOFFn command for all register values to be updated"
+	 */
+	mdelay(5);
+
+	/* Enable detection and classification */
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_DET_CLA_EN);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	val = tps23881_set_val(ret, chan, 0, BIT(chan % 4), BIT(chan % 4));
+	val = tps23881_set_val(val, chan, 4, BIT(chan % 4), BIT(chan % 4));
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		val = tps23881_set_val(ret, chan, 0, BIT(chan % 4),
+				       BIT(chan % 4));
+		val = tps23881_set_val(val, chan, 4, BIT(chan % 4),
+				       BIT(chan % 4));
+	}
+
+	return i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
 }
 
 static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)

-- 
2.34.1


