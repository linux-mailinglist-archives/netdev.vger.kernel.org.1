Return-Path: <netdev+bounces-305606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ph3iAdh/TWrK1AEAu9opvQ
	(envelope-from <netdev+bounces-305606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:38:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F34E7720274
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:38:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=E6tgH5AB;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305606-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305606-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14ED23012C6E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 22:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9E3F411F;
	Tue,  7 Jul 2026 22:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250D3368B6;
	Tue,  7 Jul 2026 22:34:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463681; cv=none; b=Bu6uRAHh78HM+vidHzkTvNq5zxQP4GRAhaHF3OVKZ1tDCyL1x/g9AkYBn4osNgWIqNdHWRNKVop8nNQN9Uje8A5SD7cwv1HZAGqFne0XTc5YRuHhNo5j/tomv2LCUS/nICtWvglLApWVbl51bSPiFNRk+r3SEAMfX/wKQi6OALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463681; c=relaxed/simple;
	bh=xfYpIBxJe+DvZ7duMYivaR1HHOrIzRkMRoRl3Zj0Ydg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbaVgo7Axy3kZXZ6ZxqTi8JxC3/v83MWSswAJuLsWy2oVvH3A86sT2LdH+mbrNQq9xgSjujFlMlSOM4p2vyxlqX9v8KMOuOWP6RLz4wRlhRgUIAAkas7fqmqmlf5nh5zm3YYjBESob+YJ16bAVvuKxLe1LsW0xuTD5XDzu0q7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6tgH5AB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA8EEC2BCF4;
	Tue,  7 Jul 2026 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783463680;
	bh=xfYpIBxJe+DvZ7duMYivaR1HHOrIzRkMRoRl3Zj0Ydg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E6tgH5AB73Q7CA58GqKBnVX9UTW0wMwnYhn6LJY4+cNWz7yBliiQAmtMwxeZ6nKvU
	 3YcLmo7LTxWYU3DFPuZRLdByEp1qjHOaQ0c1mVf+LNyyIr7+SEkM6y5gGtWDAcQuLK
	 N3iw62lpjL/lH3GvjdiEhtIh7vx+0z4vACj6r9lxS6X5awIEjmf9oxEYSpQtQGcOBN
	 br1M0yMN1GUCtqq30HlP2g8INjPDhrxTo/K5CP+B53rYrwvSAk9koISrOIepu+mh97
	 hrrwMZ/d1VLNPiYzGz1KcgA5kpE7HYSRf0vB22udZkDDA/kbBVUJ27SNo8hPZfr1iB
	 yz19WO9MoV+2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A8C44503;
	Tue,  7 Jul 2026 22:34:40 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 08 Jul 2026 01:33:30 +0300
Subject: [PATCH net-next v5 02/13] net: ethernet: oa_tc6: Handle the OA TC6
 SPI protected mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-adin1140-driver-v5-2-4aca7b51a58b@analog.com>
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
In-Reply-To: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783463678; l=8803;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=SM0rmSB5zit7aaPvFAKTNfnnH6p7eTfSSvlehEnKdhc=;
 b=ZoG2gRlmpu8OU3R0Hqm67ZbN7WXJXnVElw2uZs7iPRe66q3P3pjF+UPekuEFnopeasjeAOzhb
 BF4eCYv177tB+BygLaRrj+ehPkiQ42K8Jzu6Q1qalUovjPfDXtNwVyv
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
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
	TAGGED_FROM(0.00)[bounces-305606-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:replyto,analog.com:mid,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F34E7720274

From: Ciprian Regus <ciprian.regus@analog.com>

Implement the OA TC6 standard defined protected mode for control (register
access) transactions. In addition to the current register access formats
the oa_tc6 driver handles, 1's complement values of the data field
are included (by both the host and the MACPHY) in the SPI transfer frames.
This feature acts as an integrity check.

Control write transactions look like this:

          |<- 32 bits ->|<--- data_size --->|<- 32 bits ->|
    MOSI: | ctrl header | reg write data    | ignored     |
    MISO: | (discard)   | echoed ctrl hdr   | echoed data |

    data_size (LEN = number of registers to read in a sequence):
      Unprotected: 32 x (LEN + 1) bits
      Protected:   2 x 32 x (LEN + 1) bits

Control read transaction:

          |<- 32 bits ->|<--- 32 bits --> |<- data_size ->|
    MOSI: | ctrl header | ignored ...                     |
    MISO: | (discard)   | echoed ctrl hdr | reg read data |

    data_size (LEN = number of registers to read in a sequence):
      Unprotected: 32 x (LEN + 1) bits
      Protected:   2 x 32 x (LEN + 1) bits

Register data format ("reg write data" and "reg read data"):

    Unprotected:
      | W1 (normal) | W2 (normal) | ... | Wx (normal) |

    Protected:
    | W1 (normal) | W1 (complement) | ... | Wx (normal) | Wx (complement)|

The protected mode state can be read from the bit 5 of CONFIG0 (0x4)
register, and this setting is usually only configured during the
MACPHY's reset (depending on the device it can be done by setting the
state of a pin). We can read the protected mode configuration before any
other register access and since the SPI transfer is initially sized for an
unprotected read, the MACPHY's complement words are never clocked out
and no checking is required. The data transactions (Ethernet frames)
remain unchanged.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v5 changelog:
 - no change
v4 changelog:
 - no change
v3 changelog:
 - no change
v2 changelog:
 - Updated OA_TC6_CTRL_SPI_BUF_SIZE to always alloc the control
   transaction buffer size required by the protected mode, instead of
   calling krealloc if the PROTE bit is set.
 - Formatting to fit the 80 character column limit.
---
 drivers/net/ethernet/oa_tc6.c | 93 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 0727d53345a3..8b9655883496 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -25,6 +25,7 @@
 #define OA_TC6_REG_CONFIG0			0x0004
 #define CONFIG0_SYNC				BIT(15)
 #define CONFIG0_ZARFE_ENABLE			BIT(12)
+#define CONFIG0_PROTE				BIT(5)
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
@@ -90,14 +91,17 @@
 #define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
 #define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
 
+#define OA_TC6_CTRL_PROT_REPLY_SIZE		4
 #define OA_TC6_CTRL_HEADER_SIZE			4
 #define OA_TC6_CTRL_REG_VALUE_SIZE		4
 #define OA_TC6_CTRL_IGNORED_SIZE		4
 #define OA_TC6_CTRL_MAX_REGISTERS		128
-#define OA_TC6_CTRL_SPI_BUF_SIZE		(OA_TC6_CTRL_HEADER_SIZE +\
-						(OA_TC6_CTRL_MAX_REGISTERS *\
-						OA_TC6_CTRL_REG_VALUE_SIZE) +\
-						OA_TC6_CTRL_IGNORED_SIZE)
+#define OA_TC6_CTRL_SPI_BUF_SIZE	(OA_TC6_CTRL_HEADER_SIZE +\
+					(OA_TC6_CTRL_MAX_REGISTERS *\
+					(OA_TC6_CTRL_REG_VALUE_SIZE +\
+					OA_TC6_CTRL_PROT_REPLY_SIZE)) +\
+					OA_TC6_CTRL_IGNORED_SIZE)
+
 #define OA_TC6_CHUNK_PAYLOAD_SIZE		64
 #define OA_TC6_DATA_HEADER_SIZE			4
 #define OA_TC6_CHUNK_SIZE			(OA_TC6_DATA_HEADER_SIZE +\
