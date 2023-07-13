Return-Path: <netdev+bounces-17380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40A575166F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D8828199C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375FC63D;
	Thu, 13 Jul 2023 02:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82663B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:47:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74BC819BA
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:47:11 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8BxXeuuZa9kqT8EAA--.6691S3;
	Thu, 13 Jul 2023 10:47:10 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c6sZa9kuJcrAA--.57200S2;
	Thu, 13 Jul 2023 10:47:09 +0800 (CST)
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
Subject: [RFC PATCH 00/10] net: phy/stmmac: Add Loongson platform support
Date: Thu, 13 Jul 2023 10:46:52 +0800
Message-Id: <cover.1689215889.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx_c6sZa9kuJcrAA--.57200S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF4rKF1xWr1kWFy8Wr1kXrc_yoW5GFW3pF
	ZrAa4Yqr97Jr1xJ3Z3Aw1kWF95Wa4xtr45Ww4Iqrsa9ayIyF90qrnI9FWrJr17ZrWDZFy2
	qr1UCw13GFn0kwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add driver for Loongson PHY. Extend stmmac functions and macros for
Loongson DWMAC. Add LS7A support for dwmac_loongson.

Feiyang Chen (10):
  net: phy: Add driver for Loongson PHY
  net: stmmac: Pass stmmac_priv and chan in some callbacks
  net: stmmac: dwmac1000: Allow platforms to choose some register
    offsets
  net: stmmac: dwmac1000: Add multi-channel support
  net: stmmac: dwmac1000: Add 64-bit DMA support
  net: stmmac: dwmac1000: Add Loongson register definitions
  net: stmmac: Add Loongson HWIF entry
  net: stmmac: dwmac-loongson: Add LS7A support
  net: stmmac: dwmac-loongson: Add 64-bit DMA and multi-vector support
  net: stmmac: dwmac-loongson: Add GNET support

 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  28 ++-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
 drivers/net/ethernet/stmicro/stmmac/descs.h   |   7 +
 .../net/ethernet/stmicro/stmmac/descs_com.h   |  49 ++--
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 214 +++++++++++++-----
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  20 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   |   4 +-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  63 ++++--
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 110 +++++++--
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |  12 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  11 +-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  19 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 210 +++++++++--------
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 156 +++++++++++--
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  17 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   8 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  38 ++--
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  48 +++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  77 ++++---
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  17 +-
 .../net/ethernet/stmicro/stmmac/ring_mode.c   | 105 +++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  31 ++-
 drivers/net/phy/Kconfig                       |   5 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/loongson-phy.c                |  69 ++++++
 drivers/net/phy/phy_device.c                  |  16 ++
 include/linux/phy.h                           |   2 +
 include/linux/stmmac.h                        |  51 +++++
 32 files changed, 1054 insertions(+), 359 deletions(-)
 create mode 100644 drivers/net/phy/loongson-phy.c

-- 
2.39.3


