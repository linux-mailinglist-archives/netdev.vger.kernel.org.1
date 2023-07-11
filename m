Return-Path: <netdev+bounces-16922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7091274F6E3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF53281243
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09671E538;
	Tue, 11 Jul 2023 17:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16B1E504
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:18:12 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA310FC;
	Tue, 11 Jul 2023 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689095890; x=1720631890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Fi7Z+SejqB8FmLnWihYsJBZfmhjua3hB69p3/WVjRY=;
  b=SGbt8SObiAgaHPJ3usbKbQBte1azVKHZ/P+WF31+Cx3zgKfXUw7rBuF9
   xB76OPWXC9sgc89JOZCacSAyUcsffPRdHywWSbMNudFAOBB6PTKxxhnrC
   SeejvGVqnVTPPpQSS6Y0KQ/pp3Gtgjf3JIQRlny2UUmYVRlmIu6FuBF3l
   6Y+vT9OYrd2pxxdlfXgtasAuAnIRQLJaWDS+E9mLKA7NhJXm7LQW244J+
   +jlgu1LLv+aEmUIdBxA0MH/5yfvPz9oI36Y52sT0sXIudXp3VxKJt1GL0
   kR8IgmNeePUXiOTq09jbm9sRFv4DXAV0R6X1gAYB5idzhTKw7b3RRbGzo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363545620"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="363545620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="756427039"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="756427039"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 11 Jul 2023 10:18:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DE1AC7AB; Tue, 11 Jul 2023 20:17:59 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Sanjay R Mehta <sanju.mehta@amd.com>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 13/14] spi: Convert to SPI_CONTROLLER_HALF_DUPLEX
Date: Tue, 11 Jul 2023 20:17:55 +0300
Message-Id: <20230711171756.86736-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
References: <20230711171756.86736-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert the users under SPI subsystem to SPI_CONTROLLER_HALF_DUPLEX.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-amd.c             | 2 +-
 drivers/spi/spi-cavium-thunderx.c | 2 +-
 drivers/spi/spi-falcon.c          | 2 +-
 drivers/spi/spi-lp8841-rtc.c      | 2 +-
 drivers/spi/spi-mxs.c             | 2 +-
 drivers/spi/spi-omap-uwire.c      | 2 +-
 drivers/spi/spi-pic32-sqi.c       | 2 +-
 drivers/spi/spi-qcom-qspi.c       | 2 +-
 drivers/spi/spi-rockchip-sfc.c    | 2 +-
 drivers/spi/spi-sprd-adi.c        | 2 +-
 drivers/spi/spi-ti-qspi.c         | 2 +-
 drivers/spi/spi-xcomm.c           | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index fecead757a3c..b19766571f28 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -404,7 +404,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	master->bus_num = 0;
 	master->num_chipselect = 4;
 	master->mode_bits = 0;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->max_speed_hz = AMD_SPI_MAX_HZ;
 	master->min_speed_hz = AMD_SPI_MIN_HZ;
 	master->setup = amd_spi_master_setup;
diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index 60c0d6934654..535f7eb9fa69 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -64,7 +64,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 		p->sys_freq = SYS_FREQ_DEFAULT;
 	dev_info(dev, "Set system clock to %u\n", p->sys_freq);
 
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->num_chipselect = 4;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
 			    SPI_LSB_FIRST | SPI_3WIRE;
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 4c103dff0d44..8a8414cbb400 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -401,7 +401,7 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 	priv->master = master;
 
 	master->mode_bits = SPI_MODE_3;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->setup = falcon_sflash_setup;
 	master->transfer_one_message = falcon_sflash_xfer_one;
 	master->dev.of_node = pdev->dev.of_node;
diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index ccaa7a946359..c6810720b3b5 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -191,7 +191,7 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, master);
 
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->mode_bits = SPI_CS_HIGH | SPI_3WIRE | SPI_LSB_FIRST;
 
 	master->bus_num = pdev->id;
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 963a53dd680b..cd0e7ae07162 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -572,7 +572,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 	master->num_chipselect = 3;
 	master->dev.of_node = np;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->auto_runtime_pm = true;
 
 	spi = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 902d2e0c1f2f..f89aa9e52c23 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -486,7 +486,7 @@ static int uwire_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 
 	master->bus_num = 2;	/* "official" */
 	master->num_chipselect = 4;
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 51dfb49523f3..5cbebcf26a2a 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -648,7 +648,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	master->dev.of_node	= pdev->dev.of_node;
 	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_TX_DUAL |
 				  SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
-	master->flags		= SPI_MASTER_HALF_DUPLEX;
+	master->flags		= SPI_CONTROLLER_HALF_DUPLEX;
 	master->can_dma		= pic32_sqi_can_dma;
 	master->bits_per_word_mask	= SPI_BPW_RANGE_MASK(8, 32);
 	master->transfer_one_message	= pic32_sqi_one_message;
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index a8a683d6145c..5a98c52bad32 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -724,7 +724,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_MODE_0 |
 			    SPI_TX_DUAL | SPI_RX_DUAL |
 			    SPI_TX_QUAD | SPI_RX_QUAD;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->prepare_message = qcom_qspi_prepare_message;
 	master->transfer_one = qcom_qspi_transfer_one;
 	master->handle_err = qcom_qspi_handle_err;
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 583f4187f030..bd550e76ab3d 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -565,7 +565,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->mem_ops = &rockchip_sfc_mem_ops;
 	master->dev.of_node = pdev->dev.of_node;
 	master->mode_bits = SPI_TX_QUAD | SPI_TX_DUAL | SPI_RX_QUAD | SPI_RX_DUAL;
diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 22e39c4c12c4..94d16aadfa44 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -580,7 +580,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bus_num = pdev->id;
 	ctlr->num_chipselect = num_chipselect;
-	ctlr->flags = SPI_MASTER_HALF_DUPLEX;
+	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	ctlr->bits_per_word_mask = 0;
 	ctlr->transfer_one = sprd_adi_transfer_one;
 
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 5914335ff63d..bf4b40289bee 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -770,7 +770,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD;
 
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->setup = ti_qspi_setup;
 	master->auto_runtime_pm = true;
 	master->transfer_one_message = ti_qspi_start_transfer_one;
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index ae6218bcd02a..a3d57554f5ba 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -218,7 +218,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 	master->num_chipselect = 16;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->transfer_one_message = spi_xcomm_transfer_one;
 	master->dev.of_node = i2c->dev.of_node;
 	i2c_set_clientdata(i2c, master);
-- 
2.40.0.1.gaa8946217a0b


