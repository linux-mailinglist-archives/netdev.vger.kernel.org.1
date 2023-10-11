Return-Path: <netdev+bounces-39956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7847C5004
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B0E1C20C6A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2131DA50;
	Wed, 11 Oct 2023 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOk/92jY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C85354F6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:24:33 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFDB9E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:24:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f7d109926so102186337b3.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697019870; x=1697624670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=203bBP7a2b6pRkiY7KIj8CvvSRZjJgZuucLnBJ/xXnU=;
        b=DOk/92jYBf3h31SkLVTi7CAckbljDDiKN6O/M7pc2b4VwhTHK7GsbZ/RRnVIa+ngDf
         kPuxzhrn/bAgTULOAUqa0E8pKJOghFQL+WkC6sRXwK0/+JbXo6hABLAx8716wiqaxLod
         7wpc1c1tV0NPUYL5e2rTJ6sG5dWErPjvskzUd6IFZAcnN/zk15H4xElmbMU3veUofyq8
         qSmxUdpJKOcaXeyC300Zl8j4fOYYl3FKWIjP4EQAt8jP0a9d2qga+VwkBMBfLzpZjyhs
         xupQFlxjFGDwMNcF13BcsKKLhrn7TT06ddpo6/VkZgui6PYfLRr+blNmqbqH22qXT3sM
         OL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697019870; x=1697624670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=203bBP7a2b6pRkiY7KIj8CvvSRZjJgZuucLnBJ/xXnU=;
        b=NOBDOXxtD8jTgD0icC46E7aQITOQ9VO9CVVXtWQzR5tJTaICTS8JrQ6UhV0wT2h2X0
         rcceoiWeAOCLKzmtZfkxpDwM+YCbmEkzgYr7X0p72ywu8oYEhQgXiEtX0TvWf7uPIMxo
         zuQIxKl8ghGhtNXfuRAC3ucBOIVOR0EO673JSwxgtOQS/wVIpfr/QmoLzGZBj9APiwke
         Glo5Yw2Tw3A8qvm7S+BtpN9bHvDX2RSMvFA2vaIYCVqENbPvbtq/CHMeuKlha1tUzGGb
         Ejl9XmeLMEotN+qq0v9Rtf2sJeXdQXXQJa5ZUNBJBRp7Mak/2/VoAaw9mjywwexZNCx3
         rxvA==
X-Gm-Message-State: AOJu0YwbAFmnpSXgLLBjbfW9S4tXCf9d0JEw7V/0ESbuDObo7bulG+FB
	IlbeIvzdKDuAmoskviHgodfdLQQPNGGgHw==
X-Google-Smtp-Source: AGHT+IHWaniAO/TC9lAfBZdoLMlbcrwc3qCJo2wZcRJeQP6ABbHhPdIxJaomJQa1mi8v39boLPsgnciBWP/+Dw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:acf:0:b0:d77:f6f9:159 with SMTP id
 a15-20020a5b0acf000000b00d77f6f90159mr397894ybr.9.1697019870452; Wed, 11 Oct
 2023 03:24:30 -0700 (PDT)
Date: Wed, 11 Oct 2023 10:24:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231011102429.799316-1-edumazet@google.com>
Subject: [PATCH net] xfrm: fix a data-race in xfrm_lookup_with_ifid()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot complains about a race in xfrm_lookup_with_ifid() [1]

When preparing commit 0a9e5794b21e ("xfrm: annotate data-race
around use_time") I thought xfrm_lookup_with_ifid() was modifying
a still private structure.

[1]
BUG: KCSAN: data-race in xfrm_lookup_with_ifid / xfrm_lookup_with_ifid

write to 0xffff88813ea41108 of 8 bytes by task 8150 on cpu 1:
xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

write to 0xffff88813ea41108 of 8 bytes by task 15867 on cpu 0:
xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x00000000651cd9d1 -> 0x00000000651cd9d2

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 15867 Comm: kworker/u4:58 Not tainted 6.6.0-rc4-syzkaller-00016-g5e62ed3b1c8a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: wg-kex-wg2 wg_packet_handshake_send_worker

Fixes: 0a9e5794b21e ("xfrm: annotate data-race around use_time")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a73e4b66c98f9db98d94a146bc963fa29979c592..1058530d2a7235abe0f051e26695efbfc84feb33 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3213,7 +3213,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 	}
 
 	for (i = 0; i < num_pols; i++)
-		pols[i]->curlft.use_time = ktime_get_real_seconds();
+		WRITE_ONCE(pols[i]->curlft.use_time, ktime_get_real_seconds());
 
 	if (num_xfrms < 0) {
 		/* Prohibit the flow */
-- 
2.42.0.609.gbb76f46606-goog


