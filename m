Return-Path: <netdev+bounces-172752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB85A55E4D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9639177E89
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2F14AD0D;
	Fri,  7 Mar 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fS9JxuYS"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08279DDC5;
	Fri,  7 Mar 2025 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318354; cv=none; b=tBdyWOSYNXotbgG/PD0DMrgPBYxRFtdNTxu5KqDWDj333JdzYXhEoD7psO8Oo9FyTSu8hVcbMyx5ozrzAF9GOedehixRLc+ZY5yCjD8j3TtAatDgaM9TxPs8aiywRzPcHLOPkGjwO/gpV+j6X9dpLLd9/dgqDVFSM+KDv7bWimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318354; c=relaxed/simple;
	bh=JgXvI8eby/pVJCPI3OtXr1NPnBv+rXku4TbyF2UNnt8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QqUaL+SPiTj0r3RJfRqUdIkATQwvE0ZTsv0Ht3pRZIDZvy1VosAzH3ckQoElacjmmwXA157IqBfWuslSqT95GD6UJF/7NiI2txIwPmfMQgxeBT08QRdIbbQpbMKb+ai+zsJew1AfRwYgynVSak90xSnUuISvtB9+nofQPFJkfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fS9JxuYS; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ca3e8e2cfb0411ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5frJAB9y8a+BiVXJdjweEmbFcW3Z5pKKgyZuRvk20D0=;
	b=fS9JxuYS0cWAjniF/aYx04gIMbRgUecBUrtMREHZ/ffQYNDxBcEf+XinHL9GzranUl5hBFOWSUXnVviVU4TVDP6PZtCqIIdSYVxvgFw+QM3J6UDHoXKZ6fEu4iv7ZIH7ImWfvCgNwjvv7tUaXuVq+T+YZl7dmxdAmmuGoOwd5Yw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:e7b909c0-bf0f-4ee5-a0fb-7c59aa875745,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:f226cc49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ca3e8e2cfb0411ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1685896031; Fri, 07 Mar 2025 11:32:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:32:25 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:32:24 +0800
From: Guangjie Song <guangjie.song@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Guangjie Song
	<guangjie.song@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 00/26] clk: mediatek: Add MT8196 clock support
Date: Fri, 7 Mar 2025 11:26:56 +0800
Message-ID: <20250307032942.10447-1-guangjie.song@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series is based on linux-next, tag: next-20250306.

Changes:
- Update clock driver for MT8196
- Add MT8196 clock support

Guangjie Song (26):
  clk: mediatek: Add defines for vote
  clk: mediatek: Support voting for pll
  clk: mediatek: Support voting for mux
  clk: mediatek: Support voting for gate
  clk: mediatek: Add gate ops without disable
  dt-bindings: clock: mediatek: Add new MT8196 clock
  clk: mediatek: Add MT8196 apmixedsys clock support
  clk: mediatek: Add MT8196 apmixedsys_gp2 clock support
  clk: mediatek: Add MT8196 topckgen clock support
  clk: mediatek: Add MT8196 topckgen2 clock support
  clk: mediatek: Add MT8196 vlpckgen clock support
  clk: mediatek: Add MT8196 peripheral clock support
  clk: mediatek: Add MT8196 adsp clock support
  clk: mediatek: Add MT8196 i2c clock support
  clk: mediatek: Add MT8196 mcu clock support
  clk: mediatek: Add MT8196 mdpsys clock support
  clk: mediatek: Add MT8196 mfg clock support
  clk: mediatek: Add MT8196 disp0 clock support
  clk: mediatek: Add MT8196 disp1 clock support
  clk: mediatek: Add MT8196 disp-ao clock support
  clk: mediatek: Add MT8196 ovl0 clock support
  clk: mediatek: Add MT8196 ovl1 clock support
  clk: mediatek: Add MT8196 pextpsys clock support
  clk: mediatek: Add MT8196 ufssys clock support
  clk: mediatek: Add MT8196 vdecsys clock support
  clk: mediatek: Add MT8196 vencsys clock support

 .../bindings/clock/mediatek,mt8196-clock.yaml |   66 +
 .../clock/mediatek,mt8196-sys-clock.yaml      |   63 +
 drivers/clk/mediatek/Kconfig                  |   78 +
 drivers/clk/mediatek/Makefile                 |   14 +
 drivers/clk/mediatek/clk-gate.c               |  236 ++-
 drivers/clk/mediatek/clk-gate.h               |    6 +
 drivers/clk/mediatek/clk-mt8196-adsp.c        |  291 ++++
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c  |  146 ++
 .../clk/mediatek/clk-mt8196-apmixedsys_gp2.c  |  154 ++
 drivers/clk/mediatek/clk-mt8196-disp0.c       |  247 +++
 drivers/clk/mediatek/clk-mt8196-disp1.c       |  260 +++
 .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    |  211 +++
 drivers/clk/mediatek/clk-mt8196-mcu.c         |  167 ++
 drivers/clk/mediatek/clk-mt8196-mdpsys.c      |  357 ++++
 drivers/clk/mediatek/clk-mt8196-mfg.c         |  143 ++
 drivers/clk/mediatek/clk-mt8196-ovl0.c        |  256 +++
 drivers/clk/mediatek/clk-mt8196-ovl1.c        |  255 +++
 drivers/clk/mediatek/clk-mt8196-peri_ao.c     |  218 +++
 drivers/clk/mediatek/clk-mt8196-pextp.c       |  162 ++
 drivers/clk/mediatek/clk-mt8196-topckgen.c    | 1373 +++++++++++++++
 drivers/clk/mediatek/clk-mt8196-topckgen2.c   |  701 ++++++++
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c      |  107 ++
 drivers/clk/mediatek/clk-mt8196-vdec.c        |  449 +++++
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c    |  100 ++
 drivers/clk/mediatek/clk-mt8196-venc.c        |  413 +++++
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c    |  777 +++++++++
 drivers/clk/mediatek/clk-mtk.h                |   10 +
 drivers/clk/mediatek/clk-mux.c                |  198 ++-
 drivers/clk/mediatek/clk-mux.h                |   79 +
 drivers/clk/mediatek/clk-pll.c                |   51 +-
 drivers/clk/mediatek/clk-pll.h                |    5 +
 include/dt-bindings/clock/mt8196-clk.h        | 1503 +++++++++++++++++
 32 files changed, 9086 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8196-adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys_gp2.c
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
 create mode 100644 include/dt-bindings/clock/mt8196-clk.h

-- 
2.45.2


