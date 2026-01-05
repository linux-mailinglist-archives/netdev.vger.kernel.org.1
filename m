Return-Path: <netdev+bounces-247047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E27DCF3C11
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE8830CA5E8
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2C227B83;
	Mon,  5 Jan 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qOaLktrK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9E21CC58
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618508; cv=none; b=ovr4rvtUp1zyPTvHtUQWRNV8ih34mPR8DL/ewoEVKoJEk+NZ0ry9xH0mBf4U22SKmNndROQ6jBPxJZjd4FrpcX0P+levP6/PIrSpylohernvLxoCqV9W/2NpFDhn/uOcprRJINdnX1VdMt+0fU47bj7xfEXmTsObQWQM+k+vMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618508; c=relaxed/simple;
	bh=GXaQFe/Is97fVVZGCbnVuhzcHgfOQ+tyK7d4SkC6q98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWwhe0oU8xJ6NS7fL3inPhU0dIdlM5b1KvslpY+FJqLhicXiyH1E9MkgkfSFn4LIJhlkYksFd6RoToOoGEBi/kS1Hk0mnRZr1G2nP6cjrV0xo18VNGgUvAaLy2B8DclEMLSwKehNhP8xeMtto3hBbOI8Vs5PX35RVZj5wv93qdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qOaLktrK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC4411A2659;
	Mon,  5 Jan 2026 13:08:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C18E960726;
	Mon,  5 Jan 2026 13:08:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE24C103C8416;
	Mon,  5 Jan 2026 14:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618502; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nAokcdyRaLbj1nu9HhMESdbv4sN2fW/Zlfyc2vVP3vY=;
	b=qOaLktrKDnHuti5M+HA3l9Bc7IUQUADbaVgmfvzN0RTN3NLUBfJzt0lQz4I1nO8GBuFj4w
	aFe+5AngL8Quqrb/yCr57noj1r9PIQUF4l/FUyBXcPG9fBN2jYlPTDtAIKjKSEDAJ9oIVw
	7xvb0mLE0f02g3le2HX2vreGCVXAz5Ur4k4x88ZcecfqM6OYjmRsBtperNiMFaflLG44x9
	qCzm4FrFbGKtLwk2G3Up16lpvGESrtBIdZHQMm5JJcyUeV/5ydgtYGgMWsRspHH2zztPgA
	m1s+ZJlCj+8eQ24P+KitIfVvhC38mzBbi2cSdjJ/Byutte7XsOEw18WNXyRzTQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:00 +0100
Subject: [PATCH net-next 1/9] net: dsa: microchip: Initialize IRQ's mask
 outside common_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-1-a68df7f57375@bootlin.com>
References: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
In-Reply-To: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
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

The IRQ logic of the KSZ8463 differs from that of other KSZ switches.
It doesn't have a 'mask' register but an 'enable' one instead. The
common IRQ framework can still be used though as soon as we reverse
the logic (using '1' to enable interrupts instead of '0') for KSZ8463
cases.

Move the initialization of the kirq->masked outside of
ksz_irq_common_setup() to keep this function truly common when
IRQ support for the KSZ8463 is added.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 0c10351fe5eb4206210c727ffc2484bfb7168d97..fa392f952f9441cfbeb51498fc9411340b58747a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2905,7 +2905,6 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	int ret, n;
 
 	kirq->dev = dev;
-	kirq->masked = ~0;
 
 	kirq->domain = irq_domain_create_simple(dev_fwnode(dev->dev), kirq->nirqs, 0,
 						&ksz_irq_domain_ops, kirq);
@@ -2935,6 +2934,7 @@ static int ksz_girq_setup(struct ksz_device *dev)
 	girq->nirqs = dev->info->port_cnt;
 	girq->reg_mask = REG_SW_PORT_INT_MASK__1;
 	girq->reg_status = REG_SW_PORT_INT_STATUS__1;
+	girq->masked = ~0;
 	snprintf(girq->name, sizeof(girq->name), "global_port_irq");
 
 	girq->irq_num = dev->irq;
@@ -2949,6 +2949,7 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	pirq->nirqs = dev->info->port_nirqs;
 	pirq->reg_mask = dev->dev_ops->get_port_addr(p, REG_PORT_INT_MASK);
 	pirq->reg_status = dev->dev_ops->get_port_addr(p, REG_PORT_INT_STATUS);
+	pirq->masked = ~0;
 	snprintf(pirq->name, sizeof(pirq->name), "port_irq-%d", p);
 
 	pirq->irq_num = irq_find_mapping(dev->girq.domain, p);

-- 
2.52.0


