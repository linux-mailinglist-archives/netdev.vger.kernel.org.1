Return-Path: <netdev+bounces-140494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23FA9B6A07
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3121C23FDD
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116E22ADE7;
	Wed, 30 Oct 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YjpHq0m/"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48222A495;
	Wed, 30 Oct 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307260; cv=none; b=BDXlZCYOnkEwaj0FepYi7hQEdR39eNhYfFKYZmkSz01/r3vzJ9PeWS7R49bMcdxc44FzY9zopjaTAZBW+K/xVbWc8pitRJJZihiyFByf6HNpVN50jphUDA92D18TiAABrRZRMVEvyutI2HmvEtALrRgN+PoPSQa8noZy/kGTjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307260; c=relaxed/simple;
	bh=EMjeSvfOC5IkeddTk73wHP7CNIy5Wf4vXWrjzp14ZzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWjzkxksUNvPWWr+lNT7TQUDaeeKm1X1u0lLqB8AusMkHFzJXScnacxLGvC071jsssgaEBq//mCSi/uwlPoWI1OMgoxTHIayPstkQFmB6deV1P2VCdbnTW6JPgxXCPpNebZ1J/IpJW0sVfKSb4SzS5GwgaexgrYOPa33qRSnO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YjpHq0m/; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B655FC000B;
	Wed, 30 Oct 2024 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvmAMGax6dNwCZy8+Fe42XCwON0HoTKAXTO/9PqlEtM=;
	b=YjpHq0m/GxEuDroMzfEDPgg+YUwnojLZ8Rq74FKOypdQiJf7iCKwQfASsGvcydXS0VqW7F
	zJ14yG1WcrEKd6xEbWLFNJkczPIGQZuso6zQvuwFzMZ5G4uF7W0+MxyZRyglteULdkxC4i
	E0Tq4Eft30snvBIRTzZawHMsKyRYst2JxZoCD9ZjHnJfqa0PCv186Dd36lnN2avhzDiSYg
	oaGue/7w2znr+OhM2ywZ3824K9EtpZCATZmcKEB8WOk3G52zyXRgAX6BXw1zJGegDEHtvz
	t2J3Oe8uO2yDqIOtastSjp2OXiKLvNDBLC7v1m58u/LAI+PxjhAA29fJ45Rg3Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:20 +0100
Subject: [PATCH RFC net-next v2 18/18] net: pse-pd: pd692x0: Add support
 for PSE PI priority feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_poe_port_prio-v2-18-9559622ee47a@bootlin.com>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
In-Reply-To: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
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

This patch extends the PSE callbacks by adding support for the newly
introduced pi_set_prio() callback, enabling the configuration of PSE PI
priorities. The current port priority is now also included in the status
information returned to users.

Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 0af7db80b2f8..018b6559049f 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -685,6 +685,8 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 	if (ret < 0)
 		return ret;
 	status->c33_avail_pw_limit = ret;
+	/* PSE core priority start at 0 */
+	status->c33_prio = buf.data[2] - 1;
 
 	memset(&buf, 0, sizeof(buf));
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_CLASS];
@@ -1061,6 +1063,25 @@ static int pd692x0_pi_set_current_limit(struct pse_controller_dev *pcdev,
 	return pd692x0_sendrecv_msg(priv, &msg, &buf);
 }
 
+static int pd692x0_pi_set_prio(struct pse_controller_dev *pcdev, int id,
+			       unsigned int prio)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
+	msg.sub[2] = id;
+	/* Controller priority from 1 to 3 */
+	msg.data[4] = prio + 1;
+
+	return pd692x0_sendrecv_msg(priv, &msg, &buf);
+}
+
 static const struct pse_controller_ops pd692x0_ops = {
 	.setup_pi_matrix = pd692x0_setup_pi_matrix,
 	.ethtool_get_status = pd692x0_ethtool_get_status,
@@ -1070,6 +1091,7 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_get_voltage = pd692x0_pi_get_voltage,
 	.pi_get_current_limit = pd692x0_pi_get_current_limit,
 	.pi_set_current_limit = pd692x0_pi_set_current_limit,
+	.pi_set_prio = pd692x0_pi_set_prio,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff
@@ -1486,6 +1508,8 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	priv->pcdev.ops = &pd692x0_ops;
 	priv->pcdev.dev = dev;
 	priv->pcdev.types = ETHTOOL_PSE_C33;
+	priv->pcdev.port_prio_supp_modes = BIT(ETHTOOL_PSE_PORT_PRIO_DYNAMIC);
+	priv->pcdev.pis_prio_max = 2;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret)
 		return dev_err_probe(dev, ret,

-- 
2.34.1


