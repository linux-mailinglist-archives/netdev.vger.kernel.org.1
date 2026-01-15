Return-Path: <netdev+bounces-250240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF31D25883
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB0BD30178F0
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3673B8D6D;
	Thu, 15 Jan 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g+alzKG8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189F3A4AA8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492646; cv=none; b=IaBwqHnw1lxreYQIqa7kJ3qQilXs1WOGKSr+DHWQYeNLUzr+t/PBHXiWLtRu/z3Eth8Xc6MRg73RBhDSF0Ud+znu82CRTb8sk6gfMKe54ycS1oEQM2ACQozubWJn6mjosmV0tKyb3LL65Tw3YTLYvFGWmhgWW3GiAcpmOM8Udrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492646; c=relaxed/simple;
	bh=y9ILA0dgp7O+/P1xCiocTYA28Zii9I7LacpliNPN/eU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3iUmXmvJ2el+caKZ4Uhj6FHCGltRQ2bP2Ase0Omn61k7WkYJFAEfna1NQn+vwbV2alToX0RDHT7+BpWgbBOB1OJ2E9HUhOfRTHqpKONIhJ+vxDNS53gGXklngahRsyr+2X26foSN9KX4OQjGOv0H6z1Cn3ZME5GgFl2TufCMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g+alzKG8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D6334C1F1DE
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 15:56:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 958F3606E0;
	Thu, 15 Jan 2026 15:57:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96E0510B686B7;
	Thu, 15 Jan 2026 16:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768492636; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IVi7Q1GgB0qSOLdVBgrG+z5nUwRZyQIi7zOmshni1Pg=;
	b=g+alzKG8hQ28GP9nRDctzRbBiPmQ09KqT5Kq+4XFy+j27bbTALhXomBF+iF5pNzUCoTWf0
	2TIEFa6mZOOP1jSyO+Q6SVc0tpcT5YlSAzgKP5KLTJNTJBN/UwIaYsGjuRUbEaI+B5jXLV
	6mg0dVt2gjJ1lZ9NIwkUNExtrIfvEJmsJ3RjVSYo0lwTnmYRtDd6/vuKnpAibcA88MGQQF
	dVHEktSqcSZ7m6xBjvj7B9rev+BmXT5Vl7U0A1RkNuf0E+LiMwnVwKQqhLGu/OedjxcxBS
	/i7ckfncfbrsW8JJduoQlILMpwpnWF0pTTITzmHy6Xw8mWUZ/9GTsbRaSVm6Yg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 15 Jan 2026 16:57:03 +0100
Subject: [PATCH net-next 4/8] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-ksz8463-ptp-v1-4-bcfe2830cf50@bootlin.com>
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
In-Reply-To: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

KSZ8463 PTP interrupts aren't handled by the driver.
The interrupt layout in KSZ8463 has nothing to do with the other
switches:
- all the interrupts of all ports are grouped into one status register
  while others have one interrupt register per port
- xdelay_req and pdresp timestamps share one single interrupt bit on the
  KSZ8463 while each of them has its own interrupt bit on other switches

Add KSZ8463-specific IRQ setup()/free() functions to support KSZ8463.
Both ports share one IRQ domain held by port n°1.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c  |  49 +++++++++-----
 drivers/net/dsa/microchip/ksz_common.h  |   2 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 114 +++++++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_ptp.h     |   9 +++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |   7 ++
 5 files changed, 162 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 82ec7142a02c432f162e472c831faa010c035123..224be307b3417bf30d62da5c94efc6714d914dc6 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3076,15 +3076,21 @@ static int ksz_setup(struct dsa_switch *ds)
 		if (ret)
 			return ret;
 
-		dsa_switch_for_each_user_port(dp, dev->ds) {
-			ret = ksz_pirq_setup(dev, dp->index);
+		if (ksz_is_ksz8463(dev)) {
+			ret = ksz8463_ptp_irq_setup(ds);
 			if (ret)
-				goto port_release;
-
-			if (dev->info->ptp_capable) {
-				ret = ksz_ptp_irq_setup(ds, dp->index);
+				goto girq_release;
+		} else {
+			dsa_switch_for_each_user_port(dp, dev->ds) {
+				ret = ksz_pirq_setup(dev, dp->index);
 				if (ret)
-					goto pirq_release;
+					goto port_release;
+
+				if (dev->info->ptp_capable) {
+					ret = ksz_ptp_irq_setup(ds, dp->index);
+					if (ret)
+						goto pirq_release;
+				}
 			}
 		}
 	}
@@ -3119,14 +3125,20 @@ static int ksz_setup(struct dsa_switch *ds)
 		ksz_ptp_clock_unregister(ds);
 port_release:
 	if (dev->irq > 0) {
-		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
-			if (dev->info->ptp_capable)
-				ksz_ptp_irq_free(ds, dp->index);
+		if (ksz_is_ksz8463(dev)) {
+			ksz8463_ptp_irq_free(ds);
+		} else {
+			dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+				if (dev->info->ptp_capable)
+					ksz_ptp_irq_free(ds, dp->index);
 pirq_release:
-			ksz_irq_free(&dev->ports[dp->index].pirq);
+				ksz_irq_free(&dev->ports[dp->index].pirq);
+			}
 		}
-		ksz_irq_free(&dev->girq);
 	}
