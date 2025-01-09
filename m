Return-Path: <netdev+bounces-156620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9580FA072AD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903DA16430D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A18216381;
	Thu,  9 Jan 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lS3H5Oe2"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E34215F49;
	Thu,  9 Jan 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417934; cv=none; b=ZSOnWCVxfHqAkSrKxwkhESge7QX83XtCAh8JQ/Q3AdFQIhT/tRrFI87ymbywcp6nGMYXNSArq2USCZ7mCZNAet3hfk1+sPYWRGM06B7hhzbP634GvTAqkXWWuitknDTIOw4Yb9N5ir5isGqFoUD3pk2XbTk1uvKRGQ0mXQesaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417934; c=relaxed/simple;
	bh=/tAXWE9ZL4WtZspUDdAze2QFcr2Yf2fb5nGAhV9PnmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Py8rXVko7Mtn5E2R/McL36UCTC+BBOjMZ5LkKarB+HtT5lYLPR3ue8N6nF8GaMNLRwlRlMuqIAzYYJk2U33AywCxGbaHVbPZfbUF2/bk6E/zbwBSo+SW4DyHMFKCsN/c8pCBQufS82uxP7K/hCaUndtKO9FRXYBO1weCKm2pr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lS3H5Oe2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DC34E0007;
	Thu,  9 Jan 2025 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sbdIG7o+MIgUW4/5Lh2oWiUH88289E01R5dOjp9fk0=;
	b=lS3H5Oe2+8aeIQRfnFbV2oahSnGKGUaABYcJVR+cCx6TP0f3x/0plThHs44/b9HHzvudTy
	t1YslX+fgERlz3Nv8+pABg6XpsUNG6mgfNQ3k+gh+NgzdlcfaNqFlpByUVyHkN5E1g64eE
	FH3tyVWKn9ap4u/hf6E37w2SX9O9ZPNfzaOTSrIBg4N/xxHptOVUJR+W/79RY0TYY8Y3Ru
	dTXM+cdPCtjYFlaY6/I8PHzkAoURsTG11UNewRJkZ04ZsZ1BVqJr+kCTwRVdezRGtQkwVz
	FbbH3yh9gql3/ru25Iv4wTZz6+KJOw/3aJ430AXq1V+jz/SCYMMMSgtZuvgwGg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:18:00 +0100
Subject: [PATCH net-next v2 06/15] net: pse-pd: tps23881: Add missing
 configuration register after disable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-6-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
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

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 4a75206b2de6..b87c391ae0f5 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -130,6 +130,7 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	u8 chan;
 	u16 val;
+	int ret;
 
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
@@ -143,7 +144,34 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
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


