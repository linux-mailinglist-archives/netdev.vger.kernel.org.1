Return-Path: <netdev+bounces-26872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D17793CA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6359E28242E
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54385360EC;
	Fri, 11 Aug 2023 15:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCD360E0
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:58:49 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F60C30D5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3178dd771ceso1940264f8f.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769526; x=1692374326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1qLyx2LWnWiVDIicSTKWPLIL8cOkrsv9pt//BNBZb0=;
        b=5CwpXuyc3e6V3L5gpSouGk49Q1W6jcHqBw2n3JRh5rxeWROc6RP0WMlI3du/myOPmQ
         puaHwGDQzngqlZqsTSl1AJYZUARvyusyNSZDnqqD1G+WkC9kGhL8KS23G/vKMnSFqtwF
         F7MlilSG9CMyFf736o5zzpNvtmnNjorFEFiCknqz0CAvpOrI22/K2lxvHZ1CR6j+I2+t
         yBytN7X3CaMJrgOdnRU2O2C22RMQItsSHTeRNPSD0lvTGaiImWpKjiAnX20Hp52EsKSY
         3DaEGNExNcg6Z7Vlnqz+wkuSz9nMG/BL4BntoOh1gFyKMzX2YJIMAH4O1xD/GWyWse9y
         j+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769526; x=1692374326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1qLyx2LWnWiVDIicSTKWPLIL8cOkrsv9pt//BNBZb0=;
        b=ZqHivWtvkOeGKQRpnAeCvr/f2BUHm02xQj+tdFuUEKwCQg2rvwlxMmkaEci/eYsKTX
         X1qvgi0Kqs2BeXL5qk/uxinLirEXhlDOI455gLcjUoiVSoptt2e7rO8bFf1fbq6BNr6J
         TsyDfPtT460kynz/H+6VxjmMFsDjl9ESmx7vo3sSDPMMeCkoFIJtz3R87kx1edWifQhA
         Rmh402owaIi1YiqDY22ptlTCy0Ea4ygWUrFc5FFET0F6Rz7v1mRGtwajVqm+Eu5mchdM
         inyN0Exn2ZZ88OJGiSjwf4WT31qqzKn54JRsw4JY7hlAViNvZK95oNr4WhURo7qGvLv0
         f3ug==
X-Gm-Message-State: AOJu0YyHkkhZvhz19le71eQ2Iao49wox5sMf605+1NOEWIy0hvLcNrhi
	/RmCSX5OYIA/oH+sxCc2mkR2OA==
X-Google-Smtp-Source: AGHT+IGO2ZGpfasS5e61DzCME3nhIJa+sQZctwadJVKZRETnlnDPmN8+cX+ArLQaMqp76/LqKTpriA==
X-Received: by 2002:a5d:4ecf:0:b0:317:5f04:bc00 with SMTP id s15-20020a5d4ecf000000b003175f04bc00mr1863528wrv.27.1691769526605;
        Fri, 11 Aug 2023 08:58:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:46 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:19 +0200
Subject: [PATCH net-next 06/14] net: factor out __inet_listen_sk() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-6-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=bTkRYVwJ7Bz5xqxHF7Zx1jU11iINDUJMHCOsJN7EE2Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvWJ+40gT5DCRm0wzA6GWW71En1AJiVIL0q
 cyGXtBLMdWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c5E8EACO1BlTw3jWXRxMGk/AGNAJ7LKBgy2u6pKDc2BZIqqPhyn6pLcNgjgTXPkhX5zmfRAUkjf
 2H2t2dQ7K2uYYZaCEbHDQgyD8CXdVZbJGXgt/oOY59A6QeBNd0ZMsp5PcFv0hhnGgHp5On4nume
 7zQt1bR3lJBlXN2t6pFywGTU8LuMn+bakwUL8yv3rK0OfPRfhmjpkB2koU0MsvifsZt8a2JY1Fy
 vH6A6mQ8NVO6NOpcQhIFJHYODBvCOz9e7z5l7l7woFiZ7Yp7GTI5qY7CKvWk7pdexEC9M7Fph9M
 2akdXXS50JCWa77DG5ox2ae+Ud/hASytOKywNgXRZm5vS/3IJxsOpDpFxRAq/9C0pf1hHmDPsrC
 Ip7l70RMDt9bXvYsKCESV7EZpL3Uv/CvIRH06FUjngzMLZ+/kWZVRDJtWUgUpVK6+pxMSg9dD8Z
 DVc+Id57OLi/QXArLKIVja84CNuwy5AK3IdL9im85QqqDNVXT3C4td4aaeS6KP7mUWxvTeCfRzR
 5Mdv1YvILBTAqgV0kFvcisFNzZZ8QRHrxWx2FOm1X9Y8tJ0cLYROhjJprdMtz7lMWa1aytvSGo8
 R0XhXB9M/Y31n9yFOzHHpCHNits6YehkcrYWjz9Q2Nuyem1eaYlP+9NfxNNS6rnw4XzLJbFNsEl
 uEXsD8ZExbvWA9Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

The mptcp protocol maintains an additional socket just to easily
invoke a few stream operations on the first subflow. One of them
is inet_listen().

Factor out an helper operating directly on the (locked) struct sock,
to allow get rid of the above dependency in the next patch without
duplicating the existing code.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/net/inet_common.h |  1 +
 net/ipv4/af_inet.c        | 38 ++++++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 8e97de700991..f50a644d87a9 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -40,6 +40,7 @@ int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags);
 int inet_shutdown(struct socket *sock, int how);
 int inet_listen(struct socket *sock, int backlog);
+int __inet_listen_sk(struct sock *sk, int backlog);
 void inet_sock_destruct(struct sock *sk);
 int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
 int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 2fd23437c1d2..c59da65f19d2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -187,24 +187,13 @@ static int inet_autobind(struct sock *sk)
 	return 0;
 }
 
-/*
- *	Move a socket into listening state.
- */
-int inet_listen(struct socket *sock, int backlog)
+int __inet_listen_sk(struct sock *sk, int backlog)
 {
-	struct sock *sk = sock->sk;
-	unsigned char old_state;
+	unsigned char old_state = sk->sk_state;
 	int err, tcp_fastopen;
 
-	lock_sock(sk);
-
-	err = -EINVAL;
-	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
-		goto out;
-
-	old_state = sk->sk_state;
 	if (!((1 << old_state) & (TCPF_CLOSE | TCPF_LISTEN)))
-		goto out;
+		return -EINVAL;
 
 	WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
 	/* Really, if the socket is already in listen state
@@ -227,10 +216,27 @@ int inet_listen(struct socket *sock, int backlog)
 
 		err = inet_csk_listen_start(sk);
 		if (err)
-			goto out;
+			return err;
+
 		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
 	}
-	err = 0;
+	return 0;
+}
+
+/*
+ *	Move a socket into listening state.
+ */
+int inet_listen(struct socket *sock, int backlog)
+{
+	struct sock *sk = sock->sk;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+
+	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
+		goto out;
+
+	err = __inet_listen_sk(sk, backlog);
 
 out:
 	release_sock(sk);

-- 
2.40.1


