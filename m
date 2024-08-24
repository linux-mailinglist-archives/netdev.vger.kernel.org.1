Return-Path: <netdev+bounces-121660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390CC95DF34
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C9E1F21C3E
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF95C42A97;
	Sat, 24 Aug 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="cryBrt0n"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C115D1
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724520854; cv=none; b=ggQQlp96yslBE3HUJW2ffyGVfF6aRoQ5wcNF7b7/rl0AMG1jipH7Jv6flsR1+3cu+R6viRAsmW9ElkIGb8HpLrpdHuotD1dPcCvVB8Z7xgwWdIWJU+orNl4jJMq8lEdZH1GLDhTtm9WTVIpcA3HJxC/Qi6haruykYk4cDdeplWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724520854; c=relaxed/simple;
	bh=Yq8vnnRZX4EWZ9Z9TEN0rJZtGbaAVElrOGGinFf+KgM=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=jsI9wJTgfyLBl+8Hu+s2Wrijphb1OGV74iDDBKyLMwfjsEJXiWgKbB/xCSnFLJZR97ythDrEgOwMzPcOiqBA5XlS6iGmjHebIAH/PqeJyUXdAs/F9Vgvl4ydn8EpUZFmaYSTLeDm5FgH79wQQNqHMmEdvCZrXDSWLc8UZJBkyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=cryBrt0n; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724520847; x=1725125647; i=hfdevel@gmx.net;
	bh=0Z7e06DdqqIGekxojd0wsGu5JxdIYqwlacDcUFyZmzw=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cryBrt0neJ63lhWHP6mWJk5YEqGpSZsXoQjzEP3k+X3uTLl5YCEBbXFSwdkXwGzR
	 Z5rMFPNbPDO8ai7zVChtMHEhL1b84ATyceExJ6T+oGt7aZNO8GRbKo/whwN/M5DPo
	 X1zmtzeKab7PRHx1LoVlxPL5+I4FisXtY4uCFG6zKtxBw4KoXqPb6gc7aK6L90//N
	 fPF1qqyL0FfPyzb80U3uDx9kuaXG/FTuKiKbuKuEz2mvhgfZfn6CAPMBLIPN7HSGk
	 K/nSx0M7hB1jj8npKf83cHd0hhI5wBVZ7wxmjhrgDI2rFzG1nJVZDl66OoR/f2iTh
	 C44Fil36GD3Iip64GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bs42.server.lan [172.19.170.94]) (via HTTP); Sat, 24 Aug 2024
 19:34:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-916ed524-e8a5-4534-b059-3ed707ec3881-1724520847823@3c-app-gmx-bs42>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>
Subject: [PATCH net-next 1/2] net: phy: aquantia: create firmware name for
 aqr PHYs at runtime
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Aug 2024 19:34:07 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:dbYOwg7sPrzCQgUz0OwZwhAaAwnVZY4uPbNqIAejCizgvsVsjZg4vFTzl42xpZESm15df
 /TTzjO/u88kkcvthB5F47A15nINmssIquavilkO/BsbWuDo0s3qt1eoA/Beh7NZSHC+Wc58nJ+sq
 QM6afpx/rbSxxOc5nCQj7+AB9nzuYT3+2bZIu/nqZCGf3oYLyCJdOlEQ8Q/Zcw7C78YElPTRzGHK
 rht0Mlqhba27l4/eDKGlULMokZQGRgNJofBdSagnRf0Vv15k892MSdDe3WLiZTjs15ibHQ+gYzkW
 N8=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FUVwZm5QxF0=;rFcE066qC9XOeqUhQjI8EjNWiH/
 y1s72fxXXGMZh1zrl1F1sQyWqmC8A1Xn8l/OHII4d2mn8583bEOVPonnDLazsRRqr6JTtHiy1
 Tgcl8Bf8MB/C2rLudREw25B8ZLtK66LBqmjtt6Fapo1y9QjX7MqxyerFbh0sOPiiliKvsyLJk
 zYBRp2Vx3/GQOiXA3VvEg2mDTeyY0v2lCTnlhz07YN4cKfmYd8j2/yGqdDmEM5gQGbe7iHA/8
 8PqY9De3kz94JdgK+z13Lgr3062hzA4Xv4SqsdaKaSYOnhLCG9V9XP7VR2MQgWSIC2j93TvyX
 S+imD3I1d/haBmHQHPI8jFRTfwagbbIPXpvIvv5CO/3igQypJ6oBW13e7wFDISbODPfyYivhC
 OAkXlMkI6q9kVvUhJDeNKAZkvdOk5h09qvdYdVmC+poUqauyo1Iwim1C4lF4J4d19LPYEke3I
 04aNmVJnP9B9Cg45VGwhXIX457Vj9NkvkYbqkUghn8v7pv2Q133AGCfTGqoVXgQsHm7zYUMiI
 pa5TUVMgvjs3kmgL932gCvJNYojJudvmOu36tqaeMnRjtglHf3ZDYGD1WfBlXXAXwRtLlOCwD
 EE2fHxI2eDNeE5IHBbZUwIE1kYOhzcn280cdwAmWQNlNfGtm9yHcYu4wYOdFglDdrYz7UP66s
 kYc5KUJgOun1IdTv9VzFgJoncDk/ayojv+pSf70ETw==
Content-Transfer-Encoding: quoted-printable

Aquantia PHYs without EEPROM have to load the firmware via the file system=
 and
