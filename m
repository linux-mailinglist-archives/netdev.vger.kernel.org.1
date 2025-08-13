Return-Path: <netdev+bounces-213294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A82B24765
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A392A3FD7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D982F49F1;
	Wed, 13 Aug 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cgT8KXDs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6574420;
	Wed, 13 Aug 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081255; cv=none; b=UBF+WdUV/aCPLpb4ZVthzW6vIYojVr+J15ZgIKVUhsBkQ/h2LdnLyiGaAiUr64ut5iF5euYDg/wkXuwchWCE1g76IZgM7iNSUXBinqaF0hDwKthA5wY8KZKv+Mr3NmG35tZNLZRs8/YdDTqYu7a7kgb9MowGaZv654Oqt4D4KsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081255; c=relaxed/simple;
	bh=RdQTeqQB8uoTlU13DhVu51bey3H2cntBXfP/WY0N2a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2cEs+OqnYZ9/ymk3CgEkfOqlxTEQ6QB+DCshqiQshgCeYb7PpAbBst2Kym5BOSLT5R6cd3gHY74BNeVi9NNWk1iumxDg4rd/Uaenfail667PMNqHNWGo5szuay2aaF0/w9HvWslhipi4PHXvpKaLo8PjVK0nOOVXSaG/fEFnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cgT8KXDs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755081253; x=1786617253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RdQTeqQB8uoTlU13DhVu51bey3H2cntBXfP/WY0N2a4=;
  b=cgT8KXDsZdgp7Qk6jRieyswytv+ZJpt9uCc7qm4Rctsff5ENT4T3wj3n
   N/lHw5tsympIfWG6GgMc7vV+fLOtZbWA0GH4s8dBmZLc2U2G9GUWHt0zI
   fLZoOb6k7QKGIf8A4ybovEPjuSUlCWsXDW9F95FD1zI3Gd6mnRU9kd9qr
   vmMNK77ap4PuDbYWeKhtFxSMyD9K5FLFyPVyQpvdKMZCazMHleX2TZfUc
   Gsr9rZgrm9t/WA8UPA1EwH8NSgbo+t1beo1G8YlCSIJVqAMp7AFUo1vjU
   tJnf7jpumkcLguUxwawRsl6fS3GvN1qR/2a3lAWkMhTMf7BHTeLRHiyE8
   w==;
X-CSE-ConnectionGUID: 7pl1KfoDRtWRHbFbwqg1xg==
X-CSE-MsgGUID: 02vxkrFKRsK/KyyW/r515w==
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="276535068"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2025 03:34:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 13 Aug 2025 03:34:07 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 13 Aug 2025 03:34:04 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net 1/2] microchip: lan865x: fix missing netif_start_queue() call on device open
Date: Wed, 13 Aug 2025 16:03:54 +0530
Message-ID: <20250813103355.70838-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813103355.70838-1-parthiban.veerasooran@microchip.com>
References: <20250813103355.70838-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This fixes an issue where the transmit queue is started implicitly only
the very first time the device is registered. When the device is taken
down and brought back up again (using `ip` or `ifconfig`), the transmit
queue is not restarted, causing packet transmission to hang.

Adding an explicit call to netif_start_queue() in lan865x_net_open()
ensures the transmit queue is properly started every time the device
is reopened.

Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index dd436bdff0f8..d03f5a8de58d 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -311,6 +311,8 @@ static int lan865x_net_open(struct net_device *netdev)
 
 	phy_start(netdev->phydev);
 
+	netif_start_queue(netdev);
+
 	return 0;
 }
 
-- 
2.34.1


