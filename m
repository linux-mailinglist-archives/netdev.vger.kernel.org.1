Return-Path: <netdev+bounces-101706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD78FFD25
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA351C213C2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A759515538A;
	Fri,  7 Jun 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XunuChKw"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5515381B;
	Fri,  7 Jun 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745443; cv=none; b=JOz06CzPWBf0YiI8cRi6tZyoAyhcSyiJN69t85v1tx/QiFnVPbFvy6x1XPOom3coSCi4NxryCT63uGCPoiowDXWFjIq755KfD11S23a0yY4RHba6eOgvSgOuXoDCweT6KZHV4a59k2rm9yBowuLWDgrLBXgaE/hu12widCryBvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745443; c=relaxed/simple;
	bh=wKMjgK3GIPQQd20gtCcFQwHg9O/bjN2nXRgotur12wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQXJ7ITq77cC6jEfodVdt++0LGLEMamxNcQJ6FYzw/NR+DFGLigCABuieBKzjs/lWpNd1VT5NCk2VJ011YiWhi3g/+gYncV4FyICGRd1QhEoB190Od6DaBVcNXp1goontdYLvZJpT4DCENrYE598ALF9mHTCOud/SUcRQL+6mMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XunuChKw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E65E40010;
	Fri,  7 Jun 2024 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWgiv6Dw2J0CMsQahRN/WS1Vb3ESj1spouLrLT3OBb4=;
	b=XunuChKwkT8m7BgVIpHDvis4uLT4GlwcWSfBCX1XlW0ZRUjiJyXNGstqZ2Wl8C+VTfBjbQ
	jCTaz2xXOQx4ZH+Srq98s0t5xbeOw+sRzodKojMQQLlw98cy4ugrraWzrIC9yL1pDHxDqb
	hYlPANtOOY6ez0LGKmBDwcceXsbje1U/miBpzJtrVPSRjZ1BQU6vz5lESKMnmBGEBsLSqn
	hpZcZdayfMjW+26v0DxYHB4P+IpkOpf46iG7rpkvBYG7+/rz5Zwr2++/GZarqxeQ/Dbz39
	nFbEz/SXexrkXR+N+Lq/t2C4Tq4FYeRgH73Svhi+RsvxQzkfhk5SHi+VSjeRyw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 07 Jun 2024 09:30:21 +0200
Subject: [PATCH net-next v2 4/8] net: pse-pd: pd692x0: Expand ethtool
 status message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-feature_poe_power_cap-v2-4-c03c2deb83ab@bootlin.com>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
In-Reply-To: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
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

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

This update expands pd692x0_ethtool_get_status() callback with newly
introduced details such as the detected class, current power delivered,
and extended state information.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Move in from string status message to c33_pse_ext_state_info.
---
 drivers/net/pse-pd/pd692x0.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 6488b941703c..6b7367d009d6 100644
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
@@ -435,6 +442,75 @@ static int pd692x0_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 	}
 }
 
+struct pd692x0_pse_ext_state_mapping {
+	u32 status_code;
+	enum ethtool_c33_pse_ext_state pse_ext_state;
+	u8 pse_ext_substate;
+};
+
+static const struct pd692x0_pse_ext_state_mapping
+pd692x0_pse_ext_state_map[] = {
+	{0x06, ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_V_OVERVOLTAGE},
+	{0x07, ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_V_UNDERVOLTAGE},
+	{0x08, ETHTOOL_C33_PSE_EXT_STATE_HARDWARE_ISSUE, 0},
+	{0x0C, ETHTOOL_C33_PSE_EXT_STATE_CONFIG,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_CFG_UNDEFINED},
+	{0x11, ETHTOOL_C33_PSE_EXT_STATE_CONFIG,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_CFG_UNDEFINED},
+	{0x12, ETHTOOL_C33_PSE_EXT_STATE_HARDWARE_ISSUE, 0},
+	{0x1B, ETHTOOL_C33_PSE_EXT_STATE_DETECTION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_DET_IN_PROGRESS},
+	{0x1C, ETHTOOL_C33_PSE_EXT_STATE_DETECTION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_DET_FAILURE},
+	{0x1E, ETHTOOL_C33_PSE_EXT_STATE_CURRENT_ISSUE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_CRT_UNDERLOAD},
+	{0x1F, ETHTOOL_C33_PSE_EXT_STATE_CURRENT_ISSUE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_CRT_OVERLOAD},
+	{0x20, ETHTOOL_C33_PSE_EXT_STATE_POWER_BUDGET_EXCEEDED, 0},
+	{0x21, ETHTOOL_C33_PSE_EXT_STATE_HARDWARE_ISSUE, 0},
+	{0x22, ETHTOOL_C33_PSE_EXT_STATE_CONFIG,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_CFG_CHANGED},
+	{0x24, ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_V_INJECTION},
+	{0x25, ETHTOOL_C33_PSE_EXT_STATE_DETECTION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_DET_FAILURE},
+	{0x26, ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE, 0},
+	{0x34, ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_V_SHORT_DETECTED},
+	{0x35, ETHTOOL_C33_PSE_EXT_STATE_TEMP_ISSUE, 0},
+	{0x36, ETHTOOL_C33_PSE_EXT_STATE_TEMP_ISSUE, 0},
+	{0x37, ETHTOOL_C33_PSE_EXT_STATE_UNKNOWN, 0},
+	{0x3C, ETHTOOL_C33_PSE_EXT_STATE_POWER_BUDGET_EXCEEDED, 0},
+	{0x3D, ETHTOOL_C33_PSE_EXT_STATE_POWER_BUDGET_EXCEEDED, 0},
+	{0x41, ETHTOOL_C33_PSE_EXT_STATE_POWER_BUDGET_EXCEEDED, 0},
+	{0x43, ETHTOOL_C33_PSE_EXT_STATE_CLASSIFICATION_FAILURE, 0},
+	{0xA0, ETHTOOL_C33_PSE_EXT_STATE_HARDWARE_ISSUE, 0},
+	{0xA7, ETHTOOL_C33_PSE_EXT_STATE_DETECTION,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_DET_FAILURE},
+	{0xA8, ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
+		ETHTOOL_C33_PSE_EXT_SUBSTATE_V_OPEN},
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
+			c33_ext_state_info->__c33_pse_ext_substate = ext_state_map->pse_ext_state;
+			return;
+		}
+		ext_state_map++;
+	}
+}
+
 static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 				      unsigned long id,
 				      struct netlink_ext_ack *extack,
@@ -442,6 +518,7 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_msg msg, buf = {0};
+	u32 class;
 	int ret;
 
 	ret = pd692x0_fw_unavailable(priv);
@@ -471,6 +548,21 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 
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


