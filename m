Return-Path: <netdev+bounces-95652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEDE8C2EFA
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D69282E2F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77151E89C;
	Sat, 11 May 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Wh5jWAj6"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D147A57;
	Sat, 11 May 2024 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393726; cv=none; b=O2s0Z3diVWUChJ7p21t/j2cvQGXYiGRMjZMaLPmmfWT+aXhuGbBQBJ5zUXNCdfV7wF5JrhKYXjGKG5UglyRcBh524wjtZ6SGk+LTcJLwviW4kjkInBwuTd2cGZ7YYwTlosGywTwC1aaeXQnvhXAxPv5w2deQ05vRDN2VGx0HugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393726; c=relaxed/simple;
	bh=l8+FFc5NYXSgcU89nPC2vhD5HSbSxYtsotzn+MbScqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SwqcKfuvb6w9aIrF9PeJMRT+qRKYQHqtfcE8vo7n0Gim6dA/ZmUveb6XTZPjD34EVMx+/2+jPGNCjJXKp9Q+2Nf7YVQzon/XbeHYxLB968lEufbrv+VDW3ayqsUcfgGzW3bGzlzgK+96HSXfXuNTrCu/FMw/5Xe4vfBgbh4ewd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Wh5jWAj6; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715393699; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=J0RjhF8artoRsEJWmf6wYLdXWqFxXMkVDUuaSefLKSw=;
	b=Wh5jWAj6najeqZyu/dPQJxchDtjji+NzQNnD3HwRq3sHaCw4MYcmxCwzrEERhZa0+x03l9X11/8BYihDJ7VBVuB8+R36ICsRANbyN4xcnYjsI6n6l+FlCNItS1v1WUwzwCP0yebHT23utNlehe8FUddIRT2NFEXQCDQmNwBdQYc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6Bjjv3_1715393690;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W6Bjjv3_1715393690)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 10:14:58 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] tulip: eeprom: clean up some inconsistent indenting
Date: Sat, 11 May 2024 10:14:48 +0800
Message-Id: <20240511021448.80526-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/net/ethernet/dec/tulip/eeprom.c:179 tulip_parse_eeprom() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9001
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/ethernet/dec/tulip/eeprom.c | 37 +++++++++++++------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/eeprom.c b/drivers/net/ethernet/dec/tulip/eeprom.c
index d5657ff15e3c..738c01d859cf 100644
--- a/drivers/net/ethernet/dec/tulip/eeprom.c
+++ b/drivers/net/ethernet/dec/tulip/eeprom.c
@@ -175,25 +175,26 @@ void tulip_parse_eeprom(struct net_device *dev)
 					dev->name);
 			return;
 		}
-	  /* Do a fix-up based on the vendor half of the station address prefix. */
-	  for (i = 0; eeprom_fixups[i].name; i++) {
-		  if (dev->dev_addr[0] == eeprom_fixups[i].addr0 &&
-		      dev->dev_addr[1] == eeprom_fixups[i].addr1 &&
-		      dev->dev_addr[2] == eeprom_fixups[i].addr2) {
-		  if (dev->dev_addr[2] == 0xE8 && ee_data[0x1a] == 0x55)
-			  i++;			/* An Accton EN1207, not an outlaw Maxtech. */
-		  memcpy(ee_data + 26, eeprom_fixups[i].newtable,
-				 sizeof(eeprom_fixups[i].newtable));
-		  pr_info("%s: Old format EEPROM on '%s' board.  Using substitute media control info\n",
-			  dev->name, eeprom_fixups[i].name);
-		  break;
+		/* Do a fix-up based on the vendor half of the station address prefix. */
+		for (i = 0; eeprom_fixups[i].name; i++) {
+			if (dev->dev_addr[0] == eeprom_fixups[i].addr0 &&
+			    dev->dev_addr[1] == eeprom_fixups[i].addr1 &&
+			    dev->dev_addr[2] == eeprom_fixups[i].addr2) {
+				if (dev->dev_addr[2] == 0xE8 && ee_data[0x1a] == 0x55)
+					i++; /* An Accton EN1207, not an outlaw Maxtech. */
+				memcpy(ee_data + 26, eeprom_fixups[i].newtable,
+				       sizeof(eeprom_fixups[i].newtable));
+				pr_info("%s: Old format EEPROM on '%s' board.  Using substitute media control info\n",
+					dev->name, eeprom_fixups[i].name);
+				break;
+			}
+		}
+		/* No fixup found. */
+		if (!eeprom_fixups[i].name) {
+			pr_info("%s: Old style EEPROM with no media selection information\n",
+				dev->name);
+			return;
 		}
-	  }
-	  if (eeprom_fixups[i].name == NULL) { /* No fixup found. */
-		  pr_info("%s: Old style EEPROM with no media selection information\n",
-			  dev->name);
-		return;
-	  }
 	}
 
 	controller_index = 0;
-- 
2.20.1.7.g153144c


