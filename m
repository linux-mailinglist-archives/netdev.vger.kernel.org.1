Return-Path: <netdev+bounces-124403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A59693BD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E831F222A5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0FF1D319D;
	Tue,  3 Sep 2024 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nZtG8mW5"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEF1D1748;
	Tue,  3 Sep 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345243; cv=none; b=brd2bfE3zZdTZfIS4kXwuzNNt9iAagaHdE6z4/JC1KGAZyZatPhTtLj0z47ciw+WMtcW/guou8de2yrnwAzB4qaJ61fy29HyR0eEjh+V+U8N1oIWVngWiFiyDKvxZ237q7UB/K1gSewmgCkyIo+tVQYq9gl9akDHidnQbavwyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345243; c=relaxed/simple;
	bh=IwoHeQks9yfQVFO+ivuyBZLp/aRuXZoPALr0BeIAjeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EUCUuvJFQ7cGi7dbLYNwZCSIN+HCx/mEVgKBzTBvrqcec/4X4Snz6FYkzXf5YXs6cXj+8eKfjVgdSGxcOIWUpuO5iefSmN/RpW38M9IdmU9B+e3gXD6idWrN9BZwCu2Dxvr8EGg8hqNBZKy8/s39p1Vt/gbYhL49LATlOw58qEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nZtG8mW5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4836XjyM6860748, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725345225; bh=IwoHeQks9yfQVFO+ivuyBZLp/aRuXZoPALr0BeIAjeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=nZtG8mW5UvPgLjPCAH/r/ksnBVqYM0QGH55ikNhTgmEueAy/7XqY/QOu5VO9Dza1k
	 2a0wDu0WM8eHTTAEpmfhXrnCNyRoIkLR5I5+y98pu6B2hGdoWksBz3F5D5rYebxHhR
	 mZWJV4t88AqjDt+9rL20kBOwq/OzgxYn1TPQH9v1zuBjAtGOP7Dpmpe8qyExvfYm+V
	 j2H+t1JhqEMjycnqvyLHa8SFM6thIbaU3337dvGXdghCEHXNUrXjhcesfPZVsqLJPq
	 tJ0xmLnp1IG8pF8TOjYX+VuYjtCDcKVZgQRnOQrJ2IgjIBYpdH9zLxwqLu0fpGRBsh
	 0qfVTcPfjX1Lg==
Received: from RSEXH36502.realsil.com.cn (doc.realsil.com.cn[172.29.17.3])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4836XjyM6860748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Tue, 3 Sep 2024 14:33:45 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RSEXH36502.realsil.com.cn (172.29.17.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 14:33:45 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 14:33:45 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 3 Sep 2024 14:33:45 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net] r8152: fix the firmware doesn't work
Date: Tue, 3 Sep 2024 14:33:33 +0800
Message-ID: <20240903063333.4502-1-hayeswang@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

generic_ocp_write() asks the parameter "size" must be 4 bytes align.
Therefore, write the bp would fail, if the mac->bp_num is odd. Align the
size to 4 for fixing it. The way may write an extra bp, but the
rtl8152_is_fw_mac_ok() makes sure the value must be 0 for the bp whose
index is more than mac->bp_num. That is, there is no influence for the
firmware.

Besides, I check the return value of generic_ocp_write() to make sure
everything is correct.

Fixes: e5c266a61186 ("r8152: set bp in bulk")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 15e12f46d0ea..a5612c799f5e 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5178,14 +5178,23 @@ static void rtl8152_fw_mac_apply(struct r8152 *tp, struct fw_mac *mac)
 	data = (u8 *)mac;
 	data += __le16_to_cpu(mac->fw_offset);
 
-	generic_ocp_write(tp, __le16_to_cpu(mac->fw_reg), 0xff, length, data,
-			  type);
+	if (generic_ocp_write(tp, __le16_to_cpu(mac->fw_reg), 0xff, length,
+			      data, type) < 0) {
+		dev_err(&tp->intf->dev, "Write %s fw fail\n",
+			type ? "PLA" : "USB");
+		return;
+	}
 
 	ocp_write_word(tp, type, __le16_to_cpu(mac->bp_ba_addr),
 		       __le16_to_cpu(mac->bp_ba_value));
 
-	generic_ocp_write(tp, __le16_to_cpu(mac->bp_start), BYTE_EN_DWORD,
-			  __le16_to_cpu(mac->bp_num) << 1, mac->bp, type);
+	if (generic_ocp_write(tp, __le16_to_cpu(mac->bp_start), BYTE_EN_DWORD,
+			      ALIGN(__le16_to_cpu(mac->bp_num) << 1, 4),
+			      mac->bp, type) < 0) {
+		dev_err(&tp->intf->dev, "Write %s bp fail\n",
+			type ? "PLA" : "USB");
+		return;
+	}
 
 	bp_en_addr = __le16_to_cpu(mac->bp_en_addr);
 	if (bp_en_addr)
-- 
2.45.2


