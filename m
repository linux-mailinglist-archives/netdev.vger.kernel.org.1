Return-Path: <netdev+bounces-186655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F41AA01D5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4B3A6EE3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E623E26FD9E;
	Tue, 29 Apr 2025 05:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cAYCecKS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006226F47F;
	Tue, 29 Apr 2025 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904577; cv=none; b=hyynznumzaug/gpMBcGYkJIvZGyhNuDPgxq+NE5dCWAMgRn70H5nnQSShIfUb5NV0MUSI2Ym5xJynU5aULhBkmvbnV8e1A3FV1xj0wp1wqsgnLiLuUVAFNZDvMR91UE0rOr6zzo1ffqIwUo32YL6F10rHfStIuEna10bUik+TRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904577; c=relaxed/simple;
	bh=Lv3e47k2fwPuD/LA71tXJaD4eBI796WRIGkmveFhIiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GojUG9NkGdxO8uNam4e6s6mM9RA5hdQzMs72vU/QMWDTxS26MEYnLCy0yzeCcj3whI4lbBe8yPO3TEk4vKwpkv4DeCH8+iFiwWwj+hJ5A2WbrVuqvKYwxe/wntOFl1jqhYlqshruH9FcIWDJ64lsbYahtYMI/BclqtWCkcQO7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cAYCecKS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1745904575; x=1777440575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lv3e47k2fwPuD/LA71tXJaD4eBI796WRIGkmveFhIiY=;
  b=cAYCecKSvRIAPyIFdw9kW2M9+IIMSsnrc7oVD8oOWTzHv0bJ8lOr8Qa8
   Q3MnXjsPn6oRBqajtWMR0wE0RFAGKMMsHZZISbc8aPqI3cedJZo9c+Gwn
   BNfHniMIYvfft/zvg+feYKWS+MjVSUbYOAazEcJLB76xFTzqy66x5igMF
   bh9natYCBW45JFRpvS35iJjt6L78UJQmkxUGU5EZZ1RmCEPfdBtiAMdD7
   p4UFOnmPfqMR1X7KpGfHnCDHsZ2FFbKYTDsups2ZYA0lVRk+XjJh6rqXL
   kRE+T0BhgySrOgSW0CogIeHRo31UMIC7cfdA7QoPXfph8Y4BLmbF21X/v
   g==;
X-CSE-ConnectionGUID: cBTODZR3SKuLWw3lXtWFog==
X-CSE-MsgGUID: nkpCiSi6Tdej7hMIR2hKDw==
X-IronPort-AV: E=Sophos;i="6.15,248,1739862000"; 
   d="scan'208";a="208513184"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 22:29:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 28 Apr 2025 22:28:49 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 28 Apr 2025 22:28:46 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net] net: lan743x: Fix memleak issue when GSO enabled
Date: Tue, 29 Apr 2025 10:55:27 +0530
Message-ID: <20250429052527.10031-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Always map the `skb` to the LS descriptor. Previously skb was
mapped to EXT descriptor when the number of fragments is zero with
GSO enabled. Mapping the skb to EXT descriptor prevents it from
being freed, leading to a memory leak

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
v1
-Intial Submission

v2
-Modify the description to imperative mood

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


