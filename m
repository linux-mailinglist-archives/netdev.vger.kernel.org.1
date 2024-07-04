Return-Path: <netdev+bounces-109133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00524927153
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E4BB22A03
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238271A4F30;
	Thu,  4 Jul 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LrkQrm8n"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF61A3BAD;
	Thu,  4 Jul 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080747; cv=none; b=XJmhnUxgNpB7DtLl1PWdXbl/+hN/6865WP2JS6R1FQn+lO/SN3/Cf6zlYf0fIhkZbnldpEBLBaIg7yJQqEEzegEpLWTBd6P6Gew2HLdIMc9o7c+X+6cYJeSD7S3ijiwRX3/4cprVA+XrIqoCjzSepGoaeORODuZIcxmySpJ2K/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080747; c=relaxed/simple;
	bh=j1+RsKQPkOGafBw1lDnm7pl0zclWWvoXviWcgAIFrS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7VWN4/bIWgfXmnvAmkhWMUXXt2RUpnG2yebvNEidBQ50AG/7PWHgiUtsvA10wCX+3jTRZU8H0bhl3YGKglLgZIjsX7aML9e2SSnRjeT3g223C1+wNhtagqdVdjkuYfalL9wS1aTTfjfzlcx2CHeQZt77wIetYNskNkI4KaxMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LrkQrm8n; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 731701BF20F;
	Thu,  4 Jul 2024 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720080737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9DceUTgs30TqVEdXDY2XmgTA0kfohNvKVzdXG6JqGk=;
	b=LrkQrm8nZaOFcUPix2rc2PCMwkyq2/DOI5EIUXyHPTrRHU9Z6R8s323450/Ys1HcthduQu
	71qWxFlYLOf3ZfOfbJYBB+MFpVWqhU83GPUd5wPMyFA6/1q9vQqVBtDdmqVTtrtXInc7V1
	mTCaIE+QB50pDFdjdL5NDoY2rUk+00KNliZzkfoo2vENYTZoLVSLZlW5Qi4noSYxkoLhzY
	KAywlBPzCyOSHC/i7ZMrRJDSbS9Jg4nxewZzT36xLoIk/eRHKMH4mlzGCHdt1HSOghYN/K
	iIzv4hjLRFSJY4WIWXe4MgbwV6cfjf6wUrqnxCI14Lcq2efVdyB4F+tyIY7rCg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 04 Jul 2024 10:11:58 +0200
Subject: [PATCH net-next v6 3/7] net: pse-pd: pd692x0: Expand ethtool
 status message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-feature_poe_power_cap-v6-3-320003204264@bootlin.com>
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
In-Reply-To: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This update expands pd692x0_ethtool_get_status() callback with newly
introduced details such as the detected class, current power delivered,
and extended state information.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Move in from string status message to c33_pse_ext_state_info.

Change in v3:
- Update extended state and substate list.

Change in v4:
- Update extended state and substate list.
---
 drivers/net/pse-pd/pd692x0.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 820358b71f0f..cce1b7ce044b 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -73,6 +73,7 @@ enum {
 	PD692X0_MSG_SET_PORT_PARAM,
 	PD692X0_MSG_GET_PORT_STATUS,
 	PD692X0_MSG_DOWNLOAD_CMD,
+	PD692X0_MSG_GET_PORT_CLASS,
 
 	/* add new message above here */
 	PD692X0_MSG_CNT
@@ -149,6 +150,12 @@ static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
 		.data = {0x16, 0x16, 0x99, 0x4e,
 			 0x4e, 0x4e, 0x4e, 0x4e},
 	},
+	[PD692X0_MSG_GET_PORT_CLASS] = {
+		.key = PD692X0_KEY_REQ,
+		.sub = {0x05, 0xc4},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
 };
 
 static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
@@ -435,6 +442,84 @@ static int pd692x0_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 	}
 }
 
+struct pd692x0_pse_ext_state_mapping {
+	u32 status_code;
+	enum ethtool_c33_pse_ext_state pse_ext_state;
+	u32 pse_ext_substate;
+};
+
+static const struct pd692x0_pse_ext_state_mapping
+pd692x0_pse_ext_state_map[] = {
+	{0x06, ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE},
+	{0x07, ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE},
+	{0x08, ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE},
+	{0x0C, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT},
+	{0x11, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT},
+	{0x12, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT},
+	{0x1B, ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS},
+	{0x1C, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS},
+	{0x1E, ETHTOOL_C33_PSE_EXT_STATE_MR_MPS_VALID,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_DETECTED_UNDERLOAD},
+	{0x1F, ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD},
+	{0x20, ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED},
+	{0x21, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT},
+	{0x22, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE},
+	{0x24, ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_VOLTAGE_INJECTION},
+	{0x25, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS},
+	{0x34, ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION},
+	{0x35, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP},
+	{0x36, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP},
+	{0x37, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS},
+	{0x3C, ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PORT_PW_LIMIT_EXCEEDS_CONTROLLER_BUDGET},
+	{0x3D, ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PD_REQUEST_EXCEEDS_PORT_LIMIT},
+	{0x41, ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT},
+	{0x43, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS},
+	{0xA7, ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR},
+	{0xA8, ETHTOOL_C33_PSE_EXT_STATE_MR_MPS_VALID,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_CONNECTION_OPEN},
+	{ /* sentinel */ }
+};
+
+static void
+pd692x0_get_ext_state(struct ethtool_c33_pse_ext_state_info *c33_ext_state_info,
+		      u32 status_code)
+{
+	const struct pd692x0_pse_ext_state_mapping *ext_state_map;
+
+	ext_state_map = pd692x0_pse_ext_state_map;
+	while (ext_state_map->status_code) {
+		if (ext_state_map->status_code == status_code) {
+			c33_ext_state_info->c33_pse_ext_state = ext_state_map->pse_ext_state;
+			c33_ext_state_info->__c33_pse_ext_substate = ext_state_map->pse_ext_substate;
+			return;
+		}
+		ext_state_map++;
+	}
+}
+
 static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 				      unsigned long id,
 				      struct netlink_ext_ack *extack,
@@ -442,6 +527,7 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_msg msg, buf = {0};
+	u32 class;
 	int ret;
 
 	ret = pd692x0_fw_unavailable(priv);
@@ -471,6 +557,21 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 
 	priv->admin_state[id] = status->c33_admin_state;
 
+	pd692x0_get_ext_state(&status->c33_ext_state_info, buf.sub[0]);
+
+	status->c33_actual_pw = (buf.data[0] << 4 | buf.data[1]) * 100;
+
+	memset(&buf, 0, sizeof(buf));
+	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_CLASS];
+	msg.sub[2] = id;
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret < 0)
+		return ret;
+
+	class = buf.data[3] >> 4;
+	if (class <= 8)
+		status->c33_pw_class = class;
+
 	return 0;
 }
 

-- 
2.34.1


