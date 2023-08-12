Return-Path: <netdev+bounces-27051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD477A0A3
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DA81C208F6
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912C7496;
	Sat, 12 Aug 2023 15:12:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACB29AC
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 15:12:02 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE40171B;
	Sat, 12 Aug 2023 08:12:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26837895fbbso2001720a91.3;
        Sat, 12 Aug 2023 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691853121; x=1692457921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLJorMlL6hfqjCM48v52PYqEdNPQtxhp1HCXAeYBAoM=;
        b=FdObHNE2jednt/gMSOvuljKxBw5KmUvVCylKbyUD+D4afoeky1RIpGWnqTOlZrgY6R
         bf+P5UNIHEb8tMBUmVYAdC+OhqtZwHR07AmKp/ZRvZkU3Jt4juX8aKfKVniZMDQL1Z96
         CRec6p08c/9YPPJGw5fcdYu1oSA2A+ulrkxDm7FKcMJ8MKUzUcFEhv34lsqNUuOL2UNs
         oxjNitu5MAOt1IWOIyLFg7oMaQqRuEOEGUMH8gAtaO2H+WkMxIxMrR9rIUjRiVKwMzRZ
         YL4ZVBK32rQm/nUxfUgaUTo9WG4rotLHOC03nEuX/gmFe3tEFT+G1U9/YIo4dYZcNamd
         tgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853121; x=1692457921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLJorMlL6hfqjCM48v52PYqEdNPQtxhp1HCXAeYBAoM=;
        b=d6zd0k+jyfRz3dEmLOF6whm+rn3Q+mPeOpfEnOEDzNX4EvHP0cISVQqBCET2xRiXHp
         4q89FyUijTqzQnCpshK+DPckp6IbCo0ZKiJrJW7juKg7SX4Wu2eZvnPKj/fiEIO1dhKC
         lTkrwEtd4uiCet7zwThCnqIiUGnSn9xc9dnSep5f22Jc4BQF3R5ZA3XqbgisNT40eQs4
         cDZZj0DyWIGgMxRkVxsjuikSJ54c0ywc9btjKndvxOBre19Cj203/At33U8ngDeoLUXJ
         EMGh1BxvUvmTsI/srQbjbjkrSTmJc3JKeVz2FFAObn7M2gfFgZH446JzQ0DkzmBEtEEF
         BR0g==
X-Gm-Message-State: AOJu0YzSZrLQm52z9o5jPYzgSZgc9dJcgclCQFzCcJt0ZEt4//PaG7cj
	AGfTfdwbH6a/B8SX0OATRkDiJKkv4xQWh05n
X-Google-Smtp-Source: AGHT+IEqP+xKIcFC285EPyhVzS2Z6SWw7VLVDaiMxz4bWKwdsTAFaf210apQ45+cIXlxaG7AI+ompg==
X-Received: by 2002:a17:90a:4f4a:b0:268:5477:811c with SMTP id w10-20020a17090a4f4a00b002685477811cmr4445249pjl.23.1691853120729;
        Sat, 12 Aug 2023 08:12:00 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0026b41363887sm1040927pjh.27.2023.08.12.08.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:12:00 -0700 (PDT)
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
	Kelvin Zhang <kelvin.zhang@amlogic.com>
Subject: [PATCH 0/5] Move Loongson1 MAC arch-code to the driver dir
Date: Sat, 12 Aug 2023 23:11:30 +0800
Message-Id: <20230812151135.1028780-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kelvin Zhang <kelvin.zhang@amlogic.com>

In order to convert Loongson1 MAC platform devices to the devicetree
nodes, Loongson1 MAC arch-code should be moved to the driver dir.
    
In other words, this patchset is a preparation for converting
Loongson1 platform devices to devicetree.

Keguang Zhang (5):
  MIPS: loongson32: Remove Loongson1 MAC arch-code
  dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
  dt-bindings: net: Add Loongson-1 DWMAC glue layer
  net: stmmac: Add glue layer for Loongson-1 SoC
  MAINTAINERS: Add entry for Loongson-1 DWMAC

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/net/loongson,ls1x-dwmac.yaml     |  98 +++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 MAINTAINERS                                   |   2 +
 arch/mips/loongson32/common/platform.c        | 127 ++-------
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 257 ++++++++++++++++++
 8 files changed, 396 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c


base-commit: 21ef7b1e17d039053edaeaf41142423810572741
-- 
2.39.2


