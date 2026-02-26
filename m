Return-Path: <netdev+bounces-261491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG8HG4iMoGkNkwQAu9opvQ
	(envelope-from <netdev+bounces-261491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E21AD4F4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623D0351F87A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680933603EC;
	Thu, 26 Feb 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PrYNTNMJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20435A38D
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124132; cv=none; b=Om7e+maM69SeLUOOkZSVX241nUHfoIKtqxgd176HQcnilF+JhFTVnbpnEeq+aHiCWrDu4AQEL2R23XCHuOOywy9ClshIzO8z2+IyrsnUoXhyyEdC69dHgdltIR0fYP83dlx3oGK+W54b79BZb8iXYyk7TpWyaqK9mWQfl2Tj5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124132; c=relaxed/simple;
	bh=qAUGqtuwCqJ0laxCFzHnXNutNvHz8zxfyVdBttZkIQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgL+gpCWOS/4wZh58GE64jJSVZ6+YcuiYEdvHXA9YDgT3pxzR1yGbcFm153f0iN0djNXrYvj/NbXdtqsidQICuDeg6T+rIeebMgwoPxtSDxwPl1z9/L3KE5qn7Nm6HUJK9RThSOs5KZHAz/oPxuAyQgEqvFar/HOafpoEVV73Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PrYNTNMJ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EEC10C4069C;
	Thu, 26 Feb 2026 16:42:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 707225FDE9;
	Thu, 26 Feb 2026 16:42:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D6D3103693FB;
	Thu, 26 Feb 2026 17:42:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772124122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Dt/xWp/luOgqyet9/x/e/zuW8LChXz1mN0JA1otPa0w=;
	b=PrYNTNMJMZx+6shinKM+OCrZhocShxW44POVa68Cz1kDuY3trTQlAN3M2vLx1FNNzunh5V
	AUPE5bk+Fu0AIPN8CPz6qba2FxtsSjhlUDBKFo2hkL/wx1oLoQ7htpqEzNIX4w3BmjTQsI
	oP9gA2UIU4OBQLo09zojZHC5+dCnDMJagEZD4JxFEZUlSF993k9qI86MjtuyEArkEvURD/
	dYPWWTMvSkPpewYK8y7CsfF4VNjnFoyJ7uJTlEwRxcoLiMtcSF82PZPGTRpGatw0vZu9bt
	PkcRhTSUqeio+NqUTZQCMEy2w6t3at60NXMy/qgc90gTsrsu6DQ/K/1XmC2r4w==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 26 Feb 2026 17:41:50 +0100
Subject: [PATCH net-next v5 3/9] net: dsa: microchip: Decorrelate msg_irq
 index from IRQ bit offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-ksz8463-ptp-v5-3-1bc24fb9627d@bootlin.com>
References: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
In-Reply-To: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261491-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: D42E21AD4F4
X-Rspamd-Action: no action

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
2.53.0


