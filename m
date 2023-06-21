Return-Path: <netdev+bounces-12518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6D737EFE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B4D1C20BC0
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01899D2F3;
	Wed, 21 Jun 2023 09:31:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5971C8DA
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:31:11 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C4170C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3110a5f2832so5359899f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339868; x=1689931868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnoYzlqcpbqIFDX/QCzP0DM0XYhA9I/O0wRSd0b2d80=;
        b=OKCgz0VaMI1Fv6yd2XldHp/3Alw1/cS1VYDm4ECvg32UV+E10/b7GlASd5Luv4QTDe
         gl7+Y2+pMX7ebU1ik0S+/Bfjt+amyNuaVDzBp9q1dQm8nFS470hJzdR7tZXyr6Q4x5fN
         yy4l8FtsayAy/qYIK/O4ngS4Z8pBog+1eRV8Um2eyVNWrMK0IbXKS858U0IWVV4eTRw9
         sr7aBZXPzwDkEI7pzvxZQqaGXD45sobVdOJ+U7xJMGNTAwX13i+wjEefT/9ctkCN8KjB
         7ZStrac+Cl8yc2N9adH9Rcz9ni7eoCebFDY12q/U9V52Id688qhVzmdepEW+oLWS+tbE
         n0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339868; x=1689931868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnoYzlqcpbqIFDX/QCzP0DM0XYhA9I/O0wRSd0b2d80=;
        b=ZOv72kEPcR44r08LZolty2fRdnYZIH7TIdl1Xt6HllOZZveYRstHNj/l8jiQUcZnjS
         ULFQFqeaPNMmbpGWpNhwZpPiVqsnEBfK5lj2WxG8/ZWtef4oZKpHN8zq43tb3NIwEnnw
         cF+5THo1v1DjoyP+vhhC3g+WA5JqBwnpYmVJTgLvsYYNoK4GtL/1QrgLPcisfx56b5WD
         oAB7woNx5RkQtV0OgEO8YUNDj32As3Y2g6jsmPKrhXOEUtBnOkPtyeI04wbXRWZgGmyG
         6wQBcv0tp4poVUt7YGoALsOZWWyP9EHuSqMknmLOZLWROKaM//+ev5TT0EzM7z+UzYcD
         7Bpg==
X-Gm-Message-State: AC+VfDyK+O4zkfsGur+icISB+K6oU40fED9jsU5jQTmpjJAJHquCvMEN
	hASVaBgOewQfAcFWt6yev15O7Q==
X-Google-Smtp-Source: ACHHUZ6wNggPJlaWNtBCFb85tB2zyBb3w5c/2/L22CBkW3973Qtp0kgzE6fLsZu8EOuufjAe/NANWQ==
X-Received: by 2002:a5d:4203:0:b0:311:1107:9aba with SMTP id n3-20020a5d4203000000b0031111079abamr13408111wrq.19.1687339868152;
        Wed, 21 Jun 2023 02:31:08 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:07 -0700 (PDT)
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
Subject: [PATCH v2 0/6] can: tcan4x5x: Introduce tcan4552/4553
Date: Wed, 21 Jun 2023 11:30:57 +0200
Message-Id: <20230621093103.3134655-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
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

Hi everyone,

This series introduces two new chips tcan-4552 and tcan-4553. The
generic driver works in general but needs a few small changes. These are
caused by the removal of wake and state pins.

In v2 I updated the bindings to use tcan4x5x always as a fallback. The
driver now uses the first more specific binding if available. If the
given binding does not match the chip that is present, a warning is
printed and the correct driver data is loaded instead.

Based on v6.4-rc1.

Best,
Markus

Changes in v2:
- Update the binding documentation to specify tcan4552 and tcan4553 with
  the tcan4x5x as fallback
- Update the driver to use auto detection as well. If compatible differs
  from the ID2 register, use the ID2 register and print a warning.
- Small style changes

Previous versions:
v1 - https://lore.kernel.org/lkml/20230314151201.2317134-1-msp@baylibre.com

Markus Schneider-Pargmann (6):
  dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
  can: tcan4x5x: Remove reserved register 0x814 from writable table
  can: tcan4x5x: Check size of mram configuration
  can: tcan4x5x: Rename ID registers to match datasheet
  can: tcan4x5x: Add support for tcan4552/4553
  can: tcan4x5x: Add error messages in probe

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  11 +-
 drivers/net/can/m_can/m_can.c                 |  16 ++
 drivers/net/can/m_can/m_can.h                 |   1 +
 drivers/net/can/m_can/tcan4x5x-core.c         | 161 ++++++++++++++----
 drivers/net/can/m_can/tcan4x5x-regmap.c       |   1 -
 5 files changed, 155 insertions(+), 35 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1


