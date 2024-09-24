Return-Path: <netdev+bounces-129497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF3B984219
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA63B1F21CAC
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E4155743;
	Tue, 24 Sep 2024 09:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDA146D59
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170162; cv=none; b=cjSXAYwGc8pkmLpfTcUNOpzoKTlxcCKc/jbp3HZ0wp9H77mA33RmXhvT4TEdqrLbM0PMTtgmhngamt0ZoweIm/4HFt56w0aY0AKiuQJoG1joUyuZqhdTsoVqfsYftgzhflII1boOwMusxzoYiAxsYmcPIAEwltZCFMDbNGeI1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170162; c=relaxed/simple;
	bh=Rpiia7W171dhBiA2KDt3R+l32OjCdJgEQC5KzQ/YRWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l84Vw82rLC4hzLp0xKd9gk6pH/uKRl6YAOxhy9kW1pk85gqgBiOqRpThy4rFF25+mUXJ5LX2VMYhHVh6RjdDDH5oy1y+KYVSbXgoqA7am7QbyUrSLl0K/bf2gpWnjswEIo3wGpCrH81DHEcuogIFLejNM7Les6T5+YDfCIofWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4XCZ893kTRz4wxfZ
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 11:20:09 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
	by laurent.telenet-ops.be with cmsmtp
	id G9Kw2D00J1C8whw019Kw7X; Tue, 24 Sep 2024 11:20:02 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st1dq-000ShT-KK;
	Tue, 24 Sep 2024 11:15:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st1du-0003Zv-Gj;
	Tue, 24 Sep 2024 11:15:34 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] can: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP
Date: Tue, 24 Sep 2024 11:15:31 +0200
Message-Id: <a4b3c8c1cca9515e67adac83af5ba1b1fab2fcbc.1727169288.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip CAN-FD controller is only present on Rockchip SoCs.  Hence
add a dependency on ARCH_ROCKCHIP, to prevent asking the user about this
driver when configuring a kernel without Rockchip platform support.

Fixes: ff60bfbaf67f219c ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/Kconfig b/drivers/net/can/rockchip/Kconfig
index e029e2a3ca4b04df..fd8d9f5eeaa434ac 100644
--- a/drivers/net/can/rockchip/Kconfig
+++ b/drivers/net/can/rockchip/Kconfig
@@ -3,6 +3,7 @@
 config CAN_ROCKCHIP_CANFD
 	tristate "Rockchip CAN-FD controller"
 	depends on OF || COMPILE_TEST
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select CAN_RX_OFFLOAD
 	help
 	  Say Y here if you want to use CAN-FD controller found on
-- 
2.34.1


