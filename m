Return-Path: <netdev+bounces-300955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Eq2DSy7OGochAcAu9opvQ
	(envelope-from <netdev+bounces-300955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41DE6AC89C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=FnY3r1oB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300955-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300955-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1B0301F4AF
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C673C3546DF;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E5351C28;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102810; cv=none; b=YUfjCgNtB/WRDMMu9e4rCihXyCs/j5V5jeUkwoqg+E8vpZDp/uxC6EFIvvfFAj9iFOidSMnqkArRhEeAju44TQl3U6M8a8FMjHLK3yZyDTgMN8jpQw10Tt52Na+yplHb+4+mApzSMoY+fvqPv+cFs+4W8nj0DqBCMDoGA8WJJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102810; c=relaxed/simple;
	bh=891QZA8gyQOpB7+/ZilqXTdXYcMfj9Sok29qQYq4XMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvNLvbemsVunGpzvzA/HV2z5hWL0rkxvdHwh4giHIxG55u+35m3VP1pJslZ57TLQBnY0sqOJDLXxEsbIP3bYWjvQSC7UV4nIpUaBVZ1l8vhT7Us0dVnIGvuRTUlAaAGCrkueTDr2oLeDM03wQSopBItmn0k1QQlCSp28qhwTraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnY3r1oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50210C2BCB4;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782102810;
	bh=891QZA8gyQOpB7+/ZilqXTdXYcMfj9Sok29qQYq4XMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FnY3r1oBQ9vqgfIAICAFMiTK6oYyWjx2eKMIxnwue1h4z7LhxH9Ek16Bn7oQlRU/J
	 lJO4+LQWFOM20Sqwno9Uzm5pkv2f/mwh89GbWHuwLzBwxu14rA/2KItBWdjAhxE3cy
	 tuFBzsmFjalnr13ElhjHO2SIO3KHco6KzXBOgBx9U42mng9wbT/eFcAgK7QqsFtBT8
	 BTLE2/rVYvj6EORxGSB1bQLEHaITCroeKzDWBemy0u2p7qM/JAXY3cf8xp2GZdb0Ew
	 GsLd5nNSzpcvlPUbZRmwDO6NOtA2xvDmYl5/IMLBbtAFhToxfAr1RwZfeg2re7gyma
	 2lKKlu92lPZkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39670CDB46B;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 21 Jun 2026 21:32:57 -0700
Subject: [PATCH 1/2] Protect skb pointer used by two different kernel
 instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-fix-race-condition-and-crash-v1-1-87e290d9357f@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782102789; l=1980;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=ffD4nh3kEl/gKHXlkWi/1r0F80sp5L3vlle7Lres/CA=;
 b=xudxxi4oayFzIzb2vU0KYH0tVcxEFu1V4B1dhzxJXtmnndbO81L0tItEn0nbn+k3yQEVqP5Bd
 MjAD2KVDdVKB90+IIq/Hm6t9EQYO/5/KYGaP2riPKQpVjBq7T7rzebb
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300955-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C41DE6AC89C

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Threaded IRQ uses waiting_tx_skb. Transmit path also uses
this pointer without any mutual exclusion protection. As a
result, it might leak skb buffer, particularly threaded IRQ
runs in the middle of tranmsmit path, near skb_linearize.

Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, level triggered.")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 0727d53345a3..3fd4851ee66d 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -672,10 +672,16 @@ static void oa_tc6_cleanup_ongoing_tx_skb(struct oa_tc6 *tc6)
 
 static void oa_tc6_cleanup_waiting_tx_skb(struct oa_tc6 *tc6)
 {
-	if (tc6->waiting_tx_skb) {
+	struct sk_buff *skb;
+
+	spin_lock_bh(&tc6->tx_skb_lock);
+	skb = tc6->waiting_tx_skb;
+	tc6->waiting_tx_skb = NULL;
+	spin_unlock_bh(&tc6->tx_skb_lock);
+
+	if (skb) {
 		tc6->netdev->stats.tx_dropped++;
-		kfree_skb(tc6->waiting_tx_skb);
-		tc6->waiting_tx_skb = NULL;
+		kfree_skb(skb);
 	}
 }
 
@@ -1250,11 +1256,6 @@ EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);
  */
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 {
-	if (tc6->disable_traffic || tc6->waiting_tx_skb) {
-		netif_stop_queue(tc6->netdev);
-		return NETDEV_TX_BUSY;
-	}
-
 	if (skb_linearize(skb)) {
 		dev_kfree_skb_any(skb);
 		tc6->netdev->stats.tx_dropped++;
@@ -1262,6 +1263,11 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
 	}
 
 	spin_lock_bh(&tc6->tx_skb_lock);
+	if (tc6->disable_traffic || tc6->waiting_tx_skb) {
+		netif_stop_queue(tc6->netdev);
+		spin_unlock_bh(&tc6->tx_skb_lock);
+		return NETDEV_TX_BUSY;
+	}
 	tc6->waiting_tx_skb = skb;
 	spin_unlock_bh(&tc6->tx_skb_lock);
 

-- 
2.43.0



