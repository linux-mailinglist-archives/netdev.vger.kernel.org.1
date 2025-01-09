Return-Path: <netdev+bounces-156626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F86A072C1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C87A11DD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99E21766B;
	Thu,  9 Jan 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ckx/V8mB"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966A2163A2;
	Thu,  9 Jan 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417937; cv=none; b=B2DKI1jlOQcSOG3gCQpSWE1R/S83lBQWab2jZKBcoWPVcHwD3uT3rnZYgGMsODip4TvD7AdGteOEe7jDVJzni0o3O0UMErhm+QBpxqEotwsOPtEo+45OxgwL1/V7E+l1TcMC4PKtRFeqH+0+phbMFMK6zkfouT8TYuBG6SlxTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417937; c=relaxed/simple;
	bh=iOZ6B8zYh0YthgrafJZcH2i2zfAoZ5p30EEv4Ow7zwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWsbR2GFAdsNGhhOQ3ISstCwMEtMwCb/vRtj+GPqZBn5hKaUApXJzHl0E5uoMkYMBbzxpu6daJFS+Z3v2gOOb4NERtOMeUg8LXPQhnexhks24cdwT+m5RGr6+6zuu+m9ZudB0icae/ypdQ6JUgky+Tll+oASdIe3MxsfKh4mlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ckx/V8mB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3EF0E000A;
	Thu,  9 Jan 2025 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUuIsbAAHb+7zpS6APWXsOOX+/W4kqiqreEkOVz8pkQ=;
	b=Ckx/V8mBXizxKQxEUYUtoRMzaOMbarptRU2VNnYyR2hRSZ8D0Qg+lOex4t8gLhJbOuIuA0
	2qWTVG+afIT2j4yUtTEor8dnVyoK50uSxIo9uoWbf9cCjyRsYxRpTItA2wtLK/UHQ5hJ2x
	1yXSvyfqJY6aZldiyVvBU18VDzORzwz8iZJiykUKSiZT6/ZkBn1f/y6nCm7AbH30sEjV7S
	6+H1G1eePyt9DRJXAZ2HUmVDL3FvIi3qlGwUNbys5Adlp69NOCDzH7IRVvYT7dXfH9J5Lt
	kw+2pBjj1jy3kZORj5eM4Yzie2201qLiWDJJnyQsmKtaGhcGXXk+b4l3opND1g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:18:03 +0100
Subject: [PATCH net-next v2 09/15] net: pse-pd: Remove is_enabled callback
 from drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-9-55ded947b510@bootlin.com>
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

The is_enabled callback is now redundant as the admin_state can be obtained
directly from the driver and provides the same information.

To simplify functionality, the core will handle this internally, making
the is_enabled callback unnecessary at the driver level. Remove the
callback from all drivers.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c       | 26 --------------------------
 drivers/net/pse-pd/pse_core.c      | 13 +++++++++++--
 drivers/net/pse-pd/pse_regulator.c |  9 ---------
 drivers/net/pse-pd/tps23881.c      | 28 ----------------------------
 include/linux/pse-pd/pse.h         |  3 ---
 5 files changed, 11 insertions(+), 68 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index da5d09ed628a..fc9e23927b3b 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -431,31 +431,6 @@ static int pd692x0_pi_disable(struct pse_controller_dev *pcdev, int id)
 	return 0;
 }
 
