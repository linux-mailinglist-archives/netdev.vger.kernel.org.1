Return-Path: <netdev+bounces-183661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EEDA9171F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5125A0FD3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1522541D;
	Thu, 17 Apr 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mV2t4W5l"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4AB1E32C6;
	Thu, 17 Apr 2025 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880305; cv=none; b=oAShGPokXU4YpMlm2pzY6LxdIdC9cSvvhWvLHYxx8fB/wF5aEILEhdKsGiUYb6UKWP+pfPKEBNw79L4sGACfUWQPgDhc5wqPa6v834uUmZoPWzgGpGui0bd1mOeVNuNfPp8SgirDmbi2YQl9QuWP00LMTUtd3UE02dEB2yKGVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880305; c=relaxed/simple;
	bh=D4eEpj/ycymL1dKwAiypTkZdxNwjEWty1bTxfH4ci8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9vsg/p2TojWIk2qQP6t2WuyCawHSpyLZB6zcW/w//4IHaIOfAvMCJCwAYaK2LXC4+rJMUu7tJoG7rZBRSqTJzTHNEnqqejiFV8aIOviGB2uEXds24pjDTYyh0LbbG5wCDwTJJEhV9VYV83UiYNHitnvaw+UMSiTrhi9Sgs56d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mV2t4W5l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53H8w3gV5617659, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744880283; bh=D4eEpj/ycymL1dKwAiypTkZdxNwjEWty1bTxfH4ci8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mV2t4W5lS2/AX8hvkT04l5I0xOB7x886rAX6j953w6kEWoOByudPDZZDt7cAYPKzr
	 nUowBOi6LATprOSZOlekkwdjhO9rSjg9btSjYH7LhhZQe6m5hGy+21evlULT6H+iNM
	 gAZ4gv5YFYzF3ypD+DwOIiTKyuJSALD2IkQfzJeyyr/PcckF5WcE5yPrztGoNzwixG
	 EpKIea3WDtzWR/Ac9gAa97omDIE7nsy82yNXlLyfUBu0BxZQ4ADPsEpSzaXontJRFl
	 t3+ME03yfF0pqEg+e/WKLMc8Ns56Ks4TtHHND7lf+PFT6wmnyZ0TovQfEmHtscgvVa
	 RIGgO0XQ4Hecw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53H8w3gV5617659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:58:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Apr 2025 16:58:04 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 17 Apr
 2025 16:58:03 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH net v3 2/3] rtase: Increase the size of ivec->name
Date: Thu, 17 Apr 2025 16:56:58 +0800
Message-ID: <20250417085659.5740-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417085659.5740-1-justinlai0215@realtek.com>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

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


