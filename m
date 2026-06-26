Return-Path: <netdev+bounces-302218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KYSRE3CePmrMJAkAu9opvQ
	(envelope-from <netdev+bounces-302218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:44:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 424146CE9DB
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:44:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=DoO69u83;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302218-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302218-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EC2A304AEC0
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F17E3E023A;
	Fri, 26 Jun 2026 15:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22D370D41;
	Fri, 26 Jun 2026 15:35:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488142; cv=none; b=tSNyOBPWiHWEEhte8BJmrvIruHwTk+MOc6Ihl1PfGVAY3ZmC9nUoLMJQQGfbJj+GJyPp4RvNACE+8HQkDidZnwSrFgwr7Snt7Turf38UxyiiNTnzwni0NwcRu7GkT6pdwLHT8OYPxfPm8X5fDw6yuDj5EoC3mQXZkl/N+29To7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488142; c=relaxed/simple;
	bh=zRQ0UKHBOyhAvsRoQ7SvxLJa3k1UStC6RfoSTJnSVCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6ZbJjlUT7j7Xv98SjGKstgAhFP1zjamuwpiAMX0hHguhYbSBX8Y6pO2HCQOnOIfshdCAhVkCbGlXvlMXNEBdAq3QsGMYlxXreapQTFQ/pLL4B/R7RTIro1Ig5+dU/gur9d7Ja/x98q8R5jXuF3Qi7fhUk8OAqfOoUU5n5Opw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoO69u83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC2DEC2BCF4;
	Fri, 26 Jun 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782488142;
	bh=zRQ0UKHBOyhAvsRoQ7SvxLJa3k1UStC6RfoSTJnSVCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DoO69u83e2dVLCBxr6hccDx/ll97k5DJrArl+NkEUWJ++k051IGl0dym/QeTv4xLO
	 QMuZbPUFD+dsmzBtg3ZcAnxqa9UFBP6GVUF5Td8GeeiTqztenB/Yd6ymUlfuqwlwC1
	 lCP/3Jfwh4qnRoO03bo57raOJjdL4aqVc6IV3K8zUMSgE7ySNGDBTNg+YUxuuoT1m/
	 A7B00eWCkae55KsYFt+yc3Br7V2SM8Zl4mTZvK/Til2oxk6GnnHLPf5Vhe7FsXRTjl
	 Oh20DuuPZf+8FiJCLFVh1pId00qRCptglzu1Tp4QTm0UrVoCASscC5pc9umvMdOJqo
	 GgPoU4TJSSByQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C63C43458;
	Fri, 26 Jun 2026 15:35:41 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 26 Jun 2026 08:35:19 -0700
Subject: [PATCH net v2 2/2] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-fix-race-condition-and-crash-v2-2-b6c5c10e604f@onsemi.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
In-Reply-To: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782488122; l=6189;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=vzS9RJeOBdUQy3PCfwKdvl0EddpgK2jpfjFglDZ/fH0=;
 b=grrPHh/Fp0ZPlhRIWryDtaZsMAGzEhOeGzs7+WmBRbVtFGX6j1Xx6NhJeNRQ9zDG1sAvgSh/f
 E8qaV7txLhjB9m1jUK2jUjP8UKGq4aGka+k9dQFPH2cpd3+NFuVH86I
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302218-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,onsemi.com:replyto,onsemi.com:email,onsemi.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 424146CE9DB

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
changes in v2
  - Check rx_skb pointer before new allocation and NULL before use.
---
 drivers/net/ethernet/oa_tc6.c | 69 +++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 3fd4851ee66d..c59daa032e70 100644
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
@@ -811,13 +816,35 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
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
@@ -837,7 +864,9 @@ static int oa_tc6_prcs_complete_rx_frame(struct oa_tc6 *tc6, u8 *payload,
 	if (ret)
 		return ret;
 
-	oa_tc6_update_rx_skb(tc6, payload, size);
+	ret = oa_tc6_update_rx_skb(tc6, payload, size);
+	if (ret)
+		return ret;
 
 	oa_tc6_submit_rx_skb(tc6);
 
@@ -852,22 +881,24 @@ static int oa_tc6_prcs_rx_frame_start(struct oa_tc6 *tc6, u8 *payload, u16 size)
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
@@ -880,6 +911,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 	bool start_valid = FIELD_GET(OA_TC6_DATA_FOOTER_START_VALID, footer);
 	bool end_valid = FIELD_GET(OA_TC6_DATA_FOOTER_END_VALID, footer);
 	u16 size;
+	int ret;
 
 	/* Restart the new rx frame after receiving rx buffer overflow error */
 	if (start_valid && tc6->rx_buf_overflow)
@@ -907,8 +939,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
 	/* Process the chunk with only rx frame end */
 	if (end_valid && !start_valid) {
 		size = end_byte_offset + 1;
-		oa_tc6_prcs_rx_frame_end(tc6, data, size);
-		return 0;
+		return oa_tc6_prcs_rx_frame_end(tc6, data, size);
 	}
 
 	/* Process the chunk with previous rx frame end and next rx frame
@@ -921,7 +952,9 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
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
@@ -930,9 +963,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
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



