Return-Path: <netdev+bounces-55533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47B80B35E
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF541C2086F
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02FC8C1;
	Sat,  9 Dec 2023 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIf622N9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDFEB
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:08:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so18885e9.1
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 01:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702112888; x=1702717688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACAZlK3841Tu71j872fAdJfSIdJAJYKGcip/Dxr+6m0=;
        b=TIf622N9sZLJEY2tsYwE4SI4/VMacXJfj7vTb2qUxjvCqmbD4EfK1Mwg2OMqzreTg8
         UiECIz570ucdZwNS1d/zE/PuOIyKlcZ0s/vW82jdzbP6b7YZeKwiHJP77KgfuDUo/Bh6
         E+tNFyd9/WCD2NplZ60Cndyh4VUz0fgvtpzECWZmGbMCqg7xkZinbMhqDIyZu8l/ZBYf
         d6bUiua7sklTpTuaiPTxr2gAYLZ131mrlRCjVIamz4473DE8hEM/e/aNaeh4c2QISpmA
         vO60qYBzqPa0apyrBd/LtyTDsnFS0pmcgUdNC0IARoeLyXSqyIylBJT7bHxHR3PA0sgt
         qKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702112888; x=1702717688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACAZlK3841Tu71j872fAdJfSIdJAJYKGcip/Dxr+6m0=;
        b=Otjgic+/u+SMZOFcxcCCk2YNTGf0YPoAjCIOrnEIhaagVLC301imSC3UNmyhSaJ6C+
         6EkQ9+tsBV4VKXugY9ETQz1I6A1a78RWoDomflrNKoQsrpUq0QHyqEUJrBbcsadI8fxU
         710P5fjzll0XET00W9w84HirM+3PjUr7aTxlmDNv1EDFWkztCMUulHLXwqHp0rpsSM4+
         H6EMvGYPUgKy5MGO20QHYoWE5Hm+MSBA2MrKBZ0whewFuu7uWik9nvFqTahTxtdeb4cy
         FfRmww7o4s7WRiaGRUMenpV4rgwZmyK+NfDf8i2lYB6EtbaOsJIXrFSLaWQk6kTl0wdY
         FsCA==
X-Gm-Message-State: AOJu0YyrlFEQtJAZbFtyc0vuIv9sLhHJ0f0C1CLEep+gatrK0dxH829p
	7hj9d6HeXxHzqz6SXgjU1Sf5BIHfeQubBoVQnV3PEQ==
X-Google-Smtp-Source: AGHT+IF5pdhPSj+DKknmK5TylMPHWPVV7aCrZp7oXhL8tA20Jxm6KeCiENCk0eu7QMQzvAMaIuGb3TQBW5+C05iJJ54=
X-Received: by 2002:a05:600c:3b9c:b0:40b:4355:a04b with SMTP id
 n28-20020a05600c3b9c00b0040b4355a04bmr136996wms.6.1702112887819; Sat, 09 Dec
 2023 01:08:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209090509.GA401342@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <20231209090509.GA401342@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 9 Dec 2023 10:07:56 +0100
Message-ID: <CANn89iJWQR62a2sk_87skv=92eegFSaBgu=W7-zn96Y5NQo8PA@mail.gmail.com>
Subject: Re: [PATCH net v2] atm: Fix Use-After-Free in do_vcc_ioctl
To: Hyunwoo Kim <v4bel@theori.io>
Cc: davem@davemloft.net, kuba@kernel.org, imv4bel@gmail.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 10:05=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wrote=
:
>
> Because do_vcc_ioctl() accesses sk->sk_receive_queue
> without holding a sk->sk_receive_queue.lock, it can
> cause a race with vcc_recvmsg().
> A use-after-free for skb occurs with the following flow.
> ```
> do_vcc_ioctl() -> skb_peek()
> vcc_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> ```
> Add sk->sk_receive_queue.lock to do_vcc_ioctl() to fix this issue.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---
> v1 -> v2: Change the code style
> ---
>  net/atm/ioctl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
> index 838ebf0cabbf..b7684abcf458 100644
> --- a/net/atm/ioctl.c
> +++ b/net/atm/ioctl.c
> @@ -72,15 +72,18 @@ static int do_vcc_ioctl(struct socket *sock, unsigned=
 int cmd,
>                 goto done;
>         case SIOCINQ:
>         {
> +               long amount;
>                 struct sk_buff *skb;

This should be "int amount;", and should be put after the " struct
sk_buff *skb;" line for  proper style.




>
>                 if (sock->state !=3D SS_CONNECTED) {
>                         error =3D -EINVAL;
>                         goto done;
>                 }
> +               spin_lock_irq(&sk->sk_receive_queue.lock);
>                 skb =3D skb_peek(&sk->sk_receive_queue);
> -               error =3D put_user(skb ? skb->len : 0,
> -                                (int __user *)argp) ? -EFAULT : 0;
> +               amount =3D skb ? skb->len : 0;
> +               spin_unlock_irq(&sk->sk_receive_queue.lock);
> +               error =3D put_user(amount, (int __user *)argp) ? -EFAULT =
: 0;
>                 goto done;
>         }
>         case ATM_SETSC:
> --
> 2.25.1
>

