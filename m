Return-Path: <netdev+bounces-291624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCMJBbBuFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:58:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 690985D3CDD
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A7C53090D8F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB13DB623;
	Tue, 26 May 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eUZV8Rb3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CB3B9949;
	Tue, 26 May 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788871; cv=none; b=AVb16ing40X3gzOh6lw9L0lqouGMWLIlZWXvKLDmn4YyVC4GSiCi9sCVqGGllIUReg5jkYAna7ViaUfvFjMnoRHKSkxfSyVrPxiOZvG7jGIDme52CY2N5G8UCJKtnMU8pH8wFsrDbHYuZITWsiuJwiY7Dn6MFA6USltG1QQ140I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788871; c=relaxed/simple;
	bh=vet+8LUw9CMHJCl4uCcWV2+acL0io+HppB8DCWwMYSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDIV1gOmYVwHk1p63+ZX96MPQQDVzSgabXomeeDQYGnnsvZ30PTSXgTKSiSit+iuUBf8ROvkzvsiCTanOYqAUkLysi3gVzPC2rL4JahcwIEdIUFOd2TfG0oxUveY8LVr5+5I+N7Nqx3QJ5JG+TvnA973sZeAjPqOLBi6rOxMy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eUZV8Rb3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 733BD1A36D4;
	Tue, 26 May 2026 09:47:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 468BA60732;
	Tue, 26 May 2026 09:47:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B97B11088858A;
	Tue, 26 May 2026 11:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788861; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/K9/ZTUYEm7hgptnRygC7Z1Qmu1Q/ZK2rVMEioKNYGM=;
	b=eUZV8Rb3hYs4R80fck3UyLCiqktJCsoy21b9h4aO0MledhzwuCI8eNlV+LrRZ5PCr6oPhZ
	didGMf+PU4bpr2W5jO4t5UB/dieDUzDdSMk/8sFnbt9LThAD5qIIgPkOUkxPhfEZ+Bb8Cu
	5twNtBZ+HTrGRJtS+npHyYgxXHXjMrhkn4EcgIrtkfAGARHH8JXejeP0Ezn0D6ewdgcl4u
	XQu1E7JJZtwBHMRGIj15SjJwXm89/W3HC6j6Ek5r852nbJV+G2f6maUTDkr96yI4fsFn0K
	JI/RsOa72ZpB1oF8B8HiRg3C/F/PZ9EH7/0Ki4Xh+zJYQEjY8Ph/OyS9l3ZwwA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:27 +0200
Subject: [PATCH net-next 1/9] net: dsa: microchip: remove useless common
 cls_flower_{add/del} operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-clean-ksz-3rd-v1-1-5b63e732149a@bootlin.com>
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
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291624-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 690985D3CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


