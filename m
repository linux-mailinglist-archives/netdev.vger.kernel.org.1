Return-Path: <netdev+bounces-147203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 277709D8418
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 12:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E56CB30680
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0152194C7D;
	Mon, 25 Nov 2024 10:33:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7219258E
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530820; cv=none; b=Z1VyUUUCGac1/FlTfsDHWnms1sa3GlfGQbTe+JwA/DGHn0Tif+PolfqOZqpBIwjDkVM0zJLPOdp3Xa0AtASE54cwyFnJGEoZnnL3KnndWmQYFi9TEtxImwklocRJuHaWshaTpSmwUn3M8pNpgSCnu30GN4A94qdxZtNiEjgSjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530820; c=relaxed/simple;
	bh=gCRzn4LNOBE5nMygWBX5OlLmC+fRJ/rT8vbWN7CMr/4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E30u0zIXv3Q83Bi1q0MPS4S9STonhUPgsBldauj4c2OHmRFBCUMGcC8GbISNYqdazxri7ZDkueaau9N2EijnwBFH0w6JothTzdiL9zo3B0w83OHAuhcLEYMyzbswcN9XwVptwaaGPGtYCWZ+RleRj9/ELTJYiS91CwTx1/kGJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tFWPO-0001Fo-Oi; Mon, 25 Nov 2024 11:33:34 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 0/4] ARM64: dts: intel: agilex5: add nodes and new board
Date: Mon, 25 Nov 2024 11:33:19 +0100
Message-Id: <20241125-v6-12-topic-socfpga-agilex5-v2-0-864256ecc7b2@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG9SRGcC/43NTQ7CIBCG4asY1o4ZqPbHlfcwXbQw0ElMIVBJT
 dO7iz2By+dbvN8mEkWmJO6nTUTKnNjPBep8EnoaZkfAplgoVFeJFUKuQSpYfGANyWsb3ACD4xe
 tN+jQmsq0tmtRi1IIkSyvR/3ZF0+cFh8/x1mWv/W/bpaAMKqxbpoWqUZ6BJrde4l+5vViSPT7v
 n8BNcoDkcsAAAA=
X-Change-ID: 20241030-v6-12-topic-socfpga-agilex5-90fd3d8f980c
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-clk@vger.kernel.org, kernel@pengutronix.de, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This series adds the gpio0 and gmac nodes to the socfpga_agilex5.dtsi.

An initial devicetree for a new board (Arrow AXE5-Eagle) is also added.
Currently only QSPI and network are functional as all other hardware
currently lacks mainline support.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
- fix node names according to dtb_check
- remove gpio 'status = disabled'
- mdio0: remove setting of adi,[rt]x-internal-delay-ps. 2000 is the
  default value
- add Acked-by to dt-binding
- Link to v1: https://lore.kernel.org/r/20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de

---
Steffen Trumtrar (4):
      arm64: dts: agilex5: add gpio0
      arm64: dts: agilex5: add gmac nodes
      dt-bindings: intel: add agilex5-based Arrow AXE5-Eagle
      arm64: dts: agilex5: initial support for Arrow AXE5-Eagle

 .../devicetree/bindings/arm/intel,socfpga.yaml     |   1 +
 arch/arm64/boot/dts/intel/Makefile                 |   1 +
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     | 106 ++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_axe5_eagle.dts  | 140 +++++++++++++++++++++
 4 files changed, 248 insertions(+)
---
base-commit: adc218676eef25575469234709c2d87185ca223a
change-id: 20241030-v6-12-topic-socfpga-agilex5-90fd3d8f980c

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


