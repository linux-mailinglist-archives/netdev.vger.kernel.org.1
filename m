Return-Path: <netdev+bounces-45516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDE7DDBFA
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 05:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A96B20F5A
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 04:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8D1390;
	Wed,  1 Nov 2023 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WK6bKJwQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAA1841
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 04:52:37 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCAE103
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:52:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da1aa98ec19so5462891276.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698814355; x=1699419155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OMtkIDUX/j1i63fJeJ5GABjjpSAvL/rueSTjNWrKQtY=;
        b=WK6bKJwQ4pXPA9YMOYSJ4Wx/wZHVkZjmbxtBXqnjIxM5a8bwWRhsRq0SZhPcOFa90W
         5ER8GxD2smW2aewwNDVEfuOMCXE3CzH3NSZ8aRi7rFiwYuyo4uDxSB1s70G8XADVYzYs
         YRvTSTpwghtMZGncnkWPOEsqp31CH6/H30p83TDp9b39TsOIK1RPRBohOe/Iq2ElZrNt
         1PDKUSchh5vVtdbyPnnYv/kD17+FSaVitbCwb7odoV7JDRTlJBLq/s96kJUt28aKm7/Q
         b3FQViooFA8Rg4xhMwJoEXpnId7TVioUJIp8904oUNXL9XCE25vvi8fzHYAQDbCa7BIy
         u4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698814355; x=1699419155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMtkIDUX/j1i63fJeJ5GABjjpSAvL/rueSTjNWrKQtY=;
        b=otgrP0NMjLjiHe2fcYqmQ1b/cJab9msSDrIllA/nx5tElAxGIY0Qt+psfwXb0xajeg
         PcJu2je1GlCzcFp2LXByx1lXihSOqanSdnSRvgheEcXfm/LOSovdYnFn8GUtX3kzjUSp
         vedLCNEd9ByS2des9xNVzwoD+9em6D+rI7yw6K8zT8WurcJQ8/YbhtuHdmUbqrJSFxfL
         qGb+YX51iCshxlDf5eOYa/9JdptiTLZssiQz5kAySnwy8y5ZBgUAOgl1myZu3JxMeZmX
         yOREYIrYGZdHh5PrgY4zWFZ+BSkKSdgIBjB0Bw8A1jiHET407drocSkTSV7hKcsbAKb6
         7PVw==
X-Gm-Message-State: AOJu0Ywq48tR0l2VDAeqFb25VdJG4Uah/fjwOxNC9Y7evyCwfEaL93A+
	CDBvMe6bcUz5ewUeExRSx8JNme4LwJCbSQ==
X-Google-Smtp-Source: AGHT+IGMCa/9s4Vl1vMegRgL+P+8w33T6+pBYguSuxjx4EiO1coQGeyP+vLRjmgObiRLHcNAOpLQDGys7t1S7g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:dbd4:0:b0:da3:7a5c:69ba with SMTP id
 g203-20020a25dbd4000000b00da37a5c69bamr64477ybf.3.1698814354986; Tue, 31 Oct
 2023 21:52:34 -0700 (PDT)
Date: Wed,  1 Nov 2023 04:52:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231101045233.3387072-1-edumazet@google.com>
Subject: [PATCH v2 net] net/tcp: fix possible out-of-bounds reads in tcp_hash_fail()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Dmitry Safonov <dima@arista.com>, Francesco Ruggeri <fruggeri@arista.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

syzbot managed to trigger a fault by sending TCP packets
with all flags being set.

v2:
 - While fixing this bug, add PSH flag handling and represent
   flags the way tcpdump does : [S], [S.], [P.]
 - Print 4-tuples more consistently between families.

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
 include/net/tcp_ao.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index a375a171ef3cb37ab1d8246c72c6a3e83f5c9184..b56be10838f09a2cb56ab511242d2b583eb4c33b 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -124,7 +124,7 @@ struct tcp_ao_info {
 #define tcp_hash_fail(msg, family, skb, fmt, ...)			\
 do {									\
 	const struct tcphdr *th = tcp_hdr(skb);				\
-	char hdr_flags[5] = {};						\
+	char hdr_flags[6];						\
 	char *f = hdr_flags;						\
 									\
 	if (th->fin)							\
@@ -133,17 +133,18 @@ do {									\
 		*f++ = 'S';						\
 	if (th->rst)							\
 		*f++ = 'R';						\
+	if (th->psh)							\
+		*f++ = 'P';						\
 	if (th->ack)							\
-		*f++ = 'A';						\
-	if (f != hdr_flags)						\
-		*f = ' ';						\
+		*f++ = '.';						\
+	*f = 0;								\
 	if ((family) == AF_INET) {					\
-		net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d) %s" fmt "\n", \
+		net_info_ratelimited("%s for %pI4.%d->%pI4.%d [%s] " fmt "\n", \
 				msg, &ip_hdr(skb)->saddr, ntohs(th->source), \
 				&ip_hdr(skb)->daddr, ntohs(th->dest),	\
 				hdr_flags, ##__VA_ARGS__);		\
 	} else {							\
-		net_info_ratelimited("%s for [%pI6c]:%u->[%pI6c]:%u %s" fmt "\n", \
+		net_info_ratelimited("%s for [%pI6c].%d->[%pI6c].%d [%s]" fmt "\n", \
 				msg, &ipv6_hdr(skb)->saddr, ntohs(th->source), \
 				&ipv6_hdr(skb)->daddr, ntohs(th->dest),	\
 				hdr_flags, ##__VA_ARGS__);		\
-- 
2.42.0.820.g83a721a137-goog


