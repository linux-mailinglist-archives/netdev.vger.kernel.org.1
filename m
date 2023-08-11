Return-Path: <netdev+bounces-26867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D737793BB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D29E2823D5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF62329AF;
	Fri, 11 Aug 2023 15:58:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A92AB42
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:58:45 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDAA30D5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31771bb4869so1945122f8f.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769522; x=1692374322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5X9dCBbAfU6DjT+NDvr2dXxeO/cfwiJDXtpifKgXlA=;
        b=AfNHOQJ2nkB4iLHU0XVMtVVb1UTnxAlXjmudsfmcOaORZaxOvRzrr6koOLBpjL69QQ
         tt9xfEhLwbWEL3B7zOiiJ3zwChgyoycobsJf7svUsEVpCMgPOLnp3DPZtSoOnpVwxKDb
         18FBd+zzEuVvYjyW1rujienvRQtSWWwKZMXGN6ZfK7/X3GRIsk4s6KKUq6Iiy26aWt6H
         gmoTwFWF9zbFCXa8wxuWHRN2D6xzLGJg8vmjzlFdVyvV9h2whRtMfhHnzPBSyY7yLkO4
         6CnTY9+d+D8b4YjvYmH8zjFo2tLhlqIO41WsVPYxWAyBdtCH2il3OvT08DS2+ywhFiiG
         HYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769522; x=1692374322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5X9dCBbAfU6DjT+NDvr2dXxeO/cfwiJDXtpifKgXlA=;
        b=idpsW4Jtb2HfevM6AYkxCKxDzL6ffx2oUbsXQqAxzbROQ2mhOdfBNJ52Km0vYcD4Ht
         d5zaODgqtefzGCrqYsspPiA5grnnE7ccMTSyHaLW0uFmMU4lDpvrt+ean4GsUPBK3p3+
         tPsqf5vh/zAreHiQSS08H8P2gf9BJaILi8EJNJ/TBrO7AqEsX69pwius39crE1ziZker
         YMvP4PxZAz8l5W2Bdky2jggRMZzsQAyNn4O9tpkW8bnBm9jJ5Wc4b/V2CeF7h3AFodu/
         TUwqf9g0VpxB9bDBI8oXLvFRqi4IHvGorxVyZMBb3ov0Q3vT0rRhn4bVPhitMtIO0CDE
         rQpw==
X-Gm-Message-State: AOJu0Yx3Dj6QL7Tu+id/3hWT6ev1WrC8D7ArwJjTGdbmVKWPtheut8FK
	RYB6djDoiVyJ927B22AhUANUPg==
X-Google-Smtp-Source: AGHT+IGSD4ePtHDWsMuK7XQNepQL96MNQFK7TtCmw2t1Syvy1CL8jN95/AgxPjnyyfqTQtK9EQ0vVw==
X-Received: by 2002:adf:fc0f:0:b0:314:3a3d:5d1f with SMTP id i15-20020adffc0f000000b003143a3d5d1fmr1851910wrr.19.1691769521953;
        Fri, 11 Aug 2023 08:58:41 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:41 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:14 +0200
Subject: [PATCH net-next 01/14] mptcp: avoid unneeded mptcp_token_destroy()
 calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-1-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=gXoRie7DLKf3vWVejVmTZfC//Kg+jCDe1+Txjp6fEyI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqv+r3KsHtF8v8Wo26pcmdkgVeFoZMKt2vnr
 HOE8E3VCBeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c5hhD/0c8KK8DF9+DihPAJVsBCw7OJK4Qsqj2v1GgkbmoYkVV/vFyweuzcYBNmZTwHt0Su6nykO
 yTlwWPLLzZhhIAXBOXbC3XB7d2jkyS3h2pqF/9NcTWo8weFJ8uSMbNlAe7PnjeMAIpzPkJrEK8H
 4YkzZK9+ntc2MMMzT73WfsF5iC+FruQYPx/OhwC6yAEVeJ23v5qxEJJojrDZJN+x51fFdQdJNF/
 QvsWBAWSLqAXLxy+4Ds9b8q8FMkIXKXIaws85ymRXZ/94L20W9rPdHHljK1Ek1hYlHbD8LJNcxO
 No80OBKqkrAXLp3LEsaADiPDGyDQSMeaWkRjFZlSj7dybAooRafbK8PZ1Da3GUJsR3Iv8cbj+9O
 cjhYtxdA6xrGd7MsTFO2pwlVGHp3NCJQyIyqoQFgpjflevMdPrfX/1kA0i/dioxVacgWg8/5uLO
 5S0HrjyyGNyngounFXMI4f4Lsouhe0X+DgUcSLMUqyEb+Dpt3XyyIh+nZDOFc9Ivvi1pzkGYovL
 fLLChmmsbzNCGm4exod+n3UvNvo6upaYtM9NJqaT8A7u8XfsWA9bbICQ2IVtU1htskbe1U0L1Bn
 Qyhhfb59KB54aTJX647M05snl4oFlidlaSmSjVcMZKw2963aE61PrSJtRdVXw2g/wzH2L6b4HFU
 8k5iDsBxKuQShNg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol currently clears the msk token both at connect() and
listen() time. That is needed to deal with failing connect() calls that
can create a new token while leaving the sk in TCP_CLOSE,SS_UNCONNECTED
status and thus allowing later connect() and/or listen() calls.

Let's deal with such failures explicitly, cleaning the token in a timely
manner and avoid the confusing early mptcp_token_destroy().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48e649fe2360..abb310548c37 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3594,7 +3594,6 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 
-	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 #ifdef CONFIG_TCP_MD5SIG
@@ -3624,6 +3623,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 * subflow_finish_connect()
 	 */
 	if (unlikely(err && err != -EINPROGRESS)) {
+		/* avoid leaving a dangling token in an unconnected socket */
+		mptcp_token_destroy(msk);
 		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
 		return err;
 	}
@@ -3713,7 +3714,6 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
-	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 

-- 
2.40.1