+girq_release:
+	if (dev->irq > 0)
+		ksz_irq_free(&dev->girq);
 
 	return ret;
 }
@@ -3140,11 +3152,14 @@ static void ksz_teardown(struct dsa_switch *ds)
 		ksz_ptp_clock_unregister(ds);
 
 	if (dev->irq > 0) {
-		dsa_switch_for_each_user_port(dp, dev->ds) {
-			if (dev->info->ptp_capable)
-				ksz_ptp_irq_free(ds, dp->index);
-
-			ksz_irq_free(&dev->ports[dp->index].pirq);
+		if (ksz_is_ksz8463(dev)) {
+			ksz8463_ptp_irq_free(ds);
+		} else {
+			dsa_switch_for_each_user_port(dp, dev->ds) {
+				if (dev->info->ptp_capable)
+					ksz_ptp_irq_free(ds, dp->index);
+				ksz_irq_free(&dev->ports[dp->index].pirq);
+			}
 		}
 
 		ksz_irq_free(&dev->girq);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 67a488a3b5787f93f9e2a9266ce04f6611b56bf8..dfbc3d13daca8d7a8b9d3ffe6a7c1ec9927863f2 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -851,6 +851,8 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define PORT_SRC_PHY_INT		1
 #define PORT_SRC_PTP_INT		2
 
+#define KSZ8463_SRC_PTP_INT		12
+
 #define KSZ8795_HUGE_PACKET_SIZE	2000
 #define KSZ8863_HUGE_PACKET_SIZE	1916
 #define KSZ8863_NORMAL_PACKET_SIZE	1536
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index ae46ba41c588c076de2c3b70c7c6702ad85263d5..cafb64785ef4c7eb9c05900a87148e8b7b4678e5 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -31,6 +31,9 @@
 #define KSZ_PTP_SUBNS_BITS 32
 
 #define KSZ_PTP_INT_START 13
+#define KSZ8463_PTP_PORT1_INT_START 12
+#define KSZ8463_PTP_PORT2_INT_START 14
+#define KSZ8463_PTP_INT_START KSZ8463_PTP_PORT1_INT_START
 
 static int ksz_ptp_tou_gpio(struct ksz_device *dev)
 {
@@ -1102,6 +1105,7 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *port,
 				 u8 index, int irq)
 {
+	static const char * const ksz8463_name[] = {"sync-msg", "delay-msg"};
 	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
 			REG_PTP_PORT_SYNC_TS};
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
@@ -1115,15 +1119,108 @@ static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *por
 		return -EINVAL;
 
 	ptpmsg_irq->port = port;
-	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[index]);
 
-	strscpy(ptpmsg_irq->name, name[index]);
+	if (ksz_is_ksz8463(port->ksz_dev)) {
+		ts_reg[0] = KSZ8463_REG_PORT_SYNC_TS;
+		ts_reg[1] = KSZ8463_REG_PORT_DREQ_TS;
+		strscpy(ptpmsg_irq->name, ksz8463_name[index]);
+	} else {
+		strscpy(ptpmsg_irq->name, name[index]);
+	}
+
+	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[index]);
 
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
 				    ptpmsg_irq->name, ptpmsg_irq);
 }
 
