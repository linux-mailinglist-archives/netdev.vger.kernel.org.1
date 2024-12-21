Return-Path: <netdev+bounces-153884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413E79F9F30
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 09:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C15188AF94
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90251EC4CC;
	Sat, 21 Dec 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="PFxqLGig"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E161E9B3C
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734768920; cv=none; b=Gv0Ff4Nb9CO2NvxrAslcsndJKgx+k1IEYA/5ELlvydL/Hx/X0bQhfc6mIH/QQSD0H1Om1bcRqy9CxU/bjIylH88d5yF87brGAz1/69s3Q83qEC0icM/ARX6qb3o68HJXpPAOLPytMF4ZjeUJnqkJN9+ER0GNJ2nRTxgdi6LomjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734768920; c=relaxed/simple;
	bh=L5LPT3BWLfNdOAMNUUwasAlbHjTyGbJl42kz0zvbJCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NPH6ygFOPJa+LdjbAskjMaHeIUIwM+Z31M7SXsOWU54pu2y3z5hNfn588v+mDqfM2XW8M2wQGHsdKx6BAEeJyKKLBKfHQCimfEBUNIVnHDkfR1PZSg6AiOcaezpUNch4iSHdyHTEocvowmvJpxBzcc98fTzHO8wPEDDZ/cLl4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=PFxqLGig; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e81257bfso2344032b3a.2
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 00:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734768918; x=1735373718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slTUwbxtcSMPK8G6S2IH/36OybBp8SgMfp9mnjaHTjQ=;
        b=PFxqLGigmsIfk+K2wolNlSbAUcEcaeJQhyq5NPvxND9PxYH0MHX+I9cnIMgLk7IFb0
         dH9oIUaVfLGKrxQqtCmYbZeZM4QEps751VSaMzUG9Dot+5MwxWKGA1i6zWRqPu8GzSUp
         Cm7Q57/uRqcHnjtXT8Fh3tAk7sVQj8ZaHd3vt8regQVfe3JTrj84uXDFDhkaUDbSpT1J
         +5yKHvrg4mNkaxVQZWmt0O6b6MqJV+eCGKAsoJPQ86Ahk73p4QZswOzckChRNoi4GGlb
         3YMeg/gmDk11Hxp0+PYyCH367lOJKc8GJb9aMj52YmOdvMbmHEJrkQXaMf1HkXKGfUmC
         DVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734768918; x=1735373718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slTUwbxtcSMPK8G6S2IH/36OybBp8SgMfp9mnjaHTjQ=;
        b=MA11Fyqh5mD4qavnC6mScotOpnDeQqerYxDgeY1d1G6nXXRZzXJPbKedsUB6t1tOMD
         aUfj6UMFae2czQbQ3c+zVsTcyhCcpUnenD50evqL29hYR50sKJrr4R1qwEbF2wXmHVX2
         F84LU2Nl05tXYFAer2PvD2zTbMKr1oncItgzKHc1NHoOGKYMufKSzNvX83GPGP8vhWOs
         IV4M3+9CueIlcb87/i1nMBAev6ABGK3w0qk4yfV4sWtE4idVJxHr3+WA8bdb0Rkc4onj
         iiSvWmL6DhE0x4V2EgMNINmcHMua8IdFLoySrOrUbIeZLEuR3CUTVzDlcRwYD2Cjy/gF
         HUpg==
X-Gm-Message-State: AOJu0Yxs6K3bkyLdtMIgOHDnCB3Xd9ej0/Vg5DcOPmcVbYaKCEatjXoX
	/R4iPwFPc2pKo1a67ytoVeFsHXA2zcet1Bv0jp6fX7YQ0/vIlSGDlgB2atrIV0YTuhj7klvCtUi
	AAEY=
X-Gm-Gg: ASbGncv6uUEUN/EIkWHGJapkRfo1ZeXDrk8j6yy6wmh13Ed2rUqf5Zkvkeuzp43XoNU
	7S8THr3xvIX/XJxnNZQw7C5yQa9aDJb6SGm+NUPgMQvTExToX45eK+TiUoBEW20Or9XjTg2Y5jC
	typw9/EHMWccUp6fRcnxl/tT3IDRBvLSyuX/5wJYwroESP8CU2iLnqGRO+hZmercD4zydSiaTTf
	xNFIzaQaN5ozhUWgVYs0qiP+tvOBWIphocKPz7QaQ7Md8VASc+FmqVzPnRn3Cibhdh7/36Poz2A
	EiqGsLU2kmFiEJ7g79bBTc3LdH4kZwuunRmRwRlXpmU=
X-Google-Smtp-Source: AGHT+IFbqCyDOdZTAUMikM7TTVxukkDPL7eL3KTKQklbmIvXNygbp0Rw61F9Y5Ky4vDJinIgIDD7xg==
X-Received: by 2002:a05:6a00:2405:b0:725:aa5d:f217 with SMTP id d2e1a72fcca58-72abdd912fdmr7167929b3a.7.1734768918065;
        Sat, 21 Dec 2024 00:15:18 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81622dsm4279093b3a.30.2024.12.21.00.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 00:15:17 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: sebastian.hesselbarth@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH net v4] net: mv643xx_eth: fix an OF node reference leak
Date: Sat, 21 Dec 2024 17:14:48 +0900
Message-Id: <20241221081448.3313163-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of mv643xx_eth_shared_of_add_port() calls
of_parse_phandle(), but does not release the refcount on error. Call
of_node_put() in the error path and in mv643xx_eth_shared_of_remove().

This bug was found by an experimental verification tool that I am
developing.

Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v4:
- Reorder the variable declaration to comply with the reverse xmax tree.
- Add the target tree to the patch subject.

Changes in v3:
- Insert a NULL check for port_platdev[n].

Changes in v2:
- Insert a NULL check before accessing the platform data.
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index a06048719e84..67a6ff07c83d 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2704,9 +2704,15 @@ static struct platform_device *port_platdev[3];
 
 static void mv643xx_eth_shared_of_remove(void)
 {
+	struct mv643xx_eth_platform_data *pd;
 	int n;
 
 	for (n = 0; n < 3; n++) {
+		if (!port_platdev[n])
+			continue;
+		pd = dev_get_platdata(&port_platdev[n]->dev);
+		if (pd)
+			of_node_put(pd->phy_node);
 		platform_device_del(port_platdev[n]);
 		port_platdev[n] = NULL;
 	}
@@ -2769,8 +2775,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 	}
 
 	ppdev = platform_device_alloc(MV643XX_ETH_NAME, dev_num);
-	if (!ppdev)
-		return -ENOMEM;
+	if (!ppdev) {
+		ret = -ENOMEM;
+		goto put_err;
+	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	ppdev->dev.of_node = pnp;
 
@@ -2792,6 +2800,8 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 
 port_err:
 	platform_device_put(ppdev);
+put_err:
+	of_node_put(ppd.phy_node);
 	return ret;
 }
 
-- 
2.34.1


