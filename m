Return-Path: <netdev+bounces-49325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582677F1BB5
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30E5282286
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B7241F9;
	Mon, 20 Nov 2023 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9jj7Qax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5EBC1
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 09:56:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso266a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700502964; x=1701107764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLJOaSiMX4j029aOHc7oApRw+KVD1nkO9hjnIeQA3ws=;
        b=e9jj7QaxGuoKYKJ/edph7ZXHgkEd1MqMMRfIhh+50RWMP30+7dG23wkhLc0gI3gL2j
         bRlLvI7ubsRmP3mOJqGkZ9eQyrtjaQWU8UwawZbBxvI2gn1iymZOGxrrWTlWHuU0ycv5
         Wkm+UYSGSlB5KqYbbsUupnF5M+wySXNuYLTM3/tZj0B21dqGBdrsllA90Bv/6dKmSPvG
         Me6nNg2X+D65Yjm7J0ksXPWJCOqobHtBI2JaC/u8MGXHV9sC8OWU8+zrvs5dej47ibxr
         RkXyMFOFAt8EHPCJeoJb7hBoi6P1I5PhOqrPJC771//Y6dlAMI/Ng33rtW/z1Xn0EdEu
         KNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700502964; x=1701107764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLJOaSiMX4j029aOHc7oApRw+KVD1nkO9hjnIeQA3ws=;
        b=LaZqCYrTVgI6VQg16kDfFNZMklQaEICgwaRfZ8KbejUZikFxXVqCP6kknhpKqi3Vea
         +dFZcu02LqoM9pHDYcPi5wlJJ4tOOJXoDYYKCYAK27+PxMzbvDTZo90GUei1ECRyjhy0
         1buU24f67LaGyi7vq7YMPBj3/V5zxMocS7rDp8+zyI6KxvZks48Q6zzrmYtmkMxGsCns
         OdOdA6C3zNCHXSy44235lNjJwUbRrlRHlV9/9akK9K8eAkPAE/aTI+yRCxEbKf4P4nOa
         WQk0Ftt/X8Jnnc1bWqlGmAfgK8su/TcLeYu08Ggg77SSKM2ISB0ncFRZBEoiPvIfWP3k
         CUhg==
X-Gm-Message-State: AOJu0Yw36mqcD7TxkHOufPzHPlZdPiCysKRe+DCVLSNv2gxZ6OzoShVI
	HRWF3O09u/GvaF888FsPLGe/S4Kv2aS7fu+nOMezsg==
X-Google-Smtp-Source: AGHT+IGIb/35Hbinv4Qtgi95bh0B0EBvf1zLhZKPE3sBN4r4pQW5rheUbkcq+eL5EJQgnl8zIDYfaHDK3f1/wJQXPPw=
X-Received: by 2002:a05:6402:3784:b0:544:24a8:ebd with SMTP id
 et4-20020a056402378400b0054424a80ebdmr272603edb.4.1700502963990; Mon, 20 Nov
 2023 09:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115210509.481514-1-vschneid@redhat.com> <20231115210509.481514-2-vschneid@redhat.com>
In-Reply-To: <20231115210509.481514-2-vschneid@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Nov 2023 18:55:50 +0100
Message-ID: <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar <tglozar@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 10:05=E2=80=AFPM Valentin Schneider <vschneid@redha=
t.com> wrote:
>
> The TCP timewait timer is proving to be problematic for setups where sche=
duler
> CPU isolation is achieved at runtime via cpusets (as opposed to staticall=
y via
> isolcpus=3Ddomains).
>
> What happens there is a CPU goes through tcp_time_wait(), arming the time=
_wait
> timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer fires, causi=
ng
> interference for the now-isolated CPU. This is conceptually similar to th=
e issue
> described in
>   e02b93124855 ("workqueue: Unbind kworkers before sending them to exit()=
")
>
> Keep softirqs disabled, but make the timer un-pinned and arm it *after* t=
he
> hashdance.
>
> This introduces the following (non-fatal) race:
>
>   CPU0                        CPU1
>     allocates a tw
>     insert it in hash table
>                                 finds the TW and removes it
>                                 (timer cancel does nothing)
>     arms a TW timer, lasting
>
> This partially reverts
>   ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
> and
>   ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashda=
nce")
>
> This also reinstores a comment from
>   ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashda=
nce")
> as inet_twsk_hashdance() had a "Step 1" and "Step 3" comment, but the "St=
ep
> 2" had gone missing.
>
> Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  net/dccp/minisocks.c          | 16 +++++++---------
>  net/ipv4/inet_timewait_sock.c | 20 +++++++++++++++-----
>  net/ipv4/tcp_minisocks.c      | 16 +++++++---------
>  3 files changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
> index 64d805b27adde..2f0fad4255e36 100644
> --- a/net/dccp/minisocks.c
> +++ b/net/dccp/minisocks.c
> @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, int t=
imeo)
>                 if (state =3D=3D DCCP_TIME_WAIT)
>                         timeo =3D DCCP_TIMEWAIT_LEN;
>
> -               /* tw_timer is pinned, so we need to make sure BH are dis=
abled
> -                * in following section, otherwise timer handler could ru=
n before
> -                * we complete the initialization.
> -                */
> -               local_bh_disable();
> -               inet_twsk_schedule(tw, timeo);
> -               /* Linkage updates.
> -                * Note that access to tw after this point is illegal.
> -                */
> +              local_bh_disable();
> +
> +               // Linkage updates
>                 inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> +               inet_twsk_schedule(tw, timeo);

We could arm a timer there, while another thread/cpu found the TW in
the ehash table.



> +               // Access to tw after this point is illegal.
> +               inet_twsk_put(tw);

This would eventually call inet_twsk_free() while the timer is armed.

I think more work is needed.

Perhaps make sure that a live timer owns a reference on tw->tw_refcnt
(This is not the case atm)

