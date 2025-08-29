Return-Path: <netdev+bounces-218345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6927CB3C0C4
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D5EA65240
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC9338F3C;
	Fri, 29 Aug 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pn9J0RIW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6132A3C4;
	Fri, 29 Aug 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485011; cv=none; b=cfJ6UlwwC043YjdXA8RIczXp0M0OwlXFmt9iai+aBUabsY4bCYOxInWn1mX7LnIjxtJ2g7m/C1JMF7jhsTJUDdV/F9SuPOF7ZnL2Jalq4bWKaob7O2uWb1S7UKCqRWiMKrHfz1aLW1GmTpjdQJEaBxUZe3liQcCgp7FdQrkTDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485011; c=relaxed/simple;
	bh=nDs+Ie14LE/juWFDz3NHG4FNB0iWCY6Xzjh/+R1BulU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jS1D1WGkDJsZJcEEr02vta3mjW1uy5pMcoDf4DjS/2bavNnVSao1nQYPhRpWiAmeS27zMXi34RWrOA3emmxmATMHNv4IJv88euns8ZjIC8lhx/Cix3p8MSsmaczWl4NBJHl5HVLpQ1KQGM3xPCxa5pP4ddxwIlNDUijWpiEB++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pn9J0RIW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C301C1A0DC6;
	Fri, 29 Aug 2025 16:30:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A5E5605F1;
	Fri, 29 Aug 2025 16:30:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 124461C22DC9E;
	Fri, 29 Aug 2025 18:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756485006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rB6OFQqpx/J1t/BrMgB2RTzpqylFswGdLZiejBlZhwI=;
	b=Pn9J0RIWX8RBICI135bvwWELfwaIqqvT9x9oh8Uxz2F5+1CN7P8SnbzOM8DaMse3xKN//R
	rqNW9fShs/KmPglnIu1mI3RBawoj8qZo5d+VIMq4Z4LBEqNf4v1tjLNA3kRb6tbw46lymY
	nksA+tqfPsvtpz4vyUvQ+agvNOIFbuMQYZMIFW70CQHJjZNLq6IR9oBuJ876fbPyOn7DC2
	TW9opmEdWhmIJ0+e//1plNmihcOm8mqO8STWf87H81yaRQhv6wmuOBy7ilr9QuUEW3FRJJ
	2TojgSo/xTzgTrrxCzngBGPey4Q7egIgRkX1N/rmjorPipAyO0E41OexodpvUw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 29 Aug 2025 18:28:46 +0200
Subject: [PATCH net-next v2 4/4] net: pse-pd: pd692x0: Add devlink
 interface for configuration save/reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
In-Reply-To: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-doc@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add devlink param attributes PD692X0_DEVLINK_PARAM_ID_SAVE_CONF and
PD692X0_DEVLINK_PARAM_ID_RESET_CONF to enable userspace management of the
PSE's permanent configuration stored in non-volatile memory.

The save_conf attribute with the '1' value allows saving the current
configuration to non-volatile memory. The reset_conf attribute restores
factory defaults configurations.

Skip hardware configuration initialization on probe when a saved
configuration is already present in non-volatile memory (detected via user
byte 42).

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Move on from sysfs to devlink param for userspace management.
---
 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/pd692x0.rst |  32 +++++
 drivers/net/pse-pd/pd692x0.c                 | 205 ++++++++++++++++++++++++++-
 3 files changed, 235 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 0c58e5c729d92..6db7d9b45f7aa 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -96,6 +96,7 @@ parameters, info versions, and other features it supports.
    netdevsim
    nfp
    octeontx2
+   pd692x0
    prestera
    qed
    sfc
diff --git a/Documentation/networking/devlink/pd692x0.rst b/Documentation/networking/devlink/pd692x0.rst
new file mode 100644
index 0000000000000..3f3edd0ac0361
--- /dev/null
+++ b/Documentation/networking/devlink/pd692x0.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+PSE PD692x0 devlink support
+===========================
+
+This document describes the devlink features implemented by the PSE ``PD692x0``
+device drivers.
+
+Parameters
+==========
+
+The ``PD692x0`` drivers implement the following driver-specific parameters.
+
+.. list-table:: Driver-specific parameters implemented
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``save_conf``
+     - bool
+     - runtime
+     - Save the current configuration to non-volatile memory using ``1``
+       attribute value.
+   * - ``reset_conf``
+     - bool
+     - runtime
+     - Reset the current and saved configuration using ``1`` attribute
+       value.
+
diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 782b1abf94cb1..eb4b911d438b3 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -14,6 +14,7 @@
 #include <linux/pse-pd/pse.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <net/devlink.h>
 
 #define PD692X0_PSE_NAME "pd692x0_pse"
 
