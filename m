Return-Path: <netdev+bounces-45190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6C87DB563
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544DFB20C6C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E446A2;
	Mon, 30 Oct 2023 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTXozX/F"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965C137E
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 08:45:33 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55174C4
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 01:45:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b02ed0f886so26618677b3.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698655530; x=1699260330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bUFDd7mr5f4aNjfsZZQpuwCRd5d1xrk3SNhcJ6MKvq8=;
        b=HTXozX/Fq/p2b6oVsiuz0fyqd86xkM29IX5xB1h6wNAHfeTc4yQgJwhS28JRJUh74K
         qXZ5BmbWAsQQPAcFOjyRbrVGaAXPLEIT/eIC2Pwe4KFNHWcoV4cQUhtN1T3jnkhnqK9d
         DMXzM/od3aQFvUtoXh/aMtIv5tnVPvIg4ExbjmPZKE6IHM1aAYowUE6zCIGZPGSqMsI7
         Cxyon7rGZdA2rhJxsQkgAhP6h8PhI+Vp9IV/jFvO9AKn/uQKGHO/FfmDMTRZvvDZFfdW
         a6RVVaCS77IdW7Twi8Ompj6dAU9AcuZ6RGu9POIkPTamBdbBHhcAtAcukKDAFk3mAGxw
         Z0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698655530; x=1699260330;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUFDd7mr5f4aNjfsZZQpuwCRd5d1xrk3SNhcJ6MKvq8=;
        b=RQqCZA1vxuDkzpU+QyOJAva11F38K+AxM5iLKQM3Y7JEBYoSLic2AEzcQwlSNIT18E
         ZV/GEdv1oJKOM/6y0dsA6ME8SuuFkQcYxRpfL0PzPW18LK0JZFE7AOFZzSANBS68dx8J
         WbS5/+yIfwN7Gd0EiCV5gUtOv0N03LTcoBPH2Nj06x6fYtNq8VPfwSCD8DnJOaXs43Ik
         ynRMKAGhCh1LCVO3Uq5eKuyJzwmQNp4AJfBqmFw3q/lLxFQu0RWowD1Ss7PA+5JtqDti
         LWcDJLiCgGOvxiH6F1WzeQrbKls20sKu2Uu5v3iz7ae3gMWSPIHw1yodfkCsV/hya4wf
         il6g==
X-Gm-Message-State: AOJu0YwuzUjAOTCljimP2jz4UOUq5hJkK9I14CZkPEH/r+AnPP3C4Qgz
	HdRntaRKmRm8gfTTY6IboYOFxGKKT0L6GA==
X-Google-Smtp-Source: AGHT+IFbd86T2dQ1Q7ldSvNU4Agx+c39vj9G9JQE9kr9KQieIfMbWFUj7CtbFCwFFV5Arnq5jnzo0gYYuxNJPA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:d9d4:0:b0:5a7:b543:7f0c with SMTP id
 b203-20020a0dd9d4000000b005a7b5437f0cmr219449ywe.10.1698655530561; Mon, 30
 Oct 2023 01:45:30 -0700 (PDT)
Date: Mon, 30 Oct 2023 08:45:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030084529.2057421-1-edumazet@google.com>
Subject: [PATCH net] net/tcp: fix possible out-of-bounds reads in tcp_hash_fail()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Dmitry Safonov <dima@arista.com>, Francesco Ruggeri <fruggeri@arista.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

syzbot managed to trigger a fault by sending TCP packets
with all flags being set.

BUG: KASAN: stack-out-of-bounds in string_nocheck lib/vsprintf.c:645 [inline]
BUG: KASAN: stack-out-of-bounds in string+0x394/0x3d0 lib/vsprintf.c:727
Read of size 1 at addr ffffc9000397f3f5 by task syz-executor299/5039

CPU: 1 PID: 5039 Comm: syz-executor299 Not tainted 6.6.0-rc7-syzkaller-02075-g55c900477f5b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:364 [inline]
print_report+0xc4/0x620 mm/kasan/report.c:475
kasan_report+0xda/0x110 mm/kasan/report.c:588
string_nocheck lib/vsprintf.c:645 [inline]
string+0x394/0x3d0 lib/vsprintf.c:727
vsnprintf+0xc5f/0x1870 lib/vsprintf.c:2818
vprintk_store+0x3a0/0xb80 kernel/printk/printk.c:2191
vprintk_emit+0x14c/0x5f0 kernel/printk/printk.c:2288
vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
_printk+0xc8/0x100 kernel/printk/printk.c:2332
tcp_inbound_hash.constprop.0+0xdb2/0x10d0 include/net/tcp.h:2760
tcp_v6_rcv+0x2b31/0x34d0 net/ipv6/tcp_ipv6.c:1882
ip6_protocol_deliver_rcu+0x33b/0x13d0 net/ipv6/ip6_input.c:438
ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
NF_HOOK include/linux/netfilter.h:314 [inline]
NF_HOOK include/linux/netfilter.h:308 [inline]
ip6_input+0xce/0x440 net/ipv6/ip6_input.c:492
dst_input include/net/dst.h:461 [inline]
ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
NF_HOOK include/linux/netfilter.h:314 [inline]
NF_HOOK include/linux/netfilter.h:308 [inline]
ipv6_rcv+0x563/0x720 net/ipv6/ip6_input.c:310
__netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5527
__netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5641
netif_receive_skb_internal net/core/dev.c:5727 [inline]
netif_receive_skb+0x133/0x700 net/core/dev.c:5786
tun_rx_batched+0x429/0x780 drivers/net/tun.c:1579
tun_get_user+0x29e7/0x3bc0 drivers/net/tun.c:2002
tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2048
call_write_iter include/linux/fs.h:1956 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x650/0xe40 fs/read_write.c:584
ksys_write+0x12f/0x250 fs/read_write.c:637
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 2717b5adea9e ("net/tcp: Add tcp_hash_fail() ratelimited logs")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Francesco Ruggeri <fruggeri@arista.com>
Cc: David Ahern <dsahern@kernel.org>
---
 include/net/tcp_ao.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index a375a171ef3cb37ab1d8246c72c6a3e83f5c9184..5daf96a3dbee14bd3786e19ea4972e351058e6e7 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -124,7 +124,7 @@ struct tcp_ao_info {
 #define tcp_hash_fail(msg, family, skb, fmt, ...)			\
 do {									\
 	const struct tcphdr *th = tcp_hdr(skb);				\
-	char hdr_flags[5] = {};						\
+	char hdr_flags[5];						\
 	char *f = hdr_flags;						\
 									\
 	if (th->fin)							\
@@ -135,8 +135,7 @@ do {									\
 		*f++ = 'R';						\
 	if (th->ack)							\
 		*f++ = 'A';						\
-	if (f != hdr_flags)						\
-		*f = ' ';						\
+	*f = 0;								\
 	if ((family) == AF_INET) {					\
 		net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d) %s" fmt "\n", \
 				msg, &ip_hdr(skb)->saddr, ntohs(th->source), \
-- 
2.42.0.820.g83a721a137-goog


