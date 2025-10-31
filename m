Return-Path: <netdev+bounces-234680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E0EC2619C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ECE583CBF
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCD4302766;
	Fri, 31 Oct 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r/Eg/NM9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63632F693E;
	Fri, 31 Oct 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926752; cv=none; b=sBZTTpOrQ9ZZMJXSKXrRu2LBEdJF/V4m5JsMyqcuEBQ/f8RpQYjbV6fwWu7rYoWmulRY0KT1Rv5xqDn7TGYs5qxiSvxoEIkKGzM/whYTRCj+2F1aAIf7QETC1jOf6KqnY9fqzgi7Qt3XITvTtZiJhiw8YFc/cnGGVOgWd+J+ACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926752; c=relaxed/simple;
	bh=95X8NfNg94Ut5ngq92r3DA5Bj+TwY3d3z4iHIBxI1SI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBZjicEE6DJKEPL9kTJ+whqVA1azcGNSVFrG+9sZfxMmv9D4xM77Y63mtnrzm20nCAZanyAdZqXYSzJWIeZYNytAusTCqbfLeXkE2889tjepHoH6EFEanQ61yB0ZS4KgFw5+MWDyag1Nw5A/tcwpbdaL90g8ptzoFetceysJGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r/Eg/NM9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E8B3B4E41445;
	Fri, 31 Oct 2025 16:05:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFB0260704;
	Fri, 31 Oct 2025 16:05:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DFA511818067;
	Fri, 31 Oct 2025 17:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761926748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lo3kX3rnuQel+DCOioyxlIMM2H/4F/tW6UiRMe3mpSw=;
	b=r/Eg/NM9wAN7B/lEvAH/7SeK4ifGkCo9EPiCrT5CP0328hJO4vDoD+Uv5Mq4J2SCgzo+4g
	PGBPV05ydRhdkXovgas4BwohBayeChJ/7tHqdSqmpEuAR11hL4GYy56Cc9TKSE637j3UBA
	wfnJvUBI3gD71fMY6B9yBJo1HWiujRpqciGrECY0BhtuhEg6ojmLmXv8viAyALZuf8konV
	Nt2+8vtKOeKxuWXffAvkoVxkvuorxcOdcWecCo39nmcUR9MDucyiFCKntp5W9QB8uItvXr
	mNVVzlkfKlQlrLip+Fw5Mjg2UE39avqRr1qRuLYpoEFcY87mNAkt4MxqRlQ5PA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 17:05:40 +0100
Subject: [PATCH net 3/3] net: dsa: microchip: Immediately assing IRQ
 numbers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-ksz-fix-v1-3-7e46de999ed1@bootlin.com>
References: <20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com>
In-Reply-To: <20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The IRQ numbers created through irq_create_mapping() are only assigned
to ptpmsg_irq[n].num at the end of the IRQ setup. So if an error occurs
between their creation and their assignment (for instance during the
request_threaded_irq() step), we enter the error path and try to release
the not yet assigned ptpmsg_irq[n].num.

Assing the IRQ number at mapping creation.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index c8bfbe5e2157323ecf29149d1907b77e689aa221..a8ad99c6ee35ff60fb56cc5770520a793c86ff66 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1102,10 +1102,6 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 
 	strscpy(ptpmsg_irq->name, name[n]);
 
-	ptpmsg_irq->num = irq_find_mapping(port->ptpirq.domain, n);
-	if (ptpmsg_irq->num < 0)
-		return ptpmsg_irq->num;
-
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
 				    ptpmsg_irq->name, ptpmsg_irq);
@@ -1135,8 +1131,13 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
-		irq_create_mapping(ptpirq->domain, irq);
+	for (irq = 0; irq < ptpirq->nirqs; irq++) {
+		port->ptpmsg_irq[irq].num = irq_create_mapping(ptpirq->domain, irq);
+		if (!port->ptpmsg_irq[irq].num) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
 
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
 	if (!ptpirq->irq_num) {

-- 
2.51.0


