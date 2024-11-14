Return-Path: <netdev+bounces-144847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 205049C889F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0F51F21AAC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2361F9ED7;
	Thu, 14 Nov 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fHgLxhNU"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723991F940C;
	Thu, 14 Nov 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582964; cv=none; b=VSdtaUFbB6iRdfLGqi/fK4CvNCUI20jDrafislp1VapIuk3hILY6Wiov9eucBpZlDGX5jRCPXVikC7Iez41YilTxUTermB28+uPAXfI+j4kiOrUWb32i0WDQx3BUbm2buKvvsblOciWodlloOZ/Vs1fMxpf+0DphS3x5xrDL2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582964; c=relaxed/simple;
	bh=uaXCn79Xv9MvtqcMUh1KWP+EVzihdOmmu9ErD65pb44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECbOKkAjd+mmqRQvwtqr0q/E+5uuEneS6jmST6FD7hE3RpywT8idq1NoAL1JdZOO2skv+nNHvRcuWIGWE/z+NXSg1vkZGZTZX/IsvC8Y8kEzrBlfcxLAJZjg4r+8zycl/PE0oGGD9+kcFH1tzhNVTqGnG6fzznBOCeAIQSSZXqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fHgLxhNU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AEBFluU62903597, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731582947; bh=uaXCn79Xv9MvtqcMUh1KWP+EVzihdOmmu9ErD65pb44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fHgLxhNUqV6i3evqgulAcV8PRtsPKLEdIw48NNDPi+8XQ9fslpqVjqI7WlNaQ2Gzy
	 lz/Ksu8S3926K8cwOAd3bRuBJg93L0j4l6AblbLNukFzEMjpfZdRThMd1F2Bme7tCB
	 XWfdjpx6Gmw2GUC8/Tj20xeVrDaRg07BTCuC3TrFT/o6Ng6LaJFej5roQqCZ0BRXXA
	 8OkBG5tljr9O2rIvB1jM53h0gCdm54QwPsJOIv89qrB4uBqfa33K+AQij7wK8+ZS0X
	 DdWHwx0D3ZXxGxX6qfUqFa0LrqMLh3p2Dg07i5xZ2Hox8BAOu1jB7NWJaMmF+b3ila
	 RHbsn56UIs/bg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AEBFluU62903597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:15:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 19:15:47 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Nov
 2024 19:15:46 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net 3/4] rtase: Add support for RTL907XD-VA PCIe port
Date: Thu, 14 Nov 2024 19:14:42 +0800
Message-ID: <20241114111443.375649-4-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114111443.375649-1-justinlai0215@realtek.com>
References: <20241114111443.375649-1-justinlai0215@realtek.com>
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

1. Add RTL907XD-VA hardware version id.
2. Add the reported speed for RTL907XD-VA.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 10697e4055b6..958b1543c4af 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1725,6 +1725,7 @@ static int rtase_get_settings(struct net_device *dev,
 		cmd->base.speed = SPEED_5000;
 		break;
 	case 0x04800000:
+	case 0x08000000:
 		cmd->base.speed = SPEED_10000;
 		break;
 	}
@@ -1993,6 +1994,7 @@ static int rtase_check_mac_version_valid(struct rtase_private *tp)
 	case 0x00800000:
 	case 0x04000000:
 	case 0x04800000:
+	case 0x08000000:
 		ret = 0;
 		break;
 	}
-- 
2.34.1


