Return-Path: <netdev+bounces-156627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F703A072C3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8814D7A1D7F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907E217677;
	Thu,  9 Jan 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dUEWTALZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F52163A8;
	Thu,  9 Jan 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417938; cv=none; b=CFLocJkj2xMmR//Pfd5AGvkRiq34abobou49+9NmlduXTnzzKXsSrNHlHdJFvNZXqzZniT9g5HOyQD2nkLu1vxOFaKBG+YC2gMa4l1GQw7/u4WSV5ryqqByqJsYb4S5DW4CN2a4NkeB9oNCW/BpDa6TnD9W01dl9LbmP52Nwom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417938; c=relaxed/simple;
	bh=ZNOJWzG45K3PkGpWZb3B1v809ET4LGuEapuaErb7AFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUj+xQ/nYQArhXPj+Aqca5IEZHdWpEMfo6X4Ug+qK4tDaJLad8W27Q9kyO8ECBq9PfY9w+q4qMcLh2Itm6Ymbxd9ol6yWkpBgJNOx8d1TidVp9E2LuKv9VucyHs4wE4dzoir4M+6xJgb4x7UMMEpMgQPpOny+J2NR57pmpY/2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dUEWTALZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DD9AE0002;
	Thu,  9 Jan 2025 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Vn1YDTOSEvolzDDe1a94IM3ahhU/7Y1fvtCiu8SO9M=;
	b=dUEWTALZr771eG+rS0WXijecTMXNzDA2nw/7whpXowgKA+8be5d86/wctD9uL0Jupps6i0
	cAcy/bRn4FCTci1aZMoMYfbKkKNDyknJhQ8hqsdHYgZFdUGBS2VN39yXPrdJDHzS3Iybbk
	Gpb9SMDFuMPfa1LN2A6T8TnvtGCmXLcV0YktR/QxFNHoWK2baMukXX3Mu4VPxmE24k0L1W
	DesQP+h4xnUZ6FjpDE28/PuqDFPAT8UWATr7gLqnTDjlGVpvAqC69k2UYq9WKJ1gNyyOBg
	0pOfdU1rc68s3J8Al8wO/BmSQFrSyWiyFJw8jA/enLqh13diwzsGLHlzcN6tcg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:17:58 +0100
Subject: [PATCH net-next v2 04/15] net: pse-pd: tps23881: Simplify function
 returns by removing redundant checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-4-55ded947b510@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
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


