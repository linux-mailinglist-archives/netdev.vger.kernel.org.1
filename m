Return-Path: <netdev+bounces-217213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82203B37C4D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261E41791BA
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB73031DD97;
	Wed, 27 Aug 2025 07:55:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021ED2F617A;
	Wed, 27 Aug 2025 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281356; cv=none; b=ntR0hDVMOoUcaJM0g90AqUnocW02hI/ngLRVfknxty9PrY3neeRseREijXcoDY7Nu5SaIzGhwwibD0D8j4xECzzn0hNKy8kUyw9C6xLyUVp6d2o66VIZy++fHSfd2l8flyPr3SeqbGkOpOtCBncNDTs/PdRO+USt4Mm1OoH1HRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281356; c=relaxed/simple;
	bh=V/k3PlEhOV5Q5JNh16qCP66g14IOSN3k+JYedNywBUs=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=E6/lz7pxWJyl7AaDf0gquYVdP52zyAgiFXba9Cr/4qAMmBwrT60OM1dK7K6GxiAELxK4G0sy2mlNKXET978gHVw66P/cY9tOUQZ90xsxu6FzyIgyMSFglDuy6SjKoX09yjFT55Idqu6wDzmG/kGEkknn19r+gorukX97K7OoDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cBcKH0Nfgz8Xs6v;
	Wed, 27 Aug 2025 15:55:47 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 57R7srfU085184;
	Wed, 27 Aug 2025 15:54:53 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 27 Aug 2025 15:54:55 +0800 (CST)
Date: Wed, 27 Aug 2025 15:54:55 +0800 (CST)
X-Zmail-TransId: 2af968aeb9cf00e-edb33
X-Mailer: Zmail v1.0
Message-ID: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.enpei@zte.com.cn>
To: <chessman@tux.org>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYzXSBldGhlcm5ldDogdGxhbjogQ29udmVydCB0byB1c2UgamlmZmllcyBtYWNybw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57R7srfU085184
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.enpei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 27 Aug 2025 15:55:47 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AEBA03.001/4cBcKH0Nfgz8Xs6v

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Use time_is_before_eq_jiffies macro instead of using jiffies directly to
handle wraparound.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
---
 drivers/net/ethernet/ti/tlan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index a55b0f951181..7c5e51284942 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -1817,7 +1817,6 @@ static void tlan_timer(struct timer_list *t)
 {
 	struct tlan_priv	*priv = timer_container_of(priv, t, timer);
 	struct net_device	*dev = priv->dev;
-	u32		elapsed;
 	unsigned long	flags = 0;

 	priv->timer.function = NULL;
@@ -1844,8 +1843,7 @@ static void tlan_timer(struct timer_list *t)
 	case TLAN_TIMER_ACTIVITY:
 		spin_lock_irqsave(&priv->lock, flags);
 		if (priv->timer.function == NULL) {
-			elapsed = jiffies - priv->timer_set_at;
-			if (elapsed >= TLAN_TIMER_ACT_DELAY) {
+			if (time_is_before_eq_jiffies(priv->timer_set_at + TLAN_TIMER_ACT_DELAY)) {
 				tlan_dio_write8(dev->base_addr,
 						TLAN_LED_REG, TLAN_LED_LINK);
 			} else  {
-- 
2.25.1

