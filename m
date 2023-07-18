Return-Path: <netdev+bounces-18643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775467581F5
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEED281159
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D188134D8;
	Tue, 18 Jul 2023 16:20:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15B11185
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 16:20:53 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28D41712
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:20:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5f4d445190so5409284276.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689697251; x=1692289251;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ak1lkXsc1F60oi/sWxGhJDAF+q+gzB8Rctm18SkkIJ4=;
        b=WNw/+ZgC49xtBxxQnXuuB49avfNokvjweAdyqqtds/dfEBA1RN8iOBkJWQf4IgxFa1
         Gkh+Yqk7+yMB4Sj/t6TLytPbBGPPWD6tNU/pt4iOjvVIP3Cd640UNbvCsyRNlycrKJx5
         MF0pBPQnAs05DuVwpOhwruggKKiupd82zbSac4lKbQkbAl5yhjqXzEAWaF1+STGWTDMJ
         95CmHpN6SMXCYJUyUACoEyPRjpgEZAPuLeTuM7YSX1izOgNpoEwxuhic5l4r5ichn8oK
         RBO9eqsErDV60KCY1ZFUE7UHOutoG1ahzhUwMciIlbpMfWZGP/m6OAdrQ9w3oir4c8s2
         /veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689697251; x=1692289251;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ak1lkXsc1F60oi/sWxGhJDAF+q+gzB8Rctm18SkkIJ4=;
        b=MwnPw2hNQ9toSSbHC6Mrz3+Nn6uHvO6ykM2ShjWNkx4tD+8+b+dQh5M6ieTXj1gM3d
         64ux9QndhMpYz59MWPhqxpC6d3JXiPEyMII0+P+pA7jy0++JsVJjmp0XwRIMXy0yHsJm
         LSq1vccOcx5gbSIBrgfbzyAjIQ+ln6apYm+lTeXWWF2/qJ3vJ3yVxjNQYuPvUFJJgWbg
         iyEMQMa/YvsrJFPzmo5puxOQX9fetMr2OgFbQJUtofai1oAY9WR3YHvW3Kb4gFzq9QfF
         fQKyiUFRldwXQu/w9eymO0ZlHHqx+2qLApESI2WpQQ/JkZyXXaayDGl/OaQLIkT1gwMq
         YE4w==
X-Gm-Message-State: ABy/qLZ8I56/FVmw/apYcFsiuSSg35ejJ/WHkxnZ9v7gLVB46gF60syT
	xIugoPiltXzSWSjmymGDcV2fSXt4ES79fg==
X-Google-Smtp-Source: APBJJlGnpb4xTkvTDK3fY4k1PMxtMyPyzhnILv0fTEWrIeMWmK9i6EY+DT4xGwCJ59QHlabUsB+hM6VO4QLvlg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2fcf:0:b0:cb6:5a0b:c86d with SMTP id
 v198-20020a252fcf000000b00cb65a0bc86dmr1915ybv.12.1689697251080; Tue, 18 Jul
 2023 09:20:51 -0700 (PDT)
Date: Tue, 18 Jul 2023 16:20:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718162049.1444938-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: tcp_enter_quickack_mode() should be static
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After commit d2ccd7bc8acd ("tcp: avoid resetting ACK timer in DCTCP"),
tcp_enter_quickack_mode() is only used from net/ipv4/tcp_input.c.

Fixes: d2ccd7bc8acd ("tcp: avoid resetting ACK timer in DCTCP")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
---
 include/net/tcp.h    | 1 -
 net/ipv4/tcp_input.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0a3b0ba6ae50799fdb114768a06937dc429f0417..efaed11e691d52db0fcece85d966954763d3cfcf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -350,7 +350,6 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 				     bool force_schedule);
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks);
 static inline void tcp_dec_quickack_mode(struct sock *sk,
 					 const unsigned int pkts)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 57c8af1859c16eba5e952a23ea959b628006f9c1..48c2b96b084351e362eec73925e6afbfebe02e8b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -287,7 +287,7 @@ static void tcp_incr_quickack(struct sock *sk, unsigned int max_quickacks)
 		icsk->icsk_ack.quick = quickacks;
 }
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
+static void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -295,7 +295,6 @@ void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 	inet_csk_exit_pingpong_mode(sk);
 	icsk->icsk_ack.ato = TCP_ATO_MIN;
 }
-EXPORT_SYMBOL(tcp_enter_quickack_mode);
 
 /* Send ACKs quickly, if "quick" count is not exhausted
  * and the session is not interactive.
-- 
2.41.0.255.g8b1d071c50-goog


