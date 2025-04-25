Return-Path: <netdev+bounces-185840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2EFA9BD9C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 06:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B937B1BA3537
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ACD19DF98;
	Fri, 25 Apr 2025 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FO53vZrz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA78134CF;
	Fri, 25 Apr 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555554; cv=none; b=Z1w2cr4VppNmNgRXQyBmD47V1S9rL+AWYYbA/AfeufIaXOSJFgvoPZK2HIynkwLN0IpI9fCw7VfIHee0Th009mw75bExHBRbTq12AHNhHue0W1j/9lHueCDQGRa5b1ox2h/Q50amTw92MJYfUdtEVLOfZ/XK134oXdQ3Do6ZjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555554; c=relaxed/simple;
	bh=zjF9JaePE0iVCghtEj4B1rUwWxnrzjj6eVYVCPmvMNs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CM+q8YZxcqAUvGNzapLm8rrT4Yab42oYIT0QthXhJuqOSPgNyz99rZMvi34pbMAkW2L0Tp5ozwT2qQvlVYVAM2RkjRsX8anr1s08GLav4D+f8DZmkTl4oC1D73OqcskACXDjUUR8WlklOOJCixdZh3NiJOJGo2XPw4ka324WYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FO53vZrz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1745555553; x=1777091553;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zjF9JaePE0iVCghtEj4B1rUwWxnrzjj6eVYVCPmvMNs=;
  b=FO53vZrz0AydtgHmCxVqKXHJLtYZTJwvCSGHXKh1iZ546qXZ0ySApM0u
   fWbnvZLuwQlCANK5JoyvYPxl47OQlelvocWAkKnLaNdWxzlOTHTG4nvQ0
   a+8usQUO6f/O1jTLQtDRp6rlgWHsj6rUVCmNuDkAWrcXVRZKMHuCqQ3zz
   CUJr+0bcSrVIwVuYuCkNi+K0ejfx/S6IWllXl5UbEEGT1VwlX/SjroLRh
   xUJU0f1pE/QQi9rv6lIl69E48xIuMNM9Q0g3xcKU6Ja+BjycOkelm9G0u
   FPzdEJOYzjOnI2UmRu2cKXASdo2rLqncYVWaAvS8cTS3hAgjxNTt6i92B
   w==;
X-CSE-ConnectionGUID: Q9SVwF29Twemz3224Z21Zw==
X-CSE-MsgGUID: Z2WZZaR1RDiB+f+XT4/lZA==
X-IronPort-AV: E=Sophos;i="6.15,238,1739862000"; 
   d="scan'208";a="40884322"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2025 21:32:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Apr 2025 21:32:11 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 24 Apr 2025 21:32:08 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net] net: lan743x: Fix memory leak when GSO enabled
Date: Fri, 25 Apr 2025 09:58:53 +0530
Message-ID: <20250425042853.21653-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The current implementation tracks the `skb` by linking it to the
LS descriptor when the  number of fragments is greater than zero,
and to the EXT descriptor when the number of fragments is zero
with GSO enabled. However, when the `skb` is mapped to the EXT
descriptor, it is not freed resulting in a memory leak. The
implementation has been modified to always map the `skb` to the
last descriptor and always be properly freed.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 8 ++++++--
 drivers/net/ethernet/microchip/lan743x_main.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 8b6b9b6efe18..73dfc85fa67e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1815,6 +1815,7 @@ static void lan743x_tx_frame_add_lso(struct lan743x_tx *tx,
 	if (nr_frags <= 0) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_first;
 	}
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
@@ -1884,6 +1885,7 @@ static int lan743x_tx_frame_add_fragment(struct lan743x_tx *tx,
 		tx->frame_first = 0;
 		tx->frame_data0 = 0;
 		tx->frame_tail = 0;
+		tx->frame_last = 0;
 		return -ENOMEM;
 	}
 
@@ -1924,16 +1926,18 @@ static void lan743x_tx_frame_end(struct lan743x_tx *tx,
 	    TX_DESC_DATA0_DTYPE_DATA_) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_tail;
 	}
 
-	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
-	buffer_info = &tx->buffer_info[tx->frame_tail];
+	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_last];
+	buffer_info = &tx->buffer_info[tx->frame_last];
 	buffer_info->skb = skb;
 	if (time_stamp)
 		buffer_info->flags |= TX_BUFFER_INFO_FLAG_TIMESTAMP_REQUESTED;
 	if (ignore_sync)
 		buffer_info->flags |= TX_BUFFER_INFO_FLAG_IGNORE_SYNC;
 
+	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
 	tx->frame_tail = lan743x_tx_next_index(tx, tx->frame_tail);
 	tx->last_tail = tx->frame_tail;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 7f73d66854be..db5fc73e41cc 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -980,6 +980,7 @@ struct lan743x_tx {
 	u32		frame_first;
 	u32		frame_data0;
 	u32		frame_tail;
+	u32		frame_last;
 
 	struct lan743x_tx_buffer_info *buffer_info;
 
-- 
2.25.1


