Return-Path: <netdev+bounces-22292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1C766F43
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74371C21909
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0F13FEB;
	Fri, 28 Jul 2023 14:19:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CB13FEA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 14:19:30 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE353C04
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:19:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso4461745e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690553968; x=1691158768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOPR69iAQ16PRI3TWa1E2gZcgSDBVpUe2mB3Tg7XdFY=;
        b=eCfDNPSl7vSoyBHYmOveE8fuDlgi8ZipveyzGaTlPOC0Q2OpbSPndzkwgMyclgAda/
         V6WTHb/DKo1bo2kDoa0OhOJhJ4PL5NQqBFKROAUwm4e9A72r5un/Wtm8JoiZhb4l0DE1
         Vs++o1lVFVOTFyUwli6h3oJ+wHe8tIxqaUvdlCDdAphocUK+ygU+y9/PrDVt7fIk7CW7
         Ms2GNLTCZO5/X4rTwRGcPHx0MtToecCzRNkrPA7W26gLn5kE3H/GoJhCCBHIbzGQIXn5
         Jszk8Jw96jdQ0daJjcTZN11nmfyS6iMVC2HVfmGVY0NLDFC3N9ANmvlVym1ZBAg+pMsx
         d+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553968; x=1691158768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOPR69iAQ16PRI3TWa1E2gZcgSDBVpUe2mB3Tg7XdFY=;
        b=QN6PmIhZJhyLxMC+euUnEUGLI7Mg8NVxUaSJ3wLwu9e5ilVt0xiNTR3mveGRJzCXe+
         TduULhvbC1ZVCWqyAvkpvybPCG8Ikq7hXpn56S+aPYfCsCiqB/qPkX6dw2TQ7xRfwM+p
         GZsPdNRikXEW/CTfVNt/twDJIaRMAVzH0da1wlW495s09xeuOD9eJFXKW5KLQyaFghMi
         5SdEe+vJwRJLCntIAnVq0EcP9huoRXtDoE7iEub4gngxgJ1Ddq9wJ2K6vEqbQD0l5aMg
         1mptXgRMfF0JGiLZetlEsSZZrd+D4d5rZpaegWbFA25cIvsGA6pPpCsEvaUFJWR9k8QB
         CumQ==
X-Gm-Message-State: ABy/qLZagO0ngcnqCGqrxmE6VHwg6zEZblapNgKgoqharPMNjcW1rL+f
	9WAVkuyelrTMnlUGqq1uDJKFgA==
X-Google-Smtp-Source: APBJJlFhR9WAI6qiGI8oGXWvZ/UsZ0vbMPJ3iXVMm2YZyySkV1K6NGpHXIsauRuCoGnRq9hod7gT/A==
X-Received: by 2002:a5d:5101:0:b0:313:f5f8:a331 with SMTP id s1-20020a5d5101000000b00313f5f8a331mr1763758wrt.34.1690553967911;
        Fri, 28 Jul 2023 07:19:27 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a246:80e3:766f:be78:d79a:8686])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm5013681wrm.3.2023.07.28.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:19:27 -0700 (PDT)
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
Subject: [PATCH v4 2/6] can: tcan4x5x: Remove reserved register 0x814 from writable table
Date: Fri, 28 Jul 2023 16:19:19 +0200
Message-Id: <20230728141923.162477-3-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728141923.162477-1-msp@baylibre.com>
References: <20230728141923.162477-1-msp@baylibre.com>
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

The mentioned register is not writable. It is reserved and should not be
written.

Fixes: 39dbb21b6a29 ("can: tcan4x5x: Specify separate read/write ranges")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 2b218ce04e9f..fafa6daa67e6 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -95,7 +95,6 @@ static const struct regmap_range tcan4x5x_reg_table_wr_range[] = {
 	regmap_reg_range(0x000c, 0x0010),
 	/* Device configuration registers and Interrupt Flags*/
 	regmap_reg_range(0x0800, 0x080c),
-	regmap_reg_range(0x0814, 0x0814),
 	regmap_reg_range(0x0820, 0x0820),
 	regmap_reg_range(0x0830, 0x0830),
 	/* M_CAN */
-- 
2.40.1


