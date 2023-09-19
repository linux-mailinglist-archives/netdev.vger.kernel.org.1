Return-Path: <netdev+bounces-34921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA87A5ECB
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC571C20EFA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E302E62A;
	Tue, 19 Sep 2023 09:54:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE92E621
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:54:16 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8616C19B4
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:54:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bdcade7fbso701157166b.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695117251; x=1695722051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OmXgnmvOiVfooj4M23wQXodnaTVsRKoq6QYvvY7fqHM=;
        b=RgQyoqUm11pRry9dUDKqKUxVvTI2uVecQ2JniY1b3jBaAKIkQB3UZb6B3YcCKXUXaf
         OT6KuGJuX0mDfVrGdMKsYB5ZyO5oY5/Q5Q2iTNdm5LZZeGW67c2fNvtmlJIWeUncBlyq
         XLua7I+5+CQ1K9KC9Z3e9kxqYf/zhl0vsIVU2iZkxLgACELaFfggRdSzq9JVj5gFTDpM
         yLPJUltHgzM49H2mY4Mkp8aSHbWg/E5UvU0QB30jTg1u2p/+oaaILpIG8rHGNBZFVj9K
         FCaXn1/F3e73NHlCXn4a7TX0RG9iapgjtGEyL4xlh225FEKIei0klikQj+UN1Pjambrr
         9YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695117251; x=1695722051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmXgnmvOiVfooj4M23wQXodnaTVsRKoq6QYvvY7fqHM=;
        b=mep2CL9iTYES1iegpAGULQigdECI3b2+c+034D9ht+Vswolk6rXBtd7AOrCNeQVQKP
         6aGf388aBJOKiE9C3wesLEDXUzgJhtVeS+fyyb8D4yeky+8E7z2YXUecGTu6pffKdyls
         Qw/B3+yt+NXGX0+YwUZhFrl2nAzquPtudlMj5ocx9TLXkGQE9f9mH2UED/Z+9AijngCn
         LGZUkT3nL7KKEXUX3iWQDCnI0shZZmz3XQ/LdlXHJKhEIgy+J1bcefGhJTrqX9iE4FDp
         +ftcDEa0/lMrItx7gTBDMGcYhzU8OMLAOsb28x5qttLcjGGNk6CamSuVqkkR6AidbVwi
         fKhQ==
X-Gm-Message-State: AOJu0YzGVTSctjbaG8u/5xiJWka0E2ryCQvp70UtyC5pv1oSxcQ4fPgm
	J+08T6vK7G8Plb5MAqcOxn/OTw==
X-Google-Smtp-Source: AGHT+IFD+/JR8bBXkKzRaOn6uW69Q1H71e3hBw6gpkPpcO6ABZxmcJoEcS7N9t36yAyaScr+LBt+gA==
X-Received: by 2002:a17:907:a07c:b0:992:bc8:58e4 with SMTP id ia28-20020a170907a07c00b009920bc858e4mr6491327ejc.20.1695117250517;
        Tue, 19 Sep 2023 02:54:10 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906198b00b009926928d486sm7521855ejd.35.2023.09.19.02.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:54:09 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] can: tcan4x5x: Fix id2_register for tcan4553
Date: Tue, 19 Sep 2023 11:54:01 +0200
Message-Id: <20230919095401.1312259-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix id2_register content for tcan4553. This slipped through my testing.

Reported-by: Sean Anderson <sean.anderson@seco.com>
Closes: https://lore.kernel.org/lkml/a94e6fc8-4f08-7877-2ba0-29b9c2780136@seco.com/
Fixes: 142c6dc6d9d7 ("can: tcan4x5x: Add support for tcan4552/4553")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8a4143809d33..ae8c42f5debd 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -125,7 +125,7 @@ static const struct tcan4x5x_version_info tcan4x5x_versions[] = {
 	},
 	[TCAN4553] = {
 		.name = "4553",
-		.id2_register = 0x32353534,
+		.id2_register = 0x33353534,
 	},
 	/* generic version with no id2_register at the end */
 	[TCAN4X5X] = {
-- 
2.40.1


