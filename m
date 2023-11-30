Return-Path: <netdev+bounces-52657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1A37FF9A4
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB511C20CAA
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502254789;
	Thu, 30 Nov 2023 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnyWOsU7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4DD94
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:41:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daf702bde7eso1664951276.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701369697; x=1701974497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIh6zrFBIlQ3nP2zqzfNyGT+T1QeQmGkB/lwQO09/2U=;
        b=rnyWOsU7igIVeV7h7o9IQ5KHVTLUrv9fzyLNXio7/CoAP0UDSvtbg5l+NIg9uy4VHN
         m2q6oUr5nrTsdTlof+WfIa2NAuJ9MEkUk4VKiUtyRZ/kkvwIANpXTWywqTzRd0Arro9t
         9IlWhi98gD9bZxA7S0UuVrv1KlKqMDo/zbzztLgWmRn0DDFrTYu+A991EXHHWNo1tQOl
         DyIGdAtF163rryzVVDhjBwg8R6ljmhR8UalWlWGtrMVXizKnkLDQNzyJOI5Z+38iUCME
         xlugWkno2WN+YmKypNUbvVY39+iPmypEiSPIkijT0azRsuQuBi9Mn97QxnKdBrgO37nV
         dKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369697; x=1701974497;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIh6zrFBIlQ3nP2zqzfNyGT+T1QeQmGkB/lwQO09/2U=;
        b=VO2eQ91CVZG3fVauxev2OH33ya2qrElHdTZHnWueF68CfBiJThGAed6QIEZDytnS0s
         TOR9t4QCOpZVfihyEeqKEQf/TSs5Rt4Aj6+XBHan1HoKCDZ67nt23PNe4YhM5ABX5mPW
         u6ihevaGA9wscxjNVirFBvSVyvneF7n6N5f7jjPsmnZWfTdcpUrLRtRSd2zw/3Ngi2t7
         YAKPg/ZQ8IcemoO/ZyfHRiOlWb/NQNA1hoBx5csb7K45Yw6Is/WhAEEaUDDMWT6KgX51
         6/EIDvpK/avJpAhrqqlQ8W+7Se81hp9v8mLBDqYZGc1PgtMyhpfsWZBTzQnvrnuSthAF
         9i2g==
X-Gm-Message-State: AOJu0YwgV1T3RSu82DnwbiFxII/udzRfczDAsv9rLm/p+Jqp3lvrMXEg
	bzx0f21ZH9pb4dtxC9pa/prDRbK3nAYrdA==
X-Google-Smtp-Source: AGHT+IF2REsRUaORgplxf9tuEKm/PzWtNmhJTmic1jNWbcbqLMifrMyqw26KZVU106XpqaJUqLK0yiR6biF03A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:3055:0:b0:da0:3117:f35 with SMTP id
 w82-20020a253055000000b00da031170f35mr690568ybw.3.1701369696965; Thu, 30 Nov
 2023 10:41:36 -0800 (PST)
Date: Thu, 30 Nov 2023 18:41:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130184135.4130860-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: tcp_gro_dev_warn() cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use DO_ONCE_LITE_IF() and __cold attribute to put tcp_gro_dev_warn()
out of line.

This also allows the message to be printed again after a
"echo 1 > /sys/kernel/debug/clear_warn_once"

Also add a READ_ONCE() when reading device mtu, as it could
be changed concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c5213f0095613124d5193b15b2793..cd57c2552ac7d5ed799f06e2241691c36da5022e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -202,23 +202,17 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 }
 #endif
 
-static void tcp_gro_dev_warn(struct sock *sk, const struct sk_buff *skb,
+static __cold void tcp_gro_dev_warn(const struct sock *sk, const struct sk_buff *skb,
 			     unsigned int len)
 {
-	static bool __once __read_mostly;
+	struct net_device *dev;
 
-	if (!__once) {
-		struct net_device *dev;
-
-		__once = true;
-
-		rcu_read_lock();
-		dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
-		if (!dev || len >= dev->mtu)
-			pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised.\n",
-				dev ? dev->name : "Unknown driver");
-		rcu_read_unlock();
-	}
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
+	if (!dev || len >= READ_ONCE(dev->mtu))
+		pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised.\n",
+			dev ? dev->name : "Unknown driver");
+	rcu_read_unlock();
 }
 
 /* Adapt the MSS value used to make delayed ack decision to the
@@ -250,9 +244,8 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		icsk->icsk_ack.rcv_mss = min_t(unsigned int, len,
 					       tcp_sk(sk)->advmss);
 		/* Account for possibly-removed options */
-		if (unlikely(len > icsk->icsk_ack.rcv_mss +
-				   MAX_TCP_OPTION_SPACE))
-			tcp_gro_dev_warn(sk, skb, len);
+		DO_ONCE_LITE_IF(len > icsk->icsk_ack.rcv_mss + MAX_TCP_OPTION_SPACE,
+				tcp_gro_dev_warn, sk, skb, len);
 		/* If the skb has a len of exactly 1*MSS and has the PSH bit
 		 * set then it is likely the end of an application write. So
 		 * more data may not be arriving soon, and yet the data sender
-- 
2.43.0.rc1.413.gea7ed67945-goog


