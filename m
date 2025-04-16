Return-Path: <netdev+bounces-183293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B18A8B98D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83843B9EA0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBBD1494BB;
	Wed, 16 Apr 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TDiqHdHf"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC0184E;
	Wed, 16 Apr 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807622; cv=none; b=n2XNcDQ4O4MX51BdyiOd2d1FK/GELzN93p2ZXNXg+zbZDJuduflv7mUMhNXDj9erZXMawTgB8R8wrWvYC2GUY9uUJeG65iGfMF/ZL2J5HStD95DOEWjRFhQuo9/ifVOVpLNsz7viBedC7HmnYsgHYyiy0HuKy5v28zCKaKSKa/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807622; c=relaxed/simple;
	bh=D4eEpj/ycymL1dKwAiypTkZdxNwjEWty1bTxfH4ci8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvF8qwQYiU/8TL6VaW6FU8/yPeDkJJgnSVvATTaomZUaBeh5d9MAqOOAz/35iktR03nrJ4LNrgn2pRVM2sH2SzKUKP9hVcvu5vGv6za2e5j80zayLE+3Iv57nkDv+7nbh3kRe02wDlvCUtVh1rbhI6XuFLHW9O77ysGOXyqVPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TDiqHdHf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53GCkez973270922, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744807600; bh=D4eEpj/ycymL1dKwAiypTkZdxNwjEWty1bTxfH4ci8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TDiqHdHfwhWcItRyA/PlHV99qFXUiMmF1sEVg0UlzdmKXqUESuxOSQa3Tbc07b22v
	 NKlWBh0bl1i9N+vxnvxwT6N7HosLzi77JvRnW5JMSUyg5CTPVmK2OfjSDWsOIqO3Lk
	 ZEkRDWTVVHfZYZ6urCM73sRo3eo8NWZUIeK6A33CQk3i+2zfnjcsmZnpm3KZjkT8aY
	 Vl4s8yQd8k0/jjiPzCp2I+mxO8n8SSuoNE53mA9SrbJ5DWTEnMpeanHhlRMebuiXTf
	 dd5wk/pbdy8rbG4CFBrcSRY4zVTDB05siwPCG2iSLHddZioq8ylKquWp9QMTlAIUsQ
	 1ki/mo75Pdquw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53GCkez973270922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 20:46:40 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 20:46:41 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 20:46:40 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH net v2 2/3] rtase: Fix the compile warning reported by the kernel test robot
Date: Wed, 16 Apr 2025 20:45:33 +0800
Message-ID: <20250416124534.30167-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416124534.30167-1-justinlai0215@realtek.com>
References: <20250416124534.30167-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Fix the following compile warning reported by the kernel test robot by
increasing the size of ivec->name.

drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_open':
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:52: warning:
'%i' directive output may be truncated writing between 1 and 10 bytes
into a region of size between 7 and 22 [-Wformat-truncation=]
     snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
                                                     ^~
 drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:45: note:
 directive argument in the range [0, 2147483647]
     snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
                                              ^~~~~~~~~~
 drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:4: note:
 'snprintf' output between 6 and 30 bytes into a destination of
 size 26
     snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       tp->dev->name, i);
       ~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.com/
Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 2bbfcad613ab..1e63b5826da1 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -259,7 +259,7 @@ union rtase_rx_desc {
 #define RTASE_VLAN_TAG_MASK     GENMASK(15, 0)
 #define RTASE_RX_PKT_SIZE_MASK  GENMASK(13, 0)
 
-#define RTASE_IVEC_NAME_SIZE (IFNAMSIZ + 10)
+#define RTASE_IVEC_NAME_SIZE (IFNAMSIZ + 14)
 
 struct rtase_int_vector {
 	struct rtase_private *tp;
-- 
2.34.1


