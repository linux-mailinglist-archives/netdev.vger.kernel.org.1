Return-Path: <netdev+bounces-53433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E6802F49
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E963A2809A8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230B1DDD6;
	Mon,  4 Dec 2023 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOLpu4YH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ACF10E
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:51:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso9020a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701683502; x=1702288302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGP0Q7p9LapeH2bDY5jkZ9LFInWVGjDrdW3D7GpYi7o=;
        b=HOLpu4YH+/+nCM2ZXEUS425+6bW2+Q3sJNs1eL3SmcIfnkc/WrM9txv3494Dla6MOE
         98uZJAxUusZQl2BgFw6F9L6fm/RFgHmrq4E/kyTI3zL7FSl3SQ8zujpeH4w/qfs/HxS5
         8ApAheGyyy/xb+6P4ogRprxYelwrCHCnqy01QZBwvcysTHiNEV5erJ4UHy06OzVblgbP
         jBRi9QGIRixfpzmf6jjMjH9XkF+v7LfKYu9jDrhsY0hGZxzEsE0dUR4G4NyAZgGCjUa4
         HwO6IS8tO4csMaG3DVduDMV1xb+2WojyGO2pZ89gUQ20ALPQs/eThg4ay/tR3/tdPQW6
         pB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683502; x=1702288302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGP0Q7p9LapeH2bDY5jkZ9LFInWVGjDrdW3D7GpYi7o=;
        b=Gks4zKHOIlv26lidIT+gL4t1axtEIF1D1yma6HcyNyEyQI89mM1VS0mFEVDYKr9kUl
         BVJSs0J4UaUouYQqC4ikkbbbWqjdCKshou7SJlpEU0roLT+wuLG4cX3U+Jyw70+ytYXk
         WEPuxVvx43EMGkOpoj8K3KglemVc+0Z4kB8ZTsmH+5N03Ybh0g+8fBDxBo+hLDI8MSBD
         91vgevidqEoeSM+1AS+n5uoYqElXUKzZZoW+9zNUOtfGhPje2gAu+HRdhMKa/wXOucwU
         laza++Wy3gKTG7xJtzGX7wsoPU+iM1x72sICgBnXDa5YoCu0phfZnbGiadqsHGJgJ0H2
         BGjw==
X-Gm-Message-State: AOJu0YypTF+m8poCOg82ma7P/xLbvpuphHNMfJ9uShT7PEvtlWgG4RF1
	r+5zxs7uXtjNahGgUNoIp7uMxXvVP/G8CgwKc0zHHGdnYVbDzoz7dCtr6Q==
X-Google-Smtp-Source: AGHT+IFhcFjFwz6EvC7a6jh/cbd+7D0xHbAGrJHpa2ed6aPy0WQWBuuN4mBfV+R5674iaG0dox3TOuj1zREsDWYX3Zg=
X-Received: by 2002:a50:d797:0:b0:54b:6b3f:4aa8 with SMTP id
 w23-20020a50d797000000b0054b6b3f4aa8mr359821edi.4.1701683501906; Mon, 04 Dec
 2023 01:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204065657.GA16054@ubuntu>
In-Reply-To: <20231204065657.GA16054@ubuntu>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Dec 2023 10:51:30 +0100
Message-ID: <CANn89iLFdhshzJKfw8d2ZdDCu__GsoT_4md8ZWPABBAdykADEg@mail.gmail.com>
Subject: Re: [PATCH] net/rose: Fix Use-After-Free in rose_ioctl
To: Hyunwoo Kim <v4bel@theori.io>
Cc: ralf@linux-mips.org, imv4bel@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:57=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wrote:
>
> Because rose_ioctl() accesses sk->sk_receive_queue
> without holding a lock_sock, it can cause a race with
> rose_accept().
> A use-after-free for skb occurs with the following flow.
> ```
> rose_ioctl() -> skb_peek()
> rose_accept() -> skb_dequeue() -> kfree_skb()
> ```
> Add lock_sock to rose_ioctl() to fix this issue.
>
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---
>  net/rose/af_rose.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> index 0cc5a4e19900..5fe9db64b6df 100644
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -1316,8 +1316,10 @@ static int rose_ioctl(struct socket *sock, unsigne=
d int cmd, unsigned long arg)
>                 struct sk_buff *skb;
>                 long amount =3D 0L;
>                 /* These two are safe on a single CPU system as only user=
 tasks fiddle here */
> +               lock_sock(sk);

This is not correct.

You will have to lock sk->sk_receive_queue.lock instead.

Look at rose_recvmsg() for the reason why locking the socket itself is
not helping.

>                 if ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL)
>                         amount =3D skb->len;
> +               release_sock(sk);
>                 return put_user(amount, (unsigned int __user *) argp);
>         }
>
> --
> 2.25.1
>

