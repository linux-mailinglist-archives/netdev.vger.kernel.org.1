Return-Path: <netdev+bounces-216082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E0B31F67
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1647BAE93
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D092ECEBC;
	Fri, 22 Aug 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZOvGqT6v"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE72EC579
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877083; cv=none; b=GW6Bi58VsofxnWVYGTziQofz4kR8wCnAgTQngmsNVvlzZf4PQAwifRcWsmD8Cant2zbRgJF+xgOUsOha/bDH8fq00m/4cgDQyUR5hYA4/wTGXQIwFdD7VnNI3O1ENrWgzrVDTwyB5gUx98lxtZJ1DQhf58+tHMmgatuE1ukhm2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877083; c=relaxed/simple;
	bh=fNFPaFxaGIxv5Y8hCloKDpiUz2vCKZuJPCQSbCRT2CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQ54wbBynO7Zy59jIzm+O7kliraJez2D5jYo2fhtRr2LGAGHZN8jeWZGFTIdXEFXcoXdXE6n0zO13MrYYN+plGYudjZW1V1CCIIHM4BXPobEHAZ4OU17S7jikfwF6NHc00eoN8EvdWwAsEANL7KuFtt7Tm3u4ymUgBX6M3e3uRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZOvGqT6v; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B39BF4E40BD1;
	Fri, 22 Aug 2025 15:37:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8EAD7604AD;
	Fri, 22 Aug 2025 15:37:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E88791C22D194;
	Fri, 22 Aug 2025 17:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755877078; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7PVWOEKulKe5NQD88m9aMzcwTOMAsDLujR1Ax84aCtE=;
	b=ZOvGqT6viS25r9BeVLxBHtz91CZ30Cx3LeFaFwaG1vqZ1qmgDqZAzDfl07afzAp4QQEBZC
	YkRl9Sq+81q6hbq9qPLPJqgfnaExwx5sR+cP+VgwiiC0RaGwjzfKG5/R+b70f6/Nf3gpbH
	aQH25DTAYlnqG9acUKMl41I2NR0zeVDh015nP9PH6xcrzlh0a1D/MroAA6zsf1CnkdoDK6
	z9gxlDg1dVjdSYBoBAJM+B+12Wg3LHQtubqp80Wu1jV/EUC2D+mJtIH3yC5abtdgxWvW4X
	otJizU1BxTtDxdAHSZhTyCgzbPH43JB49Aa1HLbdIv9EkOs7DA1csz6bxP+pdg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 22 Aug 2025 17:37:01 +0200
Subject: [PATCH net-next 1/2] net: pse-pd: pd692x0: Separate configuration
 parsing from hardware setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-feature_poe_permanent_conf-v1-1-dcd41290254d@bootlin.com>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
In-Reply-To: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Cache the port matrix configuration in driver private data to enable
PSE controller reconfiguration. This refactoring separates device tree
parsing from hardware configuration application, allowing settings to be
reapplied without reparsing the device tree.

This prepares for upcoming permanent configuration support where cached
settings can be restored after device resets or firmware updates.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 113 ++++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 39 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index f4e91ba64a66..8b94967bb4fb 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -85,6 +85,11 @@ enum {
 	PD692X0_MSG_CNT
 };
 
