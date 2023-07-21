Return-Path: <netdev+bounces-19823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5946575C84F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737AF1C21684
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9851E52F;
	Fri, 21 Jul 2023 13:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4331E520
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:50:19 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC24273F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:50:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3143b88faebso1672985f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947415; x=1690552215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOPR69iAQ16PRI3TWa1E2gZcgSDBVpUe2mB3Tg7XdFY=;
        b=S5dWitbnh9elOa2q9vS/O6dNz1JkoENscNstuy3J7BNYk2/m6k98E8AxiKJ9977QL0
         lNIQK2k8JE2UxkxW4th6c5WftiHUIyB4ad7eNknbEG64kQ4l3PYKxLCveUL1J2VNg0Q6
         +aaO0a6lYfije4SM6F+8KmfcM2mckMmuOeRmp+ySYNV2fTIFcquqbtvPgdoJI7ub1k6p
         9Q5Sm8/u6lVDPHdE+Hwr7mYb0V3/qAN3/fXBn+yDAdxzFVLkeGotnjp8Q1HkP1ndu/YP
         FKacxuXIPmcNETfgkQbNu7V8K6YDFzSlVT8Araax1YIHfa6gBpJblvTiCS76KRE0i7DY
         EXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947415; x=1690552215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOPR69iAQ16PRI3TWa1E2gZcgSDBVpUe2mB3Tg7XdFY=;
        b=JmKD8EInHhAuxqh1pg2HvPCh12LCyRppQpaxfvwDZPwWeqkKdkXBU+kONYOSRhh0eC
         HPIlz0USsbhKKa2TzkV09rhQZxPHTCBuM4YNoQEh+tjg721jOfBWAF0qrsGISRyT+A3a
         G9cUYVMhp3+tah9ePvvHSh9ud+HtKvgJ+wAlfocYZxhowyF+5K4jK4oe5X3ug2Ma5tvo
         4RB8GKFYvaneU2uQy2PwqcPCNvhF3fyG7UGVBjp6xo118oQaisj7Xau7e3PrA2cx96/e
         /vPJrR+msdtb5u8La3zCPBMC+4X1Xp91hGNLbqBzB9Q7tYxv6Eut/bQj6ChtHuP68NKf
         /KfA==
X-Gm-Message-State: ABy/qLbYp/5nvv/hYoShltZ0chhSAUjSNIQ6muQd1Zb/ZpQ69YblB07Y
	W2udHw0g7vLTTG3si1g+qEhMRQ==
X-Google-Smtp-Source: APBJJlGCjLrz8H3xLH2x14w+MvjfgsC8U0tQjX/MTFt887k385qXdnC92hC6tULIF0jY3g+Vo6Dpjg==
X-Received: by 2002:a5d:6047:0:b0:316:e04a:29e8 with SMTP id j7-20020a5d6047000000b00316e04a29e8mr1699793wrt.54.1689947415101;
        Fri, 21 Jul 2023 06:50:15 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:14 -0700 (PDT)
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
Subject: [PATCH v3 2/6] can: tcan4x5x: Remove reserved register 0x814 from writable table
Date: Fri, 21 Jul 2023 15:50:05 +0200
Message-Id: <20230721135009.1120562-3-msp@baylibre.com>
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


