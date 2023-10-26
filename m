Return-Path: <netdev+bounces-44476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC39D7D835A
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A587C281D9F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2C2DF8E;
	Thu, 26 Oct 2023 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0NYkpfc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009913AF8
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:14:49 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351C512A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:14:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9b9f56489fso719552276.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698326087; x=1698930887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hDsj/v6e5ygOSpybe1tBr7uxRuym2QZ91jwFI9rNDxA=;
        b=G0NYkpfcvM59e2hUF3mGJx4kzlRhYTFlShecT9EaOOAGyZH2jJyW0N3yJ3PM9NEQRZ
         QWB6UPP3RIpBWJ1Zof3QLoHY4r35/SBTL6p9olMaQ75ppOuDkfIy6YxK+LLQt8RuHKyP
         OQnEDH1X6QDYVon5+CssYfClqqO9l7rr1JAVhjbsyetPGhvDzCvfJysuGEZDGhJwnIpJ
         K5fb3tNrKcHd5vUiMB4A9r0OpnLvBkGc8D1V6DcNrf1E1hwAB/sqC4Vg8+k6wHnL2Zh3
         JLyxqbhW1pJXEFxKfjEu9YzKhfK2DPinKp24DuPGxi0L6jn5CkAWo9oFJzUzyXaY7HmV
         gpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698326087; x=1698930887;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDsj/v6e5ygOSpybe1tBr7uxRuym2QZ91jwFI9rNDxA=;
        b=EkQcA2I7EQqnj45e4lBAgm8d1TNlT3qtuLHYAut3KpL6hD+wnA5+EDGO6hsAy74ivs
         D79/NNYc3PeZG6ozq6z2wul/sugLGT1s59+4+P8yNFCYTV5NCUa4GS14bRSAV2IK91IZ
         Hm5/gxQ3PXwR32Q3FJ6NOzWLoCadfX0A4uI8RDIcSHVd90Gv4ccx9xFAL6KYupbH+8bL
         yEX8ad7Chvin9sqiMozeBs3YTRK7e2Fnv1DDABo2YBHR5LNEOSz2QYAntRh9NJz2MOWT
         iFPEG2sWUVFiWcGhQvFTc75mGU7U45uUmGc0iC8uf6g0j6oZTBQc2oZlDlSV34Ec30Nv
         D7WQ==
X-Gm-Message-State: AOJu0YwPk645BbJtSbYpGFJtuw2NFCITO3AvcjchldJmiXIWPZrgEhqm
	AcBNZ29NfexkzFC1qaod9sYHNWX6jJ76CQ==
X-Google-Smtp-Source: AGHT+IHCTyw3eGxAqKOJ2aq/UQ0CCw9/Xn7mI5P0zOhUYNqP63WMHyADdolsVm9LYIn0TV6JH/MtsaQlsAjbLw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d601:0:b0:d9b:e3f6:c8c6 with SMTP id
 n1-20020a25d601000000b00d9be3f6c8c6mr376478ybg.4.1698326087462; Thu, 26 Oct
 2023 06:14:47 -0700 (PDT)
Date: Thu, 26 Oct 2023 13:14:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231026131446.3933175-1-edumazet@google.com>
Subject: [PATCH net-next] ipvlan: properly track tx_errors
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

Both ipvlan_process_v4_outbound() and ipvlan_process_v6_outbound()
increment dev->stats.tx_errors in case of errors.

Unfortunately there are two issues :

1) ipvlan_get_stats64() does not propagate dev->stats.tx_errors to user.

2) Increments are not atomic. KCSAN would complain eventually.

Use DEV_STATS_INC() to not miss an update, and change ipvlan_get_stats64()
to copy the value back to user.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 8 ++++----
 drivers/net/ipvlan/ipvlan_main.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index c0c49f1813673acebdae2f3f52259fb6b9678c36..21e9cac7312186380fa60de11f0a9178080b74b0 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -441,12 +441,12 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
@@ -482,12 +482,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	err = ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 1b55928e89b8a10706cc8c7911d6055d17987be6..57c79f5f29916b66154da2c8ff10238ef2c02584 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -324,6 +324,7 @@ static void ipvlan_get_stats64(struct net_device *dev,
 		s->rx_dropped = rx_errs;
 		s->tx_dropped = tx_drps;
 	}
+	s->tx_errors = DEV_STATS_READ(dev, tx_errors);
 }
 
 static int ipvlan_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
-- 
2.42.0.758.gaed0368e0e-goog


