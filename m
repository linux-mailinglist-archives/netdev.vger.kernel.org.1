Return-Path: <netdev+bounces-216483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BE3B34024
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC013B59B9
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D8E258EE1;
	Mon, 25 Aug 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wp4RD6ok"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60923507E;
	Mon, 25 Aug 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126540; cv=none; b=GAz5C48K8fkykUD7knuuLBdpXnVH2jK7GCqfoXozoH/0aPErs2l2mc6TEGHjf6/huLDbtSxoCjVh5ZV02ShcnaI5s0m/U1Z0kXg1RTid1Dl9jdJbggMQ+LlGqvKsJC09Sa7HOCHs9LMSH319RuuX4TEzbzy0RkjzQgPSmcid0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126540; c=relaxed/simple;
	bh=jVaErzpkbBb5kQVUHxnb7jL9Y9M/5d+ZZP5UlZ/Us0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpMfxjqmE/jgrFiR+vMtHmw3OrXcxvtwejHpuD5Yfp+SnebDwfZyHMJguD/cD1ZeRCNntHVT/N+v8ho/qAJwDvS1QwjA6h6TXqDbUvBiSBtya3O0/53kAZRby8xDDHuy4D6yGx71Er5k3DokKhP7SPB38UmgpqvUqeg6DrGsbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wp4RD6ok; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756126536;
	bh=jVaErzpkbBb5kQVUHxnb7jL9Y9M/5d+ZZP5UlZ/Us0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wp4RD6okHgd1+oa9kr5BJhRxkSudWhgt0gxErtIF77SMtmVowdSnjBKcTMOgz6q6Q
	 c+ouGWUc0V3qil0CbYY6Jc83PP6hUVrH0bndU7BzUTpTC963gXN4/moGlaTUM1ZHl7
	 YXZYhRlwOoQ7pLpLcWhWQcOa5uIGY0hGBj9AcQn7Lsy72M/NL4QchXTSyHzFGsLMp7
	 8+fMnQwO90GamZEfsguUuxCJTIPjbU5DcXUOHMvWwglpOkPTwK4sihrVg5lkTu1+VS
	 Aqk1s+4WCAf/KLOMF+oTKCU8kwDQsm4OMpANbNMf/ut573xmTDIa4NnIXfJ6HVV54j
	 JV5/PnGHw5vkg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:b1df:895a:e67b:5cd4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 31E3D17E0478;
	Mon, 25 Aug 2025 14:55:35 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: wenst@chromium.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	guangjie.song@mediatek.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	netdev@vger.kernel.org,
	nfraprado@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v4 15/27] clk: mediatek: Add MT8196 ufssys clock support
Date: Mon, 25 Aug 2025 14:54:25 +0200
Message-Id: <20250825125425.210123-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5GH6ypcuXn9+XED7du_CJaeDs3M1ODjtN7pDH_FA0gmjg@mail.gmail.com>
References: <CAGXv+5GH6ypcuXn9+XED7du_CJaeDs3M1ODjtN7pDH_FA0gmjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/15/25 05:50, Chen-Yu Tsai wrote:
> On Tue, Aug 5, 2025 at 10:55 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> Add support for the MT8196 ufssys clock controller, which provides clock
>> gate control for UFS.
>>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>  drivers/clk/mediatek/Kconfig             |   7 ++
>>  drivers/clk/mediatek/Makefile            |   1 +
>>  drivers/clk/mediatek/clk-mt8196-ufs_ao.c | 109 +++++++++++++++++++++++
>>  3 files changed, 117 insertions(+)
>>  create mode 100644 drivers/clk/mediatek/clk-mt8196-ufs_ao.c
>>
>> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
>> index 1e0c6f177ecd..d99c39a7f10e 100644
>> --- a/drivers/clk/mediatek/Kconfig
>> +++ b/drivers/clk/mediatek/Kconfig
>> @@ -1010,6 +1010,13 @@ config COMMON_CLK_MT8196
>>         help
>>           This driver supports MediaTek MT8196 basic clocks.
>>
>> +config COMMON_CLK_MT8196_UFSSYS
>> +       tristate "Clock driver for MediaTek MT8196 ufssys"
>> +       depends on COMMON_CLK_MT8196
>> +       default COMMON_CLK_MT8196
>> +       help
>> +         This driver supports MediaTek MT8196 ufssys clocks.
>> +
>>  config COMMON_CLK_MT8365
>>         tristate "Clock driver for MediaTek MT8365"
>>         depends on ARCH_MEDIATEK || COMPILE_TEST
>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>> index 8888ffd3d7ba..1a497de00846 100644
>> --- a/drivers/clk/mediatek/Makefile
>> +++ b/drivers/clk/mediatek/Makefile
>> @@ -153,6 +153,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
>>  obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
>>                                    clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o \
>>                                    clk-mt8196-peri_ao.o
>> +obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
>>  obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
>>  obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
>>  obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
>> diff --git a/drivers/clk/mediatek/clk-mt8196-ufs_ao.c b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
>> new file mode 100644
>> index 000000000000..858706b3ba6f
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt8196-ufs_ao.c
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2025 MediaTek Inc.
>> + *                    Guangjie Song <guangjie.song@mediatek.com>
>> + * Copyright (c) 2025 Collabora Ltd.
>> + *                    Laura Nao <laura.nao@collabora.com>
>> + */
>> +#include <dt-bindings/clock/mediatek,mt8196-clock.h>
>> +#include <dt-bindings/reset/mediatek,mt8196-resets.h>
>
> Nit: add empty line here for separation.
>

Ack.

