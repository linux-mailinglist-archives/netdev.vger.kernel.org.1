Return-Path: <netdev+bounces-291737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC21AgG5FWrKYQcAu9opvQ
	(envelope-from <netdev+bounces-291737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:15:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC885D879A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 494FA306DEC2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336FF43E4A8;
	Tue, 26 May 2026 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IBgymD9j"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415E402BB0;
	Tue, 26 May 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807570; cv=none; b=T2hTA0JnJqUpLP58Upd0Im7+iyZua7iOXtqUOgoxTIZIrwxF2MpGoz293SmtBkyJzG305omhlB+5xjgh+kJ7e/dKFZ/b5YBdb9XZaPodz7gH/HYmzLE7gUv6oKP90XHituwvq4PmEFbQIDiYOk2j4+cTiafWB2t0gTWf/8yadm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807570; c=relaxed/simple;
	bh=qDIKeceRZQi8Kht1iTmljrU4lnSxyn0oEHL2dPnESio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/MP4Kv6tiP+fQxkWiMmjgBP+tgk08t+dW6KwvFBW+x7xlYPm6e8EzypJ3SpWIh8uGCNphYooCXaTpEOP+CgN0irlcsBhXXPACLcErFCNzTNEcGWe9n5d4XmNcrn07h0gq8ZY/XMTM1OhgY4BGAUjxwq/02EryFQguQ/HS/Ftos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IBgymD9j; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779807567;
	bh=qDIKeceRZQi8Kht1iTmljrU4lnSxyn0oEHL2dPnESio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IBgymD9jo/vveamU7KQIQ/SPp78mS7Js7yWQRSQUAKFwMKjek1sPLKWJ5LbPDp0Ya
	 6mQ5QkKCWBxQzj1G3v4wOd0AMy+qjeUPnHGBVyj/8q3+ch77h8jtYmhbxZzhEP8Yhi
	 OeDD01C1+JkhvtGrrY1Qdsr9HLmE7f4rF7sQ5FbsARd6VlAe9Tx6zp/rnAZMDvGsvy
	 8hriMyGzR1KiOhKkoF+I71euLBo3Q0hEZJGVeLWdypiUrLNaM+IfaNOnLPX39Hlhdr
	 RQQ2vZIOUe0onX6EB2DI9ucKcpJjvRNL2fdrNajgRcZDHuJjWV/q7W5fGhNVX+8Bjy
	 P41cLMzcV1cAA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 87E6417E0CF3;
	Tue, 26 May 2026 16:59:25 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 26 May 2026 16:58:11 +0200
Subject: [PATCH net-next v5 6/6] net: phy: air_an8801: ensure maximum
 available speed link use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-add-airoha-an8801-support-v5-6-01aea8dee69b@collabora.com>
References: <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
In-Reply-To: <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com, 
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779807555; l=2209;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=qDIKeceRZQi8Kht1iTmljrU4lnSxyn0oEHL2dPnESio=;
 b=6olIzN9aEMnfSw8gvWsFpzgsQ2QyrEQpwURR/hnSZZuk3wyNrHv4JqSvAxvw44N9mUNGAoBQy
 3sADk+71SEUBD7gsGYrXKlLSRNBW+437hj52O6IomH+0DItxEgJ792M
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291737-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6EC885D879A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To ensure that the Airoha AN8801R PHY uses the maximum available link
speed, an additional register write is needed to configure the function
mode for either 1G or 100M/10M operation after link detection.

So, in air_an8801 driver, implement a custom read_status callback, that
after genphy_read_status determines the link speed, sets the bit 0 of
the link mode register (REG_LINK_MODE) if the detected speed is 1Gbps,
or unsets it otherwise.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/net/phy/air_an8801.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/phy/air_an8801.c b/drivers/net/phy/air_an8801.c
index aa24bb182d64..f97c78e43023 100644
--- a/drivers/net/phy/air_an8801.c
+++ b/drivers/net/phy/air_an8801.c
@@ -996,6 +996,41 @@ static int an8801r_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int an8801r_read_status(struct phy_device *phydev)
+{
+	int prev_speed, ret;
+	u32 val;
+
+	prev_speed = phydev->speed;
+
+	ret = genphy_read_status(phydev);
+	if (ret)
+		return ret;
+
+	if (!phydev->link) {
+		phydev->speed = SPEED_UNKNOWN;
+		return 0;
+	}
+
+	if (prev_speed != phydev->speed) {
+		/* Ensure that PHY switches to 1G speed when available,
+		 * by configuring the function mode for either 1G or 100M/10M
+		 * operation.
+		 * Therefore, set the link mode register, after read_status
+		 * determines the link speed.
+		 */
+		val = phydev->speed == SPEED_1000 ?
+		      AN8801_BPBUS_LINK_MODE_1000 : 0;
+
+		return an8801_buckpbus_reg_rmw(phydev,
+					       AN8801_BPBUS_REG_LINK_MODE,
+					       AN8801_BPBUS_LINK_MODE_1000,
+					       val);
+	}
+
+	return 0;
+}
+
 static int an8801r_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -1093,6 +1128,7 @@ static struct phy_driver airoha_driver[] = {
 	.suspend		= an8801r_suspend,
 	.resume			= an8801r_resume,
 	.config_aneg		= genphy_config_aneg,
+	.read_status		= an8801r_read_status,
 	.config_intr		= an8801r_config_intr,
 	.handle_interrupt	= an8801r_handle_interrupt,
 	.set_wol		= an8801r_set_wol,

-- 
2.54.0


