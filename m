Return-Path: <netdev+bounces-35425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D07A9739
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3271F2106D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20364168D7;
	Thu, 21 Sep 2023 17:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDABBA4D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:05:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F58072A3
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:05:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qjDHR-00086O-3V; Thu, 21 Sep 2023 08:35:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qjDHP-007rbT-HF; Thu, 21 Sep 2023 08:35:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qjDHP-003Vqe-7h; Thu, 21 Sep 2023 08:35:15 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S . Miller" <davem@davemloft.net>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: ethernet: xilinx: Drop kernel doc comment about return value
Date: Thu, 21 Sep 2023 08:35:01 +0200
Message-Id: <20230921063501.1571222-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9goEXAndZAaUOWWHTdFPMXMYmPkDAr306Y3Xex5R/Gg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlC+QUicq8nMbEvv0joHwKr74ScN8qTQuinGavx huSgvvzlx2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQvkFAAKCRCPgPtYfRL+ TigXB/9FvtEwm4yREzOuj1CttteKdWj6zzGVJSOCvk0kdUhrAyCoZhiEEBp7C4CmoxYISUaV5Ll Pa4YhQswovKt/Q70rBlKaKAAL9Qi4aQP+33XAG7biDA7QpM6HX2Bja8r8UVibPMveMbnj6XHcbf n8+IVXq0K+YfWujW4zkwMDC+CMFOjUODMKWi2pXdcvjvgMWUat8o8ZoBw+Pyr7gxX4IeN/03XA9 UogxYjyMpyPmM2ZI2boxLviirBb8ZOd5gDegKl2t7nkhHeNLWyAPOPW9x0mzevdyWPpy5oQkF9N /mU3v3M4OPxdCzxtMOpG7hJHGflgxewuyZXqIFt1UVJit//c
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

During review of the patch that became 2e0ec0afa902 ("net: ethernet:
xilinx: Convert to platform remove callback returning void") in
net-next, Radhey Shyam Pandey pointed out that the change makes the
documentation about the return value obsolete. The patch was applied
without addressing this feedback, so here comes a fix in a separate
patch.

Fixes: 2e0ec0afa902 ("net: ethernet: xilinx: Convert to platform remove callback returning void")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I don't know if you keep net-next/main stable. If you're relaxed here,
feel free to squash this patch into the original commit.

Best regards
Uwe

 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 32a502e7318b..765aa516aada 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1180,8 +1180,6 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
  * This function is called if a device is physically removed from the system or
  * if the driver module is being unloaded. It frees any resources allocated to
  * the device.
- *
- * Return:	0, always.
  */
 static void xemaclite_of_remove(struct platform_device *of_dev)
 {

base-commit: 940fcc189c51032dd0282cbee4497542c982ac59
-- 
2.40.1


