Return-Path: <netdev+bounces-215541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C245B2F1A2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EBD7A27E0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96382EB873;
	Thu, 21 Aug 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YvpjYnCD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B92EB861;
	Thu, 21 Aug 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764940; cv=none; b=H+4z6cS9VH12z+bYsTY6zJKKB+OynKKFhwKptuPCbbTMYTDMvmj9JWVBRuifOoil1c4R9Hx0/qnaZW6dtNY96vcvhjfwdydQgX7jY6TWvcY0KFg7xYAxhj/XoETH9hCmvV1jTYFpTLowyQHiEK0RYerkIKeX11Yin9raoGsWJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764940; c=relaxed/simple;
	bh=jH1hutM5AnkBX/bpIXkHgthMbiBJU2SdnIuhANxvH+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rLHBuFXzEJy3bw33w5FVVwyPnEDL+pL8e8fS9c7fkPoWKjv5mbPMTLLCcw7F+fNwX8R2LcCZXrvmpLZzJyvPr9MoCkW5kvrWRiNqHjaarrraCRpQSXjER+rN0jac36oVZ2NEZAiO9nYws4Bs/MeoxKB7viiEm4rREDxwt65zVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YvpjYnCD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755764939; x=1787300939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jH1hutM5AnkBX/bpIXkHgthMbiBJU2SdnIuhANxvH+8=;
  b=YvpjYnCDr7EKBMHLceWuIg7bgH6Ymkwp31v8Wtd8qFttNqLZd+L74EN3
   0Loiclo2eL5LmYSAqXOrjCxwROX8d5JVVMiB4BZ1fhEnnFR3S6cNM+cQz
   tkF3+YIZgl8cypROzO88RaJY6HsbJA2vrakYriIFE2NDWR1Rfe1dx66Dz
   gw1ElrS4NxG71Cppn1oSdHlTVJwwlMPdmzNjoWBIAUh0M40heY7H8Im8v
   AJ2ocxmGZoBeeQtabhEVnFOykodKMJiZShAswVyMGYFu2hj9xSWc1x6yX
   dC7uid6m8pRx9gWB17nnm8QLox9TyNrKn1rjAjxqHQHPAaiT0SA1FdY4F
   g==;
X-CSE-ConnectionGUID: IVCZus4uRhWp81WseQpWbA==
X-CSE-MsgGUID: gIp++s86RLyLDUfl1zDHMA==
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="276868160"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2025 01:28:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 21 Aug 2025 01:28:39 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 21 Aug 2025 01:28:36 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net] microchip: lan865x: fix missing ndo_eth_ioctl handler to support PHY ioctl
Date: Thu, 21 Aug 2025 13:58:32 +0530
Message-ID: <20250821082832.62943-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The LAN865x Ethernet driver is missing an .ndo_eth_ioctl implementation,
which is required to handle standard MII ioctl commands such as
SIOCGMIIREG and SIOCSMIIREG. These commands are used by userspace tools
(e.g., ethtool, mii-tool) to access and configure PHY registers.

This patch adds the lan865x_eth_ioctl() function to pass ioctl calls to
the PHY layer via phy_mii_ioctl() when the interface is up.

Without this handler, MII ioctl operations return -EINVAL, breaking PHY
diagnostics and configuration from userspace.

Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index dd436bdff0f8..09e6a0406350 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -314,12 +314,22 @@ static int lan865x_net_open(struct net_device *netdev)
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

base-commit: 62a2b3502573091dc5de3f9acd9e47f4b5aac9a1
-- 
2.34.1


