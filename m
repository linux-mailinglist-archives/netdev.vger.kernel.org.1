Return-Path: <netdev+bounces-26868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C257793C2
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F292E1C21735
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A434CEE;
	Fri, 11 Aug 2023 15:58:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352742AB42
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:58:46 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E264430D7
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so3286147e87.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769523; x=1692374323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhePiwzsSx/PL85mddTkFwpXPwkG7Z75k06o+iuXV0A=;
        b=v1ebNHHM6M1mmtuZYCv9hRgIOkNvxHx2SBgalyfmwDZhrfEP9IFSEcEkc4TRnRuPDv
         Ao0uoh4HYY2as2H7y1J9ab6sbArcrdWg7SaIIeVQhpHhugrq2WkDi3Emdx/CbDhYrVBM
         D+lPAgyFcDqUpd2x8FeKuRbhvWnEgQaGpZCWhjB7Nwi+rIIhgoiueuPj5VE12UgA0dI0
         h3oYYd9MkdE1qfpUX72Aat2uQTVWut57m3OIDEvheqy/KjoG3gPPP9gnWHvbvLTR5cDr
         N8aKLr3ik3cVQ/ZjSY56pHpzWz4ou7/3bqoVW9jSxs1angf6mLpdQeVnNoc+8EJP1btk
         NF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769523; x=1692374323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhePiwzsSx/PL85mddTkFwpXPwkG7Z75k06o+iuXV0A=;
        b=YqN2FEhlLDdIeRhjxsVd+C2OUd4q0JHxOcN9NSIMiQ13Ud+wWCFPsqtHJ6Bd6QY2Wu
         xictxMBW9a3T4LVTcNYQAg0N0dBFtooJtZAb9vHavh5BQYkNsiJzdPsigjSM/Aw4I9Ez
         vH2vlfmsv1mlwtXHhGAdd31N0XdrC+6nSMYcLa6fBNeMl+Sh8MLneT7oJZFdLomITICJ
         YDWfNidgkJfcj1IPFvCs1I3PzFgwazqxGBct0gmfl3CFh/F8fu7DhmnxQMccIX7XUMdR
         /VAEQdJfVaZM5riPIWsnc9JYUW4YoCy7UEze9ji+uHoTsSaIhfmikyXaZd0qbUWv2ejD
         DZHA==
X-Gm-Message-State: AOJu0YyX4GcEncmsZXZWJ9I6iSR6q5cV7NQ/o/kafGF2OL45jTFGTGw9
	YnluceOvMkpYonc8timkR55qmA==
X-Google-Smtp-Source: AGHT+IEujOlzrfqvXdCg0+L8AtbpF7nTqrrFN85u705jORmwlIy3xMjlO1zC1yyK/tf3s2Jwb6Ap3Q==
X-Received: by 2002:a05:6512:308c:b0:4fe:8c1d:9e7b with SMTP id z12-20020a056512308c00b004fe8c1d9e7bmr2115985lfd.49.1691769522977;
        Fri, 11 Aug 2023 08:58:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:42 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:15 +0200
Subject: [PATCH net-next 02/14] mptcp: avoid additional
 __inet_stream_connect() call
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-2-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3783;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=9Qe781+27wzhv16vF50KO5HsGzkjYeuVU2/sb7jT8+c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqv5fFsBgTBTnGPQG9RVKTvL3RVK7VoW1/dY
 tAt+/hU8biJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c4sGEADj8+wJ8gLXhu4xLA3eshwVHpAUMPU6fl5G1adbkUaHa4ymSWx/xIIWUFc+BgqfFa4bUHA
 JZSHhjd5Ui/PTvxdKjznOkZlfpJJrXAke5riO8m2bkSLlAHIyh6YfaeXIZ4BqylD8FjjQi8fu/J
 Mi7HshwB5pwlR6mPcviJi8hiUV6ha9Txs/2nJ4l0uVpNw9i37VyzWW7N7S6MipOFkCiwmQrpnLo
 0Hf69GX16W8QNlyvUxNcBcZr2KilIWTIYAYN/LvyP0TmzCKSAaQqKPqXBRwcDxus7tn3BxmRHig
 aA4FJPpHoM5XRCz5EtPtH5NNKOWWcUrsTlhiWlfKwcGqdVZwM5yTeD2U/LvEcyC43MMhUsTsBk2
 KmM8E+oeTleZtGwTWAuD/dJjtY+KrW86S1iheFW9obk9GQIJNTK8SUzzRBhmF3hdpAZKQlMcNGc
 KZfbu0kd7uPFy6vaAtDtURGiU1YWRx0GT8SNcl4BxqzalwVQaS3oF0VdQkAE3yE7XC7u3kmDsBG
 XjrvyAU9j8Au9o0OtUEbvr8FST8dYjQdG8z/il7pD4pHB5FALIw5jnDpXLIFWRf91KIIZZQAQh6
 7XwvLCdlTkwdU3yeM4FvlDciFXTqzbUHmjQMzSh+n7cLweyaMLk6p0fdSDg138LeQLLqjXfAewy
 fztkK3c9TEI9XkQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

The mptcp protocol maintains an additional socket just to easily
invoke a few stream operations on the first subflow. One of them is
__inet_stream_connect().

We are going to remove the first subflow socket soon, so avoid
the additional indirection via at connect time, calling directly
into the sock-level connect() ops.

The sk-level connect never return -EINPROGRESS, cleanup the error
path accordingly. Additionally, the ssk status on error is always
TCP_CLOSE. Avoid unneeded access to the subflow sk state.

No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index abb310548c37..b888d6339c80 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3589,22 +3589,24 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct socket *ssock;
 	int err = -EINVAL;
+	struct sock *ssk;
 
 	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 
 	inet_sk_state_store(sk, TCP_SYN_SENT);
-	subflow = mptcp_subflow_ctx(ssock->sk);
+	ssk = msk->first;
+	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
 	 */
-	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
+	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
 		mptcp_subflow_early_fallback(msk, subflow);
 #endif
-	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
-		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
+	if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
 	if (likely(!__mptcp_check_fallback(msk)))
@@ -3613,27 +3615,42 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* if reaching here via the fastopen/sendmsg path, the caller already
 	 * acquired the subflow socket lock, too.
 	 */
-	if (msk->fastopening)
-		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
-	else
-		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
-	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
+	if (!msk->fastopening)
+		lock_sock(ssk);
+
+	/* the following mirrors closely a very small chunk of code from
+	 * __inet_stream_connect()
+	 */
+	if (ssk->sk_state != TCP_CLOSE)
+		goto out;
+
+	if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
+		err = ssk->sk_prot->pre_connect(ssk, uaddr, addr_len);
+		if (err)
+			goto out;
+	}
+
+	err = ssk->sk_prot->connect(ssk, uaddr, addr_len);
+	if (err < 0)
+		goto out;
+
+	inet_sk(sk)->defer_connect = inet_sk(ssk)->defer_connect;
+
+out:
+	if (!msk->fastopening)
+		release_sock(ssk);
 
 	/* on successful connect, the msk state will be moved to established by
 	 * subflow_finish_connect()
 	 */
-	if (unlikely(err && err != -EINPROGRESS)) {
+	if (unlikely(err)) {
 		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
-		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
+		inet_sk_state_store(sk, TCP_CLOSE);
 		return err;
 	}
 
-	mptcp_copy_inaddrs(sk, ssock->sk);
-
-	/* silence EINPROGRESS and let the caller inet_stream_connect
-	 * handle the connection in progress
-	 */
+	mptcp_copy_inaddrs(sk, ssk);
 	return 0;
 }
 

-- 
2.40.1


