Return-Path: <netdev+bounces-306069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jv7cNmBET2qydAIAu9opvQ
	(envelope-from <netdev+bounces-306069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:49:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5B72D55F
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:49:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="LPW/z7RF";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306069-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306069-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5B6530C068C
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4D03DDAF8;
	Thu,  9 Jul 2026 06:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21453DE43B
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:42:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579376; cv=none; b=XlHCKhVfySyVTIBUEoXSqwrmHMI5+DU6y8UIbpfWKtpSl229+KkHu+0r4O0lWg2Xi2rtOtYcySOMZ5PwGfrEIt+bp1eQst0XAVmhjM2zFjhYdDqhPJvbzBxN5QHguGJtpmEBfAL1F9p9WDFepZwN+qBm9StTMc0FLUUcqbkN4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579376; c=relaxed/simple;
	bh=hWw4xiAaOHbn0Lxb1RJ9sP1ExOiCtbQjGmsfJ6RvU0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUM6VpMCklglpWxy9FpfEI1tpCovYYj3U6O/ACI8ZdhygG4+z7EvDnXpZF1xa1GAIImpocIw2uyJ0oV5bd7NQYoHUyD3aEr/N8nqbTPyWFBqKWveNQDtJLgFCZmVUsLqx2z3M3A05ixY5TGfnpW7fFfvZ8eAN9QWOgLgkMl1wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LPW/z7RF; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 477B11A0EFE;
	Thu,  9 Jul 2026 06:42:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AAB65FF03;
	Thu,  9 Jul 2026 06:42:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B4AC11BC2144;
	Thu,  9 Jul 2026 08:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579360; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VmVvjxYNp9LkN0emJrGpqwbiGfhUTLyxiUgQJDJv1kU=;
	b=LPW/z7RF1s9iGREY8nPevfeDzEmNGR6Q3Cxfyhysx7ehh7hE8ANnee3YBm1EL5CvTYB0l4
	dxe1dupZNiih/Q1it67i9/XgryfdKFstFGNotIBqXrbN2ztZCjYGPG9Z1TmXO3sk6Cw9ui
	NZYUSId9KtbtTUYnIOvx+uslk5t4QZRN6p8f5hm5iIruPymOqMqj0wNoKbqqRm9oVwly2r
	9U88/qL1L30JbAQALQzTZ39pVhaJdTv+korymlgWym9GZpS/tFRu0wiRXaabdF6tWMQmi3
	s6aHUHANHCzyy2xQHad8RFtvDfGU0TZwK+PNd9MhYkyvZ6CMlBrdULlV5lWrOQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:29 +0200
Subject: [PATCH net-next 03/10] net: dsa: microchip: allow the use of other
 IRQ operations.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-3-344f02fe739e@bootlin.com>
References: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
In-Reply-To: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
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
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306069-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43B5B72D55F

The IRQ setup uses an hardcoded set of IRQ operations. These operations
don't fit with the KSZ8463 which has an inverted bit logic (it uses an
'enable irq' register instead of a 'mask irq' one) and 16-bits registers.

Take the IRQ domain operations as input of ksz_irq_common_setup() to
allow KSZ8463 to use the already existing setup with its own set of IRQ
operations.
Expose ksz_irq_common_setup() and ksz_irq_bus_lock/unlock() so they can
be used by ksz8.c.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 15 ++++++++-------
 drivers/net/dsa/microchip/ksz_common.h |  5 +++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 67ab6ddb9e53..ff1be540b546 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2419,14 +2419,14 @@ static void ksz_irq_unmask(struct irq_data *d)
 	kirq->masked &= ~BIT(d->hwirq);
 }
 
-static void ksz_irq_bus_lock(struct irq_data *d)
+void ksz_irq_bus_lock(struct irq_data *d)
 {
 	struct ksz_irq *kirq  = irq_data_get_irq_chip_data(d);
 
 	mutex_lock(&kirq->dev->lock_irq);
 }
 
-static void ksz_irq_bus_sync_unlock(struct irq_data *d)
+void ksz_irq_bus_sync_unlock(struct irq_data *d)
 {
 	struct ksz_irq *kirq  = irq_data_get_irq_chip_data(d);
 	struct ksz_device *dev = kirq->dev;
@@ -2504,14 +2504,15 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
 
-static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
+int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq,
+			 const struct irq_domain_ops *ops)
 {
 	int ret, n;
 
 	kirq->dev = dev;
 
-	kirq->domain = irq_domain_create_simple(dev_fwnode(dev->dev), kirq->nirqs, 0,
-						&ksz_irq_domain_ops, kirq);
+	kirq->domain = irq_domain_create_simple(dev_fwnode(dev->dev),
+						kirq->nirqs, 0, ops, kirq);
 	if (!kirq->domain)
 		return -ENOMEM;
 
@@ -2543,7 +2544,7 @@ int ksz_girq_setup(struct ksz_device *dev)
 
 	girq->irq_num = dev->irq;
 
-	return ksz_irq_common_setup(dev, girq);
+	return ksz_irq_common_setup(dev, girq, &ksz_irq_domain_ops);
 }
 
 int ksz_pirq_setup(struct ksz_device *dev, u8 p)
@@ -2560,7 +2561,7 @@ int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	if (!pirq->irq_num)
 		return -EINVAL;
 
-	return ksz_irq_common_setup(dev, pirq);
+	return ksz_irq_common_setup(dev, pirq, &ksz_irq_domain_ops);
 }
 
 void ksz_teardown(struct dsa_switch *ds)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index acaf70e6f393..0f2abb22ca91 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -8,6 +8,7 @@
 #define __KSZ_COMMON_H
 
 #include <linux/etherdevice.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/pcs/pcs-xpcs.h>
@@ -508,6 +509,10 @@ int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val);
 int ksz_parent_mdio_read(struct mii_bus *bus, int addr, int regnum);
 int ksz_parent_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val);
 int ksz_mdio_register(struct ksz_device *dev);
+void ksz_irq_bus_lock(struct irq_data *d);
+void ksz_irq_bus_sync_unlock(struct irq_data *d);
+int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq,
+			 const struct irq_domain_ops *ops);
 int ksz_pirq_setup(struct ksz_device *dev, u8 p);
 int ksz_girq_setup(struct ksz_device *dev);
 void ksz_irq_free(struct ksz_irq *kirq);

-- 
2.54.0


