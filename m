Return-Path: <netdev+bounces-238611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BDEC5BC4C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8994F35B349
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318F2F90D3;
	Fri, 14 Nov 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SU5Udwbv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E452F5A30;
	Fri, 14 Nov 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104841; cv=none; b=Fg2aKipODWbcB/KHkeoymuRZUT0qpBQE0vA0PJMFO4dbtVNSyG+jFaH7/cUBdePAptRsub/ViRKTaozUt0pW9Q/MIF+0ucOdOM5ZVoxccrmReARihm0nrI48JP6RsaGrKFqmO3xSupnH45omZo/ooM1JEFhkmYWis7rjX8sFxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104841; c=relaxed/simple;
	bh=n2hvB/3o5w8dPESHdtFQQ9OaOCEwb0lAWC9CkO0kdaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aweSkd+XfbuMMWt000C98U0WUMAhNWR83VpSIxm5cHbFRD5815IDVEIjNpASWJdgSfnCnT5SgeSrfBsgu28JxbrY5rKottdtLrCrqH/eJCHiarB+4hsNJNxXJDSKS6xtJUYuaKyjMdqSCP7I2pCZaqeLjctvQf48Er07hshC01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SU5Udwbv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 67D8A1A1A97;
	Fri, 14 Nov 2025 07:20:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36EFB6060E;
	Fri, 14 Nov 2025 07:20:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5F3F102F24BE;
	Fri, 14 Nov 2025 08:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763104831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XSXVbFwfTU7Uju3hufcbql/zxc9UUbIw1e56ZFVut6Y=;
	b=SU5UdwbvnTqhlnvB5uPaGxGoTqyTYLEuoabB45YUjwmE63IS2KW2DcLR/iGiRf7FguMKJt
	cSmygxIUNeC6GXVaYeIfoPvt+H4aXh8DPfidX6VQPuonVwUEv+i/DLc/HVWOPmfOSKJ70U
	JZEz3J1fKSrF7FuC731lQS3B+XL72KQrtvx/isTGUzq23c6H+GsNiCuUXiwFEgTEo7xHeq
	OJn2OUbJl3sUDxUkIn7i5L003SM0kNhJZrtroCeLj38xupIWWgpMtFLmtDAN9cc3kkby1V
	cg/K8RhbDM8L4N3PGkQPmhbaP5kgwEAgyV4YXtu4YY/xoDwfrEgTRCnLnAHHlw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 14 Nov 2025 08:20:22 +0100
Subject: [PATCH net v3 3/4] net: dsa: microchip: Ensure a ksz_irq is
 initialized before freeing it
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-ksz-fix-v3-3-acbb3b9cc32f@bootlin.com>
References: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
In-Reply-To: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
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

Sometimes ksz_irq_free() can be called on uninitialized ksz_irq (for
example when ksz_ptp_irq_setup() fails). It leads to freeing
uninitialized IRQ numbers and/or domains.

Ensure that IRQ numbers or domains aren't null before freeing them.
In our case the IRQ number of an initialized ksz_irq is never 0. Indeed,
it's either the device's IRQ number and we enter the IRQ setup only when
this dev->irq is strictly positive, or a virtual IRQ assigned with
irq_create_mapping() which returns strictly positive IRQ numbers.

Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
--
Regarding the Fixes tag here, IMO before cc13ab18b201 it was safe to
not check the domain and the IRQ number because I don't see any path
where ksz_irq_free() would be called on a non-initialized ksz_irq
---
 drivers/net/dsa/microchip/ksz_common.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3a4516d32aa5f99109853ed400e64f8f7e2d8016..c5f8821a3a0ab7b50ddc31cc0a2f28220fe57c84 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2858,14 +2858,17 @@ static void ksz_irq_free(struct ksz_irq *kirq)
 {
 	int irq, virq;
 
-	free_irq(kirq->irq_num, kirq);
+	if (kirq->irq_num)
+		free_irq(kirq->irq_num, kirq);
 
-	for (irq = 0; irq < kirq->nirqs; irq++) {
-		virq = irq_find_mapping(kirq->domain, irq);
-		irq_dispose_mapping(virq);
-	}
+	if (kirq->domain) {
+		for (irq = 0; irq < kirq->nirqs; irq++) {
+			virq = irq_find_mapping(kirq->domain, irq);
+			irq_dispose_mapping(virq);
+		}
 
-	irq_domain_remove(kirq->domain);
+		irq_domain_remove(kirq->domain);
+	}
 }
 
 static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)

-- 
2.51.1


