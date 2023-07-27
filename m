Return-Path: <netdev+bounces-21736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F0B764850
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86A11C214E8
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E74C2EB;
	Thu, 27 Jul 2023 07:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF8C2E8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:18:26 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE82483D0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:18:14 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8AxTeu+GcJkaZsKAA--.21091S3;
	Thu, 27 Jul 2023 15:16:14 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ8y8GcJkkrY8AA--.56466S2;
	Thu, 27 Jul 2023 15:16:12 +0800 (CST)
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
Subject: [PATCH v2 00/10] stmmac: Add Loongson platform support
Date: Thu, 27 Jul 2023 15:15:44 +0800
Message-Id: <cover.1690439335.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxJ8y8GcJkkrY8AA--.56466S2
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJry7Jw1UGryftrWkCr17Arc_yoW8KFyDpF
	9rAa4Yqr97Xr1xJ3Z3Jw1kXF95GayxtF45Ww4IqrsakayIyrZ0qrnI9FWrJF17ZrWDZFya
	qr1UuwnxCF1qkwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend stmmac functions and macros for Loongson DWMAC.
Add LS7A support for dwmac_loongson.

Feiyang Chen (10):
  net: stmmac: Pass stmmac_priv and chan in some callbacks
  net: stmmac: dwmac1000: Allow platforms to choose some register
    offsets
  net: stmmac: dwmac1000: Add multi-channel support
  net: stmmac: dwmac1000: Add 64-bit DMA support
  net: stmmac: dwmac1000: Add Loongson register definitions
  net: stmmac: Add Loongson HWIF entry
  net: stmmac: dwmac-loongson: Add LS7A support
  net: stmmac: dwmac-loongson: Disable flow control for GMAC
  net: stmmac: dwmac-loongson: Add 64-bit DMA and multi-vector support
  net: stmmac: dwmac-loongson: Add GNET support

 .../net/ethernet/stmicro/stmmac/chain_mode.c  |  28 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
 drivers/net/ethernet/stmicro/stmmac/descs.h   |   7 +
 .../net/ethernet/stmicro/stmmac/descs_com.h   |  49 +++-
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 246 +++++++++++++-----
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  20 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   |   4 +-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  63 +++--
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 110 +++++++-
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |  12 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  11 +-
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  19 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 210 ++++++++-------
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 156 +++++++++--
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  11 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  17 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   8 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  38 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  48 +++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  77 +++---
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  17 +-
 .../net/ethernet/stmicro/stmmac/ring_mode.c   | 105 ++++++--
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  38 ++-
 include/linux/stmmac.h                        |  54 ++++
 27 files changed, 997 insertions(+), 370 deletions(-)

-- 
2.39.3


