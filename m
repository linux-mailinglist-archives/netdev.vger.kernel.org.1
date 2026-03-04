Return-Path: <netdev+bounces-263720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II1VObUHqGnSnQAAu9opvQ
	(envelope-from <netdev+bounces-263720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:21:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFEF1FE3D0
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712CA3143554
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB953A1A56;
	Wed,  4 Mar 2026 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eCIfzKxP"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AA3A2549
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619552; cv=none; b=l9s+0nzL3J0b94o95WCYrfU4KiaqILhgs2EVQ4BF3TQnVFHDA8WyfUxTtLSCEbTxcq0RDWCmbpClDC2hcPgxRKXVvvnowS6nH2zYZzuv87SiQZYJRbKlKIZ6KdXljxL1BPxO0W4upMVgbKTNrSGrHLk/Zji+VHomThl1OGfU24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619552; c=relaxed/simple;
	bh=1DSoU6CbK0j90o7+JBRAk2vA4wGlNMTFxSdaqpeJa/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQZKgjMPv5tPfp7Ctxxui8Ph5ehiFI3Uy6PTcWHkRh6Vw2zV0e0jtV80DzXDirNbMrkL/fTPRmPD6il7Q+u/12Lf5hAmVgwCrroeVjHPFSANmmctLu5vNedrfnLny+YE6l4lfZzS0nsvI8da7D8xA21en7O5vwq9IN+AyUDLgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eCIfzKxP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2597B4E4253A;
	Wed,  4 Mar 2026 10:19:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9B825FF5C;
	Wed,  4 Mar 2026 10:19:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 585551036977C;
	Wed,  4 Mar 2026 11:19:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772619545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vr3bvxuke1eH9N7va1Vf/GvcbKA4SqYSzeU29NJ6EyA=;
	b=eCIfzKxPfXbgs1BiOG2NP6mp5/wM0bTWu1zX/Aps6ZIcN7FlqzfHyj7ogoQVlzEZj7yFel
	OSjmkEbwE44yPEEwq1FkCSUecQFeeICFCtb0xCsWXf8AEF88SdLdP/6T8Uxn6w/2KaY3pS
	OabS2yA8451zCHQy0GJ+ym8ccWXPnfl1HDC/dCHkJP6ydQkrfpaCFdAUMllHZ+2N/R+LmB
	zo7w4stCOZf7jXGgtCkneXLmn64Z0mDg/yFOFV9o/Esn1oo0LUkZsReREaLkBdoVJznBLi
	Y712ERNTSjPj9Grb2UQGK8RG/diHRnmBPzXQqVZXEvhD0SDG2x2NIA77PHPiqw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 04 Mar 2026 11:18:54 +0100
Subject: [PATCH net-next v6 3/9] net: dsa: microchip: Decorrelate msg_irq
 index from IRQ bit offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-ksz8463-ptp-v6-3-3f4c47954c71@bootlin.com>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
In-Reply-To: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
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
X-Rspamd-Queue-Id: 4EFEF1FE3D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263720-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
 drivers/net/dsa/microchip/ksz_ptp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 64afe92a3479ec87b5afc66e489b92787a0fc715..79f2210df8588e0a75b4f29dae2d7281ede12a3c 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1100,7 +1100,7 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 }
 
 static int ksz_ptp_msg_irq_setup(struct irq_domain *domain,
-				 struct ksz_port *port, u8 n)
+				 struct ksz_port *port, u8 index, int irq)
 {
 	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
 			REG_PTP_PORT_SYNC_TS};
@@ -1109,15 +1109,15 @@ static int ksz_ptp_msg_irq_setup(struct irq_domain *domain,
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
@@ -1162,7 +1162,7 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		goto out;
 
 	for (irq = 0; irq < ptpirq->nirqs; irq++) {
-		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq);
+		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq, irq);
 		if (ret)
 			goto out_ptp_msg;
 	}

-- 
2.53.0