-static int pd692x0_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
-{
-	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
-	struct pd692x0_msg msg, buf = {0};
-	int ret;
-
-	ret = pd692x0_fw_unavailable(priv);
-	if (ret)
-		return ret;
-
-	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
-	msg.sub[2] = id;
-	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
-	if (ret < 0)
-		return ret;
-
-	if (buf.sub[1]) {
-		priv->admin_state[id] = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
-		return 1;
-	} else {
-		priv->admin_state[id] = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
-		return 0;
-	}
-}
-
 struct pd692x0_pse_ext_state_mapping {
 	u32 status_code;
 	enum ethtool_c33_pse_ext_state pse_ext_state;
@@ -1105,7 +1080,6 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_get_actual_pw = pd692x0_pi_get_actual_pw,
 	.pi_enable = pd692x0_pi_enable,
 	.pi_disable = pd692x0_pi_disable,
-	.pi_is_enabled = pd692x0_pi_is_enabled,
 	.pi_get_voltage = pd692x0_pi_get_voltage,
 	.pi_get_pw_limit = pd692x0_pi_get_pw_limit,
 	.pi_set_pw_limit = pd692x0_pi_set_pw_limit,
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 5f2a9f36e4ed..887a477197a6 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -210,16 +210,25 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	struct pse_admin_state admin_state = {0};
 	const struct pse_controller_ops *ops;
 	int id, ret;
 
 	ops = pcdev->ops;
-	if (!ops->pi_is_enabled)
+	if (!ops->pi_get_admin_state)
 		return -EOPNOTSUPP;
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
-	ret = ops->pi_is_enabled(pcdev, id);
+	ret = ops->pi_get_admin_state(pcdev, id, &admin_state);
+	if (ret)
+		goto out;
+
+	if (admin_state.podl_admin_state == ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED ||
+	    admin_state.c33_admin_state == ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED)
+		ret = 1;
+
+out:
 	mutex_unlock(&pcdev->lock);
 
 	return ret;
diff --git a/drivers/net/pse-pd/pse_regulator.c b/drivers/net/pse-pd/pse_regulator.c
index 86360056b2f5..6ce6773fff31 100644
--- a/drivers/net/pse-pd/pse_regulator.c
+++ b/drivers/net/pse-pd/pse_regulator.c
@@ -51,14 +51,6 @@ pse_reg_pi_disable(struct pse_controller_dev *pcdev, int id)
 	return 0;
 }
 
-static int
-pse_reg_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
-{
-	struct pse_reg_priv *priv = to_pse_reg(pcdev);
-
-	return regulator_is_enabled(priv->ps);
-}
-
 static int
 pse_reg_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
 			   struct pse_admin_state *admin_state)
@@ -95,7 +87,6 @@ static const struct pse_controller_ops pse_reg_ops = {
 	.pi_get_admin_state = pse_reg_pi_get_admin_state,
 	.pi_get_pw_status = pse_reg_pi_get_pw_status,
 	.pi_enable = pse_reg_pi_enable,
-	.pi_is_enabled = pse_reg_pi_is_enabled,
 	.pi_disable = pse_reg_pi_disable,
 };
 
diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index f735b6917f8b..340d70ee37fe 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -174,33 +174,6 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 	return i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, val);
 }
 
-static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
-{
-	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
-	struct i2c_client *client = priv->client;
-	bool enabled;
-	u8 chan;
-	u16 val;
-	int ret;
-
-	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
-	if (ret < 0)
-		return ret;
-
-	chan = priv->port[id].chan[0];
-	val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
-	enabled = !!(val);
-
-	if (priv->port[id].is_4p) {
-		chan = priv->port[id].chan[1];
-		val = tps23881_calc_val(ret, chan, 0, BIT(chan % 4));
-		enabled &= !!(val);
-	}
-
-	/* Return enabled status only if both channel are on this state */
-	return enabled;
-}
-
 static int
 tps23881_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
 			    struct pse_admin_state *admin_state)
@@ -690,7 +663,6 @@ static const struct pse_controller_ops tps23881_ops = {
 	.setup_pi_matrix = tps23881_setup_pi_matrix,
 	.pi_enable = tps23881_pi_enable,
 	.pi_disable = tps23881_pi_disable,
-	.pi_is_enabled = tps23881_pi_is_enabled,
 	.pi_get_admin_state = tps23881_pi_get_admin_state,
 	.pi_get_pw_status = tps23881_pi_get_pw_status,
 };
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 3c544aff58b9..b5ae3dcee550 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -122,8 +122,6 @@ struct ethtool_pse_control_status {
  * @pi_get_ext_state: Get the extended state of the PSE PI.
  * @pi_get_pw_class: Get the power class of the PSE PI.
  * @pi_get_actual_pw: Get actual power of the PSE PI in mW.
- * @pi_is_enabled: Return 1 if the PSE PI is enabled, 0 if not.
- *		   May also return negative errno.
  * @pi_enable: Configure the PSE PI as enabled.
  * @pi_disable: Configure the PSE PI as disabled.
  * @pi_get_voltage: Return voltage similarly to get_voltage regulator
@@ -145,7 +143,6 @@ struct pse_controller_ops {
 				struct pse_ext_state_info *ext_state_info);
 	int (*pi_get_pw_class)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_get_actual_pw)(struct pse_controller_dev *pcdev, int id);
-	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_get_voltage)(struct pse_controller_dev *pcdev, int id);

-- 
2.34.1


