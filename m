Return-Path: <netdev+bounces-31044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A218778B0D0
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744E41C20410
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF693125AD;
	Mon, 28 Aug 2023 12:44:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DE46BA
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 12:44:22 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090FE100
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:44:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d74a0f88457so3820535276.2
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693226660; x=1693831460;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0gNdXyvwmU1BEiu+u2AzAKQjUDXvrwMvpJWRLzG/nnY=;
        b=HOugWpQn85RdVyMglokCPKtiMJ5i5N4YtiIjHM1P6/fLpUub4QRXkCoZyxIO6/2XBY
         P/TNUUfROai9lO15B52dblJm6jLGM3UhzanpD1S1mXlbcgDqv4+fD1qelh5zzQ06kYKj
         6loOcyNJxLRqaq1Ufir4WsEYCDgaEr/xq1Po905T5fyuJLJeWQjTYofDWCGoVvgAtd0A
         nN0nexVDHw4S1exQF8Kaq0qdUfAN0b5BPRO62qnC21knoORBQIkzDIwESoXng7L1oDbe
         sZ1kJWlRNLdtQQd0toYzO36TkfmJFjB10uFvRQSoiv7ptX8GLCrSaLpyS0mrYGbZoT/t
         Bneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693226660; x=1693831460;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gNdXyvwmU1BEiu+u2AzAKQjUDXvrwMvpJWRLzG/nnY=;
        b=GmmxXNimFbmyJSIhkrBgQzXCQh0jsKRKiSJ3duNieN2qETiM0GVqCIKzXts4alPsJ6
         +RIheMMqvvDrdQfUpQ03B9YOSeB2AoOhH3U8T4zs5nB5V5j6fFi+6W31/cq7KOp1p2PV
         fJ32nYkfDPfy9WYbvIevt7LVxHLOVwRrtcWSDte9yLU0OzgG/hFnx47nPQzYBJ89x/Y+
         2xwl62Ccv4AMzhgZSbnGSMY8W7M0d2VkuAv5BieLRQTI+W7uL6PyCN9aC8j2vHHqoZ6c
         yXPI2XvcqfGS2WMqL1tHxaxMhrDj5Go+UJumOPzHHeEFYmk9p++flqNti6RgJe3RFmG+
         TQNw==
X-Gm-Message-State: AOJu0Yx6JYHoUgm9j8Xym7RvigLUxFnub5sjoy5anWa0O2Pit5iohDK5
	yrcC9DtQ5PdFeWBgupiSHjRtkrGLj9VVHg==
X-Google-Smtp-Source: AGHT+IFj5k99EE4+ZqNexUKNrndfDrzb/Ae7j0PZUd0gdkkMCrUc/rIGCIXX00fbSIMjL/tnJteHDYLc0MfpBw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:41c1:0:b0:d45:daf4:1fc5 with SMTP id
 o184-20020a2541c1000000b00d45daf41fc5mr778736yba.3.1693226660326; Mon, 28 Aug
 2023 05:44:20 -0700 (PDT)
Date: Mon, 28 Aug 2023 12:44:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230828124419.2915961-1-edumazet@google.com>
Subject: [PATCH net] sctp: annotate data-races around sk->sk_wmem_queued
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk->sk_wmem_queued can be read locklessly from sctp_poll()

Use sk_wmem_queued_add() when the field is changed,
and add READ_ONCE() annotations in sctp_writeable()
and sctp_assocs_seq_show()

syzbot reported:

BUG: KCSAN: data-race in sctp_poll / sctp_wfree

read-write to 0xffff888149d77810 of 4 bytes by interrupt on cpu 0:
sctp_wfree+0x170/0x4a0 net/sctp/socket.c:9147
skb_release_head_state+0xb7/0x1a0 net/core/skbuff.c:988
skb_release_all net/core/skbuff.c:1000 [inline]
__kfree_skb+0x16/0x140 net/core/skbuff.c:1016
consume_skb+0x57/0x180 net/core/skbuff.c:1232
sctp_chunk_destroy net/sctp/sm_make_chunk.c:1503 [inline]
sctp_chunk_put+0xcd/0x130 net/sctp/sm_make_chunk.c:1530
sctp_datamsg_put+0x29a/0x300 net/sctp/chunk.c:128
sctp_chunk_free+0x34/0x50 net/sctp/sm_make_chunk.c:1515
sctp_outq_sack+0xafa/0xd70 net/sctp/outqueue.c:1381
sctp_cmd_process_sack net/sctp/sm_sideeffect.c:834 [inline]
sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1366 [inline]
sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
sctp_do_sm+0x12c7/0x31b0 net/sctp/sm_sideeffect.c:1169
sctp_assoc_bh_rcv+0x2b2/0x430 net/sctp/associola.c:1051
sctp_inq_push+0x108/0x120 net/sctp/inqueue.c:80
sctp_rcv+0x116e/0x1340 net/sctp/input.c:243
sctp6_rcv+0x25/0x40 net/sctp/ipv6.c:1120
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
process_backlog+0x21f/0x380 net/core/dev.c:5894
__napi_poll+0x60/0x3b0 net/core/dev.c:6460
napi_poll net/core/dev.c:6527 [inline]
net_rx_action+0x32b/0x750 net/core/dev.c:6660
__do_softirq+0xc1/0x265 kernel/softirq.c:553
run_ksoftirqd+0x17/0x20 kernel/softirq.c:921
smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
kthread+0x1d7/0x210 kernel/kthread.c:389
ret_from_fork+0x2e/0x40 arch/x86/kernel/process.c:145
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

