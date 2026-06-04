Return-Path: <netdev+bounces-295344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y/B4NWGvIWrsLAEAu9opvQ
	(envelope-from <netdev+bounces-295344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:01:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF5642266
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:01:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Opk4Eydi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295344-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295344-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E05330BAB0C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010AD48C8C4;
	Thu,  4 Jun 2026 16:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E753B9935;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590780; cv=none; b=MZPkGgbO6yJ5GCFWf0jaABub7+n58F6IEX3d8gFIV/VZA+htlEB0nWVB2DhNon10EYZ5RhGrR+coZyObUnXvAQmD/GooR1M0Y7LdBFIRgU4KpWtCF24RK5ANR0PHKkkwOTCGzC3avDp3msYSQ4MiXBn6fMTLoO0jITqLW/fw+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590780; c=relaxed/simple;
	bh=szsxI7s4ajswbkCUFBTBD8d8vD1Z/ZedbsriN75zF5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9tUxQSjmih8OlptkJ4ji73CDxRdEhBhGeXB9Rgtv/NSeybTOgi2yFR/+NMzyCfANmfBiAJG48IqGFG2j8m8Aca5ZdGN+3XVyN9g2V+nAQ4HrGQJGWTT/1Toy7dEn7I0MmBaccDMU3KVyG41suhJ9kaY/hhJh7z84EeNWNFw4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opk4Eydi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFC98C2BCFB;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780590779;
	bh=szsxI7s4ajswbkCUFBTBD8d8vD1Z/ZedbsriN75zF5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Opk4Eydi39B2nFFTgZEPYU+R0egi7ZLk+ZNyL7R1pX/0hDsxYGPHTV9bYOB1avVA8
	 9uKIFUqK/gdQfpQM64xyvIZnVv0/Fq/bLSGO2VLujYMReusy2WjPNTXv6T64CHFMeN
	 q+5Pyvs34LJiXPGxE7G7hCIq7luvnycchsajlcc/SkWiN6ZasAkibKry16ztJ00Kgb
	 Bgbq2ImCSdsGa3M7asQo5hRXEnC2eqUXuWTtrmr7HhANjvGzAkTLFwmqUWfwC57pFo
	 9kTw7JDNVMI+37LEnY80BphbmT5CKvsBR7vjQHm/omzdWpxlalGYcsPuwOTwBqFgIg
	 KBnaCGiT+CDoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88A4CD6E79;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 19:32:51 +0300
Subject: [PATCH net-next v3 06/13] net: ethernet: oa_tc6: Add the OA_TC6_
 prefix to standard registers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-adin1140-driver-v3-6-5debdb3173c4@analog.com>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
In-Reply-To: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780590775; l=7168;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=guMxrl2Z2kGqnZvHBADy+lB8CINQv/UgNqNLCTsfsmM=;
 b=qSV7uo4g6HO9gWJSTpX39ORkUH3P5QHQOIHcFGVk+BmcnWEASaklHkjJZNPRFAj/u/KOB78xC
 Tct6uqcBIpADN/u6eGHSBpmEA/GGtY/r1wGqhQKsFufA/6Ns+OjG3Bb
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295344-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:mid,analog.com:email,analog.com:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BECF5642266

From: Ciprian Regus <ciprian.regus@analog.com>

The OA TC6 standard registers are currently exported in a header file.
Add the OA_TC6_ prefix to the register address and subfield mask macros
to avoid future naming conflicts.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v3 changelog:
 - New patch
---
 drivers/net/ethernet/oa_tc6.c | 35 ++++++++++++++++++-----------------
 include/linux/oa_tc6.h        | 36 ++++++++++++++++++------------------
 2 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 97df38207827..92da5bb74cc7 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -397,7 +397,7 @@ static int oa_tc6_check_phy_reg_direct_access_capability(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
-	if (!(regval & STDCAP_DIRECT_PHY_REG_ACCESS))
+	if (!(regval & OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS))
 		return -ENODEV;
 
 	return 0;
@@ -598,7 +598,7 @@ static int oa_tc6_read_status0(struct oa_tc6 *tc6)
 
 static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
 {
-	u32 regval = RESET_SWRESET;
+	u32 regval = OA_TC6_RESET_SWRESET;
 	int ret;
 
 	ret = oa_tc6_write_register(tc6, OA_TC6_REG_RESET, regval);
@@ -607,7 +607,7 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
 
 	/* Poll for soft reset complete for every 1ms until 1s timeout */
 	ret = readx_poll_timeout(oa_tc6_read_status0, tc6, regval,
-				 regval & STATUS0_RESETC,
+				 regval & OA_TC6_STATUS0_RESETC,
 				 STATUS0_RESETC_POLL_DELAY,
 				 STATUS0_RESETC_POLL_TIMEOUT);
 	if (ret)
@@ -626,10 +626,10 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
-	regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
-		    INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
-		    INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
-		    INT_MASK0_HEADER_ERR_MASK);
+	regval &= ~(OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK |
+		    OA_TC6_INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
+		    OA_TC6_INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
+		    OA_TC6_INT_MASK0_HEADER_ERR_MASK);
 
 	return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
 }
@@ -644,7 +644,7 @@ static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
 		return ret;
 
 	/* Enable configuration synchronization for data transfer */
-	value |= CONFIG0_SYNC;
+	value |= OA_TC6_CONFIG0_SYNC;
 
 	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, value);
 }
