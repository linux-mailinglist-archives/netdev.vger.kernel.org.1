Return-Path: <netdev+bounces-99054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E088D38C6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43501C2030D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C2C1E890;
	Wed, 29 May 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DkRlJjnV"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5FC1CD0C;
	Wed, 29 May 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991781; cv=none; b=bD9Pyk8Max9HjPrVCeHTgJNKTaLmaMoVITKQogISo0rh6MO6E3OIRDGGlXqXXbTA7Bu2Vcrpdx25HqolcIzPHWvmG3W2REil5TzfBaBYXPHrVav7/9BwZ7gqT5gerYfzvc4ApIhRg0TpN37hjK1PU5ZQYDf9s7rlr69fFx/WBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991781; c=relaxed/simple;
	bh=+Hf1nunZ4FXWiATNo1UOBxXtdIk0xjt6aEwheQxGSlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/ibCgWhDrKb3RH8aI88VmT/zY4piUZODuCNmPAEI6SA9vLQCjE+UpPIMze2ol74zhyzuczj3qKG9FqDQrtmWuC/gWN2C0udhjxtmjKbrV6wTp4oqFoPJaE0KIVxExZlqB6Ow9YNqTtexb3hGO10bIoPfMXA0taU7INat8tGplg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DkRlJjnV; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93CC140005;
	Wed, 29 May 2024 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbiDNqiPauaD/1z/h6ohPFLO5GmM0lX9SctZdlgqRs8=;
	b=DkRlJjnVsHuESEZCbicVgpFOqLHrX8J7jGRIryc0hJ+/OIHxVgMhzh2+72z6oxHrY+W13m
	oaaxMhxlpuHXPy29z36aa28hHt0n+nGpQZEw6bhyolOUXvvyv2afve1re5GGpw3jSBcuPQ
	VimGT0/JtQdjMwq/zRc34RH8Xccq0smNSNUZVEV9tC9QZyLfUKYFtRA7VPY6oC/Cusl4dc
	4qKJqNSrRIPV/8eIrbad9jihiKrUkut4PSMQ5fOpDQW6XVVkEI1t44VtG7lBvKMcLXg/8G
	UR8HJp/RStBBGQ/7B9T3XjJUfaJyqK5qamUJ3KvfjBTZqF3GCugEuWkk10ebkw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 16:09:31 +0200
Subject: [PATCH 4/8] net: pse-pd: pd692x0: Expand ethtool status message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240529-feature_poe_power_cap-v1-4-0c4b1d5953b8@bootlin.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
In-Reply-To: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
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
and a detailed status message.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 96 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 6488b941703c..017a8efc43c4 100644
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
@@ -435,6 +442,79 @@ static int pd692x0_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 	}
 }
 
+struct pd692x0_status_msg {
+	int id;
+	const char msg[63];
+};
+
+static const struct pd692x0_status_msg pd692x0_status_msg_list[] = {
+	{.id = 0x06, .msg = "Port is off: Main supply voltage is high."},
+	{.id = 0x07, .msg = "Port is off: Main supply voltage is low."},
+	{.id = 0x08, .msg = "Port is off: Disable all ports pin is active."},
+	{.id = 0x0C, .msg = "Port is off: Non-existing port number."},
+	{.id = 0x11, .msg = "Port is yet undefined."},
+	{.id = 0x12, .msg = "Port is off: Internal hardware fault."},
+	{.id = 0x1A, .msg = "Port is off: User setting."},
+	{.id = 0x1B, .msg = "Port is off: Detection is in process."},
+	{.id = 0x1C, .msg = "Port is off: Non-802.3AF/AT powered device."},
+	{.id = 0x1E, .msg = "Port is off: Underload state."},
+	{.id = 0x1F, .msg = "Port is off: Overload state."},
+	{.id = 0x20, .msg = "Port is off: Power budget exceeded."},
+	{.id = 0x21, .msg = "Port is off: Internal hardware routing error."},
+	{.id = 0x22, .msg = "Port is off: Configuration change."},
+	{.id = 0x24, .msg = "Port is off: Voltage injection into the port."},
+	{.id = 0x25, .msg = "Port is off: Improper Capacitor Detection"},
+	{.id = 0x26, .msg = "Port is off: Discharged load."},
+	{.id = 0x34, .msg = "Port is off: Short condition."},
+	{.id = 0x35, .msg = "Port is off: Over temperature at the port."},
+	{.id = 0x36, .msg = "Port is off: Device is too hot."},
+	{.id = 0x37, .msg = "Unknown device port status."},
+	{.id = 0x3C, .msg = "Power Management-Static."},
+	{.id = 0x3D, .msg = "Power Management-Static\u2014OVL."},
+	{.id = 0x41, .msg = "Power denied: Hardware power limit."},
+	{.id = 0x43, .msg = "Port is off: Class error."},
+	{.id = 0x44, .msg = "Port turn off during Host crash."},
+	{.id = 0x45, .msg = "Delivered power port was forced to be shut down at host crash."},
+	{.id = 0x46, .msg = "An enabled port was forced to be shut down at Host crash."},
+	{.id = 0x47, .msg = "Force Power Crash Error."},
+	{.id = 0x48, .msg = "Port is off: Recovery UDL."},
+	{.id = 0x49, .msg = "Port is off: Recovery PG Event."},
+	{.id = 0x4A, .msg = "Port is off: Recovery OVL."},
+	{.id = 0x4B, .msg = "Port is off: Recovery SC."},
+	{.id = 0x4C, .msg = "Port is off: Recovery Voltage injection."},
+	{.id = 0x80, .msg = "2P Port delivering non-IEEE."},
+	{.id = 0x81, .msg = "2P Port delivering IEEE."},
+	{.id = 0x82, .msg = "4P Port that deliver only 2 Pair non-IEEE."},
+	{.id = 0x83, .msg = "4P Port delivering 2P non-IEEE."},
+	{.id = 0x84, .msg = "4P Port delivering 4P non-IEEE."},
+	{.id = 0x85, .msg = "4P Port delivering 2P IEEE SSPD."},
+	{.id = 0x86, .msg = "4P Port delivering 4P IEEE SSPD."},
+	{.id = 0x87, .msg = "4P Port delivering 2P IEEE DSPD in the first phase."},
+	{.id = 0x88, .msg = "4P Port delivering 2P IEEE DSPD."},
+	{.id = 0x89, .msg = "4P Port delivering 4P IEEE DSPD."},
+	{.id = 0x90, .msg = "Force Power BT 2P."},
+	{.id = 0x91, .msg = "Force Power BT 4P."},
+	{.id = 0xA0, .msg = "Force Power BT error."},
+	{.id = 0xA7, .msg = "Connection Check error."},
+	{.id = 0xA8, .msg = "Open Port is not connected."},
+	{ /* sentinel */ }
+};
+
+static const char *pd692x0_get_status_msg(int id)
+{
+	const struct pd692x0_status_msg *msg_list;
+
+	msg_list = pd692x0_status_msg_list;
+	while (msg_list->id) {
+		if (msg_list->id == id)
+			return msg_list->msg;
+
+		msg_list++;
+	}
+
+	return NULL;
+}
+
 static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 				      unsigned long id,
 				      struct netlink_ext_ack *extack,
@@ -442,6 +522,7 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_msg msg, buf = {0};
+	u32 class;
 	int ret;
 
 	ret = pd692x0_fw_unavailable(priv);
@@ -471,6 +552,21 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 
 	priv->admin_state[id] = status->c33_admin_state;
 
+	status->c33_pw_status_msg = pd692x0_get_status_msg(buf.sub[0]);
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


