Return-Path: <netdev+bounces-54360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB0B806BF7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5648B1F21348
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1B17744;
	Wed,  6 Dec 2023 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RXIR2ic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475A5120
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:33:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so9781a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701858807; x=1702463607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09DI37Cq+VQrU+S9PP54JaC5ZxNfdGTjkQnCEA1LpAo=;
        b=2RXIR2icJTMw/+ACt8BOYRUIHJNcSiz8QclXIioynnuwGXsprpbjJN6m9Sj4TCToUK
         mECHcejtfILRUECewTRQfqyq+kOHNOd6c7kpvLi6oJxUUR/x3i7bIS8LcOUIXCWoUn/W
         ahmefwc9IIWNFgrWKKfQQVcvTyb/AutQyXpNfkd6sFcBxoq81RFOaQR5VK1imBmqOpft
         7MzJ0uUzBTsKUSo723Xm1mKsUmR2s445bHcqurlZLNuMXipzvVHwp6mpQUMYUwNWvUv/
         gwxknkeuOC9dyvyvKmAyOEEYxioTKG9nMqotJFvcsfBHybkWFC3jDVn5lr8G+NI//pAz
         bN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858807; x=1702463607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09DI37Cq+VQrU+S9PP54JaC5ZxNfdGTjkQnCEA1LpAo=;
        b=oqunXgr4T50RJWMntUp07w/MK5Wg+tc3eXe5fKgusEJCuwEIoPwNU2iBO11aBjZeVF
         2NR0hOuVU/szy5osecwTom3RiZiH6ncG3M9kFSCuZfQJ1ZKZVPPXw6InaRPf8pKr7+Lh
         JbLtYouOF4LkLXpceAUW34DJkjoZaPYV1qRo5xAs2zssZE88lxWXVLDqwOyoy5UHs5qP
         35KECcs8efU51Tu23GWLurU2IaQBWuu9Ev/1L48zsXtGMI06WqzkyDNcHszInt1b3GZR
         hH7QH5o4pT/MnPb/8wlv4RZCVo1V3fuu2Q7wAp1a9tBanKBwHTBL4ukzvEsUz888sPJV
         M36Q==
X-Gm-Message-State: AOJu0YwdR5LveRxGE1wJR6roJc0utGsZUUHpeeigizEFrwKSnmLpVL7U
	KPRSF87VA+Q5bkyXzsy7YrtqjpToQG2TyVrWoNTm0Q==
X-Google-Smtp-Source: AGHT+IGgsPQOvHd0HHZviyExDPpjEL4RdM9N55BTh8O12Jwv1ZA4HWaSazOM/4R4GfRXVUDTJmpGIqiyyw+YHDUsLKU=
X-Received: by 2002:a50:d744:0:b0:543:fb17:1a8 with SMTP id
 i4-20020a50d744000000b00543fb1701a8mr52085edj.3.1701858806381; Wed, 06 Dec
 2023 02:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206041332.GA5721@ubuntu>
In-Reply-To: <20231206041332.GA5721@ubuntu>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Dec 2023 11:33:15 +0100
Message-ID: <CANn89i+uXB__Bx7HAJt1Dg-P-cWyQUQk1SshE0jHjcTdODS9_w@mail.gmail.com>
Subject: Re: [PATCH v2] net/rose: Fix Use-After-Free in rose_ioctl
To: Hyunwoo Kim <v4bel@theori.io>
Cc: ralf@linux-mips.org, imv4bel@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 5:13=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wrote:
>
> Because rose_ioctl() accesses sk->sk_receive_queue
> without holding a sk->sk_receive_queue.lock, it can
> cause a race with rose_accept().
> A use-after-free for skb occurs with the following flow.
> ```
> rose_ioctl() -> skb_peek()
> rose_accept() -> skb_dequeue() -> kfree_skb()
> ```
> Add sk->sk_receive_queue.lock to rose_ioctl() to fix this issue.
>

Please add a Fixes: tag

> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---
> v1 -> v2: Use sk->sk_receive_queue.lock instead of lock_sock.
> ---
>  net/rose/af_rose.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> index 0cc5a4e19900..841c238de222 100644
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -1316,8 +1316,10 @@ static int rose_ioctl(struct socket *sock, unsigne=
d int cmd, unsigned long arg)
>                 struct sk_buff *skb;
>                 long amount =3D 0L;
>                 /* These two are safe on a single CPU system as only user=
 tasks fiddle here */
> +               spin_lock(&sk->sk_receive_queue.lock);

You need interrupt safety here.

sk_receive_queue can be fed from interrupt, that would potentially deadlock=
.

>                 if ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL)
>                         amount =3D skb->len;
> +               spin_unlock(&sk->sk_receive_queue.lock);
>                 return put_user(amount, (unsigned int __user *) argp);
>         }
>
> --
> 2.25.1
>

