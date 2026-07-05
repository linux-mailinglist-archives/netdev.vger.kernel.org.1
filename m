Return-Path: <netdev+bounces-304821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aDGGGu3hSmpjJAEAu9opvQ
	(envelope-from <netdev+bounces-304821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 00:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D770BB0C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 00:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=FLP4MAZ1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304821-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304821-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EABD53007C9F
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B251A37189C;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BC34404A;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783292390; cv=none; b=K8YPK3P65irbhU8pLf2+2HnvUQIHHCMUSLJzpj9a+y4aZD+qKDPmD2kDjMNqR1v9Sf8W4gX8IUn3Jz3a/eoPNcdEACLsOWwKa4UlcjZxL08JzaXFY7AjkSPSy3Z2gWUYsXtLMtP6573HDf3U0mUV3aIz5EZ3xeOrFaYmIyITS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783292390; c=relaxed/simple;
	bh=QN22gjPOHBHn4IknSjN6pLk2T63fhEPX273NYoyhUYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKQ6IKwGoJOU6fDzogAYQ0QYEgvxA71I18SbWm4IOr3sjN4jxVbVSevcmiZh9R6uqYUzHUYkFozHcBnjBAv9qC1EZpVUGE8aZcMLsSLVhRXQ6HL+LwT0+R8GDijpHk9nBWrNzsPlyqLV/nRlna5ER/0KwoSzl7naMOTxrKzUcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLP4MAZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36713C2BCC7;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783292390;
	bh=QN22gjPOHBHn4IknSjN6pLk2T63fhEPX273NYoyhUYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FLP4MAZ1dMni9h2YDaBXaTSnFnPqCnx43cVGI9F3eX6q+ltTkQ1JUKg3Ha0Rlb91Y
	 ydOuQouEluPgTK0elOfFqYzi8VK8vjbTI1nDdTahOHyDnD7o4RlBb0dRGgbrtaYCXD
	 5jT2ApHMPjRRPw7syYsQkY42HXMtpEtPQrqGRZn9sPXhWOLVkyLc/fWZgwm4ccKHLz
	 xhfPV1+ClNdiCra6E0pHsf1yuk+vH+upBnlwLULHS4SThDZ1RltqjPpWal1+OPObgF
	 p/bNB2DelHxBf/7qejngWSfoMnV+yR3VHRjbqdk1a9AL/KNbPV58MG2WEKjnej8OIW
	 Yv+faSQUsae1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16241C43602;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 05 Jul 2026 15:59:49 -0700
Subject: [PATCH net v3 1/3] net: ethernet: oa_tc6: Protect skb pointer used
 by two different kernel instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-fix-race-condition-and-crash-v3-1-3e51841e4d08@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783292390; l=5732;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=O7Oj18DBVkGTryp3cIezxo5TZ5Hc2efym53Tb/oEKg0=;
 b=ZN3jONVSnTRJxe9+c5ItmwClQbI+ruzcpwr+765cdycWkjsl+/nLnLu6kXBCNxLqmbcVM6hyz
 BDTuJzX0wQbDM1hXernRVh2Zwgo+zQSu2NFrGUwEmlixnswjp1sIlEb
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304821-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC9D770BB0C

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Threaded IRQ uses waiting_tx_skb. Transmit path also uses
this pointer without any mutual exclusion protection. As a
result, it might leak skb buffer, particularly threaded IRQ
runs in the middle of tranmsmit path, near skb_linearize.

Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, level triggered.")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v3
  - Added the missed out spin lock protection for
    waiting_tx_skb and disable_traffic flag
changes in v2
  - added the missing prefix to the title
---
 drivers/net/ethernet/oa_tc6.c | 100 +++++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 0727d53345a3..5b24cce4f9b5 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -652,6 +652,26 @@ static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, value);
 }
 
