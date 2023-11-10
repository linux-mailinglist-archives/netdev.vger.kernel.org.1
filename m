Return-Path: <netdev+bounces-47024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0497E7A4D
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1001C20B9E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6F7847A;
	Fri, 10 Nov 2023 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w60jJm1z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EFECA73
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:53:17 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F440A27C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:53:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so24279a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699606393; x=1700211193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo3Gaef76iZdXuhsx+7+Om1O4tE/oq1eo+uule+ERTE=;
        b=w60jJm1zzPUQBH2LMtpUKvckPCnvCMcuxB74Phs/oJS4nUVUdnADfZXrvUXrJe5XVB
         Z/pBPSzhy2tqqTIjukQcldaqEt/KkOKn8sxzWpw+TF5HziW7IMNZxuhY+taBsAdaUlbN
         n64s0bwc9c27WY4akZjQR7n05xPM5Hfi0w1VGyvIkWB2ho9kOKblmtv39QbVfSYdg91N
         xdBCyiTEzwuJ0AwtvlmbxDXST3bwlrmxC8ZwE1jl3Jk+LnaFSuuH6oWt2GacZ4yVrsTr
         pfKVwI8vwZWH6NqtwhHk+YB13RirZtfybVGSmcTRSt1tQgpwIfh3OACZZhQZNC/GIV9Y
         0sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699606393; x=1700211193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bo3Gaef76iZdXuhsx+7+Om1O4tE/oq1eo+uule+ERTE=;
        b=ORIUIJdMKmDxdBCJ+NGM2StSsmLaGOdGE6EmVLElVyn9z9J0rq77268utwnGkY1GYq
         MzdF7a+4FpXu0T7XnUZKjdR57uIS5DdA8ug8fTlpS7SvBnFrZfRdtPmyKm//N9lWYj5D
         bxSEIidV5YsRYRfAxc8PEl+fkLlAJuvNrXHB/mfaf0OiHlb+hqXoAyGnAGWtfdIISncc
         Q+XgLmCZ5QglXn3IYYJOq7j8hm1Iq+wds1vUoYKWywB/VfSioNw21dfcqB2amXsJn/GS
         IoAiLSEDEzieO4L97oxfNdoea/PRGEiYN5kbe6sd9fWY1syZQESS3dStWiK5m5SnEL9T
         mVeA==
X-Gm-Message-State: AOJu0YwmK2imokNcB2Twl4m5oN3VGpt1EfryC0+kktMU4jxVeqMmX0DJ
	6LposBUnY+FX0u3KYiVD4Ikkyo7NnaX2AqC7AiVQ9A==
X-Google-Smtp-Source: AGHT+IHNVwWCLTN6LjcqqqgM7vGdwZcOOORDqp35sP4CzTDGxBSeVzCT91zZD4uIiqV2QAN4HgA7DtSL0ihyPu880ts=
X-Received: by 2002:a05:6402:497:b0:544:24a8:ebd with SMTP id
 k23-20020a056402049700b0054424a80ebdmr327482edv.4.1699606393272; Fri, 10 Nov
 2023 00:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110084425.2123-1-kdipendra88@gmail.com>
In-Reply-To: <20231110084425.2123-1-kdipendra88@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Nov 2023 09:52:59 +0100
Message-ID: <CANn89iL34Yiuas__P5WbtVM-mN5=ga-RhZV7Kdqo4a6KDxTv1g@mail.gmail.com>
Subject: Re: [PATCH] Fixes the null pointer deferences in nsim_bpf
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 9:45=E2=80=AFAM Dipendra Khadka <kdipendra88@gmail.=
com> wrote:
>
> Syzkaller found a null pointer dereference in nsim_bpf
> originating from the lack of a null check for state.
>
> This patch fixes the issue by adding a check for state
> in two functions nsim_prog_set_loaded and nsim_setup_prog_hw_checks
>
> Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com./bug?extid=3D44c2416196b7c607f226

Please add a Fixes: tag, and remove this empty line, thanks.

>
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
>  drivers/net/netdevsim/bpf.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> index f60eb97e3a62..e407efb0e3de 100644
> --- a/drivers/net/netdevsim/bpf.c
> +++ b/drivers/net/netdevsim/bpf.c
> @@ -97,7 +97,8 @@ static void nsim_prog_set_loaded(struct bpf_prog *prog,=
 bool loaded)
>                 return;
>
>         state =3D prog->aux->offload->dev_priv;
> -       state->is_loaded =3D loaded;
> +       if (state)
> +               state->is_loaded =3D loaded;
>  }
>
>  static int
> @@ -317,10 +318,12 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, str=
uct netdev_bpf *bpf)
>         }
>
>         state =3D bpf->prog->aux->offload->dev_priv;
> -       if (WARN_ON(strcmp(state->state, "xlated"))) {
> -               NSIM_EA(bpf->extack, "offloading program in bad state");
> -               return -EINVAL;
> -       }
> +       if (state) {
> +               if (WARN_ON(strcmp(state->state, "xlated"))) {
> +                       NSIM_EA(bpf->extack, "offloading program in bad s=
tate");
> +                       return -EINVAL;
> +               }
> +       }
>         return 0;
>  }
>
> --
> 2.34.1
>

