Return-Path: <netdev+bounces-200699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E950AE6911
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8654E3C6E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61B2D4B66;
	Tue, 24 Jun 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Linbs5zY"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F492D3A93;
	Tue, 24 Jun 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775615; cv=none; b=r5KF6MoHFsFnnFvm6Z9ogC6yCr+u5iAmzOD4zTUu2NdBezAdK0dAWIdzJXqYVrHHt4ayPJiaM34/Dbrir7+AvtgtqcuGCe05K0xQ56WsSHpE6ooZErZLZsjol5RnrGk23TvLbSfrceP4fKjDBGaBpw9O4Gr6q1wkB44OQFdwQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775615; c=relaxed/simple;
	bh=T4Clas5bzqxC87iLgxrgDlE8/O1YxVArn4WnJgBEpKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M4JVpLFlYjP/w/m0RimibXzZx7EBLbO83gHNjvBk1LgIaAM282t1PMe+/7vBaQdqm2Tx5och+5OpAMASI2JukY2faXTzXNAh2Tr/jLrHrh+mzpC+4+mPGsHLfDDvDd5WP6fxggndU4BQA9yrmsHqx8OsqNgpgNfC2BjzkKD0zBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Linbs5zY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775611;
	bh=T4Clas5bzqxC87iLgxrgDlE8/O1YxVArn4WnJgBEpKA=;
	h=From:To:Cc:Subject:Date:From;
	b=Linbs5zYmDSJ0zkA/iGPLy8OFrGC6fGw+57BQTCTC71zIlT3Nyk9QKUjc771ILAch
	 xd1yU/vY6b+L1qWFFhX3FzCv3EAuQzptiptko7Z02We/fYsC7GqOvM1OWzi4wdODs7
	 L4uCgp2C+KBU08/zwq4qzpKSpsW1GnXqvLiGvKuFAMFknMrRAvwjd4rqm6skxoYP4L
	 dTRLsL3gBzmexBaIKpLlFCixY+2E3SSEw9xrdbI72jjUm7F/Vu4IK5GQrT4ruwEh2Q
	 50Ft5IDSE4L9+tqDn75PrER9Sd0H36uY7GQ66tFtxrNwHrYrXZGmXuFH2RMKpeJP7a
	 KKLDdpwfyab5g==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 72BA217E0DE3;
	Tue, 24 Jun 2025 16:33:30 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: guangjie.song@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2 00/29] Add support for MT8196 clock controllers
Date: Tue, 24 Jun 2025 16:31:51 +0200
Message-Id: <20250624143220.244549-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for MT8196 clock controllers

This patch series introduces support for the clock controllers on the
MediaTek MT8196 platform, following up on an earlier submission[1].

MT8196 uses a hardware voting mechanism to control some of the clock muxes
and gates, along with a fence register responsible for tracking PLL and mux
gate readiness. The series introduces support for these voting and fence
mechanisms, and includes drivers for all clock controllers on the platform.

[1] https://lore.kernel.org/all/20250307032942.10447-1-guangjie.song@mediatek.com/

Changes in v2:
- Fixed incorrect ID numbering in mediatek,mt8196-clock.h
- Improved description for 'mediatek,hardware-voter' in mediatek,mt8196-clock.yaml and mediatek,mt8196-sys-clock.yaml
- Added description for '#reset-cells' in mediatek,mt8196-clock.yaml
- Added missing mediatek,mt8196-vdisp-ao compatible in mediatek,mt8196-clock.yaml
- Fixed license in mediatek,mt8196-resets.h
- Fixed missing of_match_table in clk-mt8196-vdisp_ao.c
- Squashed commit adding UFS and PEXTP reset controller support
- Reordered commits to place reset controller binding before dependent drivers
- Added R-b tags

Link to v1: https://lore.kernel.org/all/20250623102940.214269-1-laura.nao@collabora.com/

AngeloGioacchino Del Regno (1):
  dt-bindings: reset: Add MediaTek MT8196 Reset Controller binding

