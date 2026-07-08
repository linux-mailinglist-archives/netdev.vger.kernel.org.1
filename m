Return-Path: <netdev+bounces-305921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bKkkI9eFTmoMOgIAu9opvQ
	(envelope-from <netdev+bounces-305921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:16:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C0072914D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:16:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=BnwlX4Z2;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305921-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305921-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F1A23023FBE
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD64D2EEA;
	Wed,  8 Jul 2026 17:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122124C6EEF;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530757; cv=none; b=pnrMI5IoInUmZ30te7/YE8jWP+N7wCOmeS6cS+jTj6LbOhpEJovdfchZieRQurzsch2aDHE2rZtLTDtoe2/nK330AtdB8b5EeRuCwIbVP6QBuLLOYsndyvoKyppJmAn80JPJeu0yLiImuanamDIXkSQIUiGv6Dk9PllwtKR4Z4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530757; c=relaxed/simple;
	bh=uDIYz2uFATbQoBFK5ieshxBAZcZ9+zSmiUoYej2a4x8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PubBz4IokV9HWCTYLARQxhsQ2yo4pQ+I/fUTb710YweThA/0tJsRHdsl3H/toPmxsGZmTjNU917T72RJI3QOEkIWADowwtcU0JJLdWMJNzxm42thKTzbFGliWibfK/CSqAfoYuQr+w8RNpCdRl/is3f9fEFE8EIJEL5Pn3c1oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnwlX4Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C54B4C4AF14;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530756;
	bh=uDIYz2uFATbQoBFK5ieshxBAZcZ9+zSmiUoYej2a4x8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BnwlX4Z2MVGM41BghdSEm7AnoEQMdc0/8uDckFmwDXebJ36GC+MWheKNkmtAeDHPT
	 eu3TEIpQ0t8SXsRYXP1JZy80sWrsJpyEoFiJEyltqOoWT0s9U1UNQ9DEuQy+9irFzu
	 UtjtHqsMRp0D//WhuG9netRfpjLfeRAw/Fut7Hz/toofkQrRp/Oj+7xV/1fNDgc+9M
	 IppnYoX4Q8UJIB9bDEc82O5uUf7/Rr2ke34E1TUwLLtYYiOh7ifMODgqm3RITUFkur
	 7KnwpWxerWQ0/Vv1/xmL/PpAuDcQIpPQKbtwyg0rDCpA7WpqJzpnoRBev4o1fM255q
	 ZvJNwXNQh+Qvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C5FC44501;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:37 -0700
Subject: [PATCH net-next v7 07/15] net: ethernet: oa_tc6: Move constant
 definitions to header file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-s2500-mac-phy-support-v7-7-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=13137;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=3gXwntDzFmCiEwU+4UPmat6Gtc9FbFlk+o+D29kHnnY=;
 b=xPSoOUe0eLz62Ho5yFqcg7cV0A2N1g+4FN9k1YbkwJCt++sHSYfQhnLaOPFlvusYKwrX33HFb
 dwm84wkxElvBq2yCjM83JEuBGtr+EzPnDqXVBbvsx54T5Nu8uBkzYwx
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305921-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82C0072914D

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

To help other source files within the module share the
constant definitions, they are moved to a header file.

The memory map selector(MMS) values that are defined in
in Table 6 of OPEN Alliance 10BASE-T1x Serial Interface
specification and currently used are added.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - Added MMS values 1 and 12, which are used now
changes in v3
  - Moved constant definitions from the source to newly created
    header file for other sources in the directory to share.
  - Standard specific defines are moved to Linux common header file
  - First patch
---
 drivers/net/ethernet/oa_tc6/oa_tc6.c         | 145 +------------------------
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h | 157 +++++++++++++++++++++++++++
 include/linux/oa_tc6.h                       |  15 +++
 3 files changed, 173 insertions(+), 144 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
index 0727d53345a3..bf96e8d1ccb9 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -12,150 +12,7 @@
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
-#define INT_MASK0_ALL_INTERRUPTS                (GENMASK(5, 0) | \
-						 GENMASK(12, 7))
-
-/* PHY Clause 22 registers base address and mask */
-#define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
-#define OA_TC6_PHY_STD_REG_ADDR_MASK		0x1F
-
-/* Control command header */
-#define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
-#define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
-#define OA_TC6_CTRL_HEADER_MEM_MAP_SELECTOR	GENMASK(27, 24)
-#define OA_TC6_CTRL_HEADER_ADDR			GENMASK(23, 8)
-#define OA_TC6_CTRL_HEADER_LENGTH		GENMASK(7, 1)
-#define OA_TC6_CTRL_HEADER_PARITY		BIT(0)
-
-/* Data header */
-#define OA_TC6_DATA_HEADER_DATA_NOT_CTRL	BIT(31)
-#define OA_TC6_DATA_HEADER_DATA_VALID		BIT(21)
-#define OA_TC6_DATA_HEADER_START_VALID		BIT(20)
-#define OA_TC6_DATA_HEADER_START_WORD_OFFSET	GENMASK(19, 16)
-#define OA_TC6_DATA_HEADER_END_VALID		BIT(14)
-#define OA_TC6_DATA_HEADER_END_BYTE_OFFSET	GENMASK(13, 8)
-#define OA_TC6_DATA_HEADER_PARITY		BIT(0)
-
-/* Data footer */
-#define OA_TC6_DATA_FOOTER_EXTENDED_STS		BIT(31)
-#define OA_TC6_DATA_FOOTER_RXD_HEADER_BAD	BIT(30)
-#define OA_TC6_DATA_FOOTER_CONFIG_SYNC		BIT(29)
-#define OA_TC6_DATA_FOOTER_RX_CHUNKS		GENMASK(28, 24)
-#define OA_TC6_DATA_FOOTER_DATA_VALID		BIT(21)
-#define OA_TC6_DATA_FOOTER_START_VALID		BIT(20)
-#define OA_TC6_DATA_FOOTER_START_WORD_OFFSET	GENMASK(19, 16)
-#define OA_TC6_DATA_FOOTER_END_VALID		BIT(14)
-#define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET	GENMASK(13, 8)
-#define OA_TC6_DATA_FOOTER_TX_CREDITS		GENMASK(5, 1)
-
-/* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in the
- * OPEN Alliance specification.
- */
-#define OA_TC6_PHY_C45_PCS_MMS2			2	/* MMD 3 */
-#define OA_TC6_PHY_C45_PMA_PMD_MMS3		3	/* MMD 1 */
-#define OA_TC6_PHY_C45_VS_PLCA_MMS4		4	/* MMD 31 */
-#define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
-#define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
-
-#define OA_TC6_CTRL_HEADER_SIZE			4
-#define OA_TC6_CTRL_REG_VALUE_SIZE		4
-#define OA_TC6_CTRL_IGNORED_SIZE		4
-#define OA_TC6_CTRL_MAX_REGISTERS		128
-#define OA_TC6_CTRL_SPI_BUF_SIZE		(OA_TC6_CTRL_HEADER_SIZE +\
-						(OA_TC6_CTRL_MAX_REGISTERS *\
-						OA_TC6_CTRL_REG_VALUE_SIZE) +\
-						OA_TC6_CTRL_IGNORED_SIZE)
-#define OA_TC6_CHUNK_PAYLOAD_SIZE		64
-#define OA_TC6_DATA_HEADER_SIZE			4
-#define OA_TC6_CHUNK_SIZE			(OA_TC6_DATA_HEADER_SIZE +\
-						OA_TC6_CHUNK_PAYLOAD_SIZE)
-#define OA_TC6_MAX_TX_CHUNKS			48
-#define OA_TC6_SPI_DATA_BUF_SIZE		(OA_TC6_MAX_TX_CHUNKS *\
-						OA_TC6_CHUNK_SIZE)
-#define STATUS0_RESETC_POLL_DELAY		1000
-#define STATUS0_RESETC_POLL_TIMEOUT		1000000
-
-/* Internal structure for MAC-PHY drivers */
-struct oa_tc6 {
-	struct net_device *netdev;
-	struct phy_device *phydev;
-	struct mii_bus *mdiobus;
-	struct spi_device *spi;
-	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
-	spinlock_t tx_skb_lock; /* Protects tx skb handling */
-	void *spi_ctrl_tx_buf;
-	void *spi_ctrl_rx_buf;
-	void *spi_data_tx_buf;
-	void *spi_data_rx_buf;
-	struct sk_buff *ongoing_tx_skb;
-	struct sk_buff *waiting_tx_skb;
-	struct sk_buff *rx_skb;
-	u16 tx_skb_offset;
-	u16 spi_data_tx_buf_offset;
-	u16 tx_credits;
-	u8 rx_chunks_available;
-	bool rx_buf_overflow;
-	bool int_flag;
-	bool disable_traffic;
-};
-
-enum oa_tc6_header_type {
-	OA_TC6_CTRL_HEADER,
-	OA_TC6_DATA_HEADER,
-};
-
-enum oa_tc6_register_op {
-	OA_TC6_CTRL_REG_READ = 0,
-	OA_TC6_CTRL_REG_WRITE = 1,
-};
-
-enum oa_tc6_data_valid_info {
-	OA_TC6_DATA_INVALID,
-	OA_TC6_DATA_VALID,
-};
-
-enum oa_tc6_data_start_valid_info {
-	OA_TC6_DATA_START_INVALID,
-	OA_TC6_DATA_START_VALID,
-};
-
-enum oa_tc6_data_end_valid_info {
-	OA_TC6_DATA_END_INVALID,
-	OA_TC6_DATA_END_VALID,
-};
+#include "oa_tc6_std_def.h"
 
 static int oa_tc6_spi_transfer(struct oa_tc6 *tc6,
 			       enum oa_tc6_header_type header_type, u16 length)
diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
new file mode 100644
index 000000000000..6bacf254a36a
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Register and driver related definitions to support
+ * OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface framework.
+ *
+ * Author: Selva Rajagopal <selvamani.rajagopal@onsemi.com>
+ */
+
+#ifndef OA_TC6_STD_DEF_H
+#define OA_TC6_STD_DEF_H
+
+#include <linux/ptp_clock_kernel.h>
+#include <linux/net_tstamp.h>
+#include <linux/netdevice.h>
+#include <linux/spi/spi.h>
+#include <linux/skbuff.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/phy.h>
+
+/* OPEN Alliance TC6 registers */
+/* Standard Capabilities Register */
+#define OA_TC6_REG_STDCAP			0x0002
+#define STDCAP_DIRECT_PHY_REG_ACCESS		BIT(8)
+
+/* Reset Control and Status Register */
+#define OA_TC6_REG_RESET			0x0003
+#define RESET_SWRESET				BIT(0)
+
+/* Configuration Register #0 */
+#define OA_TC6_REG_CONFIG0			0x0004
+#define CONFIG0_SYNC				BIT(15)
+#define CONFIG0_ZARFE_ENABLE			BIT(12)
+
+/* Status Register #0 */
+#define OA_TC6_REG_STATUS0			0x0008
+#define STATUS0_RESETC				BIT(6)
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
+#define INT_MASK0_ALL_INTERRUPTS		(GENMASK(5, 0) | \
+						 GENMASK(12, 7))
+
+/* PHY Clause 22 registers base address and mask */
+#define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
+#define OA_TC6_PHY_STD_REG_ADDR_MASK		0x1F
+
+/* Control command header */
+#define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
+#define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
+#define OA_TC6_CTRL_HEADER_MEM_MAP_SELECTOR	GENMASK(27, 24)
+#define OA_TC6_CTRL_HEADER_ADDR			GENMASK(23, 8)
+#define OA_TC6_CTRL_HEADER_LENGTH		GENMASK(7, 1)
+#define OA_TC6_CTRL_HEADER_PARITY		BIT(0)
+
+/* Data header */
+#define OA_TC6_DATA_HEADER_DATA_NOT_CTRL	BIT(31)
+#define OA_TC6_DATA_HEADER_DATA_VALID		BIT(21)
+#define OA_TC6_DATA_HEADER_START_VALID		BIT(20)
+#define OA_TC6_DATA_HEADER_START_WORD_OFFSET	GENMASK(19, 16)
+#define OA_TC6_DATA_HEADER_END_VALID		BIT(14)
+#define OA_TC6_DATA_HEADER_END_BYTE_OFFSET	GENMASK(13, 8)
+#define OA_TC6_DATA_HEADER_PARITY		BIT(0)
+
+/* Data footer */
+#define OA_TC6_DATA_FOOTER_EXTENDED_STS		BIT(31)
+#define OA_TC6_DATA_FOOTER_RXD_HEADER_BAD	BIT(30)
+#define OA_TC6_DATA_FOOTER_CONFIG_SYNC		BIT(29)
+#define OA_TC6_DATA_FOOTER_RX_CHUNKS		GENMASK(28, 24)
+#define OA_TC6_DATA_FOOTER_DATA_VALID		BIT(21)
+#define OA_TC6_DATA_FOOTER_START_VALID		BIT(20)
+#define OA_TC6_DATA_FOOTER_START_WORD_OFFSET	GENMASK(19, 16)
+#define OA_TC6_DATA_FOOTER_END_VALID		BIT(14)
+#define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET	GENMASK(13, 8)
+#define OA_TC6_DATA_FOOTER_TX_CREDITS		GENMASK(5, 1)
+
+#define OA_TC6_CTRL_HEADER_SIZE			4
+#define OA_TC6_CTRL_REG_VALUE_SIZE		4
+#define OA_TC6_CTRL_IGNORED_SIZE		4
+#define OA_TC6_CTRL_MAX_REGISTERS		128
+#define OA_TC6_CTRL_SPI_BUF_SIZE		(OA_TC6_CTRL_HEADER_SIZE +\
+						(OA_TC6_CTRL_MAX_REGISTERS *\
+						OA_TC6_CTRL_REG_VALUE_SIZE) +\
+						OA_TC6_CTRL_IGNORED_SIZE)
+#define OA_TC6_CHUNK_PAYLOAD_SIZE		64
+#define OA_TC6_DATA_HEADER_SIZE			4
+#define OA_TC6_CHUNK_SIZE			(OA_TC6_DATA_HEADER_SIZE +\
+						OA_TC6_CHUNK_PAYLOAD_SIZE)
+#define OA_TC6_MAX_TX_CHUNKS			48
+#define OA_TC6_SPI_DATA_BUF_SIZE		(OA_TC6_MAX_TX_CHUNKS *\
+						OA_TC6_CHUNK_SIZE)
+#define STATUS0_RESETC_POLL_DELAY		1000
+#define STATUS0_RESETC_POLL_TIMEOUT		1000000
+
+/* Internal structure for MAC-PHY drivers */
+struct oa_tc6 {
+	struct net_device *netdev;
+	struct phy_device *phydev;
+	struct mii_bus *mdiobus;
+	struct spi_device *spi;
+	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
+	spinlock_t tx_skb_lock; /* Protects tx skb handling */
+	void *spi_ctrl_tx_buf;
+	void *spi_ctrl_rx_buf;
+	void *spi_data_tx_buf;
+	void *spi_data_rx_buf;
+	struct sk_buff *ongoing_tx_skb;
+	struct sk_buff *waiting_tx_skb;
+	struct sk_buff *rx_skb;
+	u16 tx_skb_offset;
+	u16 spi_data_tx_buf_offset;
+	u16 tx_credits;
+	u8 rx_chunks_available;
+	bool rx_buf_overflow;
+	bool int_flag;
+	bool disable_traffic;
+};
+
+enum oa_tc6_header_type {
+	OA_TC6_CTRL_HEADER,
+	OA_TC6_DATA_HEADER,
+};
+
+enum oa_tc6_register_op {
+	OA_TC6_CTRL_REG_READ = 0,
+	OA_TC6_CTRL_REG_WRITE = 1,
+};
+
+enum oa_tc6_data_valid_info {
+	OA_TC6_DATA_INVALID,
+	OA_TC6_DATA_VALID,
+};
+
+enum oa_tc6_data_start_valid_info {
+	OA_TC6_DATA_START_INVALID,
+	OA_TC6_DATA_START_VALID,
+};
+
+enum oa_tc6_data_end_valid_info {
+	OA_TC6_DATA_END_INVALID,
+	OA_TC6_DATA_END_VALID,
+};
+#endif /* OA_TC6_STD_DEF_H */
+
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 15f58e3c56c7..39b80033dfa9 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -7,9 +7,23 @@
  * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
  */
 
+#ifndef _LINUX_OA_TC6_H
+#define _LINUX_OA_TC6_H
+
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 
+/* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in
+ * the OPEN Alliance specification.
+ */
+#define OA_TC6_PHY_C45_MAC_MMS1			1	/* No MMD */
+#define OA_TC6_PHY_C45_PCS_MMS2			2	/* MMD 3 */
+#define OA_TC6_PHY_C45_PMA_PMD_MMS3		3	/* MMD 1 */
+#define OA_TC6_PHY_C45_VS_PLCA_MMS4		4	/* MMD 31 */
+#define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
+#define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
+#define OA_TC6_PHY_C45_VS_MMS12			12	/* for vendors */
+
 struct oa_tc6;
 
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev);
@@ -22,3 +36,4 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
 int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
+#endif /* _LINUX_OA_TC6_H */

-- 
2.43.0



