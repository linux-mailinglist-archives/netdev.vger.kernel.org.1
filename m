Return-Path: <netdev+bounces-56459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B980EF67
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270271F214F9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD0745E0;
	Tue, 12 Dec 2023 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJbBhVV9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A67ED
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 06:55:53 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1b2153ba1so49078967b3.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 06:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702392952; x=1702997752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7rLdS3DdixJrv3ZBmVRiErlPRp5xsbOeyrzK+E5VPtA=;
        b=LJbBhVV9aGrbjt10N9vw/gGLNtqiwHGqKKANn7RBOHQgM5d4DrFR3dY8pM7TecvfRK
         A837/sUhOWPq3Cg6zwqZpJ959jdK761WAg/Et87XG6ZjP4WmendsXFO6NqLcLbzH5z1/
         WKWQTXXsemfXevhvyRavI9vBhIgiqq6F0Jo9HqnfBl3rdW3gjjgHNVhxT7j5KGKheEVm
         kVfdQNDTvtwzlgkgIwh4nKCtWAihioY1G5CtstwQ0uKCoon87dDcDU4/QjYKiovN2bb7
         ZXpBi0z8mnoCHwdlTpQkJhn6pqU4GyjEIiCej885tnhwlvDlqedf7ow4t0S7EslfAuAG
         k3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702392952; x=1702997752;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rLdS3DdixJrv3ZBmVRiErlPRp5xsbOeyrzK+E5VPtA=;
        b=Yt18CZ6o2BOdSpB6bvCxo7efEk7cxZPHbrYUHhdLkCwlalBtjuzbuFmF96h0byNOVc
         lCk5T6FsUSm5n/jwBgpeFd2Hg8FhUda/XXEwdBIPUQNqZxRwJ+bESK6szUAqsenq9ES6
         7T3wjzKiMgW+FwK0PMvL6wHeqhENkRGUgiI1ko+hvkV1+FGtJdLA0QtCTDmSnGpRKMjP
         ywf4Jc4/eYX/MElwxLcauE0obd66AX5BXmP4YdcIVs4f4T2Ysl7OSkteVUtmB839CvVj
         o2maGfl86+z309Ne4MZ0Iu832dEjU3J6WytmWN0r7jOVahBiMf9SHMxaIsJIb/3zVclZ
         8qRQ==
X-Gm-Message-State: AOJu0YxaZrcglc7Z3tdIkDNPuei4d1RMafh3qX2m9/ofPLbNC6pbvQ05
	2DItGp23HBoI/PTTzJNXpXI940jSshfbzA==
X-Google-Smtp-Source: AGHT+IEX+VOBlwmznBQ9L/oGuRDL1FPdLaYQ0+5I5XGLSwCz6Vr8VzJGrPg7jSaFizkEQlYKqApJ/C/mlmf94w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d0cb:0:b0:db5:47bd:8b14 with SMTP id
 h194-20020a25d0cb000000b00db547bd8b14mr46464ybg.4.1702392952591; Tue, 12 Dec
 2023 06:55:52 -0800 (PST)
Date: Tue, 12 Dec 2023 14:55:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212145550.3872051-1-edumazet@google.com>
Subject: [PATCH net-next] sctp: support MSG_ERRQUEUE flag in recvmsg()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

For some reason sctp_poll() generates EPOLLERR if sk->sk_error_queue
is not empty but recvmsg() can not drain the error queue yet.

This is needed to better support timestamping.

I had to export inet_recv_error(), since sctp
can be compiled as a module.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/af_inet.c | 1 +
 net/sctp/socket.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index fbeacf04dbf3744e5888360e0b74bf6f70ff214f..835f4f9d98d25559fb8965a7531c6863448a55c2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1633,6 +1633,7 @@ int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 #endif
 	return -EINVAL;
 }
+EXPORT_SYMBOL(inet_recv_error);
 
 int inet_gro_complete(struct sk_buff *skb, int nhoff)
 {
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 7f89e43154c091f6f7a3c995c1ba8abb62a8e767..5fb02bbb4b349ef9ab9c2790cccb30fb4c4e897c 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2099,6 +2099,9 @@ static int sctp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	pr_debug("%s: sk:%p, msghdr:%p, len:%zd, flags:0x%x, addr_len:%p)\n",
 		 __func__, sk, msg, len, flags, addr_len);
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+
 	lock_sock(sk);
 
 	if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
-- 
2.43.0.472.g3155946c3a-goog


