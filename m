Return-Path: <netdev+bounces-28567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BB77FDC8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 20:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73421C213D8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE717750;
	Thu, 17 Aug 2023 18:24:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713814AA6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:24:34 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A013ABA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:24:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d428d4956so1468917b3.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296635; x=1692901435;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9F0cwUIY6WN5ASTknqJ6ReTlQ1mUXvEFt2hrKxx3fLE=;
        b=Ahmj0AdzoCHKyxtsKNLZYfRkCPpJBDkHc0dmJ0kc29shxkYeRqwhR0GPX58wTS8m9+
         u4kf3ryWtpuHUDvfG5PGYi41Y5iUYBnF+wd/zTMuVZiIujVzZHx9PjcpkJflwxBdenT6
         tCbeE488WbEZ3EJTqDquvFLuLSywUMfP9Aexf9g5ejf6SXVE8oTw+adFnLARP62+r4bP
         rFfznMUd8CiKTiuW794gHcvW8HHL5tpgE+ChXa1CrDChfE+Gbhoem2CUHxqn6yvRSCvp
         J+TCfTyoG2qPW9KpC6cL3LSzbyZ1kRMsBpvQ3KHEZ6pkL/t3aWCxyuh3j0swVtNvfZBS
         8Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296635; x=1692901435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9F0cwUIY6WN5ASTknqJ6ReTlQ1mUXvEFt2hrKxx3fLE=;
        b=VzTlDrEgq4mQH/j5bC09J5DyDVYHKQTIsu34nropYT802+Wu3USxHLLyivZULl4VYC
         Agbvn5v+AApLBY53K1x7o1ie7RQSa/taiMJIylO5dgAo++vp3XkswErR/MUTFD8zdEbF
         rqNIq7cYHHdpPRKb5VRpAZFJZmiL/JuBhOVy2h5eycUrla6JjJbdJeop0yeZ42/BNVAR
         v4iZw99ZVxNnFfizZ3hnVDTgv8CxZQF3sDvx86JF9xCh6nYx9x07xiq8O1MTeFYHgpad
         EPcTKTmiuEsl3u4QzaLp4chQH4YSAfTCfQSKr8l1vO326eNeS9tDi9X5cr1RSTQvwvei
         PInA==
X-Gm-Message-State: AOJu0YxUfY1UIJ+LBrZHucsq5PU+oS8REP2EbiQ+bwcH43lbsgsI2A0F
	ywX6XAnoxZjjOVSR0lLKh+qwgEaG1r0+XA==
X-Google-Smtp-Source: AGHT+IE15i7yuNt03f6kC61yTuGztmoPZC0oFGsVXK+6kLRgCja6iJ6m5JLtyQARrKncwujhKPBSVj+i0RSrpw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:5c5:0:b0:c78:c530:6345 with SMTP id
 188-20020a2505c5000000b00c78c5306345mr3960ybf.7.1692296635251; Thu, 17 Aug
 2023 11:23:55 -0700 (PDT)
Date: Thu, 17 Aug 2023 18:23:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230817182353.2523746-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: refine skb->ooo_okay setting
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enabling BIG TCP on a low end platform apparently increased
chances of getting flows locked on one busy TX queue.

A similar problem was handled in commit 9b462d02d6dd
("tcp: TCP Small Queues and strange attractors"),
but the strategy worked for either bulk flows,
or 'large enough' RPC. BIG TCP changed how large
RPC needed to be to enable the work around:
If RPC fits in a single skb, TSQ never triggers.

Root cause for the problem is a busy TX queue,
with delayed TX completions.

This patch changes how we set skb->ooo_okay to detect
the case TX completion was not done, but incoming ACK
already was processed and emptied rtx queue.

Update the comment to explain the tricky details.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 769a558159ee10cc4977f0005dc309ab79d5a8b2..b6be73dbc560ba2919f417c3e81c493a315927ae 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1301,14 +1301,21 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	}
 	tcp_header_size = tcp_options_size + sizeof(struct tcphdr);
 
-	/* if no packet is in qdisc/device queue, then allow XPS to select
-	 * another queue. We can be called from tcp_tsq_handler()
-	 * which holds one reference to sk.
-	 *
-	 * TODO: Ideally, in-flight pure ACK packets should not matter here.
-	 * One way to get this would be to set skb->truesize = 2 on them.
+	/* We set skb->ooo_okay to one if this packet can select
+	 * a different TX queue than prior packets of this flow,
+	 * to avoid self inflicted reorders.
+	 * The 'other' queue decision is based on current cpu number
+	 * if XPS is enabled, or sk->sk_txhash otherwise.
+	 * We can switch to another (and better) queue if:
+	 * 1) No packet with payload is in qdisc/device queues.
+	 *    Delays in TX completion can defeat the test
+	 *    even if packets were already sent.
+	 * 2) Or rtx queue is empty.
+	 *    This mitigates above case if ACK packets for
+	 *    all prior packets were already processed.
 	 */
-	skb->ooo_okay = sk_wmem_alloc_get(sk) < SKB_TRUESIZE(1);
+	skb->ooo_okay = sk_wmem_alloc_get(sk) < SKB_TRUESIZE(1) ||
+			tcp_rtx_queue_empty(sk);
 
 	/* If we had to use memory reserve to allocate this skb,
 	 * this might cause drops if packet is looped back :
-- 
2.42.0.rc1.204.g551eb34607-goog


