Return-Path: <netdev+bounces-19825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0484975C854
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3594D1C216A4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459D81EA7A;
	Fri, 21 Jul 2023 13:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397881EA77
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:50:22 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB7273F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:50:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso17382275e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947417; x=1690552217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK3XW9CvIKNotY0VMKRibuYSfqNfjSdewyrI1jRS2zM=;
        b=0ctkDHsJLr567qj00My9u/DwovaTt7nVS0cVaepA86zfFneViqAlpM4chikj9YNjt3
         KlTL4vYYcjlmlMHwc+SKh/+xXAkR3OhXaqYSFferh6wND2fdMOEDZ6aS5HB14zXPaVLu
         01Ge809ipavv5JQ8PxQ/x6kPY60W2EuxY/4BPBpNQHl4y8M1q/iN9+73+T9K9czoeU9y
         jwVXSRdJyVefdJ1xzvkssK9P4GpXffMhdBBW1WIExz05IpK+HM6yDYwpUFpHYZX2Qq3t
         Pv1PgAcxoOTi2f1MUVrDdmu3LJ2nnadMjVj7wS7B3U4lLCwY0ES6m8/rf8nHVwZta9G9
         cRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947417; x=1690552217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK3XW9CvIKNotY0VMKRibuYSfqNfjSdewyrI1jRS2zM=;
        b=h0gKPQ5pn0u47M6HKM0ffcDKmbJXiW3Hlj1y0+ot6rRGLEH/hzwPitALIkbi8NtVBE
         phfWjIVhsIInMxTUwuOYx/Uj5T4yDI8C0jie7PwFW7XPQlwhWKm98dwV70IlZYWaehKl
         iKkYuWed4AoPO3ULX75N34aJEmG+swA01xI9oDBe7rr6h+fasIJkYtEhDEpT3H+ZKXVJ
         8McxWZVEV9bFG9L6c8yxmINM1HBn9mLu4matY0cyGlwE+wBX1U6eK0urnIF0i4x0Ett+
         xoC5i4FLK/FEP0DhCmQkszNmNuOYzDkJmixx4+q4hVB+rsdhWaBWnQV3v/KkK5ME+QdP
         Sc0g==
X-Gm-Message-State: ABy/qLZndZjFc/Bb6kotvt50upr/AeMB+pSQw4TNUhIIyt8v8JCbahKi
	uSN4K7uS2FNtczzA0y0lhbKy/g==
X-Google-Smtp-Source: APBJJlEYGOJohpsvToAwNTHgc3LKCSn7YXvsUGwDkuU0VAHrmITjFOeoFfDz7sdQfHoDDp7yNk7Lbw==
X-Received: by 2002:a1c:f206:0:b0:3fb:415a:d07 with SMTP id s6-20020a1cf206000000b003fb415a0d07mr1476441wmc.36.1689947417293;
        Fri, 21 Jul 2023 06:50:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:16 -0700 (PDT)
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
Subject: [PATCH v3 4/6] can: tcan4x5x: Rename ID registers to match datasheet
Date: Fri, 21 Jul 2023 15:50:07 +0200
Message-Id: <20230721135009.1120562-5-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721135009.1120562-1-msp@baylibre.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
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


