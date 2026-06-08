Return-Path: <netdev+bounces-296597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i6WPCJTPJmq8kwIAu9opvQ
	(envelope-from <netdev+bounces-296597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:20:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD3657154
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:20:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=xUY0A3IJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296597-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296597-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 407CB31034D3
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D63D3D14;
	Mon,  8 Jun 2026 14:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA23D34AC;
	Mon,  8 Jun 2026 14:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927832; cv=none; b=lr+SaIWKkPEAgzROV2jLIAO2kfjv0pmGQo55z7hsBwdfhAO342vmZHIoMgdE6t9XUxu48k0wl4hC1fwNdvSME1fdb9cgjuK93RUrtD8lw1AzC8E0FzGk3/q5E3D1OF5LS+l2jUAQRXo3KF3Ox4VYp/MbM62cJESThTrq6s+low4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927832; c=relaxed/simple;
	bh=FpoDWnbu1u3/8UQ4JnzO52SSHsP/c0PaK/Z34Md/cH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJ3I54Yg33ulqU0VSN3sm39jvtGBvHA+WUUvBLHy2f43J7UqoHG3VMK9yqDB87bAYyN9H7UxePVgsjttxLpmCJ+frUqqJRMGf67TkaBWy92NTvxB9mW1vDP5qSmv/IfFZ5e8SXMrLz6GCGBhDWaNU6F8ExRh9qNGecu7MUBdXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xUY0A3IJ; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EE09D1A37CC;
	Mon,  8 Jun 2026 14:10:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9E5C5FFB7;
	Mon,  8 Jun 2026 14:10:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84C25106A295D;
	Mon,  8 Jun 2026 16:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=a9yPHpnzM5zpypG6P5ITVYfiVmedFm7ephXnJAxPee4=;
	b=xUY0A3IJklXW4OuJniETmyk0vQoiR4ZtcXkGMAO4cdEYrprY/Jm9VRNXC0VcpCTSycuJSw
	Yryl/VWfVtavRP3MD9NfK95UQBj9AUvHtgD5wbS3hjn0Mo/iHEng3qVf92kk0uuc87pDw+
	zhPFxJvg0wdguiVtS3tzS8SGoKnoJMRMLMl6b4YgUe7YCPRQKG9jYbBPUKRhGGjNlsfntY
	pc3uL64/oi9BD2SG4aMfRneB1g+S0lEdacwSNxiBkZFtdsaiNXxa9o4bugTHj3tEEYi+Xj
	Ax/v15OzozVKhn1eIHwAgCMKUkDzCSbALjxJek7r8r6PCG6KniGRV5aj+Zgpdw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:10 +0200
Subject: [PATCH net-next v2 07/10] net: dsa: microchip: implement
 .{get/set}_wol only if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-7-6e61b7be23c4@bootlin.com>
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
In-Reply-To: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296597-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89BD3657154

All the KSZ switches use common {get/set}_wol operations while only the
ksz9477 and the ksz87xx families really support it. These operations are
optional so there is no point implementing them to return -EOPNOTSUPP.

Remove the {get/set}_wol callbacks from the switch operations for the
ksz88xx, the ksz8463 and the lan937x families.
Remove the family check from the common {get/set}_wol implementation.

Note that is_ksz9477() is only true for the KSZ9477 so this change will
also add WoL support for the other switches using the
ksz9477_switch_ops. I checked their datasheet, they implement the same
PME_WOL registers, at the same addresses, so this should go fine.
Modify the ksz_wol_pre_shutdown() initial check to ensure consistency in
the WoL handling for these non-KSZ9477 switches using ksz9477_switch_ops.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  4 ----
 drivers/net/dsa/microchip/ksz_common.c   | 12 ++++--------
 drivers/net/dsa/microchip/lan937x_main.c |  2 --
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 7b4b46db1ef6..690e1b275992 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2467,8 +2467,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz8_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
-	.get_wol		= ksz_get_wol,
-	.set_wol		= ksz_set_wol,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,
@@ -2578,8 +2576,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz8_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
-	.get_wol		= ksz_get_wol,
-	.set_wol		= ksz_set_wol,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index bebf697ec60a..809a0bc3c01e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3756,9 +3756,6 @@ void ksz_get_wol(struct dsa_switch *ds, int port,
 	u8 pme_ctrl;
 	int ret;
 
-	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
-		return;
-
 	if (!dev->wakeup_source)
 		return;
 
@@ -3809,9 +3806,6 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
 	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
 
-	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
-		return -EOPNOTSUPP;
-
 	if (!dev->wakeup_source)
 		return -EOPNOTSUPP;
 
@@ -3871,12 +3865,13 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev)
 {
 	const struct ksz_dev_ops *ops = dev->dev_ops;
 	const u16 *regs = dev->info->regs;
+	struct dsa_switch *ds = dev->ds;
 	u8 pme_pin_en = PME_ENABLE;
 	bool wol_enabled = false;
 	struct dsa_port *dp;
 	int ret;
 
-	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
+	if (!ds->ops->set_wol)
 		return;
 
 	if (!dev->wakeup_source)
@@ -3924,7 +3919,8 @@ int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 	 */
 	wol.wolopts = 0;
 
-	ksz_get_wol(ds, dp->index, &wol);
+	if (ds->ops->get_wol)
+		ds->ops->get_wol(ds, dp->index, &wol);
 	if (wol.wolopts & WAKE_MAGIC) {
 		dev_err(ds->dev,
 			"Cannot change MAC address on port %d with active Wake on Magic Packet\n",
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index e1aba93d1438..6b1306e81558 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -893,8 +893,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= lan937x_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
-	.get_wol		= ksz_get_wol,
-	.set_wol		= ksz_set_wol,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,

-- 
2.54.0


