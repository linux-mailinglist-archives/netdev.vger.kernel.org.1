Return-Path: <netdev+bounces-232363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C207C049F6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 153CB34E640
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869FF2BDC0A;
	Fri, 24 Oct 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qrO2aJcu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B629C33D;
	Fri, 24 Oct 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289666; cv=none; b=mVk18HcAL5xgKPgX3b0epu9a+k76swtyseNd8OqbVCuXU5eL/h3OeXx/eJmdJk0OFFXMxjLhwmTzQO/k0eJl9Ptz0Rlnb9WL9rmHBi6H0YW5z5TTJeJedh6iwRiSYVv116eZbpItYRGIEq+6xP6ucTQv6rZRj6Rb6dRs7rNHClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289666; c=relaxed/simple;
	bh=0uj5C8Xbc96rH1BljyEN0ep/DWRMCNGdng2lDpjyZag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi+FD9cEtKRHJrLXCE/d8RWO+BpN61+AOj3WUoOy0x9HDNFD1DW7ihLUK/UCOmxQnhpSfXAuFcd3dWyqk36t45fkdz1NWnoZ9ELx2gMI4cW641iT4/aBgLZNRM5yTbWXYzMLt0m/tB/NAIHM+BlaSQy7A9A6OOLLjihb6sozbuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qrO2aJcu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ABB7E1A163B;
	Fri, 24 Oct 2025 07:07:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 80FE760703;
	Fri, 24 Oct 2025 07:07:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E251F102F2479;
	Fri, 24 Oct 2025 09:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761289661; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=A1EtqRzxIfYahVpLg5Nn8CrI/7ldhsFWV8dKenQuIrM=;
	b=qrO2aJcuzI4rhlflKWADJQMxOtGalPJgJ1S6XY+0XAnemmmjLbzx/tCoJJdE370Ru5u2on
	pp16p2rijdILG1tL40aT+jCoNyIxWzGoQwodjLK1J6Q2MHtXE4HPRBTUg6byh/N1XNGdCg
	F+1jrissekCSDWkzrtzibmbYOURV4krfbDcK+9HRvuDjhBGHVkNGsy1MA6V2Rkz8h8cdUl
	CJCTlj9vJmYXgyN9Khn6cghXUVI1ZH0ufqApkXdcSkJLFACZ/0CLIIF7bDFdC9q+Sf/Yj8
	K2PGJ+JSwGM+dqMxCT07PKfuIhj7/ZLwGhvrMDSl86JgiHoc8ar6cVOEXDtn3A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: stmmac: Add a devlink attribute to control timestamping mode
Date: Fri, 24 Oct 2025 09:07:18 +0200
Message-ID: <20251024070720.71174-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
References: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The DWMAC1000 supports 2 timestamping configurations to configure how
frequency adjustments are made to the ptp_clock, as well as the reported
timestamp values.

There was a previous attempt at upstreaming support for configuring this
mode by Olivier Dautricourt and Julien Beraud a few years back [1]

In a nutshell, the timestamping can be either set in fine mode or in
coarse mode.

In fine mode, which is the default, we use the overflow of an accumulator to
trigger frequency adjustments, but by doing so we lose precision on the
timetamps that are produced by the timestamping unit. The main drawback
is that the sub-second increment value, used to generate timestamps, can't be
set to lower than (2 / ptp_clock_freq).

The "fine" qualification comes from the frequent frequency adjustments we are
able to do, which is perfect for a PTP follower usecase.

In Coarse mode, we don't do frequency adjustments based on an
accumulator overflow. We can therefore have very fine subsecond
increment values, allowing for better timestamping precision. However
this mode works best when the ptp clock frequency is adjusted based on
an external signal, such as a PPS input produced by a GPS clock. This
mode is therefore perfect for a Grand-master usecase.

Introduce a driver-specific devlink parameter "ts_coarse" to enable or
disable coarse mode, keeping the "fine" mode as a default.

This can then be changed with:

  devlink dev param set <dev> name ts_coarse value true cmode runtime

The associated documentation is also added.

[1] : https://lore.kernel.org/netdev/20200514102808.31163-1-olivier.dautricourt@orolia.com/

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/stmmac.rst   |  31 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   3 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 115 +++++++++++++++++-
 5 files changed, 148 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/networking/devlink/stmmac.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 0c58e5c729d9..35b12a2bfeba 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -99,5 +99,6 @@ parameters, info versions, and other features it supports.
    prestera
    qed
    sfc
