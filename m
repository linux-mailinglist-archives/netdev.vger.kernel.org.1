Return-Path: <netdev+bounces-300954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MPNZACu7OGobhAcAu9opvQ
	(envelope-from <netdev+bounces-300954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:33:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DECA6AC897
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:33:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Jpv4CXoC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300954-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300954-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4638D301CFB8
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13033546DE;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05A3502A5;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102810; cv=none; b=kJ3TXQL/iBqSu/R1SLs2CUtqNk2Njd+KdsO2CnxquEV5PzlAUqqLZ18gwQiegv/hOsxph/itgw63jvCRwJPLTzTdjyVt7cfgJblxH4Y41z+fA3WoH56tu2gpORGEOZlwLWFNqoeB2nR88waHQgMM4C0EuK0xtmj0wj0PA3e7vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102810; c=relaxed/simple;
	bh=30Wap1qtWpTSDzP8lwQwhbPVYLHLfH2qS1Zoao35KE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxPTxfSJ50xBIub3LzONjVGnjrzZ2j+iMvB1X7DWop7EjFaiaZmcgomdZSmSkOd9wN3cXTNMhnXQsym9s+qZm7SijS6rChYhxBeegPWOZkK1QWuRrtMZqQeEI2XaiYSUi1bdZdgWoxN1SXUHKBgigATpePdQedxVKpeqRHK/B4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpv4CXoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FF73C2BCF4;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782102810;
	bh=30Wap1qtWpTSDzP8lwQwhbPVYLHLfH2qS1Zoao35KE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jpv4CXoCu1A08dT/9WLpa6iUIzi9fzZw0fBMHmuYyPrtG/UBjA5kMjyWt3Lo0nGJA
	 lKHe5Y3wUjGiB8uOgDBS4ptsrWkGyWyMnKdUXSXaufSRWrXZ5x4y53q/WXrH5vTwxT
	 lEBnaKkax46tJSH5uEfA37p2wGlz6821Pi0wjKgPIBVCVRZ2xWL5Zx0xRYnYkdrhiF
	 4wOQ1qXeme+UGiWsT66enI2zCiy37c7xZvyw4e3/DWNxO92ae45bRY05+kqdOYVhx4
	 IZDKTcTFvUFe3EtYegWr36sp2lMlk2kXUuiIXUIXri5J0/Kt0dq+5K2AZPAbzbp3O8
	 PHE46q97XGawg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4F3CD98F6;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 21 Jun 2026 21:32:58 -0700
Subject: [PATCH 2/2] net: ethernet: oa_tc6: Improvement in buffer overflow
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-fix-race-condition-and-crash-v1-2-87e290d9357f@onsemi.com>
References: <20260621-fix-race-condition-and-crash-v1-0-87e290d9357f@onsemi.com>
In-Reply-To: <20260621-fix-race-condition-and-crash-v1-0-87e290d9357f@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782102789; l=5153;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=ViPT+mSppcbE2/EcIj0vC+AsRcPkLEt7HCQg7nQhrpQ=;
 b=dsizjGgi91OtRCtKg0/eL1AAp5lDoQ7UiyEGqnECvncwIY8hc2PvZthz3f990/Bzm5iZ6pN0T
 BwGNLLkN2MlB0C2kvc3z7GjY+uS2Xin+06EL1HmKTxl9Du2fcMrONY3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300954-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:pier.beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:Parthiban.Veerasooran@microchip.com,m:Selvamani.Rajagopal@onsemi.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DECA6AC897

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

When oversubscribed traffic causes lot of buffer overflow errors,
probably due to loss of data chunks, driver fails to find a
data chunk with end_valid bit set, before it runs out of sk buffer
space. As a result, assert is seen during skb_put.

Now check is made if tail + len > end, driver abandons the current
data and starts look for a data chunk with start_valid bit,
that is a new frame.

Fixes: d70a0d8f2f2d ("net: ethernet: oa_tc6: implement receive path to receive rx ethernet frames")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 53 +++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 3fd4851ee66d..180fc47c30b3 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -692,6 +692,12 @@ static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
 	oa_tc6_cleanup_waiting_tx_skb(tc6);
 }
 
