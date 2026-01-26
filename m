Return-Path: <netdev+bounces-253363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDacGYYld2kUcwEAu9opvQ
	(envelope-from <netdev+bounces-253363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:27:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C25856CB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 399FB300C26F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145E63126A0;
	Mon, 26 Jan 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dxL7ZT6c"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36F2882D6;
	Mon, 26 Jan 2026 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416065; cv=none; b=pSFX9cJ53rgqdpzBre7DpFOYNZrG/c3pyRFTotbRZl6aDdU17M7tXqAjjYt4abTm6NXFKm0UVi5XrxfKQwEKsGJ+lqD6KuhF+MC660/grXV3nnq0ROVe03QiKnbGvR2NHZyeRql5rr4LmIhDXAElzl1/WA281jLMQ2jP6x0T/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416065; c=relaxed/simple;
	bh=Mq588nrNPw+uc5oepjcOMjmGegEoAI+0BQA2zqK9rvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iV71D7fVIwVq7wQ0wtB6NKQBfbIlb85yxXnQxd+s7Zw3O3QL2VmNDnUSooSJppu23LVQBFV/twsIjOtXh3fOMhD3xcRu9qBia56IHGAtbhGtNAE7WkuUWr7LXDVok81jdGZ+fDFdOdacXVfZd/faZPE33S6X1lktVlAJi8zU20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dxL7ZT6c; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F3C21A2A50;
	Mon, 26 Jan 2026 08:27:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D731C60717;
	Mon, 26 Jan 2026 08:27:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28DA8119A8621;
	Mon, 26 Jan 2026 09:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769416060; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=msjsmNWxtn13jWdt/GBOpxERpRumsKymvRVrflpMg/g=;
	b=dxL7ZT6cqsi4xh2BWeYfzplsCg5fS2tBVmxFlxY6T0DZl/cajL+14/SCOMK/nqIs0L81NS
	yGA2fNIq2/C2Dm8QMqbiX1VM11zSYIM60Gx/Cg5qUDJmV62z2sHZsRDzzz1uvzgVnp69ht
	c2xlEex7JyxBK8FS6xWok09nQzBmS5VF2WRJh8DWe8vSRM4yNjy+gMUtotC0z5o51chELu
	iH+ecbP4m3lDCBvqciYIofKkVAFAip3meDSSBAY/XZLzMm9bDokPqgsQ/xPjoRp/t2DCFU
	SNvAgew6w6A+9M/XTiObrWEEKZDY3oly+DlALF0+VPkqWN3MAX6ylJGulufcVQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 26 Jan 2026 09:27:30 +0100
Subject: [PATCH net-next v3 2/8] net: dsa: microchip: Decorrelate IRQ
 domain from port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-ksz8463-ptp-v3-2-9f092aeb8492@bootlin.com>
References: <20260126-ksz8463-ptp-v3-0-9f092aeb8492@bootlin.com>
In-Reply-To: <20260126-ksz8463-ptp-v3-0-9f092aeb8492@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 24C25856CB
X-Rspamd-Action: no action

KSZ8463 has one register holding interrupt bits from both port 1 and 2.
So it has to use one IRQ domain for both of its ports. This conflicts
with the current initialization procedure that ties one IRQ domain to
each port.

Decorrelate IRQ domain from port so a port can use an IRQ domain not
directly related to itself.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 4a2cc57a628f97bd51fcb11057bc4effda9205dd..3b0dddf918595e9318c9e9779035d5152dcd9dde 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1099,18 +1099,17 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 	irq_dispose_mapping(ptpmsg_irq->num);
 }
 
-static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
+static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *port, u8 n)
 {
 	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
 			REG_PTP_PORT_SYNC_TS};
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
 					    "sync-msg"};
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
-	struct ksz_irq *ptpirq = &port->ptpirq;
 	struct ksz_ptp_irq *ptpmsg_irq;
 
 	ptpmsg_irq = &port->ptpmsg_irq[n];
-	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
+	ptpmsg_irq->num = irq_create_mapping(domain, n);
 	if (!ptpmsg_irq->num)
 		return -EINVAL;
 
@@ -1162,7 +1161,7 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		goto out;
 
 	for (irq = 0; irq < ptpirq->nirqs; irq++) {
-		ret = ksz_ptp_msg_irq_setup(port, irq);
+		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq);
 		if (ret)
 			goto out_ptp_msg;
 	}

-- 
2.52.0


