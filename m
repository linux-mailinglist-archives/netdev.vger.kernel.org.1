Return-Path: <netdev+bounces-216459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBA6B33D08
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FBD16D47F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54542D9ECD;
	Mon, 25 Aug 2025 10:41:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4052D6E77;
	Mon, 25 Aug 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118481; cv=none; b=FHXfLxNrtN4DCT34QTYXo6RSXm8z+aCZeZqtzNy03TGTcdVUVUXE4aWaQgEwp3KHsROqS7+j65n4Bpwg/HInmeBxM0t4YhsGlEYskaCfoqIeHZOxtqCaXVkE8a8imK90SnUqRnYt4glPvjb0vTjvIK2Wa6G3U9V8kaW9ZqmeAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118481; c=relaxed/simple;
	bh=PdxxKeyeceakPlTQqFd2A9nbPnGW95fQ6PUCACBH9EE=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=SuEq1r+PwgPNZZcR812z08mkbkMj2idTA9iJKFYIO7zjdL/K1O6FD1gi2zBhpIB1PhYDGIpdXL+SFlfq5XW5OCbU96ijZlDJ3SH1TasBGIA9mxd3+AUtK9jz+b6D2HGp/ap/zuRF3HneDXoAviJRU/GVca0j1Ifg8oLffKN19lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4c9S4z3jJ9z5B0lT;
	Mon, 25 Aug 2025 18:41:07 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 57PAf0LG024511;
	Mon, 25 Aug 2025 18:41:00 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 25 Aug 2025 18:41:02 +0800 (CST)
Date: Mon, 25 Aug 2025 18:41:02 +0800 (CST)
X-Zmail-TransId: 2afc68ac3dbedcf-48490
X-Mailer: Zmail v1.0
Message-ID: <20250825184102534B6FAD5gv_p5nAHbiIyFqx@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYyXSBldGhlcm5ldDogdGxhbjogQ29udmVydCB0byB1c2UgamlmZmllcyBtYWNybw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57PAf0LG024511
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.enpei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 25 Aug 2025 18:41:07 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AC3DC3.000/4c9S4z3jJ9z5B0lT

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Use time_after_eq macro instead of using jiffies directly to handle
wraparound.

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
        struct tlan_priv        *priv = timer_container_of(priv, t, timer);
        struct net_device       *dev = priv->dev;
-       u32             elapsed;
        unsigned long   flags = 0;

        priv->timer.function = NULL;
@@ -1844,8 +1843,7 @@ static void tlan_timer(struct timer_list *t)
        case TLAN_TIMER_ACTIVITY:
                spin_lock_irqsave(&priv->lock, flags);
                if (priv->timer.function == NULL) {
-                       elapsed = jiffies - priv->timer_set_at;
-                       if (elapsed >= TLAN_TIMER_ACT_DELAY) {
+                       if (time_is_before_eq_jiffies(priv->timer_set_at + TLAN_TIMER_ACT_DELAY)) {
                                tlan_dio_write8(dev->base_addr,
                                                TLAN_LED_REG, TLAN_LED_LINK);
                        } else  {
-- 
2.25.1

