Return-Path: <netdev+bounces-15353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B74747017
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 13:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849B51C208F1
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E25568B;
	Tue,  4 Jul 2023 11:41:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8D53B1
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 11:41:20 +0000 (UTC)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B85E7B
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 04:41:18 -0700 (PDT)
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9B4ECA05B5;
	Tue,  4 Jul 2023 13:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=9Ag0fFiZ2g1oQklipKV6x0rCyFRpiiX6jD53xnTCNng=; b=
	ObmeQmRXrdIZEe9Q/E3k66NGEpx6uChcIwaZJayWvno7Vsmji32+pBo1XnX1wN10
	UbIFbSAgFGokVXGyvVjl/0NRM7xG2LOJEQkNuUelp9ATJDDUTirI4551FBQrD9VY
	isXwYYgESsQKP+fKhczdJ1lw/4xdkZsibzg3pJrzQ+f5LDNATTKE2NOfxWpHIapj
	VjvWyEfdhoYqBtU8WZAhY7YSes1hmOVmjmUAzBVtegDAowqmHKWhpHYMRsvMqlqo
	2f/npsFzx9qkP5vaQhsJib/vvUsznTxk381+nMUuP+7tfP7q65AAa3BKUTdIaOqM
	DVFWUInT3CYE13kWzKkpyNpwzqWo/amHNiFyI4A0JHIDsWYGDRKdsiyMgwrBvAtT
	0V3QOKLJ+HBMelnbW1KwfincacRI4QuDnMqgbqtoGEim7nDWp0rrie0v5Rcvk0qW
	/VV6wvkoTvCjvzkyQnyGyIzLzVyct0gkCqO68yCTIBMDQUu0Enj+svPw/PwKPDH1
	ddToG/K8PXPprQgfWFA+MjQvX+xyMAEEs3MSvowUgrzzbfpuxN1kyhzqDeqmXlUY
	HX9ut/pYJiTPOy/I0BWUrVctr90tnzMToHZWp3s7/okWcetJxR6hP1yNJGGl5TYF
	bC+N8ICiw3+vew6D/K+nzkkqLB1S1pqKFATWr0VbyfY=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Ahmad Fatoum
	<a.fatoum@pengutronix.de>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andrew Lunn <andrew@lunn.ch>, <kernel@pengutronix.de>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH resubmit] net: fec: Refactor: rename `adapter` to `fep`
Date: Tue, 4 Jul 2023 13:40:59 +0200
Message-ID: <20230704114058.5785-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: Fail (atlas.intranet.prolan.hu: domain of csokas.bence@prolan.hu
 does not designate 10.254.7.28 as permitted sender)
 receiver=atlas.intranet.prolan.hu; client-ip=10.254.7.28;
 helo=P-01011.intranet.prolan.hu;
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1688470872;VERSION=7955;MC=1399971582;ID=332562;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29B0A0C25B657263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rename local `struct fec_enet_private *adapter` to `fep` in `fec_ptp_gettime()` to match the rest of the driver

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index ab86bb8562ef..afc658d2c271 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -443,21 +443,21 @@ static int fec_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
  */
 static int fec_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
-	struct fec_enet_private *adapter =
+	struct fec_enet_private *fep =
 	    container_of(ptp, struct fec_enet_private, ptp_caps);
 	u64 ns;
 	unsigned long flags;
 
-	mutex_lock(&adapter->ptp_clk_mutex);
+	mutex_lock(&fep->ptp_clk_mutex);
 	/* Check the ptp clock */
-	if (!adapter->ptp_clk_on) {
-		mutex_unlock(&adapter->ptp_clk_mutex);
+	if (!fep->ptp_clk_on) {
+		mutex_unlock(&fep->ptp_clk_mutex);
 		return -EINVAL;
 	}
-	spin_lock_irqsave(&adapter->tmreg_lock, flags);
-	ns = timecounter_read(&adapter->tc);
-	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
-	mutex_unlock(&adapter->ptp_clk_mutex);
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	ns = timecounter_read(&fep->tc);
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	mutex_unlock(&fep->ptp_clk_mutex);
 
 	*ts = ns_to_timespec64(ns);
 
-- 
2.25.1



