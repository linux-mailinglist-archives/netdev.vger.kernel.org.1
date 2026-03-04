Return-Path: <netdev+bounces-263719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLz/M2oHqGnSnQAAu9opvQ
	(envelope-from <netdev+bounces-263719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:20:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EDE1FE3AB
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8BDC30DFED5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895D3A2545;
	Wed,  4 Mar 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RIhQw7U+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386A3A1CE7;
	Wed,  4 Mar 2026 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619548; cv=none; b=qbEhRBiIr0+YqGrSbFnX/G7sryDTZIUHyereF3OL4zT13mjedsdpZkYuZVJJ+eV/GlGa8IcVVWVoaF7/4HzBp3NLX4KUnMLCCX7Ho96y6gxSf8F+Svb5Wwq1VyMGdJrAwyQ3In8gqMkUVq8lDTz74HXqk2afZqPF183fbMhp/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619548; c=relaxed/simple;
	bh=fXMwrcjmZvystrSDHuovPfNyY4dVoy1RKCLww3ptD6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0aQXxMWNdpgFqrxatqrSVXckMu7N9d2xIZJgQenOUbSf1BD2kKNFbt2RiXV+n0jQVljXIkJsrRyClK94aGMQXvUdZIyUTAFJI40f5KqzDSfQEcF9kSOeXKEhKW2LVZJ8HtGxpCvrP5bhziDC62rmbbcXYQGI0mp/Yms7wiCLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RIhQw7U+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1DC154E42539;
	Wed,  4 Mar 2026 10:19:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7AD75FF5C;
	Wed,  4 Mar 2026 10:19:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 601EA10369785;
	Wed,  4 Mar 2026 11:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772619544; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FjmtI7HjgVnVqo/hseLxriBj9a2y9wqXyOZXbDhpUoM=;
	b=RIhQw7U+sGR2TybwTlGQOR4wzyo58gB4iT+ALSNLckUSwAP1FCliMKum4POTCeNtqJiayo
	QxBr93iPzLfCqVEKDS6cRrFaBTAj3/lMcggXE6DIu4CLIkkGJfZRN3kogvfGpcpEEwUpRS
	UULev7JOvjVvbSurcJy65oO9ZIQnLE0Q63FhuKX13uFO/PPbg6uRgk4y1XStinuwIWrmA+
	KHQPpKguQ0oToD6yhkMJ0z/to7OC1HxaMrA8faBo84S8Fw0UKM0MK65i4WXU4hh17ecEuw
	5Y6RUiDN9Jwh7KWGHfsQ69cMbD7cRAijGQqGxfJ7APGEHn5R/7QKQ1DTCzptgw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Wed, 04 Mar 2026 11:18:53 +0100
Subject: [PATCH net-next v6 2/9] net: dsa: microchip: Decorrelate IRQ
 domain from port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-ksz8463-ptp-v6-2-3f4c47954c71@bootlin.com>
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
X-Rspamd-Queue-Id: 31EDE1FE3AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263719-lists,netdev=lfdr.de];
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

KSZ8463 has one register holding interrupt bits from both port 1 and 2.
So it has to use one IRQ domain for both of its ports. This conflicts
with the current initialization procedure that ties one IRQ domain to
each port.

Decorrelate IRQ domain from port so a port can use an IRQ domain not
directly related to itself.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 4a2cc57a628f97bd51fcb11057bc4effda9205dd..64afe92a3479ec87b5afc66e489b92787a0fc715 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1099,18 +1099,18 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 	irq_dispose_mapping(ptpmsg_irq->num);
 }
 
-static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
+static int ksz_ptp_msg_irq_setup(struct irq_domain *domain,
+				 struct ksz_port *port, u8 n)
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
 
@@ -1162,7 +1162,7 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		goto out;
 
 	for (irq = 0; irq < ptpirq->nirqs; irq++) {
-		ret = ksz_ptp_msg_irq_setup(port, irq);
+		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq);
 		if (ret)
 			goto out_ptp_msg;
 	}

-- 
2.53.0


