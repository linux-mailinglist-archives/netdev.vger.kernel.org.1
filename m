Return-Path: <netdev+bounces-15372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD84747336
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4951C20A02
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D46AD8;
	Tue,  4 Jul 2023 13:46:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5BB6AC2
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:46:49 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21CEE
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:46:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3143b70d6easo1767020f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688478405; x=1691070405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2IDitR9Vhq5+nUn/yyJmBovpxVJNF/QnicIs9lsJ+Y=;
        b=D7RibmC1rQJ8R8+HX4kjTFvvR2CgDwvOaepJYfaswNn8rG4oWqKjvZq6KGzCKg0m8d
         wWt9AWDbXmssH1MsgmQyGc+31k7Sgz950TZ8oaLIXhX62SWcxe9pyci+bUX+eXJkliUh
         YfoZvF4fvmHg8OZovJvCRR660XemmUpraqHDXdqEWPOhAZ/Ash/CMvRgJb/bTRl45oO6
         B3JH4fjAfXtJaNVTqEViPvA0DOQ2A9cdcO7aQQEc/9lqtOWD59Y0ZvNim5uYL8vdyCkO
         M+F2YnEKzfOW3s5BRgLhq9CYLP4W9hOl+GyN2hqreLt+Ut2WJ66ui5PgkAEHWuVUoQ3x
         5l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478405; x=1691070405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2IDitR9Vhq5+nUn/yyJmBovpxVJNF/QnicIs9lsJ+Y=;
        b=OIXiTruguPfY91XP5UkC88l/n3xNbrPCyg/zpBasiUPjKzihAIsD7x1zg9PKuCCwd+
         Mk/rQh5g73PiSbEk1Kg8egrL6otl94owlBEgOG/E7lxwR6B5Wr3QtUFusswaI0VzMMFO
         pPKa40yfLC96FvUglxZJOKzv68VfNiDvywO/3acn84hj4LZ1reZQ/YGeAjIr0xKxj5Q2
         /X96SVnCJ+Yq52VrJely3aKjusEgrViWNu6UonXhEPP03SbrcdfRiYIwFKM4Qje9foXx
         9sPJFTkiZOu3GKfdCtaPhJGMIQoHu3osGFa6RyWY6HR5mJe1awtGgqwNIzm0jfg5rnLo
         eJUw==
X-Gm-Message-State: ABy/qLYNmagYfHpAflNb9W08gKbDt9ToYM6KXWviEeV840WgLNi4PNwS
	OdoWvXwl/MM6hOXDK413q9GvIQ==
X-Google-Smtp-Source: APBJJlEGduOzEzHe7GYus5y9PRmRsc4u41aKbi0k3fjDnY/GuxPQAeB6TcnO2Kx0jc0qi6X9I1n7bw==
X-Received: by 2002:a5d:518c:0:b0:314:fe8:94d8 with SMTP id k12-20020a5d518c000000b003140fe894d8mr9602461wrv.31.1688478405542;
        Tue, 04 Jul 2023 06:46:45 -0700 (PDT)
Received: from [192.168.133.175] ([5.148.46.226])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b003142b0d98b4sm9274680wrt.37.2023.07.04.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:46:45 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 04 Jul 2023 14:46:26 +0100
Subject: [PATCH bpf-next v5 4/7] net: document inet[6]_lookup_reuseport
 sk_state requirements
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v5-4-f6686a0dbce0@isovalent.com>
References: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The current implementation was extracted from inet[6]_lhash2_lookup
in commit 80b373f74f9e ("inet: Extract helper for selecting socket
from reuseport group") and commit 5df6531292b5 ("inet6: Extract helper
for selecting socket from reuseport group"). In the original context,
sk is always in TCP_LISTEN state and so did not have a separate check.

Add documentation that specifies which sk_state are valid to pass to
the function.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 net/ipv4/inet_hashtables.c  | 15 +++++++++++++++
 net/ipv6/inet6_hashtables.c | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 352eb371c93b..64fc1bd3fb63 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -335,6 +335,21 @@ static inline int compute_score(struct sock *sk, struct net *net,
 
 INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
 
+/**
+ * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
+ * @net: network namespace.
+ * @sk: AF_INET socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.
+ * @skb: context for a potential SK_REUSEPORT program.
+ * @doff: header offset.
+ * @saddr: source address.
+ * @sport: source port.
+ * @daddr: destination address.
+ * @hnum: destination port in host byte order.
+ * @ehashfn: hash function used to generate the fallback hash.
+ *
+ * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
+ *         the selected sock or an error.
+ */
 struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 3616225c89ef..f76dbbb29332 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -114,6 +114,21 @@ static inline int compute_score(struct sock *sk, struct net *net,
 
 INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
 
+/**
+ * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
+ * @net: network namespace.
+ * @sk: AF_INET6 socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.
+ * @skb: context for a potential SK_REUSEPORT program.
+ * @doff: header offset.
+ * @saddr: source address.
+ * @sport: source port.
+ * @daddr: destination address.
+ * @hnum: destination port in host byte order.
+ * @ehashfn: hash function used to generate the fallback hash.
+ *
+ * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
+ *         the selected sock or an error.
+ */
 struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,

-- 
2.40.1


