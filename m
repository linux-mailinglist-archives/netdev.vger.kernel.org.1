Return-Path: <netdev+bounces-37764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C77B70FE
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 20:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 26D6BB207CD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36F328A8;
	Tue,  3 Oct 2023 18:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28662208D9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 18:34:59 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCF83
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:34:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e1154756so18408317b3.2
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696358097; x=1696962897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KAHqWrtDb9NPF7DLFjIS3O6hmxVDbgQo+OlGtVyn+6k=;
        b=PuBDpKvl3Ep5PJRNqurOoFJ5ag8ashAXcRW4ieogxube6/u0F7kATnL420gyx9Hofm
         WKLGOi3O2tgVTstmRSfNc6758/jNAIiRzE6GvI4VdzllQl/KA/tbYMX2PuXR4c1H5Ht6
         ziqWlsOjQSxvrABS2Bvq+wp9dgLMlEm2UHcKvChApZa+NaLF1m6wYJqm2iZwQ17Hqr+5
         qrPtWuMFvFD8j+jmeOoVT49gjG1wicCZDISKJAbS+1jOYC4YcEJwRA+lHNH3t2CW9AGA
         qze23X4E4aS52l8EnSJ9Cvca8hCrpfCw9CrM2KiU3fv32LaA/d4eiB4L1lvKsbBaXYv5
         qJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358097; x=1696962897;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAHqWrtDb9NPF7DLFjIS3O6hmxVDbgQo+OlGtVyn+6k=;
        b=BjFDTLl9LC8VDkvSoOxu//q+kEsH3AI84pHEtvMF9jBzdwpMAGYAaCBVlTZoe+rjcU
         Xe1aWHUYTh2mnmRjoXBUyycCOfN8OM7qm8ANNNwUAYufepa//j+Mfi+JFY+Ezm2KvF23
         Bf/xTr3OboL/0D4AW3B2FgZ2w+T13l2q59LDO4BEpyssRC/CdfJHMyfn8r3NRTE42N7i
         2WMRrWAB5RHosPTdzq/lYJsTf40rjFEn3/JgxYNLsEQPbcPoQowvfpm3L+8KtzC64/yY
         3Y2xGP6WehWAenokNna4O8qk2KcJsd2XAwyFIUXum7p2Qmd4KOgtu/Y2OqvOew3OegJ1
         uGdQ==
X-Gm-Message-State: AOJu0Yz4IyeDL1kWheIryYicfoa2xsNWyL4jNFb7qVloOiDhfEsoO+Z6
	EDlslxhmfqhW1kC8rRlKMNAQU2xpbcn11g==
X-Google-Smtp-Source: AGHT+IFQD+zXGe6v0HQ4cxiRZbRsgJA34iuYeFAOWpOQZQCqDAcz2RWsvhYCe6rUIdq9n8c4kOjySmm4dbFTSQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d313:0:b0:d7b:92d7:5629 with SMTP id
 e19-20020a25d313000000b00d7b92d75629mr983ybf.8.1696358097597; Tue, 03 Oct
 2023 11:34:57 -0700 (PDT)
Date: Tue,  3 Oct 2023 18:34:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003183455.3410550-1-edumazet@google.com>
Subject: [PATCH net] netlink: annotate data-races around sk->sk_err
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

syzbot caught another data-race in netlink when
setting sk->sk_err.

Annotate all of them for good measure.

BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg

write to 0xffff8881613bb220 of 4 bytes by task 28147 on cpu 0:
netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
sock_recvmsg_nosec net/socket.c:1027 [inline]
sock_recvmsg net/socket.c:1049 [inline]
__sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
__do_sys_recvfrom net/socket.c:2247 [inline]
__se_sys_recvfrom net/socket.c:2243 [inline]
__x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to 0xffff8881613bb220 of 4 bytes by task 28146 on cpu 1:
netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
sock_recvmsg_nosec net/socket.c:1027 [inline]
sock_recvmsg net/socket.c:1049 [inline]
__sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
__do_sys_recvfrom net/socket.c:2247 [inline]
__se_sys_recvfrom net/socket.c:2243 [inline]
__x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000 -> 0x00000016

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 28146 Comm: syz-executor.0 Not tainted 6.6.0-rc3-syzkaller-00055-g9ed22ae6be81 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 net/netlink/af_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 642b9d382fb46ddbc3523584c98e07da6860951a..eb086b06d60da48646739226ca084fa6f6f31b74 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -352,7 +352,7 @@ static void netlink_overrun(struct sock *sk)
 	if (!nlk_test_bit(RECV_NO_ENOBUFS, sk)) {
 		if (!test_and_set_bit(NETLINK_S_CONGESTED,
 				      &nlk_sk(sk)->state)) {
-			sk->sk_err = ENOBUFS;
+			WRITE_ONCE(sk->sk_err, ENOBUFS);
 			sk_error_report(sk);
 		}
 	}
@@ -1605,7 +1605,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 		goto out;
 	}
 
-	sk->sk_err = p->code;
+	WRITE_ONCE(sk->sk_err, p->code);
 	sk_error_report(sk);
 out:
 	return ret;
@@ -1991,7 +1991,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
 		ret = netlink_dump(sk);
 		if (ret) {
-			sk->sk_err = -ret;
+			WRITE_ONCE(sk->sk_err, -ret);
 			sk_error_report(sk);
 		}
 	}
@@ -2511,7 +2511,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 err_bad_put:
 	nlmsg_free(skb);
 err_skb:
-	NETLINK_CB(in_skb).sk->sk_err = ENOBUFS;
+	WRITE_ONCE(NETLINK_CB(in_skb).sk->sk_err, ENOBUFS);
 	sk_error_report(NETLINK_CB(in_skb).sk);
 }
 EXPORT_SYMBOL(netlink_ack);
-- 
2.42.0.582.g8ccd20d70d-goog


