Return-Path: <netdev+bounces-50285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E97F5435
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 00:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AF028150A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 23:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F324A1EB4E;
	Wed, 22 Nov 2023 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdDYayGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030A0191
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:09:14 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b063a6420dso8984639f.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700694553; x=1701299353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zZ8JfNM2OMcgGqYzXA4poHKbJA5XfysSinrC2/AyhA=;
        b=jdDYayGdZgMUaezeNXDhadUTmPAgbIyiPX1K/D8ryz/xR2RSW2+Y4P8E3DGCAwNjaN
         rqxRV5EM1dx1ad9o71rpzRW3kGNQ/9E3jenb5pYu5VjpWrSaC8kcsJhBK9DmplaMi9l9
         Vutvfn+yIVigWCmzLsXMzy6NksTE4jIRcPWRJTIEA9Gv/yk+YxqJ25cs4ZrUOBq9gp8t
         2SBT3jPONXVuPcQAkoYPyE2rHh9cnGZe7NZp39kTeprt2czeXbgzWph8A5KEEjdPJXhh
         9WcJn2l3DZrZBcrAeWP3ngwsVJs5sTHjGWCEO/KrnfKIz6LLAS1oPDU3wHaoL+bZT8tc
         8etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694553; x=1701299353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zZ8JfNM2OMcgGqYzXA4poHKbJA5XfysSinrC2/AyhA=;
        b=VNFwcAMadtF7PxUwqjUQ+j3WnJORpV7xDTS5+uCP0DGza5IZmuTtoGXqKEQMqHoXYd
         ZD0XLUrzeXGhvrxf5piY5keieLR4g7ziK685dUt3GSppSHtAOLaOE7DzgvAWpzYHQ4eo
         jXxJrYqt5Rq0IGIRZ6/meYh3rjvDX9X7JjPtOcZKk45qrIiHueHC7/tNIjkRM84mJOTW
         l4IxRiyvCOg1L9wTDf37WXrzDbx78teEsR9j2H2mWnfzSNw3UAkoYJQi3UOYX2sV3vY2
         0T9/r32vRRmyNcW7nvWWrkmWmKCpRBdjq904pQZjizx9QVyBQ8z1HP6xt5BqQ+vlU5T4
         Nydw==
X-Gm-Message-State: AOJu0YzBaSRin0YEd6N0/pDbMb5Wxa0fLYCBMPsZ/UBW8IFiZbw49asS
	jEMQd6dlYBRRQuKKdWPgXdJywQ==
X-Google-Smtp-Source: AGHT+IGfvFvNtX9o31O98ivh6qmCBRyGBdUZt6yHaaXOlhuOzKQhxaFCldwPqv8IM4y4OZJkMkipuQ==
X-Received: by 2002:a05:6602:4f03:b0:79d:1b4e:fb8a with SMTP id gl3-20020a0566024f0300b0079d1b4efb8amr813367iob.9.1700694553309;
        Wed, 22 Nov 2023 15:09:13 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id fm29-20020a0566382b1d00b0043a20ad93c8sm117754jab.41.2023.11.22.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:09:12 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	agross@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mka@chromium.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: ipa: add IPA v5.5 support
Date: Wed, 22 Nov 2023 17:09:04 -0600
Message-Id: <20231122230909.895482-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds IPA support for the Qualcomm SM8550 SoC, which uses
IPA v5.5.

The first patch adds a new compatible string for the SM8550.  The
second cleans up "ipa_reg.h" a bit for consistency.  The third patch
adds definitions and some minor code changes related to IPA v5.5.
The fourth defines IPA register offsets and fields used for IPA
v5.0; most--but not all--register definitions are the same as used
in IPA v5.0.  The final patch adds configuration data used for IPA
v5.5 (here again this mostly duplicates IPA v5.0 definitions).

					-Alex

Alex Elder (5):
  dt-bindings: net: qcom,ipa: add SM8550 compatible
  net: ipa: update IPA version comments in "ipa_reg.h"
  net: ipa: prepare for IPA v5.5
  net: ipa: add IPA v5.5 register definitions
  net: ipa: add IPA v5.5 configuration data

 .../devicetree/bindings/net/qcom,ipa.yaml     |   1 +
 drivers/net/ipa/Makefile                      |   4 +-
 drivers/net/ipa/data/ipa_data-v5.5.c          | 487 +++++++++++++++
 drivers/net/ipa/gsi_reg.c                     |   1 +
 drivers/net/ipa/ipa_data.h                    |   1 +
 drivers/net/ipa/ipa_main.c                    |  13 +-
 drivers/net/ipa/ipa_mem.c                     |   2 +-
 drivers/net/ipa/ipa_reg.c                     |   6 +-
 drivers/net/ipa/ipa_reg.h                     | 111 ++--
 drivers/net/ipa/ipa_version.h                 |   1 +
 drivers/net/ipa/reg/ipa_reg-v5.5.c            | 565 ++++++++++++++++++
 11 files changed, 1130 insertions(+), 62 deletions(-)
 create mode 100644 drivers/net/ipa/data/ipa_data-v5.5.c
 create mode 100644 drivers/net/ipa/reg/ipa_reg-v5.5.c

-- 
2.34.1


