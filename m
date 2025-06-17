Return-Path: <netdev+bounces-198597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 865DFADCD0F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60247A1E00
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E82DE20C;
	Tue, 17 Jun 2025 13:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC01290BC4
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166734; cv=none; b=IgosDNDHhJCU/Qv+sG6k55gOQhAzhEaHvbsBrP6FrbdYvHJ22cHtRNj+/DDB/8XG+ZFhUO4EOrmuXC6+y9Ho4hHPlJPN/TQ3dc2bInTqVGe/9k+iXYd7tweXXtj8LDOWCnSUIw//6PXBD7cdnUtuFXHLYsjaPawPFW+vgnsWIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166734; c=relaxed/simple;
	bh=TImvkETCV7p7PD/nkYjqoMCUVxOt2SMtL7fqY4urm/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUX5POmWqtQTz87nJOMI0MSX3B+5sgNZh12wN2W2XhlUK7UrWvf97AemD18cwlhpnOepZISzDjWf58X54nzMn1gI6R3MGhsFV6oZjl0FZMKRW5Mi4McQUxHHYAX/BYlW966wNE5CXxRHkxNlpMc8cmLyj2GuuOCdPzq0+HvlP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e2bf:c3f2:96ab:885d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 7428D66ECF0
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:25 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 438CF42A7F3
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 48DD742A79F;
	Tue, 17 Jun 2025 13:25:21 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d3cf84ce;
	Tue, 17 Jun 2025 13:25:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 17 Jun 2025 15:24:51 +0200
Subject: [PATCH net-next v3 01/10] net: fec: fix typos found by codespell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250617-fec-cleanups-v3-1-a57bfb38993f@pengutronix.de>
References: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
In-Reply-To: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=4516; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=TImvkETCV7p7PD/nkYjqoMCUVxOt2SMtL7fqY4urm/k=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUWytwDPvtd0e58KNOg78Bh4TylXt97nz2P6WQ
 iHOto3SHJqJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFFsrQAKCRAMdGXf+ZCR
 nOzqCACxZjDBH2bnOn/nt5AsrRRuRBOlvGIz7DfSB9eDthimBkxYO5nAwkuEbaZVFt5IyJEkBR+
 azoTFqxPV+xY3NZ97LOJZvleHUTXhHDIfGz7DK2+1HNwS1G765wIXtkJH3gLm2d4eYmZxoPGBnV
 H3HZvYc1yU36k73CKG3rpkXqk6+Qei9Pw9IHJNJCzfgRamwoB1jfd47fSDJPBJFSNsytjRgiVPX
 mlv/E5p1y+Gt76Tqk24FzpgCPqWfJITfZyM0aorGFCOi5hZQHTPebfeyLqhH80T8SqAdUZtoZse
 XGoLha5zE9dcVQWkrUHV4a+/Ad/B745GLrzcX8rhg0qUoe58
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

codespell has found some typos in the comments, fix them.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.h         | 8 ++++----
 drivers/net/ethernet/freescale/fec_mpc52xx.c | 2 +-
 drivers/net/ethernet/freescale/fec_ptp.c     | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index c81f2ea588f2..3cce9bba5dee 100644
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
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index 2bfaf14f65c8..3fc29afc9854 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -619,7 +619,7 @@ static void mpc52xx_fec_hw_init(struct net_device *dev)
 	out_be32(&fec->rfifo_alarm, 0x0000030c);
 	out_be32(&fec->tfifo_alarm, 0x00000100);
 
-	/* begin transmittion when 256 bytes are in FIFO (or EOF or FIFO full) */
+	/* begin transmission when 256 bytes are in FIFO (or EOF or FIFO full) */
 	out_be32(&fec->x_wmrk, FEC_FIFO_WMRK_256B);
 
 	/* enable crc generation */
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 876d90832596..d6d9f0d6ca99 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -117,7 +117,7 @@ static u64 fec_ptp_read(const struct cyclecounter *cc)
  * @fep: the fec_enet_private structure handle
  * @enable: enable the channel pps output
  *
- * This function enble the PPS ouput on the timer channel.
+ * This function enables the PPS output on the timer channel.
  */
 static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 {
@@ -172,7 +172,7 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 		 * very close to the second point, which means NSEC_PER_SEC
 		 * - ts.tv_nsec is close to be zero(For example 20ns); Since the timer
 		 * is still running when we calculate the first compare event, it is
-		 * possible that the remaining nanoseonds run out before the compare
+		 * possible that the remaining nanoseconds run out before the compare
 		 * counter is calculated and written into TCCR register. To avoid
 		 * this possibility, we will set the compare event to be the next
 		 * of next second. The current setting is 31-bit timer and wrap

-- 
2.47.2



