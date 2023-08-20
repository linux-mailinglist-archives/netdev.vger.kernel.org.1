Return-Path: <netdev+bounces-29158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD0781DB6
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F3A1C20862
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982F85670;
	Sun, 20 Aug 2023 12:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901723DE
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 12:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B3C433C7;
	Sun, 20 Aug 2023 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692533643;
	bh=IC8w578EAIZuY+94RdibA09oC+PtDBo0QtdFqUh+Eoc=;
	h=From:To:Cc:Subject:Date:From;
	b=e9ZZcIuUApBk3/DB9NX5MF3p32ExThYZkvRMnbluFlAdY1aeeaEuz1pLo9GSKmVDh
	 UUqiuVscsmqZqCwmK3KTZ9GEaZJ3/Pz7iepdYs0MoEjyq/ffILkkYcke7fdf2/tMDO
	 FZ/Xfw5h8SOsIoLRXITYJQ1kjR4fwy8GQLT8ce1BfZwuvMOOPG6kjn1T+Scz9gVSPJ
	 xjDzHwGnEqmYnPqAoe8D0O+5g04ZF977wMRCp+zLL7J6hthruWXb1wOlh5AmeeI46D
	 oeaHTaHfYc9qmcMAF8VPkQ16Ahm1qyNNgGvS4KBnIj30ev7qILkdeshYhyOm+TqmqL
	 hbWS/d9APZiyw==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 0/3] add the dwmac driver for T-HEAD TH1520 SoC
Date: Sun, 20 Aug 2023 20:02:10 +0800
Message-Id: <20230820120213.2054-1-jszhang@kernel.org>
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

Jisheng Zhang (3):
  dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
  dt-bindings: net: add T-HEAD dwmac support
  net: stmmac: add glue layer for T-HEAD TH1520 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 .../devicetree/bindings/net/thead,dwmac.yaml  |  87 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 304 ++++++++++++++++++
 5 files changed, 405 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c

-- 
2.40.1


