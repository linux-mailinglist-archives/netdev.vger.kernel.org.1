Return-Path: <netdev+bounces-118757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEFA952ADC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152FF281578
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93551B29C0;
	Thu, 15 Aug 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="Hmx0jFYA"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA0176AA9
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709845; cv=none; b=WFCUBX/yjUAaT6lr9pa//UR0aOoZXte8OG9RSlQCEGqcFjxwIfx69w5lVbYf8Jt10sqwaHD1OBJW6Psd1Ou62wgh+snEVXsuri5qe37U/ahdhTaBJcwY1zcjpdisHMKRrI1E3Pv4WR0dSPVinTh/UAaT12Gh4cjUbCvj21UFCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709845; c=relaxed/simple;
	bh=5z7fF+TnfX+LXdWikfENO8d32MXfCW+MMcVrT9DX66Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DWM7p4uYO3WpSHi2OKTJv3Ce4j0wNIYIM2UARxOOV3/LgC3tCEEPfBx4rhYAzXBvOOsNJzTKvENK8jhqg9E8YIfbzIOxBDxrOhvh3qedXBgn4+SA0OSoM9lDYdT8ZQw7nF9r51ooJW9w189gSUpFgDJf23KgAsQVB1qGupsoj6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=Hmx0jFYA; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 15880 invoked from network); 15 Aug 2024 09:49:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1723708198; bh=WBY4GMf9mjFw4X+BJHr6XblU/xSHdCH+pOR7tJbNRb4=;
          h=From:To:Subject;
          b=Hmx0jFYAjKpTk2MdQCDXEg1xE2Whbxqi2Uhf760mHwV75B3lIJ3v/3zlJN6vL7Q07
           S2VmmtpiqmGm+2Uz2fSA00OTNJxaQjC3Yohd6w7m7lZUTEIdpwfDp6yClhK22Iv5IX
           4PKsBkA54gh+3r1tJZ1/aRqHpmfXddWGjvGKRENU=
Received: from 83.24.147.218.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.147.218])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 15 Aug 2024 09:49:58 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	jacob.e.keller@intel.com,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: lantiq_etop: remove unused variable
Date: Thu, 15 Aug 2024 09:49:56 +0200
Message-Id: <20240815074956.155224-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 05eafb17e5a12033c9bbbeb6c3475e4e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [oZNE]                               

Remove a variable that has never been used.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 9e6984815386..3c289bfe0a09 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -95,7 +95,6 @@ struct ltq_etop_priv {
 	struct mii_bus *mii_bus;
 
 	struct ltq_etop_chan ch[MAX_DMA_CHAN];
-	int tx_free[MAX_DMA_CHAN >> 1];
 
 	int tx_burst_len;
 	int rx_burst_len;
-- 
2.39.2


