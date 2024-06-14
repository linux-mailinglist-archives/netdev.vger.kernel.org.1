Return-Path: <netdev+bounces-103635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602D908D80
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD26D28BE8F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579B3A260;
	Fri, 14 Jun 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F9OfHLXn"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F66125CC;
	Fri, 14 Jun 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375614; cv=none; b=gSdxUPkRilPXP6L308mGsWCeztgXf810uEP58Ik5OKK/nLEMUluyYVNl80WrtRZkd5HJAIqMLMFZeE9HE8Noj+L50QwkssEswXFRCfAmiv/BwqW7iYSGOumRxTUeoZnE34TitU4vocm+Cw5nPgHZm8bnJh2yDKzq62WGa5kOdJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375614; c=relaxed/simple;
	bh=T9f3w22iVGstgU3NrmllkIxphpImkukKBRgf/Z12e60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9v/Jc8KaVk0W+Nh+Id0oWjdRIK02K9exWKCof84Umjo33MxOFk2NKrGmwO+i+/NFfArzVitZypouDA44Qje5kF4dRW2EM0O6wXUyc4N1//PLi6Xy6eFpnTOVXFaFOCP9mJ18Ecm2zHJoyTiXTpEaQ9ADCFxMXTJwh0OkdVILWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F9OfHLXn; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 197CD1C000C;
	Fri, 14 Jun 2024 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718375603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYMpMBGcwp3zR2rlRH1PBYY4XPPycQ9VN6ginHt+7xg=;
	b=F9OfHLXny3cpxGpAwryDfewevLOe1thDyyCdllhmZxx1ylZ9eXMIFGzitQ5QAnKIOqUT3M
	dUtk3FUayWI0zIF+6jDsnqoG2UjrgjZBz97xADVS9DoczgU/eC7vjalkJ14Er1VMwj6fYE
	HsL+s6UkZMay7U9oWXNrP7K56HIH0XCc/+6Jsd9PPCMI8/Yi1+I+BUfvBBcnoMOuuQ/4W9
	GJbeyGHpUS1NVypw9IihUEgsGQcr+jIJZYnGMJAXuJsZsnaYpCndKNj4KGORd8yiIU/2tN
	SSN9o6s1/jhu/QhPs3MerU5MrrD1nyEQbcbuJw2oZFeFh5S99EYyqfmCcHGlsQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 14 Jun 2024 16:33:20 +0200
Subject: [PATCH net-next v3 4/7] net: pse-pd: Add new power limit get and
 set c33 features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-feature_poe_power_cap-v3-4-a26784e78311@bootlin.com>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
In-Reply-To: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch add a way to get and set the power limit of a PSE PI.
For that it uses regulator API callbacks wrapper like get_voltage() and
get/set_current_limit() as power is simply V * I.
We used mW unit as defined by the IEEE 802.3-2022 standards.

set_current_limit() uses the voltage return by get_voltage() and the
desired power limit to calculate the current limit. get_voltage() callback
is then mandatory to set the power limit.

get_current_limit() callback is by default looking at a driver callback
and fallback to extracting the current limit from _pse_ethtool_get_status()
if the driver does not set its callback. We prefer let the user the choice
because ethtool_get_status return much more information than the current
limit.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Use uA and uV instead of mA and mV to have more precision in the power
  calculation. Need to use 64bit variables for the calculation.
---
 drivers/net/pse-pd/pse_core.c | 172 +++++++++++++++++++++++++++++++++++++++---
 include/linux/pse-pd/pse.h    |  34 +++++++++
 2 files changed, 195 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 795ab264eaf2..98da4488a8fe 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -265,10 +265,113 @@ static int pse_pi_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
