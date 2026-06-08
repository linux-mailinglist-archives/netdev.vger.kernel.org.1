Return-Path: <netdev+bounces-296591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79skNi3PJmqqkwIAu9opvQ
	(envelope-from <netdev+bounces-296591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:18:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE35657118
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:18:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=qp0Jhmts;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296591-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296591-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F4071300601F
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56BA3C457F;
	Mon,  8 Jun 2026 14:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7703BE647
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 14:10:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927822; cv=none; b=Yl53b9jP96zHFM/Nrzrvk7SYvHEnncFSX3GzihT7k0h35YrdYgys2Tos/pZjqUPmHjAbrPVOOSAr8qgmT5gX3cN73hJANu3TWvv99XW8LCM8m7MN3B5+HXJ0ppwPqQ0kxBj6FdQVkei42oY0qd5TBWO7mcfrccG9nbOsmZrutNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927822; c=relaxed/simple;
	bh=vet+8LUw9CMHJCl4uCcWV2+acL0io+HppB8DCWwMYSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FI0M2ZMwSdBRWaq/rwU3BxWpenHJqa0LonHpwDkp13gCk9oFzZeruliY1qcrEPyLiLvW3yt/eEsKOack74mE1/HTKVDzmEzH2y0ixahQeOTbwvy0vI2Hkm28aLrIbQhRHK9ajHvQX2fpc/a932Uhce14s01iROaZZf5ULmlP+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qp0Jhmts; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B6E561A37CC;
	Mon,  8 Jun 2026 14:10:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 806655FFB7;
	Mon,  8 Jun 2026 14:10:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FB21106A2962;
	Mon,  8 Jun 2026 16:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927818; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/K9/ZTUYEm7hgptnRygC7Z1Qmu1Q/ZK2rVMEioKNYGM=;
	b=qp0JhmtsIvbHNg8wE3LXDQfI/hPR3geiFnQ4PcoBWyi8SRmweYS8dBzzW5QuLGUUaU6Wcw
	npM5csoi80MytOJBGlaHUYO9QENvLdUr32RY9HRFfFlhqpYRSEcJavUsEy1tjCRW7e+GCr
	vojg3Vp8w3gs5mHyTSSkJ48iQkdaq6S6qMWEiu8oavD82mkNnNUgjUL0KzXhMX7AVZPD8A
	Fhgnu/v/oc+2iuyKLU1NJWtPtqHrRZT/fgFMVCb/f4OKz931KEO1Tyu4AyPbU4fV2TGKIN
	d+PsdvS8LprSWL0wpCNE7M9kD3i/VBdsp/U4yUDkwvbGkj99FhDoLyUGhanMYA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:04 +0200
Subject: [PATCH net-next v2 01/10] net: dsa: microchip: remove useless
 common cls_flower_{add/del} operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-1-6e61b7be23c4@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-296591-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAE35657118

All the KSZ switches share a common implementation of the
cls_flower_{add/del} operations. These common implementations return
ksz9477-specific implementations for the KSZ9477 family and -EOPNOTSUPP
for the others. -EOPNOTSUPP is already returned by the DSA core when
the operation isn't implemented.

Remove the common implementations.
Directly link the ksz9477_cls_flower_{add/del}() to the KSZ9477 callback.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  6 -----
 drivers/net/dsa/microchip/ksz9477.c      |  4 +--
 drivers/net/dsa/microchip/ksz_common.c   | 42 --------------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  4 ---
 drivers/net/dsa/microchip/lan937x_main.c |  2 --
 5 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 0f84b2e7d25d..db08874eb025 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2462,8 +2462,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
-	.cls_flower_add		= ksz_cls_flower_add,
-	.cls_flower_del		= ksz_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
 	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
@@ -2522,8 +2520,6 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
-	.cls_flower_add		= ksz_cls_flower_add,
-	.cls_flower_del		= ksz_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
 	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
@@ -2582,8 +2578,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
-	.cls_flower_add		= ksz_cls_flower_add,
-	.cls_flower_del		= ksz_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
 	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index c1395322e54b..c18bad08a508 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1996,8 +1996,8 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
-	.cls_flower_add		= ksz_cls_flower_add,
-	.cls_flower_del		= ksz_cls_flower_del,
+	.cls_flower_add		= ksz9477_cls_flower_add,
+	.cls_flower_del		= ksz9477_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
 	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 57c8abfe0147..81d3ec88e436 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3373,48 +3373,6 @@ static int ksz_switch_detect(struct ksz_device *dev)
 	return 0;
 }
 
-int ksz_cls_flower_add(struct dsa_switch *ds, int port,
-		       struct flow_cls_offload *cls, bool ingress)
-{
-	struct ksz_device *dev = ds->priv;
-
-	switch (dev->chip_id) {
-	case KSZ8563_CHIP_ID:
-	case KSZ8567_CHIP_ID:
-	case KSZ9477_CHIP_ID:
-	case KSZ9563_CHIP_ID:
-	case KSZ9567_CHIP_ID:
-	case KSZ9893_CHIP_ID:
-	case KSZ9896_CHIP_ID:
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		return ksz9477_cls_flower_add(ds, port, cls, ingress);
-	}
-
-	return -EOPNOTSUPP;
-}
-
-int ksz_cls_flower_del(struct dsa_switch *ds, int port,
-		       struct flow_cls_offload *cls, bool ingress)
-{
-	struct ksz_device *dev = ds->priv;
-
-	switch (dev->chip_id) {
-	case KSZ8563_CHIP_ID:
-	case KSZ8567_CHIP_ID:
-	case KSZ9477_CHIP_ID:
-	case KSZ9563_CHIP_ID:
-	case KSZ9567_CHIP_ID:
-	case KSZ9893_CHIP_ID:
-	case KSZ9896_CHIP_ID:
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		return ksz9477_cls_flower_del(ds, port, cls, ingress);
-	}
-
-	return -EOPNOTSUPP;
-}
-
 /* Bandwidth is calculated by idle slope/transmission speed. Then the Bandwidth
  * is converted to Hex-decimal using the successive multiplication method. On
  * every step, integer part is taken and decimal part is carry forwarded.
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b67038cf1bd0..da62c1658aa8 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -483,10 +483,6 @@ bool ksz_support_eee(struct dsa_switch *ds, int port);
 int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 		    struct ethtool_keee *e);
 
-int ksz_cls_flower_add(struct dsa_switch *ds, int port,
-		       struct flow_cls_offload *cls, bool ingress);
-int ksz_cls_flower_del(struct dsa_switch *ds, int port,
-		       struct flow_cls_offload *cls, bool ingress);
 int ksz_setup_tc(struct dsa_switch *ds, int port,
 		 enum tc_setup_type type, void *type_data);
 
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 536153886f7b..731737fd58d1 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -890,8 +890,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
-	.cls_flower_add		= ksz_cls_flower_add,
-	.cls_flower_del		= ksz_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
 	.support_eee		= ksz_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,

-- 
2.54.0


