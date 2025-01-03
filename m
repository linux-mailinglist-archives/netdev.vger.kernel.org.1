Return-Path: <netdev+bounces-155072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6AA00F49
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DF67A1C96
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852551C1F07;
	Fri,  3 Jan 2025 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ca/52iqj"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF21AB507;
	Fri,  3 Jan 2025 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938825; cv=none; b=Wr6xNbJROQz81WQOvD1WiDSgBBHhuGIQwtj5mtuECfndE82+xthD5qSgolxrFLXSKZWoTanD7lSz4koJ0zIJ34dwWOiJ0BLrGUC1lEQAi2Pw5yV/iFqn2BQ3pFuFvfRoDnqEBr96Nuu3U14X3xJvbUXQfuC9QqL17d8RAJK/OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938825; c=relaxed/simple;
	bh=0PppTDsAgT084+ol+PNnCN8ZyILArxYvnpk6iLs4DoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nddNn6+SgFotNmbj7EiwnRJ+nrffZVuT0MFVoHtt/5pMXN7qKXQcSZB7JWBmbwloy8rXA6Fk96gjjsvdA7NNgmZVomZNLLGvBPX7F2UT0nfD/cdfmXlvBo/8CDPCXoXnTibap8ywvdg1DPYBuxu9exNBWe/jkJ9ESjGPnorYeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ca/52iqj; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6BEAFF806;
	Fri,  3 Jan 2025 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsS5vMBCX9uFRfbUu/wSiLP71O27zK9bjxXVIKpNF8k=;
	b=Ca/52iqjnvr72vH1Oh7AwXJGMNTzFaLDsvpdqtYBjZbT2MSbPKmRlKfJVhwGaTP1P8oNf6
	IF6/yPVtEuSGPqplTniRgkEtQejdZ53MRnD4LEdwOrANxEw8ZIxxPROo7tP3KbXc1QCo/E
	mT69W+TwmxIOps3yNoeTAkClv6wh2o0zrw7zl8FJaH0L/QhKSJwUvJnsZC4VTf2mrN1TBu
	0ZDpYHZT63zLzx6Z9Av8SjE2DKcURNUYcemJAwKJl0tXIS7Yyv6n4kXeWusyOjwpGflO0p
	H1qc07SfnJf07HfLS/okAtwj4G+pSlz5QrUpOegyuQfNpft9zuC1sAiKfZC+kg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:12:53 +0100
Subject: [PATCH net-next v4 04/27] net: pse-pd: tps23881: Simplify function
 returns by removing redundant checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-4-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Cleaned up several functions in tps23881 by removing redundant checks on
return values at the end of functions. These check has been removed, and
the return statement now directly returns the function result, reducing
the code's complexity and making it more concise.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v4:
- Removed unused ret variable.
---
 drivers/net/pse-pd/tps23881.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 8797ca1a8a21..a3507520ff87 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -59,7 +59,6 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	u8 chan;
 	u16 val;
-	int ret;
 
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
@@ -78,11 +77,7 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 			val |= BIT(chan + 4);
 	}
 
-	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
 }
 
 static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
@@ -91,7 +86,6 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 	struct i2c_client *client = priv->client;
 	u8 chan;
 	u16 val;
-	int ret;
 
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
@@ -110,11 +104,7 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 			val |= BIT(chan + 8);
 	}
 
-	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
 }
 
 static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
@@ -480,7 +470,7 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 	struct i2c_client *client = priv->client;
 	u8 pi_id, lgcl_chan, hw_chan;
 	u16 val = 0;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < port_cnt; i++) {
 		pi_id = port_matrix[i].pi_id;
@@ -511,11 +501,7 @@ tps23881_write_port_matrix(struct tps23881_priv *priv,
 	}
 
 	/* Write hardware ports matrix */
-	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PORT_MAP, val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i2c_smbus_write_word_data(client, TPS23881_REG_PORT_MAP, val);
 }
 
 static int
@@ -564,11 +550,7 @@ tps23881_set_ports_conf(struct tps23881_priv *priv,
 			val |= BIT(port_matrix[i].lgcl_chan[1]) |
 			       BIT(port_matrix[i].lgcl_chan[1] + 4);
 	}
-	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
 }
 
 static int
@@ -594,11 +576,7 @@ tps23881_set_ports_matrix(struct tps23881_priv *priv,
 	if (ret)
 		return ret;
 
-	ret = tps23881_set_ports_conf(priv, port_matrix);
-	if (ret)
-		return ret;
-
-	return 0;
+	return tps23881_set_ports_conf(priv, port_matrix);
 }
 
 static int tps23881_setup_pi_matrix(struct pse_controller_dev *pcdev)

-- 
2.34.1


