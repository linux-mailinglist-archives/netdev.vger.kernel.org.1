Return-Path: <netdev+bounces-30908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3055C789C9C
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4B51C20968
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933625665;
	Sun, 27 Aug 2023 09:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F580B
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 09:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062BDC433C8;
	Sun, 27 Aug 2023 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693128540;
	bh=2eeq+7FRTyNfKeldAGasRv6sGX46OUHFmY+FSc4kENM=;
	h=From:To:Cc:Subject:Date:From;
	b=rX4IAGxD/LlIE/VrRxKItRZANI9+BMo5JoQ76E40dvbNge7TqlAp6AYk0OWg7w/z4
	 6WDtsPb7+ThXUVk0Tv198kiRMI1UyfZOJyqMd+s0P6hHO+G01RgZowgDd9sfL3lZL2
	 x4CkPFs+zdmHL7gVz/qlWxJTDgt8wcag23/aIHhqs1tQyb2a48oE4sydFd8OxyKFYS
	 mQvkkTnsEkhHqpNX9G2gHRtWTzxv0im8M9yzzrYp5hhEYibeaKpOa6ooxMR8MfqIc9
	 t9p6cLbYIIshVGUPAYWZm/5BNpfspq00ZU5Nl46pXWDGUyZ2OxQRBW6ScwQvlbZ1qE
	 y/ke+YhkqSXxg==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
	Coquelin@web.codeaurora.org, Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH net-next v2 0/3] add the dwmac driver for T-HEAD TH1520 SoC
Date: Sun, 27 Aug 2023 17:17:07 +0800
Message-Id: <20230827091710.1483-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the dwmac driver support for T-HEAD TH1520 SoC.

Since the clk part isn't mainlined, so SoC dts(i) changes are not
included in this series. However, it can be tested by using fixed-clock.

Since v1:
  - rebase on the lastest net-next
  - collect Reviewed-by tag
  - address Krzysztof's comment of the dt binding
  - fix "div is not initialised" issue pointed out by Simon

Jisheng Zhang (3):
  dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
  dt-bindings: net: add T-HEAD dwmac support
  net: stmmac: add glue layer for T-HEAD TH1520 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 .../devicetree/bindings/net/thead,dwmac.yaml  |  77 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 302 ++++++++++++++++++
 5 files changed, 393 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c

-- 
2.40.1