+struct pd692x0_matrix {
+	u8 hw_port_a;
+	u8 hw_port_b;
+};
+
 struct pd692x0_priv {
 	struct i2c_client *client;
 	struct pse_controller_dev pcdev;
@@ -101,6 +106,8 @@ struct pd692x0_priv {
 	enum ethtool_c33_pse_admin_state admin_state[PD692X0_MAX_PIS];
 	struct regulator_dev *manager_reg[PD692X0_MAX_MANAGERS];
 	int manager_pw_budget[PD692X0_MAX_MANAGERS];
+	int nmanagers;
+	struct pd692x0_matrix *port_matrix;
 };
 
 /* Template list of communication messages. The non-null bytes defined here
@@ -809,11 +816,6 @@ struct pd692x0_manager {
 	int nports;
 };
 
-struct pd692x0_matrix {
-	u8 hw_port_a;
-	u8 hw_port_b;
-};
-
 static int
 pd692x0_of_get_ports_manager(struct pd692x0_priv *priv,
 			     struct pd692x0_manager *manager,
@@ -903,7 +905,8 @@ pd692x0_of_get_managers(struct pd692x0_priv *priv,
 	}
 
 	of_node_put(managers_node);
-	return nmanagers;
+	priv->nmanagers = nmanagers;
+	return 0;
 
 out:
 	for (i = 0; i < nmanagers; i++) {
@@ -963,8 +966,7 @@ pd692x0_register_manager_regulator(struct device *dev, char *reg_name,
 
 static int
 pd692x0_register_managers_regulator(struct pd692x0_priv *priv,
-				    const struct pd692x0_manager *manager,
-				    int nmanagers)
+				    const struct pd692x0_manager *manager)
 {
 	struct device *dev = &priv->client->dev;
 	size_t reg_name_len;
@@ -975,7 +977,7 @@ pd692x0_register_managers_regulator(struct pd692x0_priv *priv,
 	 */
 	reg_name_len = strlen(dev_name(dev)) + 23;
 
-	for (i = 0; i < nmanagers; i++) {
+	for (i = 0; i < priv->nmanagers; i++) {
 		static const char * const regulators[] = { "vaux5", "vaux3p3" };
 		struct regulator_dev *rdev;
 		char *reg_name;
@@ -1008,10 +1010,14 @@ pd692x0_register_managers_regulator(struct pd692x0_priv *priv,
 }
 
 static int
-pd692x0_conf_manager_power_budget(struct pd692x0_priv *priv, int id, int pw)
+pd692x0_conf_manager_power_budget(struct pd692x0_priv *priv, int id)
 {
 	struct pd692x0_msg msg, buf;
-	int ret, pw_mW = pw / 1000;
+	int ret, pw_mW;
+
+	pw_mW = priv->manager_pw_budget[id] / 1000;
+	if (!pw_mW)
+		return 0;
 
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_POWER_BANK];
 	msg.data[0] = id;
@@ -1032,11 +1038,11 @@ pd692x0_conf_manager_power_budget(struct pd692x0_priv *priv, int id, int pw)
 }
 
 static int
-pd692x0_configure_managers(struct pd692x0_priv *priv, int nmanagers)
+pd692x0_req_managers_pw_budget(struct pd692x0_priv *priv)
 {
 	int i, ret;
 
-	for (i = 0; i < nmanagers; i++) {
+	for (i = 0; i < priv->nmanagers; i++) {
 		struct regulator *supply = priv->manager_reg[i]->supply;
 		int pw_budget;
 
@@ -1053,7 +1059,18 @@ pd692x0_configure_managers(struct pd692x0_priv *priv, int nmanagers)
 			return ret;
 
 		priv->manager_pw_budget[i] = pw_budget;
-		ret = pd692x0_conf_manager_power_budget(priv, i, pw_budget);
+	}
+
+	return 0;
+}
+
+static int
+pd692x0_configure_managers(struct pd692x0_priv *priv)
+{
+	int i, ret;
+
+	for (i = 0; i < priv->nmanagers; i++) {
+		ret = pd692x0_conf_manager_power_budget(priv, i);
 		if (ret < 0)
 			return ret;
 	}
@@ -1101,10 +1118,9 @@ pd692x0_set_port_matrix(const struct pse_pi_pairset *pairset,
 
 static int
 pd692x0_set_ports_matrix(struct pd692x0_priv *priv,
-			 const struct pd692x0_manager *manager,
-			 int nmanagers,
-			 struct pd692x0_matrix port_matrix[PD692X0_MAX_PIS])
+			 const struct pd692x0_manager *manager)
 {
+	struct pd692x0_matrix *port_matrix = priv->port_matrix;
 	struct pse_controller_dev *pcdev = &priv->pcdev;
 	int i, ret;
 
@@ -1117,7 +1133,7 @@ pd692x0_set_ports_matrix(struct pd692x0_priv *priv,
 	/* Update with values for every PSE PIs */
 	for (i = 0; i < pcdev->nr_lines; i++) {
 		ret = pd692x0_set_port_matrix(&pcdev->pi[i].pairset[0],
-					      manager, nmanagers,
+					      manager, priv->nmanagers,
 					      &port_matrix[i]);
 		if (ret) {
 			dev_err(&priv->client->dev,
@@ -1126,7 +1142,7 @@ pd692x0_set_ports_matrix(struct pd692x0_priv *priv,
 		}
 
 		ret = pd692x0_set_port_matrix(&pcdev->pi[i].pairset[1],
-					      manager, nmanagers,
+					      manager, priv->nmanagers,
 					      &port_matrix[i]);
 		if (ret) {
 			dev_err(&priv->client->dev,
@@ -1139,9 +1155,9 @@ pd692x0_set_ports_matrix(struct pd692x0_priv *priv,
 }
 
 static int
-pd692x0_write_ports_matrix(struct pd692x0_priv *priv,
-			   const struct pd692x0_matrix port_matrix[PD692X0_MAX_PIS])
+pd692x0_write_ports_matrix(struct pd692x0_priv *priv)
 {
+	struct pd692x0_matrix *port_matrix = priv->port_matrix;
 	struct pd692x0_msg msg, buf;
 	int ret, i;
 
@@ -1166,13 +1182,32 @@ pd692x0_write_ports_matrix(struct pd692x0_priv *priv,
 	return 0;
 }
 
+static int pd692x0_hw_conf_init(struct pd692x0_priv *priv)
+{
+	int ret;
+
+	/* Is PD692x0 ready to be configured? */
+	if (priv->fw_state != PD692X0_FW_OK &&
+	    priv->fw_state != PD692X0_FW_COMPLETE)
+		return 0;
+
+	ret = pd692x0_configure_managers(priv);
+	if (ret)
+		return ret;
+
+	ret = pd692x0_write_ports_matrix(priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void pd692x0_of_put_managers(struct pd692x0_priv *priv,
-				    struct pd692x0_manager *manager,
-				    int nmanagers)
+				    struct pd692x0_manager *manager)
 {
 	int i, j;
 
-	for (i = 0; i < nmanagers; i++) {
+	for (i = 0; i < priv->nmanagers; i++) {
 		for (j = 0; j < manager[i].nports; j++)
 			of_node_put(manager[i].port_node[j]);
 		of_node_put(manager[i].node);
@@ -1202,46 +1237,46 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 {
 	struct pd692x0_manager *manager __free(kfree) = NULL;
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
-	struct pd692x0_matrix port_matrix[PD692X0_MAX_PIS];
-	int ret, nmanagers;
-
-	/* Should we flash the port matrix */
-	if (priv->fw_state != PD692X0_FW_OK &&
-	    priv->fw_state != PD692X0_FW_COMPLETE)
-		return 0;
+	struct pd692x0_matrix *port_matrix;
+	int ret;
 
 	manager = kcalloc(PD692X0_MAX_MANAGERS, sizeof(*manager), GFP_KERNEL);
 	if (!manager)
 		return -ENOMEM;
 
+	port_matrix = devm_kcalloc(&priv->client->dev, PD692X0_MAX_PIS,
+				   sizeof(*port_matrix), GFP_KERNEL);
+	if (!port_matrix)
+		return -ENOMEM;
+	priv->port_matrix = port_matrix;
+
 	ret = pd692x0_of_get_managers(priv, manager);
 	if (ret < 0)
 		return ret;
 
-	nmanagers = ret;
-	ret = pd692x0_register_managers_regulator(priv, manager, nmanagers);
+	ret = pd692x0_register_managers_regulator(priv, manager);
 	if (ret)
 		goto err_of_managers;
 
-	ret = pd692x0_configure_managers(priv, nmanagers);
+	ret = pd692x0_req_managers_pw_budget(priv);
 	if (ret)
 		goto err_of_managers;
 
-	ret = pd692x0_set_ports_matrix(priv, manager, nmanagers, port_matrix);
+	ret = pd692x0_set_ports_matrix(priv, manager);
 	if (ret)
 		goto err_managers_req_pw;
 
-	ret = pd692x0_write_ports_matrix(priv, port_matrix);
+	ret = pd692x0_hw_conf_init(priv);
 	if (ret)
 		goto err_managers_req_pw;
 
-	pd692x0_of_put_managers(priv, manager, nmanagers);
+	pd692x0_of_put_managers(priv, manager);
 	return 0;
 
 err_managers_req_pw:
 	pd692x0_managers_free_pw_budget(priv);
 err_of_managers:
-	pd692x0_of_put_managers(priv, manager, nmanagers);
+	pd692x0_of_put_managers(priv, manager);
 	return ret;
 }
 
@@ -1644,7 +1679,7 @@ static enum fw_upload_err pd692x0_fw_poll_complete(struct fw_upload *fwl)
 		return FW_UPLOAD_ERR_FW_INVALID;
 	}
 
-	ret = pd692x0_setup_pi_matrix(&priv->pcdev);
+	ret = pd692x0_hw_conf_init(priv);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error configuring ports matrix (%pe)\n",
 			ERR_PTR(ret));

-- 
2.43.0


