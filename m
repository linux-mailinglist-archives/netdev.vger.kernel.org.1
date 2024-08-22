Return-Path: <netdev+bounces-120894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F2A95B235
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8777228663F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31B186E40;
	Thu, 22 Aug 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wcHRVP5r"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D5186E30;
	Thu, 22 Aug 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319808; cv=none; b=L/zuEWtcC1L/nQTzk064XAfrwxLWBfI6CMPQQmv2pK8CxQvNkbKznwODg8GbGYScqELqJ1ROgT0TwfukrxRmX4dfG16pT3iM5f0KBjOMrn3OpDIVc9K10ZnRrhJIlXY1Su2MJZP8aWafuv0KEHfduemgrzryILEJRe9G99nME0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319808; c=relaxed/simple;
	bh=y2/kcadb3S8A62lL0Sh1F6IC/6vmv+LQMeVO5YYko0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4TN5LpzXNRVhut2w59tosS8IzbUUeQH6UQEkNlRu0Xr8JqIZ2+YVY7GlSXJcFzCKQeh7u5QHMgZBhcFIzvE/wP4Kp+9jMA9vIyC+S3ZTqzP+JHgq09HAkuAbNRdGtFePzYQ1+9XtQkiR4422C+gTiDV3k+QgxcaBuz46r+xPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wcHRVP5r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M9h0O013805580, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724319780; bh=y2/kcadb3S8A62lL0Sh1F6IC/6vmv+LQMeVO5YYko0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wcHRVP5rjfGVXEinBnuntktBTo9YE/SjjdeAWurUMvWg8mJMfPWp+3v6gKb46ZHxi
	 6l8n7r860mRpIWKXpKrueYRC7q3Ooq+zlheR12wACOYI3mPpMwKBaDBYN7n5xJgd9C
	 gAXgbpYLTil0J+oauP4naCrOAyvu2RQlHshJ3Wqil0AIP/31ZLgfwhXOACNHLw8DPN
	 jf8ua5vLOBgBp/65lv9XrxQcERrDq3bWd6u+ipBo1fBBaygKxHvgFvneFRFfd1zjzB
	 uR3j9+YgfVc22zX/Ixu8FxBTBNfdLZCLStLSSCHB80phdLZ2vx1iyROTnEmhz01QX4
	 TM/1wVbwctbUQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M9h0O013805580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 17:43:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 17:43:01 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Aug
 2024 17:43:00 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v28 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Date: Thu, 22 Aug 2024 17:37:54 +0800
Message-ID: <20240822093754.17117-14-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822093754.17117-1-justinlai0215@realtek.com>
References: <20240822093754.17117-1-justinlai0215@realtek.com>
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
index 5dbf23cf11c8..7d6d3c7dd526 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19848,6 +19848,13 @@ L:	linux-remoteproc@vger.kernel.org
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


