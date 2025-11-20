Return-Path: <netdev+bounces-240322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2722C73105
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 10:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 48FA62EE3A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 09:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98A3164C5;
	Thu, 20 Nov 2025 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C+im4jjg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE23148C1
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629940; cv=none; b=g3e+bS6Lo+cYemKbVqXWv3L/uVa6kTW8QREwLGbzgKpPR5tslP1G0QOpWVNGPWO/N+hxhvwwd2vRJe/FQTaoC+7ySq3TeVz3SRo4JalXywGtrClXqJvzPja/hYng+FY4iEujIkR6eIvxAm0UJBELMp+W3M2OxMrRTccLznyT1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629940; c=relaxed/simple;
	bh=R2ZCVf/VJ+iRyopKoIirxw/rsKraQlQIQ1btffSMMzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKM6JMpJOTXwMhi6bgMYKwhwbne47TmUJsWYAlTHioOX3qOSQeY0jKjfEPmIm95cacwky7pcy6yIWS4NVfUtFO4sTsxml9Q4beHZWKuHlnyNAQ6rQFxamtZOjavDRO6V+4CuQF+5fnUGaiaMsEDAOdG/TKHJtX5AnhoJG6B6c5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C+im4jjg; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 06FD24E417EA;
	Thu, 20 Nov 2025 09:12:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D11F36068C;
	Thu, 20 Nov 2025 09:12:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95A2E10371C0C;
	Thu, 20 Nov 2025 10:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763629935; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uxcBfrkPXkUZDJCua6/YvADKTChGewQXWcqnNL7MEe0=;
	b=C+im4jjg3s4gjlZQflMBdfIKdiE2eIvkG3e4496ZqMHij4t43WW4ugrXCTL8ps7n1USQyE
	4/y3sc4WK2LLK5UCcr6jR73eMaOyY5gDMGEbn5q09vbxKc8S2vPb+NuVJTFPwfjlsQjlZV
	SNiJj6j5wG3GGRe8K0DydqmTNGvCRtIUGACoLltTTApNjWB1OHSveUVEhhI8O8aHScuUH0
	dm1l7LSz/RHz5mLqbMG5yh7QNDgJWnY/t/EUHpu9Jrw9ZRvdpedR3OliqnY1n0thmGrcbq
	6GlAt9FOZoaIMU0FtsjtxBu8KEusRYSIE7VKEfs7r3gd2IAo63v9/9isSgOM8A==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 20 Nov 2025 10:12:02 +0100
Subject: [PATCH net v6 3/5] net: dsa: microchip: Don't free uninitialized
 ksz_irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-ksz-fix-v6-3-891f80ae7f8f@bootlin.com>
References: <20251120-ksz-fix-v6-0-891f80ae7f8f@bootlin.com>
In-Reply-To: <20251120-ksz-fix-v6-0-891f80ae7f8f@bootlin.com>
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
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

If something goes wrong at setup, ksz_irq_free() can be called on
uninitialized ksz_irq (for example when ksz_ptp_irq_setup() fails). It
leads to freeing uninitialized IRQ numbers and/or domains.

Use dsa_switch_for_each_user_port_continue_reverse() in the error path
to iterate only over the fully initialized ports.

Cc: stable@vger.kernel.org
Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b17d29dda612ce00ce2e52fbe16c54bd6516c417..49827ac770e6fcc9e4a1a11e8814cdd90b17473e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3080,7 +3080,7 @@ static int ksz_setup(struct dsa_switch *ds)
 			ksz_ptp_irq_free(ds, dp->index);
 out_pirq:
 	if (dev->irq > 0)
-		dsa_switch_for_each_user_port(dp, dev->ds)
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds)
 			ksz_irq_free(&dev->ports[dp->index].pirq);
 out_girq:
 	if (dev->irq > 0)

-- 
2.51.1


