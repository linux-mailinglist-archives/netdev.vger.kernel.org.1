Return-Path: <netdev+bounces-32090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED73E792320
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 15:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4331C2099E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35784D512;
	Tue,  5 Sep 2023 13:40:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4F63D9
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:40:50 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7924D191
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 06:40:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59501b014f4so23889657b3.0
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693921247; x=1694526047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yyA+SVJNJFjACAZiWGyLHWyeBZHQWKbJeVhT+xqP1lE=;
        b=v5TnexvZZCuWvvzCTgfBWCuePa0siVIHWlShfCRiYxO2bOTVxVNqaZhF7fXUXolb7u
         kdQT54VltJmA9voXiz1rgn486LNJ/yxJD3xNFhEZdo1v1i+TLnPKyOJw9WZPlzvLEw/V
         yXrMJyy4XIt/Da3CNzWIxuZiZV62VZQ2SPC8K5NET88LkqO8CnDFEvhEUyLtnXV48duT
         bHiModcxokVh6SsHEHuBOmnzbn2AuR9Ptq0+ExuHBlp93O3b05CyHFj5nodyjGiI9j1W
         KK3gNVap1wb+XBxSAkz89rS3ljT1k7Wqtx9SJa34dQhClGC5UQWbsupviANumthNE4MP
         DQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693921247; x=1694526047;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyA+SVJNJFjACAZiWGyLHWyeBZHQWKbJeVhT+xqP1lE=;
        b=aanZtpOJsjqku4Q6+XqWuqAHir86GoktgNmtM+2oJCsf2sxdbZxV7VIzCGeqFsikuq
         5pExqRm18KI8zjrGAadRaqqSox53w0caMPWIQ3BHdYv3MWtUHEkgjhwb4WbV70R06XVe
         XV7AX2Zr2GY3tFFZgUsiGFsxMi28BxMUMJbGiJ+oV73Ph++rsOcQ9yXfm3NEDzwjNioe
         OlVP2vDYTDzO2LldKVysv2dcUwNp/3fGJYUg7YhWXITnVppfzix6bInpq/kWW7Med+Of
         VX2RGwTYDtwhsQln3t7rRekIgpvyc9vHxF8rYmvSLbrrjNWseV0oHK4AA2eOaJ1dcxbZ
         SOBA==
X-Gm-Message-State: AOJu0YyIuqGNCYigywwYorBdMkS4agES+t6hDubztQatLh+fh8VZmz9E
	QN4hQyx3RbYs9MlAhFWQJcyLHgMaclp+Ng==
X-Google-Smtp-Source: AGHT+IEt6CGOVrdR2dhmnr9DYJemcwlI0g1fqaDOgArm5JHmJef57M/ZnoTA549bd/PDwwZnXJ5caxzSKN6D+A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:451d:0:b0:58c:6ddd:d27c with SMTP id
 s29-20020a81451d000000b0058c6dddd27cmr339150ywa.6.1693921247774; Tue, 05 Sep
 2023 06:40:47 -0700 (PDT)
Date: Tue,  5 Sep 2023 13:40:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905134046.2050443-1-edumazet@google.com>
Subject: [PATCH net] ip_tunnels: use DEV_STATS_INC()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot/KCSAN reported data-races in iptunnel_xmit_stats() [1]

This can run from multiple cpus without mutual exclusion.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

[1]
BUG: KCSAN: data-race in iptunnel_xmit / iptunnel_xmit

