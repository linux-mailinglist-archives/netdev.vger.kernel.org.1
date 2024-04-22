Return-Path: <netdev+bounces-89986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643498AC751
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB171C20DEA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B1A51C34;
	Mon, 22 Apr 2024 08:46:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59A51C23
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775588; cv=none; b=tVIla0xaijgFjtKVTUSRJdguB8b0i9xfFqGcgx9FvIlPeYxuZrxaPEY6cHisthhV9bNgsjz8NF1eMjpwU7nrBcf/e7HWuIaFS4n8XZw0yDiTfXWPRzvnlGskCZrXjdDzwQpVx2qxABCNw+9OsQ+umOgPqRt+rcM/ZBb5GUfXIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775588; c=relaxed/simple;
	bh=ogSLbt7Encj8rgVX9Gt1hy8GweRcMDYi4zjkFZ+QSFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rwBHUjU8Gmjv6FFWDNKzL8HLvICSclmBRBRClAD+XS9g8MrwOAGpVy/9CfYuQCKO8PcH7VEA9erp1RLP/k6zTN5RoFwzYH7+mI+kuT4wBNxiliN/B/pDHGHhE0V1jfZS9OJARaWVl67EyeevoZW5oAH2Je20DEH7d/t2m80G/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rypJd-0000ML-BZ; Mon, 22 Apr 2024 10:46:21 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH 0/3] arm64: mx93: etherrnet: set TX_CLK in RMII mode
Date: Mon, 22 Apr 2024 10:46:16 +0200
Message-Id: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgjJmYC/x3MMQqEMBAF0KvI1A6YMSzqVcRC4+zuLzSaSBDEu
 xssX/MuihqgkbrioqAJEX7NMGVB7j+uP2XM2SSV2MqKcPpwy4ff4BjL2dasu48cFoDrUdxkxbj
 GzJSDLegX55v3w30/Y2IXDWwAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Linux Team <linux-imx@nxp.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.13.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This series adds support for setting the TX_CLK direction in the eQOS
ethernet core on the i.MX93 when RMII mode is used.

According to AN14149, when the i.MX93 ethernet controller is used in
RMII mode, the TX_CLK *must* be set to output mode. 

Add a devicetree property with the register to set this bit and parse it
in the dwmac-imx driver.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Steffen Trumtrar (3):
      dt-bindings: net: mx93: add enet_clk_sel binding
      arm64: dts: imx93: add enet_clk_sel
      net: stmicro: imx: set TX_CLK direction in RMII mode

 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     | 10 ++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi           |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    | 27 ++++++++++++++++++++++
 3 files changed, 38 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240422-v6-9-topic-imx93-eqos-rmii-3a2cb421c81d

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


