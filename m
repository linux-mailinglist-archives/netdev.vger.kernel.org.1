Return-Path: <netdev+bounces-12717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB0738A01
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B15E1C20EDD
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251AE19531;
	Wed, 21 Jun 2023 15:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FCD19506
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:43:50 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73110D2
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:43:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfae0f532e4so1981273276.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687362219; x=1689954219;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wx/CGC9gI7K/3rwwMYwD+SoHnBa1DxvZMeVHjqZ+wF4=;
        b=faGVIt7CWnUBpyA6DsI7Ik5tVApCFPpkO9+1ZB31OSbF2XFXFloxs5Mf2GziSetx36
         SL4bOvq57kN5/j6GDTI5pOTNJmjUDUkne/45IqjprTd4lHi5Q2OTN2jVygg8j1ZqrCLB
         aEZlUJVoinHnoTFdh0a8mq2EfWtSqjj1+ZBBQMwcxqC1O9q6TWUSOahUwH2UylBSd1xB
         HlioW/hxUhfqjBbbfsK0Z8h4iLYf6PCg7KjDmxwI/b43n0V7KjrS3Re8chxG8m9W/QLf
         yo2b3FJ2PreAbHl6YElAKZWEzRSWgE4hDy7AuwNit3Ul6UqYZ+wYj6UNNvGckzgvXE0Q
         iqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362219; x=1689954219;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wx/CGC9gI7K/3rwwMYwD+SoHnBa1DxvZMeVHjqZ+wF4=;
        b=S7rqUFc6P1t0Qm1cTWdxHmbKLpyOj28hmwmNqqX2Ds6IXSIW3QE3jlNc6fR9R08yh6
         rjZQVQjEocB59Zc8kJvqtS3uBvQHQqvbUJWlpmuJ6wHWadRNrexleI2u9+0W99YjklWB
         w395OEeOvn4mMX6foFGS+3VjMTcnh0rCNdLcOW/8o00p0qvXwrSiAEjvsw/9BYrsZUFS
         7kQuI8iYrTr2yazjW9pagZIvcDEshWS6+R8M3jyl/AwDRplPaAHiR/Wxq2EjDW8J2+/n
         oobXZW8GybgcNfGz2OOI0nYYJXouwulDCgseq3bL22jKVWgUKuuarw4HLpJ8ydO6ksSq
         57KQ==
X-Gm-Message-State: AC+VfDx3gwr/xMYVFQrRytclrbUDzV0aJue3T6RHmmp43CJyh83XMCQR
	cXRp6AFGiC0atmCOsZh8QW8sjQV3J/c6Xg==
X-Google-Smtp-Source: ACHHUZ7gS22vXEv21IXlncE6aDe6aUVUmvqh3hW/YiKbXp1tpZ1/NtIExOx6xH4bsFeKVRu9ets8iK6Pr2eRRw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d3c8:0:b0:bac:adb8:a605 with SMTP id
 e191-20020a25d3c8000000b00bacadb8a605mr1862654ybf.2.1687362218977; Wed, 21
 Jun 2023 08:43:38 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:43:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230621154337.1668594-1-edumazet@google.com>
Subject: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reported a possible deadlock in netlink_set_err() [1]

A similar issue was fixed in commit 1d482e666b8e ("netlink: disable IRQs
for netlink_lock_table()") in netlink_lock_table()

This patch adds IRQ safety to netlink_set_err() and __netlink_diag_dump()
which were not covered by cited commit.

[1]

WARNING: possible irq lock inversion dependency detected
6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted

syz-executor.2/23011 just changed the state of lock:
ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (&local->queue_stop_reason_lock){..-.}-{2:2}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(nl_table_lock);
                               local_irq_disable();
                               lock(&local->queue_stop_reason_lock);
                               lock(nl_table_lock);
  <Interrupt>
    lock(&local->queue_stop_reason_lock);

 *** DEADLOCK ***

Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()")
Reported-by: syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=a7d200a347f912723e5c
Link: https://lore.kernel.org/netdev/000000000000e38d1605fea5747e@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Johannes Berg <johannes.berg@intel.com>
---
 net/netlink/af_netlink.c | 5 +++--
 net/netlink/diag.c       | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 3a1e0fd5bf149c3ece9e0f004107efe149e3f2c3..5968b6450d828a52a3990d18ea597687ab03170e 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1600,6 +1600,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 {
 	struct netlink_set_err_data info;
+	unsigned long flags;
 	struct sock *sk;
 	int ret = 0;
 
@@ -1609,12 +1610,12 @@ int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 	/* sk->sk_err wants a positive error value */
 	info.code = -code;
 
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 
 	sk_for_each_bound(sk, &nl_table[ssk->sk_protocol].mc_list)
 		ret += do_one_set_err(sk, &info);
 
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(netlink_set_err);
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index c6255eac305c7b64f6e00f10d3bf8cf42c680c15..4143b2ea4195aeacbd4eb828430c836cfb79d859 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -94,6 +94,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	struct net *net = sock_net(skb->sk);
 	struct netlink_diag_req *req;
 	struct netlink_sock *nlsk;
+	unsigned long flags;
 	struct sock *sk;
 	int num = 2;
 	int ret = 0;
@@ -152,7 +153,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	num++;
 
 mc_list:
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 	sk_for_each_bound(sk, &tbl->mc_list) {
 		if (sk_hashed(sk))
 			continue;
@@ -173,7 +174,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		}
 		num++;
 	}
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 
 done:
 	cb->args[0] = num;
-- 
2.41.0.178.g377b9f9a00-goog


