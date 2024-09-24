Return-Path: <netdev+bounces-129507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631409842EE
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833AEB2576C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF0170A26;
	Tue, 24 Sep 2024 10:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9B14BF9B
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172227; cv=none; b=V5a6s2VzcgO9FV9nrApFDWnhkTlZ15zp8SAbJlwmGSAivTDIQ/IXwurKz9aiGU7qEhC17BRKYwfkMV4yOorBxS4CaRp6i29li+fve/X0svxx3UrO+fcKvBP/PDlXGLX3ppSepnPxY1EeA4QIbXkDrgoB8QterQFQ6suHdLXbxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172227; c=relaxed/simple;
	bh=Qe5gsGLUKgpWeMR6yMlL8INVF8e5OomKcG92fxXpQ9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aj/Xe47ORZGBGHKI5hWanCpH1U7JWjoOWSx3Gji264Xr/1ZF8yiTBbp2iairNMTlqFdRb6GRVRPgIvpxprlQFVzvamIwCSmLQU/DBafpj1+eB34afUME29g8lcDqMnsOJKEdyludGwK5Hh16Pi/jZ8uN/iF3AuiBcub1CHFeN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4XCb6Q2mclz4xL42
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 12:03:42 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
	by baptiste.telenet-ops.be with cmsmtp
	id GA3Z2D00H1C8whw01A3ZkG; Tue, 24 Sep 2024 12:03:35 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st2K3-000Sir-BC;
	Tue, 24 Sep 2024 11:59:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st2K7-002HH6-7Z;
	Tue, 24 Sep 2024 11:59:11 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Jens=20Emil=20Schulz=20=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] net: microchip: Make FDMA config symbol invisible
Date: Tue, 24 Sep 2024 11:59:09 +0200
Message-Id: <8e2bcd8899c417a962b7ee3f75b29f35b25d7933.1727171879.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to ask the user about enabling Microchip FDMA
functionality, as all drivers that use it select the FDMA symbol.
Hence make the symbol invisible, unless when compile-testing.

Fixes: 30e48a75df9c6ead ("net: microchip: add FDMA library")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/microchip/fdma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/fdma/Kconfig b/drivers/net/ethernet/microchip/fdma/Kconfig
index 59159ad6701ad50b..ec228c0613517ec3 100644
--- a/drivers/net/ethernet/microchip/fdma/Kconfig
+++ b/drivers/net/ethernet/microchip/fdma/Kconfig
@@ -6,7 +6,7 @@
 if NET_VENDOR_MICROCHIP
 
 config FDMA
-	bool "FDMA API"
+	bool "FDMA API" if COMPILE_TEST
 	help
 	  Provides the basic FDMA functionality for multiple Microchip
 	  switchcores.
-- 
2.34.1


