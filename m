Return-Path: <netdev+bounces-29561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110B783D18
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF89281048
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE88F71;
	Tue, 22 Aug 2023 09:40:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA78F6E
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:40:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FC2CCA
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:40:33 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
	by gateway (Coremail) with SMTP id _____8Ax1fCQguRkp98aAA--.54795S3;
	Tue, 22 Aug 2023 17:40:32 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yOOguRkTzVgAA--.63227S2;
	Tue, 22 Aug 2023 17:40:31 +0800 (CST)
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
	guyinggang@loongson.cn,
	siyanteng@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v4 00/11] stmmac: Add Loongson platform support
Date: Tue, 22 Aug 2023 17:40:25 +0800
Message-Id: <cover.1692696115.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx3yOOguRkTzVgAA--.63227S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF47WF4kKr15Cw4kKrW8KrX_yoWrXrWxpF
	Z7Aa4Yvr97tr1xJ3WfJw18XF95Ga4Iqr45Ww1Ivr4S9a92kr90qrnI9FW5JF17ArWDX3W2
	qr1UuwnrCF1DCrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_WrPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add and extend stmmac functions and macros for Loongson DWMAC.
Add LS7A support and GNET support for dwmac_loongson.

Split the code for extended GMAC (dwegmac) from dwmac1000, try
not to mix up registers and core id.

Some features of Loongson platforms are bound to the GMAC_VERSION
register. We have to read its value in dwmac-loongson in order to
get the correct channel number and DMA configuration.

The current usage of stmmac_request_irq_multi_msi() is limited to
dwmac-intel. While it appears that setting irq_flags might not be
necessary for dwmac-intel, it should be configured for other drivers
like dwmac-loongson. I've observed many drivers directly setting
irq_flags within their probe functions or data structures without
referencing the DT. Since I'm unsure about the proper handling of
irq_flags, I've chosen to retain the code as-is.

Feiyang Chen (11):
  net: stmmac: Pass stmmac_priv and chan in some callbacks
  stmmac: dwmac1000: Add 64-bit DMA support
  stmmac: Add extended GMAC support for Loongson platforms
  net: stmmac: Allow platforms to set irq_flags
  net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
  net: stmmac: dwmac-loongson: Add LS7A support
  net: stmmac: dwmac-loongson: Add 64-bit DMA and MSI support
  net: stmmac: dwegmac: Fix channel numbers
  net: stmmac: dwmac-loongson: Disable flow control for GMAC
  net: stmmac: dwegmac: Disable coe
  net: stmmac: dwmac-loongson: Add GNET support

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  29 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
 drivers/net/ethernet/stmicro/stmmac/descs.h   |   7 +
 .../net/ethernet/stmicro/stmmac/descs_com.h   |  47 +-
 drivers/net/ethernet/stmicro/stmmac/dwegmac.h | 332 +++++++++++
 .../ethernet/stmicro/stmmac/dwegmac_core.c    | 552 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwegmac_dma.c | 522 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwegmac_dma.h | 190 ++++++
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 338 ++++++++---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  22 +-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |   9 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  54 +-
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |   9 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  11 +-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  17 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  22 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |   5 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  17 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  10 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  38 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  66 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  73 ++-
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  17 +-
 .../net/ethernet/stmicro/stmmac/ring_mode64.c | 158 +++++
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  34 +-
 include/linux/stmmac.h                        |  11 +
 33 files changed, 2410 insertions(+), 218 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_core.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwegmac_dma.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/ring_mode64.c

-- 
2.39.3


