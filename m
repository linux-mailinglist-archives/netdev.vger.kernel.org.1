Return-Path: <netdev+bounces-26880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D027793DE
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF23328033B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26CF1170A;
	Fri, 11 Aug 2023 15:59:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFD11708
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:59:01 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8565430E7
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so1898082f8f.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769536; x=1692374336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+XgaLGpUVP+G9qnOB0ZNXJDWKPyu+7aNgrOOBV4CXs=;
        b=Wge3t0yMVuay4tm8zdBQ9VyeL6OLJAnYtN8V9iwiqU8TvRM5ND9ERv/8i2Y0FArvFQ
         tyG+3O1nerD6rcqBCbg2Yxi/GEjlgN0VeHNCzZWoK8KmI2UeXphNC4ct39rAWNHhOq6n
         g3MxOHl1F/R3iVZaFvULiNeXrTd5HPlV4+zO97TksYClBrDGyBmm4kRFzTQccpHZLLyG
         jXFYRE99H23TempgCoan3vs01e8+KRWka4tBP479RADB9zjrIIFJ64LnP/2iwPPymaWX
         OkJg6VAAsx3QO7crW4QlH020KhacJUh6CmeEv8xlivqVhmJYQ7RUE1o45BE134rD1wev
         Scgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769536; x=1692374336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+XgaLGpUVP+G9qnOB0ZNXJDWKPyu+7aNgrOOBV4CXs=;
        b=FeoDVyJ5mxRhRxWWXa5+OrUuU4eYnEFYxsvhq8+qQwEs/vWvB41b0HsffSWK+zDQZy
         FOH9S3aD2GBuLSCV+r7i4XdCcHySQ5ZD8GxFIUxV51dI3O4/9by/1hmpxi8QPrTF0WsW
         0ufjRpp8JtoGzzkcnV4A0sVbqC57SIyQDKnv0wo4FNAnibpwLE2kKqOIbCEPn0ZYwPMh
         L+GTub7pFocidnwtU2yDlrSXRkKK85/K4omGZDkYkg2OMFHChbDt5ZXQWTKvFvCdTWRD
         k/gsNJHhXgwmRDnnT35XprsEtcCmxc6mNu6Au3E+vL25HCKLaCtOQ1Fwts5H4bTfVLjM
         8cNg==
X-Gm-Message-State: AOJu0Ywao3+EwHgUC+bu3r99dShUr9zWBB/qQJ/nrgi9I8wsFktT1SKI
	ZuQ2352l2DBMpQev47bfHJZSFA==
X-Google-Smtp-Source: AGHT+IH+uijgDdhfb4MCBOghDLHl+5AuYsKXMZMFSQo58jr8ReplmmJKvjmkcb9cb2D4E1oZaQweCQ==
X-Received: by 2002:adf:dccd:0:b0:317:5a9b:fcec with SMTP id x13-20020adfdccd000000b003175a9bfcecmr1553679wrm.14.1691769536025;
        Fri, 11 Aug 2023 08:58:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:55 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:27 +0200
Subject: [PATCH net-next 14/14] mptcp: Remove unnecessary test for
 __mptcp_init_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-14-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=9eUzQsTH9C4lw0Wrk8AIKRJ6c0bqe3QPvYFbn9S2V3Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqwU7yF3k2xiGkkBmwynf1c4Z1lknA9Khwon
 buB7uDg15eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZasAAKCRD2t4JPQmmg
 c53oD/9Cm0tzdEzZtSh2bD4u/FrbdFha+H7oI7jW05zlpsFeQAA3EQLy5H58wxt8lTY6tbB3ENZ
 MHZa6zrGYtWnVl3BEO8/JPEa1wSXa2BT+Ke/fk2NRWhHV8w/7w426oiEurwvMZgpU2U/l6rlpFi
 3vRvAO8KgA1CDraah31q+rj0LD40A//lSUC5rcG/XtrqIduqvyo/Mb0+sqQ66guhuzAPYRGj1Qk
 3A0OAwr9kMd6ie34lrH4wle2YQnZku78y5+KjTPgKR3/m+tdn4AtwdqvsGHZsxjwRf9GwgUeXsU
 jkwWJSEN5bHVOChix6B/qGM8ziHaGa+Icc23/wR1ZMBRfhzD6i5NuljgtALxngwomGPkaMHZUCy
 7pgM497BTMGffB7C7NPkHSuYmykvz+xAlJgcTLgLL83dweYf6NoFvRgie/vjHwBc4m+MooOJhZy
 jdGsO7K8gEB94e6a34UTYdtZAtiyUABk/qr2KYHzdU4zdOT05/7V14EJZRXdR8ZT8CakcEBP7XG
 fJdRjfUt7lnMcpGT5hKYMGqP8ZSmkTY4SN+j7kE0/8jNzYkifmuiSgp773MGvtbrDf0ONREBNBL
 Hr6lp1QGjLPxsdtKiHaEbI4NW5pl3ZmwlvQ5wKs80e9cM2+PJFX6+1Dn20Xdx8e3wrDIPF8dXbk
 eqm6CsASm8so4Og==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kuniyuki Iwashima <kuniyu@amazon.com>

__mptcp_init_sock() always returns 0 because mptcp_init_sock() used
to return the value directly.

But after commit 18b683bff89d ("mptcp: queue data for mptcp level
retransmission"), __mptcp_init_sock() need not return value anymore.

Let's remove the unnecessary test for __mptcp_init_sock() and make
it return void.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e715771ded7c..6ea0a1da8068 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2649,7 +2649,7 @@ static void mptcp_worker(struct work_struct *work)
 	sock_put(sk);
 }
 
-static int __mptcp_init_sock(struct sock *sk)
+static void __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
@@ -2676,8 +2676,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
-
-	return 0;
 }
 
 static void mptcp_ca_reset(struct sock *sk)
@@ -2695,11 +2693,8 @@ static void mptcp_ca_reset(struct sock *sk)
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
-	int ret;
 
-	ret = __mptcp_init_sock(sk);
-	if (ret)
-		return ret;
+	__mptcp_init_sock(sk);
 
 	if (!mptcp_is_enabled(net))
 		return -ENOPROTOOPT;

-- 
2.40.1


