Return-Path: <netdev+bounces-18313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92C97566B4
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D4D1C20A3F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BFF253AF;
	Mon, 17 Jul 2023 14:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC99BA30
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:44:51 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C7B2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:44:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5706641dda9so40593267b3.3
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689605089; x=1692197089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAwiGT1SsbXm6zGfw4gBaUR4IAO0URGNJXv6pp3PwxM=;
        b=zmj3jlW0lisrAApueFrP+QjDhzF6Gk9ZqlxmT2UqlBG+pMlfky0s5eHxgNDZptDSGA
         t0hTRly4ZRFSyUpEqQIIzCtEEBTEFSPe1ZjJI3X4nA1mhrSfJmha2oTDeFZdAnsijqA8
         ZaI6jAF3qWFT32rXiIHf7/604dkN5/7E0tt70X+62cX9q00+RBANtfV8kpdPHpZ2Nyk+
         OQXY0wnOlTnM78tSB4chC4SgPbhRmbU/WDK/mHtIXvvvtdtFIWf/ZDgsxUoXhaDtbpyf
         DmvMuOuHVr085cMvBNnUENC5bgFGMw64dxRh2b8VD3NBfbwZ2Wj2T0SqlPyZsA8Asczs
         b3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605089; x=1692197089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAwiGT1SsbXm6zGfw4gBaUR4IAO0URGNJXv6pp3PwxM=;
        b=fMGWtVdB0zQMy8dwwqGFtTlnX5AwwKPt24nmODszT1d25R0fIa9sLSGPuvucpx/p45
         hSKkbw7Gt9upopo1tBmSC5Kkau1MVUTG8MJ1YDMlwIYfxsP6UqSrpw9T+afFHrUjySwh
         t/dW/g0QVbgwdth3zLxqe2dE9obTdelNqaiTxQeLRNOhmKJ7MlBdTBqavLbm7bBui4Zn
         K2zqTj6A0ySjLsy9TKeoWHhxRR4Pvg1+a8NtrQ8Nl0/7xZ65tHMi6vzNZRZz62ygl/Zd
         gcvcMzG+oMx5I4OrWMcfBzX757L83aCeQeSNNrKoxS1a6ncMx3yVde8Ca9wzM4txRAUP
         6HBQ==
X-Gm-Message-State: ABy/qLZAJBz4yQ9I286oHJTmBU0BG/ApkWywPsCvdzsmyB0No40L+1rs
	glzpbZwA+v5rByh7wEBiTjLm7AtBOgupTA==
X-Google-Smtp-Source: APBJJlHqph2/1TNZJWSNNDZFeSkoGUf4YWok+9EEz+gss9ZzW2/T4dosEQRX8jTNxvJJc2ukuAQf8JhR+tvppw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:a846:0:b0:579:efd3:967 with SMTP id
 f67-20020a81a846000000b00579efd30967mr130033ywh.0.1689605089173; Mon, 17 Jul
 2023 07:44:49 -0700 (PDT)
Date: Mon, 17 Jul 2023 14:44:44 +0000
In-Reply-To: <20230717144445.653164-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230717144445.653164-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717144445.653164-2-edumazet@google.com>
Subject: [PATCH net 1/2] tcp: annotate data-races around tcp_rsk(req)->txhash
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TCP request sockets are lockless, some of their fields
can change while being read by another cpu as syzbot noticed.

This is usually harmless, but we should annotate the known
races.

This patch takes care of tcp_rsk(req)->txhash,
a separate one is needed for tcp_rsk(req)->ts_recent.

BUG: KCSAN: data-race in tcp_make_synack / tcp_rtx_synack

