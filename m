Return-Path: <netdev+bounces-46479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9B7E475A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166FBB203C8
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F0D34CDB;
	Tue,  7 Nov 2023 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDnOxzN8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6E30FAC
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 17:44:48 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC0212B;
	Tue,  7 Nov 2023 09:44:47 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso79964541fa.2;
        Tue, 07 Nov 2023 09:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699379086; x=1699983886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBopQGClenfXGmuKg6C+Z7OAKKWkOzVf06T/O52p9BM=;
        b=IDnOxzN8be9/3C0yRG6b3cVbDW6izav8Ou1cZXUZ6TZZY7PNskf8qsY/b+M4EggUjj
         hmdguXa7GYvkMM6yOMYteKvO6NwZcYsWq2BQUz7Aku/wnP6M24ipqRjBh12+qZamas4X
         eQ/3N0wQfr2UCnDA6faOVvsKysD5r7e0NPLoIFt5kvtkAeyJXIrW18X02ffE2t2ShZUn
         cG8vkL5S1sNHjKemmZF0EYTCbSzDA0/7ASEokDfxgMVtG5NYSP9z2Nw33+NdG/7+OXOW
         3F70Ej/cAd/Lxiu3cqPTBAX/pwKi2Sczi7PBPG2X1SURJxrinILO5YPDeRjr1Mb/nR5N
         jk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379086; x=1699983886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBopQGClenfXGmuKg6C+Z7OAKKWkOzVf06T/O52p9BM=;
        b=PAh3agm7IKoAnUUSPU9WhhsGRX0pi68JAjAttHDmfvLSbM6cMZUsmalRXa5D4tiLGy
         MsSbCY6oY5B8YtP0eDBD2tz4hOm+jztwYtEX2CWssJ/z9TtcVsso8Yvba+BV299cJ7Ns
         dxHhhnF0bd/QSIjOiQpWj3/R5rbPniLlJGNg0H5AmDYSK45aVpoOkSOa6r+07pDUtreL
         Ym11DmTGMhPFxnwFfZgeD+9kD7GPC2bY+yvuwkoprzcUwR8tX3ik2J1CWY/xycppsMOM
         5G5FczZAz8BVM2BoORHINugGUUtT9W1kOHe7GD/bOM9e+Wqee1UNUkQoD64hc8h4Kx5t
         3a2g==
X-Gm-Message-State: AOJu0YyxhQCqjjXfGDM9sqhsveRdy2o4bAlcdvwOSG4916hOku+Ivrmo
	YAKRn046AKtnpqVAmJYc4Zc=
X-Google-Smtp-Source: AGHT+IES7S2vBMwfwLLo9czOMjftZI+gMSNLau9BawVxeuoCFGFSKElKL3PI8QD0OoVy9aSJy/6QEQ==
X-Received: by 2002:a2e:a417:0:b0:2bd:102c:4161 with SMTP id p23-20020a2ea417000000b002bd102c4161mr28844292ljn.43.1699379085812;
        Tue, 07 Nov 2023 09:44:45 -0800 (PST)
Received: from mars.. ([2a02:168:6806:0:ed9a:eb86:e191:6603])
        by smtp.gmail.com with ESMTPSA id bh7-20020a05600c3d0700b00401b242e2e6sm16608744wmb.47.2023.11.07.09.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:44:45 -0800 (PST)
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Russell King <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: phylink: initialize carrier state at creation
Date: Tue,  7 Nov 2023 18:44:02 +0100
Message-ID: <20231107174402.3590-1-klaus.kudielka@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background: Turris Omnia (Armada 385); eth2 (mvneta) connected to SFP bus;
SFP module is present, but no fiber connected, so definitely no carrier.

After booting, eth2 is down, but netdev LED trigger surprisingly reports
link active. Then, after "ip link set eth2 up", the link indicator goes
away - as I would have expected it from the beginning.

It turns out, that the default carrier state after netdev creation is
"carrier ok". Some ethernet drivers explicitly call netif_carrier_off
during probing, others (like mvneta) don't - which explains the current
behaviour: only when the device is brought up, phylink_start calls
netif_carrier_off.

Fix this for all drivers using phylink, by calling netif_carrier_off in
phylink_create.

Fixes: 089381b27abe ("leds: initial support for Turris Omnia LEDs")
Cc: stable@vger.kernel.org
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2: clarified fixed drivers; added fixes tag & cc stable

 drivers/net/phy/phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6712883498..a28da80bde 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1616,6 +1616,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
+		netif_carrier_off(pl->netdev);
 	} else if (config->type == PHYLINK_DEV) {
 		pl->dev = config->dev;
 	} else {
-- 
2.42.0


