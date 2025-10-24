Return-Path: <netdev+bounces-232510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782EC061E5
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F983B6F14
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF8314D06;
	Fri, 24 Oct 2025 11:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF936314A79
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306627; cv=none; b=h+SjxShN4/yvVH9XOKU82fq/xMgspEOsc6bbH2c9RztIbepf6umWdiiwB7I59kLf1mpOt6/b/IgtoMcJSwzzRDNWJlpcT6WfNhuZ4UawBVY3OF3QyToIuqiJiugL5WIRpogzLAQ46F2odn6ZtlerqM62PQvuC2k12lDxkqI5t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306627; c=relaxed/simple;
	bh=BzGWGbSx3ob/YoIpU5YipTn7h7I3mfIONsr2QxsFfEc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xz4k8iZg4s+1KCjuTrbLqVpIzDIvdY7AoOexQGw+/FzJM7l7JJx8ZsE0FHLxZdRnqB6nzg0MuxuLfd2L6gq288hGuNjdP5DWFsCAemOWC11dsUxC39WFqMWCQsGEnkvCbd+0ryekyLofDDQevaIfe06sEMlQIbpZ/V785j7MXEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vCGJ3-0002FG-Sl; Fri, 24 Oct 2025 13:50:05 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v5 00/10] arm64: dts: socfpga: agilex5: enable network and
 add new board
Date: Fri, 24 Oct 2025 13:49:52 +0200
Message-Id: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBn+2gC/43Ny27DIBCF4VeJWJdqGMwlXfU9qi4wDA5SZSxwk
 avI714SqcqiUdPlfxbfObNKJVFlL4czK9RSTXnuoZ4OzJ/cPBFPoTdDwEGABN40F8jXvCTPa/Z
 xmRx3U/qgTfEjxCCDjUcLnnVhKRTTdtXf3nufUl1z+bqeNXFZ/+c2wYGPOGpjLJAGel1onj7Xk
 ue0PQdiF7zhDRSo/gaxg1YPqDR5b0a8C8obiPAAlB1EZ32IRkYF7i44/IAKHoJDB2mMYIAQjIq
 /wH3fvwGz4zOWvgEAAA==
X-Change-ID: 20241030-v6-12-topic-socfpga-agilex5-90fd3d8f980c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Teoh Ji Sheng <ji.sheng.teoh@intel.com>, 
 Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>, 
 Austin Zhang <austin.zhang@intel.com>, 
 "Tham, Mun Yew" <mun.yew.tham@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add an initial devicetree for a new board (Arrow AXE5-Eagle) and all
needed patches to support the network on current mainline.

Currently only QSPI and network are functional as all other hardware
currently lacks mainline support.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v5:
- remove binding conversion
- rebase to 6.18-rc1
- add sofpga_agilex5.dtsi patches
- add stmmac patches
- add dwxgmac compatible to have usable network
- Link to v4: https://lore.kernel.org/r/20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de

Changes in v4:
- extract gmii-to-sgmii-converter binding to pcs subdir
- fix dt_binding_check warnings
- rebase to v6.13-rc1
- Link to v3: https://lore.kernel.org/r/20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de

Changes in v3:
- add socfpga-stmmac-agilex5 compatible
- convert socfpga-dwmac.txt -> yaml
- add Acked-bys
- rebase to v6.13-rc1
- Link to v2: https://lore.kernel.org/r/20241125-v6-12-topic-socfpga-agilex5-v2-0-864256ecc7b2@pengutronix.de

Changes in v2:
- fix node names according to dtb_check
- remove gpio 'status = disabled'
- mdio0: remove setting of adi,[rt]x-internal-delay-ps. 2000 is the
  default value
- add Acked-by to dt-binding
- Link to v1: https://lore.kernel.org/r/20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de

---
Adrian Ng Ho Yin (1):
      arm64: dts: socfpga: agilex5: Add SMMU node

Austin Zhang (1):
      arm64: dts: socfpga: agilex5: smmu enablement

Steffen Trumtrar (6):
      net: stmmac: dwmac-socfpga: don't set has_gmac
      dt-bindings: net: altr,socfpga-stmmac: add generic dwxgmac compatible
      arm64: dts: socfpga: agilex5: add dwxgmac compatible
      dt-bindings: net: altr,socfpga-stmmac: allow dma-coherent property
      dt-bindings: intel: add agilex5-based Arrow AXE5-Eagle
      arm64: dts: socfpga: agilex5: initial support for Arrow AXE5-Eagle

Teoh Ji Sheng (1):
      net: stmmac: Use interrupt mode INTM=1 for per channel irq

Tham, Mun Yew (1):
      arm64: dts: socfpga: agilex5: dma coherent enablement for XGMACs

 .../devicetree/bindings/arm/intel,socfpga.yaml     |   1 +
 .../bindings/net/altr,socfpga-stmmac.yaml          |   4 +
 arch/arm64/boot/dts/intel/Makefile                 |   1 +
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     |  31 ++++-
 .../boot/dts/intel/socfpga_agilex5_axe5_eagle.dts  | 146 +++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   1 -
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   3 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  10 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  20 +++
 include/linux/stmmac.h                             |   2 +
 10 files changed, 214 insertions(+), 5 deletions(-)
---
base-commit: f67859cf0b6d21bf3641e7dec9e99edba91e0829
change-id: 20241030-v6-12-topic-socfpga-agilex5-90fd3d8f980c

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


