Return-Path: <netdev+bounces-106465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC89167F8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389081C24F28
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069E15ECE5;
	Tue, 25 Jun 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KkC42miA"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A45156238;
	Tue, 25 Jun 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318845; cv=none; b=ZUdlpJv5mKh5Ocs/ua/qIdOW2F8hbW4NQjFY9Mj04kipai4fuvy3ZbFxdZEkSOFp+bbCHOxd/PBu8n6oQ0VJp+8xGNJpZcQjYXUr0w1Olm5aoWIhfo6aq9D+YiGgQzmn/820Uy6F6J1oVPFdr7GZACDBR80mNE3SPej33nR0TzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318845; c=relaxed/simple;
	bh=/Lt6C8vu86KqGJrtl0gKXOGcx2FOBA84LMVyH4i3mbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xv8y9H8zvY3rYyvCx7v9yYS4jIC1eLWVbbv43lriFZ8BMBezq3A9bvHpywe/PRDv7g5XDiZ0Y0i1yelboIlrrHkFWAI1BgA9zWvvhMi9GTLfxko7NuqmX+O6EweAllalAL5iX8RRjf7ckBHkE0YMrkbbECS74e/Juzq8NkOscqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KkC42miA; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9927B60009;
	Tue, 25 Jun 2024 12:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719318841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80UZb58ynKN35M0tcD8tt4o9DnYxvRgsgP7Esy9mB6c=;
	b=KkC42miAenJOc+9FwsYqFQsPWR/h89qRP6xhNw3oY+tweb3f5oF8dbsZdrY4qc1GMAOGRI
	cHJ752ziadXhOShhI1vD53bhZNJh51W54y8/tbMo4MtIQI5MDyuDbdgkJiBGBK6w3cF2eM
	j50bFa4DLnhF72Q2+fmvStrBsf/JN2Zb31x2ASDV6M2TPpbUvHMHA37zceLauQxUm9WAZd
	HjDWngLINaMZvPwTvgcL4LmhrLb/6oR9NOmDMRssT63MKhqN7SCoi56Qv/S1MuUdNYZPqx
	6TeL1pDN/VqMCwXPzS2UnyLXm9e7uQYT3rG9M36NYYcFnpsWB54FpjcfEzZ4uA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 25 Jun 2024 14:33:48 +0200
Subject: [PATCH net-next v4 3/7] net: pse-pd: pd692x0: Expand ethtool
 status message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-feature_poe_power_cap-v4-3-b0813aad57d5@bootlin.com>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
In-Reply-To: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
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
index 6488b941703c..021b22d4b931 100644
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


