Return-Path: <netdev+bounces-245773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8EECD75B4
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 23:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86A5B3019840
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8C3446C5;
	Mon, 22 Dec 2025 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="RPwWfb/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B1342529;
	Mon, 22 Dec 2025 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442167; cv=none; b=o0dQOe6KOfI8F2ccP7jA4mv5LlNMn5UdcoEJQkbbEUET8okdWuBbACIdrYKasYASio9pX+2/2ks26nJMCde6Xqfs7qMfZ/fUJdkplBnpma+nj/xo/6EKQvk0l9o7hIo2PaM7vf3fSLVRxHUNdwudguGn53DZcUmiLM44tGFQhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442167; c=relaxed/simple;
	bh=6o04uIBbMrUeWVDzuuVZ35ZWuEMjK2tTqMHtNFsuPZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSR9UcdEGBuHqIDE6gawGzS+cxjO07QZ1hTYQwR6LhxHplfSEpHp/PslzdbSe6dKqLAeb1h8QbPhb5FnyWGaB87Ssfq/KUvP7xsffSQlKLREll9qTH+iE86BFUIS69DSEmU0gjriAWOaKjRAhQ/AtJMeBUb30faHzgQ4eWQhws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=RPwWfb/Z; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 19A093D854B3;
	Mon, 22 Dec 2025 17:22:38 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id q6eqpY7Aeh8m; Mon, 22 Dec 2025 17:22:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 38EB63D854FB;
	Mon, 22 Dec 2025 17:22:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 38EB63D854FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1766442157; bh=6sU1OVIGcm+y0qIRztIcwQx0X7+aiUyE7PKK9k/BsLA=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=RPwWfb/ZB0zmtrTJn3v32PQKbqy+gpHDXnRmhuwgoQmsAddIeOl9yQFmMWskF4X1B
	 kQowl2bHGyqojH8XYr8SJjLNgbKi40ZTBESCnJNCqNZoxEQJxDQwvizjI5jAjUu+D0
	 OvGSS5yjBaCq9OX8qCb77CXhGhdSz32THgtQ7gGN2I6KPMcxCqw3nlN56oq27a0d5W
	 1CJ0FZen3r5MqfyfwcqaFcIHA53zs5ce2mMelYh60RZPpostbDvcotPww6pBF69ANR
	 QS4maPQb5wfeckvpnyWOKO5E5/uJRx43iUQeXCq10ReWTqIXHtjVLY3t51Yp/7irfC
	 E2zt8+16xULLw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FcFF78OKAZpT; Mon, 22 Dec 2025 17:22:37 -0500 (EST)
Received: from oitua-pc.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 12CF93D854B3;
	Mon, 22 Dec 2025 17:22:37 -0500 (EST)
From: Osose Itua <osose.itua@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com,
	Osose Itua <osose.itua@savoirfairelinux.com>
Subject: [PATCH v2 1/2] net: phy: adin: enable configuration of the LP Termination Register
Date: Mon, 22 Dec 2025 17:21:04 -0500
Message-ID: <20251222222210.3651577-2-osose.itua@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
References: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ADIN1200/ADIN1300 provide a control bit that selects between normal
receive termination and the lowest common mode impedance for 100BASE-TX
operation. This behavior is controlled through the Low Power Termination
register (B_100_ZPTM_EN_DIMRX).

Bit 0 of this register enables normal termination when set (this is the
default), and selects the lowest common mode impedance when cleared.

Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
---
 drivers/net/phy/adin.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 7fa713ca8d45..e8b778cb191d 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2019 Analog Devices Inc.
  */
+#include <cerrno>
 #include <linux/kernel.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
@@ -89,6 +90,9 @@
 #define ADIN1300_CLOCK_STOP_REG			0x9400
 #define ADIN1300_LPI_WAKE_ERR_CNT_REG		0xa000
=20
+#define ADIN1300_B_100_ZPTM_DIMRX		0xB685
+#define ADIN1300_B_100_ZPTM_EN_DIMRX		BIT(0)
+
 #define ADIN1300_CDIAG_RUN			0xba1b
 #define   ADIN1300_CDIAG_RUN_EN			BIT(0)
=20
@@ -522,6 +526,32 @@ static int adin_config_clk_out(struct phy_device *ph=
ydev)
 			      ADIN1300_GE_CLK_CFG_MASK, sel);
 }
=20
+static int adin_config_zptm100(struct phy_device *phydev)
+{
+	struct device *dev =3D &phydev->mdio.dev;
+	int reg;
+	int rc;
+
+	if (!(device_property_read_bool(dev, "adi,low-cmode-impedance")))
+		return 0;
+
+	/* set to 0 to configure for lowest common-mode impedance */
+	rc =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX,=
 0x0);
+	if (rc < 0)
+		return rc;
+
+	reg =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX)=
;
+	if (reg < 0)
+		return reg;
+
+	if (!(reg & ADIN1300_B_100_ZPTM_EN_DIMRX)) {
+		phydev_err(phydev, "Failed to set lowest common-mode impedance.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int adin_config_init(struct phy_device *phydev)
 {
 	int rc;
@@ -548,6 +578,10 @@ static int adin_config_init(struct phy_device *phyde=
v)
 	if (rc < 0)
 		return rc;
=20
+	rc =3D adin_config_zptm100(phydev);
+	if (rc < 0)
+		return rc;
+
 	phydev_dbg(phydev, "PHY is using mode '%s'\n",
 		   phy_modes(phydev->interface));
=20