read-write to 0xffff8881353df170 of 8 bytes by task 30263 on cpu 1:
iptunnel_xmit_stats include/net/ip_tunnels.h:493 [inline]
iptunnel_xmit+0x432/0x4a0 net/ipv4/ip_tunnel_core.c:87
ip_tunnel_xmit+0x1477/0x1750 net/ipv4/ip_tunnel.c:831
__gre_xmit net/ipv4/ip_gre.c:469 [inline]
ipgre_xmit+0x516/0x570 net/ipv4/ip_gre.c:662
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
__bpf_tx_skb net/core/filter.c:2129 [inline]
__bpf_redirect_no_mac net/core/filter.c:2159 [inline]
__bpf_redirect+0x723/0x9c0 net/core/filter.c:2182
____bpf_clone_redirect net/core/filter.c:2453 [inline]
bpf_clone_redirect+0x16c/0x1d0 net/core/filter.c:2425
___bpf_prog_run+0xd7d/0x41e0 kernel/bpf/core.c:1954
__bpf_prog_run512+0x74/0xa0 kernel/bpf/core.c:2195
bpf_dispatcher_nop_func include/linux/bpf.h:1181 [inline]
__bpf_prog_run include/linux/filter.h:609 [inline]
bpf_prog_run include/linux/filter.h:616 [inline]
bpf_test_run+0x15d/0x3d0 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x77b/0xa00 net/bpf/test_run.c:1045
bpf_prog_test_run+0x265/0x3d0 kernel/bpf/syscall.c:3996
__sys_bpf+0x3af/0x780 kernel/bpf/syscall.c:5353
__do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
__x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5437
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff8881353df170 of 8 bytes by task 30249 on cpu 0:
iptunnel_xmit_stats include/net/ip_tunnels.h:493 [inline]
iptunnel_xmit+0x432/0x4a0 net/ipv4/ip_tunnel_core.c:87
ip_tunnel_xmit+0x1477/0x1750 net/ipv4/ip_tunnel.c:831
__gre_xmit net/ipv4/ip_gre.c:469 [inline]
ipgre_xmit+0x516/0x570 net/ipv4/ip_gre.c:662
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
__bpf_tx_skb net/core/filter.c:2129 [inline]
__bpf_redirect_no_mac net/core/filter.c:2159 [inline]
__bpf_redirect+0x723/0x9c0 net/core/filter.c:2182
____bpf_clone_redirect net/core/filter.c:2453 [inline]
bpf_clone_redirect+0x16c/0x1d0 net/core/filter.c:2425
___bpf_prog_run+0xd7d/0x41e0 kernel/bpf/core.c:1954
__bpf_prog_run512+0x74/0xa0 kernel/bpf/core.c:2195
bpf_dispatcher_nop_func include/linux/bpf.h:1181 [inline]
__bpf_prog_run include/linux/filter.h:609 [inline]
bpf_prog_run include/linux/filter.h:616 [inline]
bpf_test_run+0x15d/0x3d0 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x77b/0xa00 net/bpf/test_run.c:1045
bpf_prog_test_run+0x265/0x3d0 kernel/bpf/syscall.c:3996
__sys_bpf+0x3af/0x780 kernel/bpf/syscall.c:5353
__do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
__x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5437
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000018830 -> 0x0000000000018831

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 30249 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-11704-g3f86ed6ec0b3 #0

Fixes: 039f50629b7f ("ip_tunnel: Move stats update to iptunnel_xmit()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index e8750b4ef7e17ad85c88ec1db73242795ede0281..f346b4efbc307bcca8893775d9bd4c12f5917293 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -483,15 +483,14 @@ static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 		u64_stats_inc(&tstats->tx_packets);
 		u64_stats_update_end(&tstats->syncp);
 		put_cpu_ptr(tstats);
+		return;
+	}
+
+	if (pkt_len < 0) {
+		DEV_STATS_INC(dev, tx_errors);
+		DEV_STATS_INC(dev, tx_aborted_errors);
 	} else {
-		struct net_device_stats *err_stats = &dev->stats;
-
-		if (pkt_len < 0) {
-			err_stats->tx_errors++;
-			err_stats->tx_aborted_errors++;
-		} else {
-			err_stats->tx_dropped++;
-		}
+		DEV_STATS_INC(dev, tx_dropped);
 	}
 }
 
-- 
2.42.0.283.g2d96d420d3-goog


