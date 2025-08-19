Return-Path: <netdev+bounces-214902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C838AB2BB91
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C02A3B21F5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F3256C8B;
	Tue, 19 Aug 2025 08:16:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7926462E;
	Tue, 19 Aug 2025 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591402; cv=none; b=bSHL9PnBHYJoCb5zxM4NNHPpgaakyAz+fQgD3NvOvXvaFyP9QnkHDU8yKPJTsdvwJIRDI5biIuGyCh5g0KMB2C24RSSutwBgykVbDBpH40GgqtDktY2QXlgYhajpSc5LzZbibQcAIa5sFLx913yrXm6ITVFnIYElmki+ZeAO3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591402; c=relaxed/simple;
	bh=7UKHMSFdkKDbez4DfaZNlRBYRu6oMuke+R79dQz65Z4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=F73fuJ/ozKXvmAyTgDDLexmhjtCeM/3Gzgm4n9NHVIDZGLX0RnFoW8Z0w8F/YwqUn7Sij3ZS5FNcaeb/wzi1pu2T3wniiv6QSoz+bkOEYNotmjpV+oWxbbGxi8x/Qi9iDrEdk8bu7SIuVdIZb2ZyoTf2l4vfGOFEE144jYPyHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c5j8q3Cynz8Xs7B;
	Tue, 19 Aug 2025 16:16:27 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 57J8GE4u041042;
	Tue, 19 Aug 2025 16:16:14 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 19 Aug 2025 16:16:16 +0800 (CST)
Date: Tue, 19 Aug 2025 16:16:16 +0800 (CST)
X-Zmail-TransId: 2afc68a432d00ab-12b16
X-Mailer: Zmail v1.0
Message-ID: <20250819161616455E67Ux3eifLtzWBrN8i6Fr@zte.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 57J8GE4u041042
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.enpei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 19 Aug 2025 16:16:27 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A432DB.000/4c5j8q3Cynz8Xs7B

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

