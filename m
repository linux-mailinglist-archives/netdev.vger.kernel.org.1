Return-Path: <netdev+bounces-111252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C6B930697
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 19:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E311C20A17
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C61513B2AC;
	Sat, 13 Jul 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="HJWl8u1s"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9F4963F
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720890309; cv=none; b=H8hc7Hf+L4hh/patrLg17KXH6skMQlFKbAVtE6PpBquQCVzu5JaqLbKwBchxtcrUd0QrN+Bu5kIK7bT9y9cxQgjyDQzpfVa6wRJ0zAOiRV06pian5NU9PRvmr/omPLTPpelIR68B+nczCSTNJkz5EcDqBcKSK9WeJur7Lt6CR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720890309; c=relaxed/simple;
	bh=pfQ1m0rvUgOjeAPoUcq8dNXwr6uRl7ZE9dTDU0qqP0k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Q5sUKIZ/UcgjsG8nWPhjI4f0SLWhnlX9rXQoQrNth5FOUQmBIN7RfB8/qxNCknICj4gdwDciBhCusxZYm1BSbF5D6r5vW39idsnbo6FQHHKmkOq98weu6itfIzZ5JsVQcHZr1np4aVIyNQINBe5OgTUtjo3+YW4UzkgHhmnUS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=HJWl8u1s; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 31818 invoked from network); 13 Jul 2024 19:04:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720890298; bh=7o8mzc213EEKgCOXqvfrefpkdDjhgWDGYyRAq4cTJo0=;
          h=From:To:Subject;
          b=HJWl8u1sD3pJmGVc52Sx9l2fcYEXwnLeEKw2xbnL79KlSIE6uHI51o8enxeYwHcln
           GjyNW1iDgdPlQXFRz2BisdEehUDqHw87guDH+5v6D6LgWGQAAhJBaDQduNMlZhf+oH
           eHTI67ralldkeBTmFgnVgoAhGgJVK4T5mFy3nE0w=
Received: from 83.24.148.52.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.148.52])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 13 Jul 2024 19:04:58 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: lantiq_etop: remove redundant device name setup
Date: Sat, 13 Jul 2024 19:04:55 +0200
Message-Id: <20240713170455.862632-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 49218107f3c7190e7e7ba6215c019b9a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [oSMU]                               

The same name is set when allocating the netdevice structure in the
alloc_etherdev_mq()->alloc_etherrdev_mqs() function. Therefore, there
is no need to manually set it.

This fixes CheckPatch warnings:
WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
	strcpy(dev->name, "eth%d");

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 0b9982804370..9e6984815386 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -675,7 +675,6 @@ ltq_etop_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto err_out;
 	}
-	strcpy(dev->name, "eth%d");
 	dev->netdev_ops = &ltq_eth_netdev_ops;
 	dev->ethtool_ops = &ltq_etop_ethtool_ops;
 	priv = netdev_priv(dev);
-- 
2.39.2


