Return-Path: <netdev+bounces-291625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DTAFZttFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:53:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6AE5D3BA9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2131F3053CA5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBDD3DCDA9;
	Tue, 26 May 2026 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dwr73jFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503083D88F1
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788873; cv=none; b=uVXURBpOJv4vGYumBMfZGN1ZFv0CYxd2wGrivNP7am/glNGIpstm8FZ2M2yf6V+AmyQWC5Mbrh20XqRxcWxtyLHUYBz72MvUKTQnW/cZOm2Lo0wTpJrU/9Ef6b6rzHlaxI2ihIBAjy0GUGYbG21bxqa3Cpabxvh682JgqzSSnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788873; c=relaxed/simple;
	bh=fEHEwXEoUDYte5vxo2ruOxaYtP9IzusrpbVVL0dP9qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FiOc0Zg9LQKyDggOQhE0gysHHECo9nYAV+VBmTWaycKZM2itS/DRGGDZj5wzFK8eaMsG3pwMucbABvj6UpTZTD8jnNr4+0VJCHiZ5ZBirYwqDPP+Dbn0eQeXA8mEVLsYqP6JWXcQxVe7wDAdh5hX+2FlNPPMlEGUKQZk5QvUWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dwr73jFb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8DCD04E42D56;
	Tue, 26 May 2026 09:47:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61CB160732;
	Tue, 26 May 2026 09:47:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADE3A10888582;
	Tue, 26 May 2026 11:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788863; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BBtWvn1cViKIlEYxRrtV8pMaWvcQuKsWUQfn4agDogc=;
	b=Dwr73jFbqIIbWCJirU3xBBR/tlxxm34ROraVcEsYebGe/j8Z4U3yUas78iog0zme/Qvgcp
	NN5P1BL8oQrZzqFNvHvuVCJ9pfqT1kvLWxjx/BHbpci9RkaXWaAqBd471rF0nUDBdJaR2M
	BY2GFov5nBzWe/qg6uUJRzOjINBggOkcjTn+QoYi04g6S5WZrayHGFeEIrRdftmGaa8+Qa
	J3FKq5MyULtRiCqbDiT5NgxvzNqBoGiKvAW7iukBfrMvfx5zdv7FjV3PpK7a/j1Ycq/hiE
	ExkhzDjBglZKxxaB4ShDv1T1QRZa+NbbcOvc6lP6LrjMzLp6kznD0sOP0cqRQQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:28 +0200
Subject: [PATCH net-next 2/9] net: dsa: microchip: remove VLAN operations
 for ksz8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-clean-ksz-3rd-v1-2-5b63e732149a@bootlin.com>
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
In-Reply-To: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
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
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291625-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 7D6AE5D3BA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vladimir Oltean <vladimir.oltean@nxp.com>

KSZ8463 uses the common KSZ8 implementation for its VLAN operations.
This implementation returns -ENOTSUPP for the KSZ8463 case, which is
pointless.

Remove the VLAN operations from the ksz8463_switch_ops so the core can
directly return -ENOTSUPP.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index db08874eb025..93e0b3f60448 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1477,7 +1477,7 @@ static int ksz8_port_vlan_filtering(struct dsa_switch *ds, int port, bool flag,
 {
 	struct ksz_device *dev = ds->priv;
 
-	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
+	if (ksz_is_ksz88x3(dev))
 		return -ENOTSUPP;
 
 	/* Discard packets with VID not enabled on the switch */
@@ -1514,7 +1514,7 @@ static int ksz8_port_vlan_add(struct dsa_switch *ds, int port,
 	u16 data, new_pvid = 0;
 	u8 fid, member, valid;
 
-	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
+	if (ksz_is_ksz88x3(dev))
 		return -ENOTSUPP;
 
 	/* If a VLAN is added with untagged flag different from the
@@ -1584,7 +1584,7 @@ static int ksz8_port_vlan_del(struct dsa_switch *ds, int port,
 	u8 fid, member, valid;
 	u16 data, pvid;
 
-	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
+	if (ksz_is_ksz88x3(dev))
 		return -ENOTSUPP;
 
 	ksz_pread16(dev, port, REG_PORT_CTRL_VID, &pvid);
@@ -2439,9 +2439,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
-	.port_vlan_filtering	= ksz8_port_vlan_filtering,
-	.port_vlan_add		= ksz8_port_vlan_add,
-	.port_vlan_del		= ksz8_port_vlan_del,
 	.port_fdb_dump		= ksz8_fdb_dump,
 	.port_fdb_add		= ksz8_fdb_add,
 	.port_fdb_del		= ksz8_fdb_del,

-- 
2.54.0


