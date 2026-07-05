Return-Path: <netdev+bounces-304819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qHaeH+zhSmphJAEAu9opvQ
	(envelope-from <netdev+bounces-304819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 00:59:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC270BB09
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 00:59:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=jMSNqOGz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304819-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304819-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B99ED3004415
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE5370AF8;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC645039;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783292390; cv=none; b=lA+ENwEWuQ5FQOnZaBdIaB2W2867oUrIPtbD4H6U2RZOvMAuHwOkm/RdqN9Qv2Prw3yTpKZYdCdbC25R6ajnZs9HWw4WYumdSwxRD2cjgDG79UM6Vg+uv1JAjcz24U0XliDGkTAy7whzs+v9DaYuvFdd+Zpzk2u4gbdlu5uOK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783292390; c=relaxed/simple;
	bh=SPY8lfYvn1cq/xg/OCOdSP/Vix7hwO8e+YiD7BY5OW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/My/xWav2DdTg/CK4OyFugUkTyw+GP7dpROlV0bv06UxZRDIaKAV7zx2ziVemvibE+0rPllKsv5//j6j+g6Rqkh4loyc2RwJuXLtPiOXATNBx88sEIa7jcERbT66r5Eq/W8QzHgu6zjw2xY2VouQVdeo0oh1KtQPLqNs8chkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMSNqOGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42CBCC2BCC6;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783292390;
	bh=SPY8lfYvn1cq/xg/OCOdSP/Vix7hwO8e+YiD7BY5OW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jMSNqOGzoLivu2qjUK07ynQ5ROYXB7HUt3KEVU7sSaP431wWbvj+yeVsoAS28K+Dx
	 9qzDD2OvA4CZAglcyUCAJFSMamcFcnv16vwl1SdFiwIdgptXoJVFiw5II2h8CGk5Mh
	 NvR7/4fOdLLQuOLdMrBEQDYLb6cg2Ho8z3sb54FNXrwnOXIiD/tb0SJ3GZGwBUEg4B
	 dN8lpWE7w3TONt+bL25WZnJWAz9hek8qSFBEXr9T/mHBeF7iz29A/DlbLBmXzBM9PK
	 crOdCuQ7YoN6rWLFXxtQhwSveJGWg8uYQO8+v4OLsAkFyEYn/9zFXUa+hwjhNzVSyR
	 nbO5BJt31Lhdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27854C44500;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 05 Jul 2026 15:59:50 -0700
Subject: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-fix-race-condition-and-crash-v3-2-3e51841e4d08@onsemi.com>
References: <20260705-fix-race-condition-and-crash-v3-0-3e51841e4d08@onsemi.com>
In-Reply-To: <20260705-fix-race-condition-and-crash-v3-0-3e51841e4d08@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783292390; l=8584;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=IAqmURuM4v3QI/xLA6jBtFq0E76quE55YnhuEKsS5oU=;
 b=2GR2kqA4jo7pBIe8pLmmzfc9GYMQCETXf8ovwhV0qrCxEAJJpC8K2n01dsAH2CqAdCBmilPkz
 7Ja7lsjvTDTCfLzLA0Y9LXLVNlLZihQK6TmQQNhVLgw4z4l7oOaljlm
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304819-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:pier.beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:Parthiban.Veerasooran@microchip.com,m:Selvamani.Rajagopal@onsemi.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FC270BB09

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
changes in v3
  - Continue processing more chunks on error code -EAGAIN. Previously
    we were bailing out.
changes in v2
  - Check rx_skb pointer before new allocation and NULL before use.
---
 drivers/net/ethernet/oa_tc6.c | 113 ++++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 5b24cce4f9b5..a6b8762f6052 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -710,6 +710,12 @@ static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
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
@@ -753,8 +759,7 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
 	}
 
 	if (FIELD_GET(STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
-		tc6->rx_buf_overflow = true;
-		oa_tc6_cleanup_ongoing_rx_skb(tc6);
+		oa_tc6_look_for_new_frame(tc6);
 		net_err_ratelimited("%s: Receive buffer overflow error\n",
 				    tc6->netdev->name);
 		return -EAGAIN;
@@ -780,6 +785,8 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
 
 static int oa_tc6_process_rx_chunk_footer(struct oa_tc6 *tc6, u32 footer)
 {
+	int ret = 0;
+
 	/* Process rx chunk footer for the following,
 	 * 1. tx credits
 	 * 2. errors if any from MAC-PHY
@@ -790,9 +797,11 @@ static int oa_tc6_process_rx_chunk_footer(struct oa_tc6 *tc6, u32 footer)
 					     footer);
 
 	if (FIELD_GET(OA_TC6_DATA_FOOTER_EXTENDED_STS, footer)) {
-		int ret = oa_tc6_process_extended_status(tc6);
-
-		if (ret)
+		ret = oa_tc6_process_extended_status(tc6);
+		/* EAGAIN error is recoverable. Move on to check
+		 * HEADER and SYNC errors before returning.
+		 */
+		if (ret && ret != -EAGAIN)
 			return ret;
 	}
 
@@ -810,7 +819,7 @@ static int oa_tc6_process_rx_chunk_footer(struct oa_tc6 *tc6, u32 footer)
 		return -ENODEV;
 	}
 
-	return 0;
+	return ret;
 }
 
 static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
@@ -835,13 +844,35 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 	tc6->rx_skb = NULL;
 }
 
