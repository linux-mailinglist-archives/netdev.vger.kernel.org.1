Return-Path: <netdev+bounces-103633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85890908D7D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BA51F21364
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A41CF96;
	Fri, 14 Jun 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PiqZ0P7s"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4710A0D;
	Fri, 14 Jun 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375612; cv=none; b=C63Dpb5BN6O2CYVExfGCx/M+I6ECsazGAB2MfthK99G2xsVW7H4/4d+bYVxRP9UoDj7wV3nRclWp9XEXBRv+8KXDEtGF1RPtQpiyarpPXu234FAAPSOZru5lh4zHiJUA01nawy/zJkc6Sn80TNfHc/nWYdNSZz7Lwj3zQPvs2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375612; c=relaxed/simple;
	bh=23GwKg0+5umU4RoFBp8O7pZwdZduZK7ZYjtL+h1jdyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DBTx8CqTU8eQeNUgIebM6IFVQy3bBsUotYnjHec4Kjc3Jbwif45qu9LNjNE8Bhdv0SROzHXemp2w7FPh98rYMCIsLJp4q+kd/UPTBQfNPbtLQUUWB+sqyCp6P6Glilr0TybciDj57O0qMW6QQkFXY3gAeOrfo/1g522pa7Rc4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PiqZ0P7s; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69F701C000E;
	Fri, 14 Jun 2024 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718375603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA7FsAPDThZxU5mba5x/jLCcICtqP5tL7OiSUYKglHc=;
	b=PiqZ0P7sgKJUOmrWXdqUzHQTwVvsh8n4PRNF6r19Esee/x3+0Qn+W1+eeXEp0h3IdlBd6a
	OAGyU2o10h7/TALRodSR0L9coUE0/fXx8C6NKWCSLMsITTue8ubZIMI/TdKyKaveRVS78v
	RJmJnr5S0rowW9xumCF+g6Jq1NIuTmu/O+1bXuB5Ri4/+KegTLB9uDYg4RCqFe2X9J31Zg
	C0LAcAqivE3bA+6wG1am18Qmdwflg7e5wmCK5iMtpHUiJbTBsQPjzhdQ5xf/5pSuMcPE6k
	TZDiNbrxzixV4yqVkXd5IIzyV2YFMTad72DMBXpbhPfdAzbvxeDcD0Xw/AjSNg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 14 Jun 2024 16:33:19 +0200
Subject: [PATCH net-next v3 3/7] net: pse-pd: pd692x0: Expand ethtool
 status message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-feature_poe_power_cap-v3-3-a26784e78311@bootlin.com>
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

This update expands pd692x0_ethtool_get_status() callback with newly
introduced details such as the detected class, current power delivered,
and extended state information.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Move in from string status message to c33_pse_ext_state_info.

Change in v3:
- Update extended state and substate list.
---
 drivers/net/pse-pd/pd692x0.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 6488b941703c..c5e0456e7103 100644
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
+	{0x1C, ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_PD_DLL_POWER_TYPE_NON_802_3AF_AT_DEVICE},
+	{0x1E, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_UNDERLOAD},
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
+	{0x25, ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_IMPROPER_CAP_DET},
+	{0x34, ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION},
+	{0x35, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP},
+	{0x36, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP},
+	{0x37, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS},
+	{0x3C, ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC},
+	{0x3D, ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC_OVL},
+	{0x41, ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT},
+	{0x43, ETHTOOL_C33_PSE_EXT_STATE_CLASS_NUM_EVENTS,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_CLASS_NUM_EVENTS_CLASS_ERROR},
+	{0xA7, ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR},
+	{0xA8, ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONNECTION_OPEN},
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


