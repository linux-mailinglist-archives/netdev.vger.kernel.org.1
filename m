Return-Path: <netdev+bounces-141654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324629BBE6E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7342826F5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5B1D47A2;
	Mon,  4 Nov 2024 20:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA111D3621
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750490; cv=none; b=knoDL5S7aLie4yGSzL7i93T2UIHeWFTp47eBC6MOsbaI4OgxJR6MCLXCjq1LjnzvYWUXSfk1V5hRexbCaKdEihyl5WIXFXU15fYnPrRUzFucTha3+9UMOwJ00YiW8acc9YaqHfyPkaQ7iVHhF1NfyK0XxqMpQZLQhLWXecX4LEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750490; c=relaxed/simple;
	bh=nzTluwYybdPKvNBsT6GpichXoAzuRQBWR33xa3O7Wa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKCWh9ODx6cWBX16DeIVPewAkRStQ1o6JJi6K8EDv51EpvvTgYCMtOKMYFY/lLtuRHlh5BTX+E5qO95Hdt/b9XLUVJvj03FBUyJUvN1gK5U+ARh1Im7sQIJ5F5wgMxa31khDicfhEKfzoF5WYdEmh9CAStWbB41zbBMhOcX6rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GQ-0001bJ-UP
	for netdev@vger.kernel.org; Mon, 04 Nov 2024 21:01:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GP-00225w-2a
	for netdev@vger.kernel.org;
	Mon, 04 Nov 2024 21:01:25 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 78C04367FA2
	for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 20:01:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 910AD367F67;
	Mon, 04 Nov 2024 20:01:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e2a5e04c;
	Mon, 4 Nov 2024 20:01:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 5/8] can: rockchip_canfd: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP
Date: Mon,  4 Nov 2024 20:53:28 +0100
Message-ID: <20241104200120.393312-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104200120.393312-1-mkl@pengutronix.de>
References: <20241104200120.393312-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Rockchip CAN-FD controller is only present on Rockchip SoCs. Hence
add a dependency on ARCH_ROCKCHIP, to prevent asking the user about
this driver when configuring a kernel without Rockchip platform
support.

Fixes: ff60bfbaf67f219c ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/a4b3c8c1cca9515e67adac83af5ba1b1fab2fcbc.1727169288.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/Kconfig b/drivers/net/can/rockchip/Kconfig
index e029e2a3ca4b..fd8d9f5eeaa4 100644
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
2.45.2