Laura Nao (28):
  clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable control
  clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and FENC
  clk: mediatek: clk-mux: Add ops for mux gates with set/clr/upd and
    FENC
  clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
  clk: mediatek: clk-mux: Add ops for mux gates with HW voter and FENC
  clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use
    mtk_gate struct
  clk: mediatek: clk-gate: Add ops for gates with HW voter
  clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
  dt-bindings: clock: mediatek: Describe MT8196 peripheral clock
    controllers
  clk: mediatek: Add MT8196 apmixedsys clock support
  clk: mediatek: Add MT8196 topckgen clock support
  clk: mediatek: Add MT8196 topckgen2 clock support
  clk: mediatek: Add MT8196 vlpckgen clock support
  clk: mediatek: Add MT8196 peripheral clock support
  clk: mediatek: Add MT8196 ufssys clock support
  clk: mediatek: Add MT8196 pextpsys clock support
  clk: mediatek: Add MT8196 adsp clock support
  clk: mediatek: Add MT8196 I2C clock support
  clk: mediatek: Add MT8196 mcu clock support
  clk: mediatek: Add MT8196 mdpsys clock support
  clk: mediatek: Add MT8196 mfg clock support
  clk: mediatek: Add MT8196 disp0 clock support
  clk: mediatek: Add MT8196 disp1 clock support
  clk: mediatek: Add MT8196 disp-ao clock support
  clk: mediatek: Add MT8196 ovl0 clock support
  clk: mediatek: Add MT8196 ovl1 clock support
  clk: mediatek: Add MT8196 vdecsys clock support
  clk: mediatek: Add MT8196 vencsys clock support

 .../bindings/clock/mediatek,mt8196-clock.yaml |   87 ++
 .../clock/mediatek,mt8196-sys-clock.yaml      |   81 ++
 drivers/clk/mediatek/Kconfig                  |   78 +
 drivers/clk/mediatek/Makefile                 |   14 +
 drivers/clk/mediatek/clk-gate.c               |  106 +-
 drivers/clk/mediatek/clk-gate.h               |    3 +
 drivers/clk/mediatek/clk-mt8196-adsp.c        |  193 +++
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c  |  203 +++
 drivers/clk/mediatek/clk-mt8196-disp0.c       |  169 +++
 drivers/clk/mediatek/clk-mt8196-disp1.c       |  170 +++
 .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    |  117 ++
 drivers/clk/mediatek/clk-mt8196-mcu.c         |  166 +++
 drivers/clk/mediatek/clk-mt8196-mdpsys.c      |  187 +++
 drivers/clk/mediatek/clk-mt8196-mfg.c         |  150 ++
 drivers/clk/mediatek/clk-mt8196-ovl0.c        |  154 ++
 drivers/clk/mediatek/clk-mt8196-ovl1.c        |  153 ++
 drivers/clk/mediatek/clk-mt8196-peri_ao.c     |  144 ++
 drivers/clk/mediatek/clk-mt8196-pextp.c       |  131 ++
 drivers/clk/mediatek/clk-mt8196-topckgen.c    | 1257 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8196-topckgen2.c   |  662 +++++++++
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c      |  109 ++
 drivers/clk/mediatek/clk-mt8196-vdec.c        |  253 ++++
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c    |   79 ++
 drivers/clk/mediatek/clk-mt8196-venc.c        |  235 +++
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c    |  769 ++++++++++
 drivers/clk/mediatek/clk-mtk.c                |   16 +
 drivers/clk/mediatek/clk-mtk.h                |   23 +
 drivers/clk/mediatek/clk-mux.c                |  119 +-
 drivers/clk/mediatek/clk-mux.h                |   76 +
 drivers/clk/mediatek/clk-pll.c                |   46 +-
 drivers/clk/mediatek/clk-pll.h                |    9 +
 .../dt-bindings/clock/mediatek,mt8196-clock.h |  867 ++++++++++++
 .../reset/mediatek,mt8196-resets.h            |   26 +
 33 files changed, 6828 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8196-adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mcu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-peri_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-pextp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen2.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ufs_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt8196-clock.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8196-resets.h

-- 
2.39.5


