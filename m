Return-Path: <netdev+bounces-25088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB72772EB7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FD61C20CC4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC11640F;
	Mon,  7 Aug 2023 19:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E5FBFD
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:31:36 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD371171A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:31:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso42090425e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436692; x=1692041492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRSwV6Gm+XzxbXgNMBpKpDlEh6gTRS+MFq99dQgncbQ=;
        b=mHrDzRq+wq6uTZHPmwteMcteTqBarR3Nk2/LC+UMcpxDdpyYVB/0FPzO+LDxTTbbNr
         hRhzkXWggtKCLT4xwA7fIp3dNwm5RWOSGd3w4YU41OwbdBx+3TsaQno03l0rK33u9g29
         Mm3pzAcNw4BPYcA6KtUHgbmxynAXxh683LDni4HrDhgv95CoIFLQOyru7phiWKQkGpPI
         LecLAQigg50nsbneHX72Bl9nT/Umvd5U9X6d/NHRYZWJrzCXRsQ0oxSGLsRB6I04PHxm
         pomhLzO6E0p/XZZ9ABl879hBlfPQi9HFO3KNgYy1Nc8E7e3gSGuQk5OWV4X7lV4DBs+G
         oFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436692; x=1692041492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRSwV6Gm+XzxbXgNMBpKpDlEh6gTRS+MFq99dQgncbQ=;
        b=DZQQrlCOf4KFmf8vKjQ8eHI+9aZ0XDUwUGvkRfRHLhA6No0ts9U1bOUeC5bFBxte2a
         nCBCeKheRT2MF+s2NXIIcDxjSkkYj28bSYIB70L8Jrz2QCG4UNXlD8zLcseUQS+hTozg
         Izj/IsBrDLLw8dq9qdNbcsKZW2J6AUVEWZ4COjCi+i7Ro1r29Krl6rE1BPtkVzbfxg//
         7FC8lOzTRTh4kGnkOhx+nggUE7/hWEoiFTldnodIRRjlAN0AiHq3p96CfG6ugNKpetle
         E5hjkudv/FtA02SPnYhB301Aus2YosiaM7AXPGbbXZrXJmFqqyKAN88IWeQG/1HDyAlX
         qudg==
X-Gm-Message-State: AOJu0Yy+am1S/3oBMxJxWF4LHQhGEWQ6k//MDpRNpq5YiQ5Btbltbs61
	lHs3zENkVunEizFKngXzduDZ6Q==
X-Google-Smtp-Source: AGHT+IHcrhdGZU6crsuk18nFD4cu1qWw7VPP+T0+AdP+h8J/EgCXLVdYCouqFEEXXaCm890UjwpwOg==
X-Received: by 2002:a1c:740b:0:b0:3fe:5053:1a0b with SMTP id p11-20020a1c740b000000b003fe50531a0bmr4034769wmc.11.1691436692253;
        Mon, 07 Aug 2023 12:31:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003fbdbd0a7desm15985654wmj.27.2023.08.07.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:31:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
Date: Mon,  7 Aug 2023 21:31:00 +0200
Message-Id: <20230807193102.6374-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Two MACs may share MDIO lines to the PHYs. Let's allow that in the
stmmac driver by providing a new device-tree property allowing one MAC
node to reference the MDIO bus defined on a second MAC node.

Bartosz Golaszewski (2):
  dt-bindings: net: snps,dwmac: document the snps,shared-mdio property
  net: stmmac: support shared MDIO

 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c     | 8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 6 ++++++
 include/linux/stmmac.h                                | 1 +
 4 files changed, 21 insertions(+)

-- 
2.39.2