upload it to the PHY via MDIO.
Because the Aquantia PHY firmware is different for the same PHY depending =
on the
MAC it is connected to, it is not possible to statically define the firmwa=
re name.
When in an embedded environment, the device-tree can provide the file name=
. But when the PHY is on a PCIe card, the file name needs to be provided i=
n a different
way.

This patch creates a firmware file name at run time, based on the Aquantia=
 PHY
name and the MDIO name. By this, firmware files for ths same PHY, but comb=
ined
with different MACs are distinguishable.

The proposed naming uses the scheme:
	mdio/phy-mdio_suffix
Or, in the case of the Tehuti TN9510 card (TN4010 MAC and AQR105 PHY), the=
 firmware
file name will be
	tn40xx/aqr105-tn40xx_fw.cld

This naming style has been chosen in order to make the filename unique, bu=
t also
to place the firmware in a directory named after the MAC, where different =
firmwares
could be collected.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/phy/aquantia/aquantia_firmware.c | 78 ++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/ph=
y/aquantia/aquantia_firmware.c
index 524627a36c6f..265bd6ee21da 100644
=2D-- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -5,6 +5,7 @@
 #include <linux/firmware.h>
 #include <linux/crc-itu-t.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/ctype.h>	/* for tolower() */

 #include <asm/unaligned.h>

@@ -321,6 +322,81 @@ static int aqr_firmware_load_nvmem(struct phy_device =
*phydev)
 	return ret;
 }

+/* derive the filename of the firmware file from the PHY and the MDIO nam=
es
+ * Parts of filename:
+ *   mdio/phy-mdio_suffix
+ *    1    2   3    4
+ * allow name components 1 (=3D 3) and 2 to have same maximum length
+ */
+static int aqr_firmware_name(struct phy_device *phydev, const char **name=
)
+{
+#define AQUANTIA_FW_SUFFIX "_fw.cld"
+#define AQUANTIA_NAME "Aquantia "
+/* including the trailing zero */
+#define FIRMWARE_NAME_SIZE 64
+/* length of the name components 1, 2, 3 without the trailing zero */
+#define NAME_PART_SIZE ((FIRMWARE_NAME_SIZE - sizeof(AQUANTIA_FW_SUFFIX) =
- 2) / 3)
+	ssize_t len, mac_len;
+	char *fw_name;
+	int i, j;
+
+	/* sanity check: the phydev drv name needs to start with AQUANTIA_NAME *=
/
+	if (strncmp(AQUANTIA_NAME, phydev->drv->name, strlen(AQUANTIA_NAME)))
+		return -EINVAL;
+
+	/* sanity check: the phydev drv name may not be longer than NAME_PART_SI=
ZE */
+	if (strlen(phydev->drv->name) - strlen(AQUANTIA_NAME) > NAME_PART_SIZE)
+		return -E2BIG;
+
+	/* sanity check: the MDIO name must not be empty */
+	if (!phydev->mdio.bus->id[0])
+		return -EINVAL;
+
+	fw_name =3D devm_kzalloc(&phydev->mdio.dev, FIRMWARE_NAME_SIZE, GFP_KERN=
EL);
+	if (!fw_name)
+		return -ENOMEM;
+
+	/* first the directory name =3D MDIO bus name
+	 * (only name component, firmware name part 1; remove busids and the lik=
es)
+	 * ignore the return value of strscpy: if the MAC/MDIO name is too long,
+	 * it will just be truncated
+	 */
+	strscpy(fw_name, phydev->mdio.bus->id, NAME_PART_SIZE + 1);
+	for (i =3D 0; fw_name[i]; i++) {
+		if (fw_name[i] =3D=3D '-' || fw_name[i] =3D=3D '_' || fw_name[i] =3D=3D=
 ':')
+			break;
+	}
+	mac_len =3D i;	/* without trailing zero */
+
+	fw_name[i++] =3D '/';
+
+	/* copy name part beyond AQUANTIA_NAME into our name buffer - name part =
2 */
+	len =3D strscpy(&fw_name[i], phydev->drv->name + strlen(AQUANTIA_NAME),
+		      FIRMWARE_NAME_SIZE - i);
+	if (len < 0)
+		return len;	/* should never happen */
+
+	/* convert the name to lower case */
+	for (j =3D i; j < i + len; j++)
+		fw_name[j] =3D tolower(fw_name[j]);
+	i +=3D len;
+
+	/* split the phy and mdio components with a dash */
+	fw_name[i++] =3D '-';
+
+	/* copy again the mac_name into fw_name - name part 3 */
+	memcpy(&fw_name[i], fw_name, mac_len);
+
+	/* copy file suffix (name part 4 - don't forget the trailing '\0') */
+	len =3D strscpy(&fw_name[i + mac_len], AQUANTIA_FW_SUFFIX, FIRMWARE_NAME=
_SIZE - i - mac_len);
+	if (len < 0)
+		return len;	/* should never happen */
+
+	if (name)
+		*name =3D fw_name;
+	return 0;
+}
+
 static int aqr_firmware_load_fs(struct phy_device *phydev)
 {
 	struct device *dev =3D &phydev->mdio.dev;
@@ -330,6 +406,8 @@ static int aqr_firmware_load_fs(struct phy_device *phy=
dev)

 	ret =3D of_property_read_string(dev->of_node, "firmware-name",
 				      &fw_name);
+	if (ret)
+		ret =3D aqr_firmware_name(phydev, &fw_name);
 	if (ret)
 		return ret;

=2D-
2.43.0


