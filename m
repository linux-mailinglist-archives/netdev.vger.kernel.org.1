Return-Path: <netdev+bounces-34168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F77A2700
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2907D1C209A7
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04918E23;
	Fri, 15 Sep 2023 19:14:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757518E0C
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:14:32 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AC398
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:14:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso12485e9.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694805269; x=1695410069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsrAD3mVchurwf5cusGbI+Po9Ghg396rQO3+7tylkhA=;
        b=wHBGyzI8l7bcPgd7IPUWE11HPpQHb+g5t0UJ5nKxC31dA9FLmbAHFtGYRjHGQ9SLKq
         uP+mMNfqW9Trehn6uhkk6GbZ8A/AosCrXwpQzWkLB26sAMRshTraqviFCz5FLWgPI3ER
         W/U3tENwDrNfi2JNKDr91xq1RpZLmUVrwtEjbbTOZGd+y28T0IK8HutbyCKlwKozdLvP
         LmW/UfyhnDgl4S+Te3Waem1rsDPgs/A7AUX1UAf/USCbMJmV7ZCEA9kVNXu2SQ8S3qoF
         cifo1815NHV6UY4pqEMHh8KDxTMabFCLjVswLMy+A2AJINduuiwfJWUZ+zVyi1obP7OO
         c1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694805269; x=1695410069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsrAD3mVchurwf5cusGbI+Po9Ghg396rQO3+7tylkhA=;
        b=KvDp9LeiBWu26D3GbrnXuIqqxXY3bHHjBO/k7DDkFM9HUrj3AUCZ2R633Ui5khvfMa
         EKP1x0TmH/pJn33DD1hwQ5An8bPG/CUFB/sfzTYE8vW8q7JC2fUP9/WuFoj7Ctfw4Ny3
         yB1QTGH8m2Dhy2HIJ6MS9O3q5kUbNjJsNrHhFryCecWJt4pfu/xrTOtQEJcckzSMv5NP
         iyAvd7csqmM1/gfVi7GoPp4vsOIFCg6zGm5P7JLVuR2FfyJXsDMCZnmjneiSFinRxAaR
         Kl/e1j9TVuuG6R15DDoJ8AznFLeAa45NxFNYjcZ8IwPXmq5/3F/WNfIoO95t6qNH+h2I
         uXbQ==
X-Gm-Message-State: AOJu0YyGahTqoD2tvtIWbrJFqrklAi7/IG3n5ciO2cDVuFxxukJFSq0f
	em+ncFUsPwOuveYeWt5uX2xVgPWfpW+OyTPwiVkD+HiS1b5+l4Ups9oilA==
X-Google-Smtp-Source: AGHT+IHKWYcWD8oEEAC6PyZyKBuHs+h4RuP6+P6I/lIy47qlFCkoInY0Djy85tVNjOuvJL29BAZ9bQzW5DWJEUJeO4Y=
X-Received: by 2002:a05:600c:5126:b0:3fe:ef25:8b86 with SMTP id
 o38-20020a05600c512600b003feef258b86mr27863wms.4.1694805268816; Fri, 15 Sep
 2023 12:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915190035.4083297-1-edumazet@google.com>
In-Reply-To: <20230915190035.4083297-1-edumazet@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 15 Sep 2023 21:13:50 +0200
Message-ID: <CAG48ez2PsxR9uqP+8XOeF8b_VZqXS9tb7Qqjzz5L-573CUFuAQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] dccp: fix dccp_v4_err()/dccp_v6_err() again
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 9:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> dh->dccph_x is the 9th byte (offset 8) in "struct dccp_hdr",
> not in the "byte 7" as Jann claimed.
>
> We need to make sure the ICMP messages are big enough,
> using more standard ways (no more assumptions).
>
> syzbot reported:
> BUG: KMSAN: uninit-value in pskb_may_pull_reason include/linux/skbuff.h:2=
667 [inline]
> BUG: KMSAN: uninit-value in pskb_may_pull include/linux/skbuff.h:2681 [in=
line]
> BUG: KMSAN: uninit-value in dccp_v6_err+0x426/0x1aa0 net/dccp/ipv6.c:94

By the way, I didn't realize syzbot could catch SKB head OOB reads
thanks to KMSAN. Neat!

[...]
> CPU: 0 PID: 4995 Comm: syz-executor153 Not tainted 6.6.0-rc1-syzkaller-00=
014-ga747acc0b752 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/04/2023
>
> Fixes: 977ad86c2a1b ("dccp: Fix out of bounds access in DCCP error handle=
r")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jann Horn <jannh@google.com>

Reviewed-by: Jann Horn <jannh@google.com>

> ---
> v2: fix a typo I made on Jann name, sorry !
>  net/dccp/ipv4.c | 9 ++-------
>  net/dccp/ipv6.c | 9 ++-------
>  2 files changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index 8f56e8723c7386c9f9344f1376823bfd0077c8c2..69453b936bd557c77a790a27f=
f64cc91e5a58296 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -254,13 +254,8 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info=
)
>         int err;
>         struct net *net =3D dev_net(skb->dev);
>
> -       /* For the first __dccp_basic_hdr_len() check, we only need dh->d=
ccph_x,
> -        * which is in byte 7 of the dccp header.
> -        * Our caller (icmp_socket_deliver()) already pulled 8 bytes for =
us.
> -        *
> -        * Later on, we want to access the sequence number fields, which =
are
> -        * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
> -        */
> +       if (!pskb_may_pull(skb, offset + sizeof(*dh)))
> +               return -EINVAL;
>         dh =3D (struct dccp_hdr *)(skb->data + offset);
>         if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
>                 return -EINVAL;
> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index 33f6ccf6ba77b9bcc24054b09857aaee4bb71acf..c693a570682fba2ad93c7bceb=
8788bd9d51a0b41 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
> @@ -83,13 +83,8 @@ static int dccp_v6_err(struct sk_buff *skb, struct ine=
t6_skb_parm *opt,
>         __u64 seq;
>         struct net *net =3D dev_net(skb->dev);
>
> -       /* For the first __dccp_basic_hdr_len() check, we only need dh->d=
ccph_x,
> -        * which is in byte 7 of the dccp header.
> -        * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
> -        *
> -        * Later on, we want to access the sequence number fields, which =
are
> -        * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
> -        */
> +       if (!pskb_may_pull(skb, offset + sizeof(*dh)))
> +               return -EINVAL;
>         dh =3D (struct dccp_hdr *)(skb->data + offset);
>         if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
>                 return -EINVAL;
> --
> 2.42.0.459.ge4e396fd5e-goog
>

