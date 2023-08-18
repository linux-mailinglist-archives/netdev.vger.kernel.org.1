Return-Path: <netdev+bounces-28718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920137805EA
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C451C2155B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C77C847D;
	Fri, 18 Aug 2023 06:41:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE8A5D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:41:02 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431CE3A95
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 23:41:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so67352966b.2
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692340860; x=1692945660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgLQ/Kxxgyg7POvQlUQU9loZngfTVG7JRdTOQb+0nck=;
        b=fSTujn59id9Xk5kpEhs7fOvA8yjYAv48xtsh3tNMBl/NZ5Hr4A7lyEjIFzySQei3q5
         HCFzsWYlgyTyyoRp5kqIBNIyYLqAFrFAkBNpTimkXpB2/iLW7vN5VUDFipc5ZxyvMMXi
         XU2KB10q+yNzS6e4UoL0b7ELBikNxK+JO7QuWQ+ovYPyMR6e7Ev93yHzmu86XCO5t9j6
         qyqjuk27VMFEEsgTbLYfTOEBIx5za9N9HSBsFzZUNfvZaTM2rqRQV6WBM0/ZTqK/E6Ds
         2AL6kzPYk5NfPi32v0nF0/hen5mZ/NhobpnJIPI84lKPWERshWikHpzCMuRBykoxjvxb
         jsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692340860; x=1692945660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgLQ/Kxxgyg7POvQlUQU9loZngfTVG7JRdTOQb+0nck=;
        b=HyJ+RUVjqKnZog/1jeXiegpTmstTZ2rHRmBsRC2boOeVMrCr5rnxjJpeFmT28r2oEw
         kwJh6UiNlKaE//l7ryklFsSxkbuDvG1GDDm+wHXKMYe93Av+e5AGAwsAzMHgs1IdfmKy
         6p1Vu7HhWUBt0Bkmu0PYsCkPuvkkvRwAh9HYZlQbz6BRrL7qz2nBxSpk5EhWrMShSUkw
         feQq5a9SI6yXWBHMgCTIyK06uXMF2cxMSmSKIolQFC0UcvlJAslTta2FEYvmK51jsZGb
         YPQnmsxKhIJqE9lb+hlLWZYJMkkz8/qrx91JJVyjF7VakwKo95lC+h3fC5WpQ/BFz6Sc
         JBDw==
X-Gm-Message-State: AOJu0YwreyINKZu5c2d/HzONf2Pm4rVQFUz0485H0MoVfeYYx9a384mo
	slsmlyiht/x/FQ0+HJ3gI8lNSljkPmlXGEdZ5ntVNouFydY2jg==
X-Google-Smtp-Source: AGHT+IGMgL+98YJlDHlNt+eNrxQquwGoJg1A12Bryxhmse8azoJ4nvaIqgjuk2wa7z8Ek2Sol/hjplUVNnzSB8yZPJw=
X-Received: by 2002:a17:906:2254:b0:99e:8a1:9df7 with SMTP id
 20-20020a170906225400b0099e08a19df7mr1265438ejr.74.1692340859551; Thu, 17 Aug
 2023 23:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818021132.2796092-1-edumazet@google.com>
In-Reply-To: <20230818021132.2796092-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 18 Aug 2023 14:40:22 +0800
Message-ID: <CAL+tcoDGuVNie-mAzU6t61pQPqt24PWKP88JG-kVM6ZhttUZEg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: annotate data-races around sk->sk_lingertime
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 10:11=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> sk_getsockopt() runs locklessly. This means sk->sk_lingertime
> can be read while other threads are changing its value.
>
> Other reads also happen without socket lock being held,
> and must be annotated.
>
> Remove preprocessor logic using BITS_PER_LONG, compilers
> are smart enough to figure this by themselves.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

