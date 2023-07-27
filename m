Return-Path: <netdev+bounces-22051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8774765C28
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E7B2823B8
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904461AA78;
	Thu, 27 Jul 2023 19:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F617AC1
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:31:39 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0912D6A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:31:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so55601cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690486296; x=1691091096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiMrNW8egjJ/rz9pVUsvEDQn31eh5Gj1t0I59KNhMyg=;
        b=HBTIQxL/BwS48caM6acLiUiYzUitIQ/qI+Svnmg1+fDsEi2T6O/2Iw72v3njryct4A
         qTRz7s0d4+6h2wIMkxuq4Pg8Yi6n+JyG0tPEJU1ydcmvj4Y5fcWArU0BhmKFZQBhlj2x
         KCMJj8gJgJccPVS1ftG0oSj2bB01iiJbSsiU11Mksgy/TCzF26o2/z2RYWPCRVfrIAE4
         v6E1V3mRFTGdJ7+urGsco42GFYFRO3DWqoxUkfc8aTEGdyrZWzy82jK8ekeBTJAmkRqm
         Xvgps+ajD6M/9K/7kHg1F5LJnvL0+1kTH8WWNphAJFiUbtIE4368KJDYAe8OyMDaaerf
         3zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486296; x=1691091096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiMrNW8egjJ/rz9pVUsvEDQn31eh5Gj1t0I59KNhMyg=;
        b=lXiOZUIF7jjexpjfHTDFuXGdlAV2q3+Og1FB5ONhf2SG2F7CpJ+b9yM2X43AadOdnJ
         s4FDhrZY5OTK3HXmHrutwS5hD5wGM8iVOLF3up1urWjHquAgrl0flYPkV9oF2+zYklKx
         d8UkKsd4U6GXyGQROmLz3MwfNHe1ssnBR4fCtiyRtYCxbvPfwogTkIXORUBboAJOVI1P
         HraOxdgJkO44Fz1R5Svfw5ZBhh4ZEUZ5fBAZiVmPxsHGi6d7/vHLldoiMMOtq0lKGHKV
         J6nAsHTP0VEu02stl1luNgnRVKJSC+BOxIRO+S1Ey2gUNv42VV2ca8wfPXV3UaoGfNZm
         Ze8Q==
X-Gm-Message-State: ABy/qLYL6ZsMYKOFev2AknrTZp+M0NJZxTnvTSGK85YSzYUOpAmksdmW
	L3kX8V859iPh9qVqc+b05bpbGsCbOpcRoQae1qvCUErHF5vhCkBVsqM=
X-Google-Smtp-Source: APBJJlEgEoveD20WngLpwZFqt+XIR5MqAui5xP7Jad5pqY3GIN2pAcUY+nv2IM84Ol1+aGxHkCs2pG2IhBHgXNgK62M=
X-Received: by 2002:a05:622a:448:b0:3f2:1441:3c11 with SMTP id
 o8-20020a05622a044800b003f214413c11mr62944qtx.2.1690486296479; Thu, 27 Jul
 2023 12:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com> <20230727125125.1194376-4-imagedong@tencent.com>
In-Reply-To: <20230727125125.1194376-4-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Jul 2023 21:31:24 +0200
Message-ID: <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To: menglong8.dong@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <imagedong@tencent.com>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 2:52=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> In tcp_retransmit_timer(), a window shrunk connection will be regarded
> as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is not
> right all the time.
>
> The retransmits will become zero-window probes in tcp_retransmit_timer()
> if the 'snd_wnd=3D=3D0'. Therefore, the icsk->icsk_rto will come up to
> TCP_RTO_MAX sooner or later.
>
> However, the timer is not precise enough, as it base on timer wheel.
> Sorry that I am not good at timer, but I know the concept of time-wheel.
> The longer of the timer, the rougher it will be. So the timeout is not
> triggered after TCP_RTO_MAX, but 122877ms as I tested.
>
> Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
> once the RTO come up to TCP_RTO_MAX.
>
> Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
> which is exact the timestamp of the timeout.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/ipv4/tcp_timer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 470f581eedd4..3a20db15a186 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -511,7 +511,11 @@ void tcp_retransmit_timer(struct sock *sk)
>                                             tp->snd_una, tp->snd_nxt);
>                 }
>  #endif
> -               if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
> +               /* It's a little rough here, we regard any valid packet t=
hat
> +                * update tp->rcv_tstamp as the reply of the retransmitte=
d
> +                * packet.
> +                */
> +               if ((u32)icsk->icsk_timeout - tp->rcv_tstamp > TCP_RTO_MA=
X) {
>                         tcp_write_err(sk);
>                         goto out;
>                 }


Hmm, this looks like a net candidate, since this is unrelated to the
other patches ?

Neal, what do you think ?