+static int _pse_pi_get_voltage(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	int id;
+
+	ops = pcdev->ops;
+	if (!ops->pi_get_voltage)
+		return -EOPNOTSUPP;
+
+	id = rdev_get_id(rdev);
+	return ops->pi_get_voltage(pcdev, id);
+}
+
+static int pse_pi_get_voltage(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	int ret;
+
+	mutex_lock(&pcdev->lock);
+	ret = _pse_pi_get_voltage(rdev);
+	mutex_unlock(&pcdev->lock);
+
+	return ret;
+}
+
+static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
+				   int id,
+				   struct netlink_ext_ack *extack,
+				   struct pse_control_status *status);
+
+static int pse_pi_get_current_limit(struct regulator_dev *rdev)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	struct netlink_ext_ack extack = {};
+	struct pse_control_status st = {};
+	int id, uV, ret;
+	s64 tmp_64;
+
+	ops = pcdev->ops;
+	id = rdev_get_id(rdev);
+	mutex_lock(&pcdev->lock);
+	if (ops->pi_get_current_limit) {
+		ret = ops->pi_get_current_limit(pcdev, id);
+		goto out;
+	}
+
+	/* If pi_get_current_limit() callback not populated get voltage
+	 * from pi_get_voltage() and power limit from ethtool_get_status()
+	 *  to calculate current limit.
+	 */
+	ret = _pse_pi_get_voltage(rdev);
+	if (!ret) {
+		dev_err(pcdev->dev, "Voltage null\n");
+		ret = -ERANGE;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+	uV = ret;
+
+	ret = _pse_ethtool_get_status(pcdev, id, &extack, &st);
+	if (ret)
+		goto out;
+
+	if (!st.c33_pw_limit) {
+		ret = -ENODATA;
+		goto out;
+	}
+
+	tmp_64 = st.c33_pw_limit;
+	tmp_64 *= 1000000000ull;
+	/* uA = mW * 1000000000 / uV */
+	ret = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
+
+out:
+	mutex_unlock(&pcdev->lock);
+	return ret;
+}
+
+static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
+				    int max_uA)
+{
+	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
+	const struct pse_controller_ops *ops;
+	int id, ret;
+
+	ops = pcdev->ops;
+	if (!ops->pi_set_current_limit)
+		return -EOPNOTSUPP;
+
+	id = rdev_get_id(rdev);
+	mutex_lock(&pcdev->lock);
+	ret = ops->pi_set_current_limit(pcdev, id, max_uA);
+	mutex_unlock(&pcdev->lock);
+
+	return ret;
+}
+
 static const struct regulator_ops pse_pi_ops = {
 	.is_enabled = pse_pi_is_enabled,
 	.enable = pse_pi_enable,
 	.disable = pse_pi_disable,
+	.get_voltage = pse_pi_get_voltage,
+	.get_current_limit = pse_pi_get_current_limit,
+	.set_current_limit = pse_pi_set_current_limit,
 };
 
 static int
@@ -298,7 +401,9 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	rdesc->ops = &pse_pi_ops;
 	rdesc->owner = pcdev->owner;
 
-	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
+	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS |
+						 REGULATOR_CHANGE_CURRENT;
+	rinit_data->constraints.max_uA = MAX_PI_CURRENT;
 	rinit_data->supply_regulator = "vpwr";
 
 	rconfig.dev = pcdev->dev;
@@ -626,6 +731,23 @@ struct pse_control *of_pse_control_get(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_pse_control_get);
 
