Return-Path: <netdev+bounces-139251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7DA9B1311
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 01:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C0C283681
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C81D90A1;
	Fri, 25 Oct 2024 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="hXx7Xg2S"
X-Original-To: netdev@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D06217F53;
	Fri, 25 Oct 2024 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729897979; cv=none; b=ibYfuMFHhlHO73OMDEls+Bz93FHpBOCxn73DMqgGoB1X1nSWhTylY2/QWOLk/Pr0+trZr9a56TPK8frQUytIfcUl9ab32MFizVe7a2JAoBypRXCW06vcyhq16zUH082+ED70MQXfq99gUDKofgUtqG/jcJacsHMc0pDISELLffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729897979; c=relaxed/simple;
	bh=V5BgB/r2NWm/nRIMMT0paD5PyV+Ttw9lQg6UbPlIh+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLkMo9Z3pwpLxv/LP8rc7tUYE2a4ceDzC1OMZFZqldOz8gZ+LTKIzGGX+cyTjyFnvNg9/w8KN2Z1ejpB72dBBfFhfIBEHdB+VySpBKWEQ43c7arr4HRMf40SiwzWtNL0dNzJfpkESj/e/gcYb0V1U9MxQCGZ7E5SOV7gGwiMGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=hXx7Xg2S; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4XZz0r0c3Lz8tcR;
	Sat, 26 Oct 2024 01:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1729897564; bh=uv/dHHEplnuod4eD6WXimpOAVYIqzfMnMIhzCRMMjKo=;
	h=From:To:Cc:Subject:Date:From:To:CC:Subject;
	b=hXx7Xg2S0qkR4Cemg4a6KW/CF6M8NZCCNI0US5pOQT3xn8DaSP/qtJK101RkMgJWE
	 PuuNzNyZqAlEmR/+aLcQCTXIUJNFSY+ZDSBPb1YfJvkT6EP7MK0N+xgjpJk+L08+xM
	 kQlHWohcroe3yZMS44Aqg5DbSlIhrPe/KDPGyoMfbm5hfeTvdvDLUpA/8v7etWHK24
	 9XE7YEkvd3/4ZHN+7IATOAr/ld8pcyxPA0y3EJc0TXWowmmpOixSUNlBODrVXQvJFk
	 KVKSY+biPXdDO2pEEmgJ7+H4Tb3A4Uv4NYizNfu7W/yKeevivlKJvtkjG0nck6dyI6
	 /XSyPJCdDjTGA==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:3102:6d92:10:58e4:fd1e:ffbc:d487
Received: from Fabians-MBP.fritz.box (dynamic-2a02-3102-6d92-0010-58e4-fd1e-ffbc-d487.310.pool.telefonica.de [IPv6:2a02:3102:6d92:10:58e4:fd1e:ffbc:d487])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/30HNJXyOxPlEwinYNmtC/cS44/HpnJW0=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4XZz0n2wJ6z8tV6;
	Sat, 26 Oct 2024 01:06:01 +0200 (CEST)
From: Fabian Benschuh <Fabi.Benschuh@fau.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Fabian Benschuh <Fabi.Benschuh@fau.de>
Subject: [PATCH] Add LAN78XX OTP_ACCESS flag support
Date: Sat, 26 Oct 2024 01:05:46 +0200
Message-ID: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this flag we can now use ethtool to access the OTP:
ethtool --set-priv-flags eth0 OTP_ACCESS on
ethtool -e eth0  # this will read OTP if OTP_ACCESS is on, else EEPROM

When writing to OTP we need to set OTP_ACCESS on and write with the correct magic 0x7873 for OTP
---
 drivers/net/usb/lan78xx.c | 55 ++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 8adf77e3557e..2fc9b9b138b0 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -85,6 +85,7 @@
 #define EEPROM_INDICATOR		(0xA5)
 #define EEPROM_MAC_OFFSET		(0x01)
 #define MAX_EEPROM_SIZE			512
+#define MAX_OTP_SIZE			512
 #define OTP_INDICATOR_1			(0xF3)
 #define OTP_INDICATOR_2			(0xF7)
 
@@ -172,6 +173,7 @@
 #define INT_EP_GPIO_2			(2)
 #define INT_EP_GPIO_1			(1)
 #define INT_EP_GPIO_0			(0)
