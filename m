Return-Path: <netdev+bounces-143570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2D89C3033
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 01:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C0E1C20BA1
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 00:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F470BE4F;
	Sun, 10 Nov 2024 00:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FB946F
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731200383; cv=none; b=jFZ5yFCYMIxTDAQFoXubOW81XqeJneKI5SUnLhNsR0vv7U9QUxBZ36qXyGylFwqDVKpyQKzQu6hRQ1V6TTQb707vvk+x6hDzfgmmVNjLY05vjLW7UZTBhBkxXUk8jhDZ8lQNkhJa9AzxjBpRQmLdaEO+rMB7+qI7oqxUfrR7L7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731200383; c=relaxed/simple;
	bh=qpD86/NheXWYIaioiY2D4CJ8Rxyk39jkfGhTyLLOIzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LcNOLmQiosETv08gbuziIGENHU7zeMZ49S2zonRIFnlggOywxG1Jq3HMvqZQZ/PzXmrYn5Bnaf4HAtT0PcbUQPAs+JTottSuVOjAYQKeyEcfIAuQpzdIB9HRr/XiImEEqp1F2aFCtGId2pXg9b6MT8YJKEePkJ+bUsuGwY1yJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so5613201e87.2
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 16:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731200380; x=1731805180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MguorYkV5Mjw/NVj/J/xnsKyFDdBwvG6wgkxCAvHz9U=;
        b=iSNKwKgmH/gpA2kDW2hRLMc2/rDV2Hu80UQyFroWXQhbYhl0LBch0O1iBiZBs66Eh0
         mYr28/FRps0pQKhWToPZhIZndPSBBU4dp20JYLwztNqzLC9EP8+uHXRTjd+fMWg+r8jF
         luhKkkrmj8QgH2EbERO0Id0j5hyRDsbyG2n2asyxXeHIxWrkiKQKMrXuwEcE4cDJz/H+
         sndOka02O/wuiZNdCfFe7wASrD+nJez/dfj2cqnN9qUnZ2CuI/PVGvTj9oRpacPhCH7O
         mPhUKUK83RKRa5guDUCoRFhwNTfNtSO5w0rtF/v21boe1KXCpnLZVOsH23ZIwGXuqfjv
         zTTw==
X-Gm-Message-State: AOJu0YxVqIPh4ykQPm4vE+YJUQgLGuCd5gvk0w1rEe3JtWvh+fVPxYUd
	hmH9chuEg8TpBtq+khybjMrVXbZekjZO4/kTri1/blPa1F7ERGILDo/Ul266
X-Google-Smtp-Source: AGHT+IFPsYyhX7bsqG20wdLem4QQaJ5Gq2bcUMXM3In0Yy6gnkXY/bjyw38XgHWAWOijYaT0Yuqqzg==
X-Received: by 2002:a05:6512:e8d:b0:53a:64:6818 with SMTP id 2adb3069b0e04-53d862f7d56mr4981606e87.47.1731200379304;
        Sat, 09 Nov 2024 16:59:39 -0800 (PST)
Received: from localhost.localdomain (c188-148-61-112.bredband.tele2.se. [188.148.61.112])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7334sm1052059e87.120.2024.11.09.16.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 16:59:38 -0800 (PST)
From: William@web.codeaurora.org, Mokhlef@web.codeaurora.org,
	wmokhlef@gmail.com
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	trivial@kernel.org,
	William Mokhlef <wmokhlef@gmail.com>
Subject: [PATCH net-next] net/unix: Stylistic changes in diag.c
Date: Sun, 10 Nov 2024 01:59:20 +0100
Message-ID: <20241110005927.30688-1-wmokhlef@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Mokhlef <wmokhlef@gmail.com>

Changes based on the script scripts/checkpatch.pl

Remove space after cast, blank line after declaration,
fixed brace style
---
 net/unix/diag.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index 9138af8b465e..94d4d273f7f4 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -94,8 +94,8 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 		rql.udiag_rqueue = skb_queue_len_lockless(&sk->sk_receive_queue);
 		rql.udiag_wqueue = sk->sk_max_ack_backlog;
 	} else {
-		rql.udiag_rqueue = (u32) unix_inq_len(sk);
-		rql.udiag_wqueue = (u32) unix_outq_len(sk);
+		rql.udiag_rqueue = (u32)unix_inq_len(sk);
+		rql.udiag_wqueue = (u32)unix_outq_len(sk);
 	}
 
 	return nla_put(nlskb, UNIX_DIAG_RQLEN, sizeof(rql), &rql);
@@ -105,6 +105,7 @@ static int sk_diag_dump_uid(struct sock *sk, struct sk_buff *nlskb,
 			    struct user_namespace *user_ns)
 {
 	uid_t uid = from_kuid_munged(user_ns, sock_i_uid(sk));
+
 	return nla_put(nlskb, UNIX_DIAG_UID, sizeof(uid_t), &uid);
 }
 
@@ -250,7 +251,7 @@ static int unix_diag_get_exact(struct sk_buff *in_skb,
 
 	sk = unix_lookup_by_ino(net, req->udiag_ino);
 	err = -ENOENT;
-	if (sk == NULL)
+	if (!sk)
 		goto out_nosk;
 
 	err = sock_diag_check_cookie(sk, req->udiag_cookie);
@@ -296,8 +297,9 @@ static int unix_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
 			.dump = unix_diag_dump,
 		};
 		return netlink_dump_start(sock_net(skb->sk)->diag_nlsk, skb, h, &c);
-	} else
+	} else {
 		return unix_diag_get_exact(skb, h, nlmsg_data(h));
+	}
 }
 
 static const struct sock_diag_handler unix_diag_handler = {
-- 
2.42.0


