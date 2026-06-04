Return-Path: <netdev+bounces-295345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5P2hBOCqIWq0KwEAu9opvQ
	(envelope-from <netdev+bounces-295345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:42:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE45641F5B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:42:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=YUgnqFe3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295345-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295345-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A9F3105C96
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8148C8CF;
	Thu,  4 Jun 2026 16:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251403B95E3;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590780; cv=none; b=ZlICxsHCHKhljmbmuVhRzPU29J2Al0zY1B+3MZuxkL3VliFurVhWVgBHiMvVVD0EYPLNcyvyZB/fTJbYY0mL5ONm/ffMCr6efmCMBpN5GL5unyO+VVpXKWfhIjwC/0Mhw8O/AgI6oxQbeT5goel+hfo43liiQ6EntXJYg6a4FNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590780; c=relaxed/simple;
	bh=gHLpMozEh6f2gf2jM8Z5y7gDQUgutWrZiQNphZyscLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCc97/Jcx39Jc41tdTqQV2J/RPgRQznAVZHGfbCvKp1ZOtTJbF8bBNN+Xf92Vj9WZ3HJWJC/TxmTsjnrUc+HJDGtlAkAf7rAQjEyrwtqHCeJNFQIuSyw7fAUirWeHCnbAR0FYcslAOY+ly9o0yssPxuPPv459DXXrCe6JFAbx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUgnqFe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2160C2BCFF;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780590779;
	bh=gHLpMozEh6f2gf2jM8Z5y7gDQUgutWrZiQNphZyscLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YUgnqFe3qpr/Jx0dk6rcxD0UPFTdtgiKCaBRiQmWYio+IMr5TzLnvMyp3OruA1meL
	 nSiwjdaXGtAWQ8Z8Q1mu6Sj/ImjUj8wWydVHxea1R51YbuLwrzXXEjDmLjdMNmMD5g
	 2mAzr1xEWDW0/exT5EhMbghd2QNYYiPLbEME1WAlQtonUapG6VQ+OdEmfrCipMacWf
	 6TXahstx42/hA+7UC9vDomP4HDZqIaSSnRckCRWVVcc2bTo35XqsT7OuPboJWTyFMm
	 uDIpK9gtQu2N3Re5bOA4gBC/TcDIu4JsaxMewx/X7cMwXoUBNb/4I5L45qD9NO/wZP
	 W4jEaqD+8Z5Ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76FDCD6E7D;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 19:32:50 +0300
Subject: [PATCH net-next v3 05/13] net: ethernet: oa_tc6: Export standard
 defined registers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-adin1140-driver-v3-5-5debdb3173c4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780590775; l=5192;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=SnykMoUwLndx3IdbcHLqPP0Y55/QSx2yLP1+rPkpPh8=;
 b=g+yTEdg1tc0U6Eedi+q/eHi5iB8W8/YUlWiBuoJTnR6lnnyjct/JH58SLj1ExawKpLnlLrIZL
 Dr7n62QOZQwDVL+EVtBpy8V+B0lZDLLxyZMtCDGd2T0MnlJ1XuojmhD
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295345-lists,netdev=lfdr.de,ciprian.regus.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:mid,analog.com:email,analog.com:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AE45641F5B

From: Ciprian Regus <ciprian.regus@analog.com>

Move defines for standard Open Alliance TC6 register addresses and
subfields in the oa_tc6's header and add entries for the PHYID and
CONFIG2. As such, other ethernet drivers that rely on oa_tc6 can use
them directly.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v3 changelog:
 - Only move the register definitions, without adding the OA_TC6_ prefix
v2 changelog:
 - New patch
---
 drivers/net/ethernet/oa_tc6.c | 48 -------------------------------------------
 include/linux/oa_tc6.h        | 48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index b37e398e30e3..97df38207827 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -11,45 +11,6 @@
 #include <linux/phy.h>
 #include <linux/oa_tc6.h>
 
-/* OPEN Alliance TC6 registers */
-/* Standard Capabilities Register */
-#define OA_TC6_REG_STDCAP			0x0002
-#define STDCAP_DIRECT_PHY_REG_ACCESS		BIT(8)
-
-/* Reset Control and Status Register */
-#define OA_TC6_REG_RESET			0x0003
-#define RESET_SWRESET				BIT(0)	/* Software Reset */
-
-/* Configuration Register #0 */
-#define OA_TC6_REG_CONFIG0			0x0004
-#define CONFIG0_SYNC				BIT(15)
-#define CONFIG0_ZARFE_ENABLE			BIT(12)
-#define CONFIG0_PROTE				BIT(5)
-
-/* Status Register #0 */
-#define OA_TC6_REG_STATUS0			0x0008
-#define STATUS0_RESETC				BIT(6)	/* Reset Complete */
-#define STATUS0_HEADER_ERROR			BIT(5)
-#define STATUS0_LOSS_OF_FRAME_ERROR		BIT(4)
-#define STATUS0_RX_BUFFER_OVERFLOW_ERROR	BIT(3)
-#define STATUS0_TX_PROTOCOL_ERROR		BIT(0)
-
-/* Buffer Status Register */
-#define OA_TC6_REG_BUFFER_STATUS		0x000B
-#define BUFFER_STATUS_TX_CREDITS_AVAILABLE	GENMASK(15, 8)
-#define BUFFER_STATUS_RX_CHUNKS_AVAILABLE	GENMASK(7, 0)
-
-/* Interrupt Mask Register #0 */
-#define OA_TC6_REG_INT_MASK0			0x000C
-#define INT_MASK0_HEADER_ERR_MASK		BIT(5)
-#define INT_MASK0_LOSS_OF_FRAME_ERR_MASK	BIT(4)
-#define INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK	BIT(3)
-#define INT_MASK0_TX_PROTOCOL_ERR_MASK		BIT(0)
-
-/* PHY Clause 22 registers base address and mask */
-#define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
-#define OA_TC6_PHY_STD_REG_ADDR_MASK		0x1F
-
 /* Control command header */
 #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
 #define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
@@ -79,15 +40,6 @@
 #define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET	GENMASK(13, 8)
 #define OA_TC6_DATA_FOOTER_TX_CREDITS		GENMASK(5, 1)
 
-/* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in the
- * OPEN Alliance specification.
- */
-#define OA_TC6_PHY_C45_PCS_MMS2			2	/* MMD 3 */
-#define OA_TC6_PHY_C45_PMA_PMD_MMS3		3	/* MMD 1 */
-#define OA_TC6_PHY_C45_VS_PLCA_MMS4		4	/* MMD 31 */
-#define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
-#define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
-
 #define OA_TC6_CTRL_PROT_REPLY_SIZE		4
 #define OA_TC6_CTRL_HEADER_SIZE			4
 #define OA_TC6_CTRL_REG_VALUE_SIZE		4
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 2660eefa3504..bbc42758a313 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -10,6 +10,54 @@
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 
+/* OPEN Alliance TC6 registers */
+/* Standard Capabilities Register */
+#define OA_TC6_REG_STDCAP			0x0002
+#define STDCAP_DIRECT_PHY_REG_ACCESS		BIT(8)
+
+/* Reset Control and Status Register */
+#define OA_TC6_REG_RESET			0x0003
+#define RESET_SWRESET				BIT(0)	/* Software Reset */
+
+/* Configuration Register #0 */
+#define OA_TC6_REG_CONFIG0			0x0004
+#define CONFIG0_SYNC				BIT(15)
+#define CONFIG0_ZARFE_ENABLE			BIT(12)
+#define CONFIG0_PROTE				BIT(5)
+
+/* Status Register #0 */
+#define OA_TC6_REG_STATUS0			0x0008
+#define STATUS0_RESETC				BIT(6)	/* Reset Complete */
+#define STATUS0_HEADER_ERROR			BIT(5)
+#define STATUS0_LOSS_OF_FRAME_ERROR		BIT(4)
+#define STATUS0_RX_BUFFER_OVERFLOW_ERROR	BIT(3)
+#define STATUS0_TX_PROTOCOL_ERROR		BIT(0)
+
+/* Buffer Status Register */
+#define OA_TC6_REG_BUFFER_STATUS		0x000B
+#define BUFFER_STATUS_TX_CREDITS_AVAILABLE	GENMASK(15, 8)
+#define BUFFER_STATUS_RX_CHUNKS_AVAILABLE	GENMASK(7, 0)
+
+/* Interrupt Mask Register #0 */
+#define OA_TC6_REG_INT_MASK0			0x000C
+#define INT_MASK0_HEADER_ERR_MASK		BIT(5)
+#define INT_MASK0_LOSS_OF_FRAME_ERR_MASK	BIT(4)
+#define INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK	BIT(3)
+#define INT_MASK0_TX_PROTOCOL_ERR_MASK		BIT(0)
+
+/* PHY Clause 22 registers base address and mask */
+#define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
+#define OA_TC6_PHY_STD_REG_ADDR_MASK		0x1F
+
+/* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in the
+ * OPEN Alliance specification.
+ */
+#define OA_TC6_PHY_C45_PCS_MMS2			2	/* MMD 3 */
+#define OA_TC6_PHY_C45_PMA_PMD_MMS3		3	/* MMD 1 */
+#define OA_TC6_PHY_C45_VS_PLCA_MMS4		4	/* MMD 31 */
+#define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
+#define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
+
 struct oa_tc6;
 
 enum oa_tc6_quirk_flag {

-- 
2.43.0



