Return-Path: <netdev+bounces-111253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA093069F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2371F23200
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410D13BAC6;
	Sat, 13 Jul 2024 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="r6VLBqE0"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1A13D279
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720890572; cv=none; b=SWvUUzNnKUrNIugmKzA0tFzA7cFaSi1bcPHdsBr6RdiqoEe1l0p/K89Em89nSE0Iuvrxr10gF0+xl5iP9b3asXhFtAcPF44b+2Le6b4Tw6+ppW6gwgqO5aNXXbD7YAncwtGQOiUbYqIDV/+Iunjur3/7wZJ+S/z8Ev2bTfmilqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720890572; c=relaxed/simple;
	bh=pfQ1m0rvUgOjeAPoUcq8dNXwr6uRl7ZE9dTDU0qqP0k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ncvcxS6ah8naLCi10BRx7WFcMdA8chuKDTuoiF8Bvlbm/2b3TRNVKEnz0GJ5nxRM2BUQD7c8ppMA+t5ULtp8bWHhs/n5TqTTG/5acQ2XiD2HoWBm4pTR7ekXYoBjoWel8SohW8qjjL3QzMckD9TX/QkT9T1iacHAE3PcbXAIO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=r6VLBqE0; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 1451 invoked from network); 13 Jul 2024 19:09:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720890562; bh=7o8mzc213EEKgCOXqvfrefpkdDjhgWDGYyRAq4cTJo0=;
          h=From:To:Subject;
          b=r6VLBqE02iYYFE3IVu876jKXU38PdPH1H0LLDo2bi0eBs5Lrz+R6bt6AiJRs0fHcB
           hleUe9a1jZ0w3MxZES9cN54UWyy/81EcrDH1sNw1Npu+9Mp5xRRjHQEVTaiKmD1UFQ
           0Kq4Us5A4HOY3LGv8gafvM/KepOMq1TKhLFSmj/I=
Received: from 83.24.148.52.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.148.52])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 13 Jul 2024 19:09:22 +0200
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
Subject: [PATCH net-next v2] net: ethernet: lantiq_etop: remove redundant device name setup
Date: Sat, 13 Jul 2024 19:09:20 +0200
Message-Id: <20240713170920.863171-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 16fb977d773cd3be13d03770da642e94
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [8VMU]                               

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


