Return-Path: <netdev+bounces-14613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E85742ABD
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B7E280E89
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19038291E;
	Thu, 29 Jun 2023 16:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095322572
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 16:41:55 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13476171E
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 09:41:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561eb6c66f6so7016167b3.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688056912; x=1690648912;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UG3PTb5MAF8cAGQF47HGQin+88efRORfN4c39hK/1YE=;
        b=VYX15G65lQIXuzdX41l7NofbTeXCaqOFq+6xy+WpwfksDgl/i3Vx6ZPsDrL7zhrYuk
         wtFPIjh/43CpK/NkKUu8m1lm4AMojbEvktTW0EK7EhHgl0olFh2N+skDhsjAWQYV1VUb
         xWcBDmf8qecuwRNfGnJ16eEP+lutsJktZNm0T1vWRmrUkvqKIZmaKC1qKsWdiDU3byw8
         qNpj/+sJqroRfvO4R1S/x2fqEu4OVNxoImh3DvkzCekFr8bEEYBnuLiWAhNmBo29M+Ve
         hMZ/LhG+7fgrRS2Tgj/gJVGVzvvP01rRHaXPbaD2EYfpQj7RW9aUtZg6c5aZabQYPjk6
         5aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056912; x=1690648912;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UG3PTb5MAF8cAGQF47HGQin+88efRORfN4c39hK/1YE=;
        b=HkSEw3MhdyHBAJZV9qo2bDjRRU2qkuyLH9carvkYvH5KKVVxmhD9jIY1BGeDV5HtZW
         Bs1q1mnjuiXgWNSPmytFKbfcrXCAAc61VvzWatZCf5pQraB0M18CH+DQYUBpgbiGa0Mu
         1RQFcaQRuB0mIXMtIyA2Th02wuxx7k0vs9uG4Lzn7EK3bus0zDenm+zyBvhU7XmebdVF
         HOGjWLCT9urgZmxhnknkC1CApeq4FwAFjtNR/3PdlqETKr7uU80ldNcdv7JGHRoyEl1Q
         bZeJhd0W8X4llwxa3dSXHLLl3s8rvENuD8s+3vqX3/LPLfpbk+fueBUn+navSSzsfBqh
         JtPA==
X-Gm-Message-State: AC+VfDyKgoiVpo2pFJnAAy9X5YZSSA2bkReBgTX/NRauqGLl8qovTnuO
	BkpRJheOkjehFniKjsfZRS0RjHImD1bL8Q==
X-Google-Smtp-Source: ACHHUZ7NV0KsL3dggY/tBxurjHkISlHrlcyEZmMxw4A1aSge1LpU39dQ9buz5dzMiMt/tlvoUdyDfrzbIPhZZw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b106:0:b0:56d:7a5:2887 with SMTP id
 p6-20020a81b106000000b0056d07a52887mr15444628ywh.2.1688056912299; Thu, 29 Jun
 2023 09:41:52 -0700 (PDT)
Date: Thu, 29 Jun 2023 16:41:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230629164150.2068747-1-edumazet@google.com>
Subject: [PATCH net] tcp: annotate data races in __tcp_oow_rate_limited()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

request sockets are lockless, __tcp_oow_rate_limited() could be called
on the same object from different cpus. This is harmless.

Add READ_ONCE()/WRITE_ONCE() annotations to avoid a KCSAN report.

Fixes: 4ce7e93cb3fe ("tcp: rate limit ACK sent by SYN_RECV request sockets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6f072095211efc9c3b3a561f67750ae454fd576b..57c8af1859c16eba5e952a23ea959b628006f9c1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3590,8 +3590,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 				   u32 *last_oow_ack_time)
 {
-	if (*last_oow_ack_time) {
-		s32 elapsed = (s32)(tcp_jiffies32 - *last_oow_ack_time);
+	/* Paired with the WRITE_ONCE() in this function. */
+	u32 val = READ_ONCE(*last_oow_ack_time);
+
+	if (val) {
+		s32 elapsed = (s32)(tcp_jiffies32 - val);
 
 		if (0 <= elapsed &&
 		    elapsed < READ_ONCE(net->ipv4.sysctl_tcp_invalid_ratelimit)) {
@@ -3600,7 +3603,10 @@ static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 		}
 	}
 
-	*last_oow_ack_time = tcp_jiffies32;
+	/* Paired with the prior READ_ONCE() and with itself,
+	 * as we might be lockless.
+	 */
+	WRITE_ONCE(*last_oow_ack_time, tcp_jiffies32);
 
 	return false;	/* not rate-limited: go ahead, send dupack now! */
 }
-- 
2.41.0.255.g8b1d071c50-goog


