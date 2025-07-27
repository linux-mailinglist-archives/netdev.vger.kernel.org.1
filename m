Return-Path: <netdev+bounces-210392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD57B1310C
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 20:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D701896E44
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 18:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FBD223316;
	Sun, 27 Jul 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uV3v2cLK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CB221D92
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639407; cv=none; b=koCswtFIegBZ84alWwOr4IJxcvHFKzlbnH3m7R3cVYWDizYjZ8q3uyg3IRTpFvol4g5RzLMt/5oGJnxC0ruKQ1xZYO/2DKGYVuul38aPzIPHd7CHhRIxXbcP95ZhTsxny3vdEVkruSY9vBxojipzI1ywERbyT2/qzVtxGKqBUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639407; c=relaxed/simple;
	bh=FDUSulcAHU63Gb7cvtylh25veNN58O6WmUwROBNSoX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/aKASuwJEDJhpdYbl/YBYukTAwB+scECimxDKJCKEWHrX4yG/fN3+4cSujJt1A7wirEUhh1upIrkmI2OKANleBbwkEXxiuLnnQq9C4QAwbDbEQ8DQOuqKDdETQcj2AV1t8m2EwTBE19tLpf8vPLtxlFwWHA9JW0BPt+jRy4hZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uV3v2cLK; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753639404; bh=Lf1pIE+nbwht/5GyHXz0t8s5hLIXWqOx164q+in/H3I=;
 b=uV3v2cLKaVUu/2JTPSGlUz9LOWSLx/7z7wwSF2M3ZoWUrALuXBQzzaRF9pXacAL33WnDDxqrV
 IfsIx7mZ1Mvp3ATKOal3B0TLbRcTh31dJ0jo1WZM8+T9J0hJ9y9m+ghMZTiM05J3pAnMb8VFU+D
 Hxm1R61kHyiVSD68uob8yM2+9z655FVpYihIcH+dnLs1sHeKedZ9I9tzLOa1NBkuxetRs+nXiu6
 d+JpgL9F6prIRw1eMAp3Q6I2H4f1mudXGB2lmoxpgfco36qPrHUYKaHe1dpq38Owu+T82duyILC
 oTAx9NiUlODdsRxCyW3Hx8RhbvOsYEnc52eRoxQkT4xA==
X-Forward-Email-ID: 688669e4c509b9ee169cf311
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH net-next 1/3] net: dsa: realtek: remove unused user_mii_bus from realtek_priv
Date: Sun, 27 Jul 2025 18:02:58 +0000
Message-ID: <20250727180305.381483-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727180305.381483-1-jonas@kwiboo.se>
References: <20250727180305.381483-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

user_mii_bus of struct realtek_priv is not dereferenced anywhere and it
is easy to confuse it with user_mii_bus from struct dsa_switch, remove
it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dsa/realtek/realtek.h | 1 -
 drivers/net/dsa/realtek/rtl83xx.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index a1b2e0b529d5..7f652b245b2e 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -57,7 +57,6 @@ struct realtek_priv {
 	struct regmap		*map;
 	struct regmap		*map_nolock;
 	struct mutex		map_lock;
-	struct mii_bus		*user_mii_bus;
 	struct mii_bus		*bus;
 	int			mdio_addr;
 
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 2b9bd4462714..9a05616acea8 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -102,8 +102,6 @@ int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
 		goto err_put_node;
 	}
 
-	priv->user_mii_bus = bus;
-
 err_put_node:
 	of_node_put(mdio_np);
 
-- 
2.50.1


