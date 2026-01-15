Return-Path: <netdev+bounces-250236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B4D258F6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A06330E1501
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C5E3B8BA3;
	Thu, 15 Jan 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uy61Ng5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CF3AA1A8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492645; cv=none; b=KE48SRjvwYzib9S5d7YC2eS43GbuKqAoi+7PmTeJXNW4eDlkJjPVAI75XGqGorbqs5ouv/E33OztvXmscyr/qwAqqsXSUb2hGz+qUP3xQU13tbgC1P/OBRRnBqLOF3gHalrA27Skysq6YyRWqZ0t06LQVjFymfta1VTqBoXNV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492645; c=relaxed/simple;
	bh=5JRPbX6ZNpbbjxewpLGryuvTwhcPES2z48M948O/Y2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C91iDKXmpCW5fiQjXEU8t04lv4OhBxJmymBYfa0ejq+3FN6zZadOfOr5cwG6El1PWf7+rvstg2Ey1mMKvFHIprJiJxXW6QkbnFd+MHUN7th9K27FlJHJO+l/bcKSFq0Kv/XOwyQ9g6c5o0dOQzwneJxjju+LYq2UKgt4NuZiH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uy61Ng5w; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 869C61A2882;
	Thu, 15 Jan 2026 15:57:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5BF50606E0;
	Thu, 15 Jan 2026 15:57:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CF7210B6862C;
	Thu, 15 Jan 2026 16:57:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768492634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=raSc7l7Hms0kVCTaWY56CLFkcCyEbYi+dFevYnfrWHg=;
	b=Uy61Ng5wfv9RKaTlnee5NvE4c5U0XerZMtmh6xTnLZiuJjJaGirb7lMMEcvdU5ACH1U/Vo
	vLUMRXpviDgylmLU9kZHO1QVl4dHh3xNc+VAH0NYBayc/lTCdXJd5SII5jTwgq2qknQtEr
	sKfGOXsTwrDpe9dA4GsQNX2DlK41/71amdSNshewvHNrg6Dwo5Abj63+uW2PKyd6jsG4u3
	Rv0mpAqcC83Y0rURtXhWf0Fb+gFSD90KGMQ32AwXZHoejLM8EFBRWZlm0UylrgHcVEIuKC
	6n9ZR487Zava0smoTBWyGJH8mz/fz6vnRoIIScmu0xqnDmho/Bmcgzsc8DkLQg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 15 Jan 2026 16:57:02 +0100
Subject: [PATCH net-next 3/8] net: dsa: microchip: Decorrelate msg_irq
 index from IRQ bit offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-ksz8463-ptp-v1-3-bcfe2830cf50@bootlin.com>
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

KSZ8463 has one register containing all the PTP-related interrupts from
all ports. So it will use one IRQ domain for all of them, leading to 4
interrupt bits to be dispatched in two ports. Current implementation
doesn't allow to do so because the IRQ bit offset is also used as index
to store the struct ptpmsg_irq in the table held by the port.

Add a new input to the setup() function to independently provide the
interrupt bit offset and the ptpmsg_irq index.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 3b0dddf918595e9318c9e9779035d5152dcd9dde..ae46ba41c588c076de2c3b70c7c6702ad85263d5 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1099,7 +1099,8 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 	irq_dispose_mapping(ptpmsg_irq->num);
 }
 
-static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *port, u8 n)
+static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *port,
+				 u8 index, int irq)
 {
 	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
 			REG_PTP_PORT_SYNC_TS};
@@ -1108,15 +1109,15 @@ static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *por
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
 	struct ksz_ptp_irq *ptpmsg_irq;
 
-	ptpmsg_irq = &port->ptpmsg_irq[n];
-	ptpmsg_irq->num = irq_create_mapping(domain, n);
+	ptpmsg_irq = &port->ptpmsg_irq[index];
+	ptpmsg_irq->num = irq_create_mapping(domain, irq);
 	if (!ptpmsg_irq->num)
 		return -EINVAL;
 
 	ptpmsg_irq->port = port;
-	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[n]);
+	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[index]);
 
-	strscpy(ptpmsg_irq->name, name[n]);
+	strscpy(ptpmsg_irq->name, name[index]);
 
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
@@ -1161,7 +1162,7 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		goto out;
 
 	for (irq = 0; irq < ptpirq->nirqs; irq++) {
-		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq);
+		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq, irq);
 		if (ret)
 			goto out_ptp_msg;
 	}

-- 
2.52.0


