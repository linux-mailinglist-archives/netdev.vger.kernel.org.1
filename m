Return-Path: <netdev+bounces-13878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC2173D860
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9454D280D5B
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE41C2E;
	Mon, 26 Jun 2023 07:21:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736A1C15
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 07:21:43 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF57E0
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 00:21:42 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40079620a83so372191cf.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 00:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687764101; x=1690356101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj+GYS1A1tGQ+FJ/n5yk4Al/k8DmZXMPigKhaI306Q0=;
        b=3a5trGOb50p1P9+5CS5wMofgSHLQ8AGT8jYDtRkfWLhdPaQhoXPNskjVu2j8tTg7JP
         xRmwsKweyzrp2ydJt0z0cQHJ/21mSMdcAVeuAvjqJ/U5Ex0UINuJlJGFSM2tjM4V/ksp
         cTlb0Mf7IapJOgl4DNARuYoPv+YOLpTU/J3v2acaxJyFepYRUPrLjiXA/1a9jiX5qAbA
         WqX/14yDtW9kjCzn6umaRdPoc6R8Zq7vN0GkSKIJKCUxxItPgZSGot0LxBMq1DCw/JVv
         +RJjSWDztNvuxC00M6xEeT/o0PPMkwXqG9m86XvfpwDG/1rKhXcm7Bz/cKi4EktEUKIv
         ayCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687764101; x=1690356101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj+GYS1A1tGQ+FJ/n5yk4Al/k8DmZXMPigKhaI306Q0=;
        b=MKE0OYFxZv/G/fnnDJBB5LdSyQgM2mVEwXLeng/D9K+u/NvggwOR4jlaRtEuDoywWb
         XR464NxmVpETtlwFkJtOMOJWF55YORosS9i03dqio0pdY36V99NycgG8aZT97+yiQzPP
         f4BgLQTs1+8OqpYJuGfcaDttD6sOWxbPCXk2dy05k+NEt0ZrKGgkgmncT3pLjqaL89Qe
         Rf/7Ax3vpR4hqmVIZ2vWSWSYSmvgaX/EPrhxvfhq/Z1MDPYZs8Usc12yE/rptbfYBqQb
         9x3YXA44iuGi0w2oW7IPCI1U/akHj5v/Gb26wBlPo8jZYh3a/2XS7qmVhUO2CFdCR8Rc
         Wrrw==
X-Gm-Message-State: AC+VfDwN/ZNxOk9nMqVPLClUP80BLu3Irsa9xlkjVrIAWIjGynpGl2cp
	BL+3ia42WzTSw9ET84bxrEbORESArkV77Aosj5sTBnrdO/LFp4BKu8xNpg==
X-Google-Smtp-Source: ACHHUZ5qxL4bLh1NhEQSv8y/url9PeeYWRy+hcmaRJiXdcc+7aAQnK/3ppFEAJ8I3PCX6FkEPall1PlgdKsTvSxXPHo=
X-Received: by 2002:ac8:5b45:0:b0:3f8:175a:4970 with SMTP id
 n5-20020ac85b45000000b003f8175a4970mr343069qtw.18.1687764101132; Mon, 26 Jun
 2023 00:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230625161334.51672-1-kuniyu@amazon.com>
In-Reply-To: <20230625161334.51672-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jun 2023 09:21:30 +0200
Message-ID: <CANn89iL0n5Prem6Cjc6jkdAq6jm5AOYXWgn=i80UPsnNZE6WQw@mail.gmail.com>
Subject: Re: [PATCH v1 net] netlink: Add sock_i_ino_irqsaved() for __netlink_diag_dump().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023 at 6:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzbot reported a warning in __local_bh_enable_ip(). [0]
>
> Commit 8d61f926d420 ("netlink: fix potential deadlock in
> netlink_set_err()") converted read_lock(&nl_table_lock) to
> read_lock_irqsave() in __netlink_diag_dump() to prevent a deadlock.
>
> However, __netlink_diag_dump() calls sock_i_ino() that uses
> read_lock_bh() and read_unlock_bh().  read_unlock_bh() finally
> enables BH even though it should stay disabled until the following
> read_unlock_irqrestore().
>
> Using read_lock() in sock_i_ino() would trigger a lockdep splat
> in another place that was fixed in commit f064af1e500a ("net: fix
> a lockdep splat"), so let's add another function that would be safe
> to use under BH disabled.
>
> [0]:
>
> Fixes: 8d61f926d420 ("netlink: fix potential deadlock in netlink_set_err(=
)")
> Reported-by: syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5da61cf6a9bc1902d422
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>

Hi Kuniyuki, thanks for the fix, I mistakenly released this syzbot
bug/report the other day ;)

I wonder if we could use __sock_i_ino() instead of sock_i_ino_bh_disabled()=
,
and perhaps something like the following to have less copy/pasted code ?

diff --git a/net/core/sock.c b/net/core/sock.c
index 6e5662ca00fe5638881db11c71c46169d59a2746..146a83c50c5d329fee2e833c4f2=
ba29e896d7766
100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2550,13 +2550,25 @@ kuid_t sock_i_uid(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_i_uid);

-unsigned long sock_i_ino(struct sock *sk)
+/* Must be called while interrupts are disabled. */
+unsigned long __sock_i_ino(struct sock *sk)
 {
        unsigned long ino;

-       read_lock_bh(&sk->sk_callback_lock);
+       read_lock(&sk->sk_callback_lock);
        ino =3D sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
-       read_unlock_bh(&sk->sk_callback_lock);
+       read_unlock(&sk->sk_callback_lock);
+       return ino;
+}
+EXPORT_SYMBOL(__sock_i_ino);
+
+unsigned long sock_i_ino(struct sock *sk)
+{
+       unsigned long ino;
+
+       local_bh_disable();
+       ino =3D __sock_i_ino(sk);
+       local_bh_enable();
        return ino;
 }
 EXPORT_SYMBOL(sock_i_ino);