+static int ksz8463_ptp_port_irq_setup(struct ksz_irq *ptpirq, struct ksz_port *port, int hw_irq)
+{
+	int ret;
+	int i;
+
+	init_completion(&port->tstamp_msg_comp);
+
+	for (i = 0; i < 2; i++) {
+		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, i, hw_irq++);
+		if (ret)
+			goto release_msg_irq;
+	}
+
+	return 0;
+
+release_msg_irq:
+	while (i--)
+		ksz_ptp_msg_irq_free(port, i);
+
+	return ret;
+}
+
+static void ksz8463_ptp_port_irq_teardown(struct ksz_port *port)
+{
+	int i;
+
+	for (i = 0; i < 2; i++)
+		ksz_ptp_msg_irq_free(port, i);
+}
+
+int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	const struct ksz_dev_ops *ops = dev->dev_ops;
+	struct ksz_port *port1, *port2;
+	struct ksz_irq *ptpirq;
+	int ret;
+	int p;
+
+	port1 = &dev->ports[0];
+	port2 = &dev->ports[1];
+	ptpirq = &port1->ptpirq;
+
+	ptpirq->irq_num = irq_find_mapping(dev->girq.domain, KSZ8463_SRC_PTP_INT);
+	if (!ptpirq->irq_num)
+		return -EINVAL;
+
+	ptpirq->dev = dev;
+	ptpirq->nirqs = 4;
+	ptpirq->reg_mask = ops->get_port_addr(p, KSZ8463_PTP_TS_IER);
+	ptpirq->reg_status = ops->get_port_addr(p, KSZ8463_PTP_TS_ISR);
+	ptpirq->irq0_offset = KSZ8463_PTP_INT_START;
+	snprintf(ptpirq->name, sizeof(ptpirq->name), "ptp-irq-%d", p);
+
+	ptpirq->domain = irq_domain_create_linear(dev_fwnode(dev->dev), ptpirq->nirqs,
+						  &ksz_ptp_irq_domain_ops, ptpirq);
+	if (!ptpirq->domain)
+		return -ENOMEM;
+
+	ret = request_threaded_irq(ptpirq->irq_num, NULL, ksz_ptp_irq_thread_fn,
+				   IRQF_ONESHOT, ptpirq->name, ptpirq);
+	if (ret)
+		goto release_domain;
+
+	ret = ksz8463_ptp_port_irq_setup(ptpirq, port1,
+					 KSZ8463_PTP_PORT1_INT_START - KSZ8463_PTP_INT_START);
+	if (ret)
+		goto release_irq;
+
+	ret = ksz8463_ptp_port_irq_setup(ptpirq, port2,
+					 KSZ8463_PTP_PORT2_INT_START - KSZ8463_PTP_INT_START);
+	if (ret)
+		goto free_port1;
+
+	return 0;
+
+free_port1:
+	ksz8463_ptp_port_irq_teardown(port1);
+release_irq:
+	free_irq(ptpirq->irq_num, ptpirq);
+release_domain:
+	irq_domain_remove(ptpirq->domain);
+
+	return ret;
+}
+
 int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 {
 	struct ksz_device *dev = ds->priv;
@@ -1181,6 +1278,19 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	return ret;
 }
 
+void ksz8463_ptp_irq_free(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *port1 = &dev->ports[0];
+	struct ksz_port *port2 = &dev->ports[1];
+	struct ksz_irq *ptpirq = &port1->ptpirq;
+
+	ksz8463_ptp_port_irq_teardown(port1);
+	ksz8463_ptp_port_irq_teardown(port2);
+	free_irq(ptpirq->irq_num, ptpirq);
+	irq_domain_remove(ptpirq->domain);
+}
+
 void ksz_ptp_irq_free(struct dsa_switch *ds, u8 p)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 3086e519b1b641e9e4126cb6ff43409f6d7f29a5..46494caacc4287b845b8e5c3a68bcfc7a03bcf9d 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -48,6 +48,8 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
 void ksz_port_deferred_xmit(struct kthread_work *work);
 bool ksz_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 		       unsigned int type);
+int ksz8463_ptp_irq_setup(struct dsa_switch *ds);
+void ksz8463_ptp_irq_free(struct dsa_switch *ds);
 int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p);
 void ksz_ptp_irq_free(struct dsa_switch *ds, u8 p);
 
@@ -65,6 +67,13 @@ static inline int ksz_ptp_clock_register(struct dsa_switch *ds)
 
 static inline void ksz_ptp_clock_unregister(struct dsa_switch *ds) { }
 
+static inline int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
+{
+	return 0;
+}
+
+static inline void ksz8463_ptp_irq_free(struct dsa_switch *ds) {}
+
 static inline int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 {
 	return 0;
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index eab9aecb7fa8a50323de4140695b2004d1beab8c..e80fb4bd1a0e970ba3570374d3dc82c8e2cc15b4 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -121,6 +121,10 @@
 #define REG_PTP_PORT_SYNC_TS		0x0C0C
 #define REG_PTP_PORT_PDRESP_TS		0x0C10
 
+#define KSZ8463_REG_PORT_DREQ_TS	0x0648
+#define KSZ8463_REG_PORT_SYNC_TS	0x064C
+#define KSZ8463_REG_PORT_DRESP_TS	0x0650
+
 #define REG_PTP_PORT_TX_INT_STATUS__2	0x0C14
 #define REG_PTP_PORT_TX_INT_ENABLE__2	0x0C16
 
@@ -131,4 +135,7 @@
 #define KSZ_XDREQ_MSG			1
 #define KSZ_PDRES_MSG			0
 
+#define KSZ8463_PTP_TS_ISR		0x68C
+#define KSZ8463_PTP_TS_IER		0x68E
+
 #endif

-- 
2.52.0


