Return-Path: <netdev+bounces-239119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E839AC64456
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0470023EE9
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2B32E722;
	Mon, 17 Nov 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F0S1WWiS"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655A32F744
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384772; cv=none; b=JJB5BjUCT4HKMfFJhYGgrEdLh9vEtET4A1yDZhJpU68V5gG4KbFkmmbS58iGRdhohsvb7i933ZYVzBga/HHzLp/JXemu+n+yA1u0A4Az0tjpjDHsPKgQY71vOTL0M16b+3cjw0puzGZyFVr10zay5T/97fW7l9dTXlwiyy/sWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384772; c=relaxed/simple;
	bh=dtd0+nF+bp/Pfk/d35cPc0tB+EATqNkUgd8y1OCFLQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4TUO2VSqYhCI92FFvIC56ATAmJtu6TqseGNWUpOWkuAQLo5SKY/z1oIog8JVRsm8Cd8YzCysB5LHt1xntLG/sBaxJ0Kud1TuaJZCWq4u13o0dyJQ/nAGyZ93JunsCVOiX3jDPHE5j79GiPPhVvdO65Pp2LhAcFIz6KJSwPa8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F0S1WWiS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30AA0C12651;
	Mon, 17 Nov 2025 13:05:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43A0D606B9;
	Mon, 17 Nov 2025 13:06:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 168D310371C1B;
	Mon, 17 Nov 2025 14:06:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763384764; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dwsKotiDEJnhW0UR2k6JPDo93YR2yL0iASSN9Mxocl0=;
	b=F0S1WWiSxYq0ajYh4BY6fctSMuRPpLkAKAQucYCY3NX4tuh+wqCA33EV86iKwggVwVH15T
	iedFB9vdLgvZdB4SjAaecM9GAwc2c2ms0xoUdziEq4zilSaBr0q1wJRmGetrqDIgnwY95f
	Dnv60NoX7myqq9TH2weDpDZ/BwFOl52DPltNFY3S0S0QFV7Gqcmvz++EoA3XuNbpMAG9qG
	SvYNsQ5cNCl4srPwLmOPXgDDgOVaV2N1UEUs7AePcfYAz1d7E821yw/Xotxcr8MkI6fDvB
	2o77gRDumERUPAQpt6tzqH9n+i8YKQK8jNhaY/0CResb+/wgS2zLBqDFAu6jxA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 17 Nov 2025 14:05:43 +0100
Subject: [PATCH net v4 2/5] net: dsa: microchip: ptp: Fix checks on
 irq_find_mapping()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-ksz-fix-v4-2-13e1da58a492@bootlin.com>
References: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
In-Reply-To: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

irq_find_mapping() returns a positive IRQ number or 0 if no IRQ is found
but it never returns a negative value. However, during the PTP IRQ setup,
we verify that its returned value isn't negative.

Fix the irq_find_mapping() check to enter the error path when 0 is
returned. Return -EINVAL in such case.

Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 35fc21b1ee48a47daa278573bfe8749c7b42c731..c8bfbe5e2157323ecf29149d1907b77e689aa221 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1139,8 +1139,8 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		irq_create_mapping(ptpirq->domain, irq);
 
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
-	if (ptpirq->irq_num < 0) {
-		ret = ptpirq->irq_num;
+	if (!ptpirq->irq_num) {
+		ret = -EINVAL;
 		goto out;
 	}
 

-- 
2.51.1


