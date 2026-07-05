Return-Path: <netdev+bounces-304811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rL97DrerSmpMFwEAu9opvQ
	(envelope-from <netdev+bounces-304811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:08:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710E70ADB6
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:08:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304811-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304811-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC9A300D841
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B535B63F;
	Sun,  5 Jul 2026 19:07:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MTA-11-3.privateemail.com (mta-11-3.privateemail.com [198.54.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4F34404A;
	Sun,  5 Jul 2026 19:07:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278439; cv=none; b=l2Ed1kCc/27NxovRHo2aWH9i7htPy608G05M63dUilG19trfPNI+rOqkbw77Fh2jGZ2ZGvlV/zG3aHpIJgFrDvRjvPvaBWH54FTZ+PWwBJl8X4VQPW4CW9R/hkyj+WHVyLPHQCTFJKhG1HApHIf+pcP7t6F3OQXxL1aGo7zCHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278439; c=relaxed/simple;
	bh=/XIeuZuF2oaQje12Q6tdFHC5uAvuefl39RVERcSpCr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtV6gky3R+GDhrPF0NpP5lMyho7Fs60Zokg/tgoyHPvvhKEc8JXcWKPNf7eKtGwB3oJT+uE//vUYGMD128qJfeeEEb9NJSJiwuujmIOmdyGhNHHqORux39Boo1atkRQ1Vp49Q+zgOjud0gntQ+I/0pweKzj/pN0cj7Lj+Pdt7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.105
Received: from mail.privateemail.com (K8S-PROD-WORKER-13 [87.215.145.39])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 4gtcRn4RNxz3hhT9;
	Sun,  5 Jul 2026 15:07:00 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Heidelberg <david@ixit.cz>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] nfc: s3fwrn5: support the S3NRN4V variant
Date: Sun,  5 Jul 2026 21:06:20 +0200
Message-ID: <20260705190621.128257-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net>
References: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304811-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[catcrafts.net];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:jorijnvdgraaf@catcrafts.net,m:david@ixit.cz,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:conor+dt@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jorijnvdgraaf@catcrafts.net,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jorijnvdgraaf@catcrafts.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[catcrafts.net:from_mime,catcrafts.net:email,catcrafts.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8710E70ADB6

The S3NRN4V (e.g. on the Fairphone 6, SM7635) is an S3FWRN5-family NFC
controller that needs different bring-up, selected with a new
samsung,s3nrn4v compatible:

 - It ships with working firmware behind a bootloader protocol this
   driver does not implement (GET_BOOTINFO times out), so the firmware
   download step is skipped. Its RF registers are (re)loaded with the
   proprietary DUAL_OPTION command (the HW and SW register blobs merged
   into a single stream) instead of the START/SET/STOP_RFREG sequence.

 - Its reference clock speed is configured with the single-byte FW_CFG
   form, sent from the ->setup hook (after CORE_RESET, before CORE_INIT).
   The selector value (0x11) is taken from the vendor configuration for
   this part; its encoding is not documented.

 - It gates its XI clock through a CLK_REQ line: the chip drives it high
   when it needs the clock, notably to synthesise the 13.56 MHz poll
   carrier. Left always-on, the free-running clock never lets the chip's
   TX PLL lock on a fresh start and it cannot poll (it falls back to
   listen only). Service the handshake when a clk-req GPIO is described,
   gating the clock on it; without one the clock stays always-on.

The variant is carried as match data by both the OF and the I2C device
id tables so the two match paths agree, and the OF table is now
referenced unconditionally for its match data, so drop the
of_match_ptr()/__maybe_unused annotations from it.

The error policy differs between the two configuration steps on purpose:
a clock misconfiguration is fatal (a ->setup failure aborts CORE_INIT),
whereas an RF-register update failure is only warned about and bring-up
continues, since the chip falls back to the RF registers programmed in
its flash and NFC may still work.

Unlike the host-endian word read in the legacy rfreg path, the
DUAL_OPTION checksum is accumulated with get_unaligned_le32() and emitted
little-endian explicitly, so it is correct regardless of CPU endianness.

Existing S3FWRN5 / S3FWRN82 setups keep the firmware-download path and
the always-on clock, unchanged.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
Changes in v2:
 - Rename the new compatible to samsung,s3nrn4v, matching the binding
   change (Requested by: Conor Dooley).
 - Close a race in the probe-time CLK_REQ seeding: the GPIO level is
   now read under clk_lock (new s3fwrn5_i2c_clk_sync(), used by both
   the irq thread and probe), so a level read before the irq fired can
   never overwrite the fresher state the irq thread applied (found by
   the Sashiko AI review of v1).
 - Reject malformed rfreg blobs (word alignment, single-byte section
   index bound) up front instead of failing at STOP_UPDATE.
 - Handle gpiod_get_value_cansleep() failure instead of gating the
   clock off on error.
 - Add an s3nrn4v i2c_device_id entry carrying the variant so both
   match paths agree.
 - Describe the of_match_ptr()/__maybe_unused removal in the commit
   message.
v1: https://lore.kernel.org/20260703202601.78563-3-jorijnvdgraaf@catcrafts.net

 drivers/nfc/s3fwrn5/core.c    |  40 +++++++++-
 drivers/nfc/s3fwrn5/i2c.c     | 138 +++++++++++++++++++++++++++++++---
 drivers/nfc/s3fwrn5/nci.c     | 119 ++++++++++++++++++++++++++++-
 drivers/nfc/s3fwrn5/nci.h     |  32 +++++++-
 drivers/nfc/s3fwrn5/s3fwrn5.h |  14 +++-
 drivers/nfc/s3fwrn5/uart.c    |   2 +-
 6 files changed, 330 insertions(+), 15 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/core.c b/drivers/nfc/s3fwrn5/core.c
index af0fa8bd970b..59317eaad7ac 100644
--- a/drivers/nfc/s3fwrn5/core.c
+++ b/drivers/nfc/s3fwrn5/core.c
@@ -122,11 +122,47 @@ static int s3fwrn5_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
 	return 0;
 }
 
+static int s3fwrn5_nci_setup(struct nci_dev *ndev)
+{
+	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
+
+	/*
+	 * Runs after CORE_RESET, before CORE_INIT. The S3NRN4V needs its
+	 * reference clock configured here (the downstream stack does it in the
+	 * bootloader, before CORE_RESET, but this is the earliest hook the NCI
+	 * core offers and the chip accepts it).
+	 */
+	if (info->variant == S3FWRN5_VARIANT_S3NRN4V)
+		return s3fwrn5_nci_clk_cfg(info);
+
+	return 0;
+}
+
 static int s3fwrn5_nci_post_setup(struct nci_dev *ndev)
 {
 	struct s3fwrn5_info *info = nci_get_drvdata(ndev);
 	int ret;
 
+	if (info->variant == S3FWRN5_VARIANT_S3NRN4V) {
+		/*
+		 * The S3NRN4V ships with working firmware behind a bootloader
+		 * protocol this driver does not implement, so there is no
+		 * download step; the NCI core has already done CORE_RESET +
+		 * CORE_INIT. Just (re)load the RF registers via DUAL_OPTION.
+		 */
+		ret = s3fwrn5_nci_rf_configure_dual(info, "sec_s3nrn4v_hwreg.bin",
+						    "sec_s3nrn4v_swreg.bin");
+		/*
+		 * Keep going even if the blobs could not be loaded: the chip
+		 * still enumerates and falls back to the RF registers programmed
+		 * in its flash, so NFC may work anyway.
+		 */
+		if (ret < 0)
+			dev_warn(&ndev->nfc_dev->dev,
+				 "rfreg configure failed (%d)\n", ret);
+		return 0;
+	}
+
 	if (s3fwrn5_firmware_init(info)) {
 		//skip bootloader mode
 		return 0;
@@ -152,13 +188,14 @@ static const struct nci_ops s3fwrn5_nci_ops = {
 	.open = s3fwrn5_nci_open,
 	.close = s3fwrn5_nci_close,
 	.send = s3fwrn5_nci_send,
+	.setup = s3fwrn5_nci_setup,
 	.post_setup = s3fwrn5_nci_post_setup,
 	.prop_ops = s3fwrn5_nci_prop_ops,
 	.n_prop_ops = ARRAY_SIZE(s3fwrn5_nci_prop_ops),
 };
 
 int s3fwrn5_probe(struct nci_dev **ndev, void *phy_id, struct device *pdev,
-	const struct s3fwrn5_phy_ops *phy_ops)
+	const struct s3fwrn5_phy_ops *phy_ops, enum s3fwrn5_variant variant)
 {
 	struct s3fwrn5_info *info;
 	int ret;
@@ -170,6 +207,7 @@ int s3fwrn5_probe(struct nci_dev **ndev, void *phy_id, struct device *pdev,
 	info->phy_id = phy_id;
 	info->pdev = pdev;
 	info->phy_ops = phy_ops;
+	info->variant = variant;
 	mutex_init(&info->mutex);
 
 	s3fwrn5_set_mode(info, S3FWRN5_MODE_COLD);
diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index e9a34d27a369..7d20e737e402 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -23,9 +23,76 @@ struct s3fwrn5_i2c_phy {
 	struct i2c_client *i2c_dev;
 	struct clk *clk;
 
+	/*
+	 * Optional hardware clock-request handshake. When a CLK_REQ GPIO is
+	 * wired, the chip drives it high while it needs its XI clock -- notably
+	 * to generate the poll/reader carrier -- and the clock is gated on it
+	 * instead of being left always-on (which never lets the chip's TX PLL
+	 * lock on a fresh clock start, leaving it unable to poll).
+	 */
+	struct gpio_desc *gpio_clk_req;
+	bool clk_on;
+	struct mutex clk_lock;	/* serialises clk_on against the CLK_REQ irq */
+
 	unsigned int irq_skip:1;
 };
 
+static void s3fwrn5_i2c_clk_set_locked(struct s3fwrn5_i2c_phy *phy, bool on)
+{
+	lockdep_assert_held(&phy->clk_lock);
+
+	if (on && !phy->clk_on) {
+		int ret = clk_prepare_enable(phy->clk);
+
+		if (ret == 0)
+			phy->clk_on = true;
+		else
+			dev_warn_once(&phy->i2c_dev->dev,
+				      "failed to enable clock (%d); NFC may not poll\n",
+				      ret);
+	} else if (!on && phy->clk_on) {
+		clk_disable_unprepare(phy->clk);
+		phy->clk_on = false;
+	}
+}
+
+/*
+ * Apply the current CLK_REQ level. Reading the GPIO under clk_lock makes
+ * concurrent callers (the CLK_REQ irq thread and the probe-time seeding)
+ * safe: whoever runs last applies a level read after the earlier update,
+ * never a stale one.
+ */
+static void s3fwrn5_i2c_clk_sync(struct s3fwrn5_i2c_phy *phy)
+{
+	int level;
+
+	mutex_lock(&phy->clk_lock);
+	level = gpiod_get_value_cansleep(phy->gpio_clk_req);
+	if (level >= 0)
+		s3fwrn5_i2c_clk_set_locked(phy, level > 0);
+	else
+		dev_warn_once(&phy->i2c_dev->dev,
+			      "failed to read CLK_REQ (%d); keeping clock state\n",
+			      level);
+	mutex_unlock(&phy->clk_lock);
+}
+
+static void s3fwrn5_i2c_clk_disable_action(void *data)
+{
+	struct s3fwrn5_i2c_phy *phy = data;
+
+	mutex_lock(&phy->clk_lock);
+	s3fwrn5_i2c_clk_set_locked(phy, false);
+	mutex_unlock(&phy->clk_lock);
+}
+
+static irqreturn_t s3fwrn5_i2c_clk_req_thread(int irq, void *phy_id)
+{
+	s3fwrn5_i2c_clk_sync(phy_id);
+
+	return IRQ_HANDLED;
+}
+
 static void s3fwrn5_i2c_set_mode(void *phy_id, enum s3fwrn5_mode mode)
 {
 	struct s3fwrn5_i2c_phy *phy = phy_id;
@@ -146,6 +213,7 @@ static irqreturn_t s3fwrn5_i2c_irq_thread_fn(int irq, void *phy_id)
 
 static int s3fwrn5_i2c_probe(struct i2c_client *client)
 {
+	enum s3fwrn5_variant variant;
 	struct s3fwrn5_i2c_phy *phy;
 	int ret;
 
@@ -172,15 +240,61 @@ static int s3fwrn5_i2c_probe(struct i2c_client *client)
 	 * S3FWRN5 depends on a clock input ("XI" pin) to function properly.
 	 * Depending on the hardware configuration this could be an always-on
 	 * oscillator or some external clock that must be explicitly enabled.
-	 * Make sure the clock is running before starting S3FWRN5.
+	 *
+	 * If a CLK_REQ GPIO is wired, the chip gates the clock itself (driving
+	 * CLK_REQ high when it needs XI); service that handshake. Otherwise just
+	 * make sure the clock is running before starting S3FWRN5.
 	 */
-	phy->clk = devm_clk_get_optional_enabled(&client->dev, NULL);
-	if (IS_ERR(phy->clk))
-		return dev_err_probe(&client->dev, PTR_ERR(phy->clk),
-				     "failed to get clock\n");
+	mutex_init(&phy->clk_lock);
+	phy->gpio_clk_req = devm_gpiod_get_optional(&client->dev, "clk-req",
+						    GPIOD_IN);
+	if (IS_ERR(phy->gpio_clk_req))
+		return PTR_ERR(phy->gpio_clk_req);
+
+	if (phy->gpio_clk_req) {
+		int clk_req_irq;
+
+		phy->clk = devm_clk_get_optional(&client->dev, NULL);
+		if (IS_ERR(phy->clk))
+			return dev_err_probe(&client->dev, PTR_ERR(phy->clk),
+					     "failed to get clock\n");
+
+		/*
+		 * Unlike the always-on branch below, this clock is enabled by
+		 * hand from the CLK_REQ handler, so devm will not disable it on
+		 * unbind. Gate it off explicitly if it is still on at teardown.
+		 */
+		ret = devm_add_action_or_reset(&client->dev,
+					       s3fwrn5_i2c_clk_disable_action,
+					       phy);
+		if (ret)
+			return ret;
+
+		clk_req_irq = gpiod_to_irq(phy->gpio_clk_req);
+		if (clk_req_irq < 0)
+			return clk_req_irq;
+
+		ret = devm_request_threaded_irq(&client->dev, clk_req_irq, NULL,
+						s3fwrn5_i2c_clk_req_thread,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"s3fwrn5_clk_req", phy);
+		if (ret)
+			return ret;
+
+		/* Seed the clock state from the current CLK_REQ level. */
+		s3fwrn5_i2c_clk_sync(phy);
+	} else {
+		phy->clk = devm_clk_get_optional_enabled(&client->dev, NULL);
+		if (IS_ERR(phy->clk))
+			return dev_err_probe(&client->dev, PTR_ERR(phy->clk),
+					     "failed to get clock\n");
+	}
 
+	variant = (uintptr_t)i2c_get_match_data(client);
 	ret = s3fwrn5_probe(&phy->common.ndev, phy, &phy->i2c_dev->dev,
-			    &i2c_phy_ops);
+			    &i2c_phy_ops, variant);
 	if (ret < 0)
 		return ret;
 
@@ -205,13 +319,17 @@ static void s3fwrn5_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
-	{ .name = S3FWRN5_I2C_DRIVER_NAME },
+	{ .name = S3FWRN5_I2C_DRIVER_NAME, .driver_data = S3FWRN5_VARIANT_FWDL },
+	{ .name = "s3nrn4v", .driver_data = S3FWRN5_VARIANT_S3NRN4V },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
 
-static const struct of_device_id of_s3fwrn5_i2c_match[] __maybe_unused = {
-	{ .compatible = "samsung,s3fwrn5-i2c", },
+static const struct of_device_id of_s3fwrn5_i2c_match[] = {
+	{ .compatible = "samsung,s3fwrn5-i2c",
+	  .data = (void *)S3FWRN5_VARIANT_FWDL, },
+	{ .compatible = "samsung,s3nrn4v",
+	  .data = (void *)S3FWRN5_VARIANT_S3NRN4V, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_s3fwrn5_i2c_match);
@@ -219,7 +337,7 @@ MODULE_DEVICE_TABLE(of, of_s3fwrn5_i2c_match);
 static struct i2c_driver s3fwrn5_i2c_driver = {
 	.driver = {
 		.name = S3FWRN5_I2C_DRIVER_NAME,
-		.of_match_table = of_match_ptr(of_s3fwrn5_i2c_match),
+		.of_match_table = of_s3fwrn5_i2c_match,
 	},
 	.probe = s3fwrn5_i2c_probe,
 	.remove = s3fwrn5_i2c_remove,
diff --git a/drivers/nfc/s3fwrn5/nci.c b/drivers/nfc/s3fwrn5/nci.c
index 5a9de11bbece..7034fb810e18 100644
--- a/drivers/nfc/s3fwrn5/nci.c
+++ b/drivers/nfc/s3fwrn5/nci.c
@@ -8,6 +8,9 @@
 
 #include <linux/completion.h>
 #include <linux/firmware.h>
+#include <linux/minmax.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
 
 #include "s3fwrn5.h"
 #include "nci.h"
@@ -20,7 +23,7 @@ static int s3fwrn5_nci_prop_rsp(struct nci_dev *ndev, struct sk_buff *skb)
 	return 0;
 }
 
-const struct nci_driver_ops s3fwrn5_nci_prop_ops[4] = {
+const struct nci_driver_ops s3fwrn5_nci_prop_ops[5] = {
 	{
 		.opcode = nci_opcode_pack(NCI_GID_PROPRIETARY,
 				NCI_PROP_SET_RFREG),
@@ -41,6 +44,11 @@ const struct nci_driver_ops s3fwrn5_nci_prop_ops[4] = {
 				NCI_PROP_FW_CFG),
 		.rsp = s3fwrn5_nci_prop_rsp,
 	},
+	{
+		.opcode = nci_opcode_pack(NCI_GID_PROPRIETARY,
+				NCI_PROP_DUAL_OPTION),
+		.rsp = s3fwrn5_nci_prop_rsp,
+	},
 };
 
 #define S3FWRN5_RFREG_SECTION_SIZE 252
@@ -117,3 +125,112 @@ int s3fwrn5_nci_rf_configure(struct s3fwrn5_info *info, const char *fw_name)
 	release_firmware(fw);
 	return ret;
 }
+
+/*
+ * Configure the reference clock. The S3NRN4V expects the single-byte FW_CFG
+ * form (just the clock-speed selector). The downstream stack sends this in the
+ * bootloader before CORE_RESET; the earliest the mainline NCI core lets us in
+ * is the ->setup hook (after CORE_RESET, before CORE_INIT), which works.
+ */
+int s3fwrn5_nci_clk_cfg(struct s3fwrn5_info *info)
+{
+	u8 clk_speed = NCI_PROP_FW_CFG_CLK_SPEED;
+
+	return nci_prop_cmd(info->ndev, NCI_PROP_FW_CFG, 1, &clk_speed);
+}
+
+/*
+ * S3NRN4V RF register update. The HW and SW register blobs are merged into a
+ * single stream (HW first) and pushed via the DUAL_OPTION command:
+ * START_UPDATE, one SET_OPTION per 252-byte section, then STOP_UPDATE carrying
+ * a 16-bit checksum (running sum of the merged stream as 32-bit words).
+ */
+int s3fwrn5_nci_rf_configure_dual(struct s3fwrn5_info *info,
+				  const char *hw_name, const char *sw_name)
+{
+	const struct firmware *hw_fw = NULL, *sw_fw = NULL;
+	struct nci_prop_dual_set_option_cmd set_option;
+	struct device *dev = &info->ndev->nfc_dev->dev;
+	size_t merged_size, i, len;
+	u8 *merged = NULL;
+	u8 stop_cmd[3];
+	u32 checksum;
+	u8 sub_oid;
+	int ret;
+
+	ret = request_firmware(&hw_fw, hw_name, dev);
+	if (ret < 0)
+		return ret;
+	ret = request_firmware(&sw_fw, sw_name, dev);
+	if (ret < 0)
+		goto out_hw;
+
+	merged_size = hw_fw->size + sw_fw->size;
+
+	/*
+	 * The stream is checksummed as 32-bit words and pushed in at most 256
+	 * sections (the section index is a single byte); reject blobs that
+	 * would silently break either.
+	 */
+	if (merged_size % 4 ||
+	    merged_size > 256 * NCI_PROP_DUAL_SECTION_SIZE) {
+		dev_err(dev, "invalid rfreg blob size (%zu)\n", merged_size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	merged = kmalloc(merged_size, GFP_KERNEL);
+	if (!merged) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memcpy(merged, hw_fw->data, hw_fw->size);
+	memcpy(merged + hw_fw->size, sw_fw->data, sw_fw->size);
+
+	/* Running sum of the merged stream as little-endian 32-bit words. */
+	checksum = 0;
+	for (i = 0; i + 4 <= merged_size; i += 4)
+		checksum += get_unaligned_le32(merged + i);
+
+	dev_dbg(dev, "rfreg dual-option update: %s + %s\n", hw_name, sw_name);
+
+	/* START_UPDATE */
+	sub_oid = NCI_PROP_DUAL_SUB_START_UPDATE;
+	ret = nci_prop_cmd(info->ndev, NCI_PROP_DUAL_OPTION, 1, &sub_oid);
+	if (ret < 0) {
+		dev_err(dev, "Unable to start rfreg update\n");
+		goto out;
+	}
+
+	/* SET_OPTION per section */
+	set_option.sub_oid = NCI_PROP_DUAL_SUB_SET_OPTION;
+	set_option.index = 0;
+	for (i = 0; i < merged_size; i += NCI_PROP_DUAL_SECTION_SIZE) {
+		len = min_t(size_t, merged_size - i, NCI_PROP_DUAL_SECTION_SIZE);
+		memcpy(set_option.data, merged + i, len);
+		ret = nci_prop_cmd(info->ndev, NCI_PROP_DUAL_OPTION,
+				   len + 2, (__u8 *)&set_option);
+		if (ret < 0) {
+			dev_err(dev, "rfreg update error (code=%d)\n", ret);
+			goto out;
+		}
+		set_option.index++;
+	}
+
+	/* STOP_UPDATE with checksum */
+	stop_cmd[0] = NCI_PROP_DUAL_SUB_STOP_UPDATE;
+	put_unaligned_le16(checksum, &stop_cmd[1]);
+	ret = nci_prop_cmd(info->ndev, NCI_PROP_DUAL_OPTION, 3, stop_cmd);
+	if (ret < 0) {
+		dev_err(dev, "Unable to stop rfreg update\n");
+		goto out;
+	}
+
+	dev_dbg(dev, "rfreg dual-option update: success\n");
+out:
+	kfree(merged);
+	release_firmware(sw_fw);
+out_hw:
+	release_firmware(hw_fw);
+	return ret;
+}
diff --git a/drivers/nfc/s3fwrn5/nci.h b/drivers/nfc/s3fwrn5/nci.h
index bc4bce2bbc4d..23179ba095a1 100644
--- a/drivers/nfc/s3fwrn5/nci.h
+++ b/drivers/nfc/s3fwrn5/nci.h
@@ -40,6 +40,13 @@ struct nci_prop_stop_rfreg_rsp {
 
 #define NCI_PROP_FW_CFG		0x28
 
+/*
+ * Single-byte FW_CFG payload (clock-speed selector) for the S3NRN4V reference
+ * clock. Taken from the vendor configuration for this part (the encoding is
+ * not documented).
+ */
+#define NCI_PROP_FW_CFG_CLK_SPEED	0x11
+
 struct nci_prop_fw_cfg_cmd {
 	__u8 clk_type;
 	__u8 clk_speed;
@@ -50,7 +57,30 @@ struct nci_prop_fw_cfg_rsp {
 	__u8 status;
 };
 
-extern const struct nci_driver_ops s3fwrn5_nci_prop_ops[4];
+/*
+ * The S3NRN4V updates its RF registers through a single "dual option" command
+ * (a sub-OID selects the operation) instead of the START/SET/STOP_RFREG
+ * opcodes above, and expects the HW and SW register blobs merged into one
+ * stream.
+ */
+#define NCI_PROP_DUAL_OPTION		0x2a
+
+#define NCI_PROP_DUAL_SUB_START_UPDATE	0x01
+#define NCI_PROP_DUAL_SUB_SET_OPTION	0x02
+#define NCI_PROP_DUAL_SUB_STOP_UPDATE	0x03
+
+#define NCI_PROP_DUAL_SECTION_SIZE	252
+
+struct nci_prop_dual_set_option_cmd {
+	__u8 sub_oid;	/* NCI_PROP_DUAL_SUB_SET_OPTION */
+	__u8 index;
+	__u8 data[NCI_PROP_DUAL_SECTION_SIZE];
+};
+
+extern const struct nci_driver_ops s3fwrn5_nci_prop_ops[5];
 int s3fwrn5_nci_rf_configure(struct s3fwrn5_info *info, const char *fw_name);
+int s3fwrn5_nci_rf_configure_dual(struct s3fwrn5_info *info,
+				  const char *hw_name, const char *sw_name);
+int s3fwrn5_nci_clk_cfg(struct s3fwrn5_info *info);
 
 #endif /* __LOCAL_S3FWRN5_NCI_H_ */
diff --git a/drivers/nfc/s3fwrn5/s3fwrn5.h b/drivers/nfc/s3fwrn5/s3fwrn5.h
index 2b492236090b..2d8c12091fba 100644
--- a/drivers/nfc/s3fwrn5/s3fwrn5.h
+++ b/drivers/nfc/s3fwrn5/s3fwrn5.h
@@ -21,6 +21,17 @@ enum s3fwrn5_mode {
 	S3FWRN5_MODE_FW,
 };
 
+enum s3fwrn5_variant {
+	/* S3FWRN5 / S3FWRN82: firmware is downloaded by this driver */
+	S3FWRN5_VARIANT_FWDL,
+	/*
+	 * S3NRN4V: ships with working firmware behind a bootloader protocol
+	 * this driver does not implement; skip the download, configure the
+	 * clock (FW_CFG) and update the RF registers via the DUAL_OPTION cmd.
+	 */
+	S3FWRN5_VARIANT_S3NRN4V,
+};
+
 struct s3fwrn5_phy_ops {
 	void (*set_wake)(void *id, bool sleep);
 	void (*set_mode)(void *id, enum s3fwrn5_mode);
@@ -36,6 +47,7 @@ struct s3fwrn5_info {
 	const struct s3fwrn5_phy_ops *phy_ops;
 
 	struct s3fwrn5_fw_info fw_info;
+	enum s3fwrn5_variant variant;
 
 	struct mutex mutex;
 };
@@ -78,7 +90,7 @@ static inline int s3fwrn5_write(struct s3fwrn5_info *info, struct sk_buff *skb)
 }
 
 int s3fwrn5_probe(struct nci_dev **ndev, void *phy_id, struct device *pdev,
-	const struct s3fwrn5_phy_ops *phy_ops);
+	const struct s3fwrn5_phy_ops *phy_ops, enum s3fwrn5_variant variant);
 void s3fwrn5_remove(struct nci_dev *ndev);
 
 int s3fwrn5_recv_frame(struct nci_dev *ndev, struct sk_buff *skb,
diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index 540a4ddb0b05..47172d739a41 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -137,7 +137,7 @@ static int s3fwrn82_uart_probe(struct serdev_device *serdev)
 	}
 
 	ret = s3fwrn5_probe(&phy->common.ndev, phy, &phy->ser_dev->dev,
-			    &uart_phy_ops);
+			    &uart_phy_ops, S3FWRN5_VARIANT_FWDL);
 	if (ret < 0)
 		goto err_serdev;
 
-- 
2.55.0


