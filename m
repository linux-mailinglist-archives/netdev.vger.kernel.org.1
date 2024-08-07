Return-Path: <netdev+bounces-116315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1D949E8B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0C81C23D2C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E5190466;
	Wed,  7 Aug 2024 03:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="i9fx5piN"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5E372;
	Wed,  7 Aug 2024 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002298; cv=none; b=AHK//WYlErdzILwxtVN46DvoIqzqNyt9SGG4FXmR0f1O2kXFtVIi0EJw01fQ2yB/uEhb3Gn9c8nuDYmvUB/h0Qs9wU6EOVW9rgA80vc5+0v4RqIVEh7E5L4sOSckC5QD72RLZxpe2YIxw74pXSec1Q93Z5bsgXDyzCkmOFeK0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002298; c=relaxed/simple;
	bh=IJyzsrd/JdNLjO9PSggzuX2zIs7jIBS8QaV26qcUUmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqCuWsitftnR5Kvsdy2Jlr2br5/L4nYginpPDgG0GYo62CUjUeDQMkVhZuI/z1BWhow05v+ordhU2rx6hfHLoYZjU7XlThEVqhS8DXPdhWrTqJC6jMlRoWwHF+pc/5cvMUkkXXikDDQBuuYcUyyi39FCt8DC6t8QaZL+1Yone38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=i9fx5piN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4773iabcF1925829, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723002276; bh=IJyzsrd/JdNLjO9PSggzuX2zIs7jIBS8QaV26qcUUmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=i9fx5piNCIm3OC/kBK7+9/8agdiWtO/IL+vYesaMtrSobqJTNrDhkhsQ6OEQixrBe
	 Zx8HAzpwGC5IBsUKiKl0nAWVm1rdodg1XPTwNUdlwZMVqUoVCpeR883B6lomsq8At4
	 Ink5/pdHJFcG9f3iR4sJ1g5L7ZQt1wGIz3JyzF1khZAIoRZBq7FPsE9SUaJl12g8VQ
	 gLErs2Z6kfB5vHxHUDP9imG055zPvZyt553RV5HK48GnVJt+ac5YG0BYI6lXPlXxu/
	 HN/KZBfe7+IedfIo+4sCMuTtkUz1aDEHHxHo0MGetWRu1KtDI8nC0/BwGQv8MeQSnW
	 U6KwjTuCW1yYg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4773iabcF1925829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 11:44:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 11:44:36 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 7 Aug
 2024 11:44:36 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v26 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Date: Wed, 7 Aug 2024 11:37:23 +0800
Message-ID: <20240807033723.485207-14-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807033723.485207-1-justinlai0215@realtek.com>
References: <20240807033723.485207-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..af8a6ab8db20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19845,6 +19845,13 @@ L:	linux-remoteproc@vger.kernel.org
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


