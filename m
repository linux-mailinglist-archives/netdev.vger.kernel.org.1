Return-Path: <netdev+bounces-98777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241708D270C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550011C21868
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7581317B421;
	Tue, 28 May 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qggBL/aJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518F17E8EB;
	Tue, 28 May 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931940; cv=none; b=dtQFB+WCEj+cwTjpdjLflltQdSK063BixqwFwAQznYwHcRKXuj1ERi9Fq+lh3AyfSG3ZoH/9DSWoyq1l1RKoDS+zBCz+OzVBJk2x3W+sYG8bJCNpNaO+0VmuWb07by+3MMGbLrZN49uhl6DOZnWYdhDYFxiiZEVrFVaq39giWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931940; c=relaxed/simple;
	bh=P780Z2cLz1m9wazVo/8pz+Og5KD+JfWGrdNgn4xCE6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KKe9qssjK+HsOBcuIdmHteNnRgzNCeURha4Q+R0lzlIyOQVPAuSRQiQy5g5sxQ2B3YHzDQOsTDis2WnErYjyeo3CvpolYvQYg7PEVIpEh14jeeQv4jNMjP3Gqp7+h9JoEolofegUjjkFUz3ne+tG6bweit6Qej7bWcndXx7BnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qggBL/aJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716931938; x=1748467938;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=P780Z2cLz1m9wazVo/8pz+Og5KD+JfWGrdNgn4xCE6o=;
  b=qggBL/aJdNuC24WZZum8FSFENd5GgsTXw/M9hmqIjcbQDjlUxLZx7OFN
   P1RNr3vJ8QLukOd4eW9dCHY1Hri8F4FS56YVh/ni4UKFrghaY5lbcPHkf
   tYArihmfD8YrkPa126MNIBHWoM6UvYF6lRJ1TTwkghRhGM3L+/JbOrtpS
   P1FfVjtXbG+U9rOqYhm0qKZLeu1E3rUWZ40pXXCqf+8UQInQAlsV85JaK
   AYFlbf/NI+Jsfm3OaffBka7gEtcLd4V0b/n6SCjrCC28YOhr6tbVg608n
   gM1AxZjZiUtiKTx3QIdGCXlpn4LGF8BPRBBc2IZX8WtMxHW9216RnMsD2
   Q==;
X-CSE-ConnectionGUID: Hdb4HxD6TwGhrq+SF3nsaA==
X-CSE-MsgGUID: JVnjNpAOSzGoPC4OZo5ZGQ==
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="27243798"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 14:32:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 14:31:51 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 28 May 2024 14:31:51 -0700
From: <Tristram.Ha@microchip.com>
To: Arun Ramadoss <arun.ramadoss@microchip.com>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot
	<vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	"Vladimir Oltean" <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: fix wrong register write when masking interrupt
Date: Tue, 28 May 2024 14:35:13 -0700
Message-ID: <1716932113-3418-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The initial code used 32-bit register.  After that it was changed to 0x1F
so it is no longer appropriate to use 32-bit write.

Fixes: e1add7dd6183 ("net: dsa: microchip: use common irq routines for girq and pirq")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1e0085cd9a9a..3ad0879b00cd 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2185,7 +2185,7 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
 	struct ksz_device *dev = kirq->dev;
 	int ret;
 
-	ret = ksz_write32(dev, kirq->reg_mask, kirq->masked);
+	ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
 	if (ret)
 		dev_err(dev->dev, "failed to change IRQ mask\n");
 
-- 
2.34.1


