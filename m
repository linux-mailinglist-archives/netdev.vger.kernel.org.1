Return-Path: <netdev+bounces-136320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8634B9A152C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0521F21E56
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402821D63C6;
	Wed, 16 Oct 2024 21:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8331D5CE5
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115555; cv=none; b=KhXqjueEXOvh0xRCFuB0mIsULz7mAt8A+gGav4LU58swBIqCjXObUp8XJGIK1Wq2+YxHu/YUWpCkpoyc5iueY5/lKNqk1mpjzpYwTZbzNozOnVvKYhtfkzvXQippptosMI584bkNCE9iKE9O4b8yGrjTRKp7QVr8r2mUUfHLw5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115555; c=relaxed/simple;
	bh=XVXSrBwnjwJzG3Mu4AqC0twMOeUoMAa/k9VGh+plXKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UofA4iLLXlAVIEcsBs0emYkOqcsRiSEwz1pTKDBz8W3BvDiWXfMofp4aXU4zuKqqLBVghg+ZBwXJMe+D+jAh+ffyWnQHVeq6wy7ZYjK28ks6avbVTeLj9htmUX1R69xsnvp5r/0XhLakzPPQ3UzpW74SzXAGg2fZHzJOauJLktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwP-0003Jh-1O
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwN-002OPJ-Dt
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1D2EC3548C3
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D1A14354879;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5a53b740;
	Wed, 16 Oct 2024 21:52:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:49 +0200
Subject: [PATCH net-next 01/13] net: fec: fix typos found by codespell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-1-de783bd15e6a@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3729; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=XVXSrBwnjwJzG3Mu4AqC0twMOeUoMAa/k9VGh+plXKg=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDV/1AXer3fwLAq7BYzND+lVfhxBTKmo0pxom
 7VpHnbsBcqJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1fwAKCRAoOKI+ei28
 b6enB/4kvCAurNaACjRUSxqqu+gXKWERcZ4Y0a4Jf42Vi7xf6cx/BGja6Dt8u7AEhxewfPzBR1o
 fDa+LhmRzTx/DlLlx5Sh+vuPyFW557e/W2PY+YLbsi1C9Qm8UI2t92U2z15Hzrl0m0X9RQM1gvq
 BH6wLvzpG2AkRlT42hUSRFk6O3T2tfe2Byy4Q9SfSomO7rYOH2kbtmopODnrhw1brTJ9kMGEX2d
 RjuqTttci/ebFX8JlOKXARk/RZl0psrBLAfBG3cdd9sXpJ1Emn9VphgAFZQKJCcD4ybV9oj7yT7
 sd3luI6J9bNmUf/U7TqKDpDLHGIiV3xbm6Gizxg7ovEM9WSw
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

codespell has found some typos in the comments, fix them.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.h     | 8 ++++----
 drivers/net/ethernet/freescale/fec_ptp.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 1cca0425d49397bbdb97f2c058bd759f9e602f17..77c2a08d23542accdb85b37a6f86847d9eb56a7a 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -115,7 +115,7 @@
 #define IEEE_T_MCOL		0x254 /* Frames tx'd with multiple collision */
 #define IEEE_T_DEF		0x258 /* Frames tx'd after deferral delay */
 #define IEEE_T_LCOL		0x25c /* Frames tx'd with late collision */
-#define IEEE_T_EXCOL		0x260 /* Frames tx'd with excesv collisions */
+#define IEEE_T_EXCOL		0x260 /* Frames tx'd with excessive collisions */
 #define IEEE_T_MACERR		0x264 /* Frames tx'd with TX FIFO underrun */
 #define IEEE_T_CSERR		0x268 /* Frames tx'd with carrier sense err */
 #define IEEE_T_SQE		0x26c /* Frames tx'd with SQE err */
@@ -342,7 +342,7 @@ struct bufdesc_ex {
 #define FEC_TX_BD_FTYPE(X)	(((X) & 0xf) << 20)
 
 /* The number of Tx and Rx buffers.  These are allocated from the page
- * pool.  The code may assume these are power of two, so it it best
+ * pool.  The code may assume these are power of two, so it is best
  * to keep them that size.
  * We don't need to allocate pages for the transmitter.  We just use
  * the skbuffer directly.
@@ -460,7 +460,7 @@ struct bufdesc_ex {
 #define FEC_QUIRK_SINGLE_MDIO		(1 << 11)
 /* Controller supports RACC register */
 #define FEC_QUIRK_HAS_RACC		(1 << 12)
-/* Controller supports interrupt coalesc */
+/* Controller supports interrupt coalesce */
 #define FEC_QUIRK_HAS_COALESCE		(1 << 13)
 /* Interrupt doesn't wake CPU from deep idle */
 #define FEC_QUIRK_ERR006687		(1 << 14)
@@ -495,7 +495,7 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_HAS_EEE		(1 << 20)
 
-/* i.MX8QM ENET IP version add new feture to generate delayed TXC/RXC
+/* i.MX8QM ENET IP version add new feature to generate delayed TXC/RXC
  * as an alternative option to make sure it works well with various PHYs.
  * For the implementation of delayed clock, ENET takes synchronized 250MHz
  * clocks to generate 2ns delay.
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 7f6b57432071667e8553363f7c8c21198f38f530..8722f623d9e47e385439f1cee8c677e2b95b236d 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -118,7 +118,7 @@ static u64 fec_ptp_read(const struct cyclecounter *cc)
  * @fep: the fec_enet_private structure handle
  * @enable: enable the channel pps output
  *
- * This function enble the PPS ouput on the timer channel.
+ * This function enable the PPS output on the timer channel.
  */
 static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 {
@@ -173,7 +173,7 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 		 * very close to the second point, which means NSEC_PER_SEC
 		 * - ts.tv_nsec is close to be zero(For example 20ns); Since the timer
 		 * is still running when we calculate the first compare event, it is
-		 * possible that the remaining nanoseonds run out before the compare
+		 * possible that the remaining nanoseconds run out before the compare
 		 * counter is calculated and written into TCCR register. To avoid
 		 * this possibility, we will set the compare event to be the next
 		 * of next second. The current setting is 31-bit timer and wrap

-- 
2.45.2