+   stmmac
    ti-cpsw-switch
    zl3073x
diff --git a/Documentation/networking/devlink/stmmac.rst b/Documentation/networking/devlink/stmmac.rst
new file mode 100644
index 000000000000..e8e33d1c7baf
--- /dev/null
+++ b/Documentation/networking/devlink/stmmac.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+stmmac (synopsys dwmac) devlink support
+=======================================
+
+This document describes the devlink features implemented by the ``stmmac``
+device driver.
+
+Parameters
+==========
+
+The ``stmmac`` driver implements the following driver-specific parameters.
+
+.. list-table:: Driver-specific parameters implemented
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``ts_coarse``
+     - Boolean
+     - runtime
+     - Enable the Coarse timestamping mode. In Coarse mode, the ptp clock is
+       expected to be updated through an external PPS input, but the subsecond
+       increment used for timestamping is set to 1/ptp_clock_rate. In Fine mode
+       (i.e. Coarse mode == false), the ptp clock frequency is adjusted more
+       frequently, but the subsecond increment is set to 2/ptp_clock_rate.
+       Coarse mode is suitable for PTP Grand Master operation. If unsure, leave
+       the parameter to False.
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 716daa51df7e..87c5bea6c2a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -10,6 +10,7 @@ config STMMAC_ETH
 	select PHYLINK
 	select CRC32
 	select RESET_CONTROLLER