+#define LAN78XX_NET_FLAG_OTP		BIT(0)
 
 static const char lan78xx_gstrings[][ETH_GSTRING_LEN] = {
 	"RX FCS Errors",
@@ -446,6 +448,7 @@ struct lan78xx_net {
 	unsigned int		burst_cap;
 
 	unsigned long		flags;
+	u32			priv_flags;
 
 	wait_queue_head_t	*wait;
 	unsigned char		suspend_count;
@@ -1542,6 +1545,10 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 
 static int lan78xx_ethtool_get_eeprom_len(struct net_device *netdev)
 {
+	struct lan78xx_net *dev = netdev_priv(netdev);
+
+	if (dev->priv_flags & LAN78XX_NET_FLAG_OTP)
+		return MAX_OTP_SIZE;
 	return MAX_EEPROM_SIZE;
 }
 
@@ -1555,9 +1562,10 @@ static int lan78xx_ethtool_get_eeprom(struct net_device *netdev,
 	if (ret)
 		return ret;
 
-	ee->magic = LAN78XX_EEPROM_MAGIC;
-
-	ret = lan78xx_read_raw_eeprom(dev, ee->offset, ee->len, data);
+	if (dev->priv_flags & LAN78XX_NET_FLAG_OTP)
+		ret = lan78xx_read_raw_otp(dev, ee->offset, ee->len, data);
+	else
+		ret = lan78xx_read_raw_eeprom(dev, ee->offset, ee->len, data);
 
 	usb_autopm_put_interface(dev->intf);
 
@@ -1577,30 +1585,39 @@ static int lan78xx_ethtool_set_eeprom(struct net_device *netdev,
 	/* Invalid EEPROM_INDICATOR at offset zero will result in a failure
 	 * to load data from EEPROM
 	 */
-	if (ee->magic == LAN78XX_EEPROM_MAGIC)
-		ret = lan78xx_write_raw_eeprom(dev, ee->offset, ee->len, data);
-	else if ((ee->magic == LAN78XX_OTP_MAGIC) &&
-		 (ee->offset == 0) &&
-		 (ee->len == 512) &&
-		 (data[0] == OTP_INDICATOR_1))
-		ret = lan78xx_write_raw_otp(dev, ee->offset, ee->len, data);
+	if (dev->priv_flags & LAN78XX_NET_FLAG_OTP) {
+		/* Beware!  OTP is One Time Programming ONLY! */
+		if (ee->magic == LAN78XX_OTP_MAGIC)
+		    ret = lan78xx_write_raw_otp(dev, ee->offset, ee->len, data);
+	} else {
+		if (ee->magic == LAN78XX_EEPROM_MAGIC)
+		    ret = lan78xx_write_raw_eeprom(dev, ee->offset, ee->len, data);
+	}
 
 	usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
 
+static const char lan78xx_priv_flags_strings[][ETH_GSTRING_LEN] = {
+	"OTP_ACCESS",
+};
+
 static void lan78xx_get_strings(struct net_device *netdev, u32 stringset,
 				u8 *data)
 {
 	if (stringset == ETH_SS_STATS)
 		memcpy(data, lan78xx_gstrings, sizeof(lan78xx_gstrings));
+	else if (stringset == ETH_SS_PRIV_FLAGS)
+		memcpy(data, lan78xx_priv_flags_strings, sizeof(lan78xx_priv_flags_strings));
 }
 
 static int lan78xx_get_sset_count(struct net_device *netdev, int sset)
 {
 	if (sset == ETH_SS_STATS)
 		return ARRAY_SIZE(lan78xx_gstrings);
+	else if (sset == ETH_SS_PRIV_FLAGS)
+		return ARRAY_SIZE(lan78xx_priv_flags_strings);
 	else
 		return -EOPNOTSUPP;
 }
@@ -1617,6 +1634,22 @@ static void lan78xx_get_stats(struct net_device *netdev,
 	mutex_unlock(&dev->stats.access_lock);
 }
 
+static u32 lan78xx_ethtool_get_priv_flags(struct net_device *netdev)
+{
+	struct lan78xx_net *dev = netdev_priv(netdev);
+
+	return dev->priv_flags;
+}
+
+static int lan78xx_ethtool_set_priv_flags(struct net_device *netdev, u32 flags)
+{
+	struct lan78xx_net *dev = netdev_priv(netdev);
+
+	dev->priv_flags = flags;
+
+	return 0;
+}
+
 static void lan78xx_get_wol(struct net_device *netdev,
 			    struct ethtool_wolinfo *wol)
 {
@@ -1905,6 +1938,8 @@ static const struct ethtool_ops lan78xx_ethtool_ops = {
 	.get_eeprom	= lan78xx_ethtool_get_eeprom,
 	.set_eeprom	= lan78xx_ethtool_set_eeprom,
 	.get_ethtool_stats = lan78xx_get_stats,
+	.get_priv_flags = lan78xx_ethtool_get_priv_flags,
+	.set_priv_flags = lan78xx_ethtool_set_priv_flags,
 	.get_sset_count = lan78xx_get_sset_count,
 	.get_strings	= lan78xx_get_strings,
 	.get_wol	= lan78xx_get_wol,
-- 
2.43.0


