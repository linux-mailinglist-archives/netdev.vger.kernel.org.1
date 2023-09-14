Return-Path: <netdev+bounces-33797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53A7A02F6
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9132C1F23052
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098791D68F;
	Thu, 14 Sep 2023 11:45:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87A1D68C;
	Thu, 14 Sep 2023 11:45:07 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBB1FCA;
	Thu, 14 Sep 2023 04:45:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso664725b3a.0;
        Thu, 14 Sep 2023 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691907; x=1695296707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DOlydW7mn7Eara9saftmS/8t4g8SJw5aUgoksQq/RQ=;
        b=dBcjJEeYctd/ryYdnFJUNdh02lp2yYGFmn6KrpCKaOTTd0onXcR8ckxkksTFAv9n97
         udr/VzvH8V2LyBXVvrPc+zGnrpYeW81aRw12YN1WIGhte7LL+Z9mDd+m+F1RYJCPFAig
         n634fy9pc7U2o+hqgtYRckUmazRz4M1ODmyTeZpUxDGX/6bxHLupkE6P0CstDX3ffRIG
         hHoN7NmGMDWhb+6o5Yzj4kENqrQ5UTcnhWe+lOM4VnCOfryHZpPWCrZDX9lsLZDRkUOP
         /l9l6lwXfXXUVNciG1ptY6dspmcTzVfWOyQtwVAbPcXIr9uFqK6bjBuXaH+H+pLdidWN
         J7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691907; x=1695296707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DOlydW7mn7Eara9saftmS/8t4g8SJw5aUgoksQq/RQ=;
        b=DCJjw5oQhD+ySE9XGw6jovfC88ZEc2JY0xrMaFruymAw7dim3TLHWCdyH4rbgvzCHY
         8QhNNhgmaFsKfDeqefyXK/uNdrHTZ5YN5uCYwv2o7226JdPms/ZsxZSnOx917NxSzo2R
         PosQbxqNi8YvZzDnYvzhKA7XbW9yHoJsWSwM3MqugqlmiOFKNACuhSedCNBVrmErpNVf
         lAOiPeFtC1LnuXbcRCLgVIyTwNeLsIZtSCMIzpUE80HAPsjt4rCUiJ++yjabWCn07euN
         vzl6Bj1h+nrCEpcSqwZiPV9tFujbOJyJWCfc0nholJJLNkW1RhZrZi9WmB10iA1zKUvO
         0dWA==
X-Gm-Message-State: AOJu0Yzadz7YxSXPwvrIRSlMaO62zQP3n2FhiV/Ut0zxFjeQnpLXbIKZ
	c64E/EzkTGTH4TCGBMODhhDh4SDJ7x8dMwOT
X-Google-Smtp-Source: AGHT+IEp12w5aRWDEpuTqUbw3Gy+YGb+WayObgIwJpqieuUkUj7qh+v8b+o2Dhezz6KRbmsi9rCR4Q==
X-Received: by 2002:a05:6a20:8f1e:b0:153:a00b:dca0 with SMTP id b30-20020a056a208f1e00b00153a00bdca0mr6186671pzk.11.1694691906763;
        Thu, 14 Sep 2023 04:45:06 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001b9cea4e8a2sm1388570pll.293.2023.09.14.04.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:45:06 -0700 (PDT)
From: Keguang Zhang <keguang.zhang@gmail.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
Date: Thu, 14 Sep 2023 19:44:33 +0800
Message-Id: <20230914114435.481900-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914114435.481900-1-keguang.zhang@gmail.com>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Loongson LS1B and LS1C compatibles for system controller.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V4 -> V5: None
V3 -> V4: Add Acked-by tag from Krzysztof Kozlowski
V2 -> V3: Change compatibles back to loongson,ls1b-syscon
          and loongson,ls1c-syscon
V1 -> V2: Make the syscon compatibles more specific

 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 8103154bbb52..c77d7b155a4c 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -49,6 +49,8 @@ properties:
               - hisilicon,peri-subctrl
               - hpe,gxp-sysreg
               - intel,lgm-syscon
+              - loongson,ls1b-syscon
+              - loongson,ls1c-syscon
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
-- 
2.39.2


