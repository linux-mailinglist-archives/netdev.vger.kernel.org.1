Return-Path: <netdev+bounces-26869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994147793C3
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C820B1C216B7
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A65F360C6;
	Fri, 11 Aug 2023 15:58:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13E360C2
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:58:46 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B592723
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so18754685e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769524; x=1692374324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v41qzMf6LvZ79BWScnJgfS1EiY59Q4nhSyLXYX9clC8=;
        b=dCpP57fWagMhSfkoq09ZTOyreAAn1Ol4VHCZxHRN1quTTKFwgC5E1TY/3szUZL+Nho
         bi4MwaKRbxx2jdBAnsIcMtJ/394azV8mlkBhG36GzSzQZ5lKHCYFHypiuKOD1yxm80ZZ
         hRvJVXtb9dGHvUk8u0sgnWydoFkJ4Y8Qn2NY5WDC4BPJitlQajjAYA9BaAffFNNTduFX
         dHRpKdIRCekz54EmvfTOlGwds3C06vC2AzPbvBEIwoc9VNypU2VpHoy4clF8101b3udq
         dOneavoGfDsaA9N8+0BoJSk6B4vRg+W5CKsNwoNmUWG5dCMcVX9ZAcroED7Jv6GVIs9S
         kZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769524; x=1692374324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v41qzMf6LvZ79BWScnJgfS1EiY59Q4nhSyLXYX9clC8=;
        b=evPuS5dBTDgokXZnwss1Hh30d8FpcTKrapbjizhnYx6PQnHfWbojgJ0HSnDtkdLePi
         7VcpO1xQB1QVH6rak+dAR0fqGOiEzTI0wXjefLSXO/QBN47m7r1J38O7O/XaLI2fWZ9Z
         dZxWs1BRr5nlhCdvpE+8J4jImVgvSPKYH74wVn9/m9ukixPmGZjLofJg9JWpzyo4iY3Y
         TsSKKYBy7jlpwOClwzrjJRZPNFaEHW5jOGj0VvHGTd1s45qiDrVE5x3n2sCKRCoMjbzf
         022ZRfhLtpTA0f9XMF13jcTuNmNvSXZLeDqtEPvFGES01NOk1GA1OhImxrJw2J0/E2pD
         DZsQ==
X-Gm-Message-State: AOJu0YwkstuTR5ov4H4qoI0YonuSd62RNZOITDfklXcpKm19QNq5ju7j
	e00Ki6bLN0EGuKDoUssPLDvmlQ==
X-Google-Smtp-Source: AGHT+IEkpl5SbnBobq9PFSDtqBQa20owAg6YgDzSe6V+rMq1bi6S/v8n951Yt0Kko0IVOqBq/E3ITQ==
X-Received: by 2002:adf:efca:0:b0:314:34dd:aaec with SMTP id i10-20020adfefca000000b0031434ddaaecmr1889820wrp.8.1691769523941;
        Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:16 +0200
Subject: [PATCH net-next 03/14] mptcp: avoid subflow socket usage in
 mptcp_get_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-3-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=qK4HL7ezTejvaB3TjS+CX/NlLTCXy1zfWJooZqvAatM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvLUyKj/mYOz62URiB0KFWHJAuVmboKVIMR
 4TcaDRhCOSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c8LuD/9b7fcRKlNJsRt+MISnQc+hRMDgQiu+4c5P3Dbqv/qbP8THtVxf4LdUWcBeTeV3dqcJir/
 z0fAK/4dEvm08l8ew1OHXViLxS77ybbKIrN4azBbEnDCDnOiJc+7Zetxuwv2Mc2+rthfG8V9uBZ
 7tvB8ET48AjFga00QxJd3oH1PE2Rj1r+N22oyH/bFxc2ECrCJZUo+ZUfh9FBhED7UXEIT3yyQbG
 C3EJCT6WkPKj0ROz7tPh5Zk2iODubNydmNdiKcwmdGrspd5UC3k9b7tkPXngeOZ6mdMDv0Wu5+v
 ne3eNtzm6rufhdIt1yhMVWUu6QCK9ilhuCo7PPE5KOcvxMm159bpU/il2t9mCWzlj8B9kWW9yKk
 vcoINOl/nPOZd2SmlVlO+qDhp1fXg5T20Wc8h1E7iGvkKkOLwvQid6Q5ay6KwnMtN0EfoB/bUXO
 nSYeL5urXLDgrToWfdlL/HXbvdLt9w/0OR4DXeFHRLu98KVQo3x6ngDnXTxJwOEeQYBmJznF+zE
 3J4t29u7nqHNjUF06rmss4nPN8o1YHUvMm6vilrRJRM8tqG06B//ajcFqXEYe+G98IOz9Ah3wgl
 cj6uShv8wlaSvj94mjIdtldrdZcN1/64wQsmS6ByshKqXFkwVv1W8JDXU2NdrlT9cORnrxOiCi2
 4R/CJi0KXEXOtvg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

We are going to remove the first subflow socket soon, so avoid
accessing it in mptcp_get_port(). Instead, access directly the
first subflow sock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b888d6339c80..891f49722263 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3405,14 +3405,12 @@ static void mptcp_unhash(struct sock *sk)
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *ssock;
 
-	ssock = msk->subflow;
-	pr_debug("msk=%p, subflow=%p", msk, ssock);
-	if (WARN_ON_ONCE(!ssock))
+	pr_debug("msk=%p, ssk=%p", msk, msk->first);
+	if (WARN_ON_ONCE(!msk->first))
 		return -EINVAL;
 
-	return inet_csk_get_port(ssock->sk, snum);
+	return inet_csk_get_port(msk->first, snum);
 }
 
 void mptcp_finish_connect(struct sock *ssk)

-- 
2.40.1