@@ -30,6 +31,8 @@
 #define PD692X0_FW_MIN_VER	5
 #define PD692X0_FW_PATCH_VER	5
 
+#define PD692X0_USER_BYTE	42
+
 enum pd692x0_fw_state {
 	PD692X0_FW_UNKNOWN,
 	PD692X0_FW_OK,
@@ -80,6 +83,9 @@ enum {
 	PD692X0_MSG_GET_PORT_PARAM,
 	PD692X0_MSG_GET_POWER_BANK,
 	PD692X0_MSG_SET_POWER_BANK,
+	PD692X0_MSG_SET_USER_BYTE,
+	PD692X0_MSG_SAVE_SYS_SETTINGS,
+	PD692X0_MSG_RESTORE_FACTORY,
 
 	/* add new message above here */
 	PD692X0_MSG_CNT
@@ -103,11 +109,13 @@ struct pd692x0_priv {
 	bool last_cmd_key;
 	unsigned long last_cmd_key_time;
 
+	bool cfg_saved;
 	enum ethtool_c33_pse_admin_state admin_state[PD692X0_MAX_PIS];
 	struct regulator_dev *manager_reg[PD692X0_MAX_MANAGERS];
 	int manager_pw_budget[PD692X0_MAX_MANAGERS];
 	int nmanagers;
 	struct pd692x0_matrix *port_matrix;
+	struct devlink *dl;
 };
 
 /* Template list of communication messages. The non-null bytes defined here
@@ -193,6 +201,24 @@ static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
 		.key = PD692X0_KEY_CMD,
 		.sub = {0x07, 0x0b, 0x57},
 	},
+	[PD692X0_MSG_SET_USER_BYTE] = {
+		.key = PD692X0_KEY_PRG,
+		.sub = {0x41, PD692X0_USER_BYTE},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
+	[PD692X0_MSG_SAVE_SYS_SETTINGS] = {
+		.key = PD692X0_KEY_PRG,
+		.sub = {0x06, 0x0f},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
+	[PD692X0_MSG_RESTORE_FACTORY] = {
+		.key = PD692X0_KEY_PRG,
+		.sub = {0x2d, 0x4e},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
 };
 
 static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
@@ -1268,9 +1294,12 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	if (ret)
 		goto err_managers_req_pw;
 
-	ret = pd692x0_hw_conf_init(priv);
-	if (ret)
-		goto err_managers_req_pw;
+	/* Do not init the conf if it is already saved */
+	if (!priv->cfg_saved) {
+		ret = pd692x0_hw_conf_init(priv);
+		if (ret)
+			goto err_managers_req_pw;
+	}
 
 	pd692x0_of_put_managers(priv, manager);
 	kfree(manager);
@@ -1727,14 +1756,148 @@ static const struct fw_upload_ops pd692x0_fw_ops = {
 	.cleanup = pd692x0_fw_cleanup,
 };
 
+/* Devlink Params APIs */
+enum pd692x0_devlink_param_id {
+	PD692X0_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	PD692X0_DEVLINK_PARAM_ID_SAVE_CONF,
+	PD692X0_DEVLINK_PARAM_ID_RESET_CONF,
+};
+
+struct pd692x0_devlink {
+	struct pd692x0_priv *priv;
+};
+
+static int pd692x0_dl_validate(struct devlink *devlink, u32 id,
+			       union devlink_param_value val,
+			       struct netlink_ext_ack *extack)
+{
+	if (!val.vbool) {
+		NL_SET_ERR_MSG_FMT(extack, "0 is not a valid value");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int pd692x0_dl_save_conf_set(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct pd692x0_devlink *dl = devlink_priv(devlink);
+	struct pd692x0_priv *priv = dl->priv;
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	mutex_lock(&priv->pcdev.lock);
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		goto out;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_USER_BYTE];
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret)
+		goto out;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SAVE_SYS_SETTINGS];
+	ret = pd692x0_send_msg(priv, &msg);
+	if (ret) {
+		dev_err(&priv->client->dev,
+			"Failed to save the configuration (%pe)\n",
+			ERR_PTR(ret));
+		goto out;
+	}
+
+	msleep(50); /* Sleep 50ms as described in the datasheet */
+
+	ret = i2c_master_recv(priv->client, (u8 *)&buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		if (ret >= 0)
+			ret = -EIO;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	mutex_unlock(&priv->pcdev.lock);
+	return ret;
+}
+
+static int pd692x0_dl_reset_conf_set(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
+{
+	struct pd692x0_devlink *dl = devlink_priv(devlink);
+	struct pd692x0_priv *priv = dl->priv;
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	mutex_lock(&priv->pcdev.lock);
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		goto out;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_RESTORE_FACTORY];
+	ret = pd692x0_send_msg(priv, &msg);
+	if (ret) {
+		dev_err(&priv->client->dev,
+			"Failed to reset the configuration (%pe)\n",
+			ERR_PTR(ret));
+		goto out;
+	}
+
+	msleep(100); /* Sleep 100ms as described in the datasheet */
+
+	ret = i2c_master_recv(priv->client, (u8 *)&buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		if (ret >= 0)
+			ret = -EIO;
+		goto out;
+	}
+
+	ret = pd692x0_hw_conf_init(priv);
+	if (ret) {
+		dev_err(&priv->client->dev,
+			"Error configuring ports matrix (%pe)\n",
+			ERR_PTR(ret));
+	}
+
+out:
+	mutex_unlock(&priv->pcdev.lock);
+	return ret;
+}
+
+static int pd692x0_dl_dummy_get(struct devlink *devlink, u32 id,
+				struct devlink_param_gset_ctx *ctx)
+{
+	return 0;
+}
+
+static const struct devlink_param pd692x0_dl_params[] = {
+	DEVLINK_PARAM_DRIVER(PD692X0_DEVLINK_PARAM_ID_SAVE_CONF,
+			     "save_conf", DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     pd692x0_dl_dummy_get, pd692x0_dl_save_conf_set,
+			     pd692x0_dl_validate),
+	DEVLINK_PARAM_DRIVER(PD692X0_DEVLINK_PARAM_ID_RESET_CONF,
+			     "reset_conf", DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     pd692x0_dl_dummy_get, pd692x0_dl_reset_conf_set,
+			     pd692x0_dl_validate),
+};
+
+static const struct devlink_ops pd692x0_dl_ops = { };
+
 static int pd692x0_i2c_probe(struct i2c_client *client)
 {
 	static const char * const regulators[] = { "vdd", "vdda" };
 	struct pd692x0_msg msg, buf = {0}, zero = {0};
+	struct pd692x0_devlink *pd692x0_dl;
 	struct device *dev = &client->dev;
 	struct pd692x0_msg_ver ver;
 	struct pd692x0_priv *priv;
 	struct fw_upload *fwl;
+	struct devlink *dl;
 	int ret;
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
@@ -1793,6 +1956,9 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 		}
 	}
 
+	if (buf.data[2] == PD692X0_USER_BYTE)
+		priv->cfg_saved = true;
+
 	priv->np = dev->of_node;
 	priv->pcdev.nr_lines = PD692X0_MAX_PIS;
 	priv->pcdev.owner = THIS_MODULE;
@@ -1813,14 +1979,47 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 				     "failed to register to the Firmware Upload API\n");
 	priv->fwl = fwl;
 