-static void oa_tc6_update_rx_skb(struct oa_tc6 *tc6, u8 *payload, u8 length)
+/* On oversubscribed traffic condition, particularly with overwhelming rx
+ * buffer overflow errors, there could be data chunk loss. If tail + length
+ * goes beyond end pointer, that is an indication that the data chunk with
+ * end_valid bit is lost. Time to look for a data chunk with start_valid bit.
+ *
+ * If rx_skb is NULL, it is time to start looking for data chunk with
+ * start_bit.
+ */
+static int oa_tc6_update_rx_skb(struct oa_tc6 *tc6, u8 *payload, u8 length)
 {
+	if (!tc6->rx_skb ||
+	    (tc6->rx_skb->tail + length) > tc6->rx_skb->end) {
+		oa_tc6_look_for_new_frame(tc6);
+		return -EAGAIN;
+	}
+
 	memcpy(skb_put(tc6->rx_skb, length), payload, length);
+	return 0;
 }
 
+/* On overwhelming rx buffer overflow errors, due to data chunk loss, it is
+ * possible that we get two data chunks with start_valid bit set, without
+ * end_valid bit set in between. In this case, rx_skb would have a valid
+ * buffer pointer. We should release, if a valid pointer is found before
+ * allocating a new one.
+ */
 static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
 {
+	oa_tc6_cleanup_ongoing_rx_skb(tc6);
 	tc6->rx_skb = netdev_alloc_skb_ip_align(tc6->netdev, tc6->netdev->mtu +
 						ETH_HLEN + ETH_FCS_LEN);
 	if (!tc6->rx_skb) {
@@ -861,7 +892,9 @@ static int oa_tc6_prcs_complete_rx_frame(struct oa_tc6 *tc6, u8 *payload,
 	if (ret)
 		return ret;
 
-	oa_tc6_update_rx_skb(tc6, payload, size);
+	ret = oa_tc6_update_rx_skb(tc6, payload, size);
+	if (ret)
+		return ret;
 
 	oa_tc6_submit_rx_skb(tc6);
 
@@ -876,22 +909,24 @@ static int oa_tc6_prcs_rx_frame_start(struct oa_tc6 *tc6, u8 *payload, u16 size)
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
@@ -931,8 +966,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 	/* Process the chunk with only rx frame end */
 	if (end_valid && !start_valid) {
 		size = end_byte_offset + 1;
-		oa_tc6_prcs_rx_frame_end(tc6, data, size);
-		return 0;
+		return oa_tc6_prcs_rx_frame_end(tc6, data, size);
 	}
 
 	/* Process the chunk with previous rx frame end and next rx frame
@@ -954,9 +988,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 	}
 
 	/* Process the chunk with ongoing rx frame data */
-	oa_tc6_prcs_ongoing_rx_frame(tc6, data, footer);
-
-	return 0;
+	return oa_tc6_prcs_ongoing_rx_frame(tc6, data, footer);
 }
 
 static u32 oa_tc6_get_rx_chunk_footer(struct oa_tc6 *tc6, u16 footer_offset)
@@ -972,8 +1004,9 @@ static u32 oa_tc6_get_rx_chunk_footer(struct oa_tc6 *tc6, u16 footer_offset)
 static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
 {
 	u16 no_of_rx_chunks = length / OA_TC6_CHUNK_SIZE;
+	bool retry = false;
+	int ret = 0;
 	u32 footer;
-	int ret;
 
 	/* All the rx chunks in the receive SPI data buffer are examined here */
 	for (int i = 0; i < no_of_rx_chunks; i++) {
@@ -982,8 +1015,11 @@ static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
 						    OA_TC6_CHUNK_PAYLOAD_SIZE);
 
 		ret = oa_tc6_process_rx_chunk_footer(tc6, footer);
-		if (ret)
-			return ret;
+		if (ret) {
+			if (ret != -EAGAIN)
+				return ret;
+			retry = true;
+		}
 
 		/* If there is a data valid chunks then process it for the
 		 * information needed to determine the validity and the location
@@ -995,12 +1031,25 @@ static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
 
 			ret = oa_tc6_prcs_rx_chunk_payload(tc6, payload,
 							   footer);
-			if (ret)
-				return ret;
+			if (ret) {
+				if (ret != -ENOMEM && ret != -EAGAIN)
+					return ret;
+				retry = true;
+			}
 		}
 	}
 
-	return 0;
+	/* As a recoverable error, not bailing out on error code
+	 * -EAGAIN. If subsequent loop iterations, if any, succeeds,
+	 * error code would be overwritten. retry flag helps to
+	 * make the caller to continue and retry.
+	 */
+	if (retry) {
+		ret = -EAGAIN;
+		oa_tc6_look_for_new_frame(tc6);
+	}
+
+	return ret;
 }
 
 static __be32 oa_tc6_prepare_data_header(bool data_valid, bool start_valid,
@@ -1162,10 +1211,12 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
 		}
 
 		ret = oa_tc6_process_spi_data_rx_buf(tc6, spi_len);
-		if (ret) {
-			if (ret == -EAGAIN)
-				continue;
 
+		/* Not continuing with the next iteration to give
+		 * waiting_tx_skb a chance to get drained, if
+		 * needed.
+		 */
+		if (ret && ret != -EAGAIN) {
 			oa_tc6_free_ongoing_skbs(tc6);
 			netdev_err(tc6->netdev, "Device error: %d\n", ret);
 			return ret;

-- 
2.43.0