+static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
+				   int id,
+				   struct netlink_ext_ack *extack,
+				   struct pse_control_status *status)
+{
+	const struct pse_controller_ops *ops;
+
+	ops = pcdev->ops;
+	if (!ops->ethtool_get_status) {
+		NL_SET_ERR_MSG(extack,
+			       "PSE driver does not support status report");
+		return -EOPNOTSUPP;
+	}
+
+	return ops->ethtool_get_status(pcdev, id, extack, status);
+}
+
 /**
  * pse_ethtool_get_status - get status of PSE control
  * @psec: PSE control pointer
@@ -638,19 +760,10 @@ int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   struct pse_control_status *status)
 {
-	const struct pse_controller_ops *ops;
 	int err;
 
-	ops = psec->pcdev->ops;
-
-	if (!ops->ethtool_get_status) {
-		NL_SET_ERR_MSG(extack,
-			       "PSE driver does not support status report");
-		return -EOPNOTSUPP;
-	}
-
 	mutex_lock(&psec->pcdev->lock);
-	err = ops->ethtool_get_status(psec->pcdev, psec->id, extack, status);
+	err = _pse_ethtool_get_status(psec->pcdev, psec->id, extack, status);
 	mutex_unlock(&psec->pcdev->lock);
 
 	return err;
@@ -732,6 +845,43 @@ int pse_ethtool_set_config(struct pse_control *psec,
 }
 EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
 
+/**
+ * pse_ethtool_set_pw_limit - set PSE control power limit
+ * @psec: PSE control pointer
+ * @extack: extack for reporting useful error messages
+ * @pw_limit: power limit value in mW
+ *
+ * Return: 0 on success and failure value on error
+ */
+int pse_ethtool_set_pw_limit(struct pse_control *psec,
+			     struct netlink_ext_ack *extack,
+			     const unsigned int pw_limit)
+{
+	int uV, uA, ret;
+	s64 tmp_64;
+
+	ret = regulator_get_voltage(psec->ps);
+	if (!ret) {
+		NL_SET_ERR_MSG(extack,
+			       "Can't read current voltage");
+		return ret;
+	}
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Error reading current voltage");
+		return ret;
+	}
+	uV = ret;
+
+	tmp_64 = pw_limit;
+	tmp_64 *= 1000000000ull;
+	/* uA = mW * 1000000000 / uV */
+	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
+
+	return regulator_set_current_limit(psec->ps, 0, uA);
+}
+EXPORT_SYMBOL_GPL(pse_ethtool_set_pw_limit);
+
 bool pse_has_podl(struct pse_control *psec)
 {
 	return psec->pcdev->types & ETHTOOL_PSE_PODL;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 38b9308e5e7a..e9a7f0e5e555 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -9,6 +9,9 @@
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
 
+/* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
+#define MAX_PI_CURRENT 1920000
+
 struct phy_device;
 struct pse_controller_dev;
 
@@ -41,6 +44,7 @@ struct pse_control_config {
  * @c33_actual_pw: power currently delivered by the PSE in mW
  *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
  * @c33_ext_state_info: extended state information of the PSE
+ * @c33_pw_limit: power limit of the PSE
  */
 struct pse_control_status {
 	enum ethtool_podl_pse_admin_state podl_admin_state;
@@ -50,6 +54,7 @@ struct pse_control_status {
 	u32 c33_pw_class;
 	u32 c33_actual_pw;
 	struct ethtool_c33_pse_ext_state_info c33_ext_state_info;
+	u32 c33_pw_limit;
 };
 
 /**
@@ -61,6 +66,12 @@ struct pse_control_status {
  *		   May also return negative errno.
  * @pi_enable: Configure the PSE PI as enabled.
  * @pi_disable: Configure the PSE PI as disabled.
+ * @pi_get_voltage: Return voltage similarly to get_voltage regulator
+ *		    callback.
+ * @pi_get_current_limit: Get the configured current limit similarly to
+ *			  get_current_limit regulator callback.
+ * @pi_set_current_limit: Configure the current limit similarly to
+ *			  set_current_limit regulator callback.
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -70,6 +81,11 @@ struct pse_controller_ops {
 	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_get_voltage)(struct pse_controller_dev *pcdev, int id);
+	int (*pi_get_current_limit)(struct pse_controller_dev *pcdev,
+				    int id);
+	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
+				    int id, int max_uA);
 };
 
 struct module;
@@ -156,6 +172,11 @@ int pse_ethtool_get_status(struct pse_control *psec,
 int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   const struct pse_control_config *config);
+int pse_ethtool_set_pw_limit(struct pse_control *psec,
+			     struct netlink_ext_ack *extack,
+			     const unsigned int pw_limit);
+int pse_ethtool_get_pw_limit(struct pse_control *psec,
+			     struct netlink_ext_ack *extack);
 
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
@@ -185,6 +206,19 @@ static inline int pse_ethtool_set_config(struct pse_control *psec,
 	return -EOPNOTSUPP;
 }
 
+static inline int pse_ethtool_set_pw_limit(struct pse_control *psec,
+					   struct netlink_ext_ack *extack,
+					   const unsigned int pw_limit)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pse_ethtool_get_pw_limit(struct pse_control *psec,
+					   struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool pse_has_podl(struct pse_control *psec)
 {
 	return false;

-- 
2.34.1


