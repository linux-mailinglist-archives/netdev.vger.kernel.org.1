Return-Path: <netdev+bounces-227014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E16BEBA6E08
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2471898DDC
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542942D97BC;
	Sun, 28 Sep 2025 09:41:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA52D94B6
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052489; cv=none; b=cvnvHLZoKaiKUhelZ6zM/HBDacTKZrZCiKMEoSi6qgIUYS6j79Pikmx+SJQrCwBg+Tc3ZIRgU5Sm0JK8YEODATCgmiJZST+aqcTDEAWk6kPh8USLdOp7/amzW90VUqLF2wKI1mP+Ly3GvMpmCOPc6ugIR/4YhcLaev9gQvrzEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052489; c=relaxed/simple;
	bh=Egggm009o9ydsBPYkkTMiLNXjMsxR3MW0UWUMx0t3fE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFSNuHKfw1yYibQASUcysypk/DXcJv0Z/0d3x6YoKCypDW0YABcqwrlfcNEsRlWG/HL7wZavqjoj4v9GGE7diNaLxI8P18rmZtBmv2jhe1D/dfgDyudNmrkZS/6V0VWac6Sn9VNgUcPxz4QczFHGFUa/tu5lt8XqU5mOEcJddIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1759052378t180050c8
X-QQ-Originating-IP: DLdCGOK+JfJ4nPQvNeRfYVVJmj11ybUjOrsC8eZ1BDc=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 17:39:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18066968773018638031
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 3/3] net: txgbe: rename txgbe_get_phy_link()
Date: Sun, 28 Sep 2025 17:39:23 +0800
Message-Id: <20250928093923.30456-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250928093923.30456-1-jiawenwu@trustnetic.com>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MH85Y1C9n92PxIdxquD1sjfGIWO5Jl8E+JFnIvTxguJ/wWcpb14NyLHN
	XT6V6OCNd62cKwNCKk5jfWAoIBmAQYrfeP9te2ltdJ089Do+/9wF/ikGloICF1qImO04saN
	ezs/IndBUu8xokzv6poVBqZ3ojyUvW57YFB4HxsLv0TlzGNVeDt82QeN7oZmdgNwSF7dtHZ
	nvZo2q2sIR+ONd4NS53+zReOK9x8r9eLfcAzqGuI77yf5BXxyJ3oBTYkinF1PQUrY4xSOuB
	l4TEjYszMRT8JE5EYU3K58zfw5Y6Aew4G4ZjMXx0bdiqlupSWRM6QPNdD20RWDGInuws05G
	EQVWLVPU0bx/BDAY//ZspOPDJhdYQokNip2TFb/2okcO+pCbUCe1hNZXJfCnGLE4iB9JLHN
	+F4IhVzMxSJZ0EX8znxGEdVxzYSqabDtdOHM1svNTMSdHHdlIUNpA7TgLuHfVJq2B7yXi+J
	VfKGrbxGfyHexJgl9U8pC0iZQU/sUU+SVd9JIEhY0Iqtzmq0gGlHQU4IBh3yczwlSsiHOFW
	tImwE5LQmZyuQ+bOE4qSlcsBPqNwyLs8ia1g3OVbBKsMBrNuee0aPsBqe8W+FK50wajhteP
	b5Hhi4VTm2mFrLGORA2Hh5LEsdn/5oMxeI6Tw+GU5RgBTKUoTtUx3SocoarV2MbdZ7GtUfc
	/uuRYvw6DkEmGLwuMfL5Job+OcFyJUUr2fHAE8QJOh1nUEK0mse2soVBW+ltcCFQqKCb+5N
	zoMmT+mDGZViejhsC9lyEDSy0Wmm43fJG4IcjZzQHSu+3IwS2WTS0WsTcXZxNU7cz33bEMI
	O0n0AjFCcIxwR+n48kz2iU/1ILent0KCcvD5Fs2Y9t6wqcZUyxIH/ioZz3qVxo1UHAy1SuX
	3KAot8aCu6XCJrSL1kjJvH/WX0KJd5zjOGL1OM2kLxlBntSmZ5GrAdjy4M5ig5VJ8ZEkfl2
	vA12d/97mPa+te3/Cha8AKHKEO0P7Xal9AZc5K20CCRV0bEc5DtCGS3eA3HiKUWoN86GV59
	YWsqruIhdnvGbIttGTRQJmBvBwxTE95/y1r/cyKHhFY6iFKGvhyWwZRSxJbxWIjKBNRIL5C
	wkVNLqIP2fO
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

The function txgbe_get_phy_link() is more appropriately named
txgbe_get_mac_link(), since it reads the link status from the MAC
register.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 1da92431c324..35eebdb07761 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -118,7 +118,7 @@ static void txgbe_get_link_capabilities(struct wx *wx, int *speed, int *duplex)
 	*duplex = *speed == SPEED_UNKNOWN ? DUPLEX_HALF : DUPLEX_FULL;
 }
 
-static void txgbe_get_phy_link(struct wx *wx, int *speed)
+static void txgbe_get_mac_link(struct wx *wx, int *speed)
 {
 	u32 status;
 
@@ -234,7 +234,7 @@ static void txgbe_get_link_state(struct phylink_config *config,
 	struct wx *wx = phylink_to_wx(config);
 	int speed;
 
-	txgbe_get_phy_link(wx, &speed);
+	txgbe_get_mac_link(wx, &speed);
 	state->link = speed != SPEED_UNKNOWN;
 	state->speed = speed;
 	state->duplex = state->link ? DUPLEX_FULL : DUPLEX_UNKNOWN;
-- 
2.48.1


