Return-Path: <netdev+bounces-48261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB047EDD2C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242C0280F51
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47A214007;
	Thu, 16 Nov 2023 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0eE+k1/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FFBA1
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 00:57:09 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-41cdc2cc0b4so12327501cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 00:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700125029; x=1700729829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gh6Pqt15Uuq2Bjcq9HMGiXCbv9ksR71uUms8zAT74i8=;
        b=0eE+k1/bz6j9n7Crlf4XNm54r8Es1c9xpIqEnAof1YhNaSxiofGBxmpcJmMiei26T2
         JsuZzVw7mXFLLbiXznWhu1rfYYAbwrq9hArsLRBE21NrdQW4hnE6ZU/ANxG/uuYhQsS4
         HBWA0Ixq6qwDuCYSSPVADP1L4hNTm+vAeeYxvcRnmHNXdSw3Lo7jqOmscZjaTqzB9vxm
         YQnISruGe6uMOMEcB0+e3fDUiLEE8OhQcYdsDmWXLJAuy+5tY45GGAzJOi5g/U12+076
         CkrxXGnjIgDYPWgFptxzjknK4vpn7QkeG1H7PJ5sJCiyjO4e9gDVP/Ri8OEGsgblMJwc
         UbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125029; x=1700729829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gh6Pqt15Uuq2Bjcq9HMGiXCbv9ksR71uUms8zAT74i8=;
        b=Y6ew4rdLs3+kgZHkbpK4vrYcS/vs4EUAnYMhLoOe6xafzLkFqSVdhbgT+YuyhvGOUw
         iw7ZRGSdwvljwx7TbsTKnhW5G7c+mVQzBeGPZsFmLP+TbnCdUiv9eTx2Upj4VZ6qAeOI
         m5Yosi8xjRV/pTnexFiKOGHTF5N+68oXwI9hk7Ab7UgJMHxAV02p0lL7cuMosW3NMWgV
         NfRgkn2kURJ0OI9Aaq1OpvjLVLQM1i+J1T/3WOFebzniGriKvXiB7RoQ/P++zYovPkXJ
         nVBl8p15pf5ayvXr6brJ2FdRnWYlUulbdieSXkpYcouBnefehJboUjpvvC5/3APTfpt8
         bYiQ==
X-Gm-Message-State: AOJu0YyvsnJBgoyP50l/t94wxFXtgITG3q07sVkA5m9EnN2Oq1Xh7M9u
	X45OEv+div18uJ6YeZbOOyI4CUUKXZe+EQ==
X-Google-Smtp-Source: AGHT+IHWJWWDZayozSsMbefU7jKca3r+V1LrJVtEyI6SrSKNVY2gIGxMuyeTAPyhlxPH7vKXK2yRjXmYVBvtSA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:620f:0:b0:41b:1957:55b with SMTP id
 ks15-20020ac8620f000000b0041b1957055bmr23060qtb.4.1700125028990; Thu, 16 Nov
 2023 00:57:08 -0800 (PST)
Date: Thu, 16 Nov 2023 08:57:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116085707.2475816-1-edumazet@google.com>
Subject: [PATCH net] gve: add gve_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Bailey Forrest <bcf@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

It is suboptimal to attempt skb linearization from ndo_start_xmit()
if a gso skb has pathological layout, or if host stack does not have
access to the payload (TCP direct). Linearization of large skbs
can also fail under memory pressure.

We should instead have an ndo_features_check() so that we can
fallback to GSO, which is supported even for TCP direct,
and generally much more efficient (no payload copy).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Bailey Forrest <bcf@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jeroen de Borst <jeroendb@google.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: Shailend Chand <shailend@google.com>
Cc: Ziwei Xiao <ziweixiao@google.com>
---
 drivers/net/ethernet/google/gve/gve_dqo.h    |  3 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 13 +++++++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 37 ++++++++------------
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index 1eb4d5fd8561f1e32813e0973f96e43221d44e6b..c36b93f0de15b569eafbcb7222492013782fd441 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -33,6 +33,9 @@
 #define GVE_DEALLOCATE_COMPL_TIMEOUT 60
 
 netdev_tx_t gve_tx_dqo(struct sk_buff *skb, struct net_device *dev);
