Return-Path: <netdev+bounces-23992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC67A76E6D7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4681C20F99
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619318B02;
	Thu,  3 Aug 2023 11:29:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1213FE3
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:28:59 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BCFE1981
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:28:57 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8Dxg_B4j8tkmqwPAA--.36499S3;
	Thu, 03 Aug 2023 19:28:56 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCN1j8tk4R1HAA--.33555S2;
	Thu, 03 Aug 2023 19:28:55 +0800 (CST)
From: Feiyang Chen <chenfeiyang@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: Feiyang Chen <chenfeiyang@loongson.cn>,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v3 00/16] stmmac: Add Loongson platform support
Date: Thu,  3 Aug 2023 19:28:02 +0800
Message-Id: <cover.1691047285.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxLCN1j8tk4R1HAA--.33555S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF4xJFWDCFWkAF4rJr1rXwc_yoW5CFWDpF
	9rAa4Ygr97Xr1xJ3Z3Jw1kXF95WayIqr45Ww4IqrsakFWxtr90qrnI9FWrtF17ZrWDZFya
	qr1UuwnxCF1qkwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend stmmac functions and macros for Loongson DWMAC.
Add LS7A support for dwmac_loongson.

v2 -> v3:
* Avoid macros accessing variables that are not passed to them.
* Implement a new struct to support 64-bit DMA.
* Use feature names rather than 'lgmac' and 'dwmac_is_loongson'.

Feiyang Chen (16):
  net: stmmac: Pass stmmac_priv and chan in some callbacks
  net: stmmac: dwmac1000: Allow platforms to choose some register
    offsets
  net: stmmac: dwmac1000: Add multi-channel support
  net: stmmac: dwmac1000: Add 64-bit DMA support
  net: stmmac: dwmac1000: Add Loongson register definitions
  net: stmmac: dwmac1000: Fix channel numbers for Loongson
  net: stmmac: dwmac1000: Add multiple retries for DMA reset
  net: stmmac: dwmac1000: Allow platforms to set control value
  net: stmmac: Allow platforms to set irq_flags
  net: stmmac: Add Loongson HWIF entry
  net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
  net: stmmac: dwmac-loongson: Add LS7A support
  net: stmmac: dwmac-loongson: Add 64-bit DMA and multi-vector support
  net: stmmac: dwmac-loongson: Disable flow control for GMAC
  net: stmmac: dwmac-loongson: Use single queue for GMAC
  net: stmmac: dwmac-loongson: Add GNET support

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  29 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
 drivers/net/ethernet/stmicro/stmmac/descs.h   |   7 +
 .../net/ethernet/stmicro/stmmac/descs_com.h   |  47 ++-
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 292 ++++++++++++++----
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  22 +-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  24 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 135 ++++++--
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |  12 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |  24 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  11 +-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  17 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  62 +---
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 244 +++++++++++++--
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  17 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  10 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  38 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  44 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  71 +++--
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  17 +-
 .../net/ethernet/stmicro/stmmac/ring_mode64.c | 159 ++++++++++
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  34 +-
 include/linux/stmmac.h                        |  70 +++++
 29 files changed, 1117 insertions(+), 304 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/ring_mode64.c

-- 
2.39.3


