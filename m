Return-Path: <netdev+bounces-26873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D387793CD
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D591C21723
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71C360F7;
	Fri, 11 Aug 2023 15:58:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377F34CDD
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:58:49 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C5730DA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317798b359aso1884046f8f.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769527; x=1692374327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyRx/lqS+isYchr9XgPLMFHBFRIijA0curLoMvnrLXI=;
        b=A4x7JHBFtN/v8rQSnnmwXaQxQTM977zx8b5onDqAtC+l9kHCtn/C8+sQOS8LRmmfgR
         d1DCu1MVk4eeOTT9Q4gsBGPdbSEOvESuLPp0Q2NQJN/7Eg/EkPG87mrn4lFVIrN2q1qk
         vFxh+WcOIlgOVs2nkW24Y9a1Qg4/y6nr5isopIgjw74w5mQabIO1LHWXoDVqgAOraLlU
         lgbJos7nlJM4hpQXti3OzEvwtX+X+sE5V4gHyn5/wEB65e2jFrucBCuyVVZja7IVSEE2
         oS0QSjgnoeOTfoL0+J23cW5hS+q0Q2WJmKFNMaYM42XWJ1UKxNDyU6UcaspQx/xWGQYp
         HmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769527; x=1692374327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyRx/lqS+isYchr9XgPLMFHBFRIijA0curLoMvnrLXI=;
        b=UXPsPP/O8KEJjmiEEgZgkWZQ43CxR5Hl58u0v0YL8xOsPKIALdKY6izBRuPEudEYHd
         VQiLTcLmTbd7FNfVXE/vwyCxgiJNy8dUasNWpDVfa2u17lWTB592eopgbu+MJ2QAiCZq
         boJC86yldHidfcxZNg55B9pRn00YaRbTHiMmMrQlBk5kcTOudFvJo+sYR4VcaJ4GlWsy
         LuShah33GZP++PIH0Ad4h/cwRCoJmGuJga+Ef0XVRKY2i0pwCT8CmYYhqxB2/wkrFQLB
         X37vxNBjiDu5oKnartpVBDi2ZiQtx8upGR+tKdT9vfoqUyImylIrHMbuJbn2X5TIfYZ6
         a3cQ==
X-Gm-Message-State: AOJu0YwNJnMUy8MKiWnx1zN+pe01DQ/WswaB/Pr+z3eXJwUDOZf7dOhe
	8Gu6YiuMMPp3lCP67y7HGBL0iA==
X-Google-Smtp-Source: AGHT+IFZ0atisWKPvBjtYJDx96JtPWXfkTzMHwNbYsicETFEqF/de2pxA3IOn8IiCi9B7L2N06u4ww==
X-Received: by 2002:adf:fcce:0:b0:316:fc63:dfed with SMTP id f14-20020adffcce000000b00316fc63dfedmr1705179wrs.39.1691769527592;
        Fri, 11 Aug 2023 08:58:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:47 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:20 +0200
Subject: [PATCH net-next 07/14] mptcp: avoid additional indirection in
 mptcp_listen()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-7-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1668;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=uGv0GZryGFtqDT83EYsbNMTqvKrHGPnUvPWP7zmvWRc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvJSlkomXuEhk3T8qOlOZZYYOSwumgYgTcj
 lJMdiQ9JlmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c0SQD/9RvknM07vU2B7bycJBkHsghFJbpbcj/egc4zS2Q4FbOtFZ+n4uytsZjFaFu0fEXHdmwM4
 fF75/DI2RsOcGg8d4Nu0RGM8yRu8gPBRZQIC+H45/7ld2tN6qZsSBd8ZAnxhlX2z4N0KuKaV5J7
 u5EdlH5ubNE3tvGauOZzlaSDhugejcC9fSmjDz6sOxirfdGIrJKrftVKU3JekZJQMGW65B8kZYG
 gcM5+lUWNoNT/91bH7ti6qe4rcP8fxMTzX9OTflHVmM+DqWuZ/iO41mCrnVu6RgZBqhrnRiLveX
 CqP3x2VJBgzSHAfXaz9caEESzKNm+GKtJcXlfbMaPtqpYmB69rI+jU+eGrOe6fIozUw/3HN85pT
 Rrvp9jjK6CDlb1CRXIRgV3S7Pn7pwSnYayeRN0m2Eu7izBY4VCzI1GH3Rice8+oljgIp4tmxfYO
 EJ74fsybfqn7ARd7WSs0jIqJ/zNA74edhHrm5FUSMKGG1F9rUQimn3BN6DZpm9YMd46vwDXr43S
 bM/QR1Q1QxZB4rgdGoJbR460fXqhD36Yq8ldZH5P9edz8ze5ZgfcGxBxGei//TEUwKvZx2O6Q8Q
 QJiGDSkqYnJxlMvJMNJxkOizkDt7+zGPbtl4LAyqwzNVUt2IjMTBdbew5hj6ZhrenvBcqFf2tqd
 Q601hSoSt8x2g5Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

We are going to remove the first subflow socket soon, so avoid
the additional indirection via at listen() time. Instead call
directly the recently introduced helper on the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5b4d6f0628a7..d8b75fbc4f24 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3720,6 +3720,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct socket *ssock;
+	struct sock *ssk;
 	int err;
 
 	pr_debug("msk=%p", msk);
@@ -3736,15 +3737,19 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
+	ssk = msk->first;
 	inet_sk_state_store(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
-	err = READ_ONCE(ssock->ops)->listen(ssock, backlog);
-	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
+	lock_sock(ssk);
+	err = __inet_listen_sk(ssk, backlog);
+	release_sock(ssk);
+	inet_sk_state_store(sk, inet_sk_state_load(ssk));
+
 	if (!err) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
-		mptcp_copy_inaddrs(sk, ssock->sk);
-		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+		mptcp_copy_inaddrs(sk, ssk);
+		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
 	}
 
 unlock:

-- 
2.40.1