read to 0xffff888149d77810 of 4 bytes by task 17828 on cpu 1:
sctp_writeable net/sctp/socket.c:9304 [inline]
sctp_poll+0x265/0x410 net/sctp/socket.c:8671
sock_poll+0x253/0x270 net/socket.c:1374
vfs_poll include/linux/poll.h:88 [inline]
do_pollfd fs/select.c:873 [inline]
do_poll fs/select.c:921 [inline]
do_sys_poll+0x636/0xc00 fs/select.c:1015
__do_sys_ppoll fs/select.c:1121 [inline]
__se_sys_ppoll+0x1af/0x1f0 fs/select.c:1101
__x64_sys_ppoll+0x67/0x80 fs/select.c:1101
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00019e80 -> 0x0000cc80

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 17828 Comm: syz-executor.1 Not tainted 6.5.0-rc7-syzkaller-00185-g28f20a19294d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023

Fixes: 1da177e4c3f ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/proc.c   |  2 +-
 net/sctp/socket.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index f13d6a34f32f2f733df83ac82766466234cda42f..ec00ee75d59a658b7ad0086314f7e82a49ffc876 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -282,7 +282,7 @@ static int sctp_assocs_seq_show(struct seq_file *seq, void *v)
 		assoc->init_retries, assoc->shutdown_retries,
 		assoc->rtx_data_chunks,
 		refcount_read(&sk->sk_wmem_alloc),
-		sk->sk_wmem_queued,
+		READ_ONCE(sk->sk_wmem_queued),
 		sk->sk_sndbuf,
 		sk->sk_rcvbuf);
 	seq_printf(seq, "\n");
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 76f1bce49a8e7b3eabfc53c66eaf6f68d41cfb77..d5f19850f9a0efb8afd444b0da7452e78e912df8 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -69,7 +69,7 @@
 #include <net/sctp/stream_sched.h>
 
 /* Forward declarations for internal helper functions. */
-static bool sctp_writeable(struct sock *sk);
+static bool sctp_writeable(const struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
 static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 				size_t msg_len);
@@ -140,7 +140,7 @@ static inline void sctp_set_owner_w(struct sctp_chunk *chunk)
 
 	refcount_add(sizeof(struct sctp_chunk), &sk->sk_wmem_alloc);
 	asoc->sndbuf_used += chunk->skb->truesize + sizeof(struct sctp_chunk);
-	sk->sk_wmem_queued += chunk->skb->truesize + sizeof(struct sctp_chunk);
+	sk_wmem_queued_add(sk, chunk->skb->truesize + sizeof(struct sctp_chunk));
 	sk_mem_charge(sk, chunk->skb->truesize);
 }
 
@@ -9144,7 +9144,7 @@ static void sctp_wfree(struct sk_buff *skb)
 	struct sock *sk = asoc->base.sk;
 
 	sk_mem_uncharge(sk, skb->truesize);
-	sk->sk_wmem_queued -= skb->truesize + sizeof(struct sctp_chunk);
+	sk_wmem_queued_add(sk, -(skb->truesize + sizeof(struct sctp_chunk)));
 	asoc->sndbuf_used -= skb->truesize + sizeof(struct sctp_chunk);
 	WARN_ON(refcount_sub_and_test(sizeof(struct sctp_chunk),
 				      &sk->sk_wmem_alloc));
@@ -9299,9 +9299,9 @@ void sctp_write_space(struct sock *sk)
  * UDP-style sockets or TCP-style sockets, this code should work.
  *  - Daisy
  */
-static bool sctp_writeable(struct sock *sk)
+static bool sctp_writeable(const struct sock *sk)
 {
-	return sk->sk_sndbuf > sk->sk_wmem_queued;
+	return READ_ONCE(sk->sk_sndbuf) > READ_ONCE(sk->sk_wmem_queued);
 }
 
 /* Wait for an association to go into ESTABLISHED state. If timeout is 0,
-- 
2.42.0.rc1.204.g551eb34607-goog


