Return-Path: <netdev+bounces-145223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848509CDBF3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491F6282776
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E889B1991DD;
	Fri, 15 Nov 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IAwS8wqq"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1218FC75;
	Fri, 15 Nov 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664554; cv=none; b=YeY46v7EWPPcFO3nOi5SEf0cF84v6l7Ce/keRJ+2PbvGD6cpmHGGlixUgTNk+iVMtQqPz/NGd7ifqRZQyzxojFa9qztDKuTAPrR/SpiLXRNnN9qGZdrCK3p6PIsf3SPTHkm3j9EuKd25vZvaBEAgcsq6EzzApMovRYjvjURjH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664554; c=relaxed/simple;
	bh=KqVUQsZudJmLc5BK8kjEGKOC7PoSPhxr6P8Izbi9bYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZHSILI879KKEDbAoVwp6sXtOM3JmFrAax8J+04LIylQIqCZfi5MoLf+nJyTec7Qz+U+R1cxHkHBPUMpMzruJD1dWyqvWEwGf0c/0Maet+IjKWF+YqAAEtkZ9B3nTw0J1GhthGuSxGig0pW8NPZQTVY5AkeBpaLZwWg5RXlFqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IAwS8wqq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF9tbA93290716, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731664537; bh=KqVUQsZudJmLc5BK8kjEGKOC7PoSPhxr6P8Izbi9bYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IAwS8wqq4CA4xdw1vtLa6JJUKuuZbKBA2iTO2M6PW9kVpVRX98ieGirDyUDL9GnuQ
	 aYKLFXqpeNyEsV3eU1SWfUH0kz8eWsyCrHLmFuJNRbv6odShc+oKX504bfPvjuavEa
	 Nasf/IxJnz59QNyvQPQTUeVMNehCN8D61De9CnSUZECXrlOCJ5WOx0arHzBAZ3i9pp
	 3grg8osQ/K2EvKQLX5KOS/8E1xUIpuDImDBLlR86yWiE+cGKo/6yyUo3v2clxbEw7c
	 HbgJOV9Gun6RYKQc675/UCed6C6HRqzUyuFJzfKCRUAP416mUYRLmhmmpx83mUYyDB
	 tugEWq/6+UYyQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF9tbA93290716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:55:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 17:55:38 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Nov
 2024 17:55:37 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v2 3/5] rtase: Add support for RTL907XD-VA PCIe port
Date: Fri, 15 Nov 2024 17:54:27 +0800
Message-ID: <20241115095429.399029-4-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115095429.399029-1-justinlai0215@realtek.com>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
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
index 5b8012987ea6..22389911a7d4 100644
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


