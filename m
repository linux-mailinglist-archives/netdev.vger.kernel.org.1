Return-Path: <netdev+bounces-35848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4247AB545
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 59D162820EA
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564DA41742;
	Fri, 22 Sep 2023 15:51:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E300405E6
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:51:35 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDFB102;
	Fri, 22 Sep 2023 08:51:34 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 265B3E0004;
	Fri, 22 Sep 2023 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695397892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XOd0JrO+1xPUhE+XVcakH0x2HfsOjoLw2tQ5rSA+B/U=;
	b=ESmJwqf0WWa/pJi7++YG5b1j6UP3j/d6kvYOgYQGE/X7kdlksnQ8VoW65Q+Uju2KJuQOid
	0TQswmEzx3qV/PQtjLGHQHoOfcW46rjcneu2pS6uihi4ABVqlDRHLtoBzdzA4kJNd2+wVw
	w0MP6K23nHlM6QkvR7ZGvGE7YsOgI2xYZarKrPRqO6+VC/Sgl8eRnqLkvF35SrlSis+dLF
	D4hbz8XslW/cJ+zsPxKcC2zvlZ51vAnK9Gcd4gQjOq/BdrrMHdREhrwHgiGXewVnXA+PGF
	EPoh0r357xv3Hegd6mVawTe3u6gUyDgQV5ncMrp+qlBBAPK5ygw0ZYPBEXJHuw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	sylvain.girard@se.com,
	pascal.eberhard@se.com,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH net-next] can: sja1000: Fix comment
Date: Fri, 22 Sep 2023 17:51:30 +0200
Message-Id: <20230922155130.592187-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is likely a copy-paste error here, as the exact same comment
appears below in this function, one time calling set_reset_mode(), the
other set_normal_mode().

Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/net/can/sja1000/sja1000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 158a17c9d46b..ae47fc72aa96 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -207,7 +207,7 @@ static void sja1000_start(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 
-	/* leave reset mode */
+	/* enter reset mode */
 	if (priv->can.state != CAN_STATE_STOPPED)
 		set_reset_mode(dev);
 
-- 
2.34.1


