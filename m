Return-Path: <netdev+bounces-190719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9CAAB86AD
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0978E4E2C66
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B829993C;
	Thu, 15 May 2025 12:44:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9F297B97;
	Thu, 15 May 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313065; cv=none; b=dDrf4NHiS0U7uh0WRLMoQTbzvjGE6198t9A8e8MajC+CKpWpbB7+71zitbC6U6rbHA5t/p5gCqkFRX+T0DCMQNeS+W0IgosWfrCvItsqzsCnzgrxjZ4gTnQuwGPjpJEgii/tEqkrlnpA+/dlHgifmN/ZN5W6lE7Dqf38lPFcoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313065; c=relaxed/simple;
	bh=sB8y6Gz5gTffJYTi4xWoNeuZb9+zLlzfjmsG7LcZOAk=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=dFKOP2fwkf+YN4rFJVxtDMM8RdjN4deXMTZL5h27iQuwtJACwy3ktmIj1lXIpEis1QapVLfYOpwBEE2ozRoHW/rGhP9A4dEWf5N+y1fxbK65kruikzb+7rnpxZiLZFTGcaGCaKoqE3G7r5sp02Te4DL+j7InKb6xm0Trw+qtYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Zyqf73n23z51SY2;
	Thu, 15 May 2025 20:44:15 +0800 (CST)
Received: from njb2app05.zte.com.cn ([10.55.22.121])
	by mse-fl1.zte.com.cn with SMTP id 54FCiADT030587;
	Thu, 15 May 2025 20:44:11 +0800 (+08)
	(envelope-from long.yunjian@zte.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid201;
	Thu, 15 May 2025 20:44:14 +0800 (CST)
Date: Thu, 15 May 2025 20:44:14 +0800 (CST)
X-Zmail-TransId: 2af96825e19effffffff8ff-d246d
X-Mailer: Zmail v1.0
Message-ID: <20250515204414844_YQsk90Odo5a3bx9qvo8g@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <long.yunjian@zte.com.cn>
To: <anthony.l.nguyen@intel.com>
Cc: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fang.yumeng@zte.com.cn>, <xu.lifeng1@zte.com.cn>,
        <ouyang.maochun@zte.com.cn>, <mou.yi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG5ldDogZTEwMDogVXNlIHN0cl9yZWFkX3dyaXRlKCkgaGVscGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54FCiADT030587
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6825E19F.000/4Zyqf73n23z51SY2

From: Yumeng Fang <fang.yumeng@zte.com.cn>

Remove hard-coded strings by using the str_read_write() helper.

Signed-off-by: Yumeng Fang <fang.yumeng@zte.com.cn>
---
 drivers/net/ethernet/intel/e100.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index c0ead54ea186..ab93caab72bb 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -147,6 +147,7 @@
 #include <linux/firmware.h>
 #include <linux/rtnetlink.h>
 #include <linux/unaligned.h>
+#include <linux/string_choices.h>


 #define DRV_NAME		"e100"
@@ -946,7 +947,7 @@ static u16 mdio_ctrl_hw(struct nic *nic, u32 addr, u32 dir, u32 reg, u16 data)
 	spin_unlock_irqrestore(&nic->mdio_lock, flags);
 	netif_printk(nic, hw, KERN_DEBUG, nic->netdev,
 		     "%s:addr=%d, reg=%d, data_in=0x%04X, data_out=0x%04X\n",
-		     dir == mdi_read ? "READ" : "WRITE",
+		     str_read_write(dir == mdi_read),
 		     addr, reg, data, data_out);
 	return (u16)data_out;
 }
@@ -1009,7 +1010,7 @@ static u16 mdio_ctrl_phy_mii_emulated(struct nic *nic,
 		default:
 			netif_printk(nic, hw, KERN_DEBUG, nic->netdev,
 				     "%s:addr=%d, reg=%d, data=0x%04X: unimplemented emulation!\n",
-				     dir == mdi_read ? "READ" : "WRITE",
+				     str_read_write(dir == mdi_read),
 				     addr, reg, data);
 			return 0xFFFF;
 		}
@@ -1018,7 +1019,7 @@ static u16 mdio_ctrl_phy_mii_emulated(struct nic *nic,
 		default:
 			netif_printk(nic, hw, KERN_DEBUG, nic->netdev,
 				     "%s:addr=%d, reg=%d, data=0x%04X: unimplemented emulation!\n",
-				     dir == mdi_read ? "READ" : "WRITE",
+				     str_read_write(dir == mdi_read),
 				     addr, reg, data);
 			return 0xFFFF;
 		}
-- 
2.25.1