@@ -130,6 +134,7 @@ struct oa_tc6 {
 	bool rx_buf_overflow;
 	bool int_flag;
 	bool disable_traffic;
+	bool prot_ctrl;
 };
 
 enum oa_tc6_header_type {
@@ -213,25 +218,36 @@ static void oa_tc6_update_ctrl_write_data(struct oa_tc6 *tc6, u32 value[],
 {
 	__be32 *tx_buf = tc6->spi_ctrl_tx_buf + OA_TC6_CTRL_HEADER_SIZE;
 
-	for (int i = 0; i < length; i++)
+	for (int i = 0; i < length; i++) {
 		*tx_buf++ = cpu_to_be32(value[i]);
+		if (tc6->prot_ctrl)
+			*tx_buf++ = cpu_to_be32(~value[i]);
+	}
 }
 
-static u16 oa_tc6_calculate_ctrl_buf_size(u8 length)
+static u16 oa_tc6_calculate_ctrl_buf_size(u8 length, bool ctrl_prot)
 {
+	u32 reply_size = OA_TC6_CTRL_REG_VALUE_SIZE;
+
+	if (ctrl_prot)
+		reply_size += OA_TC6_CTRL_PROT_REPLY_SIZE;
+
 	/* Control command consists 4 bytes header + 4 bytes register value for
-	 * each register + 4 bytes ignored value.
+	 * each register (+ 4 bytes for the register value complement in case
+	 * protected mode is used) + 4 bytes ignored value.
 	 */
-	return OA_TC6_CTRL_HEADER_SIZE + OA_TC6_CTRL_REG_VALUE_SIZE * length +
+	return OA_TC6_CTRL_HEADER_SIZE + reply_size * length +
 	       OA_TC6_CTRL_IGNORED_SIZE;
 }
 
 static void oa_tc6_prepare_ctrl_spi_buf(struct oa_tc6 *tc6, u32 address,
 					u32 value[], u8 length,
-					enum oa_tc6_register_op reg_op)
+					enum oa_tc6_register_op reg_op,
+					u16 buf_size)
 {
 	__be32 *tx_buf = tc6->spi_ctrl_tx_buf;
 
+	memset(tx_buf, 0, buf_size);
 	*tx_buf = oa_tc6_prepare_ctrl_header(address, length, reg_op);
 
 	if (reg_op == OA_TC6_CTRL_REG_WRITE)
@@ -254,10 +270,12 @@ static int oa_tc6_check_ctrl_write_reply(struct oa_tc6 *tc6, u8 size)
 	return 0;
 }
 
-static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 size)
+static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 length)
 {
-	u32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE;
-	u32 *tx_buf = tc6->spi_ctrl_tx_buf;
+	__be32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE;
+	__be32 *tx_buf = tc6->spi_ctrl_tx_buf;
+	u32 complement;
+	u32 reply;
 
 	/* The echoed control read header must match with the one that was
 	 * transmitted.
@@ -265,6 +283,20 @@ static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 size)
 	if (*tx_buf != *rx_buf)
 		return -EPROTO;
 
+	if (tc6->prot_ctrl) {
+		/* Skip past the echoed header to the value/complement pairs */
+		rx_buf += 1;
+		for (int i = 0; i < length; i++) {
+			reply = be32_to_cpu(rx_buf[0]);
+			complement = be32_to_cpu(rx_buf[1]);
+
+			if (complement != ~reply)
+				return -EPROTO;
+
+			rx_buf += 2;
+		}
+	}
+
 	return 0;
 }
 
