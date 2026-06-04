Return-Path: <netdev+bounces-295340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wSjDH7GqIWqgKwEAu9opvQ
	(envelope-from <netdev+bounces-295340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C0641F26
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=hXeXweZy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295340-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295340-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE77630089B0
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264923B9608;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40C3B6378;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590780; cv=none; b=HB5RWkNqRO8JjqGLU3PDun/lIP7f+am2N7uLZhwhZ8k353BtZq6DoPLLoURBNd2bkC0wwMe7hkWVloZxyjVytvOtm4BZYJaW9Om8ok6yCdrBzebMhnn1ykIg5pCJ2KkciJJyqYyUTN47bTKjsBqBVA7fZmbywzUK1y0zKjos3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590780; c=relaxed/simple;
	bh=P5Hsx7iN0ZJKNJxpu5gDXOiGz3XDeMfxO2eh0HfCy5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2iMVpq9p5DPyCRi0j0VRwn3NQPudCrUbp4zU0MPpUiRPq0NWWWuMS22IOhFgEmp8hFbtmpn7afC6oNMvOuojo7cpbl5ZnAyZoAMHlVNoQJSTd8tfeFzXRctuc6JE8IGTFaKxGDibCm1DMv+vCv2P2ACpxo7RIfeEiOtUFvKYhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXeXweZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACA83C2BCC9;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780590779;
	bh=P5Hsx7iN0ZJKNJxpu5gDXOiGz3XDeMfxO2eh0HfCy5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hXeXweZyhUc/Sm3U6dhe40X9LZEZDncDPgcDBqmNoHiPPT43AmtJXk0L5nuOSWvJT
	 KjOL55X3gPvq9lA2eOpL0DLZTJeOJ5jVeuOnDm1oXEtQKTdwVZcY2fEcfSZE79jyOy
	 ekAAQD8oAnXH1W0JAZJFLB+TrVPAiVOE3Q9lr5qiwmDGjBpKDvwwUFgOHRYpVmflla
	 mZyurr6dGV1ukzrUAmyLGliVjym3a2iTY8/lLwMAYgSPaNVYjsaKJhvUzzbHW3S+AN
	 joSYSwdsi852F1Wey3VOqsX6ChQRI8smwO8R/J7jkSPt38IxETEtMMIT/2Xo5w1NnO
	 b4hoktALLbv+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E3CD6E6D;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 19:32:47 +0300
Subject: [PATCH net-next v3 02/13] net: ethernet: oa_tc6: Handle the OA TC6
 SPI protected mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-adin1140-driver-v3-2-5debdb3173c4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780590774; l=8747;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=kCAt/vN4HNMmjc4uXW4s9mQuZMv1tQf5HRwsq0UZfgo=;
 b=c83fcA99zMMCgalnGg9yYetaSn8pW4BYSuOl5FhWKknWRD+nXwrwpw0/Cf+XOJJ+0AOW7QGKi
 a6PCnSdwRZ4AHqDdGzjOKRRbCoLJ/WLcMR148HtDGGsBbXUB45fVKGA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295340-lists,netdev=lfdr.de,ciprian.regus.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:mid,analog.com:email,analog.com:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 118C0641F26

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
index 91a906a7918a..baba5aad84df 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -24,6 +24,7 @@
 #define OA_TC6_REG_CONFIG0			0x0004
 #define CONFIG0_SYNC				BIT(15)
 #define CONFIG0_ZARFE_ENABLE			BIT(12)
+#define CONFIG0_PROTE				BIT(5)
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
@@ -87,14 +88,17 @@
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
@@ -129,6 +133,7 @@ struct oa_tc6 {
 	u8 rx_chunks_available;
 	bool rx_buf_overflow;
 	bool int_flag;
+	bool prot_ctrl;
 };
 
 enum oa_tc6_header_type {
@@ -212,25 +217,36 @@ static void oa_tc6_update_ctrl_write_data(struct oa_tc6 *tc6, u32 value[],
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
@@ -253,10 +269,12 @@ static int oa_tc6_check_ctrl_write_reply(struct oa_tc6 *tc6, u8 size)
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
@@ -264,6 +282,20 @@ static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 size)
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
 
@@ -273,8 +305,13 @@ static void oa_tc6_copy_ctrl_read_data(struct oa_tc6 *tc6, u32 value[],
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
@@ -283,10 +320,10 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
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
@@ -301,7 +338,7 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
 		return oa_tc6_check_ctrl_write_reply(tc6, size);
 
 	/* Check echoed/received control read command reply for errors */
-	ret = oa_tc6_check_ctrl_read_reply(tc6, size);
+	ret = oa_tc6_check_ctrl_read_reply(tc6, length);
 	if (ret)
 		return ret;
 
@@ -1224,6 +1261,20 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
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
@@ -1276,6 +1327,14 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
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



