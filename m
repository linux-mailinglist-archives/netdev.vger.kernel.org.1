Return-Path: <netdev+bounces-239118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D83C64452
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 665AB24024
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153E330FC38;
	Mon, 17 Nov 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dHBg8iqv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6A32E6B2
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384772; cv=none; b=ooFipESUlKogRJO23b4gSVl8NlmmgGmVVuwl+6cwvS/Y6EMpVyWjyEXZYEmMcTgIJLr4KVISZpW3ESEb15y+6bDxfAujqe9/nYIzD9kIDXWo5hvP9mdf9bVKlO6/Molxl3vdebeqVgjUIAAIhq9fQejf8tvtcSU20Xz3lFx0vMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384772; c=relaxed/simple;
	bh=4r/7XxgCCqAeVsQLUFOd77vszd2iOYLjLQs4R+5In7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aG98Nc3uA2nABliSlIijgH4J5K1/Z/KjwppULKUjUFJHROmgrLGz+wNf8GVs+J7o1knt+WBOtEL0vA3rN8vfW7GU/hQPQExJBURmyM+tslsKe8nTuoN0KqE/fb2kQaqilJ8j/tpdD3t5l/l/ahXPwNQuE1MTMcNakzst70kwtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dHBg8iqv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C4F27C12650;
	Mon, 17 Nov 2025 13:05:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CE30E606B9;
	Mon, 17 Nov 2025 13:06:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B88D610371D37;
	Mon, 17 Nov 2025 14:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763384766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iJC44dVU5yEb8hqqRuBXRUyct/KJL5rrWwNwUJgQGhI=;
	b=dHBg8iqvDHYQS1AKjR9b5BSpE+mKD/cMAuCDVAOVnaWgR8sFSlHLlBk+gj52vPJDT4LwvR
	1xDBTQULp/QL1x8XsKvoSlvUU91IVn9vR/YytMIY++zqDeLAq1c8qFWzWrBkOHpyhViDez
	tAAkhPg5WPaqb4xYEfuTxgjsSOzPtKTVe1Hi5mI/YNR34xMTRS2AQ1oI6aShlxKmlbXCIh
	wfch72+0A8XuLLuqpFxTKIYrXcICBZ+ATDZ+doRR3iguKRQ92pcU9w/ttDSgPz2WFHlux9
	Bk90WTR4jC+L3mgoyJe93mS+s6fUvtqPueqyEav6SbfMq1kWFXMXXmQh2Re1Bg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 17 Nov 2025 14:05:44 +0100
Subject: [PATCH net v4 3/5] net: dsa: microchip: Ensure a ksz_irq is
 initialized before freeing it
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-ksz-fix-v4-3-13e1da58a492@bootlin.com>
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

If something goes wrong at setup, ksz_irq_free() can be called on
uninitialized ksz_irq (for example when ksz_ptp_irq_setup() fails). It
leads to freeing uninitialized IRQ numbers and/or domains.

Ensure that the ksz_irq is initialized before calling ksz_irq_free().

Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
--
Regarding the Fixes tag here, IMO before cc13ab18b201 it was safe to
not check the domain and the IRQ number because I don't see any path
where ksz_irq_free() would be called on a non-initialized ksz_irq
---
 drivers/net/dsa/microchip/ksz_common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index c724f5af5d98bf3ff784e36393dd5b3fa7b37c13..a622416d966330187ee062b2f44051ddf4ce2a78 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3078,9 +3078,12 @@ static int ksz_setup(struct dsa_switch *ds)
 		dsa_switch_for_each_user_port(dp, dev->ds)
 			ksz_ptp_irq_free(ds, dp->index);
 out_pirq:
-	if (dev->irq > 0)
-		dsa_switch_for_each_user_port(dp, dev->ds)
-			ksz_irq_free(&dev->ports[dp->index].pirq);
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port(dp, dev->ds) {
+			if (dev->ports[dp->index].pirq.domain)
+				ksz_irq_free(&dev->ports[dp->index].pirq);
+		}
+	}
 out_girq:
 	if (dev->irq > 0)
 		ksz_irq_free(&dev->girq);

-- 
2.51.1


