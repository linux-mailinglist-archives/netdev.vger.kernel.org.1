Return-Path: <netdev+bounces-111655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1627931FC8
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FB1B216E3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 05:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770A15491;
	Tue, 16 Jul 2024 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vweVPmr9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97A196;
	Tue, 16 Jul 2024 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721106021; cv=none; b=AVUmZzkY84jgeFUkVdZjtyGDaSW6S35mtsA+wx4bp2ztypqtehm+nDPDCBnhHdbgKzPVVW7CPDheGowz00sJh8gi3C2MpdTT2p1/aNWgNpCBsHdhCPuSi0RV1edGSs2S3bI94V+tT8LtseWvsmk2or0z7y5B83qiJ/gsH4QFGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721106021; c=relaxed/simple;
	bh=pTwIjEIFp01nFL8bVmeWIWztWDImcVA5oCWrlzaWhS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PPTXLUtgaSt3lDfqEkuLfzkTH221TmIjB9F7LOocbCpF79SgeCRlIzgs3N0SMW9wUdNXeBnUpNzgFKVUobg+RvMc0MoPBcfr4QH97dIV/swzMe0JTkyQO6ot346l2UqzC7CAdoYudl6dPIjU/zdEGfDm/f6MmuzjRrMnpdxQA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vweVPmr9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721106019; x=1752642019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pTwIjEIFp01nFL8bVmeWIWztWDImcVA5oCWrlzaWhS0=;
  b=vweVPmr9eBT8fmYY9pT+yeDsxvroddzezhZWOUTMUIFi7dMPaGfKewDr
   GLXUU2qL3I4ymgIqHIsjq+k7cOxTKYDNfhgwV/hfzxHJUf7PH969EzPyl
   CzP0ILGOLtowo8RwcN4CS5wzlpzoD+7BeUqDTe1gVdedFf88Obi551WyE
   BCLOsxv5kUsQ5V1+I6FDe3AaO0+Sd0abeHmBIMoyva+xqGdC187cy4Z5c
   jjgVUrRz4i9FHsJLZABLn13belp77At7m3GV+JVrHOgaG9fPZqra6qBhT
   L6pFvmJT4Z0mm2WMgKmoWrt6X2M3B23JS++Xp5ajDc4s0go+svhSFaiAJ
   A==;
X-CSE-ConnectionGUID: 62SW0KjwQPSwDAhBVTpKjw==
X-CSE-MsgGUID: yDkkPmEITvGB3gm55T04eg==
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29927473"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 22:00:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 22:00:15 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jul 2024 22:00:12 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH v1 net-next] lan78xx: Refactor interrupt handling and redundant messages
Date: Tue, 16 Jul 2024 10:28:18 +0530
Message-ID: <20240716045818.1257906-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The MAC and PHY interrupt are not synchronized. When multiple phy
interrupt occur while the MAC interrupt is cleared, the phy handle
will not be called which causes the PHY interrupt to remain set
throughout. This is avoided by not clearing the MAC interrupt each
time. When the PHY interrupt is set, the MAC calls the PHY handle
and after processing the timestamp the PHY interrupt is cleared.
Also, avoided repetitive debug messages by replacing netdev_err
with netif_dbg.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/net/usb/lan78xx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 62dbfff8dad4..5f4e167ceeb0 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1421,11 +1421,6 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 	int ladv, radv, ret, link;
 	u32 buf;
 
-	/* clear LAN78xx interrupt status */
-	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
-	if (unlikely(ret < 0))
-		return ret;
-
 	mutex_lock(&phydev->lock);
 	phy_read_status(phydev);
 	link = phydev->link;
@@ -1518,7 +1513,7 @@ static void lan78xx_defer_kevent(struct lan78xx_net *dev, int work)
 {
 	set_bit(work, &dev->flags);
 	if (!schedule_delayed_work(&dev->wq, 0))
-		netdev_err(dev->net, "kevent %d may have been dropped\n", work);
+		netif_dbg(dev, intr, dev->net, "kevent %d may have been dropped\n", work);
 }
 
 static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
-- 
2.25.1


