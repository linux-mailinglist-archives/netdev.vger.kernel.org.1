Return-Path: <netdev+bounces-12522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB9737F04
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFDE1C20E2D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FFF9C9;
	Wed, 21 Jun 2023 09:31:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29394F9C0
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:31:16 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA5170C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so3383435e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339873; x=1689931873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK3XW9CvIKNotY0VMKRibuYSfqNfjSdewyrI1jRS2zM=;
        b=vvdnouFDr5rb5PrRGsiwpdR9r3jMNwu2DJKvMiB+TZcBK9nVZqtjy4UYTSQ4p9v/VP
         AquDpYPH11jrF5fDASMF0QD9sJEtSrMVtpn4yTrfXcrzYRXBVSUfh2j8cqsfBFxl6wTQ
         LmmUZA3e3tI2GkjWfMnNEG3XGt5EgaGGOhZA6bzTEwgGegB/VylAiRHrvVfHS0fVbHuQ
         bfIUDZN+XP5AHAn0UFS+tCcSTpqsif6XY8g0v6JNt3OixPHVV2E/2if5qputFSnY8AkV
         w5dl7UPoPIRGpkOn5p4VxIO1FmgwCj7Lu+5VB0Ymn7gcjmTddwZD9HzLFJBnZ0KPr8G8
         dL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339873; x=1689931873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK3XW9CvIKNotY0VMKRibuYSfqNfjSdewyrI1jRS2zM=;
        b=UafpFUynV9kg2fZREMXGe+0riU+Sr22x8y8MpktJKTtglGFN7qL8qgCPiv+JX/qQEV
         Ajc32oegjZDWKMBKbxoQy3L3VIdTp7cGsPM0HF9eVqWMXz4GamWMUDXDIQ1DuPBbhmde
         QLOaWVfJNj0becxKDxVhDU+qBtTLzc41JADcIlGr19dZ0meYIJQnS279W2HiMnJDuZuv
         aMv7N7I8gsFB9wHghHTf+eS/CY0PD5fZ7nXtooQMylX0Sne39sY68wIDHkv3/w8GXL3E
         2TC7RV14g9foYih0zpyEji+C42bfK75pyBh4cxSFoYsVWfuKCQzf7sR6/pJYHV+tmfSL
         wl0A==
X-Gm-Message-State: AC+VfDwljYWwHAY/1a57g8WztQt1WYu0ZgFoXNUeOJHGP8l0XQGGPYnD
	ldq+Mc/TXt/4d47o8bddo45Rhg==
X-Google-Smtp-Source: ACHHUZ7COqfi5t5n61Ie+ILJw3861GrMcUy4TqaeUI4JHKNwaDVVPooLUubzz7WmMReSJ+T8lRhG0A==
X-Received: by 2002:a05:600c:2051:b0:3f7:3545:4630 with SMTP id p17-20020a05600c205100b003f735454630mr15189344wmg.20.1687339873364;
        Wed, 21 Jun 2023 02:31:13 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:12 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 4/6] can: tcan4x5x: Rename ID registers to match datasheet
Date: Wed, 21 Jun 2023 11:31:01 +0200
Message-Id: <20230621093103.3134655-5-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621093103.3134655-1-msp@baylibre.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The datasheet calls these registers ID1 and ID2. Rename these to avoid
confusion.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index e706518176e4..fb9375fa20ec 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -6,8 +6,8 @@
 
 #define TCAN4X5X_EXT_CLK_DEF 40000000
 
-#define TCAN4X5X_DEV_ID0 0x00
-#define TCAN4X5X_DEV_ID1 0x04
+#define TCAN4X5X_DEV_ID1 0x00
+#define TCAN4X5X_DEV_ID2 0x04
 #define TCAN4X5X_REV 0x08
 #define TCAN4X5X_STATUS 0x0C
 #define TCAN4X5X_ERROR_STATUS_MASK 0x10
-- 
2.40.1


