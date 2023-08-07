Return-Path: <netdev+bounces-25091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924AE772EC3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE201C20CBF
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365B16414;
	Mon,  7 Aug 2023 19:35:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B915AEA
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:35:22 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A6171E
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:35:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so75951041fa.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436919; x=1692041719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e27wbiFJtLlf43t1k7vc8pvwOKH5unMgNn5Odb2O+Z8=;
        b=0ClHwQmDfHox7caha97lX3plPiiO9uO/nV4QJN2dkc8f/qkhCWBPsutilB3bREPHr4
         9NFno8L+SXRLiDnvRt+qNn8aqOk7Db8x1nMjFqMaRBuMB1Vj1nU2Uwi75BChTWV7tUQx
         7Hzzz871BHBcswazgRdh5hFNjOo0gA22e1zOHuIO+U4203plfrdrDIKkBPl9kmBMXktF
         gNJB6sNjiFc8O3jDztpnJuADTxxstNh0XKDuIQXel7XAX1teMKQnzdnB522fQMYeTDjH
         cswqB1b/e0c1/q28xCtpLeyOslraYAMkbS02ORfJGWYCuQgPrlMDaSt6g9T8NE/UYesB
         ECdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436919; x=1692041719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e27wbiFJtLlf43t1k7vc8pvwOKH5unMgNn5Odb2O+Z8=;
        b=NnieFqra9ch9kHFg8iuactLBOYOW1d4J3UqR942sWe+cD4RtNdrlEJz8+qzUvUBHEZ
         UIFITKNKwjA0w8sgyI/U9CQLQwqsa1MF6hmf9HynIYklCcUK3AEFZ/3SuEFqSmdJQlIA
         PPDTfYvh5apEQWDaDTJmvScR5n32W76SJnERwnYb25caklaCu4DiT9G2eXCzDrn7Aeja
         SJp8Bp7mFYtg1PFUclBl31GKsCUkEVlFCB/LUMVZXHxbHgUTYGaUXRaXtNX0JvppRXIc
         wMdqYnJmv21eS2Nlwljyt/RBFgzGrvIySkJKqCHGmubiHUnSaYxVjNzR2J9BJqq4txWG
         Gmuw==
X-Gm-Message-State: AOJu0YyoRLOOd05JLf4F26DjwRRHAFPT/h4aMJ8FhZxqYcVHz9Zjm2li
	Wr5RnNuMuMEnwCuOa/tZOn9Z0A==
X-Google-Smtp-Source: AGHT+IF792kTobb8MlI4iFxkIWn86W6q+R/OSGQFuQifwhPAUOuWr6eKA+8sKr0Z/k14NOqktWgXqQ==
X-Received: by 2002:a2e:7217:0:b0:2b9:cb2a:11bf with SMTP id n23-20020a2e7217000000b002b9cb2a11bfmr7483270ljc.49.1691436918813;
        Mon, 07 Aug 2023 12:35:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/9] arm64: dts: qcom: enable EMAC1 on sa8775p
Date: Mon,  7 Aug 2023 21:34:58 +0200
Message-Id: <20230807193507.6488-1-brgl@bgdev.pl>
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

This series contains changes required to enable EMAC1 on sa8775p-ride.

Bartosz Golaszewski (9):
  arm64: dts: qcom: sa8775p: add a node for the second serdes PHY
  arm64: dts: qcom: sa8775p: add a node for EMAC1
  arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
  arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet1
  arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of the
    PHY
  arm64: dts: qcom: sa8775p-ride: index the first SGMII PHY
  arm64: dts: qcom: sa8775p-ride: add the second SGMII PHY
  arm64: dts: qcom: sa8775p-ride: label the mdio node
  arm64: dts: qcom: sa8775p-ride: enable EMAC1

 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 116 ++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  43 ++++++++
 2 files changed, 152 insertions(+), 7 deletions(-)

-- 
2.39.2


