Return-Path: <netdev+bounces-196977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D3AD7396
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F031885D4D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085DA248F5F;
	Thu, 12 Jun 2025 14:16:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936A2222AA
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737792; cv=none; b=tvgo/mV9oq1qH4RaYlyDgbJtX2tz4e6QH5iQ8EQIac3TxNYemSefMtbl+1HwvNft60MgwrrVq5W/s49Etccxl0ahk786R+7YgrLLAAuYvYP9v/6ejRmwDiTwXM8TSLF455IXVDaMqjhAmLHnF1gfvW/c/1n33YrNi4wsb5JvUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737792; c=relaxed/simple;
	bh=fM3DJ0fKp+s7JwVePf1s77eQbBcgW9+yZWYcLMCuBf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEHzbVGrkeVRZ80C04NFVt8MmD4LP0Q2FlEUWynnXujRF2kZFaWb2xSi26qM1ToQeLdJajLZ7+wPSb/no/XV3kIZrFKPhh4b0mYYP62HUG12eGvcMC9ALiM5SeVpwENdrgYgl8yGuVnD8jtW07BKgCiVFHbHPQZmA9NpTBVxjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e75c:5124:23a3:4f62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 154AF66BBA0
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:22 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D719C42646E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EB8AE42641E;
	Thu, 12 Jun 2025 14:16:17 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8943e361;
	Thu, 12 Jun 2025 14:16:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 12 Jun 2025 16:15:54 +0200
Subject: [PATCH net-next v2 01/10] net: fec: fix typos found by codespell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-fec-cleanups-v2-1-ae7c36df185e@pengutronix.de>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
In-Reply-To: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3701; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=fM3DJ0fKp+s7JwVePf1s77eQbBcgW9+yZWYcLMCuBf4=;
 b=kA0DAAoBDHRl3/mQkZwByyZiAGhK4R6gqFFCBHaQvogqFti7YA5JQXQfKIZcAtO9hIekE3OuC
 IkBMwQAAQoAHRYhBJ/7DNivZ6hf/BVs8wx0Zd/5kJGcBQJoSuEeAAoJEAx0Zd/5kJGcDYIIAJAU
 k3788reIO3/4DKGBNdI+KFFLuE1qVm4nWKMUqJwCpPNO9kTRaiVxNALjxiDYJOygv+sGJgMXX//
 hNhUAXkCEQ2YmXrw5FARiWbJJV4zOtwj0UYBe5QIJ76mkz2JEDiT8ad3tbHrQxvjeK4eZkRFBk8
 BCu50JOJsKRkx99cqfAF8o5hHScJdR/muYvLNzHLHym4STWIGtt02aJTbGmj9qfEjEZTYBjLHe8
 k3pwD3CWHtbyA0UG+fwMu4rrTy631QWjCMVrqQ86lSgGERF76XO/opjN5CUwQ3cZmyfJ3llEq8y
 eEMRncEJwp8AzoGQ7nSsBbE03zaxvOw3EJ4c5dA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

codespell has found some typos in the comments, fix them.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.h     | 8 ++++----
 drivers/net/ethernet/freescale/fec_ptp.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

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
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 876d90832596..3aacd64c9e73 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -117,7 +117,7 @@ static u64 fec_ptp_read(const struct cyclecounter *cc)
  * @fep: the fec_enet_private structure handle
  * @enable: enable the channel pps output
  *
- * This function enble the PPS ouput on the timer channel.
+ * This function enable the PPS output on the timer channel.
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