+	select NET_DEVLINK
 	help
 	  This is the driver for the Ethernet IPs built around a
 	  Synopsys IP Core.
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index aaeaf42084f0..bea0ce86c718 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -259,6 +259,7 @@ struct stmmac_priv {
 	u32 sarc_type;
 	u32 rx_riwt[MTL_MAX_RX_QUEUES];
 	int hwts_rx_en;
+	bool tsfupdt_coarse;
 
 	void __iomem *ioaddr;
 	struct net_device *dev;
@@ -368,6 +369,8 @@ struct stmmac_priv {
 	/* XDP BPF Program */
 	unsigned long *af_xdp_zc_qps;
 	struct bpf_prog *xdp_prog;
+
+	struct devlink *devlink;
 };
 
 enum stmmac_state {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8922c660cefa..0b15c90b67f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -40,6 +40,7 @@
 #include <linux/phylink.h>
 #include <linux/udp.h>
 #include <linux/bpf_trace.h>
+#include <net/devlink.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
@@ -58,8 +59,7 @@
  * with fine resolution and binary rollover. This avoid non-monotonic behavior
  * (clock jumps) when changing timestamping settings at runtime.
  */
-#define STMMAC_HWTS_ACTIVE	(PTP_TCR_TSENA | PTP_TCR_TSCFUPDT | \
-				 PTP_TCR_TSCTRLSSR)
+#define STMMAC_HWTS_ACTIVE	(PTP_TCR_TSENA | PTP_TCR_TSCTRLSSR)
 
 #define	STMMAC_ALIGN(x)		ALIGN(ALIGN(x, SMP_CACHE_BYTES), 16)
 #define	TSO_MAX_BUFF_SIZE	(SZ_16K - 1)
@@ -148,6 +148,15 @@ static void stmmac_exit_fs(struct net_device *dev);
 
 #define STMMAC_COAL_TIMER(x) (ns_to_ktime((x) * NSEC_PER_USEC))
 
+struct stmmac_devlink_priv {
+	struct stmmac_priv *stmmac_priv;
+};
+
+enum stmmac_dl_param_id {
+	STMMAC_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	STMMAC_DEVLINK_PARAM_ID_TS_COARSE,
+};
+
 /**
  * stmmac_set_clk_tx_rate() - set the clock rate for the MAC transmit clock
  * @bsp_priv: BSP private data structure (unused)
@@ -675,6 +684,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	priv->hwts_tx_en = config->tx_type == HWTSTAMP_TX_ON;
 
 	priv->systime_flags = STMMAC_HWTS_ACTIVE;
+	if (!priv->tsfupdt_coarse)
+		priv->systime_flags |= PTP_TCR_TSCFUPDT;
 
 	if (priv->hwts_tx_en || priv->hwts_rx_en) {
 		priv->systime_flags |= tstamp_all | ptp_v2 |
@@ -765,7 +776,8 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 		return -EOPNOTSUPP;
 	}
 
-	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE);
+	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
+					       PTP_TCR_TSCFUPDT);
 	if (ret) {
 		netdev_warn(priv->dev, "PTP init failed\n");
 		return ret;
@@ -7383,6 +7395,95 @@ static const struct xdp_metadata_ops stmmac_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= stmmac_xdp_rx_timestamp,
 };
 
+static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
+{
+	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
+	struct stmmac_priv *priv = dl_priv->stmmac_priv;
+
+	priv->tsfupdt_coarse = ctx->val.vbool;
+
+	if (priv->tsfupdt_coarse)
+		priv->systime_flags &= ~PTP_TCR_TSCFUPDT;
+	else
+		priv->systime_flags |= PTP_TCR_TSCFUPDT;
+
+	/* In Coarse mode, we can use a smaller subsecond increment, let's
+	 * reconfigure the systime, subsecond increment and addend.
+	 */
+	stmmac_update_subsecond_increment(priv);
+
+	return 0;
+}
+
+static int stmmac_dl_ts_coarse_get(struct devlink *dl, u32 id,
+				   struct devlink_param_gset_ctx *ctx)
+{
+	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
+	struct stmmac_priv *priv = dl_priv->stmmac_priv;
+
+	ctx->val.vbool = priv->tsfupdt_coarse;
+
+	return 0;
+}
+
+static const struct devlink_param stmmac_devlink_params[] = {
+	DEVLINK_PARAM_DRIVER(STMMAC_DEVLINK_PARAM_ID_TS_COARSE, "ts_coarse",
+			     DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     stmmac_dl_ts_coarse_get,
+			     stmmac_dl_ts_coarse_set, NULL),
+};
+
+/* None of the generic devlink parameters are implemented */
+static const struct devlink_ops stmmac_devlink_ops = {};
+
+static int stmmac_register_devlink(struct stmmac_priv *priv)
+{
+	struct stmmac_devlink_priv *dl_priv;
+	int ret;
+
+	/* For now, what is exposed over devlink is only relevant when
+	 * timestamping is available and we have a valid ptp clock rate
+	 */
+	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp) ||
+	    !priv->plat->clk_ptp_rate)
+		return 0;
+
+	priv->devlink = devlink_alloc(&stmmac_devlink_ops, sizeof(*dl_priv),
+				      priv->device);
+	if (!priv->devlink)
+		return -ENOMEM;
+
+	dl_priv = devlink_priv(priv->devlink);
+	dl_priv->stmmac_priv = priv;
+
+	ret = devlink_params_register(priv->devlink, stmmac_devlink_params,
+				      ARRAY_SIZE(stmmac_devlink_params));
+	if (ret)
+		goto dl_free;
+
+	devlink_register(priv->devlink);
+	return 0;
+
+dl_free:
+	devlink_free(priv->devlink);
+
+	return ret;
+}
+
+static void stmmac_unregister_devlink(struct stmmac_priv *priv)
+{
+	if (!priv->devlink)
+		return;
+
+	devlink_unregister(priv->devlink);
+	devlink_params_unregister(priv->devlink, stmmac_devlink_params,
+				  ARRAY_SIZE(stmmac_devlink_params));
+	devlink_free(priv->devlink);
+}
+
 /**
  * stmmac_dvr_probe
  * @device: device pointer
@@ -7656,6 +7757,10 @@ int stmmac_dvr_probe(struct device *device,
 		goto error_phy_setup;
 	}
 
+	ret = stmmac_register_devlink(priv);
+	if (ret)
+		goto error_devlink_setup;
+
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err(priv->device, "%s: ERROR %i registering the device\n",
@@ -7678,6 +7783,8 @@ int stmmac_dvr_probe(struct device *device,
 	return ret;
 
 error_netdev_register:
+	stmmac_unregister_devlink(priv);
+error_devlink_setup:
 	phylink_destroy(priv->phylink);
 error_phy_setup:
 	stmmac_pcs_clean(ndev);
@@ -7714,6 +7821,8 @@ void stmmac_dvr_remove(struct device *dev)
 #ifdef CONFIG_DEBUG_FS
 	stmmac_exit_fs(ndev);
 #endif
+	stmmac_unregister_devlink(priv);
+
 	phylink_destroy(priv->phylink);
 	if (priv->plat->stmmac_rst)
 		reset_control_assert(priv->plat->stmmac_rst);
-- 
2.49.0