+netdev_features_t gve_features_check_dqo(struct sk_buff *skb,
+					 struct net_device *dev,
+					 netdev_features_t features);
 bool gve_tx_poll_dqo(struct gve_notify_block *block, bool do_clean);
 int gve_rx_poll_dqo(struct gve_notify_block *block, int budget);
 int gve_tx_alloc_rings_dqo(struct gve_priv *priv);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 276f996f95dcc8b6ab3c5eb51958b95c19e61dd2..0b01166642b38118888fd0d2a4e73e2577876e82 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -79,6 +79,18 @@ static int gve_verify_driver_compatibility(struct gve_priv *priv)
 	return err;
 }
 
+static netdev_features_t gve_features_check(struct sk_buff *skb,
+					    struct net_device *dev,
+					    netdev_features_t features)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+
+	if (!gve_is_gqi(priv))
+		return gve_features_check_dqo(skb, dev, features);
+
+	return features;
+}
+
 static netdev_tx_t gve_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct gve_priv *priv = netdev_priv(dev);
@@ -1873,6 +1885,7 @@ static int gve_set_features(struct net_device *netdev,
 
 static const struct net_device_ops gve_netdev_ops = {
 	.ndo_start_xmit		=	gve_start_xmit,
+	.ndo_features_check	=	gve_features_check,
 	.ndo_open		=	gve_open,
 	.ndo_stop		=	gve_close,
 	.ndo_get_stats64	=	gve_get_stats,
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 1e19b834a6130e8e32b236280ee17a21c17905fd..f59c4710f118822e30be39476f75b59595328ee0 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -843,6 +843,16 @@ static bool gve_can_send_tso(const struct sk_buff *skb)
 	return true;
 }
 
+netdev_features_t gve_features_check_dqo(struct sk_buff *skb,
+					 struct net_device *dev,
+					 netdev_features_t features)
+{
+	if (skb_is_gso(skb) && !gve_can_send_tso(skb))
+		return features & ~NETIF_F_GSO_MASK;
+
+	return features;
+}
+
 /* Attempt to transmit specified SKB.
  *
  * Returns 0 if the SKB was transmitted or dropped.
@@ -854,11 +864,10 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 	int num_buffer_descs;
 	int total_num_descs;
 
-	if (tx->dqo.qpl) {
-		if (skb_is_gso(skb))
-			if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-				goto drop;
+	if (skb_is_gso(skb) && unlikely(ipv6_hopopt_jumbo_remove(skb)))
+		goto drop;
 
+	if (tx->dqo.qpl) {
 		/* We do not need to verify the number of buffers used per
 		 * packet or per segment in case of TSO as with 2K size buffers
 		 * none of the TX packet rules would be violated.
@@ -868,24 +877,8 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 		 */
 		num_buffer_descs = DIV_ROUND_UP(skb->len, GVE_TX_BUF_SIZE_DQO);
 	} else {
-		if (skb_is_gso(skb)) {
-			/* If TSO doesn't meet HW requirements, attempt to linearize the
-			 * packet.
-			 */
-			if (unlikely(!gve_can_send_tso(skb) &&
-				     skb_linearize(skb) < 0)) {
-				net_err_ratelimited("%s: Failed to transmit TSO packet\n",
-						    priv->dev->name);
-				goto drop;
-			}
-
-			if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-				goto drop;
-
-			num_buffer_descs = gve_num_buffer_descs_needed(skb);
-		} else {
-			num_buffer_descs = gve_num_buffer_descs_needed(skb);
-
+		num_buffer_descs = gve_num_buffer_descs_needed(skb);
+		if (!skb_is_gso(skb)) {
 			if (unlikely(num_buffer_descs > GVE_TX_MAX_DATA_DESCS)) {
 				if (unlikely(skb_linearize(skb) < 0))
 					goto drop;
-- 
2.43.0.rc0.421.g78406f8d94-goog


