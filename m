Return-Path: <netdev+bounces-176850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C2A6C82D
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 08:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990C33BA36E
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394D1D86F7;
	Sat, 22 Mar 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IL6zRMF/"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A21C54AF;
	Sat, 22 Mar 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742630277; cv=none; b=R5yHpw1EceNyqqrXvomnEPOthC76B733WWqCrzclggi6kZmWqkiMGpCDDOkBzvQcpLNF25eAUJHk7zM4qLR/lvYoFVDq36uYHe9RhOq3tvqrrD8mwPgRb3iFLGHQjba7WyX1Zc3sNh+TgCt1YySzWMbmO1Cs2WPgZQdBl4wqD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742630277; c=relaxed/simple;
	bh=WaAINkxGs+hK7BTrtlVnaDRGioKtuIbDOQi9l5qMSss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmaicKQuFS9vVb2JkCtgJOSq9oI9PayNPvsnj1lDM6vqC2sEtoGtHlJtcQ+pEYBtlhABD0F6oeBGXdBTM/zCBOtO9XoYqoyok3C0oRVPsX4Ca8qpGwVd0EQsWRUNgmSnGqPJWZGrostXI1mXwSGlruRoxR3UeyS2060vPhoGomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IL6zRMF/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFA7B44396;
	Sat, 22 Mar 2025 07:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742630270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYPiDYCAtW6I1sCydnEAUQlLqE8GAEFWddESPQ+zOAM=;
	b=IL6zRMF/0hbrM0zF816LQo9ziNKs+bWOjJHo+m9yFTM8muPivWX76oj7jC5LWh1qc7CRtd
	bORALR3idd9Z+sSyyP3P+KMgYcAJQdvJxxfUCogsN+k/r4T6SkHkTkC3N0zGHAIOk+ot06
	d6Jgva1P1UwJKJh/7i8Eo4DWoMYf1MfP/PozpfiIlUCsvRa7h6rdMvyGVd+7PeVBUz+3V0
	JT4MDAbe1+3NumEF5xQS3M0GiaYOwnSzjyHHoE8y0EfOz7oN1MXoOnRSgikkooOefb+e2O
	XS8j3NLVvqYzrWq2Mo9aUAMZk1viPntapqzkwc4teW5UKIzeitwIPIwNoy0+ig==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next v4 1/2] net: phy: sfp: Add support for SMBus module access
Date: Sat, 22 Mar 2025 08:57:44 +0100
Message-ID: <20250322075745.120831-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250322075745.120831-1-maxime.chevallier@bootlin.com>
References: <20250322075745.120831-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheefgeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

The SFP module's eeprom and internals are accessible through an i2c bus.

It is possible that the SFP might be connected to an SMBus-only
controller, such as the one found in some PHY devices in the VSC85xx
family.

Introduce a set of sfp read/write ops that are going to be used if the
i2c bus is only capable of doing smbus byte accesses.

As Single-byte SMBus transaction go against SFF-8472 and breaks the
atomicity for diagnostics data access, hwmon is disabled in the case
of SMBus access.

Moreover, as this may cause other instabilities, print a warning at
probe time to indicate that the setup may be unreliable because of the
hardware design.

As hwmon may be disabled for both broken EEPROM and smbus, the warnings
are udpated accordingly.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: Fixed xmas tree in read/write functions

 drivers/net/phy/sfp.c | 82 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index c88217af44a1..347c1e0e94d9 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -234,6 +234,7 @@ struct sfp {
 	enum mdio_i2c_proto mdio_protocol;
 	struct phy_device *mod_phy;
 	const struct sff_data *type;
+	size_t i2c_max_block_size;
 	size_t i2c_block_size;
 	u32 max_power_mW;
 
@@ -691,14 +692,71 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
 	return ret == ARRAY_SIZE(msgs) ? len : 0;
 }
 
-static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
+static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
+			       void *buf, size_t len)
 {
-	if (!i2c_check_functionality(i2c, I2C_FUNC_I2C))
-		return -EINVAL;
+	union i2c_smbus_data smbus_data;
+	u8 bus_addr = a2 ? 0x51 : 0x50;
+	u8 *data = buf;
+	int ret;
+
+	while (len) {
+		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+				     I2C_SMBUS_READ, dev_addr,
+				     I2C_SMBUS_BYTE_DATA, &smbus_data);
+		if (ret < 0)
+			return ret;
+
+		*data = smbus_data.byte;
+
+		len--;
+		data++;
+		dev_addr++;
+	}
+
+	return data - (u8 *)buf;
+}
+
+static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
+				void *buf, size_t len)
+{
+	union i2c_smbus_data smbus_data;
+	u8 bus_addr = a2 ? 0x51 : 0x50;
+	u8 *data = buf;
+	int ret;
 
+	while (len) {
+		smbus_data.byte = *data;
+		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+				     I2C_SMBUS_WRITE, dev_addr,
+				     I2C_SMBUS_BYTE_DATA, &smbus_data);
+		if (ret)
+			return ret;
+
+		len--;
+		data++;
+		dev_addr++;
+	}
+
+	return 0;
+}
+
+static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
+{
 	sfp->i2c = i2c;
-	sfp->read = sfp_i2c_read;
-	sfp->write = sfp_i2c_write;
+
+	if (i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
+		sfp->read = sfp_i2c_read;
+		sfp->write = sfp_i2c_write;
+		sfp->i2c_max_block_size = SFP_EEPROM_BLOCK_SIZE;
+	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		sfp->read = sfp_smbus_byte_read;
+		sfp->write = sfp_smbus_byte_write;
+		sfp->i2c_max_block_size = 1;
+	} else {
+		sfp->i2c = NULL;
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -1594,7 +1652,7 @@ static void sfp_hwmon_probe(struct work_struct *work)
 	 */
 	if (sfp->i2c_block_size < 2) {
 		dev_info(sfp->dev,
-			 "skipping hwmon device registration due to broken EEPROM\n");
+			 "skipping hwmon device registration\n");
 		dev_info(sfp->dev,
 			 "diagnostic EEPROM area cannot be read atomically to guarantee data coherency\n");
 		return;
@@ -2201,7 +2259,7 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
 	u8 check;
 	int ret;
 
-	sfp->i2c_block_size = SFP_EEPROM_BLOCK_SIZE;
+	sfp->i2c_block_size = sfp->i2c_max_block_size;
 
 	ret = sfp_read(sfp, false, 0, &id.base, sizeof(id.base));
 	if (ret < 0) {
@@ -2941,7 +2999,6 @@ static struct sfp *sfp_alloc(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 
 	sfp->dev = dev;
-	sfp->i2c_block_size = SFP_EEPROM_BLOCK_SIZE;
 
 	mutex_init(&sfp->sm_mutex);
 	mutex_init(&sfp->st_mutex);
@@ -3115,6 +3172,15 @@ static int sfp_probe(struct platform_device *pdev)
 	if (!sfp->sfp_bus)
 		return -ENOMEM;
 
+	if (sfp->i2c_max_block_size < 2)
+		dev_warn(sfp->dev,
+			 "Please note:\n"
+			 "This SFP cage is accessed via an SMBus only capable of single byte\n"
+			 "transactions. Some features are disabled, other may be unreliable or\n"
+			 "sporadically fail. Use with caution. There is nothing that the kernel\n"
+			 "or community can do to fix it, the kernel will try best efforts. Please\n"
+			 "verify any problems on hardware that supports multi-byte I2C transactions.\n");
+
 	sfp_debugfs_init(sfp);
 
 	return 0;
-- 
2.48.1


