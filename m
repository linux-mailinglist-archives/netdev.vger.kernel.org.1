Return-Path: <netdev+bounces-47029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAC7E7A77
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9948B20E1C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4781079C;
	Fri, 10 Nov 2023 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3BD307
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:09:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1AFDD091
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:09:09 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8AxlPAz801lpbI4AA--.46117S3;
	Fri, 10 Nov 2023 17:09:07 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxE+Qt801lQ_Y9AA--.6266S2;
	Fri, 10 Nov 2023 17:09:02 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	fancer.lancer@gmail.com,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	guyinggang@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v5 0/9] stmmac: Add Loongson platform support
Date: Fri, 10 Nov 2023 17:08:44 +0800
Message-Id: <cover.1699533745.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxE+Qt801lQ_Y9AA--.6266S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXryUAFW8tw1DCr4rtr4UKFX_yoW5Xw18pF
	y7Aa4Yqr97tr1xA3Z5Jw1DXF95Gay3tr43Wa1SvrnakaySkryqqrya9FWFqF17ArZ8ZFy2
	qr1UCw1DCF1qkrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

v4 -> v5:

* Remove an ugly and useless patch (fix channel number).
* Remove the non-standard dma64 driver code, and also remove
  the HWIF entries, since the associated custom callbacks no
  longer exist.
* Refer to Serge's suggestion: Update the dwmac1000_dma.c to
  support the multi-DMA-channels controller setup.

See:
v4: <https://lore.kernel.org/loongarch/cover.1692696115.git.chenfeiyang@loongson.cn/>
v3: <https://lore.kernel.org/loongarch/cover.1691047285.git.chenfeiyang@loongson.cn/>
v2: <https://lore.kernel.org/loongarch/cover.1690439335.git.chenfeiyang@loongson.cn/>
v1: <https://lore.kernel.org/loongarch/cover.1689215889.git.chenfeiyang@loongson.cn/>

Yanteng Si (9):
  net: stmmac: Pass stmmac_priv and chan in some callbacks
  net: stmmac: Allow platforms to set irq_flags
  net: stmmac: Add Loongson DWGMAC definitions
  net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
  net: stmmac: dwmac-loongson: Add full PCI support
  net: stmmac: dwmac-loongson: Add MSI support
  net: stmmac: dwmac-loongson: Add GNET support
  net: stmmac: dwmac-loongson: Disable flow control for GMAC
  net: stmmac: Disable coe for some Loongson GNET

 .../net/ethernet/stmicro/stmmac/chain_mode.c  |   5 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 324 ++++++++++++++----
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  22 +-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |   9 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  71 +++-
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |   9 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  11 +-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  17 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  62 +++-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  44 +--
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  17 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  10 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  17 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  10 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  71 ++--
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  17 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  30 +-
 include/linux/stmmac.h                        |   4 +
 25 files changed, 563 insertions(+), 219 deletions(-)

-- 
2.31.4


