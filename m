Return-Path: <netdev+bounces-145727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386489D0930
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5151B2230B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930C149E0E;
	Mon, 18 Nov 2024 06:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B714831F;
	Mon, 18 Nov 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909746; cv=none; b=tvXNcPuJRlYEBkbfrswl7KkvikTc89njUt2RVX+amvodI2VwE9e7vNtli85+PT6kI0gL9hJnraDwofeOUHQERRgMoPfXBy5jKPdOYhmyzZeOI/d3iaPtJ3ahsdIiqvznhITa7O5WPrgsxIM1RnnHNF0WYDowRTDfAZ4wo0i3yLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909746; c=relaxed/simple;
	bh=lW3Yhn3mcDRma1Y+lv8Hv05//q7fTVEmZq6HiiPgyPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ja6dBdPVtUI81Os4qpJTvEPHfeDF1f16bysAB2SwZIFkYP5Am8uwu4fFbLVq4KXYvhGUZcnm7v8+FmRXxjqOztymJiFXMFI/nKDXwxXGSluQNXhXBtIBvGYGHLR3cdkbmHBnGbWOs2mhEsfyhAhX111+3/nKFyA4HxhAvibMRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Nov
 2024 14:02:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Nov 2024 14:02:07 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next v2 2/7] net: faraday: Add ARM64 in FTGMAC100 for AST2700
Date: Mon, 18 Nov 2024 14:02:02 +0800
Message-ID: <20241118060207.141048-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

AST2700 is a ARM 64-bit SoC and ftgmac100 adds support 64-bit
DMA capability in AST2700.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index c699bd6bcbb9..d5a088d88c3d 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_FARADAY
 	bool "Faraday devices"
 	default y
-	depends on ARM || COMPILE_TEST
+	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -28,8 +28,7 @@ config FTMAC100
 
 config FTGMAC100
 	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-	depends on ARM || COMPILE_TEST
-	depends on !64BIT || BROKEN
+	depends on ARM || ARM64 || COMPILE_TEST
 	select PHYLIB
 	select MDIO_ASPEED if MACH_ASPEED_G6
 	select CRC32
-- 
2.25.1


