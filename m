Return-Path: <netdev+bounces-212045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008BB1D7BB
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6686217A1
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CB622126C;
	Thu,  7 Aug 2025 12:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606123BF83;
	Thu,  7 Aug 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569062; cv=none; b=D1+jqMon7Yw8+hXdee7DizYGDVeyNRUb/pu4oW3YF0mVLAB1RnmKsdvULMydiP81Sw6po0gV4E6tG/e7IHTQyS53l4+j3AYA3LdUU960VgnsP3lfU1FmZDsSVHG7DsGm2zX5H9G0mjlRSVUdrvQ7fvkHs0hbFfW9KWAjtMS5L+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569062; c=relaxed/simple;
	bh=7UKHMSFdkKDbez4DfaZNlRBYRu6oMuke+R79dQz65Z4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=O6CAr870JQtWRPGu7vCrLikC5LiPpgvIu7lDd5+DTSWmiSSEjwY61TtgZPp7eqJZbKZfXKI6gv0tEE9mWphKAwpEsXscGTzwCu6pLut25/y4jnqUVEAYOKmgM/hn7F7oYrgc03d1pzR0Gr+vxrY9/g5whX9s8cAoGsuM5tnXAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4byR4Q18Jpz6FyC0;
	Thu, 07 Aug 2025 20:17:26 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 577CHJLE025104;
	Thu, 7 Aug 2025 20:17:19 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 7 Aug 2025 20:17:22 +0800 (CST)
Date: Thu, 7 Aug 2025 20:17:22 +0800 (CST)
X-Zmail-TransId: 2afa689499523ea-d5054
X-Mailer: Zmail v1.0
Message-ID: <20250807201722468rYsJszSAHXqlVrVHEIuAz@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIXSBldGhlcm5ldDogdGxhbjogQ29udmVydCB0byB1c2UgamlmZmllcyBtYWNybw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 577CHJLE025104
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.enpei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 07 Aug 2025 20:17:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68949956.000/4byR4Q18Jpz6FyC0

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Use time_after_eq macro instead of using jiffies directly to handle
wraparound.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
---
 drivers/net/ethernet/ti/tlan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index a55b0f951181..78e439834f26 100644
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
+                       if (time_after_eq(jiffies, priv->timer_set_at + TLAN_TIMER_ACT_DELAY)) {
                                tlan_dio_write8(dev->base_addr,
                                                TLAN_LED_REG, TLAN_LED_LINK);
                        } else  {
-- 
2.25.1

