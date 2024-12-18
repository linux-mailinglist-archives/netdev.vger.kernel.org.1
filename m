Return-Path: <netdev+bounces-152792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586D9F5C98
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7274D164E87
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C4A450EE;
	Wed, 18 Dec 2024 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fjy7hQBm"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDD35976;
	Wed, 18 Dec 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487433; cv=none; b=GKHFGzIuqMxdirE2Bli55fsQUbNdfC3mdg02GzYrnZHOXgJpkL504fJevjApHvAselTOJPXgTWmVoL5Vunc9o55HHDKyi3J7Qd4U2ki8/hMHABHubx+aEYqkUqRbdei42Svsu3e47cV3EXrRHP+rK3p6spXb8unbM48MllLoQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487433; c=relaxed/simple;
	bh=dsQ1qVpn9JoAKcrX4s09Fj3i5aJrldx5P82N3jLp1ws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dqPhLc8eLLpQybZZImyfdaq5Xa4KnzxEFqcoJw29sHBCYheL2zL1b2UeHEgdQemGD9ktKOoXicQuQatmRWtJj/OqrHtDaql2sll9fXVBhNU8Xv9JB7deA8y3enqMCyZDaHZw/DXLLm1e0yrUz6wA9TXzKM5MZA0TGU0r8Wky/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fjy7hQBm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734487432; x=1766023432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dsQ1qVpn9JoAKcrX4s09Fj3i5aJrldx5P82N3jLp1ws=;
  b=fjy7hQBm90ubb5h7ETP+rC4FJHNHUM9tRKWFTIu6wUJUqnL4+nnLdcEm
   c0a7KluRDlTFHEjBF/cYPL5EbTwlbVh+jvs52TQRUBbnqXgpoU8uVNTsE
   VXm9SulA1uSGxtOFgqSP/1aMnJcu9M6/uvFaI7Hct5o6WrMbfVTnGVFPR
   xEFgSyGjxOIlTyeG9HxAgjgsRJw/rEMwXMKfwAzWA8LsKRiK6HWv/x/GV
   xUYwPYvCdW6e+jJS0LHzxPjhWPKWU7sK9vdujN12MCAE8v94hqHhYl5w0
   gYcLBTplB0BsQBVE+cOoURQkC+fsiNjr2YbjfBOHh0HtfL504m1+E1ew0
   g==;
X-CSE-ConnectionGUID: BqSBYqbgTD6jKwbb+14uoQ==
X-CSE-MsgGUID: fB0cVI5FST2Gn7jFPO0+0Q==
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="35342149"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 19:03:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Dec 2024 19:03:10 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 17 Dec 2024 19:03:10 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next] net: dsa: microchip: Add suspend/resume support to KSZ DSA driver
Date: Tue, 17 Dec 2024 18:03:11 -0800
Message-ID: <20241218020311.70628-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The KSZ DSA driver starts a timer to read MIB counters periodically to
avoid count overrun.  During system suspend this will give an error for
not able to write to register as the SPI system returns an error when
it is in suspend state.  This implementation stops the timer when the
system goes into suspend and restarts it when resumed.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477_i2c.c |  4 +++
 drivers/net/dsa/microchip/ksz_common.c  | 37 +++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h  |  2 ++
 drivers/net/dsa/microchip/ksz_spi.c     |  4 +++
 4 files changed, 47 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
index 1c6d7fc16772..a2beb27459f1 100644
--- a/drivers/net/dsa/microchip/ksz9477_i2c.c
+++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
@@ -127,10 +127,14 @@ static const struct of_device_id ksz9477_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, ksz9477_dt_ids);
 
+static DEFINE_SIMPLE_DEV_PM_OPS(ksz_i2c_pm_ops,
+				ksz_switch_suspend, ksz_switch_resume);
+
 static struct i2c_driver ksz9477_i2c_driver = {
 	.driver = {
 		.name	= "ksz9477-switch",
 		.of_match_table = ksz9477_dt_ids,
+		.pm = &ksz_i2c_pm_ops,
 	},
 	.probe = ksz9477_i2c_probe,
 	.remove	= ksz9477_i2c_remove,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index df314724e6a7..a8dac7ff6b81 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4586,6 +4586,23 @@ static int ksz_hsr_leave(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int ksz_suspend(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+
+	cancel_delayed_work_sync(&dev->mib_read);
+	return 0;
+}
+
+static int ksz_resume(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dev->mib_read_interval)
+		schedule_delayed_work(&dev->mib_read, dev->mib_read_interval);
+	return 0;
+}
+
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
@@ -4626,6 +4643,8 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.port_max_mtu		= ksz_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,
+	.suspend		= ksz_suspend,
+	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,
 	.port_hwtstamp_get	= ksz_hwtstamp_get,
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
@@ -5126,6 +5145,24 @@ void ksz_switch_remove(struct ksz_device *dev)
 }
 EXPORT_SYMBOL(ksz_switch_remove);
 
+#ifdef CONFIG_PM_SLEEP
+int ksz_switch_suspend(struct device *dev)
+{
+	struct ksz_device *priv = dev_get_drvdata(dev);
+
+	return dsa_switch_suspend(priv->ds);
+}
+EXPORT_SYMBOL(ksz_switch_suspend);
+
+int ksz_switch_resume(struct device *dev)
+{
+	struct ksz_device *priv = dev_get_drvdata(dev);
+
+	return dsa_switch_resume(priv->ds);
+}
+EXPORT_SYMBOL(ksz_switch_resume);
+#endif
+
 MODULE_AUTHOR("Woojung Huh <Woojung.Huh@microchip.com>");
 MODULE_DESCRIPTION("Microchip KSZ Series Switch DSA Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b3bb75ca0796..2bc96127a447 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -444,6 +444,8 @@ struct ksz_dev_ops {
 struct ksz_device *ksz_switch_alloc(struct device *base, void *priv);
 int ksz_switch_register(struct ksz_device *dev);
 void ksz_switch_remove(struct ksz_device *dev);
+int ksz_switch_suspend(struct device *dev);
+int ksz_switch_resume(struct device *dev);
 
 void ksz_init_mib_timer(struct ksz_device *dev);
 bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 108a958dc356..b633d263098c 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -239,10 +239,14 @@ static const struct spi_device_id ksz_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, ksz_spi_ids);
 
+static DEFINE_SIMPLE_DEV_PM_OPS(ksz_spi_pm_ops,
+				ksz_switch_suspend, ksz_switch_resume);
+
 static struct spi_driver ksz_spi_driver = {
 	.driver = {
 		.name	= "ksz-switch",
 		.of_match_table = ksz_dt_ids,
+		.pm = &ksz_spi_pm_ops,
 	},
 	.id_table = ksz_spi_ids,
 	.probe	= ksz_spi_probe,
-- 
2.34.1