@@ -687,25 +687,25 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
 		return ret;
 	}
 
-	if (FIELD_GET(STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
+	if (FIELD_GET(OA_TC6_STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
 		tc6->rx_buf_overflow = true;
 		oa_tc6_cleanup_ongoing_rx_skb(tc6);
 		net_err_ratelimited("%s: Receive buffer overflow error\n",
 				    tc6->netdev->name);
 		return -EAGAIN;
 	}
-	if (FIELD_GET(STATUS0_TX_PROTOCOL_ERROR, value)) {
+	if (FIELD_GET(OA_TC6_STATUS0_TX_PROTOCOL_ERROR, value)) {
 		netdev_err(tc6->netdev, "Transmit protocol error\n");
 		return -ENODEV;
 	}
 	/* TODO: Currently loss of frame and header errors are treated as
 	 * non-recoverable errors. They will be handled in the next version.
 	 */
-	if (FIELD_GET(STATUS0_LOSS_OF_FRAME_ERROR, value)) {
+	if (FIELD_GET(OA_TC6_STATUS0_LOSS_OF_FRAME_ERROR, value)) {
 		netdev_err(tc6->netdev, "Loss of frame error\n");
 		return -ENODEV;
 	}
-	if (FIELD_GET(STATUS0_HEADER_ERROR, value)) {
+	if (FIELD_GET(OA_TC6_STATUS0_HEADER_ERROR, value)) {
 		netdev_err(tc6->netdev, "Header error\n");
 		return -ENODEV;
 	}
@@ -1141,9 +1141,10 @@ static int oa_tc6_update_buffer_status_from_register(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
-	tc6->tx_credits = FIELD_GET(BUFFER_STATUS_TX_CREDITS_AVAILABLE, value);
-	tc6->rx_chunks_available = FIELD_GET(BUFFER_STATUS_RX_CHUNKS_AVAILABLE,
-					     value);
+	tc6->tx_credits = FIELD_GET(OA_TC6_BUFFER_STATUS_TX_CREDITS_AVAILABLE,
+				    value);
+	tc6->rx_chunks_available =
+		FIELD_GET(OA_TC6_BUFFER_STATUS_RX_CHUNKS_AVAILABLE, value);
 
 	return 0;
 }
@@ -1183,7 +1184,7 @@ int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6)
 		return ret;
 
 	/* Set Zero-Align Receive Frame Enable */
-	regval |= CONFIG0_ZARFE_ENABLE;
+	regval |= OA_TC6_CONFIG0_ZARFE_ENABLE;
 
 	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, regval);
 }
@@ -1231,7 +1232,7 @@ static int oa_tc6_check_ctrl_protection(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
-	tc6->prot_ctrl = FIELD_GET(CONFIG0_PROTE, regval);
+	tc6->prot_ctrl = FIELD_GET(OA_TC6_CONFIG0_PROTE, regval);
 
 	return 0;
 }
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index bbc42758a313..bd369aac9c3b 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -13,37 +13,37 @@
 /* OPEN Alliance TC6 registers */
 /* Standard Capabilities Register */
 #define OA_TC6_REG_STDCAP			0x0002
-#define STDCAP_DIRECT_PHY_REG_ACCESS		BIT(8)
+#define OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS	BIT(8)
 
 /* Reset Control and Status Register */
 #define OA_TC6_REG_RESET			0x0003
-#define RESET_SWRESET				BIT(0)	/* Software Reset */
+#define OA_TC6_RESET_SWRESET			BIT(0)	/* Software Reset */
 
 /* Configuration Register #0 */
 #define OA_TC6_REG_CONFIG0			0x0004
-#define CONFIG0_SYNC				BIT(15)
-#define CONFIG0_ZARFE_ENABLE			BIT(12)
-#define CONFIG0_PROTE				BIT(5)
+#define OA_TC6_CONFIG0_SYNC			BIT(15)
+#define OA_TC6_CONFIG0_ZARFE_ENABLE		BIT(12)
+#define OA_TC6_CONFIG0_PROTE			BIT(5)
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
-#define STATUS0_RESETC				BIT(6)	/* Reset Complete */
-#define STATUS0_HEADER_ERROR			BIT(5)
-#define STATUS0_LOSS_OF_FRAME_ERROR		BIT(4)
-#define STATUS0_RX_BUFFER_OVERFLOW_ERROR	BIT(3)
-#define STATUS0_TX_PROTOCOL_ERROR		BIT(0)
+#define OA_TC6_STATUS0_RESETC			BIT(6)	/* Reset Complete */
+#define OA_TC6_STATUS0_HEADER_ERROR		BIT(5)
+#define OA_TC6_STATUS0_LOSS_OF_FRAME_ERROR	BIT(4)
+#define OA_TC6_STATUS0_RX_BUFFER_OVERFLOW_ERROR	BIT(3)
+#define OA_TC6_STATUS0_TX_PROTOCOL_ERROR	BIT(0)
 
 /* Buffer Status Register */
-#define OA_TC6_REG_BUFFER_STATUS		0x000B
-#define BUFFER_STATUS_TX_CREDITS_AVAILABLE	GENMASK(15, 8)
-#define BUFFER_STATUS_RX_CHUNKS_AVAILABLE	GENMASK(7, 0)
+#define OA_TC6_REG_BUFFER_STATUS			0x000B
+#define OA_TC6_BUFFER_STATUS_TX_CREDITS_AVAILABLE	GENMASK(15, 8)
+#define OA_TC6_BUFFER_STATUS_RX_CHUNKS_AVAILABLE	GENMASK(7, 0)
 
 /* Interrupt Mask Register #0 */
-#define OA_TC6_REG_INT_MASK0			0x000C
-#define INT_MASK0_HEADER_ERR_MASK		BIT(5)
-#define INT_MASK0_LOSS_OF_FRAME_ERR_MASK	BIT(4)
-#define INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK	BIT(3)
-#define INT_MASK0_TX_PROTOCOL_ERR_MASK		BIT(0)
+#define OA_TC6_REG_INT_MASK0				0x000C
+#define OA_TC6_INT_MASK0_HEADER_ERR_MASK		BIT(5)
+#define OA_TC6_INT_MASK0_LOSS_OF_FRAME_ERR_MASK		BIT(4)
+#define OA_TC6_INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK	BIT(3)
+#define OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK		BIT(0)
 
 /* PHY Clause 22 registers base address and mask */
 #define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00

-- 
2.43.0