>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-gate.h"
>> +#include "clk-mtk.h"
>> +
>> +#define MT8196_UFSAO_RST0_SET_OFFSET   0x48
>> +#define MT8196_UFSAO_RST1_SET_OFFSET   0x148
>> +
>> +static const struct mtk_gate_regs ufsao0_cg_regs = {
>> +       .set_ofs = 0x108,
>> +       .clr_ofs = 0x10c,
>> +       .sta_ofs = 0x104,
>> +};
>> +
>> +static const struct mtk_gate_regs ufsao1_cg_regs = {
>> +       .set_ofs = 0x8,
>> +       .clr_ofs = 0xc,
>> +       .sta_ofs = 0x4,
>> +};
>> +
>> +#define GATE_UFSAO0(_id, _name, _parent, _shift) {     \
>> +               .id = _id,                              \
>> +               .name = _name,                          \
>> +               .parent_name = _parent,                 \
>> +               .regs = &ufsao0_cg_regs,                \
>> +               .shift = _shift,                        \
>> +               .flags = CLK_OPS_PARENT_ENABLE,         \
>
> This probably doesn't work correctly, since not every clock defined
> below has the "ufs" clock as its parent. If the requirement is that
> the "ufs" clock be enabled for accessing this register, it is going
> to fail (badly).
>

Thanks for pointing this out - I missed this because, as you noted,
other drivers using this flag defined gates with the same parent and
worked correctly (i.e., I2C). I don’t have a way to justify keeping this
flag at the moment, and I can’t test whether the ufs clock is required
for register access at this stage of upstream support (same goes for the
other drivers with this issue).

I’m thinking of removing it here and in the other affected drivers, and
revisit the issue once we have actual users for these clocks upstream.

Best,

Laura

> ChenYu
>
>> +               .ops = &mtk_clk_gate_ops_setclr,        \
>> +       }
>> +
>> +#define GATE_UFSAO1(_id, _name, _parent, _shift) {     \
>> +               .id = _id,                              \
>> +               .name = _name,                          \
>> +               .parent_name = _parent,                 \
>> +               .regs = &ufsao1_cg_regs,                \
>> +               .shift = _shift,                        \
>> +               .flags = CLK_OPS_PARENT_ENABLE,         \
>> +               .ops = &mtk_clk_gate_ops_setclr,        \
>> +       }
>> +
>> +static const struct mtk_gate ufsao_clks[] = {
>> +       /* UFSAO0 */
>> +       GATE_UFSAO0(CLK_UFSAO_UFSHCI_UFS, "ufsao_ufshci_ufs", "ufs", 0),
>> +       GATE_UFSAO0(CLK_UFSAO_UFSHCI_AES, "ufsao_ufshci_aes", "aes_ufsfde", 1),
>> +       /* UFSAO1 */
>> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_TX_SYM, "ufsao_unipro_tx_sym", "clk26m", 0),
>> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_RX_SYM0, "ufsao_unipro_rx_sym0", "clk26m", 1),
>> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_RX_SYM1, "ufsao_unipro_rx_sym1", "clk26m", 2),
>> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_SYS, "ufsao_unipro_sys", "ufs", 3),
>> +       GATE_UFSAO1(CLK_UFSAO_UNIPRO_SAP, "ufsao_unipro_sap", "clk26m", 4),
>> +       GATE_UFSAO1(CLK_UFSAO_PHY_SAP, "ufsao_phy_sap", "clk26m", 8),
>> +};
>> +
>> +static u16 ufsao_rst_ofs[] = {
>> +       MT8196_UFSAO_RST0_SET_OFFSET,
>> +       MT8196_UFSAO_RST1_SET_OFFSET
>> +};
>> +
>> +static u16 ufsao_rst_idx_map[] = {
>> +       [MT8196_UFSAO_RST0_UFS_MPHY] = 8,
>> +       [MT8196_UFSAO_RST1_UFS_UNIPRO] = 1 * RST_NR_PER_BANK + 0,
>> +       [MT8196_UFSAO_RST1_UFS_CRYPTO] = 1 * RST_NR_PER_BANK + 1,
>> +       [MT8196_UFSAO_RST1_UFSHCI] = 1 * RST_NR_PER_BANK + 2,
>> +};
>> +
>> +static const struct mtk_clk_rst_desc ufsao_rst_desc = {
>> +       .version = MTK_RST_SET_CLR,
>> +       .rst_bank_ofs = ufsao_rst_ofs,
>> +       .rst_bank_nr = ARRAY_SIZE(ufsao_rst_ofs),
>> +       .rst_idx_map = ufsao_rst_idx_map,
>> +       .rst_idx_map_nr = ARRAY_SIZE(ufsao_rst_idx_map),
>> +};
>> +
>> +static const struct mtk_clk_desc ufsao_mcd = {
>> +       .clks = ufsao_clks,
>> +       .num_clks = ARRAY_SIZE(ufsao_clks),
>> +       .rst_desc = &ufsao_rst_desc,
>> +};
>> +
>> +static const struct of_device_id of_match_clk_mt8196_ufs_ao[] = {
>> +       { .compatible = "mediatek,mt8196-ufscfg-ao", .data = &ufsao_mcd },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_ufs_ao);
>> +
>> +static struct platform_driver clk_mt8196_ufs_ao_drv = {
>> +       .probe = mtk_clk_simple_probe,
>> +       .remove = mtk_clk_simple_remove,
>> +       .driver = {
>> +               .name = "clk-mt8196-ufs-ao",
>> +               .of_match_table = of_match_clk_mt8196_ufs_ao,
>> +       },
>> +};
>> +
>> +module_platform_driver(clk_mt8196_ufs_ao_drv);
>> +MODULE_DESCRIPTION("MediaTek MT8196 ufs_ao clocks driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.39.5
>>