@@ -274,8 +306,13 @@ static void oa_tc6_copy_ctrl_read_data(struct oa_tc6 *tc6, u32 value[],
 	__be32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE +
 			 OA_TC6_CTRL_HEADER_SIZE;
 
-	for (int i = 0; i < length; i++)
+	for (int i = 0; i < length; i++) {
 		value[i] = be32_to_cpu(*rx_buf++);
+
+		/* skip complement word */
+		if (tc6->prot_ctrl)
+			rx_buf++;
+	}
 }
 
 static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
@@ -284,10 +321,10 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
 	u16 size;
 	int ret;
 
-	/* Prepare control command and copy to SPI control buffer */
-	oa_tc6_prepare_ctrl_spi_buf(tc6, address, value, length, reg_op);
+	size = oa_tc6_calculate_ctrl_buf_size(length, tc6->prot_ctrl);
 
-	size = oa_tc6_calculate_ctrl_buf_size(length);
+	/* Prepare control command and copy to SPI control buffer */
+	oa_tc6_prepare_ctrl_spi_buf(tc6, address, value, length, reg_op, size);
 
 	/* Perform SPI transfer */
 	ret = oa_tc6_spi_transfer(tc6, OA_TC6_CTRL_HEADER, size);
@@ -302,7 +339,7 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
 		return oa_tc6_check_ctrl_write_reply(tc6, size);
 
 	/* Check echoed/received control read command reply for errors */
-	ret = oa_tc6_check_ctrl_read_reply(tc6, size);
+	ret = oa_tc6_check_ctrl_read_reply(tc6, length);
 	if (ret)
 		return ret;
 
@@ -1272,6 +1309,20 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_start_xmit);
 
+static int oa_tc6_check_ctrl_protection(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &regval);
+	if (ret)
+		return ret;
+
+	tc6->prot_ctrl = FIELD_GET(CONFIG0_PROTE, regval);
+
+	return 0;
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -1324,6 +1375,14 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	if (!tc6->spi_data_rx_buf)
 		return NULL;
 
+	/* Check the PROTE bit status so that we can reset the device */
+	ret = oa_tc6_check_ctrl_protection(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev,
+			"Failed to check the protection mode: %d\n", ret);
+		return NULL;
+	}
+
 	ret = oa_tc6_sw_reset_macphy(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,

-- 
2.43.0