+static void oa_tc6_look_for_new_frame(struct oa_tc6 *tc6)
+{
+	tc6->rx_buf_overflow = true;
+	oa_tc6_cleanup_ongoing_rx_skb(tc6);
+}
+
 /* If the failure is at SPI interface level, masking and clearing
  * the interrupt of the device won't work. Since SPI interrupt is
  * disabled, it should stop the repeated interrupts.
@@ -729,8 +735,7 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
 	}
 
 	if (FIELD_GET(STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
-		tc6->rx_buf_overflow = true;
-		oa_tc6_cleanup_ongoing_rx_skb(tc6);
+		oa_tc6_look_for_new_frame(tc6);
 		net_err_ratelimited("%s: Receive buffer overflow error\n",
 				    tc6->netdev->name);
 		return -EAGAIN;
@@ -811,9 +816,15 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 	tc6->rx_skb = NULL;
 }
 
-static void oa_tc6_update_rx_skb(struct oa_tc6 *tc6, u8 *payload, u8 length)
+static int oa_tc6_update_rx_skb(struct oa_tc6 *tc6, u8 *payload, u8 length)
 {
+	if ((tc6->rx_skb->tail + length) > tc6->rx_skb->end) {
+		oa_tc6_look_for_new_frame(tc6);
+		return -EAGAIN;
+	}
+
 	memcpy(skb_put(tc6->rx_skb, length), payload, length);
+	return 0;
 }
 
 static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
@@ -837,7 +848,9 @@ static int oa_tc6_prcs_complete_rx_frame(struct oa_tc6 *tc6, u8 *payload,
 	if (ret)
 		return ret;
 
-	oa_tc6_update_rx_skb(tc6, payload, size);
+	ret = oa_tc6_update_rx_skb(tc6, payload, size);
+	if (ret)
+		return ret;
 
 	oa_tc6_submit_rx_skb(tc6);
 
@@ -852,22 +865,24 @@ static int oa_tc6_prcs_rx_frame_start(struct oa_tc6 *tc6, u8 *payload, u16 size)
 	if (ret)
 		return ret;
 
-	oa_tc6_update_rx_skb(tc6, payload, size);
-
-	return 0;
+	return oa_tc6_update_rx_skb(tc6, payload, size);
 }
 
-static void oa_tc6_prcs_rx_frame_end(struct oa_tc6 *tc6, u8 *payload, u16 size)
+static int oa_tc6_prcs_rx_frame_end(struct oa_tc6 *tc6, u8 *payload, u16 size)
 {
-	oa_tc6_update_rx_skb(tc6, payload, size);
+	int ret;
 
-	oa_tc6_submit_rx_skb(tc6);
+	ret = oa_tc6_update_rx_skb(tc6, payload, size);
+	if (!ret)
+		oa_tc6_submit_rx_skb(tc6);
+	return ret;
 }
 
-static void oa_tc6_prcs_ongoing_rx_frame(struct oa_tc6 *tc6, u8 *payload,
-					 u32 footer)
+static int oa_tc6_prcs_ongoing_rx_frame(struct oa_tc6 *tc6, u8 *payload,
+					u32 footer)
 {
-	oa_tc6_update_rx_skb(tc6, payload, OA_TC6_CHUNK_PAYLOAD_SIZE);
+	return oa_tc6_update_rx_skb(tc6, payload,
+				    OA_TC6_CHUNK_PAYLOAD_SIZE);
 }
 
 static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
@@ -880,6 +895,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 	bool start_valid = FIELD_GET(OA_TC6_DATA_FOOTER_START_VALID, footer);
 	bool end_valid = FIELD_GET(OA_TC6_DATA_FOOTER_END_VALID, footer);
 	u16 size;
+	int ret;
 
 	/* Restart the new rx frame after receiving rx buffer overflow error */
 	if (start_valid && tc6->rx_buf_overflow)
@@ -907,8 +923,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 	/* Process the chunk with only rx frame end */
 	if (end_valid && !start_valid) {
 		size = end_byte_offset + 1;
-		oa_tc6_prcs_rx_frame_end(tc6, data, size);
-		return 0;
+		return oa_tc6_prcs_rx_frame_end(tc6, data, size);
 	}
 
 	/* Process the chunk with previous rx frame end and next rx frame
@@ -921,7 +936,9 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 		 */
 		if (tc6->rx_skb) {
 			size = end_byte_offset + 1;
-			oa_tc6_prcs_rx_frame_end(tc6, data, size);
+			ret = oa_tc6_prcs_rx_frame_end(tc6, data, size);
+			if (ret)
+				return ret;
 		}
 		size = OA_TC6_CHUNK_PAYLOAD_SIZE - start_byte_offset;
 		return oa_tc6_prcs_rx_frame_start(tc6,
@@ -930,9 +947,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 	}
 
 	/* Process the chunk with ongoing rx frame data */
-	oa_tc6_prcs_ongoing_rx_frame(tc6, data, footer);
-
-	return 0;
+	return oa_tc6_prcs_ongoing_rx_frame(tc6, data, footer);
 }
 
 static u32 oa_tc6_get_rx_chunk_footer(struct oa_tc6 *tc6, u16 footer_offset)

-- 
2.43.0