write to 0xffff8881362304bc of 4 bytes by task 32083 on cpu 1:
tcp_rtx_synack+0x9d/0x2a0 net/ipv4/tcp_output.c:4213
inet_rtx_syn_ack+0x38/0x80 net/ipv4/inet_connection_sock.c:880
tcp_check_req+0x379/0xc70 net/ipv4/tcp_minisocks.c:665
tcp_v6_rcv+0x125b/0x1b20 net/ipv6/tcp_ipv6.c:1673
ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:437
ip6_input_finish net/ipv6/ip6_input.c:482 [inline]
NF_HOOK include/linux/netfilter.h:303 [inline]
ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:491
dst_input include/net/dst.h:468 [inline]
ip6_rcv_finish+0x1e2/0x2e0 net/ipv6/ip6_input.c:79
NF_HOOK include/linux/netfilter.h:303 [inline]
ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:309
__netif_receive_skb_one_core net/core/dev.c:5452 [inline]
__netif_receive_skb+0x90/0x1b0 net/core/dev.c:5566
netif_receive_skb_internal net/core/dev.c:5652 [inline]
netif_receive_skb+0x4a/0x310 net/core/dev.c:5711
tun_rx_batched+0x3bf/0x400
tun_get_user+0x1d24/0x22b0 drivers/net/tun.c:1997
tun_chr_write_iter+0x18e/0x240 drivers/net/tun.c:2043
call_write_iter include/linux/fs.h:1871 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x4ab/0x7d0 fs/read_write.c:584
ksys_write+0xeb/0x1a0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x42/0x50 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff8881362304bc of 4 bytes by task 32078 on cpu 0:
tcp_make_synack+0x367/0xb40 net/ipv4/tcp_output.c:3663
tcp_v6_send_synack+0x72/0x420 net/ipv6/tcp_ipv6.c:544
tcp_conn_request+0x11a8/0x1560 net/ipv4/tcp_input.c:7059
tcp_v6_conn_request+0x13f/0x180 net/ipv6/tcp_ipv6.c:1175
tcp_rcv_state_process+0x156/0x1de0 net/ipv4/tcp_input.c:6494
tcp_v6_do_rcv+0x98a/0xb70 net/ipv6/tcp_ipv6.c:1509
tcp_v6_rcv+0x17b8/0x1b20 net/ipv6/tcp_ipv6.c:1735
ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:437
ip6_input_finish net/ipv6/ip6_input.c:482 [inline]
NF_HOOK include/linux/netfilter.h:303 [inline]
ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:491
dst_input include/net/dst.h:468 [inline]
ip6_rcv_finish+0x1e2/0x2e0 net/ipv6/ip6_input.c:79
NF_HOOK include/linux/netfilter.h:303 [inline]
ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:309
__netif_receive_skb_one_core net/core/dev.c:5452 [inline]
__netif_receive_skb+0x90/0x1b0 net/core/dev.c:5566
netif_receive_skb_internal net/core/dev.c:5652 [inline]
netif_receive_skb+0x4a/0x310 net/core/dev.c:5711
tun_rx_batched+0x3bf/0x400
tun_get_user+0x1d24/0x22b0 drivers/net/tun.c:1997
tun_chr_write_iter+0x18e/0x240 drivers/net/tun.c:2043
call_write_iter include/linux/fs.h:1871 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x4ab/0x7d0 fs/read_write.c:584
ksys_write+0xeb/0x1a0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x42/0x50 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x91d25731 -> 0xe79325cd

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 32078 Comm: syz-executor.4 Not tainted 6.5.0-rc1-syzkaller-00033-geb26cbb1a754 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023

Fixes: 58d607d3e52f ("tcp: provide skb->hash to synack packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 net/ipv4/tcp_ipv4.c      | 3 ++-
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 4 ++--
 net/ipv6/tcp_ipv6.c      | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd365de4d5ffca5e6cb22d056acb27a1a40a497f..fa04ff49100ba09bb17ccb54664c17fc1a9d170e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -992,7 +992,8 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			ip_hdr(skb)->tos, tcp_rsk(req)->txhash);
+			ip_hdr(skb)->tos,
+			READ_ONCE(tcp_rsk(req)->txhash));
 }
 
 /*
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 04fc328727e68404000e4068d741225d00c6e33c..ec05f277ce2ef8f72e2039fab2d5624a4104c869 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -528,7 +528,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newicsk->icsk_ack.lrcvtime = tcp_jiffies32;
 
 	newtp->lsndtime = tcp_jiffies32;
-	newsk->sk_txhash = treq->txhash;
+	newsk->sk_txhash = READ_ONCE(treq->txhash);
 	newtp->total_retrans = req->num_retrans;
 
 	tcp_init_xmit_timers(newsk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2cb39b6dad029c8935b8c31c6a19bd72e7507a12..3b09cd13e2db312198ff314fafd98bccfa8266c8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3660,7 +3660,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	rcu_read_lock();
 	md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
 #endif
-	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
+	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_L4);
 	/* bpf program will be interested in the tcp_flags */
 	TCP_SKB_CB(skb)->tcp_flags = TCPHDR_SYN | TCPHDR_ACK;
 	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts, md5,
@@ -4210,7 +4210,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
-		tcp_rsk(req)->txhash = net_tx_rndhash();
+		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 40dd92a2f4807960c7939a19adccdd1b493c30b1..eb96a8010414bda2eae39c3d8d0bac76ad465165 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1129,7 +1129,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			req->ts_recent, sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
 			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority,
-			tcp_rsk(req)->txhash);
+			READ_ONCE(tcp_rsk(req)->txhash));
 }
 
 
-- 
2.41.0.255.g8b1d071c50-goog


