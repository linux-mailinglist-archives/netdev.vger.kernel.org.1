Return-Path: <netdev+bounces-214535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDFEB2A0FA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990D01677C0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDAF31B118;
	Mon, 18 Aug 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CvmXqL0O"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1282E2294;
	Mon, 18 Aug 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518286; cv=none; b=DgHcqYmpQvABdglbb6Bp15Y3NRTIgjEZ6Owctctsm+50ItbZVWHUiv64H/b8ZKtUDNkgKeSjy1OCBD6TT//2u6XrsJb9i5X5KeJvHcxiFUVpLK0ylrktOnZ+Q3ZMGNBxLSs8LXna8YAPt03LrCtcHEp/D3jI2S7cw2U1JScSrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518286; c=relaxed/simple;
	bh=TVRZMAbNVyyIk82oxbfugOOVa3TQd+8b4kXoms3jR+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4FMNwmFAAGddTaCZ7FXdKaHPQIH8VCmz4x1eYPW4+HiVHkLRN25XTIQIqhUnBgz+mlBz1kHUdCa7AY1zVPcyzZmHDhf6NFzKsPYKyxDSthlIpjSEPdCTY4/mOn9K52m+yzpXRP4myjgH81tlHyh9f3AGdKDgl3mRtYlU5UM1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CvmXqL0O; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 96b1b7307c2a11f08729452bf625a8b4-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qWZS1ci7G5AfzBbzO520BxelfuqLdpolcZxGM7GsT28=;
	b=CvmXqL0OFSnN0gLIRkF9aHEEAM14rnllARUV6eGbc2I0C9QtNicBnChy8/2M3rMNaE9gxqS/L2kUfFBkVUT0uqwR0AFjJTuQl/ZAP53SzVK+Y639VPB4gHgLU0qapmFuyfWB5MeFtk19kR7uej2hXYvBkNuhQesrH++U9PFlpNA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:1b736701-d055-4afc-9dbb-9c63157dbbcd,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:f1326cf,CLOUDID:d90c417a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 96b1b7307c2a11f08729452bf625a8b4-20250818
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1801225720; Mon, 18 Aug 2025 19:58:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 19:57:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 19:57:59 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Richard Cochran <richardcochran@gmail.com>
CC: Qiqi Wang <qiqi.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <irving-ch.lin@mediatek.com>
Subject: [PATCH 0/6] Add support for MT8189 clock/power controller
Date: Mon, 18 Aug 2025 19:57:28 +0800
Message-ID: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

These patches add support for the clock and power controllers
of MediaTek's new SoC, MT8189. With these changes,
other modules can easily manage clock and power resources
using standard Linux APIs, such as the Common Clock Framework (CCF)
and pm_runtime on MT8189 platform.

Irving-ch Lin (6):
  dt-bindings: clock: mediatek: Add new MT8189 clock
  dt-bindings: power: mediatek: Add new MT8189 power
  dt-bindings: clock: mediatek: Add MT8189 clock definitions
  dt-bindings: power: mediatek: Add MT8189 power domain definitions
  clk: mediatek: Add clock drivers for MT8189 SoC
  pmdomain: mediatek: Add power domain driver for MT8189 SoC

 .../bindings/clock/mediatek,mt8189-clock.yaml |   89 ++
 .../clock/mediatek,mt8189-sys-clock.yaml      |   58 +
 .../mediatek,mt8189-power-controller.yaml     |   94 ++
 drivers/clk/mediatek/Kconfig                  |  146 +++
 drivers/clk/mediatek/Makefile                 |   14 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c  |  135 +++
 drivers/clk/mediatek/clk-mt8189-bus.c         |  289 +++++
 drivers/clk/mediatek/clk-mt8189-cam.c         |  131 ++
 drivers/clk/mediatek/clk-mt8189-dbgao.c       |  115 ++
 drivers/clk/mediatek/clk-mt8189-dvfsrc.c      |   61 +
 drivers/clk/mediatek/clk-mt8189-iic.c         |  149 +++
 drivers/clk/mediatek/clk-mt8189-img.c         |  122 ++
 drivers/clk/mediatek/clk-mt8189-mdpsys.c      |  100 ++
 drivers/clk/mediatek/clk-mt8189-mfg.c         |   56 +
 drivers/clk/mediatek/clk-mt8189-mmsys.c       |  233 ++++
 drivers/clk/mediatek/clk-mt8189-scp.c         |   92 ++
 drivers/clk/mediatek/clk-mt8189-topckgen.c    | 1059 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8189-ufs.c         |  106 ++
 drivers/clk/mediatek/clk-mt8189-vcodec.c      |  119 ++
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c      |  145 +++
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c    |  280 +++++
 drivers/clk/mediatek/clk-mux.c                |    4 +
 drivers/pmdomain/mediatek/mt8189-scpsys.h     |   75 ++
 drivers/pmdomain/mediatek/mtk-scpsys.c        |  957 ++++++++++++++-
 include/dt-bindings/clock/mt8189-clk.h        |  612 ++++++++++
 include/dt-bindings/power/mt8189-power.h      |   38 +
 26 files changed, 5237 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dbgao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dvfsrc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-iic.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mmsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-ufs.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpckgen.c
 create mode 100644 drivers/pmdomain/mediatek/mt8189-scpsys.h
 create mode 100644 include/dt-bindings/clock/mt8189-clk.h
 create mode 100644 include/dt-bindings/power/mt8189-power.h

-- 
2.45.2


