Return-Path: <netdev+bounces-265513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sErvJOe4rmlIIQIAu9opvQ
	(envelope-from <netdev+bounces-265513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:11:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB7523887F
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2393136077
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8313B8BB8;
	Mon,  9 Mar 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AKvJ37bA"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242553ACEFE;
	Mon,  9 Mar 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057933; cv=none; b=XraWPBkTkDYDE1lapBnn6/20Wkeq9Z1Ya3fxemphu6rLAoVJsj7mI8z/oxZzu4Qll7iJ+1qzTYqoo6fGdfXObNT8fx7EczJc5Y8VsJTn3IG4o5UZY1Gynwf5cSx5JxxDMaM/6fi0kEkhCejoNqD3Lg3OazoIRUnSFrgVFqLnz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057933; c=relaxed/simple;
	bh=QLveIigjhxPqL/YVu60mXEqkSJpmaqP4Atla9AJ4hyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IrHi142fsU0cbTE2HfJ2gqBTO1lY7LpuSpBVrLVhQKAXftQRox10lFAyDTjYOOqPvnoWwFkewUHdJCK7KUXxER2WOeacnDJd1AY0eLVr78CakTPnnJFkbImj3Qjf/SF2qCJfdBiNG7KdNioQQJPkg7N8pU+ldkbiYxDFapi41jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AKvJ37bA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3da1a4ae1bb011f1a39cd589f645bc18-20260309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pPARNu+0u9rW2dCNxPaaClv6sW4fWs5sF+Cv2x5ixCQ=;
	b=AKvJ37bA2Gw3VJ54SeFAbdGnyShvUNa/jaelGh5ePlm5Nxf7wV+Psa4tG9/KithVh1IHtQB5QADUvl+vH5eKQfk3sBl0W/NmgoH7R47ivyjbkzOdRnWhK25UK2H2TRWnUBiu/b3Xkot4Oq/BxrGOvQKtuSWfb9kWC3ON8kz6t8o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:68cc09d6-7eb9-41c9-b505-b894fa5ce071,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:15de085c-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3da1a4ae1bb011f1a39cd589f645bc18-20260309
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2102891407; Mon, 09 Mar 2026 20:05:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 20:05:17 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Mar 2026 20:05:17 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Cochran
	<richardcochran@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu
 Tsai <wenst@chromium.org>, Miles Chen <miles.chen@mediatek.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Qiqi Wang
	<qiqi.wang@mediatek.com>, <sirius.wang@mediatek.com>,
	<vince-wl.liu@mediatek.com>, <jh.hsu@mediatek.com>,
	<irving-ch.lin@mediatek.com>
Subject: [PATCH v6 00/18] Add support for MT8189 clock controller
Date: Mon, 9 Mar 2026 20:04:42 +0800
Message-ID: <20260309120512.3624804-1-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: DCB7523887F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265513-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irving-ch.lin@mediatek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Changes since v6:
- vowpll/aud_adc_ext are fixed clocks in dts, remove from bindings.
- Remove unused clocks (clk_vlp_sej_13m, clk_vlp_sej_26m)
- Fix confused naming: vlpcfg and vlpcfg-ao
- Correct naming in vlp-clk driver: vlp_fmipi_csi_up26m, vlp_pwrap_ulposc_sel

Changes since v5:
- Remove redundant 'binding', 'definition' in commit message.
- Remove MT8189 dt-schema, merged into common (apmixed, topckgen, syscon ...).
- Separates power domain patches to another series.

Changes since v4:
- Fix dt_binding_check warning.
- Check prepare_enable before set_parent to ensure our reference clock is ready.
- Enable fhctl in apmixed driver.
- Refine clock drivers: 
  - Change subsys name, regs base/size (clock related part, instead of whole subsys).
  - Simply code with GATE_MTK macro.
  - Add MODULE_DEVICE_TABLE, MODULE_DESCRIPTION
  - Register remove callback mtk_clk_simple_remove.
  - Remove most of CLK_OPS_PARENT_ENABLE and CLK_IGNORE_UNUSED which may block bringup,
      but some subsys will power off before we disable unused clocks, so still need here.  

changes since v3:
- Add power-controller dt-schema to mediatek,power-controller.yaml.
- Separates clock commit to small parts (by sub-system).
- Change to mtk-pm-domains for new MTK pm framework.

changes since v2:
- Fix dt-schema checking fails
- Merge dt-binding files and dt-schema files into one patch.
- Add vendor information to dt-binding file name.
- Remove NR define in dt-binding header.
- Add struct member description.

  This series add support for the clock controllers
of MediaTek's new SoC, MT8189. With these changes,
other modules can easily manage clock resources
using standard Linux APIs, such as the Common Clock Framework (CCF).

Irving-CH Lin (18):
  dt-bindings: clock: Add MediaTek MT8189 clock
  clk: mediatek: clk-mux: Make sure bypass clk enabled while setting MFG
    rate
  clk: mediatek: Add MT8189 apmixedsys clock support
  clk: mediatek: Add MT8189 topckgen clock support
  clk: mediatek: Add MT8189 vlpckgen clock support
  clk: mediatek: Add MT8189 vlpcfg clock support
  clk: mediatek: Add MT8189 bus clock support
  clk: mediatek: Add MT8189 cam clock support
  clk: mediatek: Add MT8189 dbgao clock support
  clk: mediatek: Add MT8189 dvfsrc clock support
  clk: mediatek: Add MT8189 i2c clock support
  clk: mediatek: Add MT8189 img clock support
  clk: mediatek: Add MT8189 mdp clock support
  clk: mediatek: Add MT8189 mfg clock support
  clk: mediatek: Add MT8189 dispsys clock support
  clk: mediatek: Add MT8189 scp clock support
  clk: mediatek: Add MT8189 ufs clock support
  clk: mediatek: Add MT8189 vcodec clock support

 .../bindings/clock/mediatek,apmixedsys.yaml   |    1 +
 .../bindings/clock/mediatek,infracfg.yaml     |    1 +
 .../bindings/clock/mediatek,pericfg.yaml      |    1 +
 .../bindings/clock/mediatek,syscon.yaml       |   27 +
 .../bindings/clock/mediatek,topckgen.yaml     |    2 +
 drivers/clk/mediatek/Kconfig                  |  146 +++
 drivers/clk/mediatek/Makefile                 |   14 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c  |  192 ++++
 drivers/clk/mediatek/clk-mt8189-bus.c         |  196 ++++
 drivers/clk/mediatek/clk-mt8189-cam.c         |  108 ++
 drivers/clk/mediatek/clk-mt8189-dbgao.c       |   94 ++
 drivers/clk/mediatek/clk-mt8189-dispsys.c     |  172 +++
 drivers/clk/mediatek/clk-mt8189-dvfsrc.c      |   54 +
 drivers/clk/mediatek/clk-mt8189-iic.c         |  118 ++
 drivers/clk/mediatek/clk-mt8189-img.c         |  107 ++
 drivers/clk/mediatek/clk-mt8189-mdpsys.c      |   91 ++
 drivers/clk/mediatek/clk-mt8189-mfg.c         |   53 +
 drivers/clk/mediatek/clk-mt8189-scp.c         |   73 ++
 drivers/clk/mediatek/clk-mt8189-topckgen.c    | 1020 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8189-ufs.c         |   89 ++
 drivers/clk/mediatek/clk-mt8189-vcodec.c      |   93 ++
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c      |  111 ++
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c    |  280 +++++
 drivers/clk/mediatek/clk-mux.c                |    9 +-
 .../dt-bindings/clock/mediatek,mt8189-clk.h   |  577 ++++++++++
 25 files changed, 3627 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dbgao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dispsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dvfsrc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-iic.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-ufs.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt8189-clk.h

-- 
2.45.2


