Return-Path: <netdev+bounces-12520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF6737F01
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CF31C20DC2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78700DDC6;
	Wed, 21 Jun 2023 09:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D958DDB0
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:31:14 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA1170C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3111547c8f9so6627350f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339871; x=1689931871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOPR69iAQ16PRI3TWa1E2gZcgSDBVpUe2mB3Tg7XdFY=;
        b=p6VfhCsZ1XQVk+UFLTJRo9cf3iTipfn7+MBuZGX/3xu99DkZWmG8tzt/4QEiu0vdoP
         SwlKwJZpil8SEzBGic9Sdgl41L2ROAyA7fjHmwCysGNFyiJ2HXeo4xDhFyiizQzpbGAb
         pFEwDePat4OO5iNIvyfT6kCa1Y1wwPfNVqWTUay+XSTDaay8iLXaiNAWpNJosnHvR002
         85B6egNdHCN4pFH1hnrVd2eyXbxaTHobsIy0GYO0HIrF0qrfTKXUZWMqa3bWv6qy4XO8
         Fmtgt9r0knq3H5Xf8bnbXgXrDmp7C2UqP5JkHSCkA99CZSH22vhgwzEkEOE5iahxQgJf
         FIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339871; x=1689931871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOPR69iAQ16PRI3TWa1E2gZcgSDBVpUe2mB3Tg7XdFY=;
        b=Rms+y5bhKU6GdDJCNKubwU8Z4lpESJb5Cw9XDBWnuGZActfQJ3NOCkmobARqe1dWr6
         JD0VD8+7sMYi1dmN3Eywa4OS2SwsHMQ1ZipA4J92/I4PRPhWnecTL8MzApOT/rgHc4m5
         3jRU28x2Owd2YUR5uzBCEGPtWoHe9WtefjuEwCovjak+qNJnP7nEIzKp3SRuyF9hk5IM
         Y1OlE48IMR+DKLb7ZJM8Y3SdAQhZf5Db218QtK/GdOftsHuBxTfw7MkMwqDJGx5dHIxq
         63/VGtgTFGIsZiUDwQ7okQpk61gSrvHQAes/oyhV6odu3nYYsNRxuldPS/k3AiIlS2tl
         052w==
X-Gm-Message-State: AC+VfDxdh8CzjcMBxkAVlf24xPnEIpa4/I9aEV1Y9a9t3pLhnyrbO9d5
	u/P+TAw0jPWVtbzaPIUVcURPIw==
X-Google-Smtp-Source: ACHHUZ7h1oBelfPdJ7hS0YJrsBMI7+8RNi0jGbeXTETw7BrgmXNO4eGVgr+m/lxb6bEa7Izo9X0Sqw==
X-Received: by 2002:adf:f287:0:b0:311:13e6:650a with SMTP id k7-20020adff287000000b0031113e6650amr12500326wro.28.1687339870910;
        Wed, 21 Jun 2023 02:31:10 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:10 -0700 (PDT)
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
Subject: [PATCH v2 2/6] can: tcan4x5x: Remove reserved register 0x814 from writable table
Date: Wed, 21 Jun 2023 11:30:59 +0200
Message-Id: <20230621093103.3134655-3-msp@baylibre.com>
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