+	dl = devlink_alloc(&pd692x0_dl_ops,
+			   sizeof(struct pd692x0_devlink), dev);
+	if (!dl) {
+		dev_err(dev, "devlink_alloc failed\n");
+		ret = -ENOMEM;
+		goto err_unregister_fw;
+	}
+
+	pd692x0_dl = devlink_priv(dl);
+	pd692x0_dl->priv = priv;
+	priv->dl = dl;
+
+	ret = devlink_params_register(dl, pd692x0_dl_params,
+				      ARRAY_SIZE(pd692x0_dl_params));
+	if (ret) {
+		dev_err(dev,
+			"devlink params register failed with error %d",
+			ret);
+		goto err_free_dl;
+	}
+
+	devlink_register(dl);
 	return 0;
+
+err_free_dl:
+	devlink_free(dl);
+err_unregister_fw:
+	firmware_upload_unregister(priv->fwl);
+
+	return ret;
 }
 
 static void pd692x0_i2c_remove(struct i2c_client *client)
 {
 	struct pd692x0_priv *priv = i2c_get_clientdata(client);
+	struct devlink *dl = priv->dl;
 
 	pd692x0_managers_free_pw_budget(priv);
+	devlink_params_unregister(dl, pd692x0_dl_params,
+				  ARRAY_SIZE(pd692x0_dl_params));
+	devlink_unregister(dl);
 	firmware_upload_unregister(priv->fwl);
 }
 

-- 
2.43.0


