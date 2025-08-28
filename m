Return-Path: <netdev+bounces-217757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A398B39BED
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADB37AE707
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712829AB0E;
	Thu, 28 Aug 2025 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P+dy/ZC8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69727A13D;
	Thu, 28 Aug 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381601; cv=none; b=aUZyJXhAdewuiQKX4cRifHzfUqjkFbirm9tJliHWHq1Z7VU/fBeFjXINd+Y1Scz6ioglTFEgYwtmUrAkloUbIRiKuXLRINAtaG8WHYUhfP/JvMUYLRybjcZkfVS0TMPi8dj4zbNnV0uNHMP2aD1XZ6MhduUGr91stiundLob6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381601; c=relaxed/simple;
	bh=B4gw0+6Ow3oDOb1XZabWlH/xg0VjGJze/LsazYjLx00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O1VZUChWPvl7Yk756i1iLPPUxFmx8KA2kxdqpoJGYwIPfXEH8w6Gx6DbLzqwnibZuQLxAH9muFoS7Lr7EZsKmGH6gbtcerrTsnKzRNSi1+uIQBJS32oNLippHFqx2ktNqq5Xi7ARI4kMC0Q7Z1ByFvOxnMB6kD2eZSkC70rUXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P+dy/ZC8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756381600; x=1787917600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B4gw0+6Ow3oDOb1XZabWlH/xg0VjGJze/LsazYjLx00=;
  b=P+dy/ZC8nyAMG/RWufQdBiVugUw76Q8sD64B3bjaHHyovqhXIi+sENWH
   rRh1A0qR+2r0PbSoVUNytW9mvjZNid4D0IBh49+g9MP1YOq2trVQag05P
   WZOAgnHOrYdPGzKr2o35Tl128+ixHnNea6a0E5Wr1GWNvoE+FOKRCvtM/
   8XJY11dJ9ZiquGALPEVhMMrryb9b7YG6tYHRmgs//ZUl9Lgu/LmqabFjN
   E51jPSp7vg9BiRXMFObfQvUbOzh3URuqPAIYxLqJcRLBZ0I0bTcPjqSkD
   SKelf7i3NJcakDlGpFQGyC6GclhY0ru6d/P8ntNv0r0Rf/k2xts7sRvZb
   w==;
X-CSE-ConnectionGUID: papHqfZvQdSzLVAcs06GLg==
X-CSE-MsgGUID: o15sR3c5ToCt9FaszvYYvg==
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="277148031"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2025 04:46:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 28 Aug 2025 04:45:58 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 28 Aug 2025 04:45:56 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2] microchip: lan865x: add ndo_eth_ioctl handler to enable PHY ioctl support
Date: Thu, 28 Aug 2025 17:15:49 +0530
Message-ID: <20250828114549.46116-1-parthiban.veerasooran@microchip.com>
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
PHY-related ioctl commands to be handled via phy_do_ioctl_running() and
enables support for ethtool and other user-space tools that rely on ioctl
interface to perform PHY register access using commands like SIOCGMIIREG
and SIOCSMIIREG.

This feature enables improved diagnostics and PHY configuration
capabilities from userspace.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
v2:
- Replaced custom lan865x_eth_ioctl() with direct use of
  phy_do_ioctl_running() to avoid code duplication.
- Updated commit message to reflect the new change.
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 84c41f193561..f7cb685b1562 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -326,6 +326,7 @@ static const struct net_device_ops lan865x_netdev_ops = {
 	.ndo_start_xmit		= lan865x_send_packet,
 	.ndo_set_rx_mode	= lan865x_set_multicast_list,
 	.ndo_set_mac_address	= lan865x_set_mac_address,
+	.ndo_eth_ioctl          = phy_do_ioctl_running,
 };
 
 static int lan865x_probe(struct spi_device *spi)

base-commit: d4854be4ec21dad23907c0fbc3389c3a394ebf67
-- 
2.34.1


