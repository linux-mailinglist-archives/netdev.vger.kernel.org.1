Return-Path: <netdev+bounces-215960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C6B3124E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4D9164571
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDCC2DEA79;
	Fri, 22 Aug 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BCXSCf/j"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6EC21256B;
	Fri, 22 Aug 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852666; cv=none; b=bzO4MfYgX/wLEFoJa8D0/oDLUkiZTWdaTN6IGq9FTKOugyqH56zZrW7Oag3b2+RzXz04LQgKdCPlaEbGMXJY+jx4S3eVxymiEmlA0hVVxX+pio0piLB/twpcmCflgOPY5jrOGinxDMGOqFRxHububkbQ9gzbwlTB50FDhD55YEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852666; c=relaxed/simple;
	bh=/Pu6UCKCKbK1bU9RXeRKsFqLQBFR+f99I5yv8sqx0zg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=isQE/xtNdRT0eF2HiwJsc8mrKwZ+ppi67ln5J1J3rWwKUspZNzWGCA2xv/zh/KNnQiV8kbnoLDwEH5GQsVjJlrHEEPGd/Hj8xt3Ovgoaka1hLyS6+rBYw3uCexirwtuiCGxu62EFw0Fpk5W4ty1sjaPw/mos0H5vJ4buVkd2M2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BCXSCf/j; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755852663; x=1787388663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Pu6UCKCKbK1bU9RXeRKsFqLQBFR+f99I5yv8sqx0zg=;
  b=BCXSCf/j2AOgQe+PTjYyxm3B68ZVB/Jtsp9yHnOoujrygNsljbFZYBPM
   kz4SQvq6mW5F9xuN4J7sY6LcD9yF1P9xIY5fgcVrK8uAVOQuL/VA+wdZI
   ZASvloVOyDQliqGg4ip9NZpJrTJkA/DO9rhlVRU/uaLJMoKetkmzH/5oB
   V1vLUGhRAnKmtWX0byYLMvkvDoOuIR5DAi2nFzKSwRLdxOWMpiwtd9u2f
   WCCAI2EeBtzGmdTjDCpE8M8NE+JWw5f28cG/JBcKskFuS3GGKpkk9ceC7
   CUxhmJCEUcNt8ijVh4gIXQd75o5PiXn0gC5+FvHSEwV7nPJ/HSIs0obBo
   Q==;
X-CSE-ConnectionGUID: 2wOkSju3SAS0tdY4jSq2tA==
X-CSE-MsgGUID: GH+7K71xT6GQkGoDncHQEg==
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="44975094"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2025 01:51:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 22 Aug 2025 01:50:21 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 22 Aug 2025 01:50:18 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next] microchip: lan865x: add ndo_eth_ioctl handler to enable PHY ioctl support
Date: Fri, 22 Aug 2025 14:20:14 +0530
Message-ID: <20250822085014.28281-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce support for standard MII ioctl operations in the LAN865x
Ethernet driver by implementing the .ndo_eth_ioctl callback. This allows
userspace tools such as ethtool and mii-tool to perform PHY register
access using commands like SIOCGMIIREG and SIOCSMIIREG.

The new lan865x_eth_ioctl() function forwards these ioctl calls to the
PHY layer through phy_mii_ioctl() when the network interface is up.

This feature enables improved diagnostics and PHY configuration
capabilities from userspace.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 84c41f193561..7f586f9558ff 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -320,12 +320,22 @@ static int lan865x_net_open(struct net_device *netdev)
 	return 0;
 }
 
+static int lan865x_eth_ioctl(struct net_device *netdev, struct ifreq *rq,
+			     int cmd)
+{
+	if (!netif_running(netdev))
+		return -EINVAL;
+
+	return phy_mii_ioctl(netdev->phydev, rq, cmd);
+}
+
 static const struct net_device_ops lan865x_netdev_ops = {
 	.ndo_open		= lan865x_net_open,
 	.ndo_stop		= lan865x_net_close,
 	.ndo_start_xmit		= lan865x_send_packet,
 	.ndo_set_rx_mode	= lan865x_set_multicast_list,
 	.ndo_set_mac_address	= lan865x_set_mac_address,
+	.ndo_eth_ioctl          = lan865x_eth_ioctl,
 };
 
 static int lan865x_probe(struct spi_device *spi)

base-commit: a7bd72158063740212344fad5d99dcef45bc70d6
-- 
2.34.1


