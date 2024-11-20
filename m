Return-Path: <netdev+bounces-146421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE39D34EE
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD7A1F21A3C
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A9F1662F6;
	Wed, 20 Nov 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VEoWoCKH"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EAA158D94;
	Wed, 20 Nov 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089576; cv=none; b=g4cENjJFcqE8s3pvU9pjul0kX8s8amN2/w2/GwOjky02npxvfZqr0Gd1XM1Clf8OmjzzvDZ3b0y6lgKxYPnBm6GQVkZywkViVXKtiORf4bv9ATWXhBHhs06pxbIJeNA+8a2w+RHKXr95BIvXwl1qtgI/lYdG6dsck3sHssep0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089576; c=relaxed/simple;
	bh=WZikTQU/J9NItKRvbptX00Xfqlo3hfyd59uhzM1JNGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BemFqaH5L08r2BKknIslmpLiId4sUIjMMjWnL4mwpgT8Iw7/6u39ToM/v1prAVfr4fPAcG0quv7IXriM2tZh7CoefZ75b9s2mDtZUD9N+mPikSuzT/YO+TjGbMQg1ieFv2wZzKJrZ3DjXR+0ZmKF27ZoRTWkgJc/sHkIHEgqyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VEoWoCKH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK7x77a93745991, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732089547; bh=WZikTQU/J9NItKRvbptX00Xfqlo3hfyd59uhzM1JNGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VEoWoCKH2AF9TXqTRt6N3cMKjgPegPcxBzH6ECMRtfOu8KTTEUZtm6Ud/49zkO9IK
	 ObenNaCPs6cFoolyRSoI/xL0W2BeLGCDWeW03SNPTNrF7ZnAfYNLFQICXUv+vgpaqX
	 NHaOcwCbUbZn4n9gC+hDNG4UzoEdF/7fIK+zTFzwTPtdKbeQKxmySWNFrZ8KrEJ+HZ
	 Yr9kHWoMRHAcmYYdxAJPYvikBufz11I6DHZEZZkA9uWiQXaM+9II9XszrAz7GJnV2B
	 76aOUHMBUhJWmLV1PMBp7Whdzw0VXnEdxkwTtXP20Vafz6+odOSG+d8GhAuSb2pkFf
	 5QOd/G80qv5ag==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK7x77a93745991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:59:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 15:59:07 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Nov
 2024 15:59:06 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>,
        <michal.kubiak@intel.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net v5 3/3] rtase: Corrects error handling of the rtase_check_mac_version_valid()
Date: Wed, 20 Nov 2024 15:56:24 +0800
Message-ID: <20241120075624.499464-4-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120075624.499464-1-justinlai0215@realtek.com>
References: <20241120075624.499464-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Previously, when the hardware version ID was determined to be invalid,
only an error message was printed without any further handling. Therefore,
this patch makes the necessary corrections to address this.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 7b433b290a97..1bfe5ef40c52 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2122,6 +2122,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		dev_err(&pdev->dev,
 			"unknown chip version: 0x%08x, contact rtase maintainers (see MAINTAINERS file)\n",
 			tp->hw_ver);
+		goto err_out_release_board;
 	}
 
 	rtase_init_software_variable(pdev, tp);
@@ -2196,6 +2197,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		netif_napi_del(&ivec->napi);
 	}
 
+err_out_release_board:
 	rtase_release_board(pdev, dev, ioaddr);
 
 	return ret;
-- 
2.34.1