+/* Called when a frame that is meant to be transmitted, is dropped. */
+static void oa_tc6_drop_tx_skb(struct oa_tc6 *tc6, struct sk_buff *skb)
+{
+	if (skb) {
+		tc6->netdev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+	}
+}
+
+static struct sk_buff *oa_tc6_detach_waiting_tx_skb(struct oa_tc6 *tc6)
+{
+	struct sk_buff *skb;
+
+	lockdep_assert_held(&tc6->tx_skb_lock);
+	skb = tc6->waiting_tx_skb;
+	tc6->waiting_tx_skb = NULL;
+
+	return skb;
+}
+
 static void oa_tc6_cleanup_ongoing_rx_skb(struct oa_tc6 *tc6)
 {
 	if (tc6->rx_skb) {
@@ -663,26 +683,30 @@ static void oa_tc6_cleanup_ongoing_rx_skb(struct oa_tc6 *tc6)
 
 static void oa_tc6_cleanup_ongoing_tx_skb(struct oa_tc6 *tc6)
 {
-	if (tc6->ongoing_tx_skb) {
-		tc6->netdev->stats.tx_dropped++;
-		kfree_skb(tc6->ongoing_tx_skb);
-		tc6->ongoing_tx_skb = NULL;
-	}
+	oa_tc6_drop_tx_skb(tc6, tc6->ongoing_tx_skb);
+	tc6->ongoing_tx_skb = NULL;
 }
 
 static void oa_tc6_cleanup_waiting_tx_skb(struct oa_tc6 *tc6)
 {
-	if (tc6->waiting_tx_skb) {
-		tc6->netdev->stats.tx_dropped++;
-		kfree_skb(tc6->waiting_tx_skb);
-		tc6->waiting_tx_skb = NULL;
-	}
+	struct sk_buff *skb;
+
+	spin_lock_bh(&tc6->tx_skb_lock);
+	skb = oa_tc6_detach_waiting_tx_skb(tc6);
+	spin_unlock_bh(&tc6->tx_skb_lock);
+
+	oa_tc6_drop_tx_skb(tc6, skb);
 }
 
-static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
+static void oa_tc6_free_ongoing_skbs(struct oa_tc6 *tc6)
 {
 	oa_tc6_cleanup_ongoing_tx_skb(tc6);
 	oa_tc6_cleanup_ongoing_rx_skb(tc6);
+}
+
+static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
+{
+	oa_tc6_free_ongoing_skbs(tc6);
 	oa_tc6_cleanup_waiting_tx_skb(tc6);
 }
 
@@ -693,9 +717,15 @@ static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
 static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
 {
 	u32 regval = INT_MASK0_ALL_INTERRUPTS;
+	struct sk_buff *skb;
 
+	spin_lock_bh(&tc6->tx_skb_lock);
 	tc6->disable_traffic = true;
-	oa_tc6_free_pending_skbs(tc6);
+	skb = oa_tc6_detach_waiting_tx_skb(tc6);
+	spin_unlock_bh(&tc6->tx_skb_lock);
+
+	oa_tc6_drop_tx_skb(tc6, skb);
+	oa_tc6_free_ongoing_skbs(tc6);
 	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
 	oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
 	oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
@@ -1136,8 +1166,7 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
 			if (ret == -EAGAIN)
 				continue;
 
-			oa_tc6_cleanup_ongoing_tx_skb(tc6);
-			oa_tc6_cleanup_ongoing_rx_skb(tc6);
+			oa_tc6_free_ongoing_skbs(tc6);
 			netdev_err(tc6->netdev, "Device error: %d\n", ret);
 			return ret;
 		}
@@ -1159,15 +1188,20 @@ static irqreturn_t oa_tc6_macphy_threaded_irq(int irq, void *data)
 	 * no need to attempt spi transfer, once it fails. Pending skbs
 	 * are already freed.
 	 */
-	if (!tc6->disable_traffic) {
-		while (tc6->int_flag ||
-		       (tc6->waiting_tx_skb && tc6->tx_credits)) {
-			ret = oa_tc6_try_spi_transfer(tc6);
-			if (ret) {
-				disable_irq_nosync(tc6->spi->irq);
-				oa_tc6_disable_traffic(tc6);
-				break;
-			}
+	spin_lock_bh(&tc6->tx_skb_lock);
+	if (tc6->disable_traffic) {
+		spin_unlock_bh(&tc6->tx_skb_lock);
+		return IRQ_HANDLED;
+	}
+	spin_unlock_bh(&tc6->tx_skb_lock);
+
+	while (tc6->int_flag ||
+	       (tc6->waiting_tx_skb && tc6->tx_credits)) {
+		ret = oa_tc6_try_spi_transfer(tc6);
+		if (ret) {
+			disable_irq_nosync(tc6->spi->irq);
+			oa_tc6_disable_traffic(tc6);
+			break;
 		}
 	}
 
@@ -1250,18 +1284,22 @@ EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);
  */
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 {
-	if (tc6->disable_traffic || tc6->waiting_tx_skb) {
-		netif_stop_queue(tc6->netdev);
-		return NETDEV_TX_BUSY;
-	}
-
 	if (skb_linearize(skb)) {
-		dev_kfree_skb_any(skb);
-		tc6->netdev->stats.tx_dropped++;
+		oa_tc6_drop_tx_skb(tc6, skb);
 		return NETDEV_TX_OK;
 	}
 
 	spin_lock_bh(&tc6->tx_skb_lock);
+	if (tc6->waiting_tx_skb) {
+		netif_stop_queue(tc6->netdev);
+		spin_unlock_bh(&tc6->tx_skb_lock);
+		return NETDEV_TX_BUSY;
+	}
+	if (tc6->disable_traffic) {
+		spin_unlock_bh(&tc6->tx_skb_lock);
+		oa_tc6_drop_tx_skb(tc6, skb);
+		return NETDEV_TX_OK;
+	}
 	tc6->waiting_tx_skb = skb;
 	spin_unlock_bh(&tc6->tx_skb_lock);
 
@@ -1393,7 +1431,9 @@ EXPORT_SYMBOL_GPL(oa_tc6_init);
  */
 void oa_tc6_exit(struct oa_tc6 *tc6)
 {
+	spin_lock_bh(&tc6->tx_skb_lock);
 	tc6->disable_traffic = true;
+	spin_unlock_bh(&tc6->tx_skb_lock);
 	disable_irq(tc6->spi->irq);
 	oa_tc6_phy_exit(tc6);
 	oa_tc6_free_pending_skbs(tc6);

-- 
2.43.0



