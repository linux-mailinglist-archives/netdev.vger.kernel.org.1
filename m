Return-Path: <netdev+bounces-108129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD591DEAB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30992861A3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4514291E;
	Mon,  1 Jul 2024 12:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F660BBE;
	Mon,  1 Jul 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835260; cv=none; b=egVqrSeizS4oFbACsMdAhXWKbqmT5g5xmh7sugoAwctj6KMkeutXnjgc3PvBmtp3+bT3lyfof+ISU1oRh+73ilpssgATGMfYM9T5GWw9POxDo3XHPQlk+yIyAdoK3X+Cch3ru/Qwck7C4HNMgSAtwd+wPGzoikbuVhWR6VAgZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835260; c=relaxed/simple;
	bh=ZZOzzvivJ3ckoJb+KIlAxVWzi4Sh80HygZ79WDVg6rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HluGdCRfaFvdxQM96uF5KJexZ6/RTnYoCmfUF7oinFhocINrizyDMX/VIJTqGMs72W1AiBEBcfTy2QAVQ9SlqMLp/CBac8jkxvu0HIA8gm0D2dp3nOr7ZM3ek4EJotRf70cwOQR2UdDApalzsBexuHapLDhR16bmG1Uc18pH14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 461C0UZX03807766, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 461C0UZX03807766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 20:00:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 20:00:31 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Jul
 2024 20:00:30 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v22 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Date: Mon, 1 Jul 2024 19:54:03 +0800
Message-ID: <20240701115403.7087-14-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701115403.7087-1-justinlai0215@realtek.com>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
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

Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e3cb040fc16..db19d508030a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19491,6 +19491,13 @@ L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/rpmsg_tty.c
 
+RTASE ETHERNET DRIVER
+M:	Justin Lai <justinlai0215@realtek.com>
+M:	Larry Chiu <larry.chiu@realtek.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/realtek/rtase/
+
 RTL2830 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.34.1