> ---
>  net/bluetooth/iso.c |  2 +-
>  net/bluetooth/sco.c |  2 +-
>  net/core/sock.c     | 18 +++++++++---------
>  net/sched/em_meta.c |  2 +-
>  net/smc/af_smc.c    |  2 +-
>  5 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 6b66d6a88b9a22adf208b24e0a31d6f236355d9b..3c03e49422c7519167a0a2a6f=
5bdc8af5b2c0cd0 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1475,7 +1475,7 @@ static int iso_sock_release(struct socket *sock)
>
>         iso_sock_close(sk);
>
> -       if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
> +       if (sock_flag(sk, SOCK_LINGER) && READ_ONCE(sk->sk_lingertime) &&
>             !(current->flags & PF_EXITING)) {
>                 lock_sock(sk);
>                 err =3D bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingerti=
me);
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 50ad5935ae47a31cb3d11a8b56f7d462cbaf2366..c736186aba26beadccd76c66f=
0af72835d740551 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1245,7 +1245,7 @@ static int sco_sock_release(struct socket *sock)
>
>         sco_sock_close(sk);
>
> -       if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
> +       if (sock_flag(sk, SOCK_LINGER) && READ_ONCE(sk->sk_lingertime) &&
>             !(current->flags & PF_EXITING)) {
>                 lock_sock(sk);
>                 err =3D bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingerti=
me);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 22d94394335fb75f12da65368e87c5a65167cc0e..e11952aee3777a5df51abdf70=
d30fbd3ec3a50fc 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -797,7 +797,7 @@ EXPORT_SYMBOL(sock_set_reuseport);
>  void sock_no_linger(struct sock *sk)
>  {
>         lock_sock(sk);
> -       sk->sk_lingertime =3D 0;
> +       WRITE_ONCE(sk->sk_lingertime, 0);
>         sock_set_flag(sk, SOCK_LINGER);
>         release_sock(sk);
>  }
> @@ -1230,15 +1230,15 @@ int sk_setsockopt(struct sock *sk, int level, int=
 optname,
>                         ret =3D -EFAULT;
>                         break;
>                 }
> -               if (!ling.l_onoff)
> +               if (!ling.l_onoff) {
>                         sock_reset_flag(sk, SOCK_LINGER);
> -               else {
> -#if (BITS_PER_LONG =3D=3D 32)
> -                       if ((unsigned int)ling.l_linger >=3D MAX_SCHEDULE=
_TIMEOUT/HZ)
> -                               sk->sk_lingertime =3D MAX_SCHEDULE_TIMEOU=
T;
> +               } else {
> +                       unsigned int t_sec =3D ling.l_linger;
> +
> +                       if (t_sec >=3D MAX_SCHEDULE_TIMEOUT / HZ)
> +                               WRITE_ONCE(sk->sk_lingertime, MAX_SCHEDUL=
E_TIMEOUT);
>                         else
> -#endif
> -                               sk->sk_lingertime =3D (unsigned int)ling.=
l_linger * HZ;
> +                               WRITE_ONCE(sk->sk_lingertime, t_sec * HZ)=
;
>                         sock_set_flag(sk, SOCK_LINGER);
>                 }
>                 break;
> @@ -1692,7 +1692,7 @@ int sk_getsockopt(struct sock *sk, int level, int o=
ptname,
>         case SO_LINGER:
>                 lv              =3D sizeof(v.ling);
>                 v.ling.l_onoff  =3D sock_flag(sk, SOCK_LINGER);
> -               v.ling.l_linger =3D sk->sk_lingertime / HZ;
> +               v.ling.l_linger =3D READ_ONCE(sk->sk_lingertime) / HZ;
>                 break;
>
>         case SO_BSDCOMPAT:
> diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
> index 6fdba069f6bfd306fa68fc2e68bdcaf0cf4d4e9e..da34fd4c92695f453f1d6547c=
6e4e8d3afe7a116 100644
> --- a/net/sched/em_meta.c
> +++ b/net/sched/em_meta.c
> @@ -502,7 +502,7 @@ META_COLLECTOR(int_sk_lingertime)
>                 *err =3D -1;
>                 return;
>         }
> -       dst->value =3D sk->sk_lingertime / HZ;
> +       dst->value =3D READ_ONCE(sk->sk_lingertime) / HZ;
>  }
>
>  META_COLLECTOR(int_sk_err_qlen)
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index f5834af5fad535c420381827548cecdf0d03b0d5..7c77565c39d19c7f1baf1184c=
4a5bf950c9cfe33 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1820,7 +1820,7 @@ void smc_close_non_accepted(struct sock *sk)
>         lock_sock(sk);
>         if (!sk->sk_lingertime)
>                 /* wait for peer closing */
> -               sk->sk_lingertime =3D SMC_MAX_STREAM_WAIT_TIMEOUT;
> +               WRITE_ONCE(sk->sk_lingertime, SMC_MAX_STREAM_WAIT_TIMEOUT=
);
>         __smc_release(smc);
>         release_sock(sk);
>         sock_put(sk); /* sock_hold above */
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
>

