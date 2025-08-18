Return-Path: <netdev+bounces-214448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E2B2995B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE123A7D79
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99152701CC;
	Mon, 18 Aug 2025 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EfZ7x04B"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0E26FA70;
	Mon, 18 Aug 2025 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497224; cv=none; b=QWTPzfttRG8rHmJUVJf8cqiuWxqD0/gTWc5WA66dcJhQn4q19c8po7Oj7MnAIT++uFMr8O3e3fGyoHqKkN0csBDqgBR+esrvCmTw8Z3VuIjKOyhg5PuhX41+SlpHAfALWyfN0hko54MkAYnKdFfZ7ab0Kz2oHPG/t+6R5p6qVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497224; c=relaxed/simple;
	bh=RdQTeqQB8uoTlU13DhVu51bey3H2cntBXfP/WY0N2a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNabO1jkyJ6HewPmtGt25gA90QWf6kcsDvTQsNgShqB5BHXe0hzo8BZmo4MeS7kKFaxnyuO/JDpjysT970FWR9RdoFSzURbeEjxFQ4vAzeS9TUKZK/jJv3G1R5BJntGZVnotTxVln5u+aJivvYiujjwoqmkS8FYEUfGMXW9upbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EfZ7x04B; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755497223; x=1787033223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RdQTeqQB8uoTlU13DhVu51bey3H2cntBXfP/WY0N2a4=;
  b=EfZ7x04BsxIFhU3thdj+ZbgBzKI+FmrKVK27k/bfoXr27o8dhCoyOEJw
   uIhPGI+o9lpnSyUv9qQbk01U3/vwxUwVEMkxS+g3zny8bniH5pVZLYfiI
   Xh5vQ1vpJRVsVew0W+AeEeEN3QwnVrIcMu8et1vMlQ3vALI6+xfI+eK2V
   NU55WSogTiNlFCegy84/EORejWpbWIdlIVT105oim02cVfv3BKRLro1Yv
   fPHFcUZZtZAzWlrwUnwkH93OQWjVSIkmDoXiof1PwegL72c5ZKW8DTs4b
   iENIycBp5diBN5O6nMuwEgoSS+j5MyCglPN3JKlAMC+zaeZrzQqZocFU2
   w==;
X-CSE-ConnectionGUID: jhrJsGctQCiiFoS1UDzbFg==
X-CSE-MsgGUID: sSwgepzARQ6+4qdZL0QTJg==
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="50850432"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2025 23:05:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 17 Aug 2025 23:05:23 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 17 Aug 2025 23:05:20 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net v2 1/2] microchip: lan865x: fix missing netif_start_queue() call on device open
Date: Mon, 18 Aug 2025 11:35:13 +0530
Message-ID: <20250818060514.52795-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818060514.52795-1-parthiban.veerasooran@microchip.com>
References: <20250818060514.52795-1-parthiban.veerasooran@microchip.com>
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


