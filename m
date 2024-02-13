Return-Path: <netdev+bounces-71320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B6852F9B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7403A280362
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3483524C0;
	Tue, 13 Feb 2024 11:34:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB63B182
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824095; cv=none; b=krJl7Y7HkFUdVyvPqLGoKPdTu8nTtSNqUQNXa3CnAnX4MiQXHp66maoIWV/8gpHSJhTqBt0cYr+DzX4Us2I/MRpHZqY4Ox/q9YdLglSaqWCgD3C6vuotHIDvlz6qAX8i5lKMrPBVsgWnalR9Du0hEsM/OQmJEzbPHfHb/y0/8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824095; c=relaxed/simple;
	bh=DE0MrAuA0Npop0CxrBQTrOnSmmhbGr7DGjdxwcIZspQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD0NbOS1pstXXph+PfPva2ga9WTmG1ABYa7rKgo28DM3CYNAED7kcNBXS1ZMUzClPrqH3juJ7MsO/gwaSgihpuJVCBce9JerNka7OQvtdmg6w1SolB1IXi8klU2Tyv6MxsirOON5l8gCVchr3v7hIIKPyW7kNzqnkEQMVKuIUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3o-0001Bj-Jt
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:48 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3k-000TXk-NE
	for netdev@vger.kernel.org; Tue, 13 Feb 2024 12:34:44 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5E0AE28D6DD
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:34:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BDDDC28D67B;
	Tue, 13 Feb 2024 11:34:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6b356603;
	Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Daniil Dulov <d.dulov@aladdin.ru>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 21/23] can: softing: remove redundant NULL check
Date: Tue, 13 Feb 2024 12:25:24 +0100
Message-ID: <20240213113437.1884372-22-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
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

From: Daniil Dulov <d.dulov@aladdin.ru>

In this case dev cannot be NULL, so remove redundant check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Link: https://lore.kernel.org/all/20240211150535.3529-1-d.dulov@aladdin.ru
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/softing/softing_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softing/softing_fw.c
index 32286f861a19..721df91cdbfb 100644
--- a/drivers/net/can/softing/softing_fw.c
+++ b/drivers/net/can/softing/softing_fw.c
@@ -436,7 +436,7 @@ int softing_startstop(struct net_device *dev, int up)
 		return ret;
 
 	bus_bitmask_start = 0;
-	if (dev && up)
+	if (up)
 		/* prepare to start this bus as well */
 		bus_bitmask_start |= (1 << priv->index);
 	/* bring netdevs down */
-- 
2.43.0



